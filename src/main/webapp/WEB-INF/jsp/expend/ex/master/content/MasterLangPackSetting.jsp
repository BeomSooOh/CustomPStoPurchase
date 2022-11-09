<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>

<head>
	<script type="text/javascript">
var comp_seq='${ViewBag}';

   	$(document).ready(function(){
   		 //기본버튼
		$("button").kendoButton();  
		//검색 버튼 설정
     	$("#searchButton").click(
    			function () {
     			fnGetLangPack($("#name_sel").val())
    			});
		
    	$("#btnSave").click(
    			function () {
         			fnLangPackSave();
       			});
    	$("#name_sel").keydown(
    			function(){
    			    if(event.keyCode == 13){	
    			    	fnGetLangPack($("#name_sel").val())	
    			    }	
    			});
		
		fnGetACompanyInfo();
		fnGetLangPack('');		
		
		
	});//document ready end
	
	
	
	
	function fnGetLangPack(keyword) {
		var param = {};
		param.searchCompSeq = $('#company_sel').val();
		param.keyWord = keyword;
 
	 	url = '<c:url value="/ex/config/GetLangPack.do" />';
	    $.ajax({
			type : 'post'
			, url : url 
			, datatype : 'json'
	        , data: param
	        , async: true
	        , success: function (result) {
	            if (result.aaData.length > 0) {
	            	$('#example').html('');
	            	console.log("리턴값:"+result.aaData);
	            	fnSetDataGrid(result.aaData);
	            }
	        }
	        , error: function (result) {
	            alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
	        }
	    }); 
	}
	 
	// 회사코드 호출
	function fnGetACompanyInfo() {
	    var tblParam = {};
	    tblParam.sCodeGb = "Company";
	    tblParam.sSearch = "";
	    
	 	url = '<c:url value="/ex/config/GetCommonCode.do" />';
	    $.ajax({
			type : 'post'
			, url : url 
			, datatype : 'json'
	        , data: tblParam
	        , async: true
	        , success: function (result) {
	            if (result.aaData.length > 0) {
	            	fnSetComboBox(result.aaData);
	            }
	        }
	        , error: function (result) {
	            alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
	        }
	    }); 
	}
	
	function fnLangPackSave()
	{
		if($("#tdCodeCd").text() != '' ||$("#tdCodeCd").text() != 'undefind' )
		{
		   var tblParam = {};
		   
		   	tblParam.comp_seq = $('#company_sel').val();
		    tblParam.code = $("#tdCodeCd").text();
		    tblParam.lang_kr = $("#txtDisplayKr").val();
		    tblParam.lang_en = $("#txtDisplayEn").val();
		    tblParam.lang_cn = $("#txtDisplayCn").val();
		    tblParam.lang_jp = $("#txtDisplayJp").val();
		    console.log("파라메터:"+JSON.stringify(tblParam));
		 	url = '<c:url value="/ex/config/SetLangPack.do" />';
		    $.ajax({
				type : 'post'
				, url : url 
				, datatype : 'json'
		        , data: tblParam
		        , async: true
		        , success: function (result) {
	            	if(result.aaData=='true')
	            	{
	            		alert("<%=BizboxAMessage.getMessage("TX000002598","저장하였습니다")%>");
	            		fnGetLangPack($("#name_sel").val());
	            	}
	            	else
            		{
	            		alert("<%=BizboxAMessage.getMessage("TX000002596","저장에 실패하였습니다")%>");	
            		}
		        }
		        , error: function (result) {
		            alert("<%=BizboxAMessage.getMessage("TX000009591","데이터 저장 중 오류가 발생하였습니다")%>");
		        }
		    }); 
		}
		else
		{
			alert("<%=BizboxAMessage.getMessage("TX000009590","저장할 명칭을 선택하세요")%>");
		}
	}
	
	//콤보박스 데이터 바인드
	function fnSetComboBox(aaData) {
		//console.log(aaData);
		setComboBox($('#company_sel'), aaData,
				function(event) {
					fnSetComboBox_Change(event);
				},'commonNm' ,'commonCd');/* 회사설정 */
		
	}
	//명칭 데이터 바인드
	function fnSetDataGrid(aaData)
	{
		console.log(aaData);
		//테이블
		$('#example').DataTable({
			"bJQueryUI" : true, //jQuery UI 테마를 적용받음
			"sDom" : '<r>t', //컬럼 드레그 재정렬
			"bProcessing" : true, //처리 중 표시
			"bServerSide" : false,
			"bDestroy" : true,
			"sScrollY" : "370px",
			"bAutoWidth" : false,
			"paging" : false,
			"ordering" : false,
			"info" : false,
			"fixedHeader" : true,
			"select" : true,
			"data" : aaData,
			"language" : {
				"lengthMenu" : "보기 _MENU_",
				"zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
				"info" : "_PAGE_ / _PAGES_",
				"infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
				"infoFiltered" : "(전체 _MAX_ 중.)"
			},
				"fnRowCallback" : function(nRow, aData,iDisplayIndex,iDisplayIndexFull) {
					$(nRow).css("cursor", "pointer");
					$(nRow).on( 'click', (function() { fnConfigAuthEventSelect_Row(aData); }));
				},
				columnDefs : [
					{ "targets" : 1, "data" : null, "render" : function(aData) {
							if (aData != null && aData != "") {
								return '<div id="divLangNm_'+aData.langpack_code+'"'+' onChange="fnLangpackView('+aData.langpack_code+ ')">'+aData.langpack_name+'</div>';
							} 
							else {
								return "";
							}
						}
					},          
				              
					{ "targets" : 2, "data" : null, "render" : function(aData) {
							if (aData != null && aData != "") {
								return '<div id="divLangKr_'+aData.langpack_code+'" onChange="fnLangpackView('+aData.langpack_code+ ')">'+aData.langpack_name_kr+'</div>';
								
							} else {
								return "";
							}
						}
					},
					
					{ "targets" : 3, "data" : null, "render" : function(aData) {
						if (aData != null && aData != "") {
							return '<div id="divLangKr_'+aData.langpack_code+'" onChange="fnLangpackView('+aData.langpack_code+ ')">'+aData.langpack_name_en+'</div>';
							} 
							else {
								return "";
							}
						}
					},
					{ "targets" : 4, "data" : null, "render" : function(aData) {
						if (aData != null && aData != "") {
							return '<div id="divLangKr_'+aData.langpack_code+'" onChange="fnLangpackView('+aData.langpack_code+ ')">'+aData.langpack_name_jp+'</div>';
							} 
							else {
								return "";
							}
						}
					},
					{ "targets" : 5, "data" : null, "render" : function(aData) {
						if (aData != null && aData != "") {
							return '<div id="divLangKr_'+aData.langpack_code+'" onChange="fnLangpackView('+aData.langpack_code+ ')">'+aData.langpack_name_cn+'</div>';
							} 
							else {
								return "";
							}
						}
					},
				],
				aoColumns : //컬럼과 프로퍼티 연결
				[
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000045","코드")%>",
						mDataProp : "langpack_code",
						bVisible : true,
						bSortable : true,
						sWidth : ""
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "",
						className: "td_le"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000005584","한글")%>",
						
						bVisible : true,
						bSortable : true,
						className: "td_le"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000005585","영문")%>",
						
						bVisible : true,
						bSortable : true,
						className: "td_le"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000009589","일문")%>",
						
						bVisible : true,
						bSortable : true,
						className: "td_le"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000009588","중문")%>",
						//mDataProp : "langpack_name_cn",
						bVisible : true,
						bSortable : true,
						className: "td_le"
					}    
				]

				
			});
	}
	
	function fnConfigAuthEventSelect_Row(aData)
	{
		console.log(aData);

		$('#tdCodeCd').html(aData.langpack_code);
		$('#tdCodeNm').html(aData.langpack_name);
		$('#txtDisplayKr').val(aData.langpack_name_kr);
		$('#txtDisplayEn').val(aData.langpack_name_en);
		$('#txtDisplayCn').val(aData.langpack_name_cn);
		$('#txtDisplayJp').val(aData.langpack_name_jp);
	}
	
	/* ComboBox 변경 이벤트 */
	function fnSetComboBox_Change() {
		$('#searchButton').click();
		return;
	}
			
			
  </script>
