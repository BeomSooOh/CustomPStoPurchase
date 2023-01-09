<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>물품검수</title>

    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  

	<script type="text/javascript">
	
	/* 예산관련 변수 시작 */
	var consDocSeq = "";
	var consSeq = "";
	var thisSeq = "${seq}";
	
	var outProcessCode = "Purchase02";
	var disabledYn = "${disabledYn}";
	
	var insertDataObject = {};
	
	var attachFormList = [];
	var attachFileNew = [];
	var attachFileDel = [];		
	var commonCodeTargetInfo = [];
	var targetElement;
	
	var tempArray = [];
	var tempObj = {};
	var tempStr = "";
	
	<c:forEach var="items" items="${formAttachList}">
	
	tempObj = {};
	tempArray =  "${items.LINK}".split('▦');
	tempObj.code = "${items.CODE}";
	tempObj.formNm = "${items.NAME}";
	
	tempObj.mustYn = tempArray[0];
	tempObj.formFileNm = tempArray[1];
	tempObj.formFileId = tempArray[2];
	
	tempObj.fileId = "${items.file_id}";
	tempObj.fileName = "${items.file_name}";
	tempObj.fileExt = "${items.file_ext}";
	tempObj.newYn = "${items.new_yn}";
	
	attachFormList.push(tempObj);
	</c:forEach>
	
	$(document).ready(function() {
		
		//기존설정항목 세팅
		<c:if test="${viewType == 'U'}">
		setDynamicSetInfoTrade();
		setDynamicSetInfoItem();
		</c:if>
		
	});	
	
	function setDynamicSetInfoItem(){
		
		<c:if test="${itemList.size() > 0 }">
		$("[name=itemList] tr[name=addData]").remove();
		
		var cloneData;
		<c:forEach var="items" items="${itemList}" varStatus="status">

		cloneData = $('[name="itemList"] tr[name=dataBase]').clone();
		$(cloneData).show().attr("name", "addData");
		$(cloneData).find("[name=item_tr_seq]").val("${items.item_tr_seq}");
		$(cloneData).find("[name=item_div_no]").text("${items.item_div_no}");
		$(cloneData).find("[name=item_idn_no]").text("${items.item_idn_no}");
		$(cloneData).find("[name=item_name]").text("${items.item_name}");
		$(cloneData).find("[name=item_amt]").text("${items.item_amt}");
		$(cloneData).find("[name=item_cnt]").text("${items.item_cnt}");
		$(cloneData).find("[name=item_check_cnt]").val("${items.item_check_cnt}" == "" ? "${items.item_cnt}" : "${items.item_check_cnt}");
		$(cloneData).find("[name=item_total_amt_text]").text("${items.item_total_amt_text}");
		$(cloneData).find("[name=item_total_amt]").text("${items.item_total_amt}");
		$(cloneData).find("[name=item_unit]").text("${items.item_unit}");
		$(cloneData).find("[name=item_pickup_location]").text("${items.item_pickup_location}");
		$(cloneData).find("[name=item_use_location]").text("${items.item_use_location}");
		$(cloneData).find("[name=item_deadline]").text("${items.item_deadline}");
		
		$('[name="itemList"]').append(cloneData);
		
		</c:forEach>			
		</c:if>			
		
	}		
	
	
	function setDynamicSetInfoTrade(){
		
		<c:if test="${tradeList.size() > 0 }">
		var supplier = "";
		<c:forEach var="items" items="${tradeList}" varStatus="status">
		supplier += (supplier == "" ? "" : ", ") + "${items.tr_name}";
		</c:forEach>	
		$("[name=supplier]").text(supplier);
		</c:if>			
		
	}	

	function openerRefreshList(){
		if(opener != null && typeof opener.BindGrid != "undefined"){
			opener.BindGrid();
		}	
	}
	
	
	function commonCodeSelectLayer(group, title, type, target, multiYn){

		Pudd.puddDialog({
		 
			width : type == "shopping" ? 1200 : 400
		,	height : type == "shopping" ? 600 : 500
		 
		,	modal : true			// 기본값 true
		,	draggable : false		// 기본값 true
		,	resize : false			// 기본값 false
		 
		,	header : {
	 		title : title
		,	closeButton : false	// 기본값 true
		,	closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		}
		
		,	body : {
		 
				iframe : true
			,	url : "${pageContext.request.contextPath}/purchase/layer/" + (type == "shopping" ? "SelectShoppingListLayer" : "CodeSelectLayer") + ".do?inqryBgnDate=${fromDate}&inqryEndDate=${toDate}&multiYn=" + multiYn + "&group=" + group
			,	iframeAttribute : {
				id : "dlgFrame"
			}						

		}
		 
			// dialog 하단을 사용할 경우 설정할 부분
		,	footer : {
		
				buttons : [
					
					{
						attributes : {}// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
					,	value : <c:if test="${viewType == 'I'}">"확인"</c:if><c:if test="${viewType != 'I'}">"저장"</c:if>
					,	clickCallback : function( puddDlg ) {
						
						var iframeTag = document.getElementById( "dlgFrame" );
						commonCodeCallback(type, target, iframeTag.contentWindow.fnGetSelectedList());
						puddDlg.showDialog( false );
							
						}
					},
					
					{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
					,	value : <c:if test="${disabledYn == 'Y'}">"닫기"</c:if><c:if test="${disabledYn == 'N'}">"취소"</c:if>
					,	clickCallback : function( puddDlg ) {
							puddDlg.showDialog( false );
							attachFileNew = [];
							attachFileDel = [];	
						}
					}
				]
			}
		});			
		
	}		
	
	function commonCodeCallback(type, target, selectedList){
		
		if(type == "ul"){
			$(target).find('[name=addData]').remove();
			$.each(selectedList, function( idx, addData ) {
				var cloneData = $(target).find('[name=dataBase]').clone();
				$(cloneData).show().attr("name", "addData");
				$(cloneData).attr("addCode", addData.code);
				$(cloneData).find("[name=addName]").text(addData.name);
				$(target).find('ul').append(cloneData);				
			});									
		}else if(type == "text"){

			if(selectedList.length > 0){
				$(target).find("[codetarget]").val(selectedList[0].name);
			}
			
		}
	}	
	
	function fnClose(){
		
		self.close();
		
	}			
	
	function fnCallBtn(callId){
		
		if(callId == "attach"){
			attachLayerPop();
		}else if(callId == "save"){
			fnSave(0);
		}else if(callId == "appr"){
			fnSave(1);
		}
		
	}	
	
	function attachLayerPop(){
		
		if(attachFormList.length == 0){
			msgAlert("error", "첨부파일 양식코드가 존재하지 않습니다.", "");
			return;
		}
		
		var layerHeight = 86+(30*attachFormList.length);
		
		// puddDialog 함수
		Pudd.puddDialog({
		 
			width : 800
		,	height : layerHeight
		 
		,	modal : true			// 기본값 true
		,	draggable : false		// 기본값 true
		,	resize : false			// 기본값 false
		 
		,	header : {
	 		title : "첨부파일"
		,	closeButton : true	// 기본값 true
		,	closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		}
		 
		,	body : {
		 
				iframe : true
			,	url : "${pageContext.request.contextPath}/purchase/layer/AttachLayer.do?disabledYn=${disabledYn}"

		}
		 
			// dialog 하단을 사용할 경우 설정할 부분
		,	footer : {
		
				buttons : [
					
					<c:if test="${disabledYn == 'N'}">
					{
						attributes : {}// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
					,	value : <c:if test="${viewType == 'I'}">"확인"</c:if><c:if test="${viewType != 'I'}">"저장"</c:if>
					,	clickCallback : function( puddDlg ) {
						
						temptemp = puddDlg;
							fnUpdateAttachInfo();
							puddDlg.showDialog( false );
							// 추가적인 작업 내용이 있는 경우 이곳에서 처리
							
						}
					},
					</c:if>
					
					{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
					,	value : <c:if test="${disabledYn == 'Y'}">"닫기"</c:if><c:if test="${disabledYn == 'N'}">"취소"</c:if>
					,	clickCallback : function( puddDlg ) {
							puddDlg.showDialog( false );
							attachFileNew = [];
							attachFileDel = [];	
						}
					}
				]
			}
		});			
		
	}		
	
	function fnUpdateAttachInfo(){
		$.each(attachFileDel, function( key1, attchDelInfo ) {
			$.each(attachFormList, function( key2, attchFormInfo ) {
				if(attchDelInfo == attchFormInfo.fileId){
					attchFormInfo.fileId = "";
					attchFormInfo.fileName = "";
					attchFormInfo.fileExt = "";
				}
			});	
		});				
		
		$.each(attachFileNew, function( key1, attchNewInfo ) {
			$.each(attachFormList, function( key2, attchFormInfo ) {
				if(attchNewInfo.attachformcode == attchFormInfo.code){
					attchFormInfo.fileId = attchNewInfo.uid;
					attchFormInfo.fileName = attchNewInfo.fileName;
					attchFormInfo.fileExt = attchNewInfo.fileExt;
				}
			});	
		});
		
		attachFileNew = [];
		attachFileDel = [];	
		
		//수정일 경우 즉시 업데이트
		<c:if test="${viewType == 'U'}">
		insertDataObject.attch_file_info = JSON.stringify(attachFormList);
		insertDataObject.outProcessCode = outProcessCode;
		insertDataObject.seq = thisSeq;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/attachSaveProc.do" />',
    		datatype:"json",
            data: insertDataObject ,
			async : false,
			success : function(result) {
				
				if(result.resultCode != "success"){
					msgSnackbar("error", "첨부파일 실패");
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "등록에 실패했습니다.");
			}
		});			
		
		</c:if>
		
	}
	
	function fnValidationCheck(){
		insertDataObject = {};
		
		var validationCheck = true;
		
		$.each($("[objKey]"), function( key, objInfo ) {
			
			var objValue = eval($(objInfo).attr("objCheckFor"));
			
			if(objValue == "$failAlert$"){
				validationCheck = false;
				return false;
			}
			
			insertDataObject[$(objInfo).attr("objKey")] = objValue;
			
		});
		
		return validationCheck;
	}
	

	function fnSave(type){
		
		if(fnValidationCheck() == true){

			insertDataObject.attch_file_info = JSON.stringify(attachFormList);
			insertDataObject.item_list_info = JSON.stringify(insertDataObject.itemObjList);
			
			//품품정보 html
			$('[name=itemObjListHtml]').find("[displaynone]").removeAttr("displaynone");
			$('[name=itemObjListHtml]').find(":hidden").attr("displaynone", "Y");
			
			//Clone객체 select checked option 정보 누락 현상관련 temp Attr에 임시저장/활용
			$.each($('[name=itemList]').find("select"), function( idx, obj ) {
				$(obj).attr("htmlTempVal", $(obj).find("option:checked").text());
			});			
			
			var cloneData = $('[name=itemObjListHtml]').clone();
			$(cloneData).find("[displaynone]").remove();
			$(cloneData).find("[removehtml=Y]").remove();
			$(cloneData).find("[name=dataBase]").remove();
			$(cloneData).find("[name=itemList]").attr("border", "1").attr("width", "100%").css("width", "100%");
			$(cloneData).find("th").attr("align", "center").attr("bgcolor", "#f1f1f1").attr("height", "25");
			$(cloneData).find("td").attr("align", "center").attr("height", "20");
			$(cloneData).find("[name]").removeAttr("name");
			$(cloneData).find("[objcheckfor]").removeAttr("objcheckfor");
			
			//개별 align 적용
			$.each($(cloneData).find("[htmlalign]"), function( idx, obj ) {
				$(obj).attr("align", $(obj).attr("htmlalign"));
			});		
			
			$.each($(cloneData).find("[colspanHtml]"), function( idx, obj ) {
				$(obj).attr("colspan", $(obj).attr("colspanHtml"));
			});
			
			//input 요소 텍스트화
			$.each($(cloneData).find("input"), function( idx, obj ) {
				$(obj).replaceWith($(obj).val());
			});	
			
			$.each($(cloneData).find("select"), function( idx, obj ) {
				$(obj).replaceWith($(obj).attr("htmlTempVal"));
			});
			
			insertDataObject.check_info_html = $(cloneData)[0].outerHTML;				
			
			
			if(type == 0){
				confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc(1)', '취소', '');	
			}else if(type == 1){
				
				var attachValidationcheck = true;
				
				$.each(attachFormList, function( key, objInfo ) {
					
					if(objInfo.mustYn == "Y" && objInfo.fileId == ""){
						attachValidationcheck = false;
						msgSnackbar("error", "필수 첨부파일을 업로드해 주세요.");
						fnCallBtn('attach');
						return false;
					}
					
				});	
				
				if(attachValidationcheck){
					confirmAlert(350, 100, 'question', '결재작성 하시겠습니까?', '확인', 'fnSaveProc(2)', '취소', '');	
				}
					
			}
								
		}			
	}
	
	function fnSaveProc(type){

		insertDataObject.reqType = type;
		insertDataObject.outProcessCode = outProcessCode;
		insertDataObject.viewType = "${viewType}";
		insertDataObject.seq = thisSeq;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/PurchaseSaveProc.do" />',
    		datatype:"json",
            data: insertDataObject ,
			async : true,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					thisSeq = result.resultData.seq;
					
					if(type == 1){
						openerRefreshList();				
						msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
					}else{
						openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=" + thisSeq,  "ApprCreatePop", 1000, 729, 1, 1) ;
						self.close();	
					}
					
				}else{
					msgSnackbar("error", "등록에 실패했습니다.");	
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "등록에 실패했습니다.");
			}
		});
		
	}	
	
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>물품검수</h1>
		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
					<c:if test="${btnSaveYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="임시저장" />
					</c:if>
					<input type="button" class="psh_btn" onclick="fnCallBtn('attach')" value="첨부파일" />
					<c:if test="${btnApprYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('appr')" value="결재작성" />
					</c:if>					
				</div>
			</div>
		</div>
	</div>


	<div class="pop_con" style="overflow: auto; min-height: 460px;">
		<div class="top_box">
			<dl>
				<dt>작성일자</dt>
				<dd objKey="c_write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input ${disabled} name="writeDt" type="text" value="${c_write_dt}" class="puddSetup" pudd-type="datepicker"/></dd>
				
				<input objKey="c_write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${c_write_comp_seq}" />
				<input objKey="c_write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${c_write_dept_seq}" />
				<input objKey="c_write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${c_write_emp_seq}" />
				
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width="369"/>
					<col width="130"/>
					<col width="369"/>
				</colgroup>
				<tr>
					<th>계약건명</th>
					<td colspan="3">${purchaseDetailInfo.title}</td>
				</tr>
				<tr>
					<th>납품자</th>
					<td name="supplier"></td>
					<th>계약금액</th>
					<td>₩${purchaseDetailInfo.purchase_amt}원 ${purchaseDetailInfo.purchase_amt_kor}</td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 납품일자</th>
					<td objKey="release_dt" objCheckFor="checkVal('date', 'releaseDt', '납품일자', 'mustAlert', '')"><input ${disabled} name="releaseDt" type="text" value="${purchaseDetailInfo.release_dt}" class="puddSetup" pudd-type="datepicker"/></td>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 검수장소</th>
					<td>
						<input objKey="check_location" objCheckFor="checkVal('text', this, '검수장소', 'mustAlert', '')" type="text" pudd-style="width:200px;" class="puddSetup ar" value="${purchaseDetailInfo.check_location}" readonly codetarget />
						<c:if test="${disabledYn == 'N'}">  
						<a href="#n" class="btn_search ml10" onclick="commonCodeSelectLayer('useLocation', '검수장소', 'text', $(this).closest('td'), 'N')"></a>
						</c:if>	
					</td>
				</tr>									
			</table>
		</div>


		<!-- 물품규격 -->
		<div class="btn_div mt25" style="margin-bottom: 5px;">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">물품검수내역</p>
			</div>
		</div>
		
		<div class="com_ta4" name="itemObjListHtml">
			<table name="itemList" objKey="itemObjList" objCheckFor="checkVal('obj', 'itemList', '물품규격', 'mustAlert', '')" style="width:100%;">
				<colgroup>
					<col width="300"/>
					<col width="100"/>
					<col width="250"/>
					<col width="300"/>
					<col width="200"/>
					<col width="150"/>
					<col width="150"/>
					<col width="200"/>
				</colgroup>
				<tr>
					<th class="ac">품명</th>
					<th class="ac">단위</th>
					<th class="ac">물품분류번호</th>
					<th class="ac">물품식별번호</th>
					<th class="ac">조달단가</th>
					<th class="ac">구매수량</th>
					<th class="ac">검수수량</th>
					<th class="ac">납품기한</th>
				</tr>
				<tr name="dataBase" style="display:none;">
					<td name="item_name"></td>
					<td name="item_unit"></td>
					<td name="item_div_no"></td>
					<td tbval="Y" tbtype="innerText" name="item_idn_no"></td>
					<td name="item_amt"></td>
					<td name="item_cnt"></td>
					<td>
						<input tbval="Y" name="item_tr_seq" type="hidden" value="" />
						<input ${disabled} tbval="Y" name="item_check_cnt" tbname="금회검수수량" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup ar" value="" />
					</td>
					<td name="item_deadline"></td>
				</tr>
			</table>
		</div>
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

<div id="exArea"></div>
<form id="frmPop" name="frmPop"> 
		<input type="hidden" name="selectedItems" id="selectedItems" value="" />
		<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
		<input type="hidden" name="selectMode" id="selectMode" value="u" />
		<input type="hidden" name="selectItem" value="m" />
		<input type="hidden" name="callback" id="callback" value="" />
		<input type="hidden" name="compSeq" value="" />
		<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
		<input type="hidden" name="empUniqYn" value="Y" />
		<input type="hidden" name="empUniqGroup" value="ALL" />
</form>
<input style="display:none;" id="file_upload" type="file" />
</body>
</html>