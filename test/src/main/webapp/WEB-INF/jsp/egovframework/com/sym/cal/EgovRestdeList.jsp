<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovRestdeList.jsp
  * @Description : EgovRestdeList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *   2011.08.12   서준식              페이징 번호 정렬이 리스트와 일치하도록 수정
  							   CSS 경로 수정
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
<title><spring:message code='system.holiday.list.title' /></title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js' />" ></script>
<script type="text/javascript">

/*---------------------------------------------*/
$(function(){
	restdeObj.init();		
	$(window).resize(function(){
		restdeObj.windowsResizeFunction();
	});	
});

var restdeObj = {};
restdeObj.jsondata = {};
restdeObj.restdeCodeObj  = {};

restdeObj.windowsResizeFunction = function(){
	//restdeObj.resizeTopSearch();	
	//restdeObj.boardTableWidth();
};
restdeObj.boardTableWidth = function()
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

restdeObj.init = function(){
	// 검색어란 key action
	restdeObj.searchTextSet();	
	// 윈도우 리사이즈
	restdeObj.windowsResizeFunction();	
	shoutCutTitleChange('<spring:message code="system.holiday.list.title" />'/*공휴일 관리*/);
    
	restdeObj.restdeCodeObj =  JSON.parse('${restdeCode}');
	var restdeCode = NeosCodeUtil.getCodeSelectList(restdeObj.restdeCodeObj , "restdeSeCode",null,"");
	var restdeCodeSelect = $(restdeCode).css("width", "180px");
	$("#restdeCodeSelect").append(restdeCodeSelect);

};

restdeObj.pagingClick = function(pageNo){
	$("#pageIndex").val(pageNo);
	var listForm = $("#listForm");
	listForm.submit();	
};


restdeObj.search = function(){	
	restdeObj.pagingClick(1);
};

restdeObj.searchTextSet = function(){
	$("#searchKeyword").bind({
		keypress : function(event){
			if(event.keyCode == 13){
				restdeObj.search();
			}
		}
	});
};

restdeObj.openEditForm = function(){
	$("#divEditForm").slideDown();	// 작성폼 열기
	$("#divListBtn").hide();	// 목록 버튼 닫기
	restdeObj.windowsResizeFunction();
};

restdeObj.closeEditForm = function(){	
	$("#divEditForm").slideUp();	// 작성폼 닫기
	$("#divListBtn").show();	// 목록 버튼 열기
	restdeObj.windowsResizeFunction();
};


// Form 정보 세팅
restdeObj.setCmdTitle = function(cmd){
	restdeObj.EditFormInit();
	$("#cmd").val(cmd); 
	if( cmd=='save'){
		$("#cmdTitle").html('<spring:message code="button.create" />');
	}else if(cmd=='Modify'){
		$("#cmdTitle").html('<spring:message code="button.read.detail" />'); /*상세정보*/  
	} 
};


// 신규 작성
restdeObj.create = function(){
 
	restdeObj.setCmdTitle("save");

	// 수정중 신규(등록)버튼 선택할 경우 사용여부  Y 로 초기화 
	$("#useAt > option[value = Y]").attr("selected", "ture");   // "selected"  or   "ture"	

	$("#list").resetSelection();
	
	restdeObj.openEditForm();
};


//내용보기 
restdeObj.read = function(rowid){
	
	restdeObj.setCmdTitle("Modify");
	
	var obj = restdeObj.jsondata[rowid-1];
	
	if(obj){

		var formData = {"restdeNo" : obj.restdeNo};
		var isSuccess = false;
		var restdeDc =null;
		
		// textarea 와 같은 개행문자 포함되어 있는 경우 json 
		$.ajax({
			type:"post",
			url:'<c:url value="/sym/cal/govRestdeDc.do" />',
			async: false,
			datatype:"json",
			data: formData,
			success:function(data){
				switch (data.result) {
					case 0:	  isSuccess  = true;	restdeDc=data.restdeDc;	break;
				}
			},			
			error : function(e){		}
		});		
		if(isSuccess)
		{			
			//휴일종류 코드 
			$("#restdeSeCode > option[value = "+obj.restdeSeCode+"]").attr("selected", "ture");   // "selected"  or   "ture"	

			$("#vrestdeDe").val(obj.restdeDe);	//   휴일일자 
			$("#vrestdeDe").attr("disabled","disabled"); 			
			$("#calendarImg").hide(); 			
			
			// 휴일명
			$("#restdeNm").val(obj.restdeNm);				
			// sequence key
			$("#restdeNo").val(obj.restdeNo);		
			
			// 휴일설명	
			if(restdeDc!=null)	$("#restdeDc").val(restdeDc);	//   
			restdeObj.openEditForm();
			
		}else{
			alert("<spring:message code='dataLoad.detailInfo.fail' />\r\n<spring:message code='system.bm.sign.retryplz' />");//   상세정보 불러오기에 실패 하였습니다.  /  잠시후에 이용해주시기 바랍니다.
			restdeObj.restdeList();
		}		
	}	
};


