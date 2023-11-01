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
    $(".material-symbols-outlined").click(function (){
        spl = this.getAttribute('id').split('-');
        data.col = spl.at(0);
        data.order = spl.at(1);
        console.log(data);
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

