<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_draftType}  <!--양식구분--></dt>
			<dd style="margin-top:18px;">
				<input type="radio" id="radi1" name="radi_docGbn" value="0" checked>
				<label for="radi1">${CL.ex_consDoc}  <!--품의서--></label>
				<input type="radio" id="radi2" name="radi_docGbn" value="1" class="ml10">
				<label for="radi2">${CL.ex_resDoc}  <!--결의서--></label>
			</dd>
			<dt>${CL.ex_formNm}  <!--양식명--></dt>
			<dd>
				<select id="list_formList" class="selectmenu" style="width:200px">
				</select>		
			</dd>
		</dl>
	</div>

	<div class="btn_div mt0">
		<div class="left_div">
			<h5>${CL.ex_defaultSet}  <!--기본설정--></h5>
			<div class="cl ml10 lh20">
				${CL.ex_erpBgtAndGwResConsSet}  <!--ERP 예산과 연동되는그룹웨어의 지출품의/결의 기본환경을 설정합니다.--> 
				<%--<br /> ${CL.ex_notUseCons}  <!--품의서 미사용 또는 품의서 예산 미통제시, 결의서는 참조품의서의 금액통제를 받지 않습니다.--> --%>
				<br /> 공통 설정 영역은 양식별 설정이 불가합니다. 
			</div>
		</div>
		<div class="right_div">
			<div class="controll_btn p0 pt35">
				<button id="btnSave">${CL.ex_save}  <!--저장--></button>
			</div>
		</div>
	</div>


	<div class="com_ta mt10">
		<table id="tblMasterOption">
			<colgroup>
				<col width="100" />
				<col width="200" />
				<col width="" />
			</colgroup>
		</table>
	</div>
	
<div class="btn_div mt20">
	<div class="left_div">
		<h5>품의서 참조 회사권한 <span id="txt_consAuthCount">(3)</span></h5>
	</div>
	<div class="right_div">
		<div class="controll_btn p0">
			<button id="btn_authUserSel" class="puddSetup" >선택</button>
		</div>
	</div>								
</div>

<div class="int_org mt10 p10" style="height:145px;" id="div_selUsers">

								
</div>
<!-- //sub_contents_wrap -->



