<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_formKind}  <!--양식종류--></dt>
			<dd>
				<select class="selectmenu" id="selFormType" style="width: 120px;">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="CON">${CL.ex_consDoc}  <!--품의서--></option>
					<option value="RES">${CL.ex_resDoc}  <!--결의서--></option>
				</select>
			</dd>
			<dt>${CL.ex_formNm}  <!--양식명--></dt>
			<dd>
				<input type="text" autocomplete="off" id="txtFormName" style="width: 226px;" />
			</dd>
			<dt>${CL.ex_inUseYN}  <!--사용여부--></dt>
			<dd>
				<select class="selectmenu" id="selUseYN" style="width: 100px;">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="Y">${CL.ex_use}  <!--사용--></option>
					<option value="N">${CL.ex_noUser}  <!--미사용--></option>
				</select>
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search} " /> <!--검색-->
			</dd>
		</dl>
	</div>

	<!-- 버튼 -->
	<div class="btn_div cl">
		<div class="left_div mt5">
			<p class="tit_p m0">
				선택항목 설정 <span class="fwn f11 ml20">${CL.ex_fromComment}  <!--양식 별 결의구분,결제수단,과세구분,채주유형 선택 값을 설정합니다.--></span>
			</p>
		</div>
		<div class="right_div">
			<div class="controll_btn p0">
				<button id="btnSave">${CL.ex_save}  <!--저장--></button>
			</div>
		</div>
	</div>

	<div class="twinbox">
		<table>
			<colgroup>
				<col width="50%" />
				<col width="" />
			</colgroup>
			<tr>
				<td class="twinbox_td" style="">
					<div class="com_ta2 sc_head mt10">
						<table>
							<colgroup>
								<col width="100">
								<col width="">
								<col width="87">
							</colgroup>
							<tr>
								<th>${CL.ex_formKind}  <!--양식종류--></th>
								<th>${CL.ex_formNm}  <!--양식명--></th>
								<th>${CL.ex_inUseYN}  <!--사용여부--></th>
							</tr>
						</table>
					</div>

					<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height: 500px;">
						<table id="tblFormList">
							<colgroup>
								<col width="100">
								<col width="">
								<col width="87">
							</colgroup>
						</table>
					</div>
				</td>
				
				<td class="twinbox_td" style="">
					<div class="com_ta">
						<table id="tblFormOption">
							<colgroup>
								<col width="140" />
								<col width="" />
							</colgroup>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- twinbox -->
</div>
<!-- //sub_contents_wrap -->



