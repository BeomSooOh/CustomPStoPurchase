<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<script>

    /* ## 설명 ## */
    /* Step1 ID */
    /*  - 검색조건 */
    /*    - 권한구분 : selAuthType ( 전체 : '' / 공급자 : P / 이메일 : E ) */
    /*    - 공급자 또는 이메일 : txtSearchStr */
    /*    - 공개범위 : selPublicType */
    /*    - 사용여부 : selSearchUseYN */
    /*    - 검색 : btnSearch */
    /*  - 기능 */
    /*    - 신규 : btnAdd */
    /*    - 저장 : btnSave */
    /*    - 삭제 : btnDelete */
    /*  - 입력정보 */
    /*    - 권한구분 : 공급자 ( rdoAuthP ) / 수신메일 ( rdoAuthE ) */

    /* ## vars ## */
    /* ==================================================================================================== */
    var AuthDataList = [];
    var PublicDataList = [];

    var Common = {
        GetAData: function (result) {
            if (Common.GetUnDefined(result, 'result')) {
                if (Common.GetUnDefined(result.result, 'aData')) {
                    return result.result.aData;
                }
            }

            return {};
        },
        GetAaData: function (result) {
            if (Common.GetUnDefined(result, 'result')) {
                if (Common.GetUnDefined(result.result, 'aaData')) {
                    return result.result.aaData;
                }
            }

            return [];
        },
        GetUnDefined: function (value, key) {
            if (typeof value[key] !== 'undefined') {
                return true;
            } else {
                return false;
            }
        }
    }
    
    var duplicationFlag = true; //중복 여부, true: 중복, false: 중복아님

    /* ## ready ## */
    /* ==================================================================================================== */
    $(document).ready(function () {
        /* init */
        fnInit();

        /* event init */
        fnEventInit();

        /* search data */
        fnGetAuthDataList();

        /* table init */
        fnSetTable();

        /* 신규버튼 클릭 */
        $('#btnAdd').click();

        /* focus */
        $('#txtSearchStr').focus();

        return;
    });

    /* ## init ## */
    /* ==================================================================================================== */
    function fnInit() {

        /* 권한구분 설정 ( 전체 : "" / 공급자 : P / 이메일 : E ) */
        $('#selAuthType').val(''); /* 전체를 기본값으로 설정 */
        /* 사용여부 설정 ( 전체 : "" / 사용 : Y / 미사용 : N ) */
        $('#selSearchUseYN').val(''); /* 전체를 기본값으로 설정 */
        /* 권한타입 설정 ( 공급자 : P / 이메일 : E ) */
        /* 사용여부 설정 */
        $('input:radio[name=useYN]:input[value=Y]').prop("checked", true); /* 기본값 "사용"으로 설정 */
        /* 공개범위 설정 */
        $('#txtPublicName').attr('disabled', 'disabled'); /* 팝업을 통해서만 입력 가능 */
        $('#txtPublicName').attr('readonly', 'readonly'); /* 팝업을 통해서만 입력 가능 */
        return;
    }

    /* ## event init ## */
    /* ==================================================================================================== */
    function fnEventInit() {

        /* 검색 */
        $('#btnSearch').click(function () {
            fnSetTable();
        });
        $('#txtSearchStr').keydown(function () {
            var keyCode = event.keyCode ? event.keyCode : event.which;
            if (keyCode.toString() === '13') {
                $('#btnSearch').click();
                return false;
            }
        });

        /* 신규 */
        $('#btnAdd').click(function () {
            fnAuthInputReset();
            fnAuthChk();
            return;
        });

        /* 저장 */
        $('#btnSave').click(function () {
            fnConfigSave();
        });

        /* 삭제 */
        $('#btnDelete').click(function () {
            fnConfigDelete();
        });

        /* 공급자 초기화 */
        $('#btnReload').click(function () {
            /* 공급자 상호 초기화 */
            $('#txtName').val('');
            /* 사업자등록번호 or 이메일주소 초기화 */
            $('#txtCode').val('');
        });

        /* 거래처 선택 */
        $('#btnPartnerSelect').click(function () {
            fnPartnerPop();
            return;
        });

        /* 공개범위 선택 */
        $('#btnPublicAdd').click(function () {
            var url = "<c:url value='/gw/systemx/orgChart.do'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url.replace("/exp", "");
            frmPop2.submit();
            frmPop2.target = "";
            pop.focus();
            return;
        });

        /* 권한구분 공급자 - 선택 */
        $('#rdoAuthP').click(function () {
            fnAuthChk();
        });
        /* 권한구분 수신메일 - 선택 */
        $('#rdoAuthE').click(function () {
            fnAuthChk();
        });
        
        /* 중복체크 */
        $('#btnCodeDuplicationCheck').click(function () {
            fnCodeDuplicationCheck();
        });
    }

    /* ## grid ## */
    /* ==================================================================================================== */
    /* ## grid - 전자세금계산서 설정 ## */
    function fnSetTable() {

        fnSetTableHead();

        if (AuthDataList.length > 0) {
            fnSetTableContent();
        } else {
            fnSetTableEmpty();
        }
        return;
    }

    function fnSetTableHead() {

        var $td = $('#contentTable');
        $td.unbind().empty();

        var div = document.createElement('div');
        $(div).addClass('com_ta2 mt10 pr15');
        
        $td.append(div);

        var table = document.createElement('table');
        $(div).append(table);

        var colgroup = '';
        colgroup = '<col width="25%" /><col width="" /><col width="15%" /><col width="15%" />';
        $(table).append('<colgroup>' + colgroup + '</colgroup>');

        var tr = '';
        tr = '<th>${CL.ex_authDiv}</th><th>${CL.ex_conductAndEmail}</th><th>${CL.ex_inUseYN}</th><th>${CL.ex_openTo}</th>';
        $(table).append('<tr>' + tr + '</tr>');

        return;
    }

    function fnSetTableContent() {

        var eTaxResultCount = 0;
        var $td = $('#contentTable');

        var div = document.createElement('div');
        $(div).addClass('com_ta2 ova_sc2 cursor_p bg_lightgray');
        $(div).css('height', '510px');

        var table = document.createElement('table');

        var colgroup = '';
        colgroup = '<col width="25%" /><col width="" /><col width="15%" /><col width="15%" />';

        var displayKey = ['authType', 'name', 'useYN', 'publicYN'];
        $.each(AuthDataList, function (idx, item) {

            var searchStr = $('#txtSearchStr').val();

            if (((item.authType || '').toString().indexOf($('#selAuthType').val()) > -1)
                && (((item.name || '').toString().indexOf($('#txtSearchStr').val()) > -1) || ((item.code || '').toString().indexOf($('#txtSearchStr').val()) > -1))
                && ((item.publicYN || '').toString().indexOf($('#selPublicType').val()) > -1)
                && ((item.useYN || 'N').toString().indexOf($('#selSearchUseYN').val()) > -1)) {

                eTaxResultCount++;

                var tr = document.createElement('tr');
                $(table).append(tr);

                $.each(displayKey, function (itemIdx, itemKey) {

                    var td = document.createElement('td');
                    $(tr).append(td);

                    var displayHtml = '';
                    switch (itemKey) {
                        case 'authType':
                            displayHtml = (item[itemKey] || '');
                            displayHtml = (displayHtml === 'P' ? '공급자' : (displayHtml === 'E' ? '수신메일' : ''));
                            break;
                        case 'name':
                            displayHtml = (item[itemKey] || '미입력');
                            if ((item.authType || '') === 'P') { displayHtml += ((item.code || '') !== '' ? ' (' + item.code + ')' : ''); }
                            $(td).addClass('le');
                            break;
                        case 'useYN':
                            displayHtml = (item[itemKey] || '');
                            displayHtml = (displayHtml === 'Y' ? '${CL.ex_use}' : '${CL.ex_notUse}');
                            break;
                        case 'publicYN':
                            displayHtml = (item[itemKey] || '');
                            $(td).addClass((displayHtml === 'Y' ? '' : 'text_red'));
                            displayHtml = (displayHtml === 'Y' ? '${CL.ex_setting}' : '${CL.ex_notSetting}');
                            break;
                        default:
                            displayHtml = (item[itemKey] || '');
                            break;
                    }

                    $(td).html(displayHtml);
                });

                $(tr).data('rowValue', item);
                $(tr).click(function () {
                    if (!$(this).hasClass('on')) {
                        $('#contentTable').find('.on').removeClass('on');
                        $(this).addClass('on');
                    }

                    fnSelectBind($(this).data('rowValue'));
                    return false;
                });
            }
        });

        if (eTaxResultCount > 0) {
            $td.append(div);
            $(div).append(table);
            $(table).append('<colgroup>' + colgroup + '</colgroup>');

            $('#spanETaxResultCount').html(eTaxResultCount.toString());
        } else {
            fnSetTableEmpty();
        }

        return;
    }

    function fnSetTableEmpty() {

        var $td = $('#contentTable');

        var div = document.createElement('div');
        $(div).addClass('com_ta2 ova_sc2 cursor_p bg_lightgray');
        $(div).css('height', '510px');
        $td.append(div);

        var table = document.createElement('table');
        $(div).append(table);

        var colgroup = '';
        colgroup = '<col width="" />';
        $(table).append('<colgroup>' + colgroup + '</colgroup>');

        var tr = '';
        tr = '<td colspan="' + $('#contentTable div:eq(0) table colgroup col').length + '">${CL.ex_noSearchResult}</td>' <!--검색결과가 없습니다.-->
        $(table).append('<tr>' + tr + '</tr>');

        $('#spanETaxResultCount').html('0');

        return;
    }

    /* ## grid - 공개범위 ## */
    function fnSetPublicTable() {
        if (PublicDataList.length > 0) {
            fnSetPublicTableContent();
        } else {
            fnSetPublicTableEmpty();
        }
        
        return;
    }

    function fnSetPublicTableContent() {
        var $table = $('#publicTable');
        $table.unbind().empty();

        var colgroup = '';
        colgroup = '<col width="55%" /><col width="" />';
        $table.append('<colgroup>' + colgroup + '</colgroup>');
        
        $.each(PublicDataList, function (idx, item) {
            var tr = document.createElement('tr');
            var td = '<td>' + (item.deptName || '') + '</td><td>' + (item.empName || '') + '</td>';
            $(tr).append(td);
            $table.append(tr);
        });

        $('#spanPublicCount').html($('#publicTable tr').length);
        return;
    }

    function fnSetPublicTableEmpty(){
        var $table = $('#publicTable');
        $table.unbind().empty();

        var colgroup = '';
        colgroup = '<col width="55%" /><col width="" />';
        $table.append('<colgroup>' + colgroup + '</colgroup>');

        var tr = '';
        tr = '<td colspan="' + $('#publicTable colgroup col').length + '">${CL.ex_noSearchResult}</td>'<!--검색결과가 없습니다.-->
        $table.append('<tr>' + tr + '</tr>');

        $('#spanPublicCount').html('0');
        return;
    }

    /* ## 설정 조회 ## */
    /* ==================================================================================================== */
    function fnGetAuthDataList() {

        /* [ ajax ] */
        $.ajax({
            type: 'post',
            /*   - url : /ex/admin/config/ExETaxAuthAllSelect.do */
            url: '/exp/ex/admin/config/ExETaxAuthAllSelect.do',
            datatype: 'json',
            async: false,
            /*   - data : resDocSeq(결의문서 시퀀스) */
            data: {},
            /*   - success :  */
            success: function (result) {
                var aaData = Common.GetAaData(result);
                AuthDataList = [];
                AuthDataList = JSON.parse(JSON.stringify(aaData));
            },
            /*   - error :  */
            error: function (result) {
                console.error(result);
            }
        });

        return;
    }

    /* ## 설정 추가 ## */
    /* ==================================================================================================== */
    function fnAuthInputReset() {
        /* 그리드 선택 초기화 */
        $('tr.on').removeClass('on');
        /* 권한구분 초기화 */
        $('#rdoAuthP').prop('disabled', false);
        $('#rdoAuthE').prop('disabled', false);
        $('#rdoAuthP').prop('checked', true);
        /* 공급자상호 초기화 */
        $('#txtName').val('');
        /* 사업자등록번호 초기화 */
        $('#txtCode').val('');
        /* 사용여부 초기화 */
        $('#rdoUseY').prop('disabled', false);
        $('#rdoUseN').prop('disabled', false);
        $('#rdoUseY').prop('checked', true);
        /* 공개범위 초기화 */
        fnSetPublicData([]);
        fnSetPublicTable();
        return;
    }

    /* ## 설정 저장 ## */
    /* ==================================================================================================== */
    function fnConfigSave() {
        
        /* 수정 or 신규 판단 변수 ( 수정 : true / 신규 : false ) */
        var saveFlagUpdate = false;
        /* 선택 내역이 존재할 경우 수정, 없을 경우 신규 */
        saveFlagUpdate = (($('tr.on').length > 0) ? true : false);
		//수정시 코드값 변경되었는지 확인
		var compareCodeFlag = $("#hidCompareCode").val() != $("#txtCode").val(); // 코드 값이 변경이 된 경우 true
		
        /* 필수입력 점검 ( 권한구분, 사업자등록번호 or 이메일주소, 사용여부 ) */
        if (!($('#rdoAuthP').prop('checked') || $('#rdoAuthE').prop('checked'))) {
            alert('권한구분이 선택되지 않았습니다.');
            return false;
        } else if (($('#txtCode').val() || '') === '') {
            alert(($('#rdoAuthP').prop('checked') ? '사업자등록번호' : '이메일주소') + '가 입력되지 않았습니다.');
            return false;
        } else if ($('#rdoAuthP').prop('checked') && ($('#txtCode').val() || '') == ''){
            alert('사업자등록번호가 입력되지 않았습니다.')
			return false;
        } else if (duplicationFlag && !saveFlagUpdate){ //신규등록이면서 중복체크를 하지 않은 경우
            alert('중복체크를 해주세요.')
			return false;   
        } else if (duplicationFlag && saveFlagUpdate && ($("#hidCompareCode").val() != $("#txtCode").val())){ //수정이면서 코드값이 변경된 경우
            alert('중복체크를 해주세요.')
			return false;        
        } else if ($('#rdoAuthE').prop('checked') && !fnChkMailID(($('#txtCode').val() || ''))) {
            alert('이메일 주소 유효성 검사에 실패하였습니다.');
            return false;
        } else if (!($('#rdoUseY').prop('checked') || $('#rdoUseN').prop('checked'))) {
            alert('사용여부가 선택되지 않았습니다.');
            return false;
        } else {
            var url = '';
            url = (saveFlagUpdate ? '/exp/ex/admin/config/ExETaxAuthUpdate.do' : '/exp/ex/admin/config/ExETaxAuthInsert.do');
            var ajaxParam = {};
            ajaxParam.authType = ($('#rdoAuthP').prop('checked') ? 'P' : 'E'); /* 권한구분 */
            ajaxParam.name = ($('#rdoAuthP').prop('checked') ? ($('#txtName').val() || '') : ($('#txtCode').val() || '')); /* 공급자상호 */
            ajaxParam.code = ($('#txtCode').val() || ''); /* 사업자등록번호 or 이메일주소 */
            ajaxParam.useYN = ($('#rdoUseY').prop('checked') ? 'Y' : 'N'); /* 사용여부 */
            ajaxParam.publicJson = JSON.stringify(PublicDataList); /* 공개범위 */

            if (saveFlagUpdate) {
                ajaxParam.etaxSeq = ($('tr.on').data('rowValue').eTaxSeq || ''); /* 전자세금계산서 권한 설정 시퀀스 */
            }

            /* ajax call */
            $.ajax({
                type: 'post',
                url: url,
                datatype: 'json',
                async: false,
                data: ajaxParam,
                success: function (result) {
                	if(result.result.resultCode == "FAIL"){
                		alert(result.result.resultName);
                	}else{
                		fnGetAuthDataList(); /* 저장내역 재조회 */
	                    fnSetTable(); /* 테이블 재생성 */
	                    $('#btnAdd').click(); /* 신규 버튼 클릭 */
                	}
                },
                error: function (result) {
                    console.error(result);
                }
            });
        }
        
        return;
    }

    /* ## 설정 삭제 ## */
    /* ==================================================================================================== */
    function fnConfigDelete(){
    	if($('tr.on').length > 0){
    		
    		if(!confirm('삭제된 내역은 복구할 수 없습니다.\r\n 진행하시겠습니까?')) {
    			return;
    		}
    		
    		var ajaxParam = {};
    		ajaxParam = $('tr.on').data('rowValue');
    		ajaxParam.deleteEtaxSeq = '';
    		ajaxParam.etaxSeq = ajaxParam.eTaxSeq;
    		
            /* ajax call */
            $.ajax({
                type: 'post',
                url: "<c:url value='/ex/admin/config/ExETaxAuthDelete.do' />",
                datatype: 'json',
                async: false,
                data: ajaxParam,
                success: function (result) {
                    fnGetAuthDataList(); /* 저장내역 재조회 */
                    fnSetTable(); /* 테이블 재생성 */
                    $('#btnAdd').click(); /* 신규 버튼 클릭 */
                },
                error: function (result) {
                    console.error(result);
                }
            });
    	}
    	
    	return;
    }

    /* ## 선택 반영 ## */
    /* ==================================================================================================== */
    function fnSelectBind(data) {
        /*
        data = {
            "eTaxSeq": "25",
            "compSeq": "4500",
            "authType": "P",
            "useYN": "Y",
            "name": "한누비아이디",
            "code": "2148871835",
            "publicYN": "N",
            "publicJson": "[{\"type\":\"U\",\"compSeq\":\"707010010251\",\"code\":\"707010010257\",\"name\":\"신재호\",\"groupSeq\":\"demo\",\"deptSeq\":\"707010010254\"}]"
        };
        */

        data = (data || {});

        /* 권한구분 */
        $('#rdoAuthP').prop('checked', (data.authType === 'P' ? true : false));
        $('#rdoAuthP').prop('disabled', (data.authType === 'P' ? false : true));
        $('#rdoAuthE').prop('checked', (data.authType === 'E' ? true : false));
        $('#rdoAuthE').prop('disabled', (data.authType === 'E' ? false : true));

        /* 사용여부 */
        $('#rdoUseY').prop('checked', ((data.useYN || 'N') === 'Y' ? true : false));
        $('#rdoUseN').prop('checked', ((data.useYN || 'N') === 'N' ? true : false));

        switch ((data.authType || '')) {
            case 'P': /* 공급자 */
                /* 공급자상호 */
                $('#txtName').val(data.name);
                /* 사업자등록번호 */
                $('#txtCode').val(data.code);
                break;
            case 'E': /* 수신메일 */
                /* 이메일주소 */
                $('#txtCode').val(data.code);
                break;
        }
        
        //사업자등록번호 또는 이메일주소 코드 저장
        $("#hidCompareCode").val(data.code);

        fnAuthChk();
        fnSetPublicData(data.publicJson);
        fnConvertPublicDataList();
        fnSetPublicTable();
        return;
    }

    function fnConvertPublicDataList() {

    }

    /* ## 권한구분 ## */
    /* ==================================================================================================== */
    function fnAuthChk() {
        var chkAuth = '';
        chkAuth = $('#rdoAuthP').prop('checked') ? 'P' : ($('#rdoAuthE').prop('checked') ? 'E' : '');

        switch (chkAuth) {
            case 'P': /* 공급자 */
                /* 사업자등록번호 명칭 변경 */
                $('#spanCodeTitle').html('${CL.ex_corporateRegistrationNumber}');
                /* 공급자 상호 표시 및 활성화 ( 사용자 입력 가능 ) */
                $('#trPartnerName').show();
                break;
            case 'E': /* 수신메일 */
                /* 이메일주소 명칭 변경 */
                $('#spanCodeTitle').html('이메일주소');
                /* 공급자 상호 미표시 및 비활성화 ( 사용자 입력 차단 ) */
                $('#trPartnerName').hide();
                $('#txtName').val('');
                break;
            default:
                break;
        }
        
        /* 중복체크 초기화 */ 
        $("#duplicationCheckMessage").hide();
        duplicationFlag = true;
    }

    /* ## 공개범위 ## */
    /* ==================================================================================================== */
    /* ## 공개범위 - 수정 ## */
    function fnCallbackSel(data) {
        /* data.returnObj example : { "bizName": "기본 사업장", "bizSeq": "1111", "compName": "더존비즈온(iCUBE)", "compSeq": "4500", "ddOrderNum": "0", "deptName": "개발1팀", "deptPath": "4500|4534|4535", "deptSeq": "4535", "dpOrderNum": "0", "dutyCode": "", "dutyName": "", "empDeptFlag": "d", "empName": "", "empNameAdv": "", "empSeq": "", "groupSeq": "demo", "orderNum": "99999", "parentDeptSeq": "4534", "pathName": "UC개발부|개발1팀", "positionCode": "", "positionName": "", "superKey": "demo|4500|4535|0|d" } */
        fnSetPublicData(data.returnObj);
        fnSetPublicTableContent();
    }

    function fnSetPublicData(data) {
        /* 기본값 정의 */
        data = (typeof data === 'string' ? JSON.parse((data || '[]')) : (data || []));

        /* 데이터 반영 */
        PublicDataList = JSON.parse(JSON.stringify(data));

        var selectedItems = [];
        $.each(PublicDataList, function (idx, item) {
            selectedItems.push(item.superKey);
        });

        if (selectedItems.length > 0) {
            $('#selectedItems_forCmPop').val(selectedItems.join(','));
        } else {
            $('#selectedItems_forCmPop').val('');
        }
    }

    /* ## 거래처 ## */
    /* ==================================================================================================== */
    function fnPartnerPop(param) {
        param = (param || '');

        if (param === '') {
            var Popresult = fnOpenCodePop({
                codeType : 'RegNoPartner'
                , callback: 'fnPartnerPop'
                , searchStr : ''
               	, search_type : ''
            });
        } else {
            var bizName = (param.obj.partnerName || '');
            var bizNo = (param.obj.partnerNo || '');

            if (bizNo.toString().replace(/-/g, '').length === 10) {
                bizNo = bizNo.toString().replace(/(^[0-9]{3})-?([0-9]{2})-?([0-9]{5})$/, "$1-$2-$3");
            }

            $('#txtName').val((bizName || ''));
            $('#txtCode').val((bizNo || ''));
        }
    }

    /* ## 사업자등록번호 ## */
    /* ==================================================================================================== */
    /* ## 사업자등록번호 - 유효성 검사 ## */
    function fnChkBizID(bizNo) {
        /* 수신된 값의 정수만 추출하여 문자열의 배열로 생성하고 10자리 여부 확인 */
        if ((bizNo = (bizNo + '').match(/\d{1}/g)).length != 10) { return false; }

        /* 합, 체크키 */
        var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];

        /* 0 ~ 8 까지 9개의 숫자를 체크키와 곱하여 합에 추가 */
        for (var i = 0 ; i < 9 ; i++) { sum += (key[i] * Number(bizNo[i])); }

        /* 각 8번배열의 값을 곱한 후 10으로 나누고 내림하여 기존 합에 더합니다. */
        /* 다시 10의 나머지를 구한후 그 값을 10에서 빼면 이것이 검증번호 이며 기존 검증번호와 비교하면됩니다. */
        return (10 - ((sum + Math.floor(key[8] * Number(bizNo[8]) / 10)) % 10)) == Number(bizNo[9]);
    }

    /* ## 이메일 ## */
    /* ==================================================================================================== */
    /* ## 사업자등록번호 - 유효성 검사 ## */
    function fnChkMailID(mailId) {
        mailId = (mailId || '');

        /* 검증에 사용할 정규식 */
        var regExp = /^[0-9a-zA-Z._%+-]*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

        /* 검증 */
        if (mailId.match(regExp) != null) {
            return true;
        } else {
            return false;
        }
    }
    
    //사업자등록번호 또는 이메일 중복체크
    function fnCodeDuplicationCheck(){
    	var params = {};
    	params.authType = ($('#rdoAuthP').prop('checked') ? 'P' : 'E'); /* 권한구분 */
    	params.code = ($('#txtCode').val() || ''); /* 사업자등록번호 or 이메일주소 */
    	
    	var codeName = (params.authType == "P")?"사업자등록번호":"이메일주소";
    	
    	if(params.code.trim() == ""){
    		alert(codeName + "를 입력해주세요.");
    		return;
    	}
		
        /* ajax call */
        $.ajax({
            type: 'post',
            url: "<c:url value='/ex/admin/config/ExETaxAuthCodeDuplicationCheck.do' />",
            datatype: 'json',
            async: false,
            data: params,
            success: function (result) {
            	var duplicationCount = result.result.aData.duplicationCount;
            	
            	if(duplicationCount > 0){
            		duplicationFlag = true; // 중복 존재
            		$("#duplicationCheckMessage").show().css("color", "#f33e51").text("이미 등록된 " + codeName + "가 존재합니다.");
            	}else{
            		duplicationFlag = false; // 중복 미존재
            		$("#duplicationCheckMessage").show().css("color", "#058df5").text("등록 가능한 " + codeName + " 입니다.");
            	}
            },
            error: function (result) {
                console.error(result);
            }
        });
    }

