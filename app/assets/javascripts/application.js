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
   function() { $(this).focus().css('outline','1px solid #fff'); },
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

//画像プレビュー
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
 	$('.post_image').on('change', function (e) {
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
		  $(".profile_image").attr('src', e.target.result);
		}
  	reader.readAsDataURL(e.target.files[0]);
  });
});

//ハンバーガー機能
$(function() {
    $('.hamburger').click(function() {
        $(this).toggleClass('active');

        if ($(this).hasClass('active')) {
            $('.globalMenuSp').addClass('active');
        } else {
            $('.globalMenuSp').removeClass('active');
        }
    });
});


//ページ読み込みアニメーション
 $(function() {
 var h = $(window).height();
  $('#loading__wrapper').css('display','none');
  $('#is-loading ,#loading').height(h).css('display','block');
 });

 $(window).load(function () {
  $('#is-loading').delay(900).fadeOut(800);
  $('#loading').delay(600).fadeOut(300);
  $('#loading__wrapper').css('display', 'block');
 });


 $(function(){
  setTimeout('stopload()',10000);
  });

  function stopload(){
   $('#loading__wrapper').css('display','block');
   $('#is-loading').delay(900).fadeOut(800);
   $('#loading').delay(600).fadeOut(300);
 }

//Google Map
let map
let geocoder

$(function initMap(){
  geocoder = new google.maps.Geocoder()
  let map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 21.48980368260301, lng: -157.98798511107822},
  zoom: 10
  });
});

$(function codeAddress(){
  // 入力を取得
  let inputAddress = document.getElementById('address').value;

  // geocodingしたあとmapを移動
  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
　　　　　　　　　　　　// map.setCenterで地図が移動
      map.setCenter(results[0].geometry.location);

　　　　　　　　　　　　// google.maps.MarkerでGoogleMap上の指定位置にマーカが立つ
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
})