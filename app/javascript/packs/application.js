/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import $ from 'jquery'
import moment from 'moment'

global.$ = $
global.jQuery = $
global.moment = moment

$(document).ready(function() {
  $('#q').on('keydown', function(e) {
    const { keyCode, shiftKey, target } = e
    const enterKey = (keyCode == 13),
          shiftFwdSlash = (shiftKey && keyCode == 191),
          tKey = (keyCode == 84)

    if (enterKey) {
      window.location.href = "/?q=" + encodeURIComponent(target.value)
    }

    if (shiftFwdSlash || tKey) {
      stopPropagation()
    }
  })
})
