$(function () {

    $(".all-search").click(function () {
        let data = {
            "category" : "all"
        }
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
    });

    $(".select-search").click(function () {
        let category = $(".select-category").val();

        let data = {
            "category" : category
        }
        console.log(data);
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
    });

    $(".search-name").keyup(function () {
        let category = $(".select-category").val();

        let name = $(this).val().toUpperCase();
        let concatName = choHangul($(this).val());

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
        }
        console.log(data);
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
    });

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

