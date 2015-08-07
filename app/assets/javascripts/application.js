// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(document).foundation();

$(document).ready(function() {
  // verticallyAlignDollarIcons();
  // horizontallyAlignStars();
  $("#starCounter").show();
});


// $(document).ready(function() {
// $("#rateTableFrame").css('border', '2px solid blue');
// // $('.draggable').parent().css('border', '5px solid red');
// });

// $(document).ready(function() {
// $("#containmentWrapper").css('border', '2px solid red');
// // $('.draggable').parent().css('border', '5px solid red');
// });

$(document).mouseover(function() {
  // verticallyAlignDollarIcons();
  // horizontallyAlignStars();
  // setTimeout("",20000);
});

$(document).ready(function() {
  setTimeout(function() {
    $("#logo3-falling-f").css("position", "absolute" );
    $("#logo3-falling-f").css("z-index", "-9999" );
    $("#logo3-falling-f").css("font-size", "1em" );
    $("#logo3-falling-f").css("margin", "17px 0px 0px 4px" );
    $("#logo3-falling-f").css("-webkit-transform", "rotate(55deg)" );
    $("#logo3-falling-f").css("-moz-transform", "rotate(55deg)" );
    $("#logo3-falling-f").css("-ms-transform", "rotate(55deg)" );
    $("#logo3-falling-f").css("-o-transform", "rotate(55deg)" );
    }, 300);
});

// trying flexbox instead of this
// function verticallyAlignDollarIcons() {
// var dollarSpacing = ($('.dollarRating').height());
// var dollarHeight = ($('#fourDollars').height() * 4.5);
// var dollarPadding = ((dollarSpacing - dollarHeight)/8);

// $('.dollarRating').children().css('padding-top',dollarPadding);
// $('.dollarRating').children().css('padding-bottom',dollarPadding);
// }

// triggers on load or resize for DOLLARS.
// $(window).resize(function() {

// var dollarSpacing = ($('.dollarRating').height());
// var dollarHeight = ($('#fourDollars').height() * 4);
// var dollarPadding = ((dollarSpacing - dollarHeight)/8);

// $('.dollarRating').children().css('padding-top',dollarPadding);
// $('.dollarRating').children().css('padding-bottom',dollarPadding);

// }).trigger('resize');

function capitaliseFirstLetter(text)
{
    return text.charAt(0).toUpperCase() + text.slice(1);
}

$(".draggable").dblclick(function(){

if (!userloggedin) {
  return;
}
  containerHeight = ($(this).parent().height() * 0.78 );
  containerWidth = ($(this).parent().width() * 0.895962732919255);
  positionFromLeft = ($(this).position().left);
  positionFromTop = ($(this).position().top);

  $('#dialog-message').data('itemId',$(this).attr('id'));
  $('#dialog-message').data('itemName',$(this).attr('name'));
  $('#dialog-message').data('xRating',((Math.round((positionFromLeft / containerWidth) * 100 )/ 100)));
  $('#dialog-message').data('yRating',((Math.round((1-(positionFromTop / containerHeight))* 100 )/ 100)));
  $("#dialog-message").find(".dialogTextArea").val("");

 if($(this).hasClass("bestValue")) {
    $('#dialog-message > .dialogBall').removeClass("fairValue");
    $('#dialog-message > .dialogBall').removeClass("worseValue");
    $('#dialog-message > .dialogBall').addClass("bestValue");

  } else if($(this).hasClass("fairValue")) {
    $('#dialog-message > .dialogBall').removeClass("worseValue");
    $('#dialog-message > .dialogBall').removeClass("bestValue");
    $('#dialog-message > .dialogBall').addClass("fairValue");

  } else if($(this).hasClass("worseValue")) {
    $('#dialog-message > .dialogBall').removeClass("bestValue");
    $('#dialog-message > .dialogBall').removeClass("fairValue");
    $('#dialog-message > .dialogBall').addClass("worseValue");
  }

    $( "#dialog-message" ).dialog({
      modal: true,
      width: 600,
      height: 500,
      title: "Tell us more about " + capitaliseFirstLetter($(this).find('.itemName').html()),
      buttons: {
        'Save': function() {

              var data = {};
              data.items = [];

              itemName = $('#dialog-message').data('itemName');
              itemId = $('#dialog-message').data('itemId');
              xRating = $('#dialog-message').data('xRating');
              yRating = $('#dialog-message').data('yRating');
              textRating = $("#dialog-message").find(".dialogTextArea").val();
              data.items.push({"name":itemName, "itemId":itemId, "xRating":xRating, "yRating":yRating, "textRating":textRating});
             
              saveratings(data);

          $( this ).dialog( "close" );
        },
            'Save & Share to FB (recommended)': function() {

              var data = {};
              data.items = [];

              // itemName = $(this).find('.itemName').html();
              itemName = $('#dialog-message').data('itemName');
              itemId = $('#dialog-message').data('itemId');
              xRating = $('#dialog-message').data('xRating');
              yRating = $('#dialog-message').data('yRating');
              textRating = $("#dialog-message").find(".dialogTextArea").val();
              data.items.push({"name":itemName, "itemId":itemId, "xRating":xRating, "yRating":yRating, "textRating":textRating});
             
              saveratings(data);

              window.open("https://www.facebook.com/dialog/feed?app_id=228744763916305&display=popup&caption="+encodeURI(textRating)+"&link="+encodeURIComponent("https://www.ratestuf.org/?s="+itemName+"&x="+xRating+"&y="+yRating)+"&redirect_uri=https://www.facebook.com",
                '_blank');

          $( this ).dialog( "close" );
          return;
    }
      }
    });
$('#dialog-message').dialog('setTitle', $(this).find(".itemName").html());
  });

