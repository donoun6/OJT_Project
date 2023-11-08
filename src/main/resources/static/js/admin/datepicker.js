$(function () {
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
