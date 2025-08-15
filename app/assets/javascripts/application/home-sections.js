window.ecotheque = window.ecotheque || {};

window.ecotheque.homeAnimation = {
    init: function () {
        'use strict';
        this.sections = document.querySelectorAll('.home-navigation');

        if (!this.sections) {
            return;
        }

        this.listen();
    },

    listen: function () {
        'use strict';
        var hoveredClass = 'is-hovered';

        this.sections.forEach(section => {
            this.link = section.querySelector('.home-navigation__link');
            if (this.link) {
                this.link.addEventListener('mouseover', function () {
                    section.classList.toggle(hoveredClass);
                });

                this.link.addEventListener('mouseout', function () {
                    section.classList.toggle(hoveredClass);
                });
            }
        });
    }
};

window.ecotheque.homeAnimation.init();
