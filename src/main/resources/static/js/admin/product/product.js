$(function () {
    let data = {
        "category" : "all",
        "checkName" : "Y",
        "name" : "",
        "productDeleteCheck" : "N",
        "categoryDeleteCheck" : "N",
        "startRegisterDate" : "",
        "endRegisterDate" : "",
        "col" : "",
        "order" : ""
    }

    /**
     * 기본 전체 조회
     */
    $(".all-search").click(function () {
        data = {
            "category" : "all",
            "checkName" : "Y",
            "name" : "",
            "productDeleteCheck" : "N",
            "categoryDeleteCheck" : "N",
            "startRegisterDate" : "",
            "endRegisterDate" : "",
            "col" : "",
            "order" : ""
        }
        productList(data);
    });

    /**
     * 선택 조건 검색
     */
    $(".select-search").click(function () {
        data.category = $(".select-category").val();
        data.productDeleteCheck = $(".product-delete-check:checked").val();
        data.categoryDeleteCheck = $(".category-delete-check:checked").val();
        data.startRegisterDate = $("#startDate").val();
        data.endRegisterDate = $("#endDate").val();

        productList(data);
    });

    /**
     * 제품 이름 검색 + 조건 검색
     */
    $(".search-name").keyup(function () {
        let checkName = 'Y';
        let name = $(this).val().toUpperCase();
        let concatName = choHangul($(this).val());

        //초성검색 구분
        if (name!="" && concatName==""){
            checkName = 'Y';
        }else{
            checkName = 'N';
        }

        data.category = $(".select-category").val();
        data.checkName = checkName;
        data.name = name;
        data.productDeleteCheck = $(".product-delete-check:checked").val();
        data.categoryDeleteCheck = $(".category-delete-check:checked").val();
        data.startRegisterDate = $("#startDate").val();
        data.endRegisterDate = $("#endDate").val();

        productList(data);
    });

    /**
     * 조건에 맞는 순서 정렬
     */
    $(".order").click(function (){
        spl = this.getAttribute('id').split('-');
        data.col = spl.at(0);
        data.order = spl.at(1);
        productList(data);
    });

    /**
     * product list 조건 검색
     * @param data
     */
    function productList(data) {
        $.ajax({
            async: true,
            type: 'GET',
            data: data,
            url: 'product/product-list',
            dataType: 'html',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                $('.product-list').html(data);
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
            }
        });
    }

    /**
     * 초성 추출
     * @param str
     * @returns {string}
     */
    function choHangul(str) {
        cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
        result = "";
        for(i=0;i<str.length;i++) {
            code = str.charCodeAt(i)-44032;
            if(code>-1 && code<11172) result += cho[Math.floor(code/588)];
        }
        return result;
    }

    /**
     * display 속성 변경
     */
    $(".save-btn").click(function () {
        $(".product-save-from-wrap").css("display","flex");
    });
    $(".product-save-cancel-btn").click(function () {
        $(".product-save-from-wrap").css("display","none");
    });

    /**
     * up/down slide animation
     */
    $(".up-slide-box").mouseover(function () {
        $(".up-slide").addClass("up-slide-on");
    });
    $(".up-slide-box").mouseout(function () {
        $(".up-slide").removeClass("up-slide-on");
    });

    $(".down-slide-box").mouseover(function () {
        $(".down-slide").addClass("down-slide-on");
    });
    $(".down-slide-box").mouseout(function () {
        $(".down-slide").removeClass("down-slide-on");
    });

    $(".up-slide-box").click(function () {
        $(".up-slide-box").stop().animate({ opacity : "0" },500,"easeInExpo");
        $(".section1").stop().animate({ marginTop : "-22%" },600,"easeInExpo");
        $(".section2").stop().animate({ height : "100%" },600,"easeInExpo");
        $(".down-slide-box").stop().animate({ top : "-2%" },500,"easeInExpo");
    });
    $(".down-slide-box").click(function () {
        $(".up-slide-box").stop().animate({ opacity : "1" },600,"easeInExpo");
        $(".section1").stop().animate({ marginTop : "0" },600,"easeInExpo");
        $(".section2").stop().animate({ height : "58%" },600,"easeInExpo");
        $(".down-slide-box").stop().animate({ top : "-10%" },500,"easeInExpo");
    });

    /**
     * datepicker 기간 선택
     */
    $(document).ready(function () {
        $("#startDate").datepicker({
            dateFormat: "yy-mm-dd", // 날짜의 형식
            nextText: ">",
            prevText: "<",
            onSelect: function (date) {
                var endDate = $('#endDate');
                var startDate = $(this).datepicker('getDate');
                var minDate = $(this).datepicker('getDate');
                endDate.datepicker('setDate', minDate);
                startDate.setDate(startDate.getDate() + 30);
                endDate.datepicker('option', 'minDate', minDate);
            }
        });
        $('#endDate').datepicker({
            dateFormat: "yy-mm-dd", // 날짜의 형식
            nextText: ">",
            prevText: "<"
        });
    });

});

