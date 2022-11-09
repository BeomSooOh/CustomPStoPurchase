<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovCcmCmmnClCodeList.jsp
  * @Description : EgovCcmCmmnClCodeList 화면
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
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title><spring:message code='system.comm.groupCode.list' /></title>
<script type="text/javascript">
<!--
$(function(){
	cmnClCodeObj.init();	
	/*
	$(window).resize(function(){
		cmnClCodeObj.windowsResizeFunction();
	});	
	*/
});


var cmnClCodeObj = {};
cmnClCodeObj.jsondata = {};

/*
cmnClCodeObj.windowsResizeFunction = function(){
	//cmnClCodeObj.resizeTopSearch();	
	//cmnClCodeObj.boardTableWidth();
};
*/
cmnClCodeObj.boardTableWidth = function()
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

cmnClCodeObj.init = function(){
	// 검색어란 key action
	cmnClCodeObj.searchTextSet();		
	shoutCutTitleChange('공통분류 코드'/*공통분류 코드*/);
	// 윈도우 리사이즈
	//cmnClCodeObj.windowsResizeFunction();
};

cmnClCodeObj.pagingClick = function(pageNo){
	$("#pageIndex").val(pageNo);
	var listForm = $("#listForm");
	listForm.submit();	
};

cmnClCodeObj.search = function(){	
	cmnClCodeObj.pagingClick(1);
};

cmnClCodeObj.searchTextSet = function(){
	$("#searchKeyword").bind({
		keypress : function(event){
			if(event.keyCode == 13){
				cmnClCodeObj.search();
			}
		}
	});
};

cmnClCodeObj.openEditForm = function(){
	$("#divEditForm").slideDown();	// 작성폼 열기
	$("#divListBtn").hide();	// 목록 버튼 닫기
	
	//$(top.document).find("#_content").css("height", $(window).height());// y scroll
	//$("#_content").css("height", $(window).height());// y scroll
	

	 //$('#div_btn').focus();
	 //$(top.document).find("#_content").focus();
	//iframe_resize();
	//parent.window_resize();

	//cmnClCodeObj.windowsResizeFunction();
};



cmnClCodeObj.closeEditForm = function(){	
	$("#divEditForm").slideUp();	// 작성폼 닫기
	$("#divListBtn").show();	// 목록 버튼 열기
	//parent.window_resize();
	//cmnClCodeObj.windowsResizeFunction();
};


// Form 정보 세팅
cmnClCodeObj.setCmdTitle = function(cmd){
	cmnClCodeObj.EditFormInit();
	$("#cmd").val(cmd); 
	if( cmd=='save'){
		$("#cmdTitle").html('<spring:message code="button.create" />');
	}else if(cmd=='Modify'){
		$("#cmdTitle").html('<spring:message code="button.read.detail" />'); /*상세정보*/  
	} 
};


// 신규 작성
cmnClCodeObj.create = function(){
 
	cmnClCodeObj.setCmdTitle("save");

	// 수정중 신규(등록)버튼 선택할 경우 사용여부  Y 로 초기화 
	$("#useAt > option[value = Y]").attr("selected", "ture");   // "selected"  or   "ture"	

	$("#list").resetSelection();
	
	cmnClCodeObj.openEditForm();
};

//내용보기 
cmnClCodeObj.read = function(rowid){
	
	cmnClCodeObj.setCmdTitle("Modify");
	
	var obj = cmnClCodeObj.jsondata[rowid-1];
	
	if(obj){
		var formData = {	"clCode" : obj.clCode};
		var isSuccess = false;
		var clCodeDc;
		
		// textarea 와 같은 개행문자 포함되어 있는 경우 json 
		$.ajax({
			type:"post",
			url:'<c:url value="/sym/ccm/ccc/selectCmmnClCodeDc.do" />',
			async: false,
			datatype:"json",
			data: formData,
			success:function(data){
				switch (data.result) {
					case 0:	  isSuccess  = true;	clCodeDc=data.clCodeDc;	break;
					//default :		 alert('3333');				break;
				}
			},			
			error : function(e){		}
		});		
		if(isSuccess)
		{
			// 사용여부
			$("#useAt > option[value = "+obj.useAt+"]").attr("selected", "ture");   // "selected"  or   "ture"	
			// 분류코드
			$("#clCode").val(obj.clCode);				
			$("#clCode").attr("disabled", "disabled");
			
			// 분류코드명
			$("#clCodeNm").val(obj.clCodeNm);		
			// 분류코드 설명 
			$("#clCodeDc").val(clCodeDc);
			cmnClCodeObj.openEditForm();
			
		}else{
			alert("<spring:message code='dataLoad.detailInfo.fail' />\r\n<spring:message code='system.bm.sign.retryplz' />");//   상세정보 불러오기에 실패 하였습니다.  /  잠시후에 이용해주시기 바랍니다.
			cmnClCodeObj.cmnClCodeList();
		}
	}
};


