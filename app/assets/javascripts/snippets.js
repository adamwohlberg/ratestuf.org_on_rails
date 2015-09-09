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