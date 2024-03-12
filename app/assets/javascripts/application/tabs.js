window.ecosystem = window.ecosystem || {};

window.ecosystem.tabs = {
    init: function () {
        'use strict';
        this.buttons = document.querySelectorAll('[data-toggle="tab"]');

        if (!this.buttons) {
            return;
        }
        
        this.buttons.forEach(button => {
            button.addEventListener('click', () => {
                this.toggleTab(button);
            });
        });
    },
    toggleTab: function (button) {
        'use strict';

        this.activeTabs = document.querySelectorAll('.tab-pane.show');
        this.activeBtn = document.querySelector('.nav-link.active');
        this.activeBtn.classList.remove('active');
        button.classList.add('active');
        
        const tabContentClass = button.getAttribute("data-target");
        const tabContentElements = document.getElementsByClassName(tabContentClass);

        this.activeTabs.forEach(activeTab => {
            activeTab.classList.remove('show');
            activeTab.classList.remove('active');
        });

        const tabContentArray = Array.from(tabContentElements);
        tabContentArray.forEach(element => {
            element.classList.add('active');
            element.classList.add('show');
        });
    }
};

window.ecosystem.tabs.init();
