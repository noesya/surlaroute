window.ecotheque.orderBy = {
    init: function () {
        'use strict';
        var orderByForm = document.querySelector('.js-order-by-form');
        var orderByToggle = document.querySelector('.js-order-by-list');
        if (!orderByToggle) {
            return;
        }
        orderByToggle.addEventListener('change', function () {
            orderByForm.submit();
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
    window.ecotheque.orderBy.init();
});
