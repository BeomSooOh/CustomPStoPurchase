<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovCcmZipList.jsp
  * @Description : EgovCcmZipList 화면
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
<title><spring:message code='system.zipCode.list' /></title>


<script type="text/javascript">
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/
$(function(){
	zipObj.init();		
	$(window).resize(function(){
		zipObj.windowsResizeFunction();
	});	
});


var zipObj = {};
zipObj.jsondata = {};

zipObj.windowsResizeFunction = function(){
	//zipObj.resizeTopSearch();	
};

zipObj.init = function(){
	// 주소방식 radioBtn action
	$("input[name='zipCl']").click(function() { zipObj.checkZipCl(); });
	// 검색어란 key action
	zipObj.searchTextSet();	
	zipObj.selSearchList();

	shoutCutTitleChange('<spring:message code="system.zipCode.list" />'/*우편번호 관리*/);
	
	// 윈도우 리사이즈
	zipObj.windowsResizeFunction();
};

zipObj.pagingClick = function(pageNo){
	$("#pageIndex").val(pageNo);
	var listForm = $("#listForm");
	listForm.submit();	
};

// 목록회면 처리 함수
zipObj.selSearchList= function(){
	if ($("#searchCondition").val() == 1) {
		$("#searchCondition").show();  
		$("#searchCondition2").hide();  
	} else {
		$("#searchCondition").hide();  
		$("#searchCondition2").show();  
	}
};

zipObj.search = function(){
	
	if ($("#searchCondition").val() == "1" || $("#searchCondition2").val() == "1") {
		$("#searchKeyword").val($("#searchKeyword").val().replace(/\-/, ""));
	}
	zipObj.pagingClick(1);
};

zipObj.searchTextSet = function(){
	$("#searchKeyword").bind({
		keypress : function(event){
			if(event.keyCode == 13){
				zipObj.search();
			}
		}
	});
};

zipObj.openEditForm = function(){
	$("#divEditForm").slideDown();	// 작성폼 열기
	//$("#divGap").show();  // 작성폼 간격  보이기
	//$("#divListForm").slideUp();    // 목록 닫기
	$("#divListBtn").hide();	// 목록 버튼 닫기
	zipObj.windowsResizeFunction();
};

zipObj.closeEditForm = function(){	
	$("#divEditForm").slideUp();	// 작성폼 닫기
	//$("#divGap").hide();  // 작성폼 간격 숨기기
	//$("#divListForm").slideDown();	// 목록 폼 열기
	$("#divListBtn").show();	// 목록 버튼 열기
	zipObj.windowsResizeFunction();
};

// 신규 작성  cType :  1(단건 등록),  2(엑셀 파일 등록)
zipObj.create = function(cType){
	if(cType==1)
		$("#cmd").val("save");   
	else
		$("#cmd").val("ExcelZipRegist");  	
	
	// 현재 선택값 기준
	//var searchList = parseInt($("#searchList").val());
	// 목록 조회시점의 기준
	var searchList = parseInt("<c:out value='${searchVO.searchList}'/>");
	
	zipObj.setEditType(searchList);		
	$("#zipClRow").show();  // 우편번호 형식 open
	zipObj.openEditForm();
};

// 주소 형식 세팅 : 등록/수정시 화면세팅을 위함    주소형식(1:일반,2:도로명)
zipObj.setEditType = function(editType){

	$("#zipCl"+editType).attr("checked",true);
	var zipCl = $("input[name='zipCl']:checked").val() ;	
	zipObj.checkZipCl();	
};

// Form 정보 세팅
//zipObj.setCmdTitle = function(searchList){
zipObj.setCmdTitle = function(){

	// $("#cmdTitle").html("우편번호 "+(searchList==1?"일반주소":"도로명주소")+($("#cmd").val()=='save'?" 등록":" 수정")); /// 1: 일반 , 2: 도로명 

	if( $("#cmd").val()=='save'){
		$("#cmdTitle").html('<spring:message code="button.create" />');
	}else if($("#cmd").val()=='Modify'){
		//$("#cmdTitle").html('<spring:message code="button.update" />'); /* 수정 */
		$("#cmdTitle").html('<spring:message code="button.read.detail" />'); /*상세정보*/  //보기와 수정을 동시에
	} else if($("#cmd").val()=='Read') {	// Read	
		$("#cmdTitle").html('<spring:message code="button.read" />');  /* 보기*/
	}else{  //  엑셀파일 등록<
		$("#cmdTitle").html('<spring:message code="button.excel.regist" />');
		
	}
};

