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
            // on récupère la hauteur de container Top dans la page par rapport au scroll : 
            // quand brezetContainer n'est pas visible : valeur positive
            // quand c'est visible : 0 ou valeur positive
            var containerTop = this.brezetContainer.getBoundingClientRect().top;

            // on récupère la distance entre le haut brezet-details et le haut de son parent (brezet-wheel-container)
            // on divise par 2 pour ajuster la valeur désirée
            var distance = this.content.offsetTop / 2;

            // on détermine un ratio compris entre 0 et 1 -> il va de 1 à 0 donc il faut l'inverser avce 1 - ...
            // même si notre ratio est écouté pdt tout le scroll, il ne prendra ses bonnes valeurs qu'une fois entre 1 et 0
            // on divise containerTop par distance pour avoir le temps de scroll désiré pour l'animation
            // on ajoute un - car on est à l'inverse
            var ratio =1 - Math.max(0, Math.min(1,  -containerTop / distance));

            // pour que notre élément reste centré, on lui ajoute la valeur des gouttières bootstrap
            // on multiplie le tout par le ratio pour obtenir une valeur décroissante entre 50% et 0%
            this.figure.style.transform = `translateX(calc( (50% + var(--bs-gutter-x)) * ${ratio}))`;

            // pour chaque texte, on utilise le ratio pour faire diminuer l'opacité des textes
            // pas besoin de plus de valeur car on va de 1 à 0
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
    }
};

window.ecosystem.brezetWheel.init();
