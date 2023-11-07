$(document).ready(function () {
    const receivingListUrl = "receiving/receiving-list";
    const url = "/api/receiving";

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
        receivingList(data, receivingListUrl);
    });

    /**
     * 기간 조회
     */
    $(".date-search").click(function () {
        if ($("#startDate").val() != "" && $("#endDate").val() != "") {
            data.startDate = $("#startDate").val();
            data.endDate = $("#endDate").val();
            receivingList(data, receivingListUrl);
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
        receivingList(data, receivingListUrl);
    });

    $(".trigger-btn").click(function () {
        receivingList(data, receivingListUrl);
    })

    /**
     * 입고일자별 정렬
     */
    $(".order").click(function () {
        data.order = this.getAttribute('id');
        receivingList(data, receivingListUrl);
    });

    /**
     * 입고 취소처리
     */
    $(document).on("click", ".receiving-cancel-btn", function () {
        let data = {
            quantity: $(this).next().val() * -1,
            productId: $(this).next().next().val(),
            receivingId: $(this).next().next().next().val(),
            description: '입고번호 : ' + $(this).val() + ' 취소 처리'
        }
        Cancel(data, url);
    });

    $(".save-btn").click(function () {
        $(".receiving-save-form-wrap").css("display", "flex");
        $(".receiving-save-form").css("display", "flex");
    });


    //입고 등록 category 별 product 출력 area
    /**
     * 카테고리 별 product List 출력
     */
    $(document).on("change", ".select-category", function () {
        let data = {
            "category": $(this).val(),
            "checkName": "Y",
            "name": "",
            "productDeleteCheck": "N",
            "categoryDeleteCheck": "N",
            "startRegisterDate": "",
            "endRegisterDate": "",
            "col": "",
            "order": ""
        }
        productList(data);
    });

    /**
     * list 클릭 해당 product id를 가져옴
     */
    let productId;
    $(".category-list").on("click", ".category-hover", function () {
        $(this).closest(".category-list").children("tr").children("td").css("color", "black")
        $(this).children().css("color", "red");
        productId = $(this).children("input").val();
    });

    /**
     * 아이템 선택 후 다음단계 display on
     */
    $(".category-select-next").click(function () {
        if (productId != null) {
            $(".receiving-save-form").css("display", "none");
            $(".receiving-save-form2").css("display", "flex");
        }
    });

    /**
     * 취소버튼 누를시 pop-up 종료
     */
    $(".category-select-cancel").click(function () {
        $(".receiving-save-form-wrap").css("display", "none");
        $(".receiving-save-form2").css("display", "none");
    });

    /**
     * 입고 등록
     */
    $(".category-select-last").click(function () {
        let data = {
            quantity: $(".quantity").val(),
            productId: productId,
            description: $(".description").val()
        }
        save(data, url);
    });

    /**
     * receiving list HTML 출력 Ajax
     */
    function receivingList(data, url) {
        $.ajax({
            async: true,
            type: 'GET',
            data: data,
            url: url,
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
     * 입고 등록
     */
    function save(data, url) {
        $.ajax({
            async: true,
            type: 'POST',
            data: JSON.stringify(data),
            url: url,
            dataType: 'json',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                alert("입고 완료");
                $(".receiving-save-form-wrap").css("display", "none");
                $(".receiving-save-form2").css("display", "none");
                $(".receiving-save-form1").css("display", "flex");
                $(".quantity").val(null);
                $(".description").val(null);
                $(".trigger-btn").trigger("click");
            },
            error: function (data) {
                alert("잠시후 다시 시도해 주세요");
            }
        });
    }

    /**
     * 카테고리별 product 출력
     * @param data
     */
    function productList(data) {
        $.ajax({
            async: true,
            type: 'GET',
            data: data,
            url: 'receiving/product-list',
            dataType: 'html',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                $('.category-list').html(data);
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

    $(".category-list").on("mouseover", ".category-hover", function () {
        $(this).children().css("font-weight", "bold");
    });
    // mouseout 이벤트 핸들러
    $(".category-list").on("mouseout", ".category-hover", function () {
        $(this).children().css("font-weight", "normal");
    });

});
