/* eslint-env jquery */
/* global accessibleAutocomplete */
import accessibleAutocomplete from '@trevoreyre/autocomplete-js'

window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.AccessibleAutocomplete = function () {

    var currentInputValue = '';
    var formInput = document.querySelector('.gem-c-search__input');

    var source = async function (query) {
      if (query && query.length) {
      const response = await fetch(`/api/autocompletes?q=${query}`);
      var completes = await response.json();
      currentInputValue = query
      return completes
      }
    }

    var renderResultHtml = function (result, props,inputVal ) {
      var index = result.toLowerCase().indexOf(inputVal.toLowerCase());
      return `<li ${props}>${result.substring(index, index + inputVal.length)}<span class='govuk-!-font-weight-bold'>${result.substring(index + inputVal.length, result.length)}</span></li>`
    }

    new accessibleAutocomplete('#autocomplete', {
      search: source,
      debounceTime: 50,
      renderResult: (value, props) => renderResultHtml(value, props, currentInputValue),
      onUpdate: function(results, selectedIndex) {
        if (results.length) {
        document.querySelector(".autocomplete-result-container").style.display = "block";
        } else {
          document.querySelector(".autocomplete-result-container").style.display = "none";
        }
      }
    });
  }
})(window.GOVUK.Modules)
