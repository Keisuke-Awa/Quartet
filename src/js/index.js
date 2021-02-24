// import "../images/default-icon.jpeg"
// import "../images/logo-nav.jpeg"
// import "../images/logo.jpeg"

import "./modules/application.scss";
import 'jquery';
import "bootstrap";
import 'bootstrap4-tagsinput/tagsinput.js'
import Rails from 'rails-ujs'

Rails.start();

window.$ = $;


// $(function(){
//   function check_flash() {
//     const alert = document.getElementsByClassName('alert');
//     const content_box = document.getElementById('contentBox');
//     if (alert.length) {
//       content_box.className = "content-box-with-flash";
//     } else {
//       content_box.className = "content-box";
//     }
//   };

//   check_flash();
// });

$(function() {
  setTimeout("$('.alert').fadeOut('slow')", 2000);
})

