<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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


<script>
$(document).ready(function() {
			
	// #grid1 table
	var exData = [
			{ "gridCheckBox": "", 
			"data1": "1000", 
			"data2": "B120220019", 
			"data3": "", 
			"data4": "물품(구매)", 
			"data5": "계약 및 물품구매 전자관리시스템 구축", 
			"data6": "1,200,000,000원", 
			"data7": "",
			"data8": "2022/09/01",
			"data9": "",
			"data10": "",
			"data11": "",
			"data12": "",
			"data13": "",
			"data14": "",
			"data15": "",
			"data16": "",
			"data17": "",
			"data18": "",
			"data19": "",
			"data20": "",
			"data21": "",
			"data22": "",
			"data23": "",
			"data24": "",
			"data25": "",
			"data26": "",
			"data27": "",
			"data28": "",
			"data29": "",
			"data30": "",
			"data31": "",
			"data32": "",
			"data33": "",
			"data34": "",
			"data35": "",
			"data36": "",
			"data37": "",
		}
	];

	var dataSource = new Pudd.Data.DataSource({
			data : exData	// 직접 data를 배열로 설정하는 옵션 작업할 것
		,	pageSize : 1000	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : false
	});

	Pudd("#grid1").puddGrid({
			dataSource : dataSource
		//,	height : 112
		,	scrollable : true
		, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : true			
		,	pageable : {
				buttonCount : 10 
			,	pageList : [ 10, 20, 30, 40, 50 ]
			}
		,	columns : [
			{
				field : "gridCheckBox"
			,	title : "체크박스"
			,	width : 34
			,	editControl : {
					type : "checkbox"
				,	dataValueField : "rank"	// value값을 datasource와 매핑하는 경우 설정
				,	basicUse : true
				}
			}
			,	{
				title : "기본정보"
			,	columns : [
				{
						field : "data1"
					,	title : "연변"
					,	width : 70
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "data2"
					,	title : "관리번호"
					,	width : 130
				}
			,	{
						field : "data3"
					,	title : "계약번호"
					,	width : 120
					,	content : {		
						template : function() {
							var html = '<input type="text" pudd-style="width:100%;" class="puddSetup ac" value="" />';
							return html;
						}
					}
				}
			,	{
						field : "data4"
					,	title : "계약목적물"
					,	width : 120
				}					
			,	{
						field : "data5"
					,	title : "계약명"
					,	width : 250
					,	content : {
							attributes : { class : "le ellipsis" }
					}
					,	tooltip : { 
						alwaysShow : false		// 말줄임 여부와 관계없이 tooltip 보여줄 것인지 설정, 기본값 false
					,	showAtClientX : false	// toolTip 보여주는 위치가 mouse 움직이는 X 좌표 기준 여부, 기본값 false ( toolTip 부모객체 기준 )
					}
				}				
			,	{
						field : "data6"
					,	title : "계약금액"
					,	width : 130
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data7"
					,	title : "계약시작일"
					,	width : 150	
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}					
				}
			,	{
						field : "data8"
					,	title : "계약종료일"
					,	width : 100							
				}
			,	{
						field : "data9"
					,	title : "근거법령"
					,	width : 150
				}						
				]
			}
			,	{
				title : "계약대상자 정보"
			,	columns : [
				{
						field : "data10"
					,	title : "계약대상자"
					,	width : 100
				}					
			,	{
						field : "data11"
					,	title : "사업자등록번호"
					,	width : 100
				}
			,	{
						field : "data12"
					,	title : "대표자명"
					,	width : 100							
				}
			,	{
						field : "data13"
					,	title : "희망기업여부"
					,	width : 100
				}						
				]
			}
			,	{
				title : "발주정보"
			,	columns : [
				{
						field : "data14"
					,	title : "입찰/수의"
					,	width : 100
				}					
			,	{
						field : "data15"
					,	title : "발주금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data16"
					,	title : "경쟁방식"
					,	width : 100							
				}
			,	{
						field : "data17"
					,	title : "낙찰자결정방법"
					,	width : 100
				}	
			,	{
						field : "data18"
					,	title : "담당자"
					,	width : 100
			}
			,	{
						field : "data19"
					,	title : "담당부서"
					,	width : 120
			}					
				]
			}
			,	{
				title : "입찰정보"
			,	columns : [
				{
						field : "data20"
					,	title : "사전규격공개기간"
					,	width : 290
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}					
			,	{
						field : "data21"
					,	title : "본 공고기간"
					,	width : 290
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}
			,	{
						field : "data22"
					,	title : "재 공고기간"
					,	width : 290			
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}				
				}
			,	{
						field : "data23"
					,	title : "공고기간 확정"
					,	width : 100
				}	
			,	{
						field : "data24"
					,	title : "투찰자수"
					,	width : 100
					,	content : {		
						template : function() {
							var html = '<input type="text" pudd-style="width:50px;" class="puddSetup ar" value="" /> 건';
							return html;
						}
					}
			}
			,	{
						field : "data25"
					,	title : "제안서평가일"
					,	width : 120
			}					
				]
			}
			,	{
				title : "변경계약정보"
			,	columns : [
				{
						field : "data26"
					,	title : "변경계약일"
					,	width : 150
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}					
			,	{
						field : "data27"
					,	title : "과업내용변경"
					,	width : 100
				}
			,	{
						field : "data28"
					,	title : "경계약기간변경"
					,	width : 100							
				}	
			,	{
						field : "data29"
					,	title : "계약금액변경"
					,	width : 100							
				}	
			,	{
						field : "data30"
					,	title : "기타변경"
					,	width : 100							
				}			
				]
			}
			,	{
				title : "대금지급정보"
			,	columns : [
				{
						field : "data31"
					,	title : "선금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "data32"
					,	title : "기성금합산"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data33"
					,	title : "준공금"
					,	width : 100	
					,	content : {
							attributes : { class : "ri" }
					}						
				}	
			,	{
						field : "data34"
					,	title : "잔액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "data35"
					,	title : "준공율"
					,	width : 100
				}			
				]
			}
			,	{
				title : "자료"
			,	columns : [
				{
						field : "data36"
					,	title : "계약서"
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function() {
							var html = '<div><span class="text_ho"><em class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="../../../Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> STOB221014STOB221014STOB221014-008</em>.zip</span> <input type="button" class="puddSetup ml5" value="추가" /></div>';
							return html;
						}
					}
				}					
			,	{
						field : "data37"
					,	title : "계약제출서류"
					,	width : 100
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function() {
							var html = '<div><span class="text_ho"><em class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="../../../Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> STOB221014STOB221014STOB221014-008</em>.zip</span> <input type="button" class="puddSetup ml5" value="추가" /></div>';
							return html;
						}
					}
				}			
				]
			}
		]
	});

	function gridHeightChange( minusVal ) {
		var puddGrid = Pudd( "#grid1" ).getPuddObject();
		var cHeight = document.body.clientHeight;

		var newGridHeight = cHeight - minusVal;
		if( newGridHeight > 100 ) {// 최소높이
			puddGrid.gridHeight( newGridHeight );
		}
	}

	gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함

	$(window).resize(function () {
		gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함

	});
	});//---documentready
	
	
	
	function fnCallBtn(callId){
		
		if(callId == "newContract"){
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do",  "ContractCreatePop", 1200, 800, 1, 1) ;
		}
		
	}
	
	
