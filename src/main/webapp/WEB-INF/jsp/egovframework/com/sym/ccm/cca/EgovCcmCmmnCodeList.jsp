<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovCcmCmmnCodeList.jsp
  * @Description : EgovCcmCmmnCodeList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">
<head>
<title><spring:message code='system.comm.commCode.list' /></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<script type="text/javascript" src="<c:url value='/js/neos/json2.js'></c:url>"></script>
<script type="text/javascript">

/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/

$(function(){
	cmnCodeObj.init();		
	/*
	$(window).resize(function(){
		cmnCodeObj.windowsResizeFunction();
	});
	*/
});

var cmnCodeObj = {};
cmnCodeObj.jsondata = {};
cmnCodeObj.clCodeObj = {};

/*
cmnCodeObj.windowsResizeFunction = function(){
	//cmnCodeObj.resizeTopSearch();	
	//cmnCodeObj.boardTableWidth();
};
*/
cmnCodeObj.boardTableWidth = function()
{
	//alert();
	$("#table_board2_th1").css("width", "96px");

 	var win_w1 = $(window).width() - 30;
	var min = jqGridUtil.minWidth();
	if(win_w1 && parseInt(win_w1)< parseInt(min)){
		return false;
	}
    var leftWidth = NeosUtil.getLeftMenuWidth();
	var width = win_w1 - leftWidth;
	
	var width_result = width - 96;
	$("#table_board2_td1").css("width", width_result);

};

cmnCodeObj.init = function(){
	// 검색어란 key action
	cmnCodeObj.searchTextSet();	
	// 윈도우 리사이즈
	//cmnCodeObj.windowsResizeFunction();

	//  use json2.js
	cmnCodeObj.clCodeObj =  JSON.parse('${cmmnClCodeList}');  

	var clCode = NeosCodeUtil.getCodeSelectList(cmnCodeObj.clCodeObj, "clCode",null,"");
	var clCodeSelect = $(clCode).css("width", "200px");
	$("#clCodeSelect").append(clCodeSelect);	
	
	//  Short Title Set
	$("#shoutCutTitle").html('<spring:message code="system.comm.commCode.list" />');	
};

cmnCodeObj.pagingClick = function(pageNo){
	$("#pageIndex").val(pageNo);
	var listForm = $("#listForm");
	listForm.submit();	
};


cmnCodeObj.search = function(){	
	cmnCodeObj.pagingClick(1);
};

cmnCodeObj.searchTextSet = function(){
	$("#searchKeyword").bind({
		keypress : function(event){
			if(event.keyCode == 13){
				cmnCodeObj.search();
			}
		}
	});
};

cmnCodeObj.openEditForm = function(){
	$("#divEditForm").slideDown();	// 작성폼 열기
	$("#divListBtn").hide();	// 목록 버튼 닫기
	//cmnCodeObj.windowsResizeFunction();
};

cmnCodeObj.closeEditForm = function(){	
	$("#divEditForm").slideUp();	// 작성폼 닫기
	$("#divListBtn").show();	// 목록 버튼 열기
	//cmnCodeObj.windowsResizeFunction();
};


// Form 정보 세팅
cmnCodeObj.setCmdTitle = function(cmd){
	cmnCodeObj.EditFormInit();
	$("#cmd").val(cmd); 
	if( cmd=='save'){
		$("#cmdTitle").html('<spring:message code="button.create" />');
	}else if(cmd=='Modify'){
		$("#cmdTitle").html('<spring:message code="button.read.detail" />'); /*상세정보*/  
	} 
};


// 신규 작성
cmnCodeObj.create = function(){
 
	cmnCodeObj.setCmdTitle("save");

	// 수정중 신규(등록)버튼 선택할 경우 사용여부  Y 로 초기화 
	$("#useAt > option[value = Y]").attr("selected", "ture");   // "selected"  or   "ture"	

	$("#list").resetSelection();
	
	cmnCodeObj.openEditForm();
};

