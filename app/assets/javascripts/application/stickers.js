document.addEventListener('DOMContentLoaded', () => {
    'use strict';
    var stickers = document.querySelectorAll('.js-sticker'),
        lastScrollY = window.scrollY,
        currentRotation = 0;

    window.addEventListener('scroll', function () {
        var newScrollY = window.scrollY,
            direction = newScrollY > lastScrollY ? 'down' : 'up',
            transformValue,
            i;

        lastScrollY = newScrollY;
        if (direction === 'up') {
            currentRotation -= 5;
        } else {
            currentRotation += 5;
        }

        transformValue = 'rotate(' + currentRotation + 'deg)';

        for (i = 0; i < stickers.length; i += 1) {
            stickers[i].style.transform = transformValue;
        }
    });
});