//우편번호 방식 변경시
zipObj.checkZipCl = function(){
	// 폼 초기화
	zipObj.EditFormInit();
	zipObj.setCmdTitle(); 

	if( $("#cmd").val()=='ExcelZipRegist'){
		$("#excel_inp").show(); 
		$("#zipClcom_inp0").hide(); 
		$("#zipClcom_inp1").hide(); 
		$("#zipCl1_inp0").hide();
		$("#zipCl1_inp1").hide();
		$("#zipCl2_inp0").hide();
		$("#zipCl2_inp1").hide();
		$("#zipCl2_inp2").hide();
		
	}else{
		$("#excel_inp").hide(); 
		$("#zipClcom_inp0").show(); 
		$("#zipClcom_inp1").show(); 
		
	    if ($("#zipCl1").attr("checked")) {  // 일반주소      
			$("#zipCl1_inp0").show(); 
			$("#zipCl1_inp1").show(); 
			$("#zipCl2_inp0").hide();
			$("#zipCl2_inp1").hide();
			$("#zipCl2_inp2").hide();
	    	
	    }else{  //  도로명 주소
			$("#zipCl1_inp0").hide();
			$("#zipCl1_inp1").hide();
			$("#zipCl2_inp0").show();
			$("#zipCl2_inp1").show();
			$("#zipCl2_inp2").show();		
	    }
	}
};

//내용보기 
zipObj.read = function(rowid){

	// 보기와 수정 동시에 
	$("#cmd").val("Modify"); 
	
	var obj = zipObj.jsondata[rowid-1];
	//var isRead = type=='R'?true:false;
	//alert('isRead : '+isRead);
	
	if(obj){
		/*
	    	ctprvnNm	signguNm	rdmn		 	bdnbrMnnm
			bdnbrSlno	buldNm		detailBuldNm	zip			rdmnCode	sn	
		*/		
		var zipType = 1;   // 도로명 코드가 있으면 도로명 주소. 없으면 일반주소 
		if(obj.rdmnCode!=null)	zipType++;
			
		zipObj.setEditType(zipType);	
		$("#zipClRow").hide();
		//$("#zipCl2").attr("disabled", "disabled");
		
	// 수정 가능한 항목  ( default Query 기준 )
	//	[일반 주소]
	//		> 시도명(f_sido - ctprvnNm) , 시군구명(f_sigungu - signguNm)
	// 	 	> 읍면동명(f_emd  - emdNm)	,   리건물명 (f_liBldNm  : liBuldNm)
	//		> 번지동호(  f_bjdh   : lnbrDongHo)
	//	[도로명 주소]
	//		> 우편번호 : 우편번호(f_zip - zip)  
	//		> 시도명(f_sido - ctprvnNm) , 시군구명(f_sigungu - signguNm)
	//		> 도로명( f_rdnm : rdmn )
	//		> 건물번호본번( f_bldMno: bdnbrMnnm) , 건물번호부번( f_bldSno : bdnbrSlno)	
	//		> 건물명( f_bldnm : buldNm),  상세건물명(  f_dtbldnm: detailBuldNm)
	
		$("#sn").val(obj.sn);			// 우편번호(f_zip - zip)  
		$("#f_zip").val(obj.zip);			// 우편번호(f_zip - zip)  		
		
		$("#f_sido").val(obj.ctprvnNm); 		// 시도명(f_sido - ctprvnNm)
		$("#f_sigungu").val(obj.signguNm);		// 시군구명(f_sigungu - signguNm)

		if(zipType==1){
			// 보기와 수정을 동시에 할 경우 주석해제
			$("#f_zip").attr("disabled", "disabled"); 
			$("#f_emd").val(obj.emdNm);			// 읍면동명(f_emd  - emdNm)	
			if(obj.liBuldNm!=null)		$("#f_liBldNm").val(obj.liBuldNm);	// 리건물명 (f_liBldNm  : liBuldNm)
			if(obj.lnbrDongHo!=null)	$("#f_bjdh").val(obj.lnbrDongHo);	//  번지동호(  f_bjdh   : lnbrDongHo)	
			
		}else{			
			$("#f_rdnmCd").val(obj.rdmnCode);	// 도로명코드(  f_rdnmCd : rdmnCode)	
			// 보기와 수정을 동시에 할 경우 주석해제
			$("#f_rdnmCd").attr("disabled", "disabled");
			$("#f_rdnm").val(obj.rdmn);		// 도로명( f_rdnm : rdmn )) 
			if(obj.bdnbrMnnm!=null)		$("#f_bldMno").val(obj.bdnbrMnnm);	// 건물번호본번( f_bldMno: bdnbrMnnm )					
			if(obj.bdnbrSlno!=null)		$("#f_bldSno").val(obj.bdnbrSlno);	// 건물번호부번( f_bldSno : bdnbrSlno)	
			if(obj.buldNm!=null)		$("#f_bldnm").val(obj.buldNm);		// 건물명( f_bldnm : buldNm)
			if(obj.detailBuldNm!=null)	$("#f_dtbldnm").val(obj.detailBuldNm);	// 상세건물명(  f_dtbldnm: detailBuldNm)
		}
	}
	
	zipObj.openEditForm();		
};
// 수정하기    게시글rowid , 조회시점의 주소 방식 기준 
//  클릭시 정보 보기,  정보보기 화면에서 edit 선택시 수정가능 처리 
zipObj.edit = function(rowid){
	$("#cmd").val("Modify"); 
	
	var zipType = 1;   // 도로명 코드가 있으면 도로명 주소. 없으면 일반주소 	
	if($("#f_rdnmCd").val()!=""){
		zipType++;	
	}
		
	zipObj.setCmdTitle();
	
	$("#f_zip").removeAttr("readonly");
	$("#f_sido").removeAttr("readonly");
	$("#f_sigungu").removeAttr("readonly");	

	if(zipType==1){
		$("#f_zip").attr("disabled", "disabled"); 
		$("#f_emd").removeAttr("readonly");
		$("#f_liBldNm").removeAttr("readonly");
		$("#f_bjdh").removeAttr("readonly");		
	}else{			
		$("#f_rdnmCd").removeAttr("readonly");
		$("#f_rdnmCd").attr("disabled", "disabled");
		$("#f_rdnm").removeAttr("readonly");
		$("#f_bldMno").removeAttr("readonly");
		$("#f_bldSno").removeAttr("readonly");
		$("#f_bldnm").removeAttr("readonly");
		$("#f_dtbldnm").removeAttr("readonly");
	}
};

