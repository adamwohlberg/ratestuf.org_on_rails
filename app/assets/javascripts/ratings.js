// *****************************************
// CREATE RATINGS
// *****************************************
$( document ).ready(function() {
	var data ={};
	data.items = [];

	$("#rateNowButton").click(function(event){
			event.preventDefault();
		  if ($(this).hasClass('disabled')) {
		  	alert('You must log in to rate stuff.')
		    return;
			}

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
		  data: data,
		  type: "POST",
		  url: "/ratings",
		  contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		  dataType: 'script'
		});

		data.items = [];
		$("#rateNowButton").removeClass('disabled');
	});
});