//  등록/수정 취소
restdeObj.cancel = function(){
	var isCancel = confirm('<spring:message code="common.cancel.msg" />');/*취소하시겠습니까?*/
	if(isCancel){
		restdeObj.restdeList();
		$("#list").resetSelection();
	}
};

restdeObj.restdeList = function(){
	restdeObj.closeEditForm();
	restdeObj.EditFormInit();
};

restdeObj.EditFormInit = function(){
	var empty = "";

	$("#vrestdeDe").removeAttr("disabled");
	$("#calendarImg").show();
	
	$("#vrestdeDe").val(empty);					
	$("#restdeNm").val(empty);				
	$("#restdeDc").val(empty);				
};	

restdeObj.resizeTopSearch = function(){
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
restdeObj.validate = function( isNew,restdeDe,restdeNm,restdeDc){
	
	if(isNew) // 신규인 경우에만 
		if(restdeObj.chkNull(restdeDe,"<spring:message code='system.holiday.date' />"))		return false;  //휴일일자

	if(restdeObj.chkNull(restdeNm,"<spring:message code='system.holiday.name' />"))		return false;  //휴일명
	if(restdeObj.chkNull(restdeDc,"<spring:message code='system.holiday.desc' />"))		return false;  //휴일설명

	   
	return true;
};

restdeObj.chkNull = function(fVal, fTitle){
	if(!$.trim(fVal)){
		alert(fTitle+"<spring:message code='valid.input.form.requisite.msg' />"); /*  (을)를 입력해주세요.*/
		return  true;
	}	
	return false;
};

//삭제
restdeObj.del =  function(){
	$("#isDel").val(true);
	restdeObj.actionSubmit();
};

// 수정.등록.삭제 처리.
restdeObj.actionSubmit = function(){
	    	
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
			alert("<spring:message code='system.holiday.doDelSelect' />");		// 삭제할 휴일을 선택해주세요.
			return false;
		}else if(checkedLen>1){
			$("#isDel").val(false);
			alert("<spring:message code='system.holiday.doDelOneSelect' />");	// 삭제할 휴일을 하나만 선택해주세요.
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
	var restdeDe = $("#restdeDe").val();			//   휴일일자 
	var restdeNm = $("#restdeNm").val();			//  휴일명*
	var restdeDc = $("#restdeDc").val();			//  휴일설명
	var restdeSeCode = $("#restdeSeCode").val();	//  휴일구분 
	var restdeNo = $("#restdeNo").val();	//  휴일구분 
	
	
	
	if(isDel != 'true'){    // 삭제가 아닌 경우애만 valid 체크
		// 수정시 : codeIdNm  codeIdDc    , useAt
		// 신규 :  code + 수정시 항목   ..clCode  codeId	
		
		if(!restdeObj.validate(isNew,restdeDe,restdeNm,restdeDc)){
			return false;
		}				
	}

	var cUrl;
	var msgSuccess;
	var msgError;
	if(action=="S"){  	 // save			
		cUrl = '<c:url value="/sym/cal/EgovRestdeRegist.do" />';	
		msgSuccess = "<spring:message code='system.bm.sign.insertend' />";  // 등록이 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.inserterror' />";//등록을 실패 하였습니다.
	}else if(action=="M"){ 	// Modify 
		cUrl = '<c:url value="/sym/cal/EgovRestdeModify.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.editend' />";//수정이 완료 되었습니다. 
		msgError = "<spring:message code='system.bm.sign.editerror' />"; //수정을 실패 하였습니다.				
	}else{
		cUrl = '<c:url value="/sym/cal/EgovRestdeRemove.do" />';  
		msgSuccess = "<spring:message code='system.bm.sign.deleteend' />";// 삭제가 완료 되었습니다.
		msgError = "<spring:message code='system.bm.sign.deleteerror' />"; //삭제가 실패 하였습니다. 
	}
	msgError = msgError +"\r\n<spring:message code='system.bm.sign.retryplz' />";  //   잠시후에 이용해주시기 바랍니다.
	
	 // 삭제인 경우  ::  복수건인 경우에만 필요.  
	 //             단일 건인 경우 현재 확인중인 건만 삭제 가능하므로 불필요
	// if(isDel){   
	//	var id = $("#list").jqGrid('getGridParam','selrow');
	//	var obj = restdeObj.jsondata[id-1];
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
			"restdeDe" : restdeDe,
			"restdeNm" : restdeNm,
			"restdeDc" : restdeDc,
			"restdeSeCode" : restdeSeCode
		};
		if(action!="S"){ 	// 수정 혹은 삭제시  
			formData["restdeNo"] = restdeNo; 
		}
             
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
					restdeObj.pagingClick(1);
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
	restdeObj.jsondata = jsondata;
	var obj = {};
	obj.option = {  
		data: jsondata, 
		datatype: 'local', 
		colNames:[
       '<spring:message code="comm.board.listNo" />',  // 순번
       '<spring:message code="system.holiday.date" />',  // 휴일일자
       '<spring:message code="system.holiday.name" />',  // 휴일명
       '<spring:message code="system.holiday.type" />',  // 휴일구분
       'restdeNo',
       'restdeSeCode'
		], 	
		//var restdeDe = $("#restdeDe").val();			//   휴일일자 
		//var restdeNm = $("#restdeNm").val();		//  휴일명*
		//var restdeDc = $("#restdeDc").val();		//  휴일설명
		//var restdeSeCode = $("#restdeSeCode").val();		//  휴일구분 	
		
		colModel:[   
		{name:'menuNm', index:'menuNm', align:'center',sortable:false},  // <c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
		{name:'restdeDe', index:'restdeDe',  align:'center', formatter : fn_dateview},// , formatter : jqGridUtil.TextOverFlow
		{name:'restdeNm', index:'restdeNm', align:'left'},	  // , editable: true
		{name:'restdeSe', index:'restdeSe', align:'left'},	
		{name:'restdeNo', index:'restdeNo',  hidden:true},
		{name:'restdeSeCode', index:'restdeSeCode',  hidden:true}
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
					restdeObj.read(rowid);  
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
				//$.jqGrid.data = {"0":"6%","1":"20%", "2":"50%", "3":"24%"}; 
				$.jqGrid.data = {"0":"20px","1":"6%","2":"20%", "3":"50%", "4":"24%"}; 
				
				$.jqGrid.min = jqGridUtil.minWidth();
				jqGridUtil.resizeJqGrid("board_table");
			}
		//,height:"700px"
	};
	//공통으로 적용할 옵션 가져오기
	obj = jqGridUtil.jqGridCommonOption(obj);
	$("#list").jqGrid(obj.option);
}

