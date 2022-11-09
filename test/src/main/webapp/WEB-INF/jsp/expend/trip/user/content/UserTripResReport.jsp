<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<jsp:include page="../include/TripCommonFunc.jsp" flush="false" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--css-->
<script type="text/css" src='<c:url value="/css/pudd.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/js/jqueryui/jquery-ui.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/js/pudding/css/common.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/animate.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/re_pudd.css"></c:url>'></script>
<!--js-->
<script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.186.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/js/jquery-1.9.1.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/common.js"></c:url>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1000px;">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl class="dl1">
			<dt>기안일자</dt>
            <dd>
                <div class="dal_div">
                    <input type="text" autocomplete="off" value="" id="txt_approvalFromDate" class="w113 puddSetup" pudd-type="datepicker"  />
                    <script type="text/javascript">
						var d = new Date()
						var monthOfYear = d.getMonth()
						d.setMonth(monthOfYear - 3)
						$("#txt_approvalFromDate").val(getFormatDateForDateObj(d));
					</script>
                </div>
                ~
                <div class="dal_div">
                    <input type="text" autocomplete="off" value="" id="txt_approvalToDate" class="w113 puddSetup" pudd-type="datepicker"  />
                    <script type="text/javascript">
						var d = new Date();
						$("#txt_approvalToDate").val(getFormatDateForDateObj(d));
					</script>
                </div>
            </dd>
			<dt>제목</dt>
			<dd><input type="text" autocomplete="off" style="width:200px;" class="puddSetup enter" id="txt_searchStr" /></dd>
			<dt style="width:55px;">문서상태</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:170px;" id="sel_docStatus">
					<option value="0">전체</option>
					<option value="001">임시저장</option>
					<option value="002">결재중</option>
					<option value="008">결재완료</option>
					<option value="007">기안반려</option>
				</select>
			</dd>				
			<dd><input type="button" class="puddSetup submit" value="검색" id="btn_search"/></dd>
		</dl>
		<span class="btn_Detail">${CL.ex_detailSearch}  <!--상세검색--> <img id="all_menu_btn" src="../../../Images/ico/ico_btn_arr_down01.png" /></span>
	</div>
	
	<div class="SearchDetail" id="divSearchDetail">
		<dl>	
			<dt style="width:55px;">문서번호</dt>
			<dd><input type="text" autocomplete="off" style="width:170px;" class="puddSetup enter" id="txt_docNo" /></dd>
			<dt style="width:90px;">기간</dt>
            <dd>
	            <div class="controll_btn p0">
	                <div class="dal_div">
	                    <input type="text" autocomplete="off" value="" id="txt_fromDate" class="w113 puddSetup" pudd-type="datepicker"  />
	                </div>
	                ~
	                <div class="dal_div">
	                    <input type="text" autocomplete="off" value="" id="txt_toDate" class="w113 puddSetup" pudd-type="datepicker"  />
	                </div>
	                <button id="btn_dateClear" class="reload_btn k-button" data-role="button" role="button" aria-disabled="false" tabindex="0"></button>
                </div>
            </dd>			
		</dl>
		<dl>
			<dt style="width:55px;">장소</dt>
			<dd><input type="text" autocomplete="off" style="width:170px;" class="puddSetup enter" id="txt_location" /></dd>
			<dt style="width:90px;">출장자</dt>
			<dd><input type="text" autocomplete="off" style="width:170px;" class="puddSetup enter" id="txt_triper" /></dd>		
		</dl>
		<dl>	
			<dt style="width:55px;">구분</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:170px;" id="sel_domesticCode">
					<option value="">전체</option>
					<option value="0">국내</option>
					<option value="1">해외</option>
				</select>
			</dd>
			<dt style="width:90px;">여비지급</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:170px;" id="sel_payRequest">
					<option value="">전체</option>
					<option value="0">대상</option>
					<option value="1">비대상</option>
				</select>
			</dd>
		</dl>
	</div>
		
	<!-- 컨텐츠내용영역 -->
	<div class="sub_contents_wrap mb0">						
			<div class="btn_div">
				<div class="left_div">
					<h5>총 <span id="totalCnt">10</span> 건</h5>	
				</div>
				
				<div class="right_div">
				<!-- 
					<input type="button"  id="btnExcelDown" class="puddSetup"  value="${CL.ex_excelDown}"><!-엑셀다운로드-></input>
				-->
				<input type="button" class="puddSetup" onclick="xl_fc(this)" value="${CL.ex_excelDown}" />
				<div class="down_lay" style="display:none;right:45px;position:absolute;">
					<div class="down_lay_in">
					<a href="#n" onclick="clo_fc();" class="clo"></a>
						<div class="down_lay_con">
								<ul style="text-align:left;">
									<li><a href="#n" id="btnExcelDown" onclick="fnAdminReportExcelDown('1')">기본정보 다운로드</a></li>
									<li><a href="#n" id="btnExcelDown2" onclick="fnAdminReportExcelDown('2')">예산과목별 다운로드</a></li>
									<li><a href="#n" id="btnExcelDown3" onclick="fnAdminReportExcelDown('3')">사용자별 다운로드</a></li>
								</ul>
						</div>
						<div class="semo"></div>
					</div>
				</div>	


				</div>
				
			</div>

			<div id="divGridArea" ></div>
	
		
	</div><!-- //sub_contents_wrap -->					
