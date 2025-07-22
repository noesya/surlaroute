document.addEventListener("DOMContentLoaded", () => {
  const stickerContainers = document.querySelectorAll(".js-sticker");
  const stickers = Array.from(stickerContainers).map(c => c.querySelector(".stickers"));

  let lastScrollY = window.scrollY;
  let currentRotation = 0;

  window.addEventListener("scroll", () => {
    const newScrollY = window.scrollY;
    const direction = newScrollY > lastScrollY ? "down" : "up";
    lastScrollY = newScrollY;

    const rotationStep = 5;
    currentRotation += direction === "down" ? rotationStep : -rotationStep;

    stickers.forEach(el => {
      el.style.transform = `rotate(${currentRotation}deg)`;
      if (el) el.style.transform = `rotate(${currentRotation}deg)`;
    });
  });
});
