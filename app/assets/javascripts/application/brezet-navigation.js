window.ecosystem = window.ecosystem || {};

window.ecosystem.brezetNavigation = {
    init: function () {
        'use strict';
        this.dom = document.querySelector('.brezet-wheel-container');
        
        if (!this.dom) {
            return;
        }

        this.navigations = this.dom.querySelectorAll('#brezet-navigation, .brezet-mobile-navigation');
        this.activeSections = this.dom.querySelectorAll('h3[id^="step-"]');

        this.initIntersectionObserver();
        this.disableLinks();
    },

    disableLinks: function () {
        const sectionIds = Array.from(this.activeSections).map(section => section.getAttribute('id'));

        this.navigations.forEach(navigation => {
            navigation.querySelectorAll('a').forEach(link => {
                const href = link.getAttribute('href').substring(1);
    
                if (!sectionIds.includes(href)) {
                    link.parentNode.classList.add('is-disabled');
                }
            });
        });

    },

    initIntersectionObserver: function () {
        this.observedEl = this.dom;

        if (!this.observedEl) {
            return;
        }
        this.observeSections();
    },

    observeSections: function () {
        function handleIntersection(entries, observer) {
            entries.forEach(entry => {
                this.id = entry.target.getAttribute('id');
                this.link = document.querySelector(`#brezet-navigation a[href="#${this.id}"]`);

                if (entry.isIntersecting) {
                    this.link.classList.add('active');
                } else {
                    this.link.classList.remove('active');
                }
            });
        }

        this.observer = new IntersectionObserver(handleIntersection, { threshold: [0, 0.25, 0.75, 1], rootMargin: '0px 0px -50% 0px'  });

        this.activeSections.forEach(section => {
            this.observer.observe(section);
        });
    }
};

window.ecosystem.brezetNavigation.init();