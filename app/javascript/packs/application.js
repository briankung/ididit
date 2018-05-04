/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import $ from 'jquery';
import moment from 'moment';

global.$ = $;
global.jQuery = $;
global.moment = moment

$(document).ready(function() {
  $('#q').on('keydown', function(e) {
    if (e.keyCode == 13) {
      window.location.href = "/?q=" + encodeURIComponent(e.target.value)
    };
    if ((e.shiftKey && e.keyCode == 191) || (e.keyCode == 84)) {
      e.stopPropagation();
    };
  });

  $('body').on('keydown', function(e) {
    if (e.shiftKey && e.keyCode == 191) { // question mark
      $('#q').focus();
      e.preventDefault();
    }
  });
});