//  등록/수정 취소
zipObj.cancel = function(){
	var isCancel = confirm('<spring:message code="common.cancel.msg" />');/*취소하시겠습니까?*/
	if(isCancel){
		zipObj.zipList();
	}
};

zipObj.zipList = function(){
	zipObj.closeEditForm();
	zipObj.EditFormInit();
};

zipObj.EditFormInit = function(){
	var empty = "";

	$("#f_zip").removeAttr("disabled");
	$("#f_rdnmCd").removeAttr("disabled");
	$("#f_zip").val(empty);			// 우편번호(f_zip - zip)  
	$("#f_sido").val(empty); 		// 시도명(f_sido - ctprvnNm)
	$("#f_sigungu").val(empty);	// 시군구명(f_sigungu - signguNm)
	$("#f_emd").val(empty);			// 읍면동명(f_emd  - emdNm)	
	// 일반 주소 등록인 경우
	$("#f_liBldNm").val(empty);	// 리건물명 (f_liBldNm  : liBuldNm)
	$("#f_bjdh").val(empty);		//  번지동호(  f_bjdh   : lnbrDongHo)	
	// 도로면 주소인 경우
	$("#f_rdnmCd").val(empty);	// 도로명코드(  f_rdnmCd : rdmnCode)
	$("#f_rdnm").val(empty);		// 도로명( f_rdnm : rdmn )
	$("#f_bldMno").val(empty);	// 건물번호본번( f_bldMno: bdnbrMnnm) 
	$("#f_bldSno").val(empty);	// 건물번호부번( f_bldSno : bdnbrSlno)	
	$("#f_bldnm").val(empty);		// 건물명( f_bldnm : buldNm)
	$("#f_dtbldnm").val(empty);	// 상세건물명(  f_dtbldnm: detailBuldNm)
							
};	


