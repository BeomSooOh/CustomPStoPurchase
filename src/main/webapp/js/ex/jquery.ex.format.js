/**
 * 포맷변환 관련 기능
 */

(function( $ ) {
    /* isnumeric to add comma */
    $.fn.addComma = function() {
        return this.each(function() {
            var source = $(this).val();
            if (source.toString() != '') {
                $(this).val(source.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
            } else {
                $(this).val('0');
            }
        });
    },
    /* string to JSON */
    $.fn.strToJson = function() {
        var source = ($(this).val() || '');

        if (source == '') {
            return {};
        } else {
            try {
                var result;
                result = JSON.parse(source);
                return result;
            } catch (e) {
                return {};
            }
        }
    }
})(jQuery);

/* isnumeric to add comma */
function fnAddComma( source ) {
    try {
        if (source.toString() != '') {
            return source.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        } else {
            return '0';
        }
    } catch (e) {

    }

    return '0';
}

/* code + name */
function fnCodeAndName( code, name ) {
    code = (code || '');
    name = (name || '');

    if (code != '') {
        code = '[' + code + ']';
    } else {
        code = '';
    }

    if (name != '') {
    	// 신재호 수정(수정 이유 : 코드 검색시 앞에 공백 포함되서 조회 안됨)
        name = '' + name;
    } else {
        name = '';
    }

    if (code != '' && name != '') {
        return code + name;
    } else {
        if (code != '' && name == '') {
            return code;
        } else if (code == '' && name != '') {
            return name;
        } else {
            return '';
        }
    }
}

/* javascript date format */
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

/* String date fromat */
function fnFormatStringToDate( format, source ) {
    /* 파라미터 문자열 : ex) 20160101010101 */
    var result = '';
    result = format.replace(/(yyyy|yy|MM|dd|hh|mm|ss|a\/p)/gi, function( key ) {
        switch (key) {
            case 'yyyy': /* yyyy : ex) 2016 >> 년도 */
                if (source.length >= 4) {
                    return source.substr(0, 4);
                } else {
                    return '1900'
                }
            case 'MM': /* MM : 01 >> 월 */
                if (source.length >= 6) {
                    return source.substr(4, 2);
                } else {
                    return '01'
                }
            case 'dd': /* dd : 01 >> 일 */
                if (source.length >= 8) {
                    return source.substr(6, 2);
                } else {
                    return '01'
                }
            case 'hh': /* hh : 00 >> 12시 */
                if (source.length >= 10) {
                    return source.substr(8, 2);
                } else {
                    return '00'
                }
            case 'mm': /* mm : 00 >> 분 */
                if (source.length >= 12) {
                    return source.substr(10, 2);
                } else {
                    return '00'
                }
            case 'ss': /* ss : 00 >> 초 */
                if (source.length >= 14) {
                    return source.substr(12, 2);
                } else {
                    return '00'
                }
        }
    });

    return result;
}

/* jsong string to json object */
function fnFormatStrToJson( source ) {
    if (source == '') {
        return {};
    } else {
        try {
            var result;
            result = JSON.parse(source);
            return result;
        } catch (e) {
            return {};
        }
    }
}

/* string to tel number */
function fnFormatStrToTelNum( source ) {
    source = (source || '');
    source = source.replace(/ /g, '');
    source = source.replace(/\(/g, '');
    source = source.replace(/\)/g, '');
    source = source.replace(/-/g, '');
    source = source.replace(/_/g, '');

    var type = [ {
        form : /^(0(2))(\d{3,4})(\d{4})$/,
        result : "$1-$3-$4"
    }, {
        form : /^(0(3[1-3]))(\d{3,4})(\d{4})$/,
        result : "$1-$3-$4"
    }, {
        form : /^(0(4[1-4]))(\d{3,4})(\d{4})$/,
        result : "$1-$3-$4"
    }, {
        form : /^(0(5[1-5]))(\d{3,4})(\d{4})$/,
        result : "$1-$3-$4"
    }, {
        form : /^(0(6[1-4]))(\d{3,4})(\d{4})$/,
        result : "$1-$3-$4"
    }, {
        form : /^(?:(010)(\d{4}))(\d{4})$/,
        result : "$1-$2-$3"
    }, {
        form : /^(?:(01[1|6|7|8|9])(\d{3,4}))(\d{4})$/,
        result : "$1-$2-$3"
    }, {
        form : /^(070)(\d{3,4})(\d{4})$/,
        result : "$1-$2-$3"
    }, {
        form : /^(070)(\d{3,4})(\d{4})$/,
        result : "$1-$2-$3"
    } ];

    var result = source;
    $.each(type, function( formIdx, formItem ) {
        if (formItem.form.test(source)) {
            result = (source.replace(formItem.form, formItem.result));
        }
    });

    return result;
}

/* string to address number */
function fnFormatStrToAddrNum( source ) {
    source = (source || '');
    source = source.replace(/ /g, '');
    source = source.replace(/\(/g, '');
    source = source.replace(/\)/g, '');
    source = source.replace(/-/g, '');
    source = source.replace(/_/g, '');

    var form = /^(\d{3})(\d{3})$/;
    if (form.test(source)) {
        return source.replace(form, '$1-$2');
    } else {
        return '';
    }
}

/* 데이터 바인딩 */
function fnSetExpendDispValue( target, value, type ) {
    /* target : info 와 disp 로 구분 */
    /* target : 2모든 element 전달 */

    var code = '';
    var name = '';
    var acct_name = '';
    var acct_code = '';
    var erp_dept_code = '';
    var erp_dept_name = '';
    var erp_pc_code = '';
    var erp_pc_name = '';
    var erp_cc_code = '';
    var erp_cc_name = '';
    
    switch (type.toLowerCase()) {
        case expendType.emp:
            code = ((value.erpEmpSeq == '' ? value.empSeq : value.erpEmpSeq) || '');
            name = ((value.erpEmpName == '' ? value.empName : value.erpEmpName) || '');
            erp_dept_code = (value.erpDeptSeq || '');
            erp_dept_name = (value.erpDeptName || '');
            erp_pc_code = (value.erpPcSeq || '');
            erp_pc_name = (value.erpPcName || '');
            erp_cc_code = (value.erpCcSeq || '');
            erp_cc_name = (value.erpCcName || '');
            break;
        case expendType.dept:
        	erp_dept_code = (value.erpDeptSeq || '');
        	erp_dept_name = (value.erpDeptName || '');
        	break;
        case expendType.pc:
        	erp_pc_code = (value.erpPcSeq || '');
        	erp_pc_name = (value.erpPcName || '');
            break;
        case expendType.cc:
        	erp_cc_code = (value.erpCcSeq || '');
        	erp_cc_name = (value.erpCcName || '');
            break;
        case expendType.summary:
            code = (value.summaryCode || '');
            name = (value.summaryName || '');
            acct_name = (value.drAcctName || '');
            break;
        case expendType.auth:
            code = (value.authCode || '');
            name = (value.authName || '');
            break;
        case expendType.vat:
        	code = (value.vatTypeCode || '');
            name = (value.vatTypeName || '');
        	break;
        case expendType.va:
        	code = (value.vaTypeCode || '');
            name = (value.vaTypeName || '');
        	break;
        case expendType.notax:
        	code = (value.noTaxCode || '');
            name = (value.noTaxName || '');
        	break;
        case expendType.project:
            code = (value.projectCode || '');
            name = (value.projectName || '');
            break;
        case expendType.card:
            code = (value.cardNum || '');
            name = (value.cardName || '');
            break;
        case expendType.partner:
            code = (value.partnerCode || '');
            name = (value.partnerName || '');
            break;
        case expendType.budget:
            code = (value.budgetCode || '');
            name = (value.budgetName || '');
            break;
        case expendType.bizplan:
            code = (value.bizplanCode || '');
            name = (value.bizplanName || '');
            break;
        case expendType.bgacct:
            code = (value.bgacctCode || '');
            name = (value.bgacctName || '');
            break;
        case expendType.exchangeunit:
        	code = (value.exchangeUnitCode || '');
        	name = (value.exchangeUnitName || '');
        	break;
        default:
            code = '';
            name = '';
            break;
    }

    target.each(function() {
        if ($(this).attr('id').indexOf('Info') >= 0) {
            $(this).val(JSON.stringify(value));
        } else if ($(this).attr('id').indexOf('Disp') >= 0) {
        	if( $(this).attr('id') == 'txtExpendCardDispEmp'){
        		$(this).val(fnCodeAndName(code, name));	
        	}else if( $(this).attr('id') == 'txtExpendCardDispDept'){
        		$(this).val(fnCodeAndName(erp_dept_code, erp_dept_name));
        	}else if( $(this).attr('id') == 'txtExpendCardDispPc'){
        		$(this).val(fnCodeAndName(erp_pc_code, erp_pc_name));
        	}else if( $(this).attr('id') == 'txtExpendCardDispCc'){
        		$(this).val(fnCodeAndName(erp_cc_code, erp_cc_name));
        	}else if( $(this).attr('id') == 'txtExpendETaxDispEmp'){ /* 매입전자세금계산서 */
        		$(this).val(fnCodeAndName(code, name));	
        	}else if( $(this).attr('id') == 'txtExpendETaxDispDept'){
        		$(this).val(fnCodeAndName(erp_dept_code, erp_dept_name));
        	}else if( $(this).attr('id') == 'txtExpendETaxDispPc'){
        		$(this).val(fnCodeAndName(erp_pc_code, erp_pc_name));
        	}else if( $(this).attr('id') == 'txtExpendETaxDispCc'){
        		$(this).val(fnCodeAndName(erp_cc_code, erp_cc_name));
        	}else{
        		$(this).val(fnCodeAndName(code, name));
        	}
        } else if ($(this).attr('id').indexOf('DrAcctName') >= 0) {
            $(this).val(fnCodeAndName('', acct_name));
        } else if ($(this).attr('id').indexOf('DeptCode') >= 0) {
            $(this).val(fnCodeAndName('', erp_dept_code));
        } else if ($(this).attr('id').indexOf('DeptName') >= 0) {
            $(this).val(fnCodeAndName('', erp_dept_name));
        } else if ($(this).attr('id').indexOf('ListPcCode') >= 0) {
            $(this).val(fnCodeAndName('', erp_pc_code));
        } else if ($(this).attr('id').indexOf('ListPcName') >= 0) {
            $(this).val(fnCodeAndName('', erp_pc_name));
        } else if ($(this).attr('id').indexOf('ListCcCode') >= 0) {
            $(this).val(fnCodeAndName('', erp_cc_code));
        } else if ($(this).attr('id').indexOf('ListCcName') >= 0) {
            $(this).val(fnCodeAndName('', erp_cc_name));
        } else if ($(this).attr('id').indexOf('Code') >= 0) {
            $(this).val(fnCodeAndName('', code));
        } else if ($(this).attr('id').indexOf('Name') >= 0) {
            $(this).val(fnCodeAndName('', name));
        }

        $(this).trigger('change');
    });
}