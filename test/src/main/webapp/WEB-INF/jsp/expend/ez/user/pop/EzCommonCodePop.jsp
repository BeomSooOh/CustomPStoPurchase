<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">

<!--  js 파일 모음 -->
<script type="text/javascript"
	src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/Scripts/common.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/kendoui/jquery.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/jquery-ui-1.10.4.js"></c:url>'></script>
	
<script type="text/javascript"
	src='<c:url value="/js/kendoui/kendo.all.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/ez/jquery.maskedinput.js"></c:url>'></script>

<!-- UC TABLE JS -->
<script type="text/javascript" src='<c:url value="/js/ez/jquery.ucdevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/jquery.uckeydevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezVariable.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezCodePop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezDisplay.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezSave.js"></c:url>'></script>	
<!-- jquery Mask  -->
<script type="text/javascript" src='<c:url value="/js/ez/jquery.mask.js"></c:url>'></script>


<!--  css 파일 모음 -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.common.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.dataviz.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.mobile.all.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.silver.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/common.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/reKendo.css"></c:url>'>
	
<script type="text/javascript">
	var CO_CD = '${CO_CD}' || 0;
	var LANGKIND = '${LANGKIND}' || 'KOR';
	var EMP_SEQ = '${EMP_SEQ}' || '';
	
	var updateList = [];
	var rowCount = -1;

	/* 테이블 헤더 json 선언 */
	var codeJsonHeader = [ {
		no : '-10',
		tail : 'N',
		popupCustLoadFunc : '',
		popupCustBindFunc : '',
		focusCustFunc : '',
		displayClass : '',
		titleName : '구분코드',
		id : 'CODE',
		value : '',
		requierdYN : 'N',
		inputType : 'text',
		codeHelperYN : 'N',
		width : '150px',
		tdClass : 'le',
		inputClass : 'td_inp',
		mask : '',
		helpDeskMessage : ''
	},{
		no : '-11',
		tail : 'N',
		popupCustLoadFunc : '',
		popupCustBindFunc : '',
		focusCustFunc : '',
		displayClass : '',
		titleName : '구분항목',
		id : 'CDNM',
		value : '',
		requierdYN : 'N',
		inputType : 'text',
		codeHelperYN : 'N',
		width : '150px',
		tdClass : 'le',
		inputClass : 'td_inp',
		mask : '',
		helpDeskMessage : ''
	},{
		no : '2',
		tail : 'N',
		popupCustLoadFunc : '',
		popupCustBindFunc : '',
		focusCustFunc : '',
		displayClass : '',
		titleName : '표시구분(1:사용/ 0:미사용)',
		id : 'USEFG',
		value : '',
		requierdYN : 'N',
		inputType : 'text',
		codeHelperYN : 'N',
		width : '150px',
		tdClass : 'le',
		inputClass : 'td_inp',
		mask : 'maskNum1',
		helpDeskMessage : ''
	},{
		no : '3',
		tail : 'Y',
		popupCustLoadFunc : '',
		popupCustBindFunc : '',
		focusCustFunc : '',
		displayClass : '',
		titleName : '순번',
		id : 'SORTNB',
		value : '',
		requierdYN : 'N',
		inputType : 'text',
		codeHelperYN : 'N',
		width : '150px',
		tdClass : 'le',
		inputClass : 'td_inp',
		mask : 'maskNum2',
		helpDeskMessage : ''
	}];
	
	
	$(document).ready(function() {
		$.devTable.create(codeJsonHeader, 'commonCodeContent', 'N', '1', '375', 'N', 'Y', 'Y');
		var contentTable =  "commonCodeContent";
		focusJsonList[contentTable] = codeJsonHeader;
		fnRegUCTableKeyEvent();
		fnLoadCommonCode();
		
		/* 마스크 넣기 */
		$('.maskNum1').mask('A',{
			translation:{
				'A':{
					pattern : /[0-1]/, optional : true
				}
			}				
		});
		
		$('.maskNum2').mask('ABC',{
			translation:{
				'A':{
					pattern : /[0-9]/, optional : true
				},
				'B':{
					pattern : /[0-9]/, optional : true
				},
				'C':{
					pattern : /[0-9]/, optional : true
				}
			}				
		});
		
		/* 셀렉트 박스 체인지 이벤트 */
		$("#selGubun").change(function(){
			fnLoadCommonCode();
		})
		
	});
	