zipObj.resizeTopSearch = function(){
	var win_w1 = $(window).width();
	var min = jqGridUtil.minWidth();
	 if(win_w1 && parseInt(win_w1)< parseInt(min)){
		 return false;
	 }
	 var leftWidth = NeosUtil.getLeftMenuWidth();
	 var width = win_w1 - leftWidth -14 ;
	 $(".top_search").css("width", width);
};
// 필수입력값 체크
// 일반주소여부 , 우편번호,시도,시군구,읍면동,도로코드, 도로명
zipObj.validate = function(isZipCl1,f_zip,f_sido,f_sigungu,f_emd, f_rdnmCd, f_rdnm){
	
	// 공통 필수 
	if(zipObj.chkNull(f_zip,"<spring:message code='system.zipCode' />"))		return false;  // 우편번호
	if(zipObj.chkNull(f_sido,"<spring:message code='system.zipCode.sidoNm' />"))			return false; // 시도명
	if(zipObj.chkNull(f_sigungu,"<spring:message code='system.zipCode.sigunguNm' />"))	return false;	// 시군구명명
	
	if(isZipCl1){  // 잉ㄹ반 조소인 경우
		if(zipObj.chkNull(f_emd,"<spring:message code='system.zipCode.umdNm' />"))		return false;	// 읍면동명
	}else{	// 도로명 주소인 경우   , f_rdnm
		if(zipObj.chkNull(f_rdnmCd,"<spring:message code='system.zipCode.roadCode' />"))	return false;	// 도로명코드
		if(zipObj.chkNull(f_rdnm,"<spring:message code='system.zipCode.roadNm' />"))		return false;	// 도로명
	}
	
	return true;
};

zipObj.chkNull = function(fVal, fTitle){
	if(!$.trim(fVal)){
		alert(fTitle+"<spring:message code='valid.input.form.requisite.msg' />"); /*  (을)를 입력해주세요.*/
		return  true;
	}	
	return false;
}
// 엑셀 파일인지 체크
zipObj.excelCheck = function(fName){
	var xlsFile = new Array("xls","xlsx");
	for(var i=0;i<xlsFile.length;i++){	
		if(xlsFile[i] == fName){
			//alert(':::::  : '+xlsFile[i] +'   /   '+fName);
			return true;
		}
	}
	return false;
}