</head>

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
<div class="top_box">
	<dl>
		<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt>
		<dd>
			<div class="dod_search">
				<input type="text" id="company_sel" class="kendoComboBox" style="width:150px;"/>
			</div>
		</dd>
		<dt><%=BizboxAMessage.getMessage("TX000000152","명칭")%></dt>
		<dd>
			<div class="dod_search">
				<input type="text" id="name_sel" class="kendoComboBox" style="width:150px;"/>
			</div>
		</dd>
		<dd><input type="button" id="searchButton" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
	</dl>
</div>

<div id="" class="controll_btn">
	<button id="btnSave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
</div>

<div class="twinbox">
<table>
	<colgroup>
		<col width="65%"/>
		<col width="35%"/>
	</colgroup>
	<tr>
		<td class="twinbox_td" style="">

			<div class="com_ta2 bg_lightgray hover_no mt20">
				<table id="example">
					<colgroup>
						<col width="90"/>
						<col width=""/>
						<col width="17%"/>
						<col width="17%"/>
						<col width="17%"/>
						<col width="17%"/>
					</colgroup>
					
				</table>
			</div>
		</td>
		<td class="twinbox_td" style="">
			<div class="com_ta mt20">
				<table>
					<colgroup>
						<col width="90"/>
						<col width="90"/>
						<col width=""/>
					</colgroup>
					<tr>
						<th colspan="2"><%=BizboxAMessage.getMessage("TX000000045","코드")%></th>
						<td id="tdCodeCd"></td>
					</tr>
					<tr>
						<th colspan="2"><%=BizboxAMessage.getMessage("TX000000152","명칭")%></th>
						<td id="tdCodeNm"></td>
					</tr>
					<tr>
						<th rowspan="4"><%=BizboxAMessage.getMessage("TX000015953","대체 문구")%></th>
						<th><%=BizboxAMessage.getMessage("TX000005584","한글")%></th>
						<td>
						<input id="txtDisplayKr" type="text" style="width:66%" />
						</td>
					</tr>
					<tr>
						<th><%=BizboxAMessage.getMessage("TX000005585","영문")%></th>
						<td>
						<input id="txtDisplayEn" type="text" style="width:66%" />
						</td>
					</tr>
					<tr>
						<th><%=BizboxAMessage.getMessage("TX000009589","일문")%></th>
						<td>
						<input id="txtDisplayJp" type="text" style="width:66%" />
						</td>
					</tr>
					<tr>
						<th><%=BizboxAMessage.getMessage("TX000009588","중문")%></th>
						<td>
						<input id="txtDisplayCn" type="text" style="width:66%" />
							</td>
						</tr>
					</table>
				</div>
				
			</td>
		</tr>
	</table>
</div><!-- twinbox -->
</div>
					

