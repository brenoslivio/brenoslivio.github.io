const defaultProfile = {
    image: "imgs/me_square.jpg",
    alt: "Breno in front of his hobbit-hole",
    caption: "In front of my hobbit-hole (try clicking on me)"
};

const alternateProfile = {
    image: "imgs/Tiao_square.jpg",
    alt: "Breno's dog, Tião",
    caption: "And that's my dog Tião :)"
};

function initializeProfileToggles(root = document) {
    root.querySelectorAll("[data-profile-toggle]").forEach((image) => {
        if (image.dataset.profileReady === "true") {
            return;
        }

        image.dataset.profileReady = "true";
        const caption = image.closest("figure")?.querySelector(".profile-caption");

        const toggleProfile = () => {
            if (image.dataset.switching === "true") {
                return;
            }

            image.dataset.switching = "true";
            const showingDefault = image.getAttribute("src")?.includes(defaultProfile.image);
            const nextProfile = showingDefault ? alternateProfile : defaultProfile;
            const transitionTime = window.matchMedia("(prefers-reduced-motion: reduce)").matches ? 0 : 500;

            image.style.opacity = 0;

            window.setTimeout(() => {
                image.src = nextProfile.image;
                image.alt = nextProfile.alt;
                if (caption) {
                    caption.textContent = nextProfile.caption;
                }
                image.style.opacity = 1;
                image.dataset.switching = "false";
            }, transitionTime);
        };

        image.addEventListener("click", toggleProfile);
        image.addEventListener("keydown", (event) => {
            if (event.key === "Enter" || event.key === " ") {
                event.preventDefault();
                toggleProfile();
            }
        });
    });
}

const terminalForm = document.getElementById("terminalForm");
const terminalInput = document.getElementById("terminalInput");
const terminalHistory = document.getElementById("terminalHistory");
const initialWhoamiOutput = document.getElementById("whoamiOutput");
const spotifyStatusUrl = "https://raw.githubusercontent.com/brenoslivio/brenoslivio.github.io/spotify-data/spotify.json";

