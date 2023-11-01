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

    // $(".product-save-btn").click(function () {
    //     let allData = {
    //         "categoryId" : $(".category").val(),
    //         "name": $(".product-name").val(),
    //         "code": $(".product-code").val(),
    //         "sellPrice": $(".product-sellPrice").val(),
    //     }
    //     $.ajax({
    //         type: 'POST',
    //         url: '/api/product/save',
    //         data: JSON.stringify(allData),
    //         contentType: "application/json; charset=utf-8",
    //         dataType: 'json',
    //         success: function (resp) {
    //             console.log(resp);
    //             alert("상품이 등록 되었습니다.")
    //             $(".product-save-from-wrap").css("display","none");
    //         },
    //         error: function (request, status, error) {
    //             console.log("code: " + request.status)
    //             console.log("message: " + request.responseText)
    //             console.log("error: " + error);
    //             alert("잠시후 다시 시도해 주세요");
    //             $(".product-save-from-wrap").css("display","none");
    //         }
    //     });
    // });

    $(".product-save-btn").click(function () {
        let form = $("#productForm");
        let formData = new FormData(form);

        $.ajax({
            async: true,
            type: 'POST',
            data: formData,
            url: '/api/product/save',
            contentType: false,
            processData: false,
            success: function (resp) {
                alert("상품이 등록 되었습니다.")
                console.log(resp)
                window.location.replace("/");
                $(".product-save-from-wrap").css("display","none");
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
                $(".product-save-from-wrap").css("display","none");
            }
        });
    });


    $(".product-save-").click(function () {
        $(".product-save-from-wrap").css("display","none");
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

