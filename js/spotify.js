(() => {
    const widget = document.querySelector("[data-spotify-widget]");
    if (!widget) return;

    const trigger = widget.querySelector(".spotify-trigger");
    const summary = widget.querySelector(".spotify-summary");
    const panel = widget.querySelector(".spotify-panel");
    const spotifyStatus = widget.querySelector(".spotify-card-content");
    const spotifyStatusUrl = "https://api.github.com/repos/brenoslivio/brenoslivio.github.io/contents/spotify.json?ref=spotify-data";
    const spotifyCacheKey = "brenoslivio-last-spotify-track";
    let pinned = false;
    let hovering = false;
    let closeTimer;
    let lastStatus = "";

    const setOpen = (open) => {
        window.clearTimeout(closeTimer);
        panel.hidden = !open;
        trigger.setAttribute("aria-expanded", String(open));
    };

    const close = () => {
        pinned = false;
        if (panel.contains(document.activeElement)) trigger.focus({ preventScroll: true });
        setOpen(false);
    };

    widget.addEventListener("pointerenter", (event) => {
        if (event.pointerType !== "mouse") return;
        hovering = true;
        setOpen(true);
    });
    widget.addEventListener("pointerleave", (event) => {
        if (event.pointerType !== "mouse") return;
        hovering = false;
        closeTimer = window.setTimeout(() => {
            if (!pinned && !widget.contains(document.activeElement)) setOpen(false);
        }, 180);
    });
    trigger.addEventListener("click", () => {
        pinned = !pinned;
        setOpen(pinned);
    });
    widget.addEventListener("focusout", () => {
        window.setTimeout(() => {
            if (!widget.contains(document.activeElement) && !hovering) close();
        }, 0);
    });
    document.addEventListener("pointerdown", (event) => {
        if (!widget.contains(event.target)) close();
    });
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape" && !panel.hidden) {
            event.preventDefault();
            close();
        }
    });

    const renderStatus = (status) => {
        const signature = JSON.stringify(status);
        if (signature === lastStatus) return;
        lastStatus = signature;
        const hasTrack = Boolean(status.track && status.artist);
        const label = status.isPlaying ? "Listening" : "Last played";
        summary.textContent = hasTrack
            ? `${label} · ${status.track}`
            : status.unavailable ? "Spotify unavailable" : "Nothing playing";
        trigger.setAttribute("aria-label", hasTrack
            ? `${label}: ${status.track} by ${status.artist}. Show Spotify details`
            : `${summary.textContent}. Show Spotify details`);
        widget.classList.toggle("spotify-is-playing", Boolean(status.isPlaying && hasTrack));
        const restoreFocus = spotifyStatus.contains(document.activeElement);
        spotifyStatus.replaceChildren(buildSpotifyCard(status));
        if (restoreFocus) {
            const target = spotifyStatus.querySelector("a") || trigger;
            target.focus({ preventScroll: true });
        }
    };

    const buildSpotifyCard = (status) => {
        const hasTrack = Boolean(status.track && status.artist);

        if (!status.isPlaying && !hasTrack) {
            const idle = document.createElement("div");
            idle.className = "spotify-now-playing spotify-now-playing-idle";

            const icon = document.createElement("i");
            icon.className = "fab fa-spotify";
            icon.setAttribute("aria-hidden", "true");

            const message = document.createElement("span");
            message.textContent = status.unavailable ? "Spotify status unavailable" : "Nothing playing right now";
            idle.append(icon, message);
            return idle;
        }

        const card = document.createElement(status.spotifyUrl ? "a" : "div");
        card.className = `spotify-now-playing ${status.isPlaying ? "spotify-now-playing-active" : "spotify-now-playing-previous"}`;

        if (status.spotifyUrl) {
            card.href = status.spotifyUrl;
            card.target = "_blank";
            card.rel = "noopener noreferrer";
            const playbackLabel = status.isPlaying ? "Currently playing" : "Last played";
            card.setAttribute("aria-label", `${playbackLabel}: ${status.track} by ${status.artist} on Spotify`);
        }

        if (status.albumArt) {
            const artwork = document.createElement("img");
            artwork.className = "spotify-now-playing-art";
            artwork.src = status.albumArt;
            artwork.alt = status.album ? `Album artwork for ${status.album}` : "Spotify album artwork";
            artwork.width = 300;
            artwork.height = 300;
            artwork.loading = "lazy";
            artwork.decoding = "async";
            card.append(artwork);
        }

        const details = document.createElement("span");
        details.className = "spotify-now-playing-details";

        const label = document.createElement("span");
        label.className = "spotify-now-playing-label";
        const icon = document.createElement("i");
        icon.className = "fab fa-spotify";
        icon.setAttribute("aria-hidden", "true");
        const labelText = document.createElement("span");
        labelText.textContent = status.isPlaying ? "LISTENING NOW" : "LAST PLAYED";
        label.append(icon, labelText);

        const track = document.createElement("strong");
        track.className = "spotify-now-playing-track";
        track.textContent = status.track || "Unknown track";

        const artist = document.createElement("span");
        artist.className = "spotify-now-playing-artist";
        artist.textContent = status.artist || "Unknown artist";

        details.append(label, track, artist);
        card.append(details);
        return card;
    };

    const rememberSpotifyTrack = (status) => {
        if (!status.track) {
            return;
        }

        try {
            window.localStorage.setItem(spotifyCacheKey, JSON.stringify(status));
        } catch (error) {
            console.debug("Could not cache the Spotify track", error);
        }
    };

    const getRememberedSpotifyTrack = () => {
        try {
            const status = JSON.parse(window.localStorage.getItem(spotifyCacheKey));
            return status?.track ? { ...status, isPlaying: false, isFallback: true } : null;
        } catch (error) {
            console.debug("Could not read the cached Spotify track", error);
            return null;
        }
    };

    const loadSpotifyStatus = async () => {
        const requestController = new AbortController();
        const requestTimeout = window.setTimeout(() => requestController.abort(), 8000);

        try {
            const response = await fetch(`${spotifyStatusUrl}&v=${Date.now()}`, {
                cache: "no-store",
                headers: { Accept: "application/vnd.github.raw+json" },
                signal: requestController.signal
            });
            if (!response.ok) {
                throw new Error(`Spotify status request failed with ${response.status}`);
            }

            let status = await response.json();
            const updatedAt = Date.parse(status.updatedAt);
            const isFresh = Number.isFinite(updatedAt) && Date.now() - updatedAt < 15 * 60 * 1000;
            if (!isFresh) {
                status = { ...status, isPlaying: false, isFallback: Boolean(status.track) };
            }

            rememberSpotifyTrack(status);
            renderStatus(status);
        } catch (error) {
            console.error(error);
            const rememberedTrack = getRememberedSpotifyTrack();
            renderStatus(rememberedTrack || { isPlaying: false, unavailable: true });
        } finally {
            window.clearTimeout(requestTimeout);
        }
    };


    widget.hidden = false;
    const rememberedTrack = getRememberedSpotifyTrack();
    if (rememberedTrack) renderStatus(rememberedTrack);
    loadSpotifyStatus();
    window.setInterval(loadSpotifyStatus, 2 * 60 * 1000);
})();
