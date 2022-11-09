<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pop_wrap_dir">
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<!-- 검색어 -->
				<dt>${CL.ex_keyWord}</dt>
				<dd>
					<div id="comboSearchTypeArea"></div>
				</dd>
				<dd>
					<div class="posi_re">
						<input id="txtSearchStr" type="text" style="width: 200px; ime-mode:active" value=""/>
					</div>
				</dd>
				<dd class="mr15">
					<!-- 검색 -->
					<input type="button" id="btnSearch" value="${CL.ex_search}" />
				</dd>
			</dl>	
		</div>
		
		<div class="fl mt10 mb10">
			<span class="mr5">총 <span id="txtShowCount">0</span> 건</span>
		</div>
		<div class="fr mt10 mb10">
			<!-- 미사용 카드 포함 -->
			<input type="checkbox" class="puddSetup" pudd-label="${CL.ex_notUseCard}" id="checkNotUseCard" />
		</div>
		
		<div class="com_ta2 mt14">
			<table id=tblUserCardInfo></table>
		</div>
		
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<!-- 확인 -->
				<input type="button" id="btnConfirm" value="${CL.ex_check}" /> 
				<!-- 취소 -->
				<input type="button" id="btnClose" class="gray_btn" value="${CL.ex_cancel}" />
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//화면 초기화
		fnInitLayout();
		//이벤트 초기화
		fnInitEvent();
		//카드정보 조회
		fnUserCardInfoSearch();
	});
	
	//화면 초기화
	function fnInitLayout(){
		//검색어 타입
		var searchType = [
			{"CODE_NM" : "${CL.ex_all}", "CODE" : "ALL"}, //전체
			{"CODE_NM" : "${CL.ex_cardNm}", "CODE" : "NAME"}, //카드명
			{"CODE_NM" : "${CL.ex_cardNumber}", "CODE" : "NUMBER"}, //카드번호
 		];
 		var searchTypeDataSource = new Pudd.Data.DataSource({
			data : searchType
		});
 		Pudd("#comboSearchTypeArea").puddComboBox({
	    	attributes : { style : "width:90px;" }, // control 부모 객체 속성 설정
	    	controlAttributes : { id : "comboSearchType" }, // control 자체 객체 속성 설정
	    	dataSource : searchTypeDataSource,
	    	dataValueField : "CODE",
		    dataTextField : "CODE_NM",
	    	selectedIndex : 0,
	    	disabled : false,
	  		scrollListHide : false
 		});
 		
 		//검색어 텍스트
 		$("#txtSearchStr").val("${ViewBag.searchStr}");
	}
	
	//이벤트 초기화
	function fnInitEvent(){
		//검색, 미사용 카드 포함
		$("#btnSearch, #checkNotUseCard").click(function(){
			fnUserCardInfoSearch();
		});
		
		//검색어
		$("#txtSearchStr").keydown(function(e){
			if(e.keyCode == 13){
				fnUserCardInfoSearch();
			}
		});
		
		//확인
		$("#btnConfirm").click(function(){
			fnGetCheckedData();
		});
		
		//취소
		$("#btnClose").click(function(){
			window.close();
		});
		
		//팝업닫기
		$(document).keydown(function(e){
    		if(e.keyCode == 27) { //ESC키 입력 시 
    			window.close();
    		}
    	});
	}
	
	//카드정보 검색
	function fnUserCardInfoSearch(){
		var gridDataSource = new Pudd.Data.DataSource({
			pageSize : 10
		  , serverPaging: true
		  , request : {
			  url : '<c:url value="/expend/ex/user/card/ExExpendUserCardInfoSelect.do" />'
			, type : 'post'
			, dataType : "json"
			, parameterMapping : function( data ) {
				data.searchType = Pudd("#comboSearchType").getPuddObject().val(); //검색어 구분
				data.searchStr = $("#txtSearchStr").val(); //검색어
				data.notUseCardYN = (Pudd("#checkNotUseCard").getPuddObject().getChecked() == true)?"Y":"N"; //미사용 카드 포함 여부
			  }
			}
		  ,	result : {
			  data : function( response ) {
			  	return response.result.aData.list;
			  }
		    , totalCount : function( response ) {
		    	var totalCount = response.result.aData.totalCount;
		    	$("#txtShowCount").text(totalCount);
		    	return totalCount;
			}
			, error : function( response ) {
				console.log("! [EX] ERROR - " + JSON.stringify(response));
			  }
			}
		});
		
		fnSetCardInfoGrid(gridDataSource);
	}
	
	//카드정보 데이터 그리드 표현
	function fnSetCardInfoGrid(gridDataSource){
		Pudd("#tblUserCardInfo").puddGrid({
			dataSource : gridDataSource //그리드에 표시할 데이터
		  ,	scrollable : true
		  ,	height : 300
		  ,	sortable : true //그리드 상단 제목 클릭 시 정렬여부
		  ,	pageable : { //그리드 하단 페이징 여부
				buttonCount : 10
			,	pageList : [ 10, 20, 30, 40, 50 ]
			}
		  ,	resizable : true //그리드 상단 제목 리사이즈 여부
		  ,	ellipsis : false //그리드 내 데이터 말줄임 사용여부
		  , gridContent : {
				attributes : { style : "min-height:250px;" }
			}
		  ,	columns : [
				{
					field : "gridCheckBox", 
					width : 25 ,
					editControl : {
						type : "checkbox",
						basicUse : true
					}
				}
			  ,	{
					field : "cardName"
				  ,	title : "${CL.ex_cardNm}" //카드명
				  ,	width : 120
				  , content : {
				      attributes : { style : "text-align:left;padding-left:5px;" }
				  }
				}
			  ,	{
					field : "cardNum"
				  ,	title : "${CL.ex_cardNumber}" //카드번호
				  ,	width : 100
				}
			]
		  ,	progressBar : {
				progressType : "loading"
			  ,	attributes : { style:"width:70px; height:70px;" }
			  ,	strokeColor : "#84c9ff"	// progress 색상
			  ,	strokeWidth : "3px"	// progress 두께
			  ,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			  ,	percentTextColor : "#84c9ff"
			  ,	percentTextSize : "12px"
		 
			  	// 배경 layer 설정 - progressType loading 인 경우만
			  ,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}
		  ,	noDataMessage : {
				message : "${CL.ex_dataDoNotExists}" //데이터가 없습니다.
			}
		  ,	loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
				var rowLength = contentTable.rows.length;
				
				//결과값 갯수가 1인 경우
				if(rowLength == 1){
					var trObj = Pudd.getInstance(contentTable.rows[0]);
					
					//현재 rowLength를 구하면 데이터가 없어도 1이 나오기 때문에 아래 조건문 추가
					if(trObj.rowData == "undefined" || trObj.rowData == null || trObj.rowData == "null" || trObj.rowData == ""){
						return;
					}
						
					var arrayParam = [];
					arrayParam.push(trObj.rowData);
					
					//선택된 카드정보 데이터 반영
					fnApplyCheckedData(arrayParam);
				}
				
				//선택된 카드정보
				var checkedCardNum = ${ViewBag.checkedCardInfo};
				
				//이미 선택된 카드정보를 체크표시해준다.
				if(checkedCardNum != null && checkedCardNum != ""){
					for(var i=0; i<rowLength; i++){
						var checkObj = Pudd.getInstance(contentTable.rows[i].cells[0]);
						var rowObj = Pudd.getInstance(contentTable.rows[i]);
						
						for(var j=0; j<checkedCardNum.length; j++){
							if(rowObj.rowData.cardNum == checkedCardNum[j].cardNum){
								checkObj.checkboxObj.setChecked(true);
							}
						}
					}
				}  
		  }
		});
	}
	
	//선택된 카드정보 데이터 가져오기
	function fnGetCheckedData(){
		var puddGrid = Pudd("#tblUserCardInfo").getPuddObject();
		if(!puddGrid){
			//데이터가 없습니다.
			alert("${CL.ex_dataDoNotExists}");
			return;
		}
		 
		var dataCheckedRow = puddGrid.getGridCheckedRowData("gridCheckBox");
		
		if(dataCheckedRow.length == 0){
			//선택된 항목이 없습니다.
			alert("${CL.ex_thereIsNoSelectedItem}");
			return;
		}
		
		//선택된 카드정보 데이터 반영
		fnApplyCheckedData(dataCheckedRow);
	}
	
	//선택된 카드정보 데이터 반영
	function fnApplyCheckedData(data){
		//콜백 함수 호출
		window.opener["${ViewBag.callback}"](data);
		
		window.close();
	}
</script>