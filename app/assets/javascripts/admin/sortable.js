/*global $, Sortable */

// Add [data-sortable] to container. Its direct children can be sortable.
// You can pass a value to data-sortable. It can be "xhr" or "inputs". Defaults to "xhr".
// With "xhr", you need to set [data-id="<id>"] on the children and [data-sort-url="<post url to call>"] on the container.
// With "inputs", you need to set [data-sortable-input] on the input field of each child.
window.sortableManager = {
    init: function () {
        'use strict';
        var i;
        this.containers = document.querySelectorAll('[data-sortable]');
        this.instances = [];
        for (i = 0; i < this.containers.length; i += 1) {
            this.instances.push(this.createInstance(this.containers[i]));
        }
    },

    createInstance: function (container) {
        'use strict';
        var sortableType = container.dataset.sortable;
        if (sortableType === 'input') {
            $(container).on('cocoon:after-add cocoon:after-remove', this.updateViaInputs);
        }

        return new Sortable(container, {
            handle: '.handle',
            group: 'nested',
            animation: 150,
            fallbackOnBody: true,
            swapThreshold: 0.65,
            onEnd: sortableType === 'inputs' ? this.updateViaInputs : this.updateViaXhr
        });
    },

    updateViaXhr: function (event) {
        'use strict';
        var url = event.to.dataset.sortUrl,
            children = event.to.children,
            ids = [],
            i;

        if (!url) {
            return;
        }

        for (i = 0; i < children.length; i += 1) {
            ids.push(children[i].dataset.id);
        }

        $.post(url, { ids: ids });
    },

    updateViaInputs: function (event) {
        'use strict';
        var children = event.to.children,
            newPosition = 0,
            child,
            i;

        for (i = 0; i < children.length; i += 1) {
            child = children[i];
            if (this.shouldSkipChild(child)) {
                continue;
            }
            newPosition += 1;
            this.updateChildPosition(child, newPosition);
        }
    },

    shouldSkipChild: function (child) {
        'use strict';
        var destroyInput = child.querySelector('input[name$="[_destroy]"]');
        return destroyInput !== null && destroyInput.value === '1';
    },

    updateChildPosition: function (child, newPosition) {
        'use strict';
        var targetInput = child.querySelector('[data-sortable-input]');
        if (targetInput !== null) {
            targetInput.value = newPosition;
        }
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
    window.sortableManager.init();
});
