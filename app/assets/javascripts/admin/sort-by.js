window.ecotheque.sortBy = {
    init: function () {
        'use strict';
        var sortByForm = document.querySelector('.js-sort-by-form');
        var sortByToggle = document.querySelector('.js-sort-by-list');
        if (!sortByToggle) {
            return;
        }
        sortByToggle.addEventListener('change', function () {
            sortByForm.submit();
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
    window.ecotheque.sortBy.init();
});
