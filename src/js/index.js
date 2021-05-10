// import "../images/default-icon.jpeg"
// import "../images/logo-nav.jpeg"
// import "../images/logo.jpeg"

import "./modules/application.scss";
import 'jquery';
import "bootstrap";
import 'bootstrap4-tagsinput/tagsinput.js';
import 'lightbox2';
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

  $(window).scroll(function() {
    if ($(this).scrollTop() > 0) {
      $('header').css('box-shadow', '2px 2px 10px gray');
    } else {
      $('header').css('box-shadow', 'none');
    }
  });
})

function flexTextarea(el) {
  const dummy = el.querySelector('.flex-textarea__dummy')
  el.querySelector('.flex-textarea__textarea').addEventListener('input', e => {
    dummy.textContent = e.target.value + '\u200b'
  })
}

document.querySelectorAll('.flex-textarea').forEach(flexTextarea)