function fn_dateview(cellvalue, options, rowObject){
	return   cellvalue.substring( 0,4) +"-"+ cellvalue.substring( 4,6)+"-"+ cellvalue.substring( 6,8);								
}
/* --------------------------------------------------------  *  
 * jqGrid END 
 * --------------------------------------------------------- */
 
//song Excel업로드를 위해 추가함
dialogViewSet = function(b){
    NeosUtil.dialogStyleSet("dialog-Background");
    if(b){
        $("#dialog-Background").show();
        $("#restde_pop").css("zIndex", "899999").show();
    }else{
        $("#dialog-Background").hide();
        $("#restde_pop").hide(); 
    } 
};    

function hideWriteForm(){
    $("#restde_pop").hide();
    dialogViewSet(false);
}

function fn_Pop(){
    $.ajax({
        type:"post",
        url:'<c:url value="/sym/cal/com/restdeExcelUploadForm.do" />',
        datatype:"html",
        success:function(data){            
        	dialogViewSet(true);
            $("#restde_pop").html(data);
            $("#restde_pop").show();
        }
    });
}

function excelUpload(){
	$("#restdexlsform").attr("action","/gw/sym/cal/restdeExcelUploadProc.do");
    $("#restdexlsform").attr("target", "hiFrame");
    $("#restdexlsform").submit();
}
//->Excel 업로드 여기까지
</script>

</head>
<body>

									
	
	<form name="listForm" id="listForm"  action="<c:url value='/sym/cal/EgovRestdeList.do'/>" method="post">
	<input name="pageIndex" id="pageIndex"  type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> 					
<div class="searchArea clearfx" id="" >
        <span>
                <select name="searchCondition" id="searchCondition" class="text-pad" style="width:100px" title=""  >
                   <option selected value=''><spring:message code='select.option.title' /></option>
                   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code='system.holiday.date' /></option>
                   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><spring:message code='system.holiday.name' /></option>
               </select>
             <input type="text" name="searchKeyword" id="searchKeyword" style="width:200px;" value=""  onkeyup="javascript:if(event.keyCode==13){restdeObj.search(); return false;}"/></span>
        <a href="javascript:restdeObj.search();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
