/**
 * 데이터 변환 및 필수값 확인
 */
(function( $ ) {
    /* string to JOSN */
    $.fn.getJson = function( defaultValue ) {
        defaultValue = (defaultValue || {});
        var jsonString = ($(this).val() || ''); /* get object value */
        if (jsonString != null && jsonString != '') {
            /* string value to json */
            var jsonObject = JSON.parse(jsonString);
            return jsonObject;
        } else {
            return defaultValue;
        }
    },
    /* JSON to string */
    $.fn.setJson = function( value ) {
        return this.each(function() {
            if (typeof value == 'object') {
                $(this).val(JSON.stringify(value));
            } else {
                $(this).val('');
            }
        });
    },
    /* 필수값 체크 */
    $.fn.chkValid = function( validType, subInputData ) {
        /* 비정상 : false 반환 >> if 사용시 "!" 를 붙여 처리 필요 */
        /* 정상 : true 반환 */
        /* 변수정의 */
        var result = true;
        var inputData;

        /* 기본값 적용 */
        subInputData = (subInputData || {});
        if (expendType.note == validType) {
            inputData = $(this).val();
        } else {
            inputData = $(this).getJson();
        }
        
        switch (validType) {
            case expendType.emp: /* 사용자 확인 */
                if ((typeof inputData.empSeq == 'undefined' && typeof inputData.erpEmpSeq == 'undefined') || (inputData.empSeq == '' && inputData.erpEmpSeq == '')) {
                    alert(NeosUtil.getMessage("TX000009545", "사용자가 선택되지 않았습니다"));
                    result = false;
                }
                break;
            case expendType.summary: /* 표준적요 확인 */
                if (typeof inputData.summaryCode == 'undefined' || inputData.summaryCode == '') {
                    alert(NeosUtil.getMessage("TX000009544", "표준적요가 선택되지 않았습니다"));
                    result = false;
                }
                break;
            case expendType.auth: /* 증빙유형 확인 */
                if (typeof inputData.authCode == 'undefined' || inputData.authCode == '') {
                    alert(NeosUtil.getMessage("TX000009543", "증빙유형이 선택되지 않았습니다"));
                    result = false;
                }
                break;
            case expendType.note: /* 적요 확인 */
                if (subInputData.noteRequiredYN == "Y") {
                    if (inputData == '') {
                        alert(NeosUtil.getMessage("TX000012068", "적요가 입력되지 않았습니다"));
                        result = false;
                    }
                }
                break;
            case expendType.project: /* 프로젝트 확인 */
                if (subInputData.projectRequiredYN == "Y") {
                    if (typeof inputData.projectCode == 'undefined' || inputData.projectCode == '') {
                    	alert(NeosUtil.getMessage("TX000002175", "프로젝트가 입력되지 않았습니다"));
                        result = false;
                    }
                }
                break;
            case expendType.card: /* 카드 확인 */
                if (subInputData.cardRequiredYN == "Y") {
                    if (typeof inputData.cardNum == 'undefined' || inputData.cardNum == '') {
                        alert(NeosUtil.getMessage("TX000009378", "카드가 선택되지 않았습니다"));
                        result = false;
                    }
                }
                break;
        }

        return result;
    },
    /* input[type=text] 갑 표현 */
    $.fn.inputInit = function( code, name ) {
        return this.each(function() {
            code = (code || '');
            name = (name || '');

            if (code != '') {
                code = '[' + code + ']';
            } else {
                code = '';
            }

            if (name != '') {
                name = ' ' + name;
            } else {
                name = '';
            }

            if (code != '' && name != '') {
                $(this).val(code + name);
            } else {
                if (code != '' && name == '') {
                    $(this).val(code);
                } else if (code == '' && name != '') {
                    $(this).val(name);
                } else {
                    $(this).val('');
                }
            }

            $(this).val();
        });
    },
    /* input[type=text] 값 초기화 */
    $.fn.inputReset = function() {
        return this.each(function() {
            $(this).val('');
        });
    };
})(jQuery);

/* 선택된 checkbox 값을 반환한다. */
function fnGetCheckboxInfo( checkboxName ) {
    var items = $('input[name=' + checkboxName + ']:checkbox:checked').map(function() {
        if (this.value != 'on') { return this.value; }
    });

    var result = [];

    $.each(items, function( idx, item ) {
        var object = {};
        var child = item.toString().split('|');

        if (child.length > 1) {
            for (var i = 0; i < child.length; i++) {
                if (i == 0) {
                    object.key = child[i];
                }

                object['item_' + i] = child[i];
            }
        } else {
            object.key = item;
        }

        result.push(object);
    });

    return result;
}

/* ajax 호출을 위해, 하위 JSON 은 string 으로 변환한다. */
function fnConvertJavaParam( param ) {
    var keys = Object.keys(param);
    $.each(keys, function( idx, key ) {
        if (typeof param[key] == 'object') {
            param[key] = JSON.stringify(param[key]);
        }
    });

    return param;
}

/* 증빙유형에 따른 필수 값 표현 처리 */
function fnSetRequired( module, authInfo ) {
    /* 무조건 필수 - 표준적요 */
    /* 무조건 필수 - 증빙유형 */
    /* 무조건 필수 - 공급대가 */
    /* 무조건 필수 - 부가세액 */
    /* 무조건 필수 - 공급가액 */

    /* 적요 */
    if (typeof authInfo.noteRequiredYN != 'undefined') {
        if (authInfo.noteRequiredYN == 'Y') {
            $('#' + module + 'ReqNote').show();
        } else {
            $('#' + module + 'ReqNote').hide();
        }
    }

    /* 증빙일자 */
    if (typeof authInfo.authRequiredYN != 'undefined') {
        if (authInfo.authRequiredYN == 'Y') {
            $('#' + module + 'ReqAuthDate').show();
        } else {
            $('#' + module + 'ReqAuthDate').hide();
        }
    }

    /* 프로젝트 */
    if (typeof authInfo.projectRequiredYN != 'undefined') {
        if (authInfo.projectRequiredYN == 'Y') {
            $('#' + module + 'ReqProject').show();
        } else {
            $('#' + module + 'ReqProject').hide();
        }
    }

    /* 카드 */
    if (typeof authInfo.cardRequiredYN != 'undefined') {
        if (authInfo.cardRequiredYN == 'Y') {
            $('#' + module + 'ReqCard').show();
        } else {
            $('#' + module + 'ReqCard').hide();
        }
    }

    /* 거래처 */
    if (typeof authInfo.partnerRequiredYN != 'undefined') {
        if (authInfo.partnerRequiredYN == 'Y') {
            $('#' + module + 'ReqPartner').show();
        } else {
            $('#' + module + 'ReqPartner').hide();
        }
    }

    return;
}