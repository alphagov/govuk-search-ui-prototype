window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.Filters = function ($element) {
    Array.from($element.querySelectorAll('.js-filter-autosubmit input')).forEach(function(el) {
        el.addEventListener("change", function(e) {
            el.closest("form").submit();
        });
    });

    //cant seem to be able to add js-filter-autosubmit class to radio component
    Array.from($element.querySelectorAll('input[type=radio]')).forEach(function(el) {
        el.addEventListener("change", function(e) {
            el.closest("form").submit();
        });
    });

    Array.from($element.querySelectorAll('select')).forEach(function(el) {
        el.addEventListener("change", function(e) {
            el.closest("form").submit();
        });
    });
  }
  
})(window.GOVUK.Modules)
