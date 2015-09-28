$( document ).ready(function() {
// *****************************************
// CREATE RATINGS
// *****************************************
var data ={};
data.items = [];

	$("#rateNowButton").click(function(event){
		event.preventDefault();
		console.log('click the button');
	  if ($(this).hasClass('disabled')) {
	  	alert('You must log in to rate stuff.')
	    return;}
	$("#rateNowButton").addClass('disabled');
  $('.draggable').each(function() {
	  name = $(this).attr('name');
	  id = $(this).attr('id');
	  containerHeight = ($(this).parent().parent().height() * 0.78 );
	  containerWidth = ($(this).parent().parent().width() * 0.896);
	  positionFromLeft = ($(this).position().left);
	  positionFromTop = ($(this).position().top);
	  x_rating = (Math.round((positionFromLeft / containerWidth) * 100 )/ 100);
	  y_rating = (Math.round((1-(positionFromTop / containerHeight))* 100 )/ 100);
  	data.items.push({"name": name, "id": id, "x_rating":x_rating, "y_rating":y_rating});
		});

	 $.ajax({
	  data: JSON.stringify(data),
	  type: "POST",
	  url: "/ratings",
	  contentType: "application/json",
	  success: function(json) {
	  	console.log(json);
	  	$('.notice').empty().hide();
			$('.alert').empty().hide();
			$('#flash_messages').html = "";
			$.each(json, function(i, item) {
				position_left = json[i].x_rating * containerWidth;
				position_top  = (containerHeight - (containerHeight * json[i].y_rating));
			  $('#'+ json[i].id + " p[class=ratings]").text(json[i].count + ' ratings');
				$('#'+ json[i].id).css("left", position_left).css('top', position_top);
			  if (json[i].count === 3) {
				$('p[class=notice]').text('You can only rate an item three times. Future ratings will update your last rating.');
			  } else if (json[i].count < 3) {
				$('p[class=notice]').text('Congratulations! Your rating(s) were saved.');
				};
			});
	  },
	  error: function(json) {
	  	console.log('error');
	  },
	  dataType:'json'});
	 data.items = [];
	  $("#rateNowButton").removeClass('disabled');
	});
});
