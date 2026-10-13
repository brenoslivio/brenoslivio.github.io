const defaultProfile = {
    image: "imgs/me_square.jpg",
    alt: "Breno in front of his hobbit-hole",
    caption: "Me in front of my hobbit-hole (try clicking on me)"
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

if (terminalForm && terminalInput && terminalHistory && initialWhoamiOutput) {
    const whoamiMarkup = initialWhoamiOutput.innerHTML;
    const terminal = terminalHistory.closest(".terminal");
    const initialCommandText = terminalHistory.querySelector(".terminal-command .terminal-command-text");
    const motionPreference = window.matchMedia("(prefers-reduced-motion: reduce)");
    const wait = (milliseconds) => new Promise((resolve) => window.setTimeout(resolve, milliseconds));
    const nextFrame = () => new Promise((resolve) => window.requestAnimationFrame(resolve));
    const focusTerminalInput = () => terminalInput.focus({ preventScroll: true });
    let introCancelled = false;

    const revealOutput = () => {
        window.CSS?.highlights?.delete("terminal-unrevealed");
        window.CSS?.highlights?.delete("terminal-typing-caret");
        initialWhoamiOutput.classList.remove("terminal-output-streaming", "terminal-output-streaming-active");
        terminal?.classList.remove("terminal-intro-running");
    };

    const cancelIntro = () => {
        introCancelled = true;
        revealOutput();
    };

    const handleMotionChange = (event) => {
        if (event.matches) cancelIntro();
    };

    const prepareOutputStream = (output) => {
        // Highlight ranges affect only the paint, never the original text or links.
        const unrevealed = new Highlight();
        const groups = Array.from(output.querySelectorAll(":scope > p")).map((paragraph) => {
            const walker = document.createTreeWalker(paragraph, NodeFilter.SHOW_TEXT);
            const textNodes = [];
            let node = walker.nextNode();

            while (node) {
                const text = node.nodeValue;
                if (text.trim()) {
                    const range = document.createRange();
                    range.selectNodeContents(node);
                    unrevealed.add(range);
                    textNodes.push({ node, text, range });
                }
                node = walker.nextNode();
            }

            return { paragraph, textNodes };
        });

        const characterCount = groups.reduce(
            (total, group) => total + group.textNodes.reduce((subtotal, item) => subtotal + item.text.length, 0),
            0
        );

        CSS.highlights.set("terminal-unrevealed", unrevealed);
        return { groups, characterCount, unrevealed };
    };

    const streamOutput = async (output, outputStream) => {
        const { groups, characterCount, unrevealed } = outputStream;
        const charactersPerFrame = Math.max(1, Math.ceil(characterCount / 230));
        const caret = document.createRange();

        await wait(180);
        if (introCancelled) return;
        output.classList.add("terminal-output-streaming-active");
        CSS.highlights.set("terminal-typing-caret", new Highlight(caret));

        for (const { textNodes } of groups) {
            for (const { node, text, range } of textNodes) {
                let position = 0;

                while (position < text.length) {
                    if (introCancelled) return;
                    const variableBatch = Math.max(
                        1,
                        Math.round(charactersPerFrame * (0.75 + Math.random() * 0.5))
                    );
                    position = Math.min(position + variableBatch, text.length);
                    range.setStart(node, position);
                    caret.setStart(node, position);
                    caret.setEnd(node, Math.min(position + 1, text.length));
                    await nextFrame();
                }
                unrevealed.delete(range);
            }
        }

        CSS.highlights.delete("terminal-typing-caret");
        await wait(180);
    };

    const playTerminalIntro = async () => {
        const supportsTextReveal = window.CSS?.highlights && typeof window.Highlight === "function"
            && CSS.supports("selector(::highlight(terminal-unrevealed))");
        if (!terminal || !initialCommandText || motionPreference.matches || !supportsTextReveal) {
            focusTerminalInput();
            return;
        }

        const command = "whoami";

        try {
            terminal.classList.add("terminal-intro-running");
            terminalHistory.setAttribute("aria-live", "off");
            initialWhoamiOutput.classList.add("terminal-output-streaming");
            const outputStream = prepareOutputStream(initialWhoamiOutput);
            // Keyboard users can read and activate every biography link immediately.
            initialWhoamiOutput.addEventListener("focusin", cancelIntro);
            motionPreference.addEventListener("change", handleMotionChange);
            initialCommandText.classList.add("terminal-command-typing");
            initialCommandText.textContent = "";

            await wait(350);

            for (const character of command) {
                if (introCancelled) return;
                initialCommandText.textContent += character;
                await wait(350 + Math.random() * 150);
            }

            await wait(280);
            initialCommandText.classList.remove("terminal-command-typing");
            await streamOutput(initialWhoamiOutput, outputStream);
        } catch (error) {
            console.error("Terminal intro failed:", error);
        } finally {
            revealOutput();
            initialWhoamiOutput.removeEventListener("focusin", cancelIntro);
            motionPreference.removeEventListener("change", handleMotionChange);
            initialCommandText.textContent = command;
            initialCommandText.classList.remove("terminal-command-typing");
            terminalHistory.setAttribute("aria-live", "polite");
            if (!introCancelled && (document.activeElement === document.body || terminal.contains(document.activeElement))) {
                focusTerminalInput();
            }
        }
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
    };

    const appendWhoami = () => {
        const output = document.createElement("div");
        output.className = "terminal-output";
        output.innerHTML = whoamiMarkup;
        terminalHistory.insertBefore(output, terminalForm);
        initializeProfileToggles(output);
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
                appendMessage("Available commands:\n  whoami   show my biography\n  funfact  show a personal fun fact\n  neofetch inspect the system\n  help     list available commands\n  clear    clear the terminal");
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
