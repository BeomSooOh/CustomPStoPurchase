<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Bizbox A</title>

	

	<!--css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pudd.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pudding/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/re_pudd.css">

	<!--js-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudd/pudd-1.1.187.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/common.js"></script>
</head>


<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap mb0">
		<div class="posi_re">
			<div id="" class="posi_ab" style="right:0px; z-index:1;">
				<input id="addBtn" type="button" class="puddSetup" value="추가" />
				<input id="saveBtn" type="button" class="puddSetup" value="저장" />
				<input id="deleteBtn" type="button" class="puddSetup" value="삭제" />
			</div>
		</div>
		<div id="exTab">
			<ul>
				<li>국내</li>
				<li>해외</li>
			</ul>
			<div>							
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="40%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<p class="tit_p fl">직책그룹목록</p>
								<div class="top_box">
									<dl>
										<dt>그룹명</dt>
										<dd><input type="text" autocomplete="off" style="width:200px;" class="searchArea puddSetup" value="" /></dd>
										<dd><input type="button" class="search puddSetup submit" value="검색" /></dd>
									</dl>
								</div>
								<div id="grid1" class="grid mt14"></div>											
							</td>
							<td class="twinbox_td">
								<div class="tablecon">
									<p class="tit_p fl">상세내역</p>
									<div class="com_ta">
										<table>
											<colgroup>
												<col width="100"/>
												<col width="100"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> 그룹명</th>
												<th><img src="../../../Images/ico/ico_check01.png" alt=""> 한국어</th>
												<td><input id="dutyGroupNameKr0" type="text" pudd-style="width:100%;" class="dutyGroupNameKr puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>영어</th>
												<td><input id="dutyGroupNameEn0" type="text" pudd-style="width:100%;" class="dutyGroupNameEn puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>일본어</th>
												<td><input id="dutyGroupNameJp0" type="text" pudd-style="width:100%;" class="dutyGroupNameJp puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>중국어</th>
												<td><input id="dutyGroupNameCn0" type="text" pudd-style="width:100%;" class="dutyGroupNameCn puddSetup txtinitElem" value="" /></td>
											</tr>													
											<tr>
												<th colspan="2">정렬순서</th>
												<td><input id="orderNum0" type="text" pudd-style="width:100%;" class="orderNum puddSetup txtinitElem" value="" onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
											</tr>
											<tr>
												<th colspan="2">비고</th>
												<td><input id="note0" type="text" pudd-style="width:100%;" class="note puddSetup txtinitElem" value="" /></td>
											</tr>
										</table>
									</div>
								</div>
								<p class="tit_p mt15">직책선택 <span class="text_red">(필수)</span></p>
								<p class="text_blue f11 mt-5 mb10"><span class="f12">※</span> 시스템설정 &gt; 직급직책관리에서 직급명 관리가 가능합니다.</p>
								<div class="divGridArea0" id="divGridArea0"></div>					
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
				<div>							
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="40%"/>
							<col />
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<p class="tit_p fl">직책그룹목록</p>
								<div class="top_box">
									<dl>
										<dt>그룹명</dt>
										<dd><input type="text" autocomplete="off" style="width:200px;" class="searchArea puddSetup" value="" /></dd>
										<dd><input type="button" class="search puddSetup submit" value="검색" /></dd>
									</dl>
								</div>
								<div id="grid1" class="grid mt14"></div>											
							</td>


							<td class="twinbox_td">
								<div class="tablecon">
									<p class="tit_p fl">상세내역</p>
									<div class="com_ta">
										<table>
											<colgroup>
												<col width="100"/>
												<col width="100"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> 그룹명</th>
												<th><img src="../../../Images/ico/ico_check01.png" alt=""> 한국어</th>
												<td><input id="dutyGroupNameKr1" type="text" pudd-style="width:100%;" class="dutyGroupNameKr puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>영어</th>
												<td><input id="dutyGroupNameEn1" type="text" pudd-style="width:100%;" class="dutyGroupNameEn puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>일본어</th>
												<td><input id="dutyGroupNameJp1" type="text" pudd-style="width:100%;" class="dutyGroupNameJp puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>중국어</th>
												<td><input id="dutyGroupNameCn1" type="text" pudd-style="width:100%;" class="dutyGroupNameCn puddSetup txtinitElem" value="" /></td>
											</tr>													
											<tr>
												<th colspan="2">정렬순서</th>
												<td><input id="orderNum1" type="text" pudd-style="width:100%;" class="orderNum puddSetup txtinitElem" value=""  onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
											</tr>
											<tr>
												<th colspan="2">비고</th>
												<td><input id="note1" type="text" pudd-style="width:100%;" class="note puddSetup txtinitElem" value="" /></td>
											</tr>
										</table>
									</div>
								</div>
								<p class="tit_p mt15">직책선택 <span class="text_red">(필수)</span></p>
								<p class="text_blue f11 mt-5 mb10"><span class="f12">※</span> 시스템설정 &gt; 직급직책관리에서 직급명 관리가 가능합니다.</p>
								<div class="divGridArea1" id="divGridArea1"></div>					
							</td>
						</tr>
					</table>
				</div>
			</div>
			</div>
		</div>
	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->
				
