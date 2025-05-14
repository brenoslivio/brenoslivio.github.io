document.getElementById("profileImage").addEventListener("click", function() {
    const img = this;
    const caption = document.getElementById("profileCaption");
    const defaultImage = "imgs/me_square.png";
    const alternateImage = "imgs/Tiao_square.jpg"; // Replace with your dog image
    const defaultText = "That's me! (try clicking on it)";
    const alternateText = "And that's my dog Tião :)";

    // Fade out the image
    img.style.opacity = 0;

    // After fade-out completes, swap image/text and fade back in
    setTimeout(() => {
        img.src = img.src.includes(defaultImage) ? alternateImage : defaultImage;
        caption.textContent = img.src.includes(alternateImage) ? alternateText : defaultText;
        img.style.opacity = 1; // Fade in
    }, 500); // Match this delay to your CSS transition time (0.5s)
});