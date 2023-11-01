$(function () {

    //aside slide
    $(".arrow-back-ios").click(function () {
        $("aside").stop().animate({ left : "-14%" },500,"easeInExpo");
        $(".logo").stop().animate({ opacity : "0" },500,"easeInExpo");
        $("nav").stop().animate({ opacity : "0" },500,"easeInExpo");
        $(".arrow-back-ios").stop().animate({ opacity : "0" },250,"easeOutExpo");
        $(".arrow-forward-ios").stop().animate({ opacity : "1" , left : "-1.5%"},500,"easeInExpo");
        $("#main-wrap").stop().animate({ marginLeft : "0" , width : "100%" },550,"easeInExpo");
        $(".search-bar").stop().animate({marginBottom: "0.5%"},550,"easeInExpo");
    });

    $(".arrow-forward-ios").click(function () {
        $("aside").stop().animate({ left : "0" },400,"easeInExpo");
        $(".logo").stop().delay(300).animate({ opacity : "1" },500,"easeInExpo");
        $("nav").stop().animate({ opacity : "1" },500,"easeInExpo");
        $(".arrow-back-ios").stop().animate({ opacity : "1" },450,"easeInExpo");
        $(".arrow-forward-ios").stop().animate({ opacity : "0" , left : "-3%"},500,"easeInExpo");
        $("#main-wrap").stop().animate({ marginLeft : "13%" , width : "87%" },400,"easeInExpo");
        $(".search-bar").stop().delay(300).animate({marginBottom: 0});
    });

});