<script>

	var optionInfoList = []; 
	/*	[ready] 품의결의 공통 옵션
	---------------------------------------------- */
	$(document).ready(function() {
		
		/* 엘리먼트 이벤트 초기화 */
		fnInitButton();
		
		/* 양식 선택 레이아웃 초기화 */
		fnCommonFormInitLayout();
		
		/* 엘리먼트 레이아웃 초기화 */
		fnInitLayout();
		
		/* 참조품의 권한 조회 */
		FnCompConsAuthSelect();
		
	});

	/*	[초기화] 버튼 설정 초기화
	---------------------------------------------- */
	function fnInitButton() {
		/* 버튼 - 저장 */
		$("#btnSave").unbind('click').on("click",function() {
			fnOptionSave();
		});
		
		/* 버튼 - 권한자 선택 */
		$('#btn_authUserSel').unbind('click').on("click",function() {
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
	}
	
	/*	[초기화] 레이아웃 초기화
	---------------------------------------------- */
	function fnInitLayout(){
		var nowOptionGbn = '';
		$("#tblMasterOption tr").remove();
		$.each(optionInfoList, function(idx,val){
			var tr = document.createElement('tr');
			if( ['1', '2', '3'].indexOf( val.optionGbn ) == -1 ){
				return;
			}
			if(val.optionGbn != nowOptionGbn){
				switch(val.optionGbn){
					case "1":
						$(tr).append('<th rowspan="'+val.optionLength+'">공통</th>');
						
						break;
					case "2":
						$(tr).append('<th rowspan="'+val.optionLength+'">품의서</th>');
						break;
					case "3":
						$(tr).append('<th rowspan="'+val.optionLength+'">결의서</th>');
						break;
					default :
						$(tr).append('<th rowspan="'+val.optionLength+'"></th>');
						break;
				}
			}
			$(tr).append('<th>'+val.note+'</th>');
			var td = document.createElement('td');
			td.className = 'al';
			var optionCode = val.optionGbn + "_" + val.optionCode;
			var checkedValue = val.setValue || '';
			var valueList = JSON.parse(val.optionList);
			
			for(var index = 0; index < valueList.length; index++){
				
				var value = valueList[index];
				var p = document.createElement('p');
				p.className = 'fl';
				p.style.width = "150px";
				
				var isRes = ( $("input[name='radi_docGbn']:checked").val() || '0' );
				var isDisabled = ((isRes == '0') && (val.optionGbn == '3')) ? ' disabled' : '' ;
				isDisabled = ((isRes == '1') && (val.optionGbn == '2')) ? ' disabled' : isDisabled ;
				var isChecked = false;
				
				if(val.optionSelectType == 'radio'){
					isChecked = (checkedValue==value.code?'checked=""':'');
					$(p).append('<label>');
					$(p).append('<input type="radio" value="'+value.code+'" name="'+optionCode+'" id="'+optionCode+"_"+value.code+'" '+isChecked + ' ' + isDisabled + '>');
					$(p).append('<span>  '+ value.name+'</span></label>');
				}else if(val.optionSelectType == 'checkbox'){
					isChecked = ( (checkedValue.indexOf(value.code) > -1 )?'checked=""':'');
					$(p).append('<label>');
					$(p).append('<input type="checkbox" value="'+value.code+'" name="'+optionCode+'" id="'+optionCode+"_"+value.code+'" '+ isChecked + ' ' + isDisabled + '>');
					$(p).append('<span>  '+ value.name+'</span></label>');

				}
				$(td).append(p);
			}
			
			$(tr).append(td);
			$("#tblMasterOption").append(tr);
			nowOptionGbn = val.optionGbn;
		});
	}
	
	/*	[ 양식구분 ] 양식구분 라디오/ 양식정보 셀렉트 초기화
	------------------------------------------------- */
	function fnCommonFormInitLayout() {
		var formList = ${aaData};
		var consFormList = [];		// 품의서 양식 리스트
		var resFormList = [];		// 결의서 양식 리스트
		console.log('AdminNPMasterOption.jsp formList >> ', formList);
		
		for(var i = 0; i < formList.length; i++){
			var item = formList[i];
			
			if(item.formDTp == 'EXNPCONU' || item.formDTp == 'EXNPCONI' || item.formDTp == 'EXNPCON'|| item.formDTp == 'TRIPCONS'){
				consFormList.push(item);
			}else if(item.formDTp == 'EXNPRESU' || item.formDTp == 'EXNPRESI'|| item.formDTp == 'EXNPRES'|| item.formDTp == 'TRIPRES'){
				resFormList.push(item);
			}
		}
		
		/* 라디오 박스 이벤트 등록 */
		$('input[name=radi_docGbn]').on('change', function() {
			// 체인지 이벤트
			var targetList = [];
			if($("input[name='radi_docGbn']:checked").val() == '0'){
				targetList = consFormList;
			}else if($("input[name='radi_docGbn']:checked").val() == '1'){
				targetList = resFormList;
			}
			/* 셀렉트 박스 이벤트 등록 */
			$("#list_formList").empty();
			$(targetList).each(function(index, data){
				$("#list_formList")[0].add(new Option(data.formName, data.formSeq));
			});
			/* 양식 상세 검색 진행 */
			fnCommonFormSearch();
		});
		
		/* 셀렉트 박스 이벤트 등록 */
		$(consFormList).each(function(index, data){
			$("#list_formList").empty();
			$("#list_formList")[0].add(new Option(data.formName, data.formSeq));
		});
		
		/* 양식리스트 */
		$('#list_formList').change(function(){
			fnCommonFormSearch();
		});
	}
	
	/*	[조회] 양식별 옵션 조회
	---------------------------------------------- */
	function fnCommonFormSearch(){
		console.log('양식별 옵션 조회');
		var formSeq = $("#list_formList").val();
		var formTp = ''; 
		if($("input[name='radi_docGbn']:checked").val() == '0'){
			if('${erpType}' == 'iCUBE'){
				formTp = 'EXNPCONI'
			}else if('${erpType}' == 'ERPiU'){
				formTp = 'EXNPCONU'
			}
		}else if($("input[name='radi_docGbn']:checked").val() == '1'){
			if('${erpType}' == 'iCUBE'){
				formTp = 'EXNPRESI'
			}else if('${erpType}' == 'ERPiU'){
				formTp = 'EXNPRESU'
			} 
		}
		
		console.log('formSeq : ' + formSeq + ' formTp : ' + formTp);
		
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpAdminOptionSelect.do" />',
			datatype : 'json',
			async : false,
			data : {
				'formSeq' : formSeq 
				,' formTp' : formTp
			},
			success : function(data) {
				if(data.result.resultCode == 'SUCCESS'){
					optionInfoList = data.result.aaData;
					fnInitLayout();
				}else{
					console.log(JSON.stringify(data));
				}
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}
	
	
	/*	[저장] 변경 옵션 저장
	---------------------------------------------- */	
	function fnOptionSave() {
		/* 변경된 내용이 있는 옵션만 저장 진행 */
		var updateOption = [];
		var commitChks = [];
		$.each(optionInfoList, function(idx,val){
			var isChange = false;
			var setValue = '';
			if( val.optionSelectType == 'radio' ){
				isChange = val.setValue != $(":radio[name='"+val.optionGbn+"_"+val.optionCode+"']:checked").val();
				setValue = $(":radio[name='"+val.optionGbn+"_"+val.optionCode+"']:checked").val();
			}else if( val.optionSelectType == 'checkbox' ){
				if(commitChks.indexOf( val.commonCode ) > -1){
					return;
				}
				var selDatas = jQuery.map($(":checkbox[name='"+val.optionGbn+"_"+val.optionCode+"']:checked"), function (val){return (val.defaultValue || '')});
				isChange = val.setValue != selDatas.join('');
				setValue = selDatas.join('');
				
			}
			
			
			if(isChange){
				var params = {};
				params.optionGbn = val.optionGbn;
				params.optionCode = val.optionCode;
				params.commonCode = val.commonCode;
				params.setValue = setValue
				params.formSeq = $("#list_formList").val();
				if( params.optionGbn == '1' ){
					params.formSeq = '-999';					
				}
				
				$.ajax({
					type : 'post',
					url : '<c:url value="/expend/np/admin/NpMasterOptionUpdate.do" />',
					datatype : 'json',
					async : false,
					data : params,
					success : function(data) {
						if(data.result.resultCode == 'SUCCESS'){
							if( val.optionSelectType == 'radio' ){
								optionInfoList[idx].setValue = $(":radio[name='"+val.optionGbn+"_"+val.optionCode+"']:checked").val();
							}else if( val.optionSelectType == 'checkbox' ){
								optionInfoList[idx].setValue = jQuery.map($(":checkbox[name='"+val.optionGbn+"_"+val.optionCode+"']:checked"), function (val){return (val.defaultValue || '')});
								commitChks.push(val.commonCode);
							}
						}
						console.log(JSON.stringify(data));
					},
					error : function(data) {
						console.log("! [EX] ERROR - " + JSON.stringify(data));
					}
				});
			}
			
		});
		alert('설정이 저장되었습니다.');
		return;
	}
	
	
	var selectedItems = '';
	function fnCallbackSel(param){
		selectedItems = '';
		var users = param.returnObj;
		$('#txt_consAuthCount').html('(' + users.length + ')');
		$('#div_selUsers').empty();
		var ajaxEmpSeqs = '';
		for(var i = 0; i < users.length; i++){
			var item = users[i];
			selectedItems += ',' + item.superKey; 
			var selItems = '';	
			selItems += '<div class="io_div idt1">';
			selItems += '	<div class="ico"></div>';
			selItems += '	<div class="who" >'+ item.empName + '(' + item.deptName + ')</div>';
			selItems += '	<a href="#n" class="clo" selEmpSeq="' + item.empSeq + '" selCompSeq="' + item.compSeq + '"></a>';
			selItems += '</div>	';
			
			
			$('#div_selUsers').append(selItems);
			ajaxEmpSeqs += ',' + item.empSeq;
		}
		
		$('.clo').click(function (){
			FnCompConsAuthDelete({selEmpSeq : $(this).attr('selEmpSeq') , selCompSeq : $(this).attr('selCompSeq')});
		});
		
		
		$('#selectedItems_forCmPop').val(selectedItems.substring(1));
		
		fnSetCompAuthUsers({
			empSeqs : ajaxEmpSeqs.substring(1)
		});
	}
	
	function fnSetCompAuthUsers(param){
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpMasterOptionCompConsAuthUpdate.do" />',
			datatype : 'json',
			async : true,
			data : param,
			success : function(data) {
				if(data.result.resultCode == 'SUCCESS'){
					
				}else{
					
					console.log(JSON.stringify(data));
				}
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}

	function FnCompConsAuthDelete(param){
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpMasterOptionCompConsAuthDelete.do" />',
			datatype : 'json',
			async : true,
			data : param,
			success : function(data) {
				if(data.result.resultCode != 'SUCCESS'){
					alert('사용자 삭제에 실패하였습니다.');
				}else{
					FnCompConsAuthSelect({});
				}
				fnCallbackSel({returnObj : data.result.aaData});
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}
	
	
	function FnCompConsAuthSelect(param){
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpMasterOptionCompConsAuthSelect.do" />',
			datatype : 'json',
			async : true,
			data : param,
			success : function(data) {
				fnCallbackSel({returnObj : data.result.aaData});
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}
</script>


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
	<input type="hidden" name="selectMode" width="500" value="u" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackSel"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>


