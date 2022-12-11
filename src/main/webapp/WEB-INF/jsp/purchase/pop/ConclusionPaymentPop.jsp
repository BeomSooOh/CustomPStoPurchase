<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>대금지급</title>

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
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		
		fnGetListBind();
		
		$(window).resize(function () {
			gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함
	
		});		

	});//---documentready끝		
		
		
	function gridHeightChange( minusVal ) {
		var puddGrid = Pudd( "#grid1" ).getPuddObject();
		var cHeight = document.body.clientHeight;

		var newGridHeight = cHeight - minusVal;
		if( newGridHeight > 100 ) {// 최소높이
			puddGrid.gridHeight( newGridHeight );
		}
	}		
	
	function fnGetListBind(){

		var reqParam = {};
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/SelectConclusionPaymentList.do" />',
			datatype : 'json',
			data : reqParam,
			async : false,
			success : function(result) {
				gridRender(result.resultList);
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});
		
		gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함
		
	}		
	
	function gridRender(listData){
		
		var dataSource = new Pudd.Data.DataSource({
			data : listData	// 직접 data를 배열로 설정하는 옵션 작업할 것
		,	pageSize : 1000	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : false
		});

		Pudd("#grid1").puddGrid({
			dataSource : dataSource
		,	scrollable : true
		, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : true			
		,	pageable : {
				buttonCount : 10 
			,	pageList : [ 10, 20, 30, 40, 50 ]
			}
		,	columns : [
				{
						field : "data1"
					,	title : "문서번호"
					,	width : 130
					,	content : {
							attributes : { class : "text_line text_ho" }
					}
				}
				,	{
						field : "data2"
					,	title : "지급구분"
					,	width : 100							
				}
				,	{
						field : "data3"
					,	title : "지급차수"
					,	width : 90							
				}
				,	{
						field : "data4"
					,	title : "결의제목"
					,	width : 300
					,	content : {
							attributes : { class : "le ellipsis" }
					}
				}
				,	{
						field : "data5"
					,	title : "기안일자"
					,	width : 100
				}
			,	{
						field : "data6"
					,	title : "결의금액"
					,	width : 120
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data7"
					,	title : "잔여금액"
					,	width : 120
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data8"
					,	title : "결재상태"
					,	width : 100
				}
			]
		});			
		
	}			
	
		
		
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;">
	<div class="pop_sign_head posi_re">
		<h1>대금지급</h1>
	</div>

	<div class="pop_con" style="overflow: auto; min-height: 460px;">
	
					<!-- 상세검색 -->
            		<div class="top_box">
						<dl>
							<dt class="ar" style="width:60px;">기안일자</dt>
							<dd>
								<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~
								<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>
							</dd>							
							<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" /></dd>
						</dl>
					</div>
					

					<div class="sub_contents_wrap posi_re">
						<!-- 연차생성 -->
						<div class="btn_div">
							<div class="left_div">							
								<h5>계약명 : ${contractDetailInfo.c_title}</h5>								
							</div>
							<div class="right_div">
								<div id="" class="controll_btn p0">
									<input type="button" class="puddSetup" value="대금지급" />
									<input type="button" class="puddSetup" value="대금지급완료" />
								</div>
							</div>
						</div>
						
						<div class="dal_Box">
							<div class="dal_BoxIn posi_re">
								<div id="grid1"></div>
							</div>
						</div>
						
					</div><!-- //sub_contents_wrap -->
	
	
	
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->
</body>
</html>