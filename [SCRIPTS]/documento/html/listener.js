$(function() {
  $('#documento').hide();
  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ui" && item.display === true) {
      $('#documento').show();
	  document.getElementById('name').innerHTML = " " + item.name;
	  document.getElementById('surname').innerHTML = " " + item.surname;
    console.log(gender);
	  document.getElementById('gender').innerHTML = " " + item.gender1;
    } else {
      $('#documento').hide();
    }
  }, false);
});
