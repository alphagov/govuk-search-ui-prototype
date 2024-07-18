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

    Array.from(document.querySelectorAll('.facet-tag__remove')).forEach(function(el) {
      el.addEventListener("click", function(e) {
        const params = new URLSearchParams(window.location.href);
        console.log(params)
        params.delete("filter_content_purpose_supergroup", "services");
      });
  });
  }
  
})(window.GOVUK.Modules)
