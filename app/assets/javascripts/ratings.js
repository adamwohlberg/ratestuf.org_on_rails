// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).foundation();
// $(function(){ $(document).foundation(); });


// animation to drop the last letter in the tagline after 2 seconds
$(document).ready(function() {
  setTimeout(function() {
    $("#logo3-falling-f").css("position", "absolute" );
    $("#logo3-falling-f").css("z-index", "-9999" );
    $("#logo3-falling-f").css("font-size", "1em" );
    $("#logo3-falling-f").css("margin", "60px 0px 0px 4px" );
    $("#logo3-falling-f").css("-webkit-transform", "rotate(85deg)" );
    $("#logo3-falling-f").css("-moz-transform", "rotate(85deg)" );
    $("#logo3-falling-f").css("-ms-transform", "rotate(85deg)" );
    $("#logo3-falling-f").css("-o-transform", "rotate(85deg)" );
    }, 2000);
});

// function saveratings(data) {
//   $.ajax({ 
//       type: "POST",
//       url: "ajax/saveratings.php",
//       data: JSON.stringify(data),
//       contentType: "application/json",
//       success: function(res) {
//         console.log(res);
//         if (res.hasOwnProperty('alreadyRated')) {
//           alert("You've already rated this stuf.");
//         } else {
//         alert("Got it! Thanks for adding your ratings to our database. You are awesome!");
//         location.reload();
//         }
//         // Location.reload(true);
//       },
//       error: function(res) {
//         console.log(res);
//       }
//       ,dataType:'json'});
// }


//user is able to select a draggable ball and delete it from the screen using BACKSPSACE or DELETE
$(".draggable").click(function(){
  if (userloggedin) {
    $(".draggable").not(this).removeClass("active");
    $(this).toggleClass("active");
  }
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
//STARS
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
//DOLLARS
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

$(document.body).keyup(function(event){
    if (event.keyCode == 46 || event.keyCode == 8) {
        event.preventDefault();
        $(".active").remove();
    }
});

$( ".draggable" ).parent().css( "background-color", "20px red" );


$(".draggable").click(function() {
    $(this).find(".itemName").fadeIn(1000);
    return;
});
$(".draggable").mouseover(function() {
    $(this).find(".itemName").fadeIn(1000);
    return;
});
$(".draggable").mouseout(function() {
    $(this).find(".itemName").fadeOut(4000);
    return;
});


//display number of ratings
  $(".draggable").hover(function() {
      $(this).find(".speechBubble").fadeIn(1000).delay(50).fadeOut(2500);
      $(this).find(".ratings").fadeIn(1000).delay(50).fadeOut(2500);
      return;
  });

 // draggable within a box and others
$(function() {
  $(".draggable").draggable({ containment: "#containmentWrapper" });
  });

// *****************************************
// INSERT RATINGS INTO DATABASE ONCLICK
// *****************************************
  var data ={};
  data.items = [];

$("#rateNowButton").click(function(){

  if ($(this).hasClass('disabled')) {
    return;
  } 
  
  if ($('.draggable').length == 0) { 
   alert("Please search for an item first.");
    return;
  }

// disable the button to prevent multiple clicks
 $("#rateNowButton").addClass('disabled');

  $('.draggable').each(function() {

  itemName = $(this).attr('name');
  itemId = $(this).attr('id');
  containerHeight = ($(this).parent().height() * 0.78 );
  containerWidth = ($(this).parent().width() * 0.895962732919255);
  positionFromLeft = ($(this).position().left);
  positionFromTop = ($(this).position().top);
  xRating = (Math.round((positionFromLeft / containerWidth) * 100 )/ 100);
  yRating = (Math.round((1-(positionFromTop / containerHeight))* 100 )/ 100);
  textRating = $('.dialogTextArea').html();

  // testing code
  // alert('container height: '+ ($(this).parent().height() * 0.78 ));
  // alert('position from top: '+ positionFromTop);
  // alert('container width: '+ ($(this).parent().width() * 0.895962732919255));
  // alert('position from left: '+ positionFromLeft);
  // alert('xRating'+ xRating);
  // alert('yRating' + yRating);

  data.items.push({"name": itemName, "itemId": itemId, "xRating":xRating, "yRating":yRating, "textRating":textRating});

});

// disable the button to prevent multiple clicks
 $("#rateNowButton").removeClass('disabled');
 
 $.ajax({ 

  data: JSON.stringify(data),
  type: "POST",
  url: "ajax/saveratings.php",
  contentType: "application/json",
  success: function(res) {
    console.log(res);
    if (res.hasOwnProperty('alreadyRated')) {
      alert("You've already rated this stuf.");
    } else {
    alert("Got it! Thanks for adding your ratings to our database. You are awesome!");
    location.reload();
    }
    // Location.reload(true);
  },
  error: function(res) {
    // console.log(res);
  },
  dataType:'json'});

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
  // alert('xposition: ' + xPosition + ', yposition: ' + yPosition + ' yposition of lowerline: ' + yPositionOnLowerLine + ' yposition of upperline: ' + yPositionOnUpperLine);

  // if (userloggedin && yPosition > yPositionOnUpperLine) {
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

// duplicate to try to get highlighting on mouseover to function more smoothly so when user releases mouse, the javascript tries again to color correctly. remove this and you need to click to get a recoloring.
$(".draggable").mouseup(function(){

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

// $(document).ready(function() {
// $("#rateTableFrame").css('border', '2px solid blue');
// // $('.draggable').parent().css('border', '5px solid red');
// });

// $(document).ready(function() {
// $("#containmentWrapper").css('border', '2px solid red');
// // $('.draggable').parent().css('border', '5px solid red');
// });


