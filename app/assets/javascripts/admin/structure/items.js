/*global $  */

window.ecotheque.structure.items = {
    init: function () {
        'use strict';
        $('#options').on('cocoon:after-insert', function(e, newElmt) {
            var input = $('.js-slug', newElmt);
            input.addClass('js-slug-input');
            window.slugInput.initInput(input.get(0));
        })
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
    window.ecotheque.structure.items.init();
});
