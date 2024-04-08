window.ecotheque = window.ecotheque || {};

window.ecotheque.menu = {
    previousScrollY: 0,
    isOpened: false,
    init: function () {
        'use strict';
        this.dom = document.querySelector('#document-header');
        this.navbar = this.dom.querySelector('.navbar-collapse');

        this.navbar.addEventListener('show.bs.collapse', function () {
            this.dom.classList.add('is-opened');
        }.bind(this));

        this.navbar.addEventListener('hide.bs.collapse', function () {
            this.dom.classList.remove('is-opened');
        }.bind(this));

        window.addEventListener('scroll', this.onScroll.bind(this));
        window.addEventListener('touchmove', this.onScroll.bind(this));

        this.onScroll();
    },
    onClickButton: function () {
        'use strict';
        this.isOpened = this.navbar.classList.contains('show');
        if (this.isOpened) {
            this.dom.classList.add('is-opened');
        } else {
            this.dom.classList.remove('is-opened');
        }
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
