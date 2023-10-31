$(function () {

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

    let data = {
        "category" : "all",
        "checkName" : "Y",
        "name" : "",
        "productDeleteCheck" : "N",
        "categoryDeleteCheck" : "N",
        "startRegisterDate" : "",
        "endRegisterDate" : ""
    }

    $(".all-search").click(function () {
        productList(data);
    });

    $(".select-search").click(function () {
        let category = $(".select-category").val();
        let productDeleteCheck = $(".product-delete-check:checked").val();
        let categoryDeleteCheck = $(".category-delete-check:checked").val();
        let startRegisterDate = $("#startDate").val();
        let endRegisterDate = $("#endDate").val();

        let data = {
            "category" : category,
            "checkName" : "Y",
            "name" : "",
            "productDeleteCheck" : productDeleteCheck,
            "categoryDeleteCheck" : categoryDeleteCheck,
            "startRegisterDate" : startRegisterDate,
            "endRegisterDate" : endRegisterDate
        }
        console.log(data)
        productList(data);
    });

    $(".search-name").keyup(function () {
        let category = $(".select-category").val();
        let checkName = 'Y';
        let name = $(this).val().toUpperCase();
        let productDeleteCheck = $(".product-delete-check:checked").val();
        let categoryDeleteCheck = $(".category-delete-check:checked").val();
        let concatName = choHangul($(this).val());
        let startRegisterDate = $("#startDate").val();
        let endRegisterDate = $("#endDate").val();

        //초성검색 구분
        if (name!="" && concatName==""){
            checkName = 'Y';
        }else{
            checkName = 'N';
        }

        let data = {
            "category" : category,
            "checkName" : checkName,
            "name" : name,
            "productDeleteCheck" : productDeleteCheck,
            "categoryDeleteCheck" : categoryDeleteCheck,
            "startRegisterDate" : startRegisterDate,
            "endRegisterDate" : endRegisterDate
        }
        productList(data);
    });

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

    /* 초성추출 */
    function choHangul(str) {
        cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
        result = "";
        for(i=0;i<str.length;i++) {
            code = str.charCodeAt(i)-44032;
            if(code>-1 && code<11172) result += cho[Math.floor(code/588)];
        }
        return result;
    }




});

