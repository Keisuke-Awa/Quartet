function initialize() {
  const next_button = document.getElementById('nextWeekButton');
  const before_button = document.getElementById('beforeWeekButton');
  const dateSearchFirst = document.getElementById('dateSearchFirst');
  const dateSearchSecond = document.getElementById('dateSearchSecond');
  dateSearchSecond.style.display="none";

  next_button.onclick = function() {
    dateSearchFirst.style.display = "none";
    dateSearchSecond.style.display = "flex";
  }

  before_button.onclick = function() {
    dateSearchFirst.style.display = "flex";
    dateSearchSecond.style.display = "none";
  }
}

initialize()