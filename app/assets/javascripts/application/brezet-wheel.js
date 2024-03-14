window.ecosystem = window.ecosystem || {};

window.ecosystem.brezetWheel = {
    init: function () {
        'use strict';
        // brezet-wheel-container comprend à la fois la figure avec l'image et les points
        // et le texte qui s'affiche en-dessous
        this.brezetContainer = document.querySelector('.brezet-wheel-container');
        
        if (!this.brezetContainer) {
            return;
        }
        
        // la figure contient l'image + les points
        this.figure = this.brezetContainer.querySelector('figure');
        // les intilutés qui ne doivent pas s'afficher au scroll
        this.texts = this.brezetContainer.querySelectorAll('.brezet-steps span');
        // le texte qui remonte à côté du sticky
        this.content = this.brezetContainer.querySelector('.brezet-details');
        this.breakpoint = 992;

        if(window.innerWidth >= this.breakpoint) {
            this.scrollAnimation();
        }
    },
    scrollAnimation: function () {
        this.scrollListener = () => {
            var containerTop = this.brezetContainer.getBoundingClientRect().top;
            var distance = this.content.offsetTop / 2;
            var ratio =1 - Math.max(0, Math.min(1,  -containerTop / distance));
            this.figure.style.transform = `translateX(calc( (50% + var(--bs-gutter-x)) * ${ratio}))`;
            this.texts.forEach((text) => {
                text.style.opacity = ratio;
            });
        };

        // on écoute le scroll
        window.addEventListener("scroll", this.scrollListener);

        // pour éviter le saut de la figure au rechargement :
        // 1) de base figure est en opacity 0
        // 2) on vient exécuter le javascript au chargement de la page
        // 3) on passe la figure en opacity 1
        this.scrollListener();
        this.figure.style.opacity = 1;
    },
    removeScrollListener: function () {
        if (this.scrollListener) {
            window.removeEventListener("scroll", this.scrollListener);
            this.scrollListener = null;
        }
    }
};

window.ecosystem.brezetWheel.init();
