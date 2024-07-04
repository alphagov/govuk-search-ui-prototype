/* eslint-env jquery */
/* global accessibleAutocomplete */
import accessibleAutocomplete from '@trevoreyre/autocomplete-js'

window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.AccessibleAutocomplete = function () {

    var currentInputValue = '';
    var NUMBER_RESULTS_SHOWN = 3;

    var params = new URLSearchParams(window.location.search);
    var model = params.get('ac-model') || '';

    var source = async function (query) {
      if (query && query.length) {
        var response = await fetch(`/api/autocompletes?q=${query}&model=${model}`);
        var completes = await response.json();
        currentInputValue = query

        if (completes.length > NUMBER_RESULTS_SHOWN) {
          completes = completes.slice(0, NUMBER_RESULTS_SHOWN);
        }
        return completes
      }
    }

    var renderResultHtml = function (result, props,inputVal ) {
      var index = result.toLowerCase().indexOf(inputVal.toLowerCase());
      return `<li ${props}>${result.substring(index, index + inputVal.length)}<span class='govuk-!-font-weight-bold'>${result.substring(index + inputVal.length, result.length)}</span></li>`
    }

    //add google search box style behaviour to keyboard interaction
    Array.from(document.querySelectorAll("#finder-keyword-search")).forEach((el) => {
      el.addEventListener("keyup", function(e) {
        var activeEl = e.target.getAttribute("aria-activedescendant");
        if (activeEl) {
          e.target.value = document.getElementById(activeEl).innerText;
        }

        if (e.key === "Enter") {
          e.target.closest("form").submit();
        }
      });
    });

    new accessibleAutocomplete('#autocomplete', {
      search: source,
      debounceTime: 50,
      renderResult: (value, props) => renderResultHtml(value, props, currentInputValue),
      onUpdate: function(results, selectedIndex) {
        var containerEl = document.querySelector(".autocomplete-result-container");
        if (results.length) {
          containerEl.style.display = "block";
        } else {
          containerEl.style.display = "none";
        }
      }
    });
  }
})(window.GOVUK.Modules)
