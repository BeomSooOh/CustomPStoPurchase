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
				<input id="addBtn" type="button" class="puddSetup" value="??????" />
				<input id="saveBtn" type="button" class="puddSetup" value="??????" />
				<input id="deleteBtn" type="button" class="puddSetup" value="??????" />
			</div>
		</div>
		<div id="exTab">
			<ul>
				<li>??????</li>
				<li>??????</li>
			</ul>
			<div>							
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="40%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<p class="tit_p fl">??????????????????</p>
								<div class="top_box">
									<dl>
										<dt>?????????</dt>
										<dd><input type="text" autocomplete="off" style="width:200px;" class="searchArea puddSetup" value="" /></dd>
										<dd><input type="button" class="search puddSetup submit" value="??????" /></dd>
									</dl>
								</div>
								<div id="grid1" class="grid mt14"></div>											
							</td>
							<td class="twinbox_td">
								<div class="tablecon">
									<p class="tit_p fl">????????????</p>
									<div class="com_ta">
										<table>
											<colgroup>
												<col width="100"/>
												<col width="100"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
												<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
												<td><input id="dutyGroupNameKr0" type="text" pudd-style="width:100%;" class="dutyGroupNameKr puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>??????</th>
												<td><input id="dutyGroupNameEn0" type="text" pudd-style="width:100%;" class="dutyGroupNameEn puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>?????????</th>
												<td><input id="dutyGroupNameJp0" type="text" pudd-style="width:100%;" class="dutyGroupNameJp puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>?????????</th>
												<td><input id="dutyGroupNameCn0" type="text" pudd-style="width:100%;" class="dutyGroupNameCn puddSetup txtinitElem" value="" /></td>
											</tr>													
											<tr>
												<th colspan="2">????????????</th>
												<td><input id="orderNum0" type="text" pudd-style="width:100%;" class="orderNum puddSetup txtinitElem" value="" onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
											</tr>
											<tr>
												<th colspan="2">??????</th>
												<td><input id="note0" type="text" pudd-style="width:100%;" class="note puddSetup txtinitElem" value="" /></td>
											</tr>
										</table>
									</div>
								</div>
								<p class="tit_p mt15">???????????? <span class="text_red">(??????)</span></p>
								<p class="text_blue f11 mt-5 mb10"><span class="f12">???</span> ??????????????? &gt; ???????????????????????? ????????? ????????? ???????????????.</p>
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
								<p class="tit_p fl">??????????????????</p>
								<div class="top_box">
									<dl>
										<dt>?????????</dt>
										<dd><input type="text" autocomplete="off" style="width:200px;" class="searchArea puddSetup" value="" /></dd>
										<dd><input type="button" class="search puddSetup submit" value="??????" /></dd>
									</dl>
								</div>
								<div id="grid1" class="grid mt14"></div>											
							</td>


							<td class="twinbox_td">
								<div class="tablecon">
									<p class="tit_p fl">????????????</p>
									<div class="com_ta">
										<table>
											<colgroup>
												<col width="100"/>
												<col width="100"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
												<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
												<td><input id="dutyGroupNameKr1" type="text" pudd-style="width:100%;" class="dutyGroupNameKr puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>??????</th>
												<td><input id="dutyGroupNameEn1" type="text" pudd-style="width:100%;" class="dutyGroupNameEn puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>?????????</th>
												<td><input id="dutyGroupNameJp1" type="text" pudd-style="width:100%;" class="dutyGroupNameJp puddSetup txtinitElem" value="" /></td>
											</tr>
											<tr>
												<th>?????????</th>
												<td><input id="dutyGroupNameCn1" type="text" pudd-style="width:100%;" class="dutyGroupNameCn puddSetup txtinitElem" value="" /></td>
											</tr>													
											<tr>
												<th colspan="2">????????????</th>
												<td><input id="orderNum1" type="text" pudd-style="width:100%;" class="orderNum puddSetup txtinitElem" value=""  onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
											</tr>
											<tr>
												<th colspan="2">??????</th>
												<td><input id="note1" type="text" pudd-style="width:100%;" class="note puddSetup txtinitElem" value="" /></td>
											</tr>
										</table>
									</div>
								</div>
								<p class="tit_p mt15">???????????? <span class="text_red">(??????)</span></p>
								<p class="text_blue f11 mt-5 mb10"><span class="f12">???</span> ??????????????? &gt; ???????????????????????? ????????? ????????? ???????????????.</p>
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
		/* ?????? ????????? ????????? */
		fnInitClickEvent();
		/* ?????? ?????? ?????? */
		fnGridSetPositionGroupTable();
		/* ?????? ?????? ?????? */
		// fnGridSetPositionItemTable();
	});
	
	function fnInitClickEvent(){
		
		//?????? 
		var puddObj = Pudd( "#addBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnSetInputFields();
			fnGridSetPositionItemTable();
			$('tr.on').removeClass('on');
		});
		//??????
		var puddObj = Pudd( "#saveBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			console.log(fnGetCheckedDutyCode());
			fnSaveDutyGroup();	 	
		});
		//??????
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteDutyGroup();
		});
		
		/* ?????? ?????? ?????? ?????????*/
		Pudd( "#exTab" ).puddTab({	 
		 	newTab : false
		 	, tabClickCallback : function( idx, tabMenu, tabArea ) {
				nowTab = idx;
		 		fnGridSetPositionGroupTable();
		 		fnSetInputFields();
		 	}
		});
		
		//???????????????
		$('.search').click(function(){
			fnGridSetPositionGroupTable();
		});
		
		$(".searchArea").keydown(function (key) {		 
	        if(key.keyCode == 13){//?????? 13?????? ?????? (????????? 13)
	        	fnGridSetPositionGroupTable();
	        }
	    });
		
		//????????? ??? ???????????????
		Pudd( ".grid").on( "gridRowClick", function( e ) {
			fnGridSetPositionItemTable();
			fnSetInputFields(e.detail.trObj.rowData);
		});
	}
	
	/*	[?????? ??????] ?????? ?????? ????????? ?????????
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
	
	/*	[??????] ???????????? ?????? ??????
	-------------------------------------------*/
	function fnDeleteDutyGroup(){
		if( ! (fnGetSelectedRowData().dutyGroupSeq ) ){
			alert("????????? ???????????? ??????????????????.");
			return;
		}
		
		if(confirm("????????????????????????")){
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
						alert('????????????????????? ???????????? ?????? ????????? ????????? ?????????????????? ?????? ??????????????? ????????????.');
						return;
					} else if (result.result.resultCode == 'SUCCESS'){
						alert("???????????? ?????? ???????????????");
						fnSetInputFields();
						fnGridSetPositionGroupTable();
						fnGridSetPositionItemTable();
					} else {
						alert("????????? ?????????????????????.");						
					}				
				}
			});
		}
	}
	
	/*	[??????????????????] ????????? ????????? ????????????
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
	}
	
	/*	[??????] ?????????????????? ?????? (?????? / ??????)
	-------------------------------------------*/
	function fnSaveDutyGroup(){

		if($.trim($("#dutyGroupNameKr" + nowTab ).val()) == ""){
			alert("?????????????????? ??????????????????.");
			$("#dutyGroupNameKr" + nowTab ).focus();
			return;
		}
		
		if(!fnGetCheckedDutyCode().codeStr){
			alert("?????? ????????? ???????????????.");
			return;
		}
		
		if(confirm("?????????????????????????")){
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
						alert("?????? ???????????????");
						fnSetInputFields();
						fnGridSetPositionGroupTable();
						fnGridSetPositionItemTable();
					}else{
						alert("????????? ??????????????????");
					}
				}
			});
		}
	}
	
	function fnGridSetPositionGroupTable(){
		var puddTab = Pudd( "#exTab" ).getPuddObject();
		/* ?????? ?????? ?????? ?????? */
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
			,	title:"?????????"
			}
		]
		,noDataMessage : {
			message : "???????????? ???????????? ????????????."
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
	        , 'oNoData': {                 // ???????????? ???????????? ?????? ?????? 
	            'tText': '???????????? ???????????? ????????????.' // ?????? ????????? ??????
	        }, "data": aaData
	        , 'oPage': {                   // ????????? ????????? ??????
	            'nItemSize': pageSize||15               // ???????????? ????????? ??????(?????? ???. 10)
	            , 'anPageSelector' : [15, 35, 50, 100] // ????????? ?????? ?????? ????????? ??????
	        	, 'bPageOff': true
	        }, "aoHeaderInfo": [{
		        	no: '0'                        // ?????? ??????????????????.
		            , renderValue : '<input type="checkbox" id="chkAll" name="chkAll" onclick="fnAllChk();">'
			        , colgroup : '5'
		        }, {
		            no: '1'
		            , renderValue: '??????'
		            , colgroup: '15'
		        }, {
		            no: '2'
		            , renderValue: '????????????'
		            , colgroup: '15'
		        }, {
		            no: '3'
		            , renderValue: '??????????????????'
		            , colgroup: '15'
	        }]
	        , "aoDataRender": [{          // [*] ?????? ????????? ?????? ????????? ????????? ???????????????.
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
	
	/*	[????????????] ????????? ?????? ?????? ???????????? ????????????
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
	
	/*	[????????????] ???????????? ?????? ??????
	 *---------------------------------------*/
	function fnAllChk(){
		$('.chkSel:enabled').prop('checked', $('#chkAll').prop('checked'));
	}
	
	/*	[????????????] ????????? ??????
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
					alert('????????? ????????? ?????????????????????.');
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