var setDatePicker = function( target ) {
    target.each(function() {
        $(this).kendoDatePicker({
            culture : "ko-KR",
            format : "yyyy-MM-dd",
        });

        var date = new Date();
        $(this).val(formatDate('yyyy-MM-dd', date));

        $(this).kendoMaskedTextBox({
            mask : '0000-00-00'
        });
    });
}

var formatDate = function( format, source ) {
    /* 사용포맷 : yyyy, yy, MM, dd, E, hh, mm, ss, a/p */
    var fullWeekName = [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ];
    var weekName = [ '일', '월', '화', '수', '목', '금', '토' ];

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
                return source.getHours() < 12 ? '오전' : '오후';
        }
    });

    return result;
}