window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.Accordion = function ($element) {

    class Accordion {
        constructor(domNode) {
            this.rootEl = domNode;
            this.buttonEl = this.rootEl.querySelector('button[aria-expanded]');

            const controlsId = this.buttonEl.getAttribute('aria-controls');
            this.contentEl = document.getElementById(controlsId);

            this.open = this.buttonEl.getAttribute('aria-expanded') === 'true';

            // add event listeners
            this.buttonEl.addEventListener('click', this.onButtonClick.bind(this));
        }
      
        onButtonClick() {
          this.toggle(!this.open);
        }
      
        toggle(open) {
          if (open === this.open) {
            return;
          }
      
          this.open = open;
      
          this.buttonEl.setAttribute('aria-expanded', `${open}`);
          if (open) {
            this.contentEl.removeAttribute('hidden');
          } else {
            this.contentEl.setAttribute('hidden', '');
          }
        }
      
        // open and close methods for convenience
        open() {
          this.toggle(true);
        }
      
        close() {
          this.toggle(false);
        }
      }

      new Accordion($element);
  }
})(window.GOVUK.Modules)
