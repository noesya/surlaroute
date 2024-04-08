window.ecotheque = window.ecotheque || {};

window.ecotheque.menu = {
    previousScrollY: 0,
    init: function () {
        'use strict';
        this.dom = document.querySelector('#document-header');
        window.addEventListener('scroll', this.onScroll.bind(this));
        window.addEventListener('touchmove', this.onScroll.bind(this));
    },
    onScroll: function () {
        'use strict';
        var offset = this.dom.offsetHeight - 30,
            y = window.scrollY,
            isNearTop = y < offset,
            threshold = 50,
            hasChanged = false;

        if (isNearTop) {
            this.dom.classList.add('is-top');
        } else {
            this.dom.classList.remove('is-top');
        }

        if (y > this.previousScrollY + threshold && !isNearTop) {
            document.documentElement.classList.add('is-scrolling-down');
            hasChanged = true;
        } else if (y < this.previousScrollY - threshold) {
            document.documentElement.classList.remove('is-scrolling-down');
            hasChanged = true;
        }

        if (hasChanged) {
            this.previousScrollY = y;
        }
    }
};

window.ecotheque.menu.init();