// 수정과 등록만 존재함.  ( 삭제 기능은 일단 제외함 )
zipObj.actionSubmit = function(){
	
	// 일반 주소 체크 여부 
    var isZipCl1 = $("#zipCl1").attr("checked");
	//alert('isZipCl1 : '+isZipCl1);
    	
	var cmd = $("#cmd").val();	
	//alert('cmd : '+cmd);
	var comfirmMsg;	
	if(cmd=='Modify'){
		comfirmMsg =  "<spring:message code='common.update.msg' />"; ///*수정하시겠습니까?*/ 
	}else{  // 단건 등록 및 엑셀파일 등록
		comfirmMsg = "<spring:message code='common.regist.msg' />";/*등록하시겠습니까?*/
	}	


	if(confirm(comfirmMsg)){
		
		if(cmd =='ExcelZipRegist'){ //   엑셀파일 등록
			
			var fileNm  = $("#fileNm").val();	
			var arrTmp      = fileNm.split(".");

			//alert('fileNm : '+fileNm);
			if(!zipObj.excelCheck(arrTmp[arrTmp.length-1].toLowerCase())){
				alert("<spring:message code='valid.input.form.xls.attach.none' />\n<spring:message code='valid.input.form.chedk' />");/*엑셀 파일을 첨부하지 않았습니다.\n확인후 다시 처리하십시오.*/
				return false;
			}
			var varForm				 = document.getElementById("editForm");
			varForm.action           = "<c:url value='/sym/ccm/zip/EgovCcmExcelZipRegist.do' />";
			varForm.zipType.value = isZipCl1?1:2 ;			
			varForm.submit();
			
		}else{  // save, Modify  
			
			var f_zip = $("#f_zip").val();			// 우편번호(f_zip - zip)  
			var f_sido = $("#f_sido").val(); 		// 시도명(f_sido - ctprvnNm)
			var f_sigungu = $("#f_sigungu").val();	// 시군구명(f_sigungu - signguNm)
			var f_emd = $("#f_emd").val();			// 읍면동명(f_emd  - emdNm)	
			// 일반 주소 등록인 경우
			var f_liBldNm = $("#f_liBldNm").val();	// 리건물명 (f_liBldNm  : liBuldNm)
			var f_bjdh = $("#f_bjdh").val();		//  번지동호(  f_bjdh   : lnbrDongHo)	
			// 도로면 주소인 경우
			var f_rdnmCd = $("#f_rdnmCd").val();	// 도로명코드(  f_rdnmCd : rdmnCode)
			var f_rdnm = $("#f_rdnm").val();		// 도로명( f_rdnm : rdmn )
			var f_bldMno = $("#f_bldMno").val();	// 건물번호본번( f_bldMno: bdnbrMnnm) 
			var f_bldSno = $("#f_bldSno").val();	// 건물번호부번( f_bldSno : bdnbrSlno)	
			var f_bldnm = $("#f_bldnm").val();		// 건물명( f_bldnm : buldNm)
			var f_dtbldnm = $("#f_dtbldnm").val();	// 상세건물명(  f_dtbldnm: detailBuldNm)	
		      
			if(!zipObj.validate(isZipCl1,f_zip,f_sido,f_sigungu,f_emd, f_rdnmCd, f_rdnm)){
				return false;
			}		
			
			//var formData = $("#editForm").serialize();
			// 공통 입력 데이터
			var formData={};
			
			// 공통 입력 데이터
			//formData["zip"] = f_zip;		// 우편번호
			//formData["ctprvnNm"] = f_sido;		// 시도명
			//formData["signguNm"] = f_sigungu;		// 시군구명
			//formData["searchList"] = isZipCl1?1:2;		
			
			var formData = {
					"zip" : f_zip,			// 우편번호
					"ctprvnNm" : f_sido,	// 시도명
					"signguNm" : f_sigungu,	// 시군구명
					"searchList" : isZipCl1?1:2	
			};			
			
			//alert('>>>>>>>>>>>>>>  '+formData["searchList"]);
			//formData["cmd"] = $("#cmd").val(); 			
			
			//주소 형식 (1: 일반 / 2: 도로명) 에 따른 추가데이터 
			if(isZipCl1) {
				//alert('----------------- : ');
				formData["emdNm"] = f_emd; // 읍면동명
				formData["liBuldNm"] = f_liBldNm; // 리건물명
				formData["lnbrDongHo"] = f_bjdh; // 번지동호
				formData["rdmnCode"] = 0;  
				formData["rdmn"] = 0;  
			}else{
				//alert('++++++++++++++++++++++++ : ');
				formData["rdmnCode"] = f_rdnmCd; // 도로명코드
				formData["rdmn"] = f_rdnm; // 도로명
				formData["bdnbrMnnm"] = f_bldMno; // 건물번호본번
				formData["bdnbrSlno"] = f_bldSno; // 건물번호부번
				formData["buldNm"] = f_bldnm; // 건물명
				formData["detailBuldNm"] = f_dtbldnm; // 상세건물명			
				formData["emdNm"] = 0;  
			}	

			var cUrl;
			var msgSuccess;
			var msgError;
			if(cmd=='save'){
				cUrl = '<c:url value="/sym/ccm/zip/EgovCcmZipRegist.do" />';	
				msgSuccess = "<spring:message code='system.bm.sign.insertend' />";  // 등록이 완료 되었습니다.
				msgError = "<spring:message code='system.bm.sign.inserterror' />\r\n<spring:message code='system.bm.sign.retryplz' />";//등록을 실패 하였습니다.  잠시후에 이용해주시기 바랍니다.
			}else if(cmd=='Modify'){
				formData["sn"] = $("#sn").val();	
				cUrl = '<c:url value="/sym/ccm/zip/EgovCcmZipModify.do" />';  
				msgSuccess = "<spring:message code='system.bm.sign.editend' />";//수정이 완료 되었습니다. 
				msgError = "<spring:message code='system.bm.sign.editerror' />\r\n<spring:message code='system.bm.sign.retryplz' />"; //수정을 실패 하였습니다.   잠시후에 이용해주시기 바랍니다.
			}
			/*
			else{  // ExcelZipRegist   엑셀파일 등록 
				cUrl = '<c:url value="/sym/ccm/zip/EgovCcmExcelZipRegist.do" />';  			
				msgSuccess = "<spring:message code='system.bm.sign.insertend' />";  // 등록이 완료 되었습니다.
				msgError = "<spring:message code='system.bm.sign.inserterror' />\r\n<spring:message code='system.bm.sign.retryplz' />";//등록을 실패 하였습니다.  잠시후에 이용해주시기 바랍니다.
			}
			*/

			$.ajax({
				type:"post",
				url:cUrl,
				datatype:"json",
				data: formData,
				success:function(data){			
					alert('data.result : '+data.result);

					switch (data.result) {
						case 0:
							alert(msgSuccess);
							zipObj.pagingClick(1);
							break;
						case -8:
							alert("<spring:message code='common.access.denied' />"); /* 잘못된 접근입니다.  */
							break;
						default :  // -9  (현재 error 처리는 불필요함...  exception 발생시 무조건  error 로...but. 향후 상세 에러 처리를 위해 제어해둠)
							alert(msgError);
							break;
					}
				},
				error : function(e){	
					alert(msgError);	
				}
			});	
		}
	}
	
	/////////////////////////////////////////
	/////////////////////////////////////////			
	
	
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
	var jsondata = $.parseJSON('${resultList}');

	zipObj.jsondata = jsondata;
	var obj = {};
	obj.option = {  
		data: jsondata, 
		datatype: 'local', 
		colNames:[
			 '<spring:message code="comm.board.listNo" />',  // 순번
			 '<spring:message code="system.zipCode" />',  // 우편번호
			 '<spring:message code="system.zipCode.address" />',  // 주소
			 'sn',
			 'ctprvnNm',
			 'signguNm',
			 'emdNm',
			 'liBuldNm',
			 'lnbrDongHo',
			 'rdmnCode',
			 'rdmn',
			 'bdnbrMnnm',
			 'bdnbrSlno',
			 'buldNm',
			 'detailBuldNm' 
		], 
		colModel:[ 
		{name:'menuNm', index:'menuNm', align:'center',sortable:false},  // <c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/>
		{name:'zip', index:'zip', align:'center' ,  formatter : fn_zipCode },	  // , editable: true
		{name:'codeId', index:'codeId',  align:'left',  formatter : fn_address}, 
		{name:'sn', index:'sn',  hidden:true},
		{name:'ctprvnNm', index:'ctprvnNm',  hidden:true},
		{name:'signguNm', index:'signguNm',  hidden:true},
		{name:'emdNm', index:'emdNm',  hidden:true},
		{name:'liBuldNm', index:'liBuldNm',  hidden:true},
		{name:'lnbrDongHo', index:'lnbrDongHo',  hidden:true},
		{name:'rdmnCode', index:'rdmnCode',  hidden:true},
		{name:'rdmn', index:'rdmn',  hidden:true},
		{name:'bdnbrMnnm', index:'bdnbrMnnm',  hidden:true},
		{name:'bdnbrSlno', index:'bdnbrSlno',  hidden:true},
		{name:'buldNm', index:'buldNm',  hidden:true},
		{name:'detailBuldNm', index:'detailBuldNm',  hidden:true}
		], 
			//multiselect:false,
			//rownumbers:true,       //맨앞에 줄번호 보이기 여부
			//rownumWidth:40, 	// 줄번호 width
  			//width:'100%',  
			emptyrecords:"<spring:message code='common.nodata.msg' />" ,  // 데이터가 존재하지 않습니다.
			//rowNum :'<c:out value="${searchVO.pageUnit}"/>',  // 목록갯수 

			//ondblClickRow: function(rowid, iRow, iCol, e) { //row 더블 클릭시 상세 보기. 
			//	zipObj.edit(rowid); 
			//}, 		

			onSelectRow: function(rowid, iRow, iCol, e){ 		//row 클릭시 상세 보기
				zipObj.read(rowid); 
			},
			
			loadComplete  : function(){
				// 넘버 추가
				var ids = $("#list").jqGrid('getDataIDs');
				for(var i=0;i < ids.length;i++){ 
					var num = parseInt('<c:out value="${paginationInfo.totalRecordCount}"/>') - (parseInt('<c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize}"/>')+i);
					jQuery("#list").jqGrid('setRowData',ids[i],{menuNm:num});
				}	
				
				$.jqGrid = {};
				$.jqGrid.data = {"0":"6%","1":"24%", "2":"70%"}; 
				$.jqGrid.min = jqGridUtil.minWidth();
				jqGridUtil.resizeJqGrid("board_table");
				//jqGridUtil.tableRowStyle("list");
				jqGridUtil.tableRowClickStyle("list");  // row link 처리
				jqGridUtil.setEmptyData(obj, "board_table");
			}
	};
	//공통으로 적용할 옵션 가져오기
	obj = jqGridUtil.jqGridCommonOption(obj);
	$("#list").jqGrid(obj.option);
}