//내용보기 
cmnCodeObj.read = function(rowid){
	
	cmnCodeObj.setCmdTitle("Modify");
	
	var obj = cmnCodeObj.jsondata[rowid-1];
	
	if(obj){

		var formData = {"codeId" : obj.codeId};
		var isSuccess = false;
		var codeIdDc =null;
		
		// textarea 와 같은 개행문자 포함되어 있는 경우 json 
		$.ajax({
			type:"post",
			url:'<c:url value="/sym/ccm/cca/EgovCcmCmmnCodeDc.do" />',
			async: false,
			datatype:"json",
			data: formData,
			success:function(data){
				switch (data.result) {
					case 0:	  isSuccess  = true;	codeIdDc=data.codeIdDc;	break;
				}
			},			
			error : function(e){		}
		});		
		if(isSuccess)
		{			
			// clCodeNm, clCode, codeId, codeIdNm, useAt
			// 사용여부
			$("#useAt > option[value = "+obj.useAt+"]").attr("selected", "ture");   // "selected"  or   "ture"		
			// 분류명 (분류코드)
			$("#clCode > option[value = "+obj.clCode+"]").attr("selected", "ture");   // "selected"  or   "ture"	
			$("#clCode").attr("disabled","disabled"); 			
			
			// 코드ID
			$("#codeId").val(obj.codeId);				
			$("#codeId").attr("disabled", "disabled"); 		
			// 코드ID 명
			$("#codeIdNm").val(obj.codeIdNm);		
			
			// 코드 ID 설명			
			if(codeIdDc!=null)	$("#codeIdDc").val(codeIdDc);	//  
			cmnCodeObj.openEditForm();
			
		}else{
			alert("<spring:message code='dataLoad.detailInfo.fail' />\r\n<spring:message code='system.bm.sign.retryplz' />");//   상세정보 불러오기에 실패 하였습니다.  /  잠시후에 이용해주시기 바랍니다.
			cmnCodeObj.cmnCodeList();
		}		
	}	
};


//  등록/수정 취소
cmnCodeObj.cancel = function(){
	var isCancel = confirm('<spring:message code="common.cancel.msg" />');/*취소하시겠습니까?*/
	if(isCancel){
		cmnCodeObj.cmnCodeList();
		$("#list").resetSelection();
	}
};

cmnCodeObj.cmnCodeList = function(){
	cmnCodeObj.closeEditForm();
	cmnCodeObj.EditFormInit();
};

cmnCodeObj.EditFormInit = function(){
	var empty = "";

	$("#clCode").removeAttr("disabled");
	$("#codeId").removeAttr("disabled");	
	
	$("#codeId").val(empty);					
	$("#codeIdNm").val(empty);	 
	$("#codeIdDc").val(empty);		
};	

cmnCodeObj.resizeTopSearch = function(){
	var win_w1 = $(window).width();
	var min = jqGridUtil.minWidth();
	 if(win_w1 && parseInt(win_w1)< parseInt(min)){
		 return false;
	 }
	 var leftWidth = NeosUtil.getLeftMenuWidth();
	 var width = win_w1 - leftWidth -14 ;
	 $(".top_search").css("width", width);
};

// 필수입력값 체크v
			

cmnCodeObj.validate = function(isNew,codeId,codeIdNm,codeIdDc){
	
	if(isNew) // 신규인 경우에만 
		if(cmnCodeObj.chkNull(codeId,"<spring:message code='system.comm.commCode.codeId' />"))		return false;  //코드ID

	if(cmnCodeObj.chkNull(codeIdNm,"<spring:message code='system.comm.commCode.clCodeNm' />"))		return false;  //코드명
	if(cmnCodeObj.chkNull(codeIdDc,"<spring:message code='system.comm.commCode.codeIdDesc' />"))	return false;  //코드 설명

	   
	return true;
};

cmnCodeObj.chkNull = function(fVal, fTitle){
	if(!$.trim(fVal)){
		alert(fTitle+"<spring:message code='valid.input.form.requisite.msg' />"); /*  (을)를 입력해주세요.*/
		return  true;
	}	
	return false;
};

//삭제
cmnCodeObj.del =  function(){
	$("#isDel").val(true);
	cmnCodeObj.actionSubmit();
};

