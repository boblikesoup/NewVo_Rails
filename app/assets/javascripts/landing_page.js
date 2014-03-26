window.onload=function(){


(function cycle(index, el) {
  var $el = el,
      currentIndex = index % 3 + 1,
      currentPhoto = 'assets/landing_page/iphone-' + currentIndex + '.jpg';

  $el.attr('src', currentPhoto )
  setTimeout(function() {
      cycle(currentIndex, $el);
  }, 5000);
})(0, $('.iphone-image'));

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
