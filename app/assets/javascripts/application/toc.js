window.ecosystem = window.ecosystem || {};

window.ecosystem.toc = {
    init: function () {
        'use strict';
        this.dom = document.querySelector('.directory');
        this.breakpoint = 768;

        if (!this.dom) {
            return;
        }
        // if(window.innerWidth <= this.breakpoint || !this.dom) {
        //     return;
        // }

        // TODO : nettoyer "toc"
        this.button = this.dom.querySelector('.toc-btn');
        this.toc = this.dom.querySelector('.toc');
        this.directoryContent = this.dom.querySelector('.directory-container');
        this.btnText = this.button.querySelector('span');

        this.hiddenTocClass = 'is-hidden';
        this.expandedContent = 'col-lg-12';
        this.reducedContent = 'col-lg-9';

        this.button.addEventListener('click', this.toggleToc.bind(this));
    },
    toggleToc: function () {
        'use strict';
        if (this.toc.classList.contains(this.hiddenTocClass)) {
            this.showToc();
        } else {
            this.hideToc();
        }
    },
    showToc: function () {
        'use strict';
        this.toc.classList.remove(this.hiddenTocClass);
        this.directoryContent.classList.remove(this.expandedContent);
        this.directoryContent.classList.add(this.reducedContent);
        this.btnText.innerHTML = 'Fermer les filtres';
    },
    hideToc: function () {
        'use strict';
        this.toc.classList.add(this.hiddenTocClass);
        this.directoryContent.classList.remove(this.reducedContent);
        this.directoryContent.classList.add(this.expandedContent);
        this.btnText.innerHTML = 'Ouvrir les filtres';
    }
};

window.ecosystem.toc.init();