//  등록/수정 취소
cmnClCodeObj.cancel = function(){
	var isCancel = confirm('<spring:message code="common.cancel.msg" />');/*취소하시겠습니까?*/
	if(isCancel){
		cmnClCodeObj.cmnClCodeList();
		$("#list").resetSelection();
	}
};

cmnClCodeObj.cmnClCodeList = function(){
	cmnClCodeObj.closeEditForm();
	cmnClCodeObj.EditFormInit();
};

cmnClCodeObj.EditFormInit = function(){
	var empty = "";	 
	
	$("#clCode").removeAttr("disabled");
	
	$("#clCodeNm").val(empty);					
	$("#clCodeDc").val(empty);	 	
};	

cmnClCodeObj.resizeTopSearch = function(){
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
cmnClCodeObj.validate = function(isNew,clCode,clCodeNm,clCodeDc){
	
	if(isNew) // 신규인 경우에만 
		if(cmnClCodeObj.chkNull(clCode,"<spring:message code='system.comm.groupCode.clCode' />"))		return false;  //분류코드

	if(cmnClCodeObj.chkNull(clCodeNm,"<spring:message code='system.comm.groupCode.clCodeNm' />"))		return false;  //분류코드명
	if(cmnClCodeObj.chkNull(clCodeDc,"<spring:message code='system.comm.groupCode.clCodeDc' />"))	return false;  //분류코드 설명

	   
	return true;
};

cmnClCodeObj.chkNull = function(fVal, fTitle){
	if(!$.trim(fVal)){
		alert(fTitle+"<spring:message code='valid.input.form.requisite.msg' />"); /*  (을)를 입력해주세요.*/
		return  true;
	}	
	return false;
};

//삭제
cmnClCodeObj.del =  function(){
	$("#isDel").val(true);
	cmnClCodeObj.actionSubmit();
};

// 수정.등록.삭제 처리.
cmnClCodeObj.actionSubmit = function(){
	    	
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
			alert("<spring:message code='system.comm.groupCode.doDelSelect' />");		// 삭제할 분류코드를 선택해주세요.
			return false;
		}else if(checkedLen>1){
			$("#isDel").val(false);
			alert("<spring:message code='system.comm.groupCode.doDelOneSelect' />");	// 삭제할 분류코드를 하나만 선택해주세요.
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
	var clCode = $("#clCode").val();			//  분류코드 
	var clCodeNm = $("#clCodeNm").val();		//  분류코드명
	var clCodeDc = $("#clCodeDc").val();		//  분류코드 설명 
	var useAt = $("#useAt").val();			//  사용여부 		
	
	if(isDel != 'true'){    // 삭제가 아닌 경우애만 valid 체크
		// clCode , clCodeNm  , clCodeDc , useAt
		// system.comm.groupCode.clCodeDc  system.comm.groupCode.clCodeNm   system.comm.groupCode.clCode
		
		if(!cmnClCodeObj.validate(isNew,clCode,clCodeNm,clCodeDc)){
			return false;
		}				
	}

	var cUrl;
	var msgSuccess;
	var msgError;
	if(action=="S"){  	 // save			
		cUrl = '<c:url value="/sym/ccm/ccc/EgovCcmCmmnClCodeRegist.do" />';	
		msgSuccess = "<spring:message code='system.bm.sign.insertend' />";  // 등록이 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.inserterror' />";//등록을 실패 하였습니다.
	}else if(action=="M"){ 	// Modify 
		cUrl = '<c:url value="/sym/ccm/ccc/EgovCcmCmmnClCodeModify.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.editend' />";//수정이 완료 되었습니다. 
		msgError = "<spring:message code='system.bm.sign.editerror' />"; //수정을 실패 하였습니다.				
	}else{
		cUrl = '<c:url value="/sym/ccm/ccc/EgovCcmCmmnClCodeRemove.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.deleteend' />";// 삭제가 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.deleteerror' />"; //삭제가 실패 하였습니다. 
	}
	msgError = msgError +"\r\n<spring:message code='system.bm.sign.retryplz' />";  //   잠시후에 이용해주시기 바랍니다.
	
	 // 삭제인 경우  ::  복수건인 경우에만 필요.  
	 //             단일 건인 경우 현재 확인중인 건만 삭제 가능하므로 불필요
	// if(isDel){   
	//	var id = $("#list").jqGrid('getGridParam','selrow');
	//	var obj = cmnClCodeObj.jsondata[id-1];
	//	var formData = {
	//		"code" : obj.code,
	//		"codeId" : obj.codeID,
	//		"codeIdNm" : obj.codeIdNm,
	//		"codeIdDc" : obj.codeIdDc,
	//		"useAt" : obj.useAt
	//	};	
	// }else{
		
		//var formData = $("#editForm").serialize();// disable    form 은 처리 불가.		
		
			
		// clCode , clCodeNm  , clCodeDc , useAt
		// system.comm.groupCode.clCodeDc  system.comm.groupCode.clCodeNm   
		
		var formData = {
			"clCode" : clCode,
			"clCodeNm" : clCodeNm,
			"clCodeDc" : clCodeDc,
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
					cmnClCodeObj.pagingClick(1);
					break;
				case -1:
					alert("<spring:message code='system.comm.detail.commCode.regist.duplicate' />"); /*"이미 등록된 코드가 존재합니다."*/
					break;
				case -8:
					alert("<spring:message code='common.access.denied' />"); /* 잘못된 접근입니다.  */
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

	var jsondata = $.parseJSON('${resultList}');
	//$("#jsonData").html( '${resultList}');
	cmnClCodeObj.jsondata = jsondata;
	var obj = {};
	obj.option = {  
		data: jsondata, 
		datatype: 'local', 
		colNames:[
		 '<spring:message code="comm.board.listNo" />',  // 순번
		 '<spring:message code="system.comm.groupCode.clCode" />',  // 분류코드
		 '<spring:message code="system.comm.groupCode.clCodeNm" />',  // 분류코드명
		 '<spring:message code="cop.useAt" />' // 사용여부
		 //'clCodeDc'
		], 
		colModel:[  
		{name:'menuNm', index:'menuNm', align:'center',sortable:false},	// <c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
		{name:'clCode', index:'clCode',  align:'center'},				// , formatter : jqGridUtil.TextOverFlow
		{name:'clCodeNm', index:'clCodeNm', align:'left'},	  			// , editable: true
		{name:'useAt', index:'useAt', align:'center',  formatter : fn_useYN }
		//{name:'clCodeDc', index:'clCodeDc',  hidden:true}
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
					cmnClCodeObj.read(rowid);  
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
				//$.jqGrid.data = {"0":"6%","1":"20%", "2":"60%", "3":"14%"}; 
				$.jqGrid.data = {"0":"20px","1":"6%","2":"20%", "3":"60%", "4":"14%"}; 
				
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
-->
</script>
</head>
<body>
		
	<form name="listForm" id="listForm"  action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeList.do'/>" method="post">
	<input name="pageIndex" id="pageIndex"  type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> 						
	
<div class="searchArea clearfx" id="" >
        <span>
            <select name="searchCondition" id="searchCondition" class="text-pad" style="width:100px" title=""  >
                   <option selected value=''><spring:message code='select.option.title' /></option>
                   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code='system.comm.groupCode.clCode' /></option>
                   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><spring:message code='system.comm.groupCode.clCodeNm' /></option>
             </select>
             <input type="text" name="searchKeyword" id="searchKeyword" style="width:200px;" value=""  onkeyup="javascript:if(event.keyCode==13){cmnClCodeObj.search(); return false;}"/></span>
        <a href="javascript:cmnClCodeObj.search();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
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
                        <li><strong style="width:95px;"><spring:message code='system.comm.groupCode.clCode' /><span class="f_red">*</span></strong> 
                              <input type="text"  name="clCode" id="clCode" maxlength="6" style="width:153px;"/>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.comm.groupCode.clCodeNm' /><span class="f_red">*</span></strong> 
                              <input type="text"  name="clCodeNm" id="clCodeNm" maxlength="60" style="width:153px;"/>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.comm.groupCode.clCodeDc' /><span class="f_red">*</span></strong> 
                              <textarea name="clCodeDc" id="clCodeDc" style="width:440px; height:40px;">내용을 입력해 주세요</textarea>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='cop.useAt' /></strong>
                            <select name="useAt" id="useAt" class="select"  style="width:100px;"  title="<spring:message code='cop.useAt' />">
                                <option value='Y' ><spring:message code='button.use'/></option>
                                <option value='N' ><spring:message code='button.use.none'/></option>
                            </select>   
                         </li>
                    </ul>

            <p class="tC mT15" id="saveButton">
                 <a href="javascript:cmnClCodeObj.actionSubmit();" class="darkBtn"><span>저장</span></a> 
                 <a href="javascript:cmnClCodeObj.cancel();" class="grayBtn"><span>취소</span></a>
            </p>
            <p class="tC mT15"  style="display:none;"  id="editButton">
                 <a href="javascript:cmnClCodeObj.actionSubmit();" class="darkBtn"><span>수정</span></a> 
                 <a href="javascript:cmnClCodeObj.del();" class="grayBtn"><span>폐기</span></a>
            </p>
        </fieldset>             
</div>
	</form>
	<!--  수정/등록 화면   END -->	

	<div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["<spring:message code='button.new' />"/*신규 */, "<spring:message code='button.delete2' />"/*폐기 */];
		var fn = ["cmnClCodeObj.create()","cmnClCodeObj.del()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);
	</script>							

	<div class="board_table mT7" id="board_table">
		<table id="list" ></table>
	</div>
	<div style="height: 12px;"></div>
	<div align="center" class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image"	jsFunction="cmnClCodeObj.pagingClick" />
	</div>
	
</body>
</html>
