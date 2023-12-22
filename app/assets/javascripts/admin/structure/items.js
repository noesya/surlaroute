/*global $  */

window.ecotheque.structure.items = {
    init: function () {
        'use strict';
        this.kindField = document.querySelector('#structure_item_kind');
        this.choices = document.querySelector('#js-choices');
        this.kindField.addEventListener('change', this.manageChoicesVisibilitiy.bind(this));
        this.manageChoicesVisibilitiy();
        this.initAddItemCallback();
    },

    manageChoicesVisibilitiy: function () {
        'use strict';
        var kind = this.kindField.value;
        var kindsWithChoices = this.kindField.dataset.withChoices.split('|');
        if (kindsWithChoices.indexOf(kind) !== -1) {
            this.choices.classList.remove('d-none');
        } else {
            this.choices.classList.add('d-none');
        }
    },

    initAddItemCallback: function () {
        'use strict';
        $('#options').on('cocoon:after-insert', function(e, newElmt) {
            var input = $('.js-slug', newElmt);
            input.addClass('js-slug-input');
            window.slugInput.initInput(input.get(0));
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
    if (document.body.classList.contains('js-structure-items')) {
        window.ecotheque.structure.items.init();
    }
});
