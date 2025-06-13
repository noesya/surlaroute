document.addEventListener("DOMContentLoaded", () => {
  const stickers = document.querySelectorAll(".logo-round-1 .stickers, .logo-round-2 .stickers");

  let lastScrollY = window.scrollY;
  let currentRotation = 0;

  window.addEventListener("scroll", () => {
    const newScrollY = window.scrollY;
    const direction = newScrollY > lastScrollY ? "down" : "up";
    lastScrollY = newScrollY;

    const rotationStep = 5; // en degrés

    // Mettre à jour la rotation cumulée
    currentRotation += direction === "down" ? rotationStep : -rotationStep;

    // Appliquer la rotation à tous les éléments
    stickers.forEach(el => {
      el.style.transform = `rotate(${currentRotation}deg)`;
    });
  });
});
