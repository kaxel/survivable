// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"

$(document).ready(function() {

  // #first_select is the id of our first select box, if the ajax request has been successful,
  // an ajax:success event is triggered.

  $('#:survivalist_selection').live('ajax:success', function(evt, data, status, xhr) {
    // get second selectbox by its id
	  alert("boom");
  });

});