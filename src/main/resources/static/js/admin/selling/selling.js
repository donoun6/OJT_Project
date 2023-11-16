$(document).ready(function () {
    total();

    const sellingListUrl = "selling/selling-list";

    $('#startDate').datepicker("setDate", "today");
    $('#endDate').datepicker("setDate", "today");

    let data = {
        bundle: "N",
        startDate: $("#startDate").val(),
        endDate: $("#endDate").val(),
        checkName: "Y",
        name: "",
        order: ""
    }

    /**
     * 기본 전체 조회
     */
    $(".all-search").click(function () {
        data = {
            bundle: "N",
            startDate: $("#startDate").val(),
            endDate: $("#endDate").val(),
            checkName: "Y",
            name: "",
            order: ""
        }
        sellingList(data, sellingListUrl);
    });

    /**
     * 기간 조회
     */
    $(".date-search").click(function () {
        if ($("#startDate").val() != "" && $("#endDate").val() != "") {
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            sellingList(data, sellingListUrl);
        }
    });

    /**
     * 품명 조회
     */
    $(".search-name").keyup(function () {
        let checkName = 'Y';
        let name = $(this).val().toUpperCase();
        let concatName = choHangul($(this).val());

        //초성검색 구분
        if (name != "" && concatName == "") {
            checkName = 'Y';
        } else {
            checkName = 'N';
        }

        data.checkName = checkName;
        data.name = name;
        sellingList(data, sellingListUrl);
    });

    /**
     * product list 조건 순서 정렬
     */
    $(".order").click(function () {
        spl = this.getAttribute('id').split('-');
        data.col = spl.at(0);
        data.order = spl.at(1);
        sellingList(data, sellingListUrl);
    });

    $(".bundle-btn").click(function () {
        data.bundle = "Y";
        sellingList(data, sellingListUrl);
    });

    /**
     * Selling-List ajax html 호출
     */
    function sellingList(data, url) {
        $.ajax({
            async: true,
            type: 'GET',
            data: data,
            url: url,
            dataType: 'html',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                $(".selling-list").html(data);
                total();
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
            }
        });
    }

    /**
     * mouse event handler
     */
    // mouseover 이벤트 핸들러
    $(".selling-list").on("mouseover", ".product-hover", function () {
        $(this).children().css("font-weight", "bold");
    });
    // mouseout 이벤트 핸들러
    $(".selling-list").on("mouseout", ".product-hover", function () {
        $(this).children().css("font-weight", "normal");
    });

    /**
     * 초성 추출
     */
    function choHangul(str) {
        cho = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
        result = "";
        for (i = 0; i < str.length; i++) {
            code = str.charCodeAt(i) - 44032;
            if (code > -1 && code < 11172) result += cho[Math.floor(code / 588)];
        }
        return result;
    }

    /**
     * total
     */
    function total() {
        $(document).ready(function () {
            let totalQuantity = 0;
            let totalPrice = 0;

            let spl = $(".add-quantity").text().split("EA");
            let spl2 = $(".add-price").text().split("원");

            for (let i = 0; i < spl.length; i++) {
                totalQuantity += Number(spl.at(i));
                totalPrice += Number(spl2.at(i).replace(",", ""));
            }

            totalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

            $(".total-quantity").text(totalQuantity + "EA");
            $(".total-price").text(totalPrice + "원")
        });
    }

});