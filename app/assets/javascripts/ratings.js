// *****************************************
// CREATE RATINGS
// *****************************************
var data ={};
data.items = [];

$(document).ready(function() {
	$("#rateNowButton").click(function(event){
	event.preventDefault();
	  if ($(this).hasClass('disabled')) {
	  	alert('You must log in to rate stuff.')
	    return;}
	$("#rateNowButton").addClass('disabled');
  $('.draggable').each(function() {
	  name = $(this).attr('name');
	  id = $(this).attr('id');
	  containerHeight = ($(this).parent().height() * 0.78 );
	  containerWidth = ($(this).parent().width() * 0.896);
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
			$.each(json, function(i, item) {
				position_left = json[i].x_rating * containerWidth;
				position_top  = (containerHeight - (containerHeight * json[i].y_rating));
			  $('#'+ json[i].id + " p[class=ratings]").text(json[i].count + ' ratings');
				$('#'+ json[i].id).css("left", position_left).css('top', position_top);
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

