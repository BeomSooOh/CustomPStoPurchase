/**
 * 날짜 처리 관련
 */

(function( $ ) {
    $.fn.resetDate = function( addDate ) {
        return this.each(function() {
            var date = new Date();
            addDate = (addDate || '0');
            date.setDate(date.getDate() + (Number(addDate)));
            $(this).val(fnFormatDate('yyyy-MM-dd', date));
        });
    }, $.fn.setKendoDatePicker = function( fnc ) {
        return this.each(function() {
            $(this).kendoDatePicker({
                culture : "ko-KR",
                format : "yyyy-MM-dd",
                change : function() {
                    if (typeof fnc == 'function') {
                        fnc();
                    }

                    return;
                }
            });
        });
    }, $.fn.setKendoDatePickerMask = function() {
        return this.each(function() {
            var datePicker = $(this);
            datePicker.kendoMaskedTextBox({
                mask : '0000-00-00'
            });
            datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');
        })
    }
})(jQuery);

function fnFormatDate( format, source ) {
    /* 사용포맷 : yyyy, yy, MM, dd, E, hh, mm, ss, a/p */
    var fullWeekName = [ NeosUtil.getMessage("TX000006545", "일요일"), NeosUtil.getMessage("TX000006546", "월요일")
                         ,NeosUtil.getMessage("TX000006547", "화요일") , NeosUtil.getMessage("TX000006548", "수요일")
                         ,NeosUtil.getMessage("TX000006549", "목요일"), NeosUtil.getMessage("TX000006550", "금요일")
                         ,NeosUtil.getMessage("TX000000821", "토요일")];
    var weekName = [ NeosUtil.getMessage("TX000003641", "일"), NeosUtil.getMessage("TX000003642", "월")
                     ,NeosUtil.getMessage("TX000000676", "화"), NeosUtil.getMessage("TX000000677", "수")
                     ,NeosUtil.getMessage("TX000000678", "목"), NeosUtil.getMessage("TX000000679", "금")
                     ,NeosUtil.getMessage("TX000000680", "토") ];

    var result = '';
    result = format.replace(/(yyyy|yy|MM|dd|E|e|HH|hh|mm|ss|a\/p)/gi, function( key ) {
        switch (key) {
            case 'yyyy': /* yyyy : ex) 2016 >> 년도 */
                return source.getFullYear();
            case 'yy': /* yy : 16 >> 년도 */
                return ((source.getFullYear() % 1000) % 100);
            case 'MM': /* MM : 01 >> 월 */
                return (source.getMonth() + 1) < 10 ? '0' + (source.getMonth() + 1) : (source.getMonth() + 1);
            case 'dd': /* dd : 01 >> 일 */
                return source.getDate() < 10 ? '0' + source.getDate() : source.getDate();
            case 'E': /* E : 월요일 >> 요일 */
                return fullWeekName[source.getDay()];
            case 'e': /* e : 월 >> 요일 */
                return weekName[source.getDay()];
            case 'HH': /* HH : 00 >> 24시 */
                return source.getHours() < 10 ? '0' + source.getHours() : source.getHours();
            case 'hh': /* hh : 00 >> 12시 */
                return (source.getHours() % 12) < 10 ? '0' + (source.getHours() % 12) : (source.getHours() % 12);
            case 'mm': /* mm : 00 >> 분 */
                return source.getMinutes() < 10 ? '0' + source.getMinutes() : source.getMinutes();
            case 'ss': /* ss : 00 >> 초 */
                return source.getSeconds() < 10 ? '0' + source.getSeconds() : source.getSeconds();
            case 'a/p': /* a/p : 오전 / 오후 */
                return source.getHours() < 12 ? NeosUtil.getMessage("TX000001123", "오전") : NeosUtil.getMessage("TX000001124", "오후");
        }
    });

    return result;
}