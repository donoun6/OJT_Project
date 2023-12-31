$(function () {

    $(".alarm").click(function () {
        if ($(".low-quantity-box").hasClass("on")) {
            $(".low-quantity-box").removeClass("on");
        } else {
            $(".low-quantity-box").addClass("on");
        }
    });

    $(document).ready(function () {

        $(".date-search").click(function () {
            let data = {
                startDate: $("#startDate").val(),
                endDate: $("#endDate").val()
            }
            rankList(data);
            chartList(data);
        });

        function rankList(data) {
            $.ajax({
                async: true,
                type: 'GET',
                data: data,
                url: "admin/rank-list",
                dataType: 'html',
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    $(".rank-list").html(data);
                },
                error: function (data) {
                    alert("잠시후 다시 시도해 주세요");
                }
            });
        }

        function chartList(data) {
            $.ajax({
                async: true,
                type: 'GET',
                data: data,
                url: "admin/chart-list",
                dataType: 'html',
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    $("#section3").html(data);
                },
                error: function (data) {
                    alert("잠시후 다시 시도해 주세요");
                }
            });
        }

    });
});