</script>




<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">계약기간</dt>
		<dd>
			<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		<dt class="ar" style="width:40px;">계약명</dt>
		<dd><input type="text" pudd-style="width:120px;" class="puddSetup" placeHolder="공고명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">부서명</dt>
		<dd><input type="text" pudd-style="width:120px;" class="puddSetup" placeHolder="부서명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">사원명</dt>
		<dd><input type="text" pudd-style="width:90px;" class="puddSetup" placeHolder="사원명 입력" value="" /></dd>
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" /></dd>
	</dl>
</div>

<div class="sub_contents_wrap posi_re">
	<!-- 연차생성 -->
	<div class="btn_div">
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="fnCallBtn('newContract');" class="puddSetup" value="계약입찰발주계획" />
				<input type="button" class="puddSetup" value="제안서 평가회의" />
				<input type="button" class="puddSetup" value="제안서 평가결과" />
				<input type="button" class="puddSetup" value="저장" />
				<input type="button" class="puddSetup" value="계약체결" />
				<input type="button" class="puddSetup" value="변경계약" />
				<input type="button" class="puddSetup" value="대금지급" />
				<input type="button" class="puddSetup" value="엑셀다운로드" />
			</div>
		</div>
	</div>
	
	<div class="dal_Box">
		<div class="dal_BoxIn posi_re">
			<div id="grid1"></div>
		</div>
	</div>
	
</div><!-- //sub_contents_wrap -->