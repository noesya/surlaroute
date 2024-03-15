window.ecosystem = window.ecosystem || {};

window.ecosystem.offcanvasSearch = {
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
        this.buttonsContainer = this.dom.querySelector('.js-offcanvas-cta-container');
        this.button = this.buttonsContainer.querySelector('.offcanvas-search-btn');
        this.offcanvas = this.dom.querySelector('.offcanvas-search');
        this.directoryContent = this.dom.querySelector('.directory-container');
        this.btnText = this.button.querySelector('span');
        this.orderByFacet = this.offcanvas.querySelector('.js-facet-order-by');

        this.hiddenTocClass = 'is-hidden';
        this.expandedContent = 'col-lg-12';
        this.reducedContent = 'col-lg-9';

        this.button.addEventListener('click', this.toggleToc.bind(this));
        this.cloneOrderByFacet();
    },
    toggleToc: function () {
        'use strict';
        if (this.offcanvas.classList.contains(this.hiddenTocClass)) {
            this.showToc();
        } else {
            this.hideToc();
        }
        // Déclenche un resize pour ajuster la carte
        window.dispatchEvent(new Event('resize'));
    },
    showToc: function () {
        'use strict';
        this.offcanvas.classList.remove(this.hiddenTocClass);
        this.directoryContent.classList.remove(this.expandedContent);
        this.directoryContent.classList.add(this.reducedContent);
        this.btnText.innerHTML = 'Fermer les filtres';
    },
    hideToc: function () {
        'use strict';
        this.offcanvas.classList.add(this.hiddenTocClass);
        this.directoryContent.classList.remove(this.reducedContent);
        this.directoryContent.classList.add(this.expandedContent);
        this.btnText.innerHTML = 'Ouvrir les filtres';
    },
    cloneOrderByFacet: function () {
        'use strict';
        var clonedOrderByFacet;
        if (!this.orderByFacet) {
            return;
        }
        clonedOrderByFacet = this.orderByFacet.cloneNode(true);
        this.buttonsContainer.appendChild(clonedOrderByFacet);
    }
};

window.ecosystem.offcanvasSearch.init();
