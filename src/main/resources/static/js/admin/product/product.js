$(function () {
    /**
     * 문서 객체 모델(DOM)이 완전히 로드된 후 스크립트가 실행
     */
    $(document).ready(function() {
        //************ PRODUCT EVENT FUNCTION ************//
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
         * product list 조건 순서 정렬
         */
        $(".order").click(function (){
            spl = this.getAttribute('id').split('-');
            data.col = spl.at(0);
            data.order = spl.at(1);
            productList(data);
        });

        /**
         * product list 조건 검색
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
         * pop-up display
         */
        $(".save-btn").click(function () {
            $(".product-save-from-wrap").css("display","flex");
        });
        $(".product-save-cancel-btn").click(function () {
            $(".product-save-from-wrap").css("display","none");
        });

        /**
         * 초성 추출
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
         * mouse event handler
         */
        // mouseover 이벤트 핸들러
        $(".product-list").on("mouseover", ".product-hover", function() {
            $(this).children().css("font-weight", "bold");
        });
        // mouseout 이벤트 핸들러
        $(".product-list").on("mouseout", ".product-hover", function() {
            $(this).children().css("font-weight", "normal");
        });

        //************ CATEOGRY EVENT FUNCTION ************//
        /**
         * 카테고리 리스트 출력
         */
        $(".category").click(function (){
            $.ajax({
                async: true,
                type: 'GET',
                url: '/api/category',
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    for (let i = 0; i < data.length; i++) {
                        if($("option").hasClass("cate"+data[i].categoryId)){
                            continue;
                        }else {
                            $(".category").append('<option class="cate'+data[i].categoryId+'" value="' +data[i].categoryId+ '">'+ data[i].name+ '</option>');
                        }
                    }
                },
                error: function (data) {
                    alert("잠시후 다시 시도해 주세요");
                }
            });
        });

        /**
         * 카테고리 save form 출력
         */
        $(".category-save").click(function () {
            $(".category-form-wrap").css("display","flex");
            $.ajax({
                async: true,
                type: 'GET',
                url: '/category/save',
                dataType: 'html',
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    $('.category-form-wrap').html(data);
                },
                error: function (data) {
                    alert("잠시후 다시 시도해 주세요");
                }
            });
        });

        /**
         * 카테고리 추가 from
         */
        $(document).on("click", ".category-save-btn", function () {
            let data = {
                "name" : $(".categoryName").val(),
            };
            $.ajax({
                async: true,
                type: 'POST',
                data: JSON.stringify(data),
                url: '/api/category',
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                success: function (data) {
                    $(".category-form-wrap").css("display", "none");
                    $(".save-btn").trigger("click");
                },
                error: function (data) {
                    alert("잠시후 다시 시도해 주세요");
                }
            });
        });

        /**
         * 카테고리 삭제처리
         */
        $(document).on("click", ".category-delete", function () {
            let cateogryId = $(this).val();

            $(".category-delete-from-wrap").css("display","flex");
            $(".category-delete-btn").click(function () {
                $.ajax({
                    type: 'DELETE',
                    url: '/api/category/'+cateogryId,
                    dataType: 'json',
                    success: function (data) {
                        $(".category-delete-from-wrap").css("display","none")
                        $(".select-search").trigger("click");
                    },
                    error: function (data) {
                        alert("잠시후 다시 시도해 주세요");
                    }
                });
            });
        });

        /**
         * pop-up display
         */
        $(".category-delete-cancel-btn").click(function (){
            $(".category-delete-from-wrap").css("display","none")
        });
        $(document).on("click", ".category-save-cancel-btn", function () {
            $(".category-form-wrap").css("display", "none");
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
         * start/end date picker
         */
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

