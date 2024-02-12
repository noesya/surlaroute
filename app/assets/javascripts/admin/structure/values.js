/*global $  */
window.ecotheque.structure.values = {
    init: function () {
        'use strict';
        this.container = document.querySelector('.js-structure-values-form');
        if (this.container === null) {
            return;
        }
        this.initCocoonEvents();
    },

    initCocoonEvents: function () {
        'use strict';
        var nestedCocoonElements = this.container.querySelectorAll('.js-nested-cocoon'),
            i;

        for (i = 0; i < nestedCocoonElements.length; i += 1) {
            $(nestedCocoonElements[i]).on('cocoon:after-insert', this.initSingleDeletableFile.bind(this));
        }
    },

    initSingleDeletableFile: function (e, newElement) {
        'use strict';
        $('.js-sdfi-deletable-file', newElement).each(function () {
            window.inputSingleDeletableFile.bindEvents(this);
        });
    },

    invoke: function () {
        'use strict';
        return {
            init: this.init.bind(this)
        };
    }
}.invoke();

window.addEventListener('DOMContentLoaded', function () {
    'use strict';
    window.ecotheque.structure.values.init();
});