<script type="text/javascript">
	var nowTab=0;
	
	$(document).ready(function() {
		/* 클릭 이벤트 초기화 */
		fnInitClickEvent();
		/* 직책 그룹 조회 */
		fnGridSetPositionGroupTable();
		/* 직책 선택 조회 */
		// fnGridSetPositionItemTable();
	});
	
	function fnInitClickEvent(){
		
		//추가 
		var puddObj = Pudd( "#addBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnSetInputFields();
			fnGridSetPositionItemTable();
			$('tr.on').removeClass('on');
		});
		//저장
		var puddObj = Pudd( "#saveBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			console.log(fnGetCheckedDutyCode());
			fnSaveDutyGroup();	 	
		});
		//삭제
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteDutyGroup();
		});
		
		/* 직책 그룹 탭별 이벤트*/
		Pudd( "#exTab" ).puddTab({	 
		 	newTab : false
		 	, tabClickCallback : function( idx, tabMenu, tabArea ) {
				nowTab = idx;
		 		fnGridSetPositionGroupTable();
		 		fnSetInputFields();
		 	}
		});
		
		//검색이벤트
		$('.search').click(function(){
			fnGridSetPositionGroupTable();
		});
		
		$(".searchArea").keydown(function (key) {		 
	        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	        	fnGridSetPositionGroupTable();
	        }
	    });
		
		//그리드 행 클릭이벤트
		Pudd( ".grid").on( "gridRowClick", function( e ) {
			fnGridSetPositionItemTable();
			fnSetInputFields(e.detail.trObj.rowData);
		});
	}
	
	/*	[입력 영역] 입력 영역 데이터 초기화
	-------------------------------------------*/
	function fnSetInputFields(param){
		param = param || {};
		$('#dutyGroupNameKr' + nowTab).val( param.dutyGroupNameKr || '' );
		$('#dutyGroupNameEn' + nowTab).val( param.dutyGroupNameEn || '' );
		$('#dutyGroupNameJp' + nowTab).val( param.dutyGroupNameJp || '' );
		$('#dutyGroupNameCn' + nowTab).val( param.dutyGroupNameCn || '' );
		$('#orderNum' + nowTab).val( param.orderNum || '' );
		$('#note' + nowTab).val( param.note || '' );
	}
	
	/*	[삭제] 직책그룹 정보 삭제
	-------------------------------------------*/
	function fnDeleteDutyGroup(){
		if( ! (fnGetSelectedRowData().dutyGroupSeq ) ){
			alert("삭제할 데이터을 선택하십시요.");
			return;
		}
		
		if(confirm("삭제하시겠습니까")){
			$.ajax({
				type: 'POST',
				url:'<c:url value="/expend/trip/admin/option/AdminTripDelete.do"/>',
				data:{
						"pageType" : 'positionGroup'
						,"dutyGroupSeq": fnGetSelectedRowData().dutyGroupSeq
					},
				dataType:'json',
				success: function(result){
					if(result.result.resultCode == 'EXSIST_AMT'){
						alert('출장비단가설정 메뉴에서 해당 조건이 반영된 출장비단가를 먼저 삭제하시기 바랍니다.');
						return;
					} else if (result.result.resultCode == 'SUCCESS'){
						alert("데이터가 삭제 되었습니다");
						fnSetInputFields();
						fnGridSetPositionGroupTable();
						fnGridSetPositionItemTable();
					} else {
						alert("삭제에 실패하였습니다.");						
					}				
				}
			});
		}
	}
	
	/*	[직책그룹목록] 선택된 데이터 가져오기
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
	}
	
	/*	[저장] 직책그룹정보 저장 (추가 / 변경)
	-------------------------------------------*/
	function fnSaveDutyGroup(){

		if($.trim($("#dutyGroupNameKr" + nowTab ).val()) == ""){
			alert("직책그룹명을 입력해주세요.");
			$("#dutyGroupNameKr" + nowTab ).focus();
			return;
		}
		
		if(!fnGetCheckedDutyCode().codeStr){
			alert("대상 직책을 선택하세요.");
			return;
		}
		
		if(confirm("저장하시겠습니까?")){
			var saveUrl = "";
			
			if ( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageInsert.do"/>';
			}else{
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageUpdate.do"/>';
			}
			
			$.ajax({
				type: 'POST',
				url:saveUrl,
				data: {
					  domesticCode:nowTab
						, dutyGroupNameKr:$('#dutyGroupNameKr' + nowTab).val()
						, dutyGroupNameEn:$('#dutyGroupNameEn' + nowTab).val()
						, dutyGroupNameJp:$('#dutyGroupNameJp' + nowTab).val()
						, dutyGroupNameCn:$('#dutyGroupNameCn' + nowTab).val()
						, note:$('#note' + nowTab).val()
						, orderNum:$('#orderNum' + nowTab).val()
						, pageType:'positionGroup'
						, dutyGroupSeq:fnGetSelectedRowData().dutyGroupSeq
						, dutyCode:fnGetCheckedDutyCode().codeStr
						, newInsertDutyCode : fnGetCheckedDutyCode().newInsertCodeStr
				},
				dataType:'json',
				success: function(e){
					if(e.result){
						alert("저장 되었습니다");
						fnSetInputFields();
						fnGridSetPositionGroupTable();
						fnGridSetPositionItemTable();
					}else{
						alert("저장을 실패했습니다");
					}
				}
			});
		}
	}
	
	function fnGridSetPositionGroupTable(){
		var puddTab = Pudd( "#exTab" ).getPuddObject();
		/* 직책 그룹 목록 조회 */
		var positionGroupData = new Pudd.Data.DataSource({
			pageSize : 10
			, request : {
					url : "<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do'/>"
				,	type : 'post'
				,	dataType : "json"
				,	async : false
				,	parameterMapping : function( data ) {
						data.pageType = 'positionGroup';
						data.domesticCode = puddTab.getActiveTab();
						data.searchCode = $(".searchArea").val();
					}
			}, result : {
				data : function( response ) {
					return response.result.aaData;
				}, totalCount : function( response ) {
					return response.result.aaData.length;
				}, error : function( response ) {
					alert( "error - Pudd.Data.DataSource.read, status code - " + response.result.resultCode );
				}
			}
		});
	
		Pudd( ".grid" ).puddGrid({ 
			dataSource : positionGroupData 
		,	height : 470
		,	scrollable : true 
		,	pageable : {
				buttonCount : 10
			,	pageList : [ 10, 20, 30, 40, 50 ]
			} 
		,	resizable : true	
		,	columns : [
			{
				field : "NO"
				, title : "no"
				, width : 80
				, content : {
					template : function( rowData ) {
						var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.NO + '</input>';
						return html;  
					}
				}
			}, {
				field:"dutyGroupName"
			,	title:"그룹명"
			}
		]
		,noDataMessage : {
			message : "데이터가 존재하지 않습니다."
		}
		});
		
	}
	
	
	function fnSetMainGrid(aaData,nowTab){
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$("#divGridArea"+nowTab).html("");
		$('.gt_paging').remove();
		$("#divGridArea"+nowTab).GridTable({
			'tTablename': 'gridConsReport'+nowTab
	        , 'nTableType': 1 
	        , 'nHeight': 270
	        , 'module' : 'expReport'
	        , 'bNoHover' : true    
	        , 'oNoData': {                 // 데이터가 존재하지 않는 경우 
	            'tText': '데이터가 존재하지 않습니다.' // 출력 텍스트 설정
	        }, "data": aaData
	        , 'oPage': {                   // 사용자 페이징 정보
	            'nItemSize': pageSize||15               // 페이지별 아이템 갯수(기본 값. 10)
	            , 'anPageSelector' : [15, 35, 50, 100] // 아이템 갯수 선택 셀렉트 구성
	        	, 'bPageOff': true
	        }, "aoHeaderInfo": [{
		        	no: '0'                        // 컬럼 시퀀스입니다.
		            , renderValue : '<input type="checkbox" id="chkAll" name="chkAll" onclick="fnAllChk();">'
			        , colgroup : '5'
		        }, {
		            no: '1'
		            , renderValue: '명칭'
		            , colgroup: '15'
		        }, {
		            no: '2'
		            , renderValue: '사용회사'
		            , colgroup: '15'
		        }, {
		            no: '3'
		            , renderValue: '소속직책그룹'
		            , colgroup: '15'
	        }]
	        , "aoDataRender": [{          // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
		        	no: '0',      
		            render: function (idx, item) {                        	                     	
		            	return '<input type="checkbox" class="chkSel" id="" value="'+ escape(JSON.stringify(item)) +'"/>';
		            }
		        }, {
		            no: '1',
		            render: function (idx, item) {                        	                     	
		            	return item.dutyName;
		            }
		        }, {
		            no: '2',
		            render: function (idx, item) {   
		            	return item.compName;
		            } 
		        }, {
		            no: '3',
		            render: function (idx, item) {                        	                     	
		            	return (item.dutyGroupName || '');
		            }
	        	}
			], 'fnRowCallBack' : function(row, aData){
	        	if((!!aData.dutyGroupName) && (fnGetSelectedRowData().dutyGroupSeq != aData.dutyGroupSeq)){
	        		$(row).find('.chkSel').attr('disabled', true);
	        	} 
	        	if((!!aData.dutyGroupName)){
	        		$(row).find('.chkSel').attr('checked', true);
	        	}
	        	
	        }
		});	
		
	}
	
	/*	[직책선택] 선택된 직책 코드 파라미터 가져오기
	-------------------------------------------------*/
	function fnGetCheckedDutyCode(){
		var aaData = [];
		$('.chkSel:checked').each(function(){
			if(!$(this).attr('disabled'))
				aaData.push( JSON.parse(unescape($(this).attr('value'))));
		});
		
		var dutyGroupCode = "";
		var newInsertDutyGroupCode = "";
		
		aaData.forEach(function(item) {
			  dutyGroupCode += ",'" + item.dutyCode + "'";
			  if(!item.dutyGroupSeq){
				  newInsertDutyGroupCode += ",'" + item.dutyCode + "'"; 
			  }
		});
		
		dutyGroupCode = dutyGroupCode.substring(1);
		newInsertDutyGroupCode = newInsertDutyGroupCode.substring(1);
		  
		return {
			aaData : aaData
			, codeStr : dutyGroupCode
			, newInsertCodeStr : newInsertDutyGroupCode
		}
	}
	
	/*	[체크박스] 체크박스 전체 선택
	 *---------------------------------------*/
	function fnAllChk(){
		$('.chkSel:enabled').prop('checked', $('#chkAll').prop('checked'));
	}
	
	/*	[직책선택] 그리드 출력
	 *---------------------------------------*/
	function fnGridSetPositionItemTable(){
		
		$.ajax({
			type : 'post'
			, url : '<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do' />'
			, datatype : 'json'
			, async : false
			, data : {
				pageType : 'positionGroupItem'
				, searchCode : ''
				, domesticCode : nowTab
			}
			, success : function(result) {
				console.log('SERVER CALL >>  result > ');
				console.log(result);
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버와 통신에 실패하였습니다.');
				}else{
					$('#totalCnt').text(result.result.aData.size);
					fnSetMainGrid(result.result.aaData,nowTab);
					fnSetMainGrid(result.result.aaData,nowTab);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
		
	}
</script>