</div><!-- iframe wrap -->
				
				
				
<script type="text/javascript">

	/*	[초기화] 도큐먼트 레디 이벤트 정의
	---------------------------------------------------- */
	$(document).ready(function(){
		
		/* 엘리먼트 초기화 */
		fnElemInit();
		
		/* 이벤트 초기화 */
		fnEventInit();
		
		/* 그리드 데이터 조회 */
		fnSetGrid();
	});

	/*	[초기화] 엘리먼트 초기화
	---------------------------------------------------- */
	function fnElemInit(){
	}
	
	 /*	[ 엑셀 ] 지출결의서 전송리스트 엑셀 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown(excelType) {
		if(!reportListCnt){
			alert("데이터가 없습니다.");
			return;
		}

		$("#fileName").val( "나의출장결의현황" );
		
		// 엑셀 다운로드 타입  ( 1: 기본, 2: 예산과목별, 3: 사용자별 )
		$("#tripExcelCode").val( excelType );
		
		var excelHeader = {};
		
		// 화면 그리드 내역 다운로드
		if( excelType == '1' ){
			/* Excel 헤더 정의 */
			excelHeader.docNo = "문서번호";
			excelHeader.docTitle = "제목";
			excelHeader.approDate = "기안일자";
			excelHeader.deptName = "부서";
			excelHeader.empName = "기안자";
			excelHeader.domesticName = "구분";
			excelHeader.locationName = "장소";
			excelHeader.tripDate = "기간";
			excelHeader.fromDate = "시작일";
			excelHeader.fromTime = "시작일시";
			excelHeader.toDate = "종료일";
			excelHeader.toTime = "종료일시";	
			excelHeader.tripExpenseName = "여비지급";
			excelHeader.travelerText = "출장자";
			excelHeader.totalAmt = "경비합계";
			excelHeader.docStatus = "문서상태";
			excelHeader.confferYN = "품의사용";			
		
		// 예산과목별 엑셀 다운로드, 사용자별 엑셀 다운로드
		}else {
			/* Excel 헤더 정의 */
			excelHeader.docNo = "문서번호";
			excelHeader.docTitle = "제목";
			excelHeader.approDate = "기안일자";
			excelHeader.deptName = "부서";
			excelHeader.empName = "기안자";
			excelHeader.domesticName = "구분";
			excelHeader.locationName = "장소";
			excelHeader.locationAdv = "상세주소";
			//excelHeader.tripDay  = "출장일수";
			//excelHeader.tripTime = "출장시간";
			excelHeader.transportName = "교통";
			excelHeader.purpose = "목적";			
			excelHeader.tripDate = "기간";
			excelHeader.fromDate = "시작일";
			excelHeader.fromTime = "시작일시";
			excelHeader.toDate = "종료일";
			excelHeader.toTime = "종료일시";	
			excelHeader.tripExpenseName = "여비지급";
			excelHeader.travelerText = "출장자";			
			excelHeader.amtClass1Amt = "일비";
			excelHeader.amtClass2Amt = "식비";
			excelHeader.amtClass3Amt = "숙박비";
			excelHeader.amtClass4Amt = "운임비";
			excelHeader.amtClass5Amt = "기타여비1";
			excelHeader.amtClass6Amt = "기타여비2";			
			excelHeader.bgtName1 = "관";
			excelHeader.bgtName2 = "항";
			excelHeader.bgtName3 = "목";
			excelHeader.bgtName4 = "세";			
			excelHeader.totalAmt = "경비합계";
			excelHeader.docStatus = "문서상태";
			excelHeader.confferYN = "품의사용";					
		}
		
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/trip/user/comm/commonExcel.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}

	
	/*	[초기화] 이벤트 초기화
	---------------------------------------------------- */
	function fnEventInit(){
		$('#btn_search').click(function(){
			fnSetGrid();
		});
		
        // 엔터 이벤트 적요
        $('.enter').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btn_search').click();
            }
        });
        
		/* 엑셀 다운로드 이벤트 정의 
		*  엑셀 유형별 저장으로 이하여 해당 이벤트 비활성화 ( 2019.12.30 )
		*/
		/*
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
		*/
		$('#btn_dateClear').click(function(){
			var puddObj1 = Pudd( "#txt_toDate" ).getPuddObject();
			var puddObj2 = Pudd( "#txt_fromDate" ).getPuddObject();
			puddObj1.setDate( "" );
			puddObj2.setDate( "" );
		});
	}
	
	/*	[리사이징] 그리드 사이즈 리사이징
	---------------------------------------------------- */
	function gridHeightChange( minusVal ) {
		var puddGrid = Pudd( "#grid" ).getPuddObject();
		var cHeight = document.body.clientHeight;

		var newGridHeight = cHeight - minusVal;
		if( newGridHeight > 100 ) {// 최소높이
			puddGrid.gridHeight( newGridHeight );
		}
	}
	
	var reportListCnt = 0 ;
	/*	[그리드 출력] 현황 메인 테이블 출력
	---------------------------------------------------- */
	function fnSetMainGrid(aaData){
		reportListCnt = aaData.length;
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$("#divGridArea").html("");
		$('.gt_paging').remove();
		$("#divGridArea").GridTable({
			'tTablename': 'gridResReport'
            , 'nTableType': 1 
            , 'nHeight': 600
            , 'module' : 'expReport'
            , 'bNoHover' : true      
            , 'oNoData': {                 // 데이터가 존재하지 않는 경우 
                'tText': '데이터가 존재하지 않습니다.' // 출력 텍스트 설정
            }
            , "data": aaData
	        , 'oPage': {                   // 사용자 페이징 정보
	            'nItemSize': pageSize||15               // 페이지별 아이템 갯수(기본 값. 10)
	            , 'anPageSelector' : [15, 35, 50, 100] // 아이템 갯수 선택 셀렉트 구성
	        }
            , "aoHeaderInfo": [{
	            no: '0'
	            , renderValue: "문서번호"
	            , colgroup: '20'
	        }, {
	            no: '1'
	            , renderValue: '제목'
	            , colgroup: '30'
	        }, {
	            no: '2'
		            , renderValue: "기안일자"
		            , colgroup: '15'
			}, {
	            no: '3'
	            , renderValue: '구분'
	            , colgroup: '8'
	        },  {
	            no: '4'
	            , renderValue: '장소'
	            , colgroup: '15'
	        }, {
	            no: '5'
		        , renderValue: '기간'
	            , colgroup: '38'
	        }, {
	            no: '6'
			        , renderValue: '여비지급'
		            , colgroup: '12'
	        }, {
	            no: '7'
			        , renderValue: '출장자'
		            , colgroup: '17'
	        }, {
	            no: '8'
			        , renderValue: '경비합계'
		            , colgroup: '15'
	        }, {
	            no: '9'
			        , renderValue: '문서상태'
		            , colgroup: '15'
	        }, {
	            no: '10'
			        , renderValue: '품의사용'
		            , colgroup: '10'
	        }]
            , "aoDataRender": [{          // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
                no: '0',      
                render: function (idx, item) {                        	                     	
                	return '<a class="resDoc" style="cursor:pointer" title="결의문서보기">' + item.docNo + '</a>';
                }
            }, {
                no: '1',
                render: function (idx, item) {
                	return '<a class="resDoc" style="cursor:pointer" title="결의문서보기">' + item.docTitle + '</a>';
                } ,
                class: 'le'
            }, {
                no: '2',
                render: function (idx, item) {                        	                     	
                	return item.approDate;
                } ,
                class: 'cen'
            }, {
                no: '3',
                render: function (idx, item) {                        	                     	
                	return (item.domesticName || '');
                } 
            }, {
                no: '4',
                render: function (idx, item) {                        	                     	
                	return (item.locationName || '');
                } 
            }, {
                no: '5',
                render: function (idx, item) {                        	                     	
                	return (item.tripDate || '');
                } 
            }, {
                no: '6',
                render: function (idx, item) {                        	                     	
                	return (item.tripExpenseName || '');
                }
            }, {
                no: '7',
                render: function (idx, item) {                        	                     	
                	return '<span title="' + item.member + '"> ' + (item.travelerText || '') + '</span>'; 
                }
            }, {
                no: '8',
                render: function (idx, item) {                        	                     	
                	return fnGetCurrencyFormat(item.totalAmt || '');
                } ,
                class: 'ri'
            }, {
                no: '9',
                render: function (idx, item) {                        	                     	
                	return fnGetDocStatusLabel(item.docStatus || '');
                }
            }, {
                no: '10',
                render: function (idx, item) {                        	                     	
                	return (item.confferYN || '');
                }
            }]
	        , 'fnGetDetailInfo' : function(){
	        }
	        , 'fnTableDraw' : function(){
	        	/* 페이지 리사이즈 */
	        	$('.rightContents').height(572);
	        }
	        , 'fnRowCallBack' : function(row, aData){
	        	$(row).find('.resDoc').click(function(){
        			fnAppdocPop(aData.docSeq, aData.formSeq);
        		});
	        }
		});	
	
	}
	
	/*	[전송 리스트] 전자결재 문서 창
	--------------------------------------------*/
	function fnAppdocPop(docSeq, formSeq) {
		var intWidth = '900';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "";
		var eaType = "${loginVo.eaType}";
		var popName = "";
		if( eaType == "eap"){
			popName = "AppDoc";
			url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq + "&form_id=" + formSeq + "&doc_auth=1";
		}else{
			var param = "diKeyCode=" + docSeq + "&mode=reading";
			popName = "popDocApprovalEdit";
			param= "multiViewYN=N&"+param;
			url = "/ea/edoc/eapproval/docCommonDraftView.do?"+ param;
		}
		window.open(url, popName,'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
	}
	
	/*	[테이블] 그리드 테이블 데이터 바인딩
	---------------------------------------------------- */
	function fnSetGrid(){
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/res/selectTripResReport.do' />'
			, datatype : 'json'
			, async : false
			, data : fnGetReportPageParam()
			, success : function(result) {
				console.log('SERVER CALL >> user res report RESULT> ');
				console.log(result);
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버와 통신에 실패하였습니다.');
				}else{
					$('#totalCnt').text(result.result.aData.size);
					fnSetMainGrid(result.result.aaData);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}

	function xl_fc(th) { 
		//툴팁 생성
		$(".down_lay").show();
	}	
	
	function clo_fc() {
		//툴팁 생성
		$(".down_lay").hide();
	}	
</script>				