</div>	
	</form>		
	
									
	
	<!--  수정/등록 화면   START -->	
	<form id="editForm" name="editForm" method="post">	
	<input id="cmd" name="cmd" type="hidden"/> 		
	<input id="isDel" name="isDel" type="hidden"/>		
	<input id="restdeDe" name="restdeDe" type="hidden"/>		
	<input id="restdeNo" name="restdeNo" type="hidden"/>		

<div id="divEditForm" style="display:none; width:100% ">
       <fieldset class="mT20">
                    <legend>상세 정보</legend>
                    <ul class="inputForm">
                        <li><strong style="width:95px;"><spring:message code='system.holiday.date' /><span class="f_red">*</span></strong> 
                              <input type="hidden" name="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
                              <input name="vrestdeDe" id="vrestdeDe" type="text" size="10" value=""  maxlength="10" readonly onClick="javascript:fn_egov_NormalCalendar(document.editForm, document.editForm.restdeDe, document.editForm.vrestdeDe);" title="<spring:message code="sym.cal.restDay" />(<spring:message code="button.newWindow" />)"/>
                              <span id="calendarImg" ><a href="#noscript" onclick="fn_egov_NormalCalendar(document.editForm, document.editForm.restdeDe, document.editForm.vrestdeDe); return false;" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/common/btn_callender.gif' />" alt="<spring:message code="button.diary.pop.alt" />"></a></span>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.holiday.name' /><span class="f_red">*</span></strong> 
                              <input type="text"  name="restdeNm" id="restdeNm" maxlength="50" style="width:150px;"/>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.holiday.desc' /><span class="f_red">*</span></strong> 
                              <textarea name="restdeDc" id="restdeDc" style="width:440px; height:40px;">내용을 입력해 주세요</textarea>
                        </li>
                        <li><strong style="width:95px;"><spring:message code='system.holiday.type' /></strong>
                             <span id='restdeCodeSelect'></span>
                         </li>
                    </ul>
                
            <p class="tC mT15" id="saveButton">
                 <a href="javascript:restdeObj.actionSubmit();" class="darkBtn"><span>저장</span></a> 
                 <a href="javascript:restdeObj.cancel();" class="grayBtn"><span>취소</span></a>
            </p>
            <p class="tC mT15"  style="display:none;"  id="editButton">
                 <a href="javascript:restdeObj.actionSubmit();" class="darkBtn"><span>수정</span></a> 
                 <a href="javascript:restdeObj.del();" class="grayBtn"><span>폐기</span></a>
            </p>    
             
        </fieldset>             
</div>
<script type="text/javascript">
function excelDownload()
{
	window.open("<c:url value="/sym/cal/restdeExcelDown.do"/>", "excel"); 
}
</script>
	</form>
	<!--  수정/등록 화면   END -->				

	<!-- <div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["<spring:message code='button.new' />"/*신규 */, "<spring:message code='button.delete2' />"/*폐기 */,"Excel 양식다운로드","Excel 업로드"];
		var fn = ["restdeObj.create()","restdeObj.del()","javascript:excelDownload()","javascript:fn_Pop()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);
	</script> -->


	<div class="clearfx mT18">
		<p class="fR">
		 <a title="신규" class="btnArrow" id=""  onclick="restdeObj.create()" href="javascript:;"><span>신규</span></a>
		 <a title="폐기" class="btnArrow" id=""  onclick="restdeObj.del()" href="javascript:;"><span>폐기</span></a>
		 <a title="Excel 양식다운로드" class="btnArrow" id=""  onclick="javascript:excelDownload()" href="javascript:;"><span><img src="<c:url value='/images/common/ico_exel.gif'></c:url>"  alt="엑셀" /> Excel 양식다운로드</span></a>
		 <a title="Excel 업로드" class="btnArrow" id="" onclick="javascript:fn_Pop()" href="javascript:;"><span><img src="<c:url value='/images/common/ico_exel.gif'></c:url>"  alt="엑셀" /> Excel 업로드</span></a>
		</p>
	</div>

								
	<div class="board_table mT7" id="board_table">
		<table id="list" ></table>
		<!--  table id="jsonData" ></table -->
	</div>
	<div style="height: 12px;"></div>
	<div align="center" class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image"	jsFunction="restdeObj.pagingClick" />
	</div>
				


</body>
<!-- song Excel 업로드 -->
<form id="restdexlsform" name="restdexlsform" method="post" enctype="multipart/form-data" >
<div class="detailSchMonth01" id="restde_pop" style="z-index:99999;"></div>
</form>
<iframe id="hiFrame" name="hiFrame" style="width:0px;height:0px;" /> 
<!-- song Excel 업로드 여기까지-->	
</html>
