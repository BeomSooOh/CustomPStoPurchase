/* 1. 항목 팝업 */
function fnExListPopup( param ) {
    var url, getParam, title, width, height, opener, parentId;

    /* 파라미터 체크 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 파라미터 체크 - url */
    if (!param.url) {
        console.log('param.url 이 전달되지 않았습니다.');
        alert("param.url" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        url = (param.url || '');
    }
    /* 파라미터 체크 - getParam */
    if (!param.getParam) {
        console.log('param.getParam 이 전달되지 않았습니다.');
        alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        getParam = (param.getParam || '');

        if (getParam == '') {
            console.log('param.getParam 이 전달되지 않았습니다.');
            alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        /* 기본파라미터 확인 */
        if (getParam.indexOf('callBack=') < 0) {
            console.log('callBack 이 전달되지 않았습니다.');
            alert("callBack" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('expendSeq=') < 0) {
            console.log('expendSeq 이 전달되지 않았습니다.');
            alert("expendSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('listSeq=') < 0) {
            console.log('listSeq 이 전달되지 않았습니다.');
            alert("listSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam != '') {
            if (getParam.indexOf('?') > -1) {
                url += getParam;
            } else {
                url += '?' + getParam;
            }
        }
    }
    /* 파라미터 체크 - title */
    if (!param.title) {
        console.log('param.title 이 전달되지 않았습니다.');
        alert("param.title" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        title = (param.title || '');
    }
    /* 파라미터 체크 - width */
    if (!param.width) {
        param.width = "800";
        width = (param.width || '');
        width = Number(width);
    } else {
        width = (param.width || '');

        if (width.indexOf('px') > -1) {
            width = width.replace('px', '');
            width = Number(width);
        }
    }
    /* 파라미터 체크 - height */
    if (!param.height) {
        param.height = "800";
        height = (param.height || '');
        height = Number(height);
    } else {
        height = (param.height || '');

        if (height.indexOf('px') > -1) {
            height = height.replace('px', '');
            height = Number(height);
        }

        if (height < 100) {
            console.log('param.height 이 전달되지 않았습니다.');
            alert("param.height" + NeosUtil.getMessage("", " 의 값이 너무 작습니다"));
            return;
        }
    }
    /* 파라미터 체크 - opener */
    if (!param.opener) {
        console.log('param.opener 이 전달되지 않았습니다.');
        alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        opener = (param.opener || '');

        if (opener == '') {
            console.log('param.opener 이 전달되지 않았습니다.');
            alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }
    }
    layerPopOpen(url, '', title, width, height, opener, "", "");
    return;
}

/* 2. 분개 팝업 */
function fnExSlipPopup( param ) {
    var url, getParam, title, width, height, opener, parentId;

    /* 파라미터 체크 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 파라미터 체크 - url */
    if (!param.url) {
        console.log('param.url 이 전달되지 않았습니다.');
        alert("param.url" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        url = (param.url || '');
    }
    /* 파라미터 체크 - getParam */
    if (!param.getParam) {
        console.log('param.getParam 이 전달되지 않았습니다.');
        alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        getParam = (param.getParam || '');

        if (getParam == '') {
            console.log('param.getParam 이 전달되지 않았습니다.');
            alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        /* 기본파라미터 확인 */
        if (getParam.indexOf('callBack=') < 0) {
            console.log('callBack 이 전달되지 않았습니다.');
            alert("callBack" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('expendSeq=') < 0) {
            console.log('expendSeq 이 전달되지 않았습니다.');
            alert("expendSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('listSeq=') < 0) {
            console.log('listSeq 이 전달되지 않았습니다.');
            alert("listSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('slipSeq=') < 0) {
            console.log('listSeq 이 전달되지 않았습니다.');
            alert("listSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam != '') {
            if (getParam.indexOf('?') > -1) {
                url += getParam;
            } else {
                url += '?' + getParam;
            }
        }
    }
    /* 파라미터 체크 - title */
    if (!param.title) {
        console.log('param.title 이 전달되지 않았습니다.');
        alert("param.title" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        title = (param.title || '');
    }
    /* 파라미터 체크 - width */
    if (!param.width) {
        param.width = "800";
        width = (param.width || '');
        width = Number(width);
    } else {
        width = (param.width || '');

        if (width.indexOf('px') > -1) {
            width = width.replace('px', '');
            width = Number(width);
        }
    }
    /* 파라미터 체크 - height */
    if (!param.height) {
        param.height = "800";
        height = (param.height || '');
        height = Number(height);
    } else {
        height = (param.height || '');

        if (height.indexOf('px') > -1) {
            height = height.replace('px', '');
            height = Number(height);
        }

        if (height < 100) {
            console.log('param.height 이 전달되지 않았습니다.');
            alert("param.height" + NeosUtil.getMessage("", " 의 값이 너무 작습니다"));
            return;
        }
    }
    /* 파라미터 체크 - opener */
    if (!param.opener) {
        console.log('param.opener 이 전달되지 않았습니다.');
        alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        opener = (param.opener || '');

        if (opener == '') {
            console.log('param.opener 이 전달되지 않았습니다.');
            alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }
    }
    layerPopOpen(url, '', title, width, height, opener, "", "");
    return;
}

/* 3. 관리항목 팝업 */
function fnExMngPopup( param ) {
    var url, getParam, title, width, height, opener, parentId;

    /* 파라미터 체크 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 파라미터 체크 - url */
    if (!param.url) {
        console.log('param.url 이 전달되지 않았습니다.');
        alert("param.url" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        url = (param.url || '');
    }
    /* 파라미터 체크 - getParam */
    if (!param.getParam) {
        console.log('param.getParam 이 전달되지 않았습니다.');
        alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        getParam = (param.getParam || '');

        if (getParam == '') {
            console.log('param.getParam 이 전달되지 않았습니다.');
            alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        /* 기본파라미터 확인 */
        if (getParam.indexOf('callBack=') < 0) {
            console.log('callBack 이 전달되지 않았습니다.');
            alert("callBack" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('expendSeq=') < 0) {
            console.log('expendSeq 이 전달되지 않았습니다.');
            alert("expendSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('listSeq=') < 0) {
            console.log('listSeq 이 전달되지 않았습니다.');
            alert("listSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('slipSeq=') < 0) {
            console.log('slipSeq 이 전달되지 않았습니다.');
            alert("slipSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('mngSeq=') < 0) {
            console.log('mngSeq 이 전달되지 않았습니다.');
            alert("mngSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam != '') {
            if (getParam.indexOf('?') > -1) {
                url += getParam;
            } else {
                url += '?' + getParam;
            }
        }
    }
    /* 파라미터 체크 - title */
    if (!param.title) {
        console.log('param.title 이 전달되지 않았습니다.');
        alert("param.title" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        title = (param.title || '');
    }
    /* 파라미터 체크 - width */
    if (!param.width) {
        param.width = "800";
        width = (param.width || '');
        width = Number(width);
    } else {
        width = (param.width || '');

        if (width.indexOf('px') > -1) {
            width = width.replace('px', '');
            width = Number(width);
        }
    }
    /* 파라미터 체크 - height */
    if (!param.height) {
        param.height = "800";
        height = (param.height || '');
        height = Number(height);
    } else {
        height = (param.height || '');

        if (height.indexOf('px') > -1) {
            height = height.replace('px', '');
            height = Number(height);
        }

        if (height < 100) {
            console.log('param.height 이 전달되지 않았습니다.');
            alert("param.height" + NeosUtil.getMessage("", " 의 값이 너무 작습니다"));
            return;
        }
    }
    /* 파라미터 체크 - opener */
    if (!param.opener) {
        console.log('param.opener 이 전달되지 않았습니다.');
        alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        opener = (param.opener || '');

        if (opener == '') {
            console.log('param.opener 이 전달되지 않았습니다.');
            alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }
    }
    layerPopOpen(url, '', title, width, height, opener, "", "");
    return;
}

/* 4. 공통코드 팝업 */
function fnExCodePopup( param ) {
    var url, getParam, title, width, height, opener, parentId;

    /* 파라미터 체크 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 파라미터 체크 - url */
    if (!param.url) {
        console.log('param.url 이 전달되지 않았습니다.');
        alert("param.url" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        url = (param.url || '');
    }
    /* 파라미터 체크 - getParam */
    if (!param.getParam) {
        console.log('param.getParam 이 전달되지 않았습니다.');
        alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        getParam = (param.getParam || '');

        if (getParam == '') {
            console.log('param.getParam 이 전달되지 않았습니다.');
            alert("param.getParam" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        /* 기본파라미터 확인 */
        if (getParam.indexOf('callBack=') < 0) {
            console.log('callBack 이 전달되지 않았습니다.');
            alert("callBack" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('formSeq=') < 0) {
            console.log('formSeq 이 전달되지 않았습니다.');
            alert("formSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('searchStr=') < 0) {
            console.log('searchStr 이 전달되지 않았습니다.');
            alert("searchStr" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('searchCompSeq=') < 0) {
            console.log('searchCompSeq 이 전달되지 않았습니다.');
            alert("searchCompSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('erpCompSeq=') < 0) {
            console.log('erpCompSeq 이 전달되지 않았습니다.');
            alert("erpCompSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam.indexOf('erpEmpSeq=') < 0) {
            console.log('erpEmpSeq 이 전달되지 않았습니다.');
            alert("erpEmpSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }

        if (getParam != '') {
            if (getParam.indexOf('?') > -1) {
                url += getParam;
            } else {
                url += '?' + getParam;
            }
        }
    }
    /* 파라미터 체크 - title */
    if (!param.title) {
        console.log('param.title 이 전달되지 않았습니다.');
        alert("param.title" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        title = (param.title || '');
    }
    /* 파라미터 체크 - width */
    if (!param.width) {
        param.width = "380";
        width = (param.width || '');
        width = Number(width);
    } else {
        width = (param.width || '');

        if (width.indexOf('px') > -1) {
            width = width.replace('px', '');
            width = Number(width);
        }
    }
    /* 파라미터 체크 - height */
    if (!param.height) {
        param.height = "643";
        height = (param.height || '');
        height = Number(height);
    } else {
        height = (param.height || '');

        if (height.indexOf('px') > -1) {
            height = height.replace('px', '');
            height = Number(height);
        }

        if (height < 100) {
            console.log('param.height 이 전달되지 않았습니다.');
            alert("param.height" + NeosUtil.getMessage("", " 의 값이 너무 작습니다"));
            return;
        }
    }
    /* 파라미터 체크 - opener */
    if (!param.opener) {
        console.log('param.opener 이 전달되지 않았습니다.');
        alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    } else {
        opener = (param.opener || '');

        if (opener == '') {
            console.log('param.opener 이 전달되지 않았습니다.');
            alert("param.opener" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        }
    }
    /* 파라미터 체크 - parentId */
    if (param.opener == "3") {
        if (!param.parentId) {
            console.log('param.parentId 이 전달되지 않았습니다.');
            alert("param.parentId" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
            return;
        } else {
            parentId = (param.parentId || '');

            if (parentId == '') {
                console.log('param.parentId 이 전달되지 않았습니다.');
                alert("param.parentId" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
                return;
            }
        }
    } else {
        parentId = (param.parentId || '');
    }
    var childrenId = "";
    if (parentId != "") {
        childrenId = "layerCommonCode";
    }
    layerPopOpen(url, '', title, width, height, opener, parentId, childrenId);
    return;
}
/* 5. 정보조회 */
function getInfo( type ) {
    /* 변수 점검용 */
    var chkContinue = false;
    var chkType = [ "creEmpInfo", "useEmpInfo", "budgetInfo", "bizplanInfo", "bgAcctInfo", "projectInfo", "partnerInfo", "cardInfo", "summaryInfo", "authInfo", "vatInfo", "notaxInfo", "vatInfo" ];
    /* 변수점검 */
    $.each(chkType, function( idx, variable ) {
        if (variable == type) {
            chkContinue = true;
        }
    });
    if (!chkContinue) {
        console.log("찾는값은 존재하지 않는 값입니다. type 구분을 다시 확인해 주세요.");
        alert(NeosUtil.getMessage("", "찾는값은 존재하지 않는 값입니다")+NeosUtil.getMessage("", "type 구분을 다시 확인해 주세요"));
        return null;
    }
    /* 변수정의 */
    var source = {}, result = {};
    /* 작은단위부터 검사해서 반환한다. */
    /* 분개단위 : slipInfo */
    if (Object.keys(source).length == 0) {
        if (typeof slipInfo != "undefined" && Object.keys(slipInfo).length > 0) {
            if (slipInfo['slip'] && Object.keys(slipInfo['slip']).length > 0) {
                $.extend(source, slipInfo['slip']);
            }
        }
    }
    /* 항목단위 : listInfo */
    if (Object.keys(source).length == 0) {
        if (typeof listInfo != "undefined" && Object.keys(listInfo).length > 0) {
            if (listInfo['list'] && Object.keys(listInfo['list']).length > 0) {
                $.extend(source, listInfo['list']);
            }
        }
    }
    /* 문서단위 : expendInfo */
    if (Object.keys(source).length == 0) {
        if (typeof expendInfo != "undefined" && Object.keys(expendInfo).length > 0) {
            if (expendInfo['expend'] && Object.keys(expendInfo['expend']).length > 0) {
                $.extend(source, expendInfo['expend']);
            }
        }
    }
    /* source 확인 */
    if (Object.keys(source).length > 0) {
        if (source[type] && Object.keys(source[type]).length > 0) {
            $.extend(result, source[type]);
        }
    } else {
        result = null;
    }
    /* 반환 */
    return result;
}
/* 사용자 조회 */
function fnExCodeOrgEmpInfoSelect( param ) {
    /* 파리미터 확인 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    if (!param.searchCompSeq) {
        console.log('param.searchCompSeq 이 전달되지 않았습니다.');
        alert("param.searchCompSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    if (!param.erpCompSeq) {
        console.log('param.erpCompSeq 이 전달되지 않았습니다.');
        alert("param.erpCompSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    if (!param.erpEmpSeq) {
        console.log('param.erpEmpSeq 이 전달되지 않았습니다.');
        alert("param.erpEmpSeq" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 변수정의 */
    var result = {};
    /* 데이터 호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + 'ex/code/org/ExCodeEmpInfoSelect.do',
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
            if (data) {
                if (data.aaData) {
                    result = data.aaData;
                }
            }
        },
        error : function( data ) {
            console.log('error');
            console.log(data);
        }
    });

    return result;
}
/* ----------------------------------------------------------------------- */
/* 공통코드 조회 ---------------------------------------------------------------- */
/* ----------------------------------------------------------------------- */
function fnExCodeMakeParam() {
    var getParam = '';

    /* 기본 공통적요 파라미터 정의 */
    if (typeof expendInfo != "undefined" && expendInfo && expendInfo.form && Object.keys(expendInfo.form).length != 0) {
        getParam += '?formSeq=' + expendInfo.form.formSeq; /* 양식아이디 */
    } else {
        getParam += '?formSeq=0'; /* 양식아이디 */
    }
    if (typeof expendInfo != "undefined" && expendInfo && expendInfo.empInfo && Object.keys(expendInfo.empInfo).length != 0) {
        getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq; /* BizboxA회사시퀀스 */
    } else {
        getParam += '&searchCompSeq=' + (searchCompSeq || ''); /* BizboxA회사시퀀스 */
    }

    if (typeof expendInfo != "undefined") {
        var empParamInfo = getInfo("useEmpInfo");
        if (Object.keys(empParamInfo).length == 0) {
            empParamInfo = getInfo("creEmpInfo");
        }

        getParam += '&erpCompSeq=' + empParamInfo.erpCompSeq; /* ERP 회사 시퀀스 */
        getParam += '&erpEmpSeq=' + empParamInfo.erpEmpSeq; /* ERP 사원 시퀀스 */
        getParam += '&searchStr='; /* 초기 검색어 : 미구현 */
    } else {
        getParam += '&erpCompSeq='; /* ERP 회사 시퀀스 */
        getParam += '&erpEmpSeq='; /* ERP 사원 시퀀스 */
        getParam += '&searchStr='; /* 초기 검색어 : 미구현 */
    }

    return getParam;
}
function fnExCodeCommonPopup( type, addGetParam, callBack, opener, parentId ) {
    var chkContinue = false;
    var chkType = [ "emp", "pc", "cc", "budget", "bizplan", "bgacct", "project", "partner", "card", "vattype", "notax", "acct" ];

    $.each(chkType, function( idx, variable ) {
        if (variable == type) {
            chkContinue = true;
        }
    });

    if (!chkContinue) {
        console.log('parameter type error -_-;');
        console.log('type은 다음과 같이 지정되어야 합니다.');
        $.each(chkType, function( idx, variable ) {
            console.log(variable);
        });

        return;
    }

    /* 변수정의 */
    var popUrl = {
        ERPiU : {
            emp : {
                url : baseUrl + "ex/code/org/ExEmpPopup.do",
                title : NeosUtil.getMessage("TX000000286", "사용자")
            },
            pc : {
                url : baseUrl + "ex/code/org/ExPcPopup.do",
                title : NeosUtil.getMessage("TX000002866", "회계단위")
            },
            cc : {
                url : baseUrl + "ex/code/org/ExCcPopup.do",
                title : NeosUtil.getMessage("TX000007548", "코스트센터")
            },
            budget : {
                url : baseUrl + "ex/code/budget/ExBudgetPopup.do",
                title : NeosUtil.getMessage("TX000007201", "예산단위")
            },
            bizplan : {
                url : baseUrl + "ex/code/budget/ExBizplanPopup.do",
                title : NeosUtil.getMessage("TX000007200", "사업계획")
            },
            bgacct : {
                url : baseUrl + "ex/code/budget/ExBgAcctPopup.do",
                title : NeosUtil.getMessage("TX000005263", "예산계정")
            },
            project : {
                url : baseUrl + "ex/code/project/ExProjectPopup.do",
                title : NeosUtil.getMessage("TX000000519", "프로젝트")
            },
            partner : {
                url : baseUrl + "ex/code/partner/ExPartnerPopup.do",
            	title : NeosUtil.getMessage("TX000000520", "거래처")
            },
            card : {
                url : baseUrl + "ex/code/card/ExCardPopup.do",
                title : NeosUtil.getMessage("TX000005795", "카드")
            },
            vattype : {
                url : baseUrl + "ex/code/tax/ExVatTypePopup.do",
                title : NeosUtil.getMessage("TX000005735", "부가세구분")
            },
            notax : {
                url : baseUrl + "ex/code/tax/ExNotaxPopup.do",
                title : NeosUtil.getMessage("TX000005802", "불공제구분")
            },
            acct : {
                url : baseUrl + "ex/code/acct/ExAcctPopup.do",
                title : NeosUtil.getMessage("TX000000341", "계정과목")
            }
        },
        iCUBE : {
            emp : {
                url : baseUrl + "ex/code/org/ExEmpPopup.do",
                title : NeosUtil.getMessage("TX000000286", "사용자")
            },
            pc : {
                url : baseUrl + "ex/code/org/ExPcPopup.do",
                title : NeosUtil.getMessage("TX000002866", "회계단위")
            },
            cc : {
                url : baseUrl + "ex/code/org/ExCcPopup.do",
                title : NeosUtil.getMessage("TX000007548", "코스트센터")
            },
            budget : {
                url : baseUrl + "ex/code/budget/ExBudgetPopup.do",
                title : NeosUtil.getMessage("TX000007201", "예산단위")
            },
            bizplan : {
                url : baseUrl + "ex/code/budget/ExBizplanPopup.do",
                title : NeosUtil.getMessage("TX000007200", "사업계획")
            },
            bgacct : {
                url : baseUrl + "ex/code/budget/ExBgAcctPopup.do",
                title : NeosUtil.getMessage("TX000005263", "예산계정")
            },
            project : {
                url : baseUrl + "ex/code/project/ExProjectPopup.do",
                title : NeosUtil.getMessage("TX000000519", "프로젝트")
            },
            partner : {
                url : baseUrl + "ex/code/partner/ExPartnerPopup.do",
                title : NeosUtil.getMessage("TX000000520", "거래처")
            },
            card : {
                url : baseUrl + "ex/code/card/ExCardPopup.do",
                title : NeosUtil.getMessage("TX000005795", "카드")
            },
            vattype : {
                url : baseUrl + "ex/code/tax/ExVatTypePopup.do",
                title : NeosUtil.getMessage("TX000005735", "부가세구분")
            },
            notax : {
                url : baseUrl + "ex/code/tax/ExNotaxPopup.do",
                title : NeosUtil.getMessage("TX000005802", "불공제구분")
            },
            acct : {
                url : baseUrl + "ex/code/acct/ExAcctPopup.do",
                title : NeosUtil.getMessage("TX000000341", "계정과목")
            }
        },
        BizboxA : {
            emp : {
                url : baseUrl + "ex/code/org/ExEmpPopup.do",
                title : NeosUtil.getMessage("TX000000286", "사용자")
            },
            pc : {
                url : baseUrl + "ex/code/org/ExPcPopup.do",
                title : NeosUtil.getMessage("TX000002866", "회계단위")
            },
            cc : {
                url : baseUrl + "ex/code/org/ExCcPopup.do",
                title : NeosUtil.getMessage("TX000007548", "코스트센터")
            },
            budget : {
                url : baseUrl + "ex/code/budget/ExBudgetPopup.do",
                title : NeosUtil.getMessage("TX000007201", "예산단위")
            },
            bizplan : {
                url : baseUrl + "ex/code/budget/ExBizplanPopup.do",
                title : NeosUtil.getMessage("TX000007200", "사업계획")
            },
            bgacct : {
                url : baseUrl + "ex/code/budget/ExBgAcctPopup.do",
                title : NeosUtil.getMessage("TX000005263", "예산계정")
            },
            project : {
                url : baseUrl + "ex/code/project/ExProjectPopup.do",
                title : NeosUtil.getMessage("TX000000519", "프로젝트")
            },
            partner : {
                url : baseUrl + "ex/code/partner/ExPartnerPopup.do",
                title : NeosUtil.getMessage("TX000000520", "거래처")
            },
            card : {
                url : baseUrl + "ex/code/card/ExCardPopup.do",
                title : NeosUtil.getMessage("TX000005795", "카드")
            },
            vattype : {
                url : baseUrl + "ex/code/tax/ExVatTypePopup.do",
                title : NeosUtil.getMessage("TX000005735", "부가세구분")
            },
            notax : {
                url : baseUrl + "ex/code/tax/ExNotaxPopup.do",
                title : NeosUtil.getMessage("TX000005802", "불공제구분")
            },
            acct : {
                url : baseUrl + "ex/code/acct/ExAcctPopup.do",
                title : NeosUtil.getMessage("TX000000341", "계정과목")
            }
        }
    }
    var popParam = {};
    var getParam = fnExCodeMakeParam();

    if (getParam.indexOf('?') == 0) {
        getParam += '&callBack=' + callBack;
    } else {
        getParam += '?callBack=' + callBack;
    }
    if (addGetParam.indexOf('&') == 0) {
        getParam += addGetParam;
    } else if (addGetParam.indexOf('?') == 0) {
        getParam += addGetParam.replace('?', '&');
    } else {
        getParam += '&' + addGetParam
    }

    var systemType = 'BizboxA';

    if (typeof expendInfo != 'undefined') {
        if (expendInfo.ifSystem) {
            systemType = (expendInfo.ifSystem || 'BizboxA');
        }
    } else {
        if (typeof ifSystem != 'undefined') {
            systemType = ifSystem;
        }
    }

    popParam.url = popUrl[systemType][type]['url'];
    popParam.title = popUrl[systemType][type]['title'];
    popParam.getParam = getParam;
    popParam.opener = opener;
    popParam.parentId = parentId;

    fnExCodePopup(popParam);
}
/* ----------------------------------------------------------------------- */
/* 공통코드 반영 ---------------------------------------------------------------- */
/* ----------------------------------------------------------------------- */
function fnExCodeCopy() {
    console.log('fnExCodeCopy');
    /* 변수정의 */
    var chkType = [ "creEmpInfo", "useEmpInfo", "budgetInfo", "bizplanInfo", "bgAcctInfo", "projectInfo", "partnerInfo", "cardInfo" ];
    /* 관리항목 */
    if (typeof mngInfo != "undefined") {
        /* 관리항목수정 진입시.. 상위 정보 데이터 복사.. */
        if (Object.keys(mngInfo).length != 0) {
            console.log('관리항목수정 진입시.. 상위 정보 데이터 복사..');
        }
    }
    /* 분개 */
    if (typeof slipInfo != "undefined") {
        if (Object.keys(slipInfo).length != 0) {
            /* 분개수정 진입시.. 상위 정보 데이터 복사.. */
            console.log('분개수정 진입시.. 상위 정보 데이터 복사..');
        } else {
            /* 분개추가 진입시.. 상위 정보 데이터 복사.. */
            console.log('분개추가 진입시.. 상위 정보 데이터 복사..');
        }
    }
    /* 항목 */
    if (typeof listInfo != "undefined") {
        /*
         * if (Object.keys(listInfo.list.creEmpInfo).length == 0) {
         * $.extend(listInfo.list.creEmpInfo, expendInfo.expend.creEmpInfo); }
         */
        if (Object.keys(listInfo.list.useEmpInfo).length == 0) {
            $.extend(listInfo.list.useEmpInfo, expendInfo.expend.useEmpInfo);
        }
        if (Object.keys(listInfo.list.budgetInfo).length == 0) {
            $.extend(listInfo.list.budgetInfo, expendInfo.expend.budgetInfo);
        }
        /*
         * if (Object.keys(listInfo.list.bizplanInfo).length == 0) {
         * $.extend(listInfo.list.bizplanInfo, expendInfo.expend.bizplanInfo); }
         */
        /*
         * if (Object.keys(listInfo.list.bgAcctInfo).length == 0) {
         * $.extend(listInfo.list.bgAcctInfo, expendInfo.expend.bgAcctInfo); }
         */
        if (Object.keys(listInfo.list.projectInfo).length == 0) {
            $.extend(listInfo.list.projectInfo, expendInfo.expend.projectInfo);
        }
        if (Object.keys(listInfo.list.partnerInfo).length == 0) {
            $.extend(listInfo.list.partnerInfo, expendInfo.expend.partnerInfo);
        }
        if (Object.keys(listInfo.list.cardInfo).length == 0) {
            $.extend(listInfo.list.cardInfo, expendInfo.expend.cardInfo);
        }

        console.log(listInfo);
    }
}
function fnExCodeCommonBind( type, value, bindFn ) {
    /* 변수 점검용 */
    var traget = '';
    var chkContinue = false;
    var chkType = [ "creEmpInfo", "useEmpInfo", "budgetInfo", "bizplanInfo", "bgAcctInfo", "projectInfo", "partnerInfo", "cardInfo", "noTaxInfo", "vatInfo" ];
    /* 변수점검 */
    $.each(chkType, function( idx, variable ) {
        if (variable == type) {
            chkContinue = true;
        }
    });
    /* 바인딩 */
    if (typeof slipInfo != "undefined") {
        $.extend(slipInfo['slip'][type], value);
        traget = 'Slip';
    } else if (typeof listInfo != "undefined") {
        $.extend(listInfo['list'][type], value);
        traget = 'List';
    } else if (typeof expendInfo != "undefined") {
        $.extend(expendInfo['expend'][type], value);
        traget = 'Expend';
    }

    if (typeof bindFn == 'function') {
        bindFn(value);
    }

    return;
}