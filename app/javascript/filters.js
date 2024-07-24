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
    // Array.from($element.querySelectorAll('input[type=radio]')).forEach(function(el) {
    //     el.addEventListener("change", function(e) {
    //         el.closest("form").submit();
    //     });
    // });

    // Individual handlers for topic changes so we can reset the secondary topic on primary topic
    // change
    $element.querySelector("#primary_topic").addEventListener("change", function(el) {
        $element.querySelector("#secondary_topic").value = "";
        $element.querySelector("#primary_topic").closest("form").submit();
    });
    $element.querySelector("#secondary_topic").addEventListener("change", function(el) {
        $element.querySelector("#secondary_topic").closest("form").submit();
    });
  }

})(window.GOVUK.Modules)