// 수정.등록.삭제 처리.
cmnCodeObj.actionSubmit = function(){
	    	
	var cmd = $("#cmd").val();	  // save, Modify, empty(delete)
	var isDel = $("#isDel").val();
	var isNew = cmd=='save'?true:false;
	
	// S : save  / M : modify  / D : delete
	var action; 
	if(isDel == 'true'){
		
		var check = $("#board_table :checkbox[checked=checked]");
		var checkedLen = check.length;
		if(checkedLen==0){
			$("#isDel").val(false);
			alert("<spring:message code='system.comm.commCode.doDelSelect' />");		// 삭제할 코드를 선택해주세요.
			return false;
		}else if(checkedLen>1){
			$("#isDel").val(false);
			alert("<spring:message code='system.comm.commCode.doDelOneSelect' />");	// 삭제할 코드를 하나만 선택해주세요.
			return false;	
		}
		action = "D";
			
	}else{
		action = isNew?"S":"M";
	}

	var comfirmMsg;	
	
	if(action=="S"){  		// Save
		comfirmMsg = "<spring:message code='common.regist.msg' />";		//등록하시겠습니까?
	}else if(action=="M"){ 	// Modify
		comfirmMsg =  "<spring:message code='common.update.msg' />"; 	// 수정하시겠습니까?
	}else{					// Delete
		comfirmMsg = "<spring:message code='common.delete.msg' />";		//	삭제하시겠습니까?		
	}

	var isConfirm = confirm(comfirmMsg);	
	if(!isConfirm){
		$("#isDel").val(false);
		return false;
	}	
	
	// save, Modify  ,  del			
	var clCode = $("#clCode").val();			//  코드 
	var codeId = $("#codeId").val();		//  코드 ID
	var codeIdNm = $("#codeIdNm").val();		//  코드명 
	var codeIdDc = $("#codeIdDc").val();		//  코드ID 설명 
	var useAt = $("#useAt").val();			//  사용여부 		
	
	if(isDel != 'true'){    // 삭제가 아닌 경우애만 valid 체크
		// 수정시 : codeIdNm  codeIdDc    , useAt
		// 신규 :  code + 수정시 항목   ..clCode  codeId	
		
		if(!cmnCodeObj.validate(isNew,codeId,codeIdNm,codeIdDc)){
			return false;
		}				
	}

	var cUrl;
	var msgSuccess;
	var msgError;
	if(action=="S"){  	 // save			
		cUrl = '<c:url value="/sym/ccm/cca/EgovCcmCmmnCodeRegist.do" />';	
		msgSuccess = "<spring:message code='system.bm.sign.insertend' />";  // 등록이 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.inserterror' />";//등록을 실패 하였습니다.
	}else if(action=="M"){ 	// Modify 
		cUrl = '<c:url value="/sym/ccm/cca/EgovCcmCmmnCodeModify.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.editend' />";//수정이 완료 되었습니다. 
		msgError = "<spring:message code='system.bm.sign.editerror' />"; //수정을 실패 하였습니다.				
	}else{
		cUrl = '<c:url value="/sym/ccm/cca/EgovCcmCmmnCodeRemove.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.deleteend' />";// 삭제가 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.deleteerror' />"; //삭제가 실패 하였습니다. 
	}
	msgError = msgError +"\r\n<spring:message code='system.bm.sign.retryplz' />";  //   잠시후에 이용해주시기 바랍니다.
	
	 // 삭제인 경우  ::  복수건인 경우에만 필요.  
	 //             단일 건인 경우 현재 확인중인 건만 삭제 가능하므로 불필요
	// if(isDel){   
	//	var id = $("#list").jqGrid('getGridParam','selrow');
	//	var obj = cmnCodeObj.jsondata[id-1];
	//	var formData = {
	//		"code" : obj.code,
	//		"codeId" : obj.codeID,
	//		"codeIdNm" : obj.codeIdNm,
	//		"codeIdDc" : obj.codeIdDc,
	//		"useAt" : obj.useAt
	//	};	
	// }else{
		
		//var formData = $("#editForm").serialize();// disable    form 은 처리 불가.		
		
		var formData = {
			"clCode" : clCode,
			"codeId" : codeId,
			"codeIdNm" : codeIdNm,
			"codeIdDc" : codeIdDc,
			"useAt" : useAt
		};	
	//}

	$.ajax({
		type:"post",
		url:cUrl,
		datatype:"json",
		data: formData,
		success:function(data){
			switch (data.result) {
				case 0:
					alert(msgSuccess);
					cmnCodeObj.pagingClick(1);
					break;
				case -1:
					alert("<spring:message code='system.comm.detail.commCode.regist.duplicate' />"); /*"이미 등록된 코드가 존재합니다."*/
					break;
				case -8:
					alert("<spring:message code='common.access.denied' />"); /* 잘못된 접근입니다.  */
					break;
				case 100:
					alert("<spring:message code='fail.common.login' />"); /* 로그인 정보가 올바르지 않습니다. */
					break;
				default :
					alert(msgError);
					break;
			}
		},			
		error : function(e){	//error : function(xhr, status, error) {
			alert(msgError);	
		}
	});	
	
	
};
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* --------------------------------------------------------  *  
 * jqGrid START  
 * --------------------------------------------------------- */
