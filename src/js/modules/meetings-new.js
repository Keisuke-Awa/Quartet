import "./application.scss";
import 'jquery';
import "bootstrap";
import 'bootstrap4-tagsinput/tagsinput.js';

$(function() {
  
  const firstForm = document.getElementById('firstMeetingForm');
  const secondForm = document.getElementById('secondMeetingForm');

  document.getElementById('nextButton').onclick = function(e) {
    firstForm.style.display = "none";
    secondForm.style.display = "block";
  };
  document.getElementById('beforeButton').onclick = function(e) {
    firstForm.style.display = "block";
    secondForm.style.display = "none";
  };

  // const tagCategory = document.getElementById();
  // const tagList = document.getElementById('selectTagList');
  // tagList.style.display = "none";

  // const tagBtns = document.getElementsByClassName('tag-btn');
  const tagForm = document.getElementById('tagForm');
  // function clickTag(obj) {
  //   let tagBtn = obj.childNodes;
  //   console.log(tagBtn[2]);
  //   tagBtn[2].style.display = "none";
    // console.log(tagBtn[2].value);
  // }
});
