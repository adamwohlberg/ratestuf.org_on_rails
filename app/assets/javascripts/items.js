function OnloadFunction ()
{

$(document).foundation();

  setTimeout(function() {
	$("#starCounter").css("display", "block");
	}, 100);	

function tagLineLetterFallsOnLoad() {
 setTimeout(function() {
  $("#logo3-falling-f").css("position", "absolute" );
  $("#logo3-falling-f").css("z-index", "-9999" );
  $("#logo3-falling-f").css("font-size", "4.1em" );
  $("#logo3-falling-f").css("margin", "900px 0px 0px 4px" );
  $("#logo3-falling-f").css("-webkit-transform", "rotate(88deg)" );
  $("#logo3-falling-f").css("-moz-transform", "rotate(88deg)" );
  $("#logo3-falling-f").css("-ms-transform", "rotate(88deg)" );
  $("#logo3-falling-f").css("-o-transform", "rotate(88deg)" );
	 },1000);
 setTimeout(function() {
  $("#logo3-falling-f").hide();
 },1900);
}

	$(".draggable").dblclick(function(){
	    $(this).fadeOut(100);
		});

	$(".draggable").mousemove(function(){
	  var counter = ((((($(this).position().left)/($('#containmentWrapper').width()-($(this).width()/2))*100)/20)+0.4).toFixed(1));
	    if (counter == 0.4) {
	      counter = (0.0).toFixed(1); 
	    } else if (counter > 5) {
	       counter = (5.0).toFixed(1);     
	    }
	    $("#starCounter").html(counter);
	});

$(".draggable").mousemove(function(){
	  $(".star").removeClass('starhover');

	  if ($(this).position().left > (($("#star1").position().left)+50)) {
	    $("#star1").addClass('starhover');
	  } 
	  if ($(this).position().left > (($("#star2").position().left)+50)) {
	    $("#star2").addClass('starhover');
	  }
	  if ($(this).position().left > (($("#star3").position().left)+50)) {
	    $("#star3").addClass('starhover');
	  }
	      if ($(this).position().left > (($("#star4").position().left)+50)) {
	    $("#star4").addClass('starhover');
	  }
	      if ($(this).position().left > (($("#star5").position().left)+50)) {
	    $("#star5").addClass('starhover');
	  }
	  $("#fourDollars").removeClass('dollarhover');
	  $("#threeDollars").removeClass('dollarhover');   
	  $("#twoDollars").removeClass('dollarhover');
	  $("#oneDollar").removeClass('dollarhover');

	  if ($(this).offset().top < (($("#fourDollars").offset().top)+40)) {
	    $("#fourDollars").addClass('dollarhover');
	  } 
	  if ($(this).offset().top < (($("#threeDollars").offset().top)+40)) {
	    $("#threeDollars").addClass('dollarhover');
	  }
	  if ($(this).offset().top < (($("#twoDollars").offset().top)+40)) {
	    $("#twoDollars").addClass('dollarhover');
	  }
	      if ($(this).offset().top < (($("#oneDollar").offset().top)+20)) {
	    $("#oneDollar").addClass('dollarhover');
	  }
	});

  $(".draggable").hover(function() {
      $(this).find(".speechBubble").fadeIn(1000).delay(50).fadeOut(2500);
      $(this).find(".ratings").fadeIn(1000).delay(50).fadeOut(2500);
      return;
  });

	$(function() {
	  $(".draggable").draggable({ containment: "#containmentWrapper" });
	  });

	$(".draggable").each(function(){

	  xPosition = (Math.round(($(this).position().left / ($(this).parent().width())) * 100));
	  yPosition = (100-(Math.round(($(this).position().top / ($(this).parent().height())) * 100)));
	  UpperLineSlope = 0.8965;
	  yPositionOnUpperLine = ((UpperLineSlope * xPosition) + 25);
	  LowerLineSlope = 0.8977;
	  yPositionOnLowerLine = ((LowerLineSlope * xPosition) + 5);
	  // alert('xposition: ' + xPosition + ', yposition: ' + yPosition + ' yposition of lowerline: ' + yPositionOnLowerLine + ' yposition of upperline: ' + yPositionOnUpperLine);

	  if (yPosition > yPositionOnUpperLine) {
	        $(this).removeClass('bestValue');
	        $(this).removeClass('fairValue');  
	        $(this).addClass('worseValue');
	  }
	  
	  if (yPosition <= yPositionOnUpperLine && yPosition >= yPositionOnLowerLine) {
	        $(this).removeClass('worseValue');
	        $(this).removeClass('bestValue');        
	        $(this).addClass('fairValue'); 
	  } 
	  
	  if (yPosition < yPositionOnLowerLine) {
	        $(this).removeClass('worseValue');
	        $(this).removeClass('fairValue');  
	        $(this).addClass('bestValue'); 
	  }
	}); 

	$(".draggable").mouseover(function(){
	  xPosition = (Math.round(($(this).position().left / ($(this).parent().width())) * 100));
	  yPosition = (100-(Math.round(($(this).position().top / ($(this).parent().height())) * 100)));
	  UpperLineSlope = 0.8965;
	  yPositionOnUpperLine = ((UpperLineSlope * xPosition) + 25);
	  LowerLineSlope = 0.8977;
	  yPositionOnLowerLine = ((LowerLineSlope * xPosition) + 5);
	  if (yPosition > yPositionOnUpperLine) {
	        $(this).removeClass('bestValue');
	        $(this).removeClass('fairValue');  
	        $(this).addClass('worseValue');
	  }
	  
	  if (yPosition <= yPositionOnUpperLine && yPosition >= yPositionOnLowerLine) {
	        $(this).removeClass('worseValue');
	        $(this).removeClass('bestValue');        
	        $(this).addClass('fairValue'); 
	  } 
	  
	  if (yPosition < yPositionOnLowerLine) {
	        $(this).removeClass('worseValue');
	        $(this).removeClass('fairValue');  
	        $(this).addClass('bestValue'); 
	  }
	}); 

// *****************************************
// CREATE RATINGS
// *****************************************
var data ={};
data.items = [];

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

}
$(document).ready(OnloadFunction);
