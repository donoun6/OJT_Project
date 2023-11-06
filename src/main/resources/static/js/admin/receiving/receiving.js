$(document).ready(function () {
    let data = {
        startDate: "N",
        endDate: "N",
        option: "N",
        checkName: "Y",
        name: "",
        order: ""
    }

    /**
     * 기본 전체 조회
     */
    $(".all-search").click(function () {
        data = {
            startDate: "N",
            endDate: "N",
            option: "N",
            checkName: "Y",
            name: "",
            order: ""
        }
        receivingList(data);
    });

    /**
     * 기간 조회
     */
    $(".date-search").click(function () {
        if ($("#startDate").val() != "" && $("#endDate").val() != "") {
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            receivingList(data);
        }
    });

    /**
     * 품명 or 입고번호 조회
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

        data.option = $("select").val();
        data.checkName = checkName;
        data.name = name;
        receivingList(data);
    });

    $(".trigger-btn").click(function (){
        receivingList(data);
    })

    /**
     * 입고일자별 정렬
     */
    $(".order").click(function () {
        data.order = this.getAttribute('id');
        receivingList(data);
    });

    /**
     * 입고 취소처리
     */
    $(document).on("click", ".receiving-cancel-btn", function (){
        const url = "/api/receiving";
        let data = {
            quantity: $(this).next().val() * -1,
            productId: $(this).next().next().val(),
            receivingId: $(this).next().next().next().val(),
            description: '입고번호 : ' + $(this).val() + ' 취소 처리'
        }
        Cancel(data, url);
    });

    /**
     * receiving list HTML 출력 Ajax
     * @param data
     */
    function receivingList(data) {
        $.ajax({
            async: true,
            type: 'GET',
            data: data,
            url: 'receiving/receiving-list',
            dataType: 'html',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                $(".receiving-list").html(data);
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
            }
        });
    }

    /**
     * Delete Method Ajax
     * @param data
     * @param url
     * @constructor
     */
    function Cancel(data, url) {
        $.ajax({
            async: true,
            type: 'DELETE',
            data: JSON.stringify(data),
            url: url,
            dataType: 'json',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                alert("취소 처리 완료");
                $(".trigger-btn").trigger("click");
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
            }
        });
    }

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
     * mouse event handler
     */
    // mouseover 이벤트 핸들러
    $(".receiving-list").on("mouseover", ".product-hover", function () {
        $(this).children().css("font-weight", "bold");
    });
    // mouseout 이벤트 핸들러
    $(".receiving-list").on("mouseout", ".product-hover", function () {
        $(this).children().css("font-weight", "normal");
    });

});
