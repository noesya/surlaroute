window.ecotheque.subscriptionCheck = {
    init: function () {
        'use strict';
        this.element = document.getElementById('js-subscription-verification');
        if (this.element === null) {
            return;
        }

        this.verificationUrl = this.element.dataset.url;
        this.checkoutIntentId = this.element.dataset.checkoutIntentId;
        this.poll();
    },

    onResponse: function (event) {
        'use strict';
        var response = JSON.parse(event.currentTarget.response);
        if (response.location !== null) {
            document.location.href = response.location;
        } else {
            window.setTimeout(this.poll.bind(this), 3000);
        }
    },

    poll: function () {
        'use strict';
        var request = new XMLHttpRequest();
        request.open('POST', this.verificationUrl, true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name=csrf-token]').content);
        request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        request.onload = this.onResponse.bind(this);
        request.send(JSON.stringify({ 'checkout_intent_id': this.checkoutIntentId }));
    }
};

window.ecotheque.subscriptionCheck.init();
