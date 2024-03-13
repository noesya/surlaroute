window.ecotheque.projectForm = {
    init: function () {
        'use strict';
        this.form = document.querySelector('form.js-project-form');
        if (!this.form) {
            return;
        }
        this.initAnswerFieldsElts();
    },

    initAnswerFieldsElts: function () {
        'use strict';
        var i;
        this.answerFieldsElts = this.form.querySelectorAll('.js-answer-fields');
        for (i = 0; i < this.answerFieldsElts.length; i += 1) {
            this.initAnswerFieldsElt(this.answerFieldsElts[i]);
        }
    },

    initAnswerFieldsElt: function (answerFieldsElt) {
        'use strict';
        var checkbox = answerFieldsElt.querySelector('input[type="checkbox"]'),
            containerWhenChecked = answerFieldsElt.querySelector('.js-checked-answer-fields');

        checkbox.addEventListener('change', function () {
            containerWhenChecked.style.display = checkbox.checked ? 'block' : 'none';
        });
        containerWhenChecked.style.display = checkbox.checked ? 'block' : 'none';
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
    window.ecotheque.projectForm.init();
});
