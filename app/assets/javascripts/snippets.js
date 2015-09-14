// duplicate to try to get highlighting on mouseover to function more smoothly so when user releases mouse, the javascript tries again to color correctly. remove this and you need to click to get a recoloring.
// $(".draggable").mouseup(function(){

//   xPosition = (Math.round(($(this).position().left / ($(this).parent().width())) * 100));
//   yPosition = (100-(Math.round(($(this).position().top / ($(this).parent().height())) * 100)));
//   UpperLineSlope = 0.8965;
//   yPositionOnUpperLine = ((UpperLineSlope * xPosition) + 25);
//   LowerLineSlope = 0.8977;
//   yPositionOnLowerLine = ((LowerLineSlope * xPosition) + 5);
//   // alert('xposition: ' + xPosition + ', yposition: ' + yPosition + ' yposition of lowerline: ' + yPositionOnLowerLine + ' yposition of upperline: ' + yPositionOnUpperLine);

//   if (yPosition > yPositionOnUpperLine) {
//         $(this).removeClass('bestValue');
//         $(this).removeClass('fairValue');  
//         $(this).addClass('worseValue');
//   }
  
//   if (yPosition <= yPositionOnUpperLine && yPosition >= yPositionOnLowerLine) {
//         $(this).removeClass('worseValue');
//         $(this).removeClass('bestValue');        
//         $(this).addClass('fairValue'); 
//   } 
  
//   if (yPosition < yPositionOnLowerLine) {
//         $(this).removeClass('worseValue');
//         $(this).removeClass('fairValue');  
//         $(this).addClass('bestValue'); 
//   }
// }); 


// ***********************************
// testing code to show the parent element for rating calculations based on position of the dragggable element relative to parent
// $(document).ready(function() {
// $("#rateTableFrame").css('border', '2px solid blue');
// $('.draggable').parent().css('border', '5px solid red');
// });
// $(document).ready(function() {
// $("#containmentWrapper").css('border', '2px solid red');
// // $('.draggable').parent().css('border', '5px solid red');
// });
// ***********************************

// $(function(){ $(document).foundation(); });

	  // testing
	  // alert('item name: '+ item_name);
	  // // alert('item id: '+ item_id);
	  // // alert('container height: '+ ($(this).parent().height() * 0.78 ));
	  // // alert('position from top: '+ positionFromTop);
	  // // alert('container width: '+ ($(this).parent().width() * 0.895962732919255));
	  // // alert('position from left: '+ positionFromLeft);
	  // alert('x_rating: '+ x_rating);
	  // alert('y_rating: ' + y_rating);



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
//         alert("Got it! Thanks for adding your ratings to our database. You are awesome!"
//         location.reload();
//         }
//         // Location.reload(true);
//       },
//       error: function(res) {
//         console.log(res);
//       }
//       ,dataType:'json'});
// }
// $(".draggable").click(function() {
//     $(this).find(".itemName").fadeIn(1000);
//     return;
// });
// $(".draggable").mouseover(function() {
//     $(this).find(".itemName").fadeIn(1000);
//     return;
// });
// $(".draggable").mouseout(function() {
//     $(this).find(".itemName").fadeOut(4000);
//     return;
// });


// $(document).ready(function() {
// 	$(".draggable").click(function(){
// 	  // if (userloggedin) {
// 	    $(".draggable").not(this).removeClass("active");
// 	    $(this).toggleClass("active");
// 	  // }
// 		});
// });

// #TODO prevent refresh after this action
// $(document.body).keyup(function(event) {
//     if (event.keyCode == 46 || event.keyCode == 8) {
//     	  event.preventDefault();
//         $('.active').remove();
//         event.preventDefault();
//     }
// });