// 	/* 표시구분 포커스 커스터마이징 */
// 	function fnFocusCustUSE(headerJsonList, curElement){
// 		$(curElement).unbind('keydown');
		
// 		$(curElement).keydown(function(){
// 			var eleId = $(curElement).attr('id');
// 			var arrId = eleId.split('_');
			
// 			var matchYN = 'N';
// 			/* 같은 유형이 존재하는지 확인 */
// 			$.each(updateList,function(index,item){
// 				if( item.CDDIV == $("#selGubun").val() && item.CODE == $("#CODE_"+arrId[1]+"_-10").val()){
// 					//item.USE_FG = $(curElement).val();
// 					updateList[index].USE_FG =$(curElement).val();
// 					matchYN = 'Y';
// 					return false;
// 				}
// 			});
			
// 			if(matchYN == "N"){
// 				var updateData = {};
// 				/* 기본 항목 */
// 				updateData.LANGKIND = LANGKIND;
// 				updateData.CO_CD = CO_CD;
// 				updateData.OFCODE = 'KNRF';
// 				updateData.INSERT_ID = EMP_SEQ;
// 				/* 수정에 필요한 항목*/
// 				updateData.CDDIV = $("#selGubun").val();
// 				updateData.CODE = $("#CODE_"+arrId[1]+"_-10").val();
// 				/* 수정 항목 */
// 				updateData.USE_FG = $(curElement).val();
// 				updateData.SORT_NB = $("#SORTNB_"+arrId[1] +"_3").val() || '0';
// 				/* 데이터 넣기*/
// 				updateList.push(updateData);
// 			}
// 			//hdnCommonCodeSaveList
// 			$(curElement).unbind('keydown');
// 		});

// 	}
	
	
// 	/* 표시구분 포커스 커스터마이징 */
// 	function fnFocusCustSORTNB(headerJsonList, curElement){
// 		$(curElement).unbind('keydown');
		
// 		$(curElement).keydown(function(){
// 			var eleId = $(curElement).attr('id');
// 			var arrId = eleId.split('_');
			
// 			var matchYN = 'N';
// 			/* 같은 유형이 존재하는지 확인 */
// 			$.each(updateList,function(index,item){
// 				if( item.CDDIV == $("#selGubun").val() && item.CODE == $("#CODE_"+arrId[1]+"_-10").val()){
// 					//item.USE_FG = $(curElement).val();
// 					updateList[index].SORT_NB =$(curElement).val();
// 					matchYN = 'Y';
// 					return false;
// 				}
// 			});
			
// 			if(matchYN == "N"){
// 				var updateData = {};
// 				/* 기본 항목 */
// 				updateData.LANGKIND = LANGKIND;
// 				updateData.CO_CD = CO_CD;
// 				updateData.OFCODE = 'KNRF';
// 				updateData.INSERT_ID = EMP_SEQ;
// 				/* 수정에 필요한 항목*/
// 				updateData.CDDIV = $("#selGubun").val();
// 				updateData.CODE = $("#CODE_"+arrId[1]+"_-10").val();
// 				/* 수정 항목 */
// 				updateData.USE_FG = $("#USEFG_"+arrId[1] +"_2").val();
// 				updateData.SORT_NB = $(curElement).val() || '0';
// 				/* 데이터 넣기*/
// 				updateList.push(updateData);
// 			}
// 			//hdnCommonCodeSaveList
// 			$(curElement).unbind('keydown');
// 		});

