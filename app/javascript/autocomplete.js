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
      const response = await fetch(`/api/autocompletes?q=${query}`);
      var completes = await response.json();
      currentInputValue = query
      return completes
    }

    var renderResultHtml = function (result, props,inputVal ) {
      var index = result.toLowerCase().indexOf(inputVal.toLowerCase());
      return `<li ${props}>${result.substring(index, index + inputVal.length)}<span class='highlight'>${result.substring(index + inputVal.length, result.length)}</span></li>`
    }

    new accessibleAutocomplete('#autocomplete', {
      search: source,
      debounceTime: 100,
      renderResult: (value, props) => renderResultHtml(value, props, currentInputValue)
    });
  }
})(window.GOVUK.Modules)
