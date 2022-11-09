/**
 * datatables, list 관련
 */

(function( $ ) {
    /* dataTable reset */
    $.fn.resetDataTable = function() {
        return this.each(function() {
            $(this).empty();
            var table = document.createElement("table");
            var tableId = $(this).attr("id").toString().replace('div', 'tbl');
            table.setAttribute("id", tableId);
            $(this).append(table);
        });
    }
})(jQuery);

var dataTableLanguage = {
    "lengthMenu" : "보기 _MENU_",
    "zeroRecords" : NeosUtil.getMessage("TX000009638", "데이터가 없습니다"),
    "info" : "_PAGE_ / _PAGES_",
    "infoEmpty" : NeosUtil.getMessage("TX000009638", "데이터가 없습니다"),
    "infoFiltered" : "(전체 _MAX_ 중.)"
};

/* dataTable List count 생성 */
function fnGetListCount( param ) {
    var result = []; 

    $.each(param, function( idx, item ) {
        var code = {}
        if (item == -1 || item == '-1') {
            code.commonName = NeosUtil.getMessage("TX000000862", "전체");
        } else {
            code.commonName = item;
        }

        code.common_code = item;

        result.push(code);
    });

    return result;
}

/* dataTable 기존 바인딩 초기화 */