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
//= require underscore
//= require gmaps/google
//= require_tree .

//画像スライダー
window.addEventListener("DOMContentLoaded", function() {
  var swiper03 = new Swiper(".swiper .swiper-container", {
    pagination: ".swiper-pagination",
    paginationClickable: true,
    nextButton: ".swiper-button-next",
    prevButton: ".swiper-button-prev",
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
  $("img[usemap]").rwdImageMaps();
});

$(function(){
  $("area").hover(
   function() { $(this).focus().css("outline","1px solid #fff"); },
   function() { $(this).blur().css("outline","none"); }
  )
});

//ページ内リンクで特定の場所までスムーススクロールさせる
$(function(){
  $('a[href^="#"]').click(function() {
    var speed = 950;
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? "html" : href);
    var position = target.offset().top;
    $("body,html").animate({scrollTop:position}, speed, "swing");
    return false;
  });
});

//Q&Aアコーディオン機能
$(function(){
  $(".question-list-item").click(function() {
    var $answer = $(this).find(".answer");
    if($answer.hasClass("open")) {
      $answer.removeClass("open");
      $answer.slideUp();
      $(this).find("span").text("＋");
  } else {
      $answer.addClass("open");
      $answer.slideDown();
      $(this).find("span").text("ー");
    };
  });
});

//画像プレビュー
$(function() {
  $(".preview_image").on("change", function (e) {
 	  var previewImage;
 	  if ($(".image")){
 	      previewImage = $(".image");
 	  }else{
 	    previewImage = $(".profile_image");
 	  }
 		var reader = new FileReader();
		reader.onload = function (e) {
		  previewImage.attr("src", e.target.result);
		}
  	reader.readAsDataURL(e.target.files[0]);
  });
});

//top画面のページ読み込み中アニメーション
 $(function() {
 var h = $(window).height();
  $("#loading__wrapper").css("display","none");
  $("#is-loading ,#loading").height(h).css("display","block");
 });

 $(window).load(function () {
  $("#is-loading").delay(1200).fadeOut(1100);
  $("#loading").delay(900).fadeOut(900);
  $("#loading__wrapper").css("display", "block");
 });

 $(function(){
  setTimeout("stopload()",10000);
  });

  function stopload(){
   $("#loading__wrapper").css("display","block");
   $("#is-loading").delay(1200).fadeOut(1100);
   $("#loading").delay(900).fadeOut(900);
 }

//Google Map
let map;
let geocoder;

function initMap(){
  geocoder = new google.maps.Geocoder() //GoogleMapsAPIジオコーディングサービスにアクセス
  if(document.getElementById("map")){ //"map"というidを取得できたら実行
    map = new google.maps.Map(document.getElementById("map"), { //"map"というidを取得してマップを表示
      center: {lat: 21.48980368260301, lng: -157.98798511107822}, //最初に表示する場所
      zoom: 10 //拡大率（1〜21まで設定可能）
  });
  
}else if(document.getElementById("edit_map")){ //"map"というidが無かった場合
    map = new google.maps.Map(document.getElementById("edit_map"), { //"edit_map"というidを取得してマップを表示
      center: {lat: gon.lat, lng: gon.lng}, //controllerで定義した変数を緯度・経度の値とする（値はDBに入っている）
      zoom: 10,
  });
  $(".search_button").click();
  
}else{ //"map, edit_map"というidが無かった場合
    map = new google.maps.Map(document.getElementById("show_map"), { //"show_map"というidを取得してマップを表示
      center: {lat: gon.lat, lng: gon.lng}, //controllerで定義した変数を緯度・経度の値とする（値はDBに入っている）
      zoom: 10,
  });
  $(".search_button").click();
  
marker = new google.maps.Marker({ //GoogleMapにマーカーを落とす
      position:  {lat: gon.lat, lng: gon.lng}, //マーカーを落とす位置を決める（値はDBに入っている）
      map: map //マーカーを落とすマップを指定
    });
  }
}

function codeAddress(){ //コールバック関数
  let inputAddress = document.getElementById("address").value; //"address"というidの値（value）を取得

  geocoder.geocode( { "address": inputAddress}, function(results, status) { //ジオコードしたい住所を引数として渡す
    if (status == "OK") {
      let lat = results[0].geometry.location.lat(); //ジオコードした結果の緯度
      let lng = results[0].geometry.location.lng(); //ジオコードした結果の経度
      let mark = {
          lat: lat, //緯度
          lng: lng  //経度
      };
      map.setCenter(results[0].geometry.location); //最も近い、判読可能な住所を取得したい場所の緯度・経度
      let marker = new google.maps.Marker({
          map: map, //マーカーを落とすマップを指定
          position: results[0].geometry.location //マーカーを落とす位置を決める
      });
    } else {
    }
  });
};

//パスワード可視化
$(function() {
  const pwd = document.getElementById("password");
  const pwdCheck = document.getElementById("password-check");
  pwdCheck.addEventListener("change", function() {
    if(pwdCheck.checked) {
      pwd.setAttribute("type", "text");
    }else{
      pwd.setAttribute("type", "password");
    }
  }, false);
});