$(function(){	
	BindjqGrid();
	$(window).resize(function(){
		jqGridUtil.resizeJqGrid("board_table");							     
	});
} );
function BindjqGrid(){
	///$("#jsonData").html( '${resultList}');
	var jsondata = $.parseJSON('${resultList}');
	//$("#jsonData").html( '${resultList}');
	cmnCodeObj.jsondata = jsondata;
	var obj = {};
	obj.option = {  
		data: jsondata, 
		datatype: 'local', 
		colNames:[
	   '<spring:message code="comm.board.listNo" />',  // 순번
	   '<spring:message code="system.comm.commCode.clCodeNm" />',  // 분류명
	   '<spring:message code="system.comm.commCode.codeId" />',  // 코드ID
	   '<spring:message code="system.comm.commCode.codeIdNm" />',  // 코드ID명
	   '<spring:message code="cop.useAt" />',  // 사용여부
	   'clCode'
	   //'codeIdDc'
		], 
		colModel:[  
		{name:'menuNm', index:'menuNm', align:'center',sortable:false},  // <c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
		{name:'clCodeNm', index:'clCodeNm', align:'center'},	  // , editable: true
		{name:'codeId', index:'codeId',  align:'center'}, 
		{name:'codeIdNm', index:'codeIdNm',  align:'left' ,formatter : jqGridUtil.textStyle},// , formatter : jqGridUtil.TextOverFlow
		{name:'useAt', index:'useAt', align:'center',  formatter : fn_useYN },	
		{name:'clCode', index:'clCode',  hidden:true}
		//{name:'codeIdDc', index:'codeIdDc',  hidden:true}
		], 
			multiselect:true,
			emptyrecords:"<spring:message code='common.nodata.msg' />" ,  // 데이터가 존재하지 않습니다.

			//ondblClickRow: function(rowid, iRow, iCol, e) { }, //row 더블 클릭시 상세 보기. 
			
			//onSelectRow: function(rowid, iRow, iCol, e){ //row 클릭시 event	
			onSelectRow: function(rowid){ //row 클릭시 event	

				var idList = $("#list").jqGrid('getGridParam','selarrrow');
				for(var i =0;i< idList.length;i++){
					if(idList[i]!=rowid){
						$("#list").resetSelection(idList[i]);
					}
				}
				
				var idList = $("#list").jqGrid('getGridParam','selarrrow');
				if(idList.length){	// 선택 되었을 때에만 세팅.
					cmnCodeObj.read(rowid);  
				}
			},			
			
			loadComplete  : function(){
				// 넘버 추가
				var ids = $("#list").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var num = parseInt('<c:out value="${paginationInfo.totalRecordCount}"/>') - (parseInt('<c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize}"/>')+i);
					jQuery("#list").jqGrid('setRowData',ids[i],{menuNm:num});
				}	

				//jqGridUtil.tableRowStyle("list");
				jqGridUtil.tableRowClickStyle("list");  // row link 처리
				jqGridUtil.setEmptyData(obj, "board_table");
				$.jqGrid = {};
				//$.jqGrid.data = {"0":"6%","1":"40%", "2":"20%", "3":"20%", "4":"14%"}; 
				$.jqGrid.data = {"0":"20px","1":"80px","2":"150px", "3":"150px", "4":"100%", "5":"150px"}; 
				
				$.jqGrid.min = jqGridUtil.minWidth();
				jqGridUtil.resizeJqGrid("board_table");
			}
		//,height:"700px"
	};
	//공통으로 적용할 옵션 가져오기
	obj = jqGridUtil.jqGridCommonOption(obj);
	$("#list").jqGrid(obj.option);
}
function fn_useYN(cellvalue, options, rowObject){
	if(cellvalue=='Y')  return  "<spring:message code='button.use' />";  // 사용
	else  return  "<spring:message code='button.use.none' />";  // 미사용
}
/* --------------------------------------------------------  *  
 * jqGrid END 
 * --------------------------------------------------------- */