function fn_zipCode(cellvalue, options, rowObject){
	return   cellvalue.substring( 0,3) +"-"+ cellvalue.substring( 3,6);
}

function fn_address(cellvalue, options, rowObject){
	var val_address = rowObject.ctprvnNm +" "+		rowObject.signguNm +" ";
	
	if('<c:out value="${searchVO.searchList}"/>'=='1'){
		val_address = val_address +	rowObject.emdNm;
		if(rowObject.liBuldNm!=null)
			val_address = val_address +" "+ rowObject.liBuldNm ;	
		if(rowObject.lnbrDongHo!=null)
			val_address = val_address +" "+ rowObject.lnbrDongHo ;
		
	}else{
		val_address = val_address +	rowObject.rdmn +" "+ rowObject.bdnbrMnnm;
		if(rowObject.bdnbrSlno!=null)
			val_address =val_address + "-"+ rowObject.bdnbrSlno ;
		if(rowObject.buldNm!=null)
			val_address = val_address +" "+ rowObject.buldNm ;
		if(rowObject.detailBuldNm!=null)
			val_address = val_address +" "+ rowObject.detailBuldNm ;
	}
	return val_address;
}
/* --------------------------------------------------------  *  
 * jqGrid END 
 * --------------------------------------------------------- */
</script>
</head>

