window.ecosystem = window.ecosystem || {};

window.ecosystem.menu = {
    init: function () {
        'use strict';
        this.dom = document.querySelector('#document-header');
        this.links = this.dom.querySelectorAll('.nav-item.dropdown a');
        this.breakpoint = 768;

        if(window.innerWidth <= this.breakpoint) {
            this.disableExpandedMenu();
        }
    },
    disableExpandedMenu: function () {
        'use strict';
        this.links.forEach((link) => {
            link.removeAttribute("data-bs-toggle");
            link.removeAttribute("aria-expanded");
        });
    }
};

window.ecosystem.menu.init();
