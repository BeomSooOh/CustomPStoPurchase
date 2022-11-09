<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- javascript - src -->
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedColumns.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>

<!-- 나의 예실대비 현황(ERPiU) -->
<!-- javascript -->
<script>
    /* UserYesil2Report var */
    if(window.console == undefined){console = {log:function(){}}} /* IE console.log 에러 방지 */
    var gisuInfo = {};
    
    /* document.ready */
    $(document).ready(function() {
    	fnGetGisuInfo();
        fnUserYesil2ReportInit();
        fnUserYesil2ReportEventInit();

        /* 초기 조회 시 오래 걸리는 고객사가 있어 사용자가 검색 누를때만 조회되도록 수정 2018. 03. 23 신재호 */
        /* $('#searchButton').click(); */
    });

    // $(window).load(function () {
    // 	$('.btn_Detail').click();
    // });

    /* 초기화 */
    function fnUserYesil2ReportInit() {
        log('+ [UserYesil2Report] fnUserYesil2ReportInit');
        fnUserYesil2ReportLayout();
        fnUserYesil2ReportDatepicker();
        fnUserYesil2ReportInitInput();
        fnUserYesil2ReportInitButton();
        log('- [UserYesil2Report] fnUserYesil2ReportInit');
        return;
    }

    /* 초기화 - Layout */
    function fnUserYesil2ReportLayout() {
        log('+ [UserYesil2Report] fnUserYesil2ReportLayout');
        $('button').kendoButton(); /* 켄도버튼정의 */
        fnUserYesil2ComboBox(); /* 켄도콤보박스 정의 */

        var jsonData =  JSON.parse('${ViewBag.params.deptInfo}');
        var dataSource = new Array();
        if(jsonData){
            $(jsonData).each(function(index, value){
                $('#deptTxt').val(value.NM_DEPT);
                $('#hid_deptCode').val( value.CD_DEPT );
            });
        }
        /* 공통코드 정의 */
        var erpTermType = '${ViewBag.params.termTypeList}';
        if(erpTermType == '' || erpTermType == '[]'){
            erpTermType = '[{"NM_SYSDEF":"월","CD_SYSDEF":"1"},{"NM_SYSDEF":"분기","CD_SYSDEF":"2"},{"NM_SYSDEF":"반기","CD_SYSDEF":"3"},{"NM_SYSDEF":"년","CD_SYSDEF":"4"}]';
        }
        fnUserYesil2CommonCode('termTypeSel', erpTermType);
        fnUserYesil2CommonCode('acctLevelSel', '${ViewBag.params.acctLevelList}');
        fnUserYesil2CommonCode('executeSel', '${ViewBag.params.executeList}');
        log('- [UserYesil2Report] fnUserYesil2ReportLayout');
        return;
    }

    /* 초기화 - Datepicker */
    function fnUserYesil2ReportDatepicker() {
        log('+ [UserYesil2Report] fnUserYesil2ReportDatepicker');
        fnInitDatePicker();
        log('- [UserYesil2Report] fnUserYesil2ReportDatepicker');
        return;
    }

    /* 초기화 - Event */
    function fnUserYesil2ReportEventInit() {
        log('+ [UserYesil2Report] fnUserYesil2ReportEventInit');
        fnUserYesil2EventKey(); /* 키보드 이벤트 정의 */

        $('#acctLevelSel').change(function(){
            fnClearComboBox("budgetAcctSel");
        });

        $('#from_date').data("kendoDatePicker").bind( "change", function(){
            var maxYear = $('#from_date').val();
            maxYear = maxYear.toString().split('-')[0];
            
            var datePicker = $('#to_date').data("kendoDatePicker");
            
		    var baseDt = new Date($('#from_date').val() + '-01');			
			datePicker.min(new Date(baseDt.getFullYear(), baseDt.getMonth()));
			
			baseDt.setMonth(baseDt.getMonth() + 11);
			datePicker.max(new Date(baseDt.getFullYear(), baseDt.getMonth()));
			
			datePicker.value(new Date(baseDt.getFullYear(), baseDt.getMonth()));
			datePicker.trigger("change");

        });
        log('- [UserYesil2Report] fnUserYesil2ReportEventInit');
        return;
    }

    /* 초기화 - Input */
    function fnUserYesil2ReportInitInput() {
        log('+ [UserYesil2Report] fnUserYesil2ReportInitInput');

        log('- [UserYesil2Report] fnUserYesil2ReportInitInput');
        return;
    }
    /* 초기화 - Button */
    function fnUserYesil2ReportInitButton() {
        log('+ [UserYesil2Report] fnUserYesil2ReportInitButton');
        var url = "";
        $('#searchButton').click(function(){
            $('.viewDiv').empty();
            $('.viewDiv').append('<table id="Yesil2View"></table>');
            fnUserYesil2Search();
        });
        $('#budgetGrPopBtn').click(function() {
            url = "<c:url value='/ex/expend/user/ExUserYesil2BudgetGrPop.do'/>";
            fnYesil2Popup(url, '640');
        });
        $('#budgetDeptPopBtn').click(function() {
            var authDept = $("#hid_deptCode").val()+'|';

            url = "<c:url value='/ex/expend/user/ExUserYesil2BudgetDeptPop.do?authDept="+authDept+"'/>";
            fnYesil2Popup(url);
        });
        $('#bizPlanPopBtn').click(function() {
            url = "<c:url value='/ex/expend/user/ExUserYesil2BizPlanPop.do'/>";
            fnYesil2Popup(url, '740');
        });
        $('#budgetAcctPopBtn').click(function() {
            var param = "";
            var levelComboBox = $("#acctLevelSel").data("kendoComboBox");
            var tpAclevel = levelComboBox.value();

            var cdDeptPipe = $("#hid_deptCode").val()+'|';
            var cdBudgetPipe = fnGetComboBoxParams("budgetDeptSel");
            var cdBizplanPipe = fnGetComboBoxParams("bizPlanSel");

            var param = "?tpAclevel="+tpAclevel+"&cdDeptPipe="+cdDeptPipe+"&cdBudgetPipe="+cdBudgetPipe+"&cdBizplanPipe="+cdBizplanPipe;

            url = "<c:url value='/ex/expend/user/ExUserYesil2BudgetAcctPop.do"+param+"'/>";
            fnYesil2Popup(url, 640);
        });
        $('#btnExcelDown').click(function(){
        	excelDown();
        });
        log('- [UserYesil2Report] fnUserYesil2ReportInitButton');
        return;
    }

    /*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
    function fnInitDatePicker() {
        Date.prototype.FromDate = function(){
			var yyyy = '', mm = '';
			
			yyyy = gisuInfo.dtFrom.split('-')[0];
			mm = gisuInfo.dtFrom.split('-')[1];
			
			return yyyy + '-' + mm
        }
        Date.prototype.ToDate = function(){
			var yyyy = '', mm = '';
			
			yyyy = gisuInfo.dtTo.split('-')[0];
			mm = gisuInfo.dtTo.split('-')[1];
			
			return yyyy + '-' + mm
        }
        var date = new Date();
        $('#from_date').val(date.FromDate());
        $('#to_date').val(date.ToDate());

        $(".datepicker").kendoDatePicker({
            start: "year",
            depth: "year",
            format: "yyyy-MM",
            culture : "ko-KR"
        });

        $('#from_date').kendoMaskedTextBox({
            mask : '0000-00'
        });

        $('#to_date').kendoMaskedTextBox({
            mask : '0000-00'
        });

	    // var maxYear = $('#from_date').val().split('-')[0];
	    var baseDt = new Date($('#from_date').val() + '-01');
	    $('#to_date').data("kendoDatePicker").min( new Date(baseDt.getFullYear(), baseDt.getMonth()));
	    
	    baseDt.setMonth(baseDt.getMonth() + 11);
	    $('#to_date').data("kendoDatePicker").max( new Date(baseDt.getFullYear(), baseDt.getMonth()));
    }

    /* 초기화 - 콤보박스 */
    function fnUserYesil2ComboBox(){
        $(".kendoComboBox").kendoComboBox( );

        $("#inquirySel").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource : [
			            {text : "<%=BizboxAMessage.getMessage("TX000000862","전체")%>" , value : "0"},
    {text : "<%=BizboxAMessage.getMessage("TX000009448","편성예산")%>", value : "1"},
    {text : "<%=BizboxAMessage.getMessage("TX000007561","실행합금액")%>", value : "2"},
    {text : "<%=BizboxAMessage.getMessage("TX000009445","집행실적")%>", value : "3"},
    {text : "<%=BizboxAMessage.getMessage("TX000018979","집행잔액")%>",value : "4"}
    ],
    index : 0
    });

    }

    /* 공통코드 콤보박스 그리기 */
    function fnUserYesil2CommonCode(elemID, data){
        var id = '' + elemID;
        id = id[0] == '#' ? id : '#' + id;

        var jsonData =  JSON.parse(data);
        var dataSource = new Array();
        $(jsonData).each(function(index, value){
            dataSource.push( { 'text' : value.NM_SYSDEF, 'value' : value.CD_SYSDEF } );
        });

        $(id).kendoComboBox({
            "dataTextField" : "text",
            "dataValueField" : "value",
            "dataSource" : dataSource,
            "index" : 0
        });
    }

    /* 키보드 이벤트 정의 */
    function fnUserYesil2EventKey(){

        $("#budgetGr").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#budgetGrPopBtn').click();
            }else{
                $('#hid_budgetGrCode').val("");
            }
        });

        $("#budgetDeptSel").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#budgetDeptPopBtn').click();
            }
        });

        $("#bizPlanSel").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#bizPlanPopBtn').click();
            }
        });

        $("#budgetAcctSel").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#budgetAcctPopBtn').click();
            }
        });

        $("#from_date,#to_date").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                $('#searchButton').click();
            }
        });
    }

    /*	[기능] 회계 기수 정보 조회
   	--------------------------------------*/
   	function fnGetGisuInfo() {
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex/ExERPiUAccSeqInfo.do" />',
            datatype : 'json',
            async : false,
            data : {},
            success : function( data ) {
            	if(data.result.resultCode == 'SUCCESS') {
            		gisuInfo = data.result;
            	} else {
            		var dtTemp = new Date();
            		var dtTempFormat = [dtTemp.getFullYear(), ((dtTemp.getMonth() + 1) < 10 ? '0' + (dtTemp.getMonth() + 1) : (dtTemp.getMonth() + 1)), '01'].join('-');
            		gisuInfo.dtFrom = dtTempFormat;
            		
            		dtTemp.setMonth(dtTemp.getMonth() + 11);
            		dtTempFormat = [dtTemp.getFullYear(), ((dtTemp.getMonth() + 1) < 10 ? '0' + (dtTemp.getMonth() + 1) : (dtTemp.getMonth() + 1)), '01'].join('-');
            		gisuInfo.dtTo = dtTempFormat;
            		
            		alert(data.result.resultName);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
    }
    
    /*	[팝업] 팝업 호출
   	--------------------------------------*/
    function fnYesil2Popup(url, width){
        var popWidth = width || 500;
        var popHeight = 530; //팝업 창 사이즈

        var winHeight = document.body.clientHeight; // 현재창의 높이
        var winWidth = document.body.clientWidth; // 현재창의 너비
        var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
        var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표

        var popX = winX + (screen.width - popWidth) / 2;
        var popY = winY + (screen.height - popHeight) / 2;

        var pop = window.open(url, "UserYesil2Pop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);

    }

    /*	[comboBox] 콤보박스 Clear
   	--------------------------------------*/
    function fnClearComboBox(elemID){
        var id = '' + elemID;
        id = id[0] == '#' ? id : '#' + id;

        $(id).kendoComboBox({
            "dataTextField" : "text",
            "dataValueField" : "value",
            "dataSource" : null,
            "value" : ""
        });
        $(id).data("kendoComboBox").refresh();
    }

    /*	[팝업] 예산단위그룹 CallBack
   	--------------------------------------*/
    function fnBudgetGrCallback(param){
        if(param.length == 0 ){
            $('#hid_budgetGrCode').val("");
            $('#budgetGr').val("");
        }else if(param.length != 0){
            $('#hid_budgetGrCode').val(param.obj.CD_BUDGETGR);
            $('#budgetGr').val(param.obj.NM_BUDGETGR);
        }

        fnClearComboBox("budgetDeptSel");
        fnClearComboBox("bizPlanSel");
        fnClearComboBox("budgetAcctSel");
    }

    /*	[팝업] 예산단위 CallBack
   	--------------------------------------*/
    function fnBudgetDeptCallback(param){
        if(param.length == 0 ){
            fnClearComboBox("budgetDeptSel");
        }else if(param.length != 0){
            $('#budgetDeptSel').kendoComboBox({
                "dataTextField" : "text",
                "dataValueField" : "value",
                "dataSource" : param,
                "index" : 0
            });
        }

        fnClearComboBox("bizPlanSel");
        fnClearComboBox("budgetAcctSel");
    }
    
    /*	[팝업] 사업계획 CallBack
   	--------------------------------------*/
	function fnBizPlanCallback(param){
		if(param.length == 0 ){
            fnClearComboBox("bizPlanSel");
		} else if(param.length != 0){
			$('#bizPlanSel').kendoComboBox({
                "dataTextField" : "text",
                "dataValueField" : "value",
                "dataSource" : param,
                "index" : 0
            });
		}
    }

    /*	[팝업] 사업계획 CallBack
   	--------------------------------------*/
    function fnBudgetBizPlanCallback(param){
        if(param.length == 0 ){
            fnClearComboBox("bizPlanSel");
        }else if(param.length != 0){
            $('#bizPlanSel').kendoComboBox({
                "dataTextField" : "text",
                "dataValueField" : "value",
                "dataSource" : param,
                "index" : 0
            });
        }

        fnClearComboBox("budgetAcctSel");
    }

    /*	[팝업] 예산계정 CallBack
   	--------------------------------------*/
    function fnBudgetAcctCallback(param){
        if(param.length == 0 ){
            fnClearComboBox("budgetAcctSel");
        }else if(param.length != 0){
            $('#budgetAcctSel').kendoComboBox({
                "dataTextField" : "text",
                "dataValueField" : "value",
                "dataSource" : param,
                "index" : 0
            });
        }
    }

    /* [comboBox] value return
 	--------------------------------------*/
    function fnGetComboBoxParams(elemID){
        var id = '' + elemID;
        id = id[0] == '#' ? id : '#' + id;

        var comboBox = $(id).data("kendoComboBox");
        var param = "";
        $(comboBox.dataSource._data).each(function(){
            if(this.value){
                param = param + this.value + '|'
            }
        });

        return param;
    }

    function fnUserYesil2Vaildation(){
        var fromDt = $('#from_date').val().toString().split("-");
        var toDt = $('#to_date').val().toString().split("-");

  		if( $('#from_date').val() > $('#to_date').val()){
   			alert("<%=BizboxAMessage.getMessage("TX000018981","종료일자보다 시작일자가 클 수 없습니다.")%>");
   			return false;
   		}
  		
        return true;
    }

    /*	[뷰-검색] 예실대비현황 조회 - 서버 호출
 	--------------------------------------*/
    function fnUserYesil2Search(){
        if( fnUserYesil2Vaildation() ){
            var executeComboBox = $("#executeSel").data("kendoComboBox");
            var execute = executeComboBox.value();

            var cdDeptPipe = $("#hid_deptCode").val() + '|';
            var cdBudgetPipe = fnGetComboBoxParams("budgetDeptSel");
            var cdBizplanPipe = fnGetComboBoxParams("bizPlanSel");
            var cdBudgetAcctPipe = fnGetComboBoxParams("budgetAcctSel");
            var param = {
                'fromDt' : ($('#from_date').val().toString().replace(/-/g, '') || ''),
                'toDt' : ($('#to_date').val().toString().replace(/-/g, '') || ''),
                'execute' : execute,
                'budgetGrPipe' : $('#hid_budgetGrCode').val() || '',
                'cdDeptPipe' : cdDeptPipe,
                'cdBudgetPipe' : cdBudgetPipe,
                'cdBizplanPipe' : cdBizplanPipe,
                'cdBudgetAcctPipe' : cdBudgetAcctPipe
            };

            /* 서버호출 */
            $.ajax({
                type : 'post',
                url : '<c:url value="/ex/expend/user/ExUserYesil2InfoSelect.do" />',
                datatype : 'json',
                async : true,
                data : param,
                success : function( data ) {
                    fnSetMainList(data);
                },
                error : function( data ) {
                    console.log("! [EX] ERROR - " + JSON.stringify(data));
                }
            });
        }
    }

    /*	[뷰] 예실대비현황 데이터 가공
 	--------------------------------------*/
    function fnSetData(data){
        var d = data.result.aaData;
        if( d == null ){
            d = [];
        }
        var result = new Array();

        var comboBox = $('#inquirySel').data("kendoComboBox");
        var val = comboBox.value();
        for(var i=0 ; i < d.length ; ){
            var jsonData = {};
            jsonData.CD_BUDGET = d[i].CD_BUDGET;
            jsonData.NM_BUDGET = d[i].NM_BUDGET;
            jsonData.CD_BIZPLAN = d[i].CD_BIZPLAN;
            jsonData.NM_BIZPLAN = d[i].NM_BIZPLAN;
            jsonData.CD_BGACCT = d[i].CD_BGACCT;
            jsonData.NM_BGACCT = d[i].NM_BGACCT;
            jsonData.CD_BUDGETGR = d[i].CD_BUDGETGR;
            jsonData.NM_BUDGETGR = d[i].NM_BUDGETGR;
            var propo = new Array();
            var sum = new Array();
            var drcr = new Array();
            var bal = new Array();
            for(var j = i+1 ; j < d.length ; j++){
                if( d[i].CD_BUDGET == d[j].CD_BUDGET &&
						d[i].CD_BIZPLAN == d[j].CD_BIZPLAN && d[i].CD_BGACCT == d[j].CD_BGACCT ){
                    var proJson = {};
                    var sumJson = {};
                    var drcrJson = {};
                    var balJson = {};
                    proJson.MONTH = d[j-1].YM_BUDGET;
                    proJson.AM_PROPO = d[j-1].AM_PROPO;
                    sumJson.MONTH = d[j-1].YM_BUDGET;
                    sumJson.AM_ACTSUM = d[j-1].AM_ACTSUM;
                    drcrJson.MONTH = d[j-1].YM_BUDGET;
                    drcrJson.AM_DRCR = d[j-1].AM_DRCR;
                    balJson.MONTH = d[j-1].YM_BUDGET;
                    balJson.AM_BAL = d[j-1].AM_ACTSUM - d[j-1].AM_DRCR;
                    propo.push(proJson);
                    sum.push(sumJson);
                    drcr.push(drcrJson);
                    bal.push(balJson);
                }else{
                    var proJson = {};
                    var sumJson = {};
                    var drcrJson = {};
                    var balJson = {};
                    proJson.MONTH = d[j-1].YM_BUDGET;
                    proJson.AM_PROPO = d[j-1].AM_PROPO;
                    sumJson.MONTH = d[j-1].YM_BUDGET;
                    sumJson.AM_ACTSUM = d[j-1].AM_ACTSUM;
                    drcrJson.MONTH = d[j-1].YM_BUDGET;
                    drcrJson.AM_DRCR = d[j-1].AM_DRCR;
                    balJson.MONTH = d[j-1].YM_BUDGET;
                    balJson.AM_BAL = d[j-1].AM_ACTSUM - d[j-1].AM_DRCR;
                    propo.push(proJson);
                    sum.push(sumJson);
                    drcr.push(drcrJson);
                    bal.push(balJson);
                    break;
                }
            }

            if(j == d.length){
                var proJson = {};
                var sumJson = {};
                var drcrJson = {};
                var balJson = {};
                proJson.MONTH = d[j-1].YM_BUDGET;
                proJson.AM_PROPO = d[j-1].AM_PROPO;
                sumJson.MONTH = d[j-1].YM_BUDGET;
                sumJson.AM_ACTSUM = d[j-1].AM_ACTSUM;
                drcrJson.MONTH = d[j-1].YM_BUDGET;
                drcrJson.AM_DRCR = d[j-1].AM_DRCR;
                balJson.MONTH = d[j-1].YM_BUDGET;
                balJson.AM_BAL = d[j-1].AM_ACTSUM - d[j-1].AM_DRCR;
                propo.push(proJson);
                sum.push(sumJson);
                drcr.push(drcrJson);
                bal.push(balJson);
            }

            jsonData.propo = propo;
            jsonData.sum = sum;
            jsonData.drcr = drcr;
            jsonData.bal = bal;

            if( val == '0'){
                result.push(jsonData);
                result.push(jsonData);
                result.push(jsonData);
                result.push(jsonData);
            }else{
                result.push(jsonData);
            }
            i = j;
        }
        return result;
    }

    /* 메인리스트 설정
	--------------------------------------------*/
    function fnSetMainList(data){
        // 파라메터 data의 가공 필요.
        var result = fnSetData(data);

        var aoColumn = [ {
            "sTitle" : "<%=BizboxAMessage.getMessage("TX000018982","예산단위그룹명")%>",
			"bVisible" : true,
        "bSortable" : false,
        "sWidth" : "100px",
        "sClass" : "le"
    }, {
			"sTitle" : "<%=BizboxAMessage.getMessage("TX000007549","예산단위명")%>",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : "100px",
			"sClass" : "",
			"sClass" : "le"
    }, {
        "sTitle" : "<%=BizboxAMessage.getMessage("TX000018983","사업계획명")%>",
        "bVisible" : true,
        "bSortable" : false,
        "sWidth" : "100px",
        "sClass" : "le"
    }, {
			"sTitle" : "<%=BizboxAMessage.getMessage("TX000007535","예산계정명")%>",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : "110px",
			"sClass" : "le"
    }, {
        "sTitle" : "<%=BizboxAMessage.getMessage("TX000018984","금액구분")%>",
        "bVisible" : true,
        "bSortable" : false,
        "sWidth" : "100px",
        "sClass" : "le"
    } ];

    var columDefs = [ {
        "targets" : 0,
        "data" : null,
        "render"  : function(data) {
            return  data.NM_BUDGETGR || '' ;
        }
    }, {
        "targets" : 1,
        "data" : null,
        "render" : function(data) {
            return  data.NM_BUDGET || '' ;
        }
    }, {
        "targets" : 2,
        "data" : null,
        "render" : function(data) {
            return  data.NM_BIZPLAN || '' ;
        }
    }, {
        "targets" : 3,
        "data" : null,
        "render" : function(data) {
            return  data.NM_BGACCT || '' ;
        }
    }, {
        "targets" : 4,
        "data" : null,
        "render" : function(data) {
            return  '';
        }
    } ];

    var comboBox = $('#termTypeSel').data("kendoComboBox");
    var val = comboBox.value();

    if( result.length > 0 ){
        // 기간 구분에 따라 컬럼 설정 (월,분기,반기,년)
        if( val == '1'){	// 월
            var fromDt = $('#from_date').val().toString().replace(/-/g, '');
            var toDt = $('#to_date').val().toString().replace(/-/g, '');

			var toYear, toMonth, formYear, fromMonth;
			toYear = Number(toDt.substring(0, 4));
			toMonth = Number(toDt.substring(4, 6));
			formYear = Number(fromDt.substring(0, 4));
			fromMonth = Number(fromDt.substring(4, 6));
			var cnt = ((((toYear - formYear) * 12) + toMonth) - fromMonth) + 1
			
            var title = $('#from_date').val().split('-');
            title[1] = title[1] - 1;

            for( var i=0 ; i < cnt ; i++){
                var aoCol = {};
				title[0] = (title[1] + 1 > 12 ? Number(title[0]) + 1 : title[0]);
				title[1] = (title[1] + 1 > 12 ? 1 : title[1] + 1);
				
                aoCol.sTitle = title[0] + "-" + ( title[1].toString()[1] ?  title[1] : "0"+title[1] );
                aoCol.bVisible = true;
                aoCol.bSortable = false;
                aoCol.sWidth = "120px";
                aoCol.sClass = "ri";

                aoColumn.push(aoCol);

                var colDef = {};
                colDef.targets = 5 + i ;
                colDef.data = null;
                colDef.render = function(data) {
                    return "-";
                }

                columDefs.push(colDef);
            }
        }else if( val == '2' ){		// 분기
            for( i=0 ; i<4 ; i++){
                var aoCol = {};
                aoCol.sTitle = (i+1)+"<%=BizboxAMessage.getMessage("TX000009444","분기")%>";
                aoCol.bVisible = true;
                aoCol.bSortable = false;
                aoCol.sWidth = "";
                aoCol.sClass = "ri";
                aoColumn.push(aoCol);

                var colDef = {};
                colDef.targets = 5 + i ;
                colDef.data = null;
                colDef.render = function(data) {
                    return "-";
                }
                columDefs.push(colDef);
            }
        }else if( val == '3' ){		// 반기
            for( i=0 ; i<2 ; i++){
                var aoCol = {};
                aoCol.sTitle = (i == 0 ? "<%=BizboxAMessage.getMessage("TX000009443","상반기")%>" : "<%=BizboxAMessage.getMessage("TX000009442","하반기")%>");
                aoCol.bVisible = true;
                aoCol.bSortable = false;
                aoCol.sWidth = "";
                aoCol.sClass = "ri";
                aoColumn.push(aoCol);

                var colDef = {};
                colDef.targets = 5 + i ;
                colDef.data = null;
                colDef.render = function(data) {
                    return "-";
                }
                columDefs.push(colDef);
            }
        }else if( val == '4' ){		// 년
            var year = $('#from_date').val().toString().split('-');

            var aoCol = {};
            aoCol.sTitle = year[0] + "<%=BizboxAMessage.getMessage("TX000000435","년")%>";
            aoCol.bVisible = true;
            aoCol.bSortable = false;
            aoCol.sWidth = "250px";
            aoCol.sClass = "ri";
            aoColumn.push(aoCol);

            var colDef = {};
            colDef.targets = 5 ;
            colDef.data = null;
            colDef.render = function(data) {
                return "-";
            }
            columDefs.push(colDef);
        }
    }

    // 그리드 그리기 호출
    fnSetGridView('Yesil2View', result, aoColumn, columDefs);
    }

    /*	[뷰-그리드] 예산코드 과목명 출력
 	--------------------------------------*/
    function fnSetGridView( elemID, data, aoColumn, columDefs ){
        columDefs = (columDefs || {});

        var id = '' + elemID;
        id = id[0] == '#' ? id : '#' + id;

        var oTable = $(id).DataTable({
            "aaSorting": [],
            "select" : false,
            "paging" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "paging" : false,
            "scrollX" : true,
            "scrollY" : $(window).height() * 0.7,
            "scrollCollapse" : true,
            "fixedColumns" :   {
                leftColumns: 5
            },
            "lengthMenu" : [ [ 10, -1 ], [ 10, "All" ] ],
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
            "info" : "_PAGE_ / _PAGES_",
            "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
    },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                var comboBox = $('#inquirySel').data("kendoComboBox");
                var inquiryVal = comboBox.value();
                var comboBox = $('#termTypeSel').data("kendoComboBox");
                var termVal = comboBox.value();

                var startMonth = Number($('#from_date').val().toString().split('-')[1]) -1;
                var rData = 0;
                var rIndex = 4;
                var preIndex = 1;

                var inquiryNm = ['1.' + "<%=BizboxAMessage.getMessage("TX000009448","편성예산")%>"
				                 ,'2.' + "<%=BizboxAMessage.getMessage("TX000007560","실행합금액")%>"
				                 ,'3.' + "<%=BizboxAMessage.getMessage("TX000009445","집행실적")%>"
				                 ,'4.' + "<%=BizboxAMessage.getMessage("TX000018979","집행잔액")%>"];
                var forData = [aData.propo, aData.sum, aData.drcr, aData.bal];

                var modValue = iDisplayIndex % 4;
                if(inquiryVal == '0'){		// 조회구분 (전체)
                    nRow.cells[4].innerHTML = inquiryNm[modValue];

                    $(forData[modValue]).each(function(index, element){
                        var viewData = [element.AM_PROPO , element.AM_ACTSUM, element.AM_DRCR, element.AM_BAL];
                        var month = element.MONTH.substring(4, element.MONTH.length);

                        if(termVal == '1'){		// 월
                            rIndex = rIndex + Number(month) - startMonth;
                            nRow.cells[rIndex].innerHTML = (viewData[modValue] || 0).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        }else{		// 분기, 반기, 년
                            if(termVal == '2'){
                                var quarter = Math.ceil(month/3);
                                rIndex = rIndex + quarter;
                                if( quarter != preIndex ){
                                    rData = 0;
                                    preIndex = quarter;
                                }
                                rData = rData + Number(viewData[modValue]);
                                nRow.cells[rIndex].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }else if(termVal == '3'){
                                var half = Math.ceil(month/6);
                                rIndex = rIndex + half;
                                if( half != preIndex ){
                                    rData = 0;
                                    preIndex = half;
                                }
                                rData = rData + Number(viewData[modValue]);
                                nRow.cells[rIndex].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }else if(termVal == '4'){
                                rData = rData + Number(viewData[modValue]);
                                nRow.cells[rIndex+1].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }
                        }
                        rIndex = 4;
                    });
                }else {	// 조회구분 (나머지)
                    nRow.cells[4].innerHTML = inquiryNm[inquiryVal-1];

                    $(forData[inquiryVal-1]).each(function(index, element){
                        var viewData = [element.AM_PROPO , element.AM_ACTSUM, element.AM_DRCR, element.AM_BAL];
                        var month = element.MONTH.substring(4, element.MONTH.length);

                        if(termVal == '1'){
                            rIndex = rIndex + Number(month) - startMonth;
                            nRow.cells[rIndex].innerHTML = viewData[inquiryVal-1].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        }else{
                            if(termVal == '2'){
                                var quarter = Math.ceil(month/3);
                                rIndex = rIndex + quarter;
                                if( quarter != preIndex ){
                                    rData = 0;
                                    preIndex = quarter;
                                }
                                rData = rData + Number(viewData[inquiryVal-1]);
                                nRow.cells[rIndex].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }else if(termVal == '3'){
                                var half = Math.ceil(month/6);
                                rIndex = rIndex + half;
                                if( half != preIndex ){
                                    rData = 0;
                                    preIndex = half;
                                }
                                rData = rData + Number(viewData[inquiryVal-1]);
                                nRow.cells[rIndex].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }else if(termVal == '4'){
                                rData = rData + Number(viewData[inquiryVal-1]);
                                nRow.cells[rIndex+1].innerHTML = rData.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                            }
                        }
                        rIndex = 4;
                    });
                }
            },
            "columnDefs" : columDefs,
            "aoColumns" : aoColumn
    });

    if(data.length == 0){
        $('.DTFC_NoData .dataTables_empty').text("<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>");
    }

    var comboBox = $('#termTypeSel').data("kendoComboBox");
    var val = comboBox.value();

    $(".DTFC_LeftBodyLiner table").css("border-top", "0");
    $(".DTFC_LeftBodyLiner tbody tr td").css("border-left", "1px solid #eaeaea");
    $(".DTFC_LeftBodyLiner tbody tr td:eq(0)").css("border-left", "1px solid #eaeaea");
    $(".DTFC_LeftBodyLiner table").css("border-right", "1px solid #eaeaea");
    $(".DTFC_LeftHeadWrapper table thead tr").css("border-right", "1px solid #eaeaea");

    if(val != 1){
        $(".dataTables_scrollHeadInner , .dataTables_scrollHeadInner table").css("width", "");
        $(".DTFC_LeftWrapper").css("width", $(".DTFC_LeftWrapper").width()-1 );
        $(".DTFC_LeftBodyWrapper").css("height","");
        $(".DTFC_LeftBodyLiner").height($(".dataTables_scrollBody").height());
    }

    var comboBox = $('#inquirySel').data("kendoComboBox");
    var val = comboBox.value();

    // 셀 병합
    if(val == '0'){
        fnUserYesil2RowSpan1();
    }
    fnUserYesil2RowSpan2(2);
    fnUserYesil2RowSpan2(1);
    fnUserYesil2RowSpan2(0);
    }

    /*	[뷰-그리드] 셀 병합1
 	--------------------------------------*/
    function fnUserYesil2RowSpan1(){
        $('.DTFC_LeftBodyLiner table tbody tr').each(function(row){
            var thisTr = $(this);
            if(row % 4 == 0){
                $(".DTFC_LeftBodyLiner table tbody tr:eq("+row+") > td:eq(3)").attr("rowspan",4);
            }else{
                $("td:eq(3)",thisTr).remove();
            }
        });
    }

    /*	[뷰-그리드] 셀 병합2
 	--------------------------------------*/
    function fnUserYesil2RowSpan2(nEq){
        var mergeItem = "";
        var mergeCount = 0;
        var mergeRowNum = 0;

        $('.DTFC_LeftBodyLiner table tbody tr').each(function(row){
            var thisTr = $(this);
            var item = $(thisTr).find('td').eq(nEq).html();

            if(mergeItem != item){
                mergeCount = 1;
                mergeItem = item;
                mergeRowNum = Number(row);
            }else{
                mergeCount = Number(mergeCount) + 1;
                $(".DTFC_LeftBodyLiner table tbody tr:eq("+mergeRowNum+") > td:eq("+nEq+")").attr("rowspan",mergeCount);

                if(mergeCount != 1){
                    $("td:eq("+nEq+")",thisTr).remove();
                }
            }
        });
    }
    
	function tableToJson(table) {
	    var myRows = [];
	    var title = [];
	    var $headers = $(".dataTables_scrollHeadInner > table > thead > tr > th ");
	    $headers.each(function(index, item) {
	        title[index] = $(item).html();
	    });
	    
	    var $rows = $("#Yesil2View > tbody > tr");
	    $rows.each(function(index, item){
	    	$cells = $(this).find("td");
            myRows[index] = {};
            $cells.each(function(cellIndex) {
                myRows[index][title[cellIndex]] = $(this).html();
            });
	    });
	 
	    var myObj = {};
	    myObj = myRows;
	 
	    var myJson = JSON.stringify(myObj);
	    return [ title, myJson ];
	}
	
	function excelDown(){
		
		var myTable = $('#Yesil2View');
		var rows = 0;
		rows = $("#Yesil2View > tbody > .odd").length;
        if (rows < 1) {
            alert("데이터가 없습니다.");
            return;
        }
        	 var dataParam = tableToJson(myTable);
             var myTitle = dataParam[0];
             var inputHead = '';
             
             var excelHeader = {};
             $.each(myTitle,function(index){
            	 inputHead =  myTitle[index];
            	 excelHeader[inputHead] = inputHead;
             });
             
             var myContents = dataParam[1];
     		
     		$("#fileName").val( "나의 예실대비 현황(ERPiU)" );
     		
     		/* 엑셀 헤더 지정 */
     		$("#excelHeader").val( JSON.stringify(excelHeader) );
     		
     		/* 엑셀 데이터 지정 */
     		$("#tableData").val(myContents );
     		
        
        
      	
		var url = "<c:url value='/ex/user/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
		
	}
    

</script>
<!-- body -->
<!-- hidden -->
<input type="hidden" value="" id="hid_budgetGrCode" />
<input type="hidden" value="" id="hid_deptCode" />
<!-- iframe wrap -->
<div class="iframe_wrap">
    <div class="sub_contents_wrap">
        <!-- 컨트롤박스 -->
        <div class="top_box">
            <dl>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000007249","예산년월")%></dt>
                <dd>
                    <input id="from_date" value="" class="dpWid datepicker" />
                    ~
                    <input id="to_date" value="" class="dpWid datepicker" />
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000009968","결의부서")%></dt>
                <dd>
                    <input type="text" id="deptTxt" style="width:120px;" readonly="readonly" />
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000007053","기간구분")%></dt>
                <dd>
                    <input id="termTypeSel" style="width:120px;" class="kendoComboBox" />
                </dd>
                <dd class="ml25"><input type="button" id="searchButton" value="<%=BizboxAMessage.getMessage(" TX000001289","검색")%>" /></dd>
                <dd class="ml5">
					<input type="button" id="btnExcelDown" value="<%=BizboxAMessage.getMessage("TX000009553","엑셀다운로드")%>" />
				</dd>
            </dl>
            <span class="btn_Detail">
                <%=BizboxAMessage.getMessage("TX000005724","상세검색")%> <img id="all_menu_btn"
                                                                          src='../../../Images/ico/ico_btn_arr_down01.png' />
            </span>
        </div>
        <div class="SearchDetail">
            <dl>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000018985","예산단위그룹")%></dt>
                <dd style="width:200px;">
                    <input type="text" id="budgetGr" style="width:120px;" />
                    <input id="budgetGrPopBtn" type="button" class="normal_btn" value="<%=BizboxAMessage.getMessage(" TX000000265","선택")%>">
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000007201","예산단위")%></dt>
                <dd style="width:200px;">
                    <input id="budgetDeptSel" style="width:120px;" class="kendoComboBox" />
                    <input id="budgetDeptPopBtn" type="button" class="normal_btn" value="<%=BizboxAMessage.getMessage(" TX000000265","선택")%>">
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000018986","사업계획")%></dt>
                <dd style="width:200px;">
                    <input id="bizPlanSel" style="width:120px;" class="kendoComboBox" />
                    <input id="bizPlanPopBtn" type="button" class="normal_btn" value="<%=BizboxAMessage.getMessage(" TX000000265","선택")%>">
                </dd>
            </dl>
            <dl>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000018987","계정라벨")%></dt>
                <dd style="width:200px;">
                    <input id="acctLevelSel" style="width:120px;" class="kendoComboBox" />
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000005263","예산계정")%></dt>
                <dd style="width:200px;">
                    <input id="budgetAcctSel" style="width:120px;" class="kendoComboBox" />
                    <input id="budgetAcctPopBtn" type="button" class="normal_btn" value="<%=BizboxAMessage.getMessage(" TX000000265","선택")%>">
                </dd>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000018988","집행구분")%></dt>
                <dd style="width:200px;">
                    <input id="executeSel" style="width:120px;" class="kendoComboBox" />
                </dd>
            </dl>
            <dl>
                <dt style="width:80px;"><%=BizboxAMessage.getMessage("TX000000854","조회구분")%></dt>
                <dd style="width:200px;">
                    <input id="inquirySel" style="width:120px;" class="kendoComboBox" />
                </dd>
            </dl>
        </div>
        <div id="" class="controll_btn cl"></div>
        <div>
            <div class="com_ta2 bg_lightgray viewDiv">
                <table id="Yesil2View">
                    <thead>
                        <tr>
                            <th>${CL.ex_budgetUnitGroupNm} <!--예산단위그룹명--></th>
                            <th>${CL.ex_budgetUnitNm} <!--예산단위명--></th>
                            <th>${CL.ex_bussinessPlanNm} <!--사업계획명--></th>
                            <th>${CL.ex_accNm} <!--예산계정명--></th>
                            <th>${CL.ex_budgetDiv} <!--금액구분--></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td rowspan="4" colspan="5"><b>검색할 조건을 선택한 후 검색버튼을 클릭하세요.</b><br />조회범위가 크면 검색시간이 오래 소요될 수 있습니다.</td>
                        </tr>
                        <tr style="height: 50px;"></tr>
                        <tr style="height: 50px;"></tr>
                        <tr style="height: 50px;"></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <form id="excelDownload" name="excel" method="post">
   		<input type="hidden" name="tableData" value="" id="tableData">
    	<input type="hidden" name="excelHeader" value="" id="excelHeader" />
    	<input type="hidden" name="fileName" value="" id="fileName">
	</form>
    
</div>