<body>
	<form name="listForm" id="listForm"  action="<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>" method="post">
	<input name="pageIndex" id="pageIndex"  type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> 							
<div class="searchArea clearfx" id="" >
        <span>
             <select name="searchList" id="searchList" class="select" title="searchList" onChange="zipObj.selSearchList()"> 
                   <option value='1' <c:if test="${searchVO.searchList == '1'}">selected="selected"</c:if>><spring:message code='system.zipCode.address' /></option>
                   <option value='2' <c:if test="${searchVO.searchList == '2'}">selected="selected"</c:if>><spring:message code='system.zipCode.road.address' /></option>
                </select>
         </span>
         <span>
                <select name="searchCondition" id="searchCondition" class="select" title="searchCondition" style="display:none">
                   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><spring:message code='system.zipCode' /></option>
                   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><spring:message code='system.zipCode.sidoNm' /></option>
                   <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>><spring:message code='system.zipCode.sigunguNm' /></option>
                   <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>><spring:message code='system.zipCode.umdNm' /></option>
                   <option value='5' <c:if test="${searchVO.searchCondition == '5'}">selected="selected"</c:if>><spring:message code='system.zipCode.riBldgNm' /></option>
                </select>
                <select name="searchCondition2" id="searchCondition2" class="select" title="searchCondition" style="display:none">
                   <option value='1' <c:if test="${searchVO.searchCondition2 == '1'}">selected="selected"</c:if>><spring:message code='system.zipCode' /></option>
                   <option value='2' <c:if test="${searchVO.searchCondition2 == '2'}">selected="selected"</c:if>><spring:message code='system.zipCode.sidoNm' /></option>
                   <option value='3' <c:if test="${searchVO.searchCondition2 == '3'}">selected="selected"</c:if>><spring:message code='system.zipCode.sigunguNm' /></option>
                   <option value='4' <c:if test="${searchVO.searchCondition2 == '4'}">selected="selected"</c:if>><spring:message code='system.zipCode.roadNm' /></option>
                   <option value='5' <c:if test="${searchVO.searchCondition2 == '5'}">selected="selected"</c:if>><spring:message code='system.zipCode.bldgNm' /></option>
                   <option value='6' <c:if test="${searchVO.searchCondition2 == '6'}">selected="selected"</c:if>><spring:message code='system.zipCode.bldgDeailNm' /></option>
                </select>                   
          </span>
          <span>
                <input type="text" name="searchKeyword" id="searchKeyword" style="widht:300px;" value=""  maxlength="25" title="" onkeyup="javascript:if(event.keyCode==13){zipObj.search(); return false;}">
          </span>
        <a href="javascript:zipObj.search();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
