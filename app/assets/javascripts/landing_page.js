window.onload=function(){

// slideShow = function(){
//   for (i=0; i<5; i++) {
//     $('.caption').empty().delay().append(" " + i);
//   }
// };

var slideshowArray = [
  "Never mismatch your clothes again.",
  "Before your meeting, know whether your outfit hits the casual/formal sweet spot",
  "Before and after of post, showing implementation of feedback",
  "Meeting my boyfriends parents. Help!",
  "What do you think of my homemade outfit???",
  "Is this appropriate for a funeral?"
  ];

(function cycle(index) {
    var text = slideshowArray[index];
    $('.caption').empty().append(text);
    delete slideshowArray[index];
    slideshowArray.push(text);
    setTimeout(function() {
        cycle(index + 1);
    }, 5000);
})(0);

  // slideShow = function(){
  //   $.each(slideshowArray, function(index, value){
  //     $(".slide").attr("src", value[0]);
  //     $("body").attr("background-image", value[1]);
  //     $(".caption").remove().append(value[2]);
  //     setInterval(function(){
  //       console.log("i am caption");
  //     },3000);
  //     $(".caption").remove(value[2]);
  //     if (index === (slideshowArray.length-1)){
  //       slideShow();
  //     };
  //   });
  // };

  // slideShow();
};