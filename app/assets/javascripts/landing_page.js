window.onload=function(){


(function cycle(index, iphoneImg, bg) {
  var $iphoneImg = iphoneImg,
      $bg = bg,
      currentIndex = index % 3 + 1,
      currentPhoto = 'assets/landing_page/iphone-' + currentIndex + '.jpg',
      localhost = 'url(http://localhost:3000/assets/landing_page/background-',
      production = 'url(https://newvo.me/assets/landing_page/background-',
      currentBackground = production + currentIndex + '.jpg)';

  $iphoneImg.fadeTo('fast', 0.7, function(){
    $(this).attr('src', currentPhoto ).fadeTo('slow', 1);
  });
  $bg.css('background-image', currentBackground )
  console.log(currentBackground)
  setTimeout(function() {
      cycle(currentIndex, $iphoneImg, $bg);
  }, 7000);
})(0, $('.iphone-image'), $('.background'));

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
