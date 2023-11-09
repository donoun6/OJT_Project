$(function () {

    $(".alarm").click(function () {
        if ($(".low-quantity-box").hasClass("on")) {
            $(".low-quantity-box").removeClass("on");
        } else {
            $(".low-quantity-box").addClass("on");
        }
    });
});