</script>

<div class="sub_contents_wrap">
    <!-- 컨트롤박스 -->
    <div class="top_box">
        <dl>
            <dt>${CL.ex_authDiv} <!--권한구분--></dt>
            <dd>
                <select id="selAuthType" class="selectmenu" style="width:120px;">
                    <option value="" selected="selected">${CL.ex_all} <!--전체--></option>
                    <option value="P">${CL.ex_supplyer} <!--공급자--></option>
                    <option value="E">${CL.ex_email2} <!--이메일--></option>
                </select>
            </dd>
            <dt>${CL.ex_conductAndEmail} <!--공급자 또는 이메일--></dt>
            <dd><input id="txtSearchStr" type="text" style="width:170px;" /></dd>
            <dt>${CL.ex_openTo} <!--공개범위--></dt>
            <dd>
                <select id="selPublicType" class="selectmenu" style="width:120px;">
                    <option value="" selected="selected">${CL.ex_all} <!--전체--></option>
                    <option value="Y">${CL.ex_setting} <!--설정--></option>
                    <option value="N">${CL.ex_notSetting} <!--미설정--></option>
                </select>
            </dd>
            <dd><input id="btnSearch" type="button" value="${CL.ex_search} " /></dd>
        </dl>
        <span class="btn_Detail">${CL.ex_detailSearch} <!--상세검색--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
    </div>

    <div class="SearchDetail">
        <dl>
            <dt>${CL.ex_inUseYN} <!--사용여부--></dt>
            <dd>
                <select id="selSearchUseYN" class="selectmenu" style="width:120px;">
                    <option value="" selected="selected">${CL.ex_all} <!--전체--></option>
                    <option value="Y">${CL.ex_use} <!--사용--></option>
                    <option value="N">${CL.ex_noUser} <!--미사용--></option>
                </select>
            </dd>
        </dl>
    </div>
    <!-- 버튼 -->
    <div class="controll_btn cl">
        <span class="fwb mt5" style="text-align:left;float:left">${CL.ex_elecTaxBillSet} <!--전자세금계산서 설정--> (<span id="spanETaxResultCount">10</span>) <span class="fwn f11 ml20">${CL.ex_elecDocComment2} <!--전자세금계산서의 공개범위 권한을 설정합니다.--></span></span>
        <button id="btnAdd">${CL.ex_new} <!--신규--></button>
        <button id="btnSave">${CL.ex_save} <!--저장--></button>
        <button id="btnDelete">${CL.ex_remove} <!--삭제--></button>
    </div>
    <div class="twinbox">
        <table>
            <colgroup>
                <col width="50%" />
                <col width="" />
            </colgroup>
            <tr>
                <td id="contentTable" class="twinbox_td" style="">
                    <div class="com_ta2 mt10 ova_sc2">
                        <table>
                            <colgroup>
                                <col width="25%" />
                                <col width="" />
                                <col width="15%" />
                                <col width="15%" />
                            </colgroup>
                            <tr>
                                <th>${CL.ex_authDiv} <!--권한구분--></th>
                                <th>${CL.ex_conductAndEmail} <!--공급자 또는 이메일--></th>
                                <th>${CL.ex_inUseYN} <!--사용여부--></th>
                                <th>${CL.ex_openTo} <!--공개범위--></th>
                            </tr>
                        </table>
                    </div>

                    <div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height:510px;">
                        <table>
                            <colgroup>
                                <col width="25%" />
                                <col width="" />
                                <col width="15%" />
                                <col width="15%" />
                            </colgroup>
                            <tr>
                                <td>${CL.ex_supplyer} <!--공급자--></td>
                                <td class="le">더존비즈온 (000-00-00000)</td>
                                <td>${CL.ex_use} <!--사용--></td>
                                <td>${CL.ex_setting} <!--설정--></td>
                            </tr>
                            <tr>
                                <td>${CL.ex_supplyer} <!--공급자--></td>
                                <td class="le">fullrush@naver.com</td>
                                <td>${CL.ex_use} <!--사용--></td>
                                <td class="text_red">${CL.ex_notSetting} <!--미설정--></td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td class="twinbox_td" style="">
                    <div class="com_ta">
                        <table>
                            <colgroup>
                                <col width="140" />
                                <col width="" />
                            </colgroup>
                            <tr>
                                <th>${CL.ex_authDiv} <!--권한구분--></th>
                                <td>
                                    <input type="radio" name="radioAuth" id="rdoAuthP" />
                                    <label for="rdoAuthP">${CL.ex_supplyer} <!--공급자--></label>
                                    <input type="radio" name="radioAuth" id="rdoAuthE" class="ml10" />
                                    <label for="rdoAuthE">${CL.ex_receiveMail} <!--수신메일--></label>
                                </td>
                            </tr>
                            <tr id="trPartnerName">
                                <th>${CL.ex_conductorMark} <!--공급자상호--></th>
                                <td>
                                    <div>
                                        <input id="txtName" type="text" style="width:170px" />
                                        <input id="btnPartnerSelect" type="button" value="${CL.ex_select}" /> <!--선택-->
                                        <div class="controll_btn p0">
                                            <button id="btnReload" class="reload_btn"></button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <img src="../../../Images/ico/ico_check01.png" alt="" /><span id="spanCodeTitle">${CL.ex_corporateRegistrationNumber} <!--사업자등록번호--></span>
                                </th>
                                <td>
                                    <input id="txtCode" type="text" style="width:170px;" />
                                    <input id="hidCompareCode" type="text" style="display: none;" />
                                    <input id="btnCodeDuplicationCheck" type="button" value="${CL.ex_duplicationCheck}" /> <!--중복체크-->
                                    <p id="duplicationCheckMessage" class="mt5" style="display: none;" ></p>
                                </td>
                            </tr>
                            <!-- 수신메일사용시 -->
                            <tr>
                                <th>${CL.ex_inUseYN} <!--사용여부--></th>
                                <td>
                                    <input type="radio" name="radioUseYN" id="rdoUseY" />
                                    <label for="rdoUseY">${CL.ex_use} <!--사용--></label>
                                    <input type="radio" name="radioUseYN" id="rdoUseN" class="ml10" />
                                    <label for="rdoUseN">${CL.ex_noUser} <!--미사용--></label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="btn_div mt20">
                        <div class="left_div">
                            <p class="tit_p mt7 mb0">${CL.ex_openTo} <!--공개범위--> (<span id="spanPublicCount">15</span>)</p>
                        </div>
                        <div class="right_div">
                            <div id="" class="controll_btn p0" style="">
                                <button id="btnPublicAdd" onclick="">${CL.ex_select} <!--선택--></button>
                            </div>
                        </div>
                    </div>
                    <div class="com_ta2 sc_head">
                        <table>
                            <colgroup>
                                <col width="55%" />
                                <col width="" />
                            </colgroup>
                            <tr>
                                <th>${CL.ex_department} <!--부서--></th>
                                <th>${CL.ex_fullName} <!--이름--></th>
                            </tr>
                        </table>
                    </div>
                    <div class="com_ta2 ova_sc2 bg_lightgray" style="height:317px;">
                        <table id="publicTable">
                            <colgroup>
                                <col width="55%" />
                                <col width="" />
                            </colgroup>
                            <tr>
                                <td>영업팀</td>
                                <td>홍길동</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div><!-- twinbox -->


</div><!-- //sub_contents_wrap -->

<!-- 공통팝업 위한 기능옵션 전달 폼 -->

<form id="frmPop2" name="frmPop2">
    <input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="" />
    <input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" />
    <input type="hidden" id="langCode_forCmPop" name="langCode" width="500" />
    <input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" />
    <input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" />
    <input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" />
    <input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" />
    <input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" />
    <input type="hidden" name="selectMode" width="500" value="ud" />
    <input type="hidden" name="selectItem" width="500" value="m" />
    <input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" />
    <input type="hidden" name="callback" width="500" value="fnCallbackSel" />
    <input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>