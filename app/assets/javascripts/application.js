// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

//画像スライダー
window.addEventListener('DOMContentLoaded', function() {
  var swiper03 = new Swiper('.swiper .swiper-container', {
    pagination: '.swiper-pagination',
    paginationClickable: true,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    loop: true,
    slidesPerView: 3,
    speed: 1000,
    centeredSlides : true,
    slideToClickedSlide: true,
    spaceBetween: 10,
    breakpoints: {
      543: {
        slidesPerView: 3
      }
    }
  });
}, false);

//クリッカブルマップ
$(function(){
  $('img[usemap]').rwdImageMaps();
});

$(function(){
  $('area').hover(
   function() { $(this).focus().css('outline','10px solid #fff'); },
   function() { $(this).blur().css('outline','none'); }
  )
});

//ページ内リンクで特定の場所までスムーススクロールさせる
$(function(){
  $('a[href^="#"]').click(function() {
    var speed = 950;
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $('body,html').animate({scrollTop:position}, speed, 'swing');
    return false;
  });
});

//Q&Aアコーディオン機能
$(function(){
  $('.question-list-item').click(function() {
    var $answer = $(this).find('.answer');
    if($answer.hasClass('open')) {
      $answer.removeClass('open');
      $answer.slideUp();
      $(this).find("span").text("＋");
    } else {
      $answer.addClass('open');
      $answer.slideDown();
      $(this).find("span").text("ー");
    };
  });
});

$(function(){
 	$('#post_image').on('change', function (e) {
 		var reader = new FileReader();
		reader.onload = function (e) {
		  $(".image").attr('src', e.target.result);
		}
  	reader.readAsDataURL(e.target.files[0]);
  });
});

$(function(){
 	$('#edit-profile_image').on('change', function (e) {
 		var reader = new FileReader();
		reader.onload = function (e) {
		  $(".profile_image_id").attr('src', e.target.result);
		}
  	reader.readAsDataURL(e.target.files[0]);
  });
});