// 	}
	
	
	
	
	/* 이지바로 공통코드 불러오기 */
	function fnLoadCommonCode(params){	
		//var regseq = 0;
		var params  ={};
		params.CO_CD = CO_CD;
		params.LANGKIND = LANGKIND;
		params.CDDIV = $("#selGubun").val();
		
		$.ajax({
			async : false,
			type : "post",
			datatype : "json",
			data : params,
			url : '<c:url value="/expend/ez/user/EzbaroGetCommonCodeSelect.do" />',
			datatype : "json",
			success : function(resultData) {
				fnSetUCTable(resultData.result);
			},
			error : function(err) {
				console.log(err);
			}
		});	
		//return regseq;
	}
	
	function fnSetUCTable(result){
		$("#commonCodeContent_TRDATA").html('');
		var dataList = [];
		dataList = result;
		
		/* 데이터 리스트 */
		$.each(dataList,function(index,item){
			rowCount = Number(rowCount) + 1;
			$.devTable.addrow('commonCodeContent', codeJsonHeader, '1', 'commonCodeContent_TRDATA' ,rowCount, 'Y');
			fnRegUCTableKeyEvent();
			$("#CODE"+"_"+rowCount+"_-10").val(item.CODE);
			$("#CODE"+"_"+rowCount+"_-10").attr("readonly",'true');
			$("#CDNM"+"_"+rowCount+"_-11").val(item.CDNM);
			$("#CDNM"+"_"+rowCount+"_-11").attr("readonly",'true');
			$("#USEFG"+"_"+rowCount+"_2").val(item.USE_FG);
			
			if(item.SORT_NB != '0'){
				$("#SORTNB"+"_"+rowCount+"_3").val(item.SORT_NB);
			}
		});
		
		if($("#USEFG_0_2").length > 0){
			$("#USEFG_0_2").focus();
			$("#USEFG_0_2").click();
		}
	}
	
	/* 저장 버튼 클릭 */
	function fnSaveEzCommonCode(){
		var tblRowCount = $("#commonCodeContent_TRDATA").find('tr').length;
		
		for(var i=0; i<=tblRowCount; i++){
			var updateData = {};
			/* 기본 항목 */
			updateData.LANGKIND = LANGKIND;
			updateData.CO_CD = CO_CD;
			updateData.OFCODE = 'KNRF';
			updateData.INSERT_ID = EMP_SEQ;
			/* 수정에 필요한 항목*/
			updateData.CDDIV = $("#selGubun").val();
			updateData.CODE = $("#CODE_"+ i +"_-10").val();
			/* 수정 항목 */
			updateData.USE_FG = $("#USEFG_"+ i +"_2").val() || '0';
			updateData.SORT_NB = $("#SORTNB_"+ i +"_3").val() || '0';
			/* 데이터 넣기*/
			updateList.push(updateData);
			
		}
		console.log(updateList);
		
		if(updateList.length > 0){
			var params = { 'updateList' : JSON.stringify(updateList) }; 
			$.ajax({
				async : false,
				type : "post",
				datatype : "json",
				data : params,
				url : '<c:url value="/expend/ez/user/EzbaroGetCommonCodeUpdate.do" />',
				datatype : "json",
				success : function(resultData) {
					if(resultData.result == 'sucess'){
						alert('저장을 완료하였습니다.');
					}
				},
				error : function(err) {
					console.log(err);
				}
			});	
		}
	}
	/* 자기자신 창 닫기 */
	function fnClose(){
		self.close();
	}
	
</script>

<head></head>

<body>
	<div class="pop_wrap brbn">
		<div class="pop_sign_head posi_re">
			<h1>공통코드 설정</h1>
			<div class="psh_btnbox">
			</div>
		</div>
	</div>
	<div class="pop_con">
		<div class="top_box ovh">
		<dl>
			<dt class="ar" style="width: 94px;">코드구분</dt>
			<dd class="ml20" style="width:150px;">
	              <select id="selGubun" class="selectmenu" style="width:148px;">
						<option value="A01" selected="selected">사용용도(집행구분)</option>
						<option value="A02">연구자구분</option>
						<option value="A03">연구자성별</option>
						<option value="A04">연구자역할구분</option>
						<option value="A05">집행요청구분</option>
						<option value="A06">집행방법</option>
						<option value="A07">은행코드</option>
						<option value="A08">물품구분</option>
						<option value="A09">카드종류코드</option>
						<option value="A10">자료송신여부</option>
						<option value="A11">자료송신옵션</option>
						<option value="A12">인증여부</option>
						<option value="A13">취소여부</option>
						<option value="A14">집행요청상태</option>
						<option value="A15">지급구분</option>
						<option value="A16">소속구분</option>
						<option value="A17">전문가활용구분</option>
						<option value="A18">시내외구분</option>
				</select>
             </dd>
        </dl>
		</div>
		<!--  공통코드 리스트 ------------------------------------------------------------------------------------------------------------------------->
		<div id="commonCodeContent" class="mt20">
		</div>
	</div>
	
	<div class="pop_foot">
        <div class="btn_cen pt12">
            <!--<input type="button" value="자료수집" />-->
            <input type="button" onClick="fnSaveEzCommonCode()" value="저장" />
            <input type="button" onClick="fnClose()" value="취소" />
        </div>
    </div><!-- //pop_foot -->

</body>
</html>