</div>
	</form>
				
	<!--  수정/등록 화면   START -->	
	<form id="editForm" name="editForm" method="post" enctype="multipart/form-data" >	
	<input id="cmd" name="cmd" type="hidden"/> 	
	<input id="sn"  type="hidden"/>	
	<input name="zipType" id="zipType"  type="hidden"/>				
	
	<div id="divEditForm" style="display:none; width:100% ">					
		
		<fieldset class="mT20">
		        <legend>상세 정보</legend>
		         <ul class="inputForm">
                        <li id='zipClRow'><strong style="width:95px;"><spring:message code='system.zipCode.type' /><span class="f_red">*</span></strong>
                             <input type="radio" name="zipCl" id="zipCl1" value="0" /> <spring:message code='system.zipCode.general.address' />
                             <input type="radio" name="zipCl" id="zipCl2" value="1"/> <spring:message code='system.zipCode.road.address' />
                        </li>
                        <li id='excel_inp'><strong style="width:95px;"><spring:message code='system.zipCode.file' /><span class="f_red">*</span></strong>
                             <input name="fileNm" type="file" id="fileNm"  style="width:180px;"/>
                        </li>
                        <li id='zipClcom_inp0'><strong style="width:95px;"><spring:message code='system.zipCode' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_zip" id="f_zip" maxlength="6" style="width:60px;"/> <span class="f11 f_gray ls_1"><spring:message code='system.zipCode.msg' /></span>
                        </li>
                        <li id='zipClcom_inp1'><strong style="width:95px;"><spring:message code='system.zipCode.sidoNm' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_sido" id="f_sido"  maxlength="20" style="width:200px;"/>
                             <strong style="width:95px;"><spring:message code='system.zipCode.sigunguNm' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_sigungu" id="f_sigungu" maxlength="20" style="width:200px;"/>
                        </li>
                        <li id='zipCl1_inp0'><strong style="width:95px;"><spring:message code='system.zipCode.umdNm' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_emd" id="f_emd" maxlength="30" style="width:200px;"/>
                        </li>
                        <li id='zipCl1_inp1'><strong style="width:95px;"><spring:message code='system.zipCode.riBldgNm' /></strong>
                             <input type="text"  name="f_liBldNm" id="f_liBldNm" maxlength="60" style="width:200px;"/>
                             <strong style="width:95px;"><spring:message code='system.zipCode.lnbrDongHo' /></strong>
                             <input type="text"  name="f_bjdh" id="f_bjdh" maxlength="20" style="width:200px;"/>
                        </li>
                        <li id='zipCl2_inp0'><strong style="width:95px;"><spring:message code='system.zipCode.roadCode' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_rdnmCd" id="f_rdnmCd" maxlength="12" style="width:200px;"/>
                             <strong style="width:95px;"><spring:message code='system.zipCode.roadNm' /><span class="f_red">*</span></strong>
                             <input type="text"  name="f_rdnm" id="f_rdnm" maxlength="60" style="width:220px;"/>
                        </li>
                        <li id='zipCl2_inp1'><strong style="width:95px;"><spring:message code='system.zipCode.bdnbrMnnm' /></strong>
                             <input type="text"  name="f_bldMno" id="f_bldMno" maxlength="5" style="width:60px;"/>
                             <strong style="width:95px;"><spring:message code='system.zipCode.bdnbrSlno' /></strong>
                             <input type="text"  name="f_bldSno" id="f_bldSno" maxlength="5" style="width:60px;"/>
                        </li>
                        <li id='zipCl2_inp2'><strong style="width:95px;"><spring:message code='system.zipCode.bldgNm' /></strong>
                             <input type="text"  name="f_bldnm" id="f_bldnm" maxlength="60" style="width:220px;"/>
                             <strong style="width:95px;"><spring:message code='system.zipCode.bldgDeailNm' /></strong>
                             <input type="text"  name="f_dtbldnm" id="f_dtbldnm" maxlength="60" style="width:220px;"/>
                        </li>
		         </ul>
		         <p class="tC mT15"><a href="#"  onclick="zipObj.actionSubmit()"  class="darkBtn"><span>저장</span></a> <a href="#" onclick="zipObj.cancel()"  class="grayBtn"><span>취소</span></a></p>
		 </fieldset>  											
	</div>						
	</form>
	<!--  수정/등록 화면   END -->	

	<div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["<spring:message code='button.new' />"/*신규 */]; // button.excel.regist   엑셀 등록 
		var fn = ["zipObj.create(1)"];  // zipObj.create(2); 
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);
	</script>							

	<div style="height:7px;"></div>			
									
	<div class="board_table" id="board_table">
		<table id="list" ></table>			
	</div>
	<div style="height: 12px;"></div>
	<div align="center" class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image"	jsFunction="zipObj.pagingClick" />
	</div>				

</body>
</html>
