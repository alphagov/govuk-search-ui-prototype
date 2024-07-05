window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.TopicsSelect = function ($element) {

    var targetEl = document.getElementById('topic-select-target');

    // targetEl.disabled = true;

    // $element.addEventListener("change", async function(e) {
    //     var response = await fetch(`/api/topics?q=${e.target.value}`);
    //     var topics = await response.json();
    //     populate(topics);
    // });

    var populate = async function(topics) {
        targetEl.innerHTML = '';

        var option = document.createElement('option');
        option.innerHTML = 'All sub-topics';
        targetEl.appendChild(option);

        await topics.forEach(t => {
            var option = document.createElement('option');
            option.innerHTML = t.title;
            targetEl.appendChild(option);
            targetEl.disabled = false;
        });
        
    }
  }
})(window.GOVUK.Modules)
