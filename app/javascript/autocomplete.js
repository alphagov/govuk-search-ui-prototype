/* eslint-env jquery */
/* global accessibleAutocomplete */
import accessibleAutocomplete from '@trevoreyre/autocomplete-js'

window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.AccessibleAutocomplete = function ($element) {

    var currentInputValue = '';
    var NUMBER_RESULTS_SHOWN = 5;

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

    var renderResultHtml = function (result, props, inputVal) {
      var index = result.toLowerCase().indexOf(inputVal.toLowerCase());
      return `<li ${props}>${result.substring(0, index + inputVal.length)}<span class='govuk-!-font-weight-bold'>${result.substring(index + inputVal.length, result.length)}<span><div class="border">&nbsp;</div></li>`
    }

    //add google search box style behaviour to keyboard interaction
    Array.from($element.querySelectorAll("input")).forEach((el) => {
      el.addEventListener("keyup", function(e) {
        var activeEl = e.target.getAttribute("aria-activedescendant");
        if (activeEl) {
          e.target.value = $element.getElementById(activeEl).innerText;
        }

        if (e.key === "Enter") {
          e.target.closest("form").submit();
        }
      });
    });

    Array.from($element.querySelectorAll(".autocomplete-result-container")).forEach((el) => {
      el.addEventListener("click", function(e) {
        $element.querySelector("input").value = e.target.closest("li").innerText;
        $element.querySelector(".search-form").submit();
      });
    });
    //end google behaviour

    new accessibleAutocomplete(`#${$element.id}`, {
      search: source,
      debounceTime: 50,
      renderResult: (value, props) => renderResultHtml(value, props, currentInputValue),
      onUpdate: function(results, selectedIndex) {
        var containerEl = $element.querySelector(".autocomplete-result-container");
        if (results.length) {
          containerEl.style.display = "block";
        } else {
          containerEl.style.display = "none";
        }
      }
    });
  }
})(window.GOVUK.Modules)