if (terminalForm && terminalInput && terminalHistory && initialWhoamiOutput) {
    const whoamiMarkup = initialWhoamiOutput.innerHTML;
    const terminal = terminalHistory.closest(".terminal");
    const initialCommandText = terminalHistory.querySelector(".terminal-command .terminal-command-text");
    const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    const wait = (milliseconds) => new Promise((resolve) => window.setTimeout(resolve, milliseconds));
    const nextFrame = () => new Promise((resolve) => window.requestAnimationFrame(resolve));
    const focusTerminalInput = () => terminalInput.focus({ preventScroll: true });

    const prepareOutputStream = (output) => {
        const groups = Array.from(output.querySelectorAll(":scope > p")).map((paragraph) => {
            const walker = document.createTreeWalker(paragraph, NodeFilter.SHOW_TEXT);
            const textNodes = [];
            let node = walker.nextNode();

            while (node) {
                const text = node.nodeValue.replace(/\s+/g, " ");
                if (text) {
                    textNodes.push({ node, text });
                    node.nodeValue = "";
                }
                node = walker.nextNode();
            }

            return { paragraph, textNodes };
        });

        const characterCount = groups.reduce(
            (total, group) => total + group.textNodes.reduce((subtotal, item) => subtotal + item.text.length, 0),
            0
        );

        return { groups, characterCount };
    };

    const streamOutput = async (output, outputStream) => {
        const { groups, characterCount } = outputStream;
        const charactersPerFrame = Math.max(1, Math.ceil(characterCount / 230));

        await wait(180);
        output.classList.remove("terminal-output-waiting");
        output.classList.add("terminal-output-streaming-active");

        for (const { paragraph, textNodes } of groups) {
            paragraph.classList.add("terminal-text-typing");

            for (const { node, text } of textNodes) {
                let position = 0;

                while (position < text.length) {
                    const variableBatch = Math.max(
                        1,
                        Math.round(charactersPerFrame * (0.75 + Math.random() * 0.5))
                    );
                    position = Math.min(position + variableBatch, text.length);
                    node.nodeValue = text.slice(0, position);
                    await nextFrame();
                }
            }

            paragraph.classList.remove("terminal-text-typing");
        }

        await wait(180);
        output.classList.remove("terminal-output-streaming", "terminal-output-streaming-active", "terminal-output-waiting");
    };

    const playTerminalIntro = async () => {
        if (!terminal || !initialCommandText || reduceMotion) {
            focusTerminalInput();
            return;
        }

        const command = "whoami";

        terminal.classList.add("terminal-intro-running");
        terminalHistory.setAttribute("aria-live", "off");
        initialWhoamiOutput.classList.add("terminal-output-streaming", "terminal-output-waiting");
        const outputStream = prepareOutputStream(initialWhoamiOutput);
        initialCommandText.classList.add("terminal-command-typing");
        initialCommandText.textContent = "";

        await wait(350);

        for (const character of command) {
            initialCommandText.textContent += character;
            await wait(350 + Math.random() * 150);
        }

        await wait(280);
        initialCommandText.classList.remove("terminal-command-typing");
        await streamOutput(initialWhoamiOutput, outputStream);
        terminal.classList.remove("terminal-intro-running");
        terminalHistory.setAttribute("aria-live", "polite");
        focusTerminalInput();
    };

    const appendCommand = (command) => {
        const line = document.createElement("div");
        line.className = "terminal-command";

        const prompt = document.createElement("span");
        prompt.className = "terminal-prompt";
        prompt.setAttribute("aria-hidden", "true");
        prompt.innerHTML = '<span class="terminal-user">brenoslivio@ahimsa</span>:<span class="terminal-path">~</span>$';

        const commandText = document.createElement("span");
        commandText.className = "terminal-command-text";
        commandText.textContent = command;

        line.append(prompt, commandText);
        terminalHistory.insertBefore(line, terminalForm);
    };

    const appendMessage = (message, isError = false) => {
        const output = document.createElement("p");
        output.className = `terminal-message${isError ? " terminal-error" : ""}`;
        output.textContent = message;
        terminalHistory.insertBefore(output, terminalForm);
        return output;
    };

    const appendWhoami = () => {
        const output = document.createElement("div");
        output.className = "terminal-output";
        output.innerHTML = whoamiMarkup;
        terminalHistory.insertBefore(output, terminalForm);
        initializeProfileToggles(output);
    };

    const buildSpotifyCard = (status) => {
        if (!status.isPlaying) {
            const idle = document.createElement("div");
            idle.className = "terminal-spotify terminal-spotify-idle";

            const icon = document.createElement("i");
            icon.className = "fab fa-spotify";
            icon.setAttribute("aria-hidden", "true");

            const message = document.createElement("span");
            message.textContent = "Not listening to anything on Spotify right now.";
            idle.append(icon, message);
            return idle;
        }

        const card = document.createElement(status.spotifyUrl ? "a" : "div");
        card.className = "terminal-spotify terminal-spotify-playing";

        if (status.spotifyUrl) {
            card.href = status.spotifyUrl;
            card.target = "_blank";
            card.rel = "noopener noreferrer";
            card.setAttribute("aria-label", `${status.track} by ${status.artist} on Spotify`);
        }

        if (status.albumArt) {
            const artwork = document.createElement("img");
            artwork.className = "terminal-spotify-art";
            artwork.src = status.albumArt;
            artwork.alt = status.album ? `Album artwork for ${status.album}` : "Spotify album artwork";
            artwork.width = 300;
            artwork.height = 300;
            artwork.loading = "lazy";
            artwork.decoding = "async";
            card.append(artwork);
        }

        const details = document.createElement("span");
        details.className = "terminal-spotify-details";

        const label = document.createElement("span");
        label.className = "terminal-spotify-label";
        const icon = document.createElement("i");
        icon.className = "fab fa-spotify";
        icon.setAttribute("aria-hidden", "true");
        const labelText = document.createElement("span");
        labelText.textContent = "NOW PLAYING ON SPOTIFY";
        label.append(icon, labelText);

        const track = document.createElement("strong");
        track.className = "terminal-spotify-track";
        track.textContent = status.track || "Unknown track";

        const artist = document.createElement("span");
        artist.className = "terminal-spotify-artist";
        artist.textContent = status.artist || "Unknown artist";

        details.append(label, track, artist);
        card.append(details);
        return card;
    };

    const appendSpotify = async () => {
        const loading = appendMessage("querying Spotify...");

        try {
            const cacheWindow = Math.floor(Date.now() / 300000);
            const response = await fetch(`${spotifyStatusUrl}?v=${cacheWindow}`, { cache: "no-store" });
            if (!response.ok) {
                throw new Error(`Spotify status request failed with ${response.status}`);
            }

            const status = await response.json();
            const updatedAt = Date.parse(status.updatedAt);
            const isFresh = Number.isFinite(updatedAt) && Date.now() - updatedAt < 15 * 60 * 1000;
            if (!isFresh) {
                throw new Error("Spotify status is stale");
            }

            loading.replaceWith(buildSpotifyCard(status));
        } catch (error) {
            console.error(error);
            loading.classList.add("terminal-error");
            loading.textContent = "Spotify status is temporarily unavailable. Try again in a few minutes.";
        }
    };

    terminalForm.addEventListener("submit", (event) => {
        event.preventDefault();

        const command = terminalInput.value.trim();
        if (!command) {
            return;
        }

        terminalInput.value = "";
        appendCommand(command);

        switch (command.toLowerCase()) {
            case "whoami":
                appendWhoami();
                break;
            case "help":
                appendMessage("Available commands:\n  whoami   show my biography\n  spotify  show what I am listening to\n  funfact  show a personal fun fact\n  neofetch inspect the system\n  help     list available commands\n  clear    clear the terminal");
                break;
            case "spotify":
                appendSpotify();
                break;
            case "funfact":
                appendMessage("Linux user since 2010, vegan since 2018, autistic since forever.");
                break;
            case "neofetch":
                appendMessage("Dude, you are on a website.");
                break;
            case "clear":
                Array.from(terminalHistory.children).forEach((child) => {
                    if (child !== terminalForm) {
                        child.remove();
                    }
                });
                break;
            default:
                appendMessage(`command not found: ${command}. Type 'help' to see the available commands.`, true);
        }

        terminalInput.focus();
    });

    playTerminalIntro();
}

initializeProfileToggles();