function saveratings(data) {
          $.ajax({ 
              type: "POST",
              url: "ajax/saveratings.php",
              data: JSON.stringify(data),
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
                console.log(res);
              }
              ,dataType:'json'});
}


// triggers on load or resize for STARS

// function horizontallyAlignStars() {

// var starSpacing = ($('.starRating').width());
// var starWidth = ($('#star1').width() * 5);
// var starPadding = ((starSpacing - starWidth)/11.2);

// $('.starRating').children().css('padding-right',starPadding);
// $('.starRating').children().css('padding-left',starPadding);

// }

// $(window).resize(function() {

// var starSpacing = ($('.starRating').width());
// var starWidth = ($('#star1').width() * 5);
// var starPadding = ((starSpacing - starWidth)/11.2);

// $('.starRating').children().css('padding-right',starPadding);
// $('.starRating').children().css('padding-left',starPadding);

// }).trigger('resize');


// $(".draggable").mouseover(function(){
//     $("#responsiveAd1").show();
// });

// $(".draggable").mouseover(function(){
//     $(this).addClass("draggableHover");
// });
// $(".draggable").mouseout(function(){
//     $(this).removeClass("draggableHover");
// });


//user is able to select a draggable ball and delete it from the screen using BACKSPSACE or DELETE
$(".draggable").click(function(){
  if (userloggedin) {
    $(".draggable").not(this).removeClass("active");
    $(this).toggleClass("active");
  }
});

$(".draggable").hover(function(){
  if (!userloggedin) {
        $("#loginFacebook").fadeIn(50).css('border', '10px solid #1cff2c');
        $("#loginFacebook").css('borderRadius','10px');
        $("#loginFacebook").css('margin-top','12px');
  }
});

$(".draggable").mouseout(function(){
  if (!userloggedin) {
        $("#loginFacebook").fadeIn(50).css('border', 'none');
        $("#loginFacebook").css('margin-top','22px');
  }
});

$("#searchTags").focus(function(){
  if (!userloggedin) {
        $("#loginFacebook").fadeIn(50).css('border', '10px solid #1cff2c');
        $("#loginFacebook").css('borderRadius','10px');
        $("#loginFacebook").css('margin-top','22px');
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


          //display ratings
            // $(".draggable").mousedown(function() {
            //     $(this).find(".speechBubble").fadeIn(1000).delay(50).fadeOut(2500);
            //     $(this).find(".ratings").fadeIn(1000).delay(50).fadeOut(2500);
            //     return;
            // });




                       //make green arrow appear
  //                 $(function() {

  //                     if (!$("#rateNowButton").hasClass('disabled')) {
  //   return;
  // }  
  //                     $(".draggable").click(function() {
  //                         $("#arrowUp").fadeIn(2000);
  //                     });
  //                     $(".draggable").hover(function() {
  //                         $("#arrowUp").fadeIn(2000);
  //                     });



  //                     $("#rateNowButton").click(function() {
  //                         $("#arrowUp").fadeIn(2000);
  //                     });
  //                     $("#rateNowButton").click(function() {
  //                         $("#arrowUp").fadeOut(600);
  //                     });
  //                     $("loginFacebook").click(function() {
  //                         $("#arrowUp").fadeOut(100);
  //                     });
  //                     $("#rateNowButton").hover(function() {
  //                         $("#arrowUp").fadeOut(200);
  //                     });
  //                   });

             // draggable within a box and others
            $(function() {
              // was 
              // if (userloggedin) {
              if (true) {
              $(".draggable").draggable({ containment: "#containmentWrapper" });
            } 
              });


 $("#hide").click(function(){
  $("#filters").hide();
  $("#show").show();  
  $("#hide").hide(); 
});

$("#show").click(function(){
  $("#filters").show();
  $("#hide").show();  
  $("#show").hide(); 
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

$(document).ready(function() {

  $(".textRatingBall").each(function(){

  xPosition = (Math.round(($(this).attr('xposition') * 100)));
  yPosition = (100-(Math.round(($(this).attr('yposition') * 100))));
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
  

$(function(){ $(document).foundation(); });
