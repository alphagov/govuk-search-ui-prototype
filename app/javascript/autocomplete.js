/* eslint-env jquery */
/* global accessibleAutocomplete */
import accessibleAutocomplete from '@trevoreyre/autocomplete-js'

window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.AccessibleAutocomplete = function () {

    var source = async function (query) {
      const response = await fetch(`/api/autocompletes?q=${query}`);
      var completes = await response.json();
      return completes
    }

    new accessibleAutocomplete('#autocomplete', {
      search: source
    });
  }
})(window.GOVUK.Modules)
