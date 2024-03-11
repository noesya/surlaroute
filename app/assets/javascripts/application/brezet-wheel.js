window.ecosystem = window.ecosystem || {};

window.ecosystem.brezetWheel = {
    init: function () {
        'use strict';
        this.observedEl = document.querySelector('.brezet-wheel-container');
        
        if (!this.observedEl) {
            return;
        }
        
        this.image = this.observedEl.querySelector('figure');
        this.texts = this.observedEl.querySelectorAll('.brezet-steps span');
        this.breakpoint = 992;

        if(window.innerWidth >= this.breakpoint) {
            let options = {
                root: null,
                rootMargin: "0px",
                threshold: 0.5
            };

            let observer = new IntersectionObserver((entries, observer) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        console.log('animation');
                        this.scrollAnimation();
                        observer.unobserve(entry.target);
                    }
                });
            }, options);

            observer.observe(this.image);
            
        }
    },
    scrollAnimation: function () {
        this.scrollListener = () => {
            this.scrollPosition = window.scrollY;
            this.triggerPosition = this.observedEl.getBoundingClientRect().top + window.scrollY + 100;
            this.maxImageWidth = 0;

            window.addEventListener("scroll", () => {
                if (this.scrollPosition > this.triggerPosition) {
                    this.percentage = Math.min(1, (this.scrollPosition - this.triggerPosition) / (window.innerHeight));
                    this.imageWidth = this.maxImageWidth + (1 - this.percentage) * (100 - this.maxImageWidth);
                    this.opacityTransition = (this.maxImageWidth + (1 - this.percentage) * (100 - this.maxImageWidth)) * 0.15;
    
                    this.image.style.width = this.imageWidth + "%";
                    
                    this.texts.forEach((text) => {
                        text.style.opacity = this.opacityTransition + "%";
                    });
                } else {
                    this.image.style.width = "100%";
                    
                    this.texts.forEach((text) => {
                        text.style.opacity = "1";
                    });
                }
            });
        };

        window.addEventListener("scroll", this.scrollListener);
    },
    removeScrollListener: function () {
        if (this.scrollListener) {
            window.removeEventListener("scroll", this.scrollListener);
            this.scrollListener = null;
        }
    }
};

window.ecosystem.brezetWheel.init();
