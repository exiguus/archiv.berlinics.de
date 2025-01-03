/*
 * id/version: berlinics.de v0.9
 * autor/copyright: Simon Gattner
 * date/location: 10-11-14 Berlin Germany
 * contact/url: http://gattner.name/simon & http://gedit.net/
 * licence: BY-NC-SA
 *   http://creativecommons.org/licenses/by-nc-sa/3.0/deed.de
 */
// toggles

function toggle() {
  var els = toggle.arguments;
  var elsLen = els.length;
  for (var i = 0; i < elsLen; i++) {
    var el = document.getElementById(els[i]);
    if (el) {
      if (el.style.display != 'none') {
        el.style.display = 'none';
      } else {
        el.style.display = '';
      }
    }
  }
}
// cleanUp/Change <input> etc. value
function chgValue(obj, newValue) {
  var el = document.getElementById(obj);
  if (el) {
    var oldValue = el.value;
    el.onfocus = function () {
      if (newValue == null) {
        el.value = '';
      } else {
        el.value = newValue;
      }
    };
    el.onblur = function () {
      el.value = oldValue;
    };
  }
}

function _focus(obj) {
  var el = document.getElementById(obj);
  if (el) {
    el.focus();
  }
}

function addClass(cl) {
  document.documentElement.className += ' ' + cl;
}
// onload functions
window.onload = function outHTML() {
  addClass('jsshow'); //show js functionality
  if (typeof window.toggleInHTML == 'function') {
    toggleInHTML();
  }
  searchInHTML();
};
