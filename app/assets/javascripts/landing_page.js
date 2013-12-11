window.onload=function(){



var textArray = [
  "Do these match?",
  "First date.  Want to look sexy!!",
  "Programming interview in SF, does this meet the casual/formal sweet spot?",
  "Meeting my boyfriends parents. Help!",
  "What do you think of my homemade outfit???",
  "Is this appropriate for a funeral?"
  ];

(function cycle(index) {
    var text = textArray[index];
    $('.caption').empty().append(text);
    delete textArray[index];
    textArray.push(text);
    setTimeout(function() {
        cycle(index + 1);
    }, 5000);
})(0);

  // Related to rotating pictures.  Need array of images.

  // slideShow = function(){
  //   for (i=0; i<5; i++) {
  //     $('.caption').empty().delay().append(" " + i);
  //   }
  // };
  // slideShow = function(){
  //   $.each(textArray, function(index, value){
  //     $(".slide").attr("src", value[0]);
  //     $("body").attr("background-image", value[1]);
  //     $(".caption").remove().append(value[2]);
  //     setInterval(function(){
  //       console.log("i am caption");
  //     },3000);
  //     $(".caption").remove(value[2]);
  //     if (index === (textArray.length-1)){
  //       slideShow();
  //     };
  //   });
  // };

  // slideShow();
};
