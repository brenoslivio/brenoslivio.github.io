document.getElementById("profileImage").addEventListener("click", function() {
    const img = this;
    const caption = document.getElementById("profileCaption");
    const defaultImage = "imgs/me_square.png";
    const alternateImage = "imgs/Tiao_square.jpg";
    const defaultText = "That's me! (try clicking on me)";
    const alternateText = "And that's my dog Tião :)";

    img.style.opacity = 0;

    setTimeout(() => {
        img.src = img.src.includes(defaultImage) ? alternateImage : defaultImage;
        caption.textContent = img.src.includes(alternateImage) ? alternateText : defaultText;
        img.style.opacity = 1; // Fade in
    }, 500);
});