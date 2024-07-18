window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.Accordion = function ($element) {

    class Accordion {
        constructor(domNode) {
          this.rootEl = domNode;
          let open = this.rootEl.getAttribute('data-accordion-open');
          this.persist = this.rootEl.getAttribute('data-accordion-persist-state');
          this.buttonEl = this.rootEl.querySelector('button[aria-expanded]');

          if (this.persist) {
            open = localStorage.getItem(this.buttonEl.id) || open;
          }
      
          const controlsId = this.buttonEl.getAttribute('aria-controls');
          this.contentEl = document.getElementById(controlsId);

          if (open === "false") {
            this.contentEl.setAttribute('hidden', '');
          } else {
            this.contentEl.removeAttribute('hidden');
          }

          this.buttonEl.setAttribute('aria-expanded', `${open}`);
          this.open = this.buttonEl.getAttribute('aria-expanded') === 'true';
      
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
            localStorage.setItem(this.buttonEl.id, true);
          } else {
            this.contentEl.setAttribute('hidden', '');
            localStorage.setItem(this.buttonEl.id, false);
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