</script>
</head>
<body>

			
	<form name="listForm" id="listForm"  action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>" method="post">
	<input name="pageIndex" id="pageIndex"  type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> 	
<div class="searchArea clearfx" id="" >
        <span>
            <select name="searchCondition" id="searchCondition" class="text-pad" style="width:100px" title=""  >
                   <option selected value=''><spring:message code='select.option.title' /></option>
                   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code='system.comm.commCode.codeId' /></option>
                   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><spring:message code='system.comm.commCode.codeIdNm' /></option>
             </select>
             <input type="text" name="searchKeyword" id="searchKeyword" style="width:200px;" value="${searchVO.searchKeyword }"  onkeyup="javascript:if(event.keyCode==13){cmnCodeObj.search(); return false;}"/></span>
        <a href="javascript:cmnCodeObj.search();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
</div>
	</form>		
					
	<!--  수정/등록 화면   START -->	
	<form id="editForm" name="editForm" method="post">	
	<input id="cmd" name="cmd" type="hidden"/> 		
	<input id="isDel" name="isDel" type="hidden"/>		
	
<div id="divEditForm" style="display:none; width:100% ">
       <fieldset class="mT20">
                    <legend>상세 정보</legend>
                    <ul class="inputForm">
                        <li><strong style="width:95px;"><spring:message code='system.comm.commCode.clCodeNm' /><span class="f_red">*</span></strong> 
                              <span id='clCodeSelect'></span>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.comm.commCode.codeId' /><span class="f_red">*</span></strong> 
                              <input type="text"  name="codeId" id="codeId" maxlength="6" style="width:153px;"/>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.comm.commCode.codeIdNm' /><span class="f_red">*</span></strong> 
                              <input type="text"  name="codeIdNm" id="codeIdNm" maxlength="60" style="width:153px;"/>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.comm.commCode.codeIdDesc' /><span class="f_red">*</span></strong> 
                              <textarea name="codeIdDc" id="codeIdDc" style="width:440px; height:40px;">내용을 입력해 주세요</textarea>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='cop.useAt' /></strong>
                             <select name="useAt" id="useAt" class="select"  style="width:100px;"  title="<spring:message code='cop.useAt' />">
                                <option value='Y' ><spring:message code='button.use'/></option>
                                <option value='N' ><spring:message code='button.use.none'/></option>
                             </select>
                         </li>
                    </ul>
				
            <p class="tC mT15" id="saveButton">
                 <a href="javascript:cmnCodeObj.actionSubmit();" class="darkBtn"><span>저장</span></a> 
                 <a href="javascript:cmnCodeObj.cancel();" class="grayBtn"><span>취소</span></a>
            </p>
            <p class="tC mT15"  style="display:none;"  id="editButton">
                 <a href="javascript:cmnCodeObj.actionSubmit();" class="darkBtn"><span>수정</span></a> 
                 <a href="javascript:cmnCodeObj.del();" class="grayBtn"><span>폐기</span></a>
            </p>	
        </fieldset>             
</div>
	</form>
	<!--  수정/등록 화면   END -->	
	
	<div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["<spring:message code='button.new' />"/*신규 */, "<spring:message code='button.delete2' />"/*폐기 */];
		var fn = ["cmnCodeObj.create()","cmnCodeObj.del()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);
	</script>							

	<div class="board_table mT7" id="board_table">
		<table id="list" ></table>
		<!--  table id="jsonData" ></table -->
	</div>
	<div style="height: 12px;"></div>
	<div align="center" class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image"	jsFunction="cmnCodeObj.pagingClick" />
	</div>

</body>
</html>