<script>

	/*	[전역변수] 페이지 전역변수 선언 영역
	---------------------------------------------- */
	var formList = ${formList};
	var optionInfoList = ${optionList};
	var selectedForm = {};

	/*	[ready] 품의결의 양식별 옵션
	---------------------------------------------- */
	$(document).ready(function() {
		
		/* 양식 엘리먼트 이벤트 적용 */
		fnInitEvent();
		
		/* 양식 리스트 그려주기 */
		fnGridForm();
		
		/* 옵션 탐색 */
		fnSearchOption(false);
	});
	
	
	/*	[초기화] 엘리먼트 이벤트 초기화
	---------------------------------------------- */
	function fnInitEvent() {
		/* 버튼 - 검색 */
		$("#btnSearch").unbind('click').on("click",function() {
			/* 양식별 옵션 정보 조회 */
			fnSearchOption(false);
		});
		
		/* 버튼 - 저장 */
		$("#btnSave").unbind().on("click",function() {
			/* 옵션 정보 저장 */
			fnOptionSave();
		});
		
		$("#txtFormName").keyup(function(e){
		    if(e.keyCode == 13) {
		    	/* 양식별 옵션 정보 조회 */
				fnSearchOption(false);
		    }
		});
	}
	
	/*	[옵션조회] 양식별 옵션 정보 조회
	---------------------------------------------- */
	function fnSearchOption(isCallFormTable){
		var params = {};
		params.formSeq = selectedForm.formSeq;
		params.formDTp = selectedForm.formDTp;
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpFormOptionSelect.do" />',
			datatype : 'json',
			async : true,
			data : params,
			success : function(data) {
				optionInfoList = data.result.aaData;
				if(!isCallFormTable){
					$("#tblFormList tr").removeClass("on");
					fnGridForm();
					if($("#tblFormList tr").length > 0){
						$("#tblFormList tr").first().addClass("on");
						selectedForm.formSeq = $("#tblFormList tr").first().data("data").formSeq;
						selectedForm.formDTp = $("#tblFormList tr").first().data("data").formDTp;
					} 
				}
				fnGridOption();
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}

	/*	[그리드] 전체 양식 그리드 출력
	---------------------------------------------- */
	function fnGridForm(){
		$("#tblFormList").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="100">';
		colGroup += '<col width="">';
		colGroup += '<col width="87">';
		colGroup += '</colgroup>';
		$("#tblFormList").append(colGroup);
		
		$.each(formList, function(idx,val){
			/* 검색어 반영 */
			if( val.formDTp.indexOf($("#selFormType").val()) == -1){
				return true;
			}else if(val.formName.indexOf($("#txtFormName").val()) == -1 ){
				return true;
			}else if(val.useYN.indexOf($("#selUseYN").val()) == -1 ){
				return true;
			}
			
			var tr = document.createElement('tr');
			$(tr).data('data', val);
			if(val.formDTp.indexOf('EXNPCON') > -1){
				$(tr).append('<td>품의서</td>');
			}else if(val.formDTp.indexOf('EXNPRES') > -1){
				$(tr).append('<td>결의서</td>');
			}
			$(tr).append('<td>'+val.formName+'</td>');
			$(tr).append('<td>'+val.useYN+'</td>');
			var isAddYN = true;
			
			$("#tblFormList").append(tr);
		});
		
		$("#tblFormList tr").on("click",function(){
			$("#tblFormList tr").removeClass("on");
			$(this).addClass("on");
			$(this).data();
			selectedForm.formSeq = $(this).data("data").formSeq;
			selectedForm.formDTp = $(this).data("data").formDTp;
			fnSearchOption(true);
		});
		
		if($("#tblFormList tr").length){
			selectedForm.formSeq = $("#tblFormList tr").first().data("data").formSeq;
			selectedForm.formDTp = $("#tblFormList tr").first().data("data").formDTp;
		}
	}
	
	/*	[옵션 목록] 옵션 목록 그리기
	---------------------------------------------- */
	function fnGridOption(){
		$("#tblFormOption tr td").empty();
		$("#tblFormOption td").empty();
		$("#tblFormOption").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="140" />';
		colGroup += '<col width="" />';
		colGroup += '</colgroup>';
		$("#tblFormOption").append(colGroup);
		$.each(optionInfoList, function(idx,val){
			var tr = document.createElement('tr');
			$(tr).append('<th>'+val.note+'</th>');
			
			var td = document.createElement('td');
			
			var optionCode = val.optionGbn + "_" + val.optionCode;
			var checkedValue = val.setValue.split('|');
			var optionSelectType = val.optionSelectType;
			var isFirst = true;
			if(optionSelectType =="checkbox"){
				td.className = 'pt15 pb15';
			}
			$.each(JSON.parse(val.optionList),function(index, value){
				var isChecked = '';
				for(var i = 0 ; i < checkedValue.length ; i++ ){
					if(checkedValue[i] == value.code){
						isChecked = 'checked=""';
						break;
					}
				}
				
				if(optionSelectType =="radio"){
					if(isFirst){
						$(td).append('<input type="'+optionSelectType+'" style="visibility: hidden;" value="'+value.code+'" name="'+optionCode+'" id="'+optionCode+"_"+value.code+'" '+isChecked+'>');	
					}else{
						$(td).append('<input type="'+optionSelectType+'" style="visibility: hidden;" value="'+value.code+'" name="'+optionCode+'" id="'+optionCode+"_"+value.code+'" '+isChecked+' class="ml10">');
					}
					$(td).append('<label for="'+optionCode+"_"+value.code+'"><span>'+value.name+'</span></label>');
				}else if(optionSelectType =="checkbox"){
					$(td).append('<input type="'+optionSelectType+'" class="chkbox" style="visibility: hidden;" value="'+value.code+'" name="'+optionCode+'" id="'+optionCode+"_"+value.code+'" '+isChecked+'/>&nbsp;');
					$(td).append('<label for="'+optionCode+"_"+value.code+'" class="mt5" style="width:100px;">'+value.name+'</label>');
					if(index % 3 == 0){
						$(td).append('<br/>');
					}
				}
				isFirst = false;
			});
			
			$(tr).append(td);
			$("#tblFormOption").append(tr);
		});
		
		/* 체크박스 - 변경 */
		$(".chkbox").unbind("change").change(function() {
			if($(this).val() != '0' && $(this).is(":checked")){
			// 	$("#"+$(this).attr("name")+"_0").removeAttr("checked","");
			}
		});
	}
	
	/*	[저장] 옵션 정보 저장
	---------------------------------------------- */
	function fnOptionSave() {
		/* 변경된 내용이 있는 옵션만 저장 진행 */
		var updateOption = [];
		$.each(optionInfoList, function(idx,val){
			var selectVal = '';
			$("input[name='"+val.optionGbn+"_"+val.optionCode+"']:checked").each(function(){
				selectVal = selectVal + this.value + "|"; 
			});
			if(selectVal != ''){
				selectVal = selectVal.substr(0,selectVal.length - 1);
			}
			if(val.setValue != selectVal){
				var params = {};
				params.formSeq = selectedForm.formSeq;
				params.formDTp = selectedForm.formDTp;
				params.optionGbn = val.optionGbn;
				params.optionCode = val.optionCode;
				params.commonCode = val.commonCode;
				params.setValue = selectVal;
				$.ajax({
					type : 'post',
					url : '<c:url value="/expend/np/admin/NpFormOptionUpdate.do" />',
					datatype : 'json',
					async : true,
					data : params,
					success : function(data) {
						alert("저장이 완료되었습니다.");
					},
					error : function(data) {
						console.log("! [EX] ERROR - " + JSON.stringify(data));
					}
				});
			}
		});
		return;
	}
</script>

