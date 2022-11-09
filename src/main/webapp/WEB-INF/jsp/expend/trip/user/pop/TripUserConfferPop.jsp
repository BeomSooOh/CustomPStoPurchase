<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<link rel="stylesheet" type="text/css" href="../../../css/pudd.css">
<link rel="stylesheet" type="text/css" href="../../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../../css/re_pudd.css">

<jsp:include page="../include/TripOptionMap.jsp" flush="false" />
<jsp:include page="../include/TripCommonFunc.jsp" flush="false" />
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<div class="pop_wrap">
	<div class="pop_head">
		<h1>출장품의 가져오기</h1>
		<a href="#n" class="clo">
			<img src="../../../Images/btn/btn_pop_clo02.png" alt="" />
		</a>
	</div>

	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt>출장 기간</dt>
				<dd>
	                <div class="dal_div">
	                    <input type="text" autocomplete="off" value="" id="txt_approvalFromDate" class="w113 puddSetup" pudd-type="datepicker"  />
	                    <script type="text/javascript">
							var d = new Date()
							var monthOfYear = d.getMonth()
							d.setMonth(monthOfYear - 1)
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
				<dt class="ar pl20">제목</dt>
				<dd>
					<input type="text" autocomplete="off" style="width: 150px;" class="puddSetup enter" id="txt_searchStr" />
				</dd>
				<dd>
					<input type="button" id="btnSearch" class="puddSetup submit" value="검색" />
				</dd>
			</dl>
			<span class="btn_Detail">상세검색 <img id="all_menu_btn" src="../../../Images/ico/ico_btn_arr_down01.png"/></span>
		</div>

		<!-- 상세검색박스 -->
		<div class="SearchDetail mb10" id="divSearchDetail">
			<dl>	
				<dt  style="width:70px;">문서번호</dt>
				<dd><input type="text" autocomplete="off" class="enter" style="width:150px;" id="txt_docNo" /></dd>
				<dt style="width:70px;">기안자</dt>
				<dd><input type="text" autocomplete="off" class="enter" style="width:150px;" id="txt_aprUserName" /></dd>
				<dt style="width:70px;">장소</dt>
				<dd><input type="text" autocomplete="off" class="enter" style="width:150px;" id="txt_location"/></dd>
			</dl>
			<dl>
				<dt style="width:70px;">출장자</dt>
				<dd><input type="text" autocomplete="off" class="enter" style="width:150px;" id="txt_triper"/></dd>
				<dt style="width:70px;">여비지급</dt>
				<dd>
					<select class="selectmenu" style="width:150px;"  id="sel_payRequest">
						<option value="" selected="selected">전체</option>
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
				<h5>총 <span id="txt_listCnt">0</span> 건</h5>	
			</div>
		</div>

		<div id="divGridArea" ></div>
	</div><!-- //sub_contents_wrap -->				
</div>


<script>
	
	/*	[참조 품의 가져오기] 문서 준비 document.ready
	----------------------------------------- */
	$(document).ready(function(){
		/* 페이지 엘리먼트 초기화 진행 */
		fnInit();
		
		/* 품의서 리스트 조회 */
		setTimeout(fnSelectConfferDocs, 300);
	});

	/*	[초기화] 페이지 엘리먼트 초기화
	----------------------------------------- */
	function fnInit(){
		
		/* 엔터 검색 이벤트 지정 */
		$('.enter').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                /* 권한 품의서 리스트 조회 */
    			fnSelectConfferDocs();
            }
        });
		
		/* 검색 이벤트 지정 */
		$('#btnSearch').unbind('click').click(function(){
			/* 권한 품의서 리스트 조회 */
			fnSelectConfferDocs();
		});
	}
	
	/*	[ajax] 참조품의 현황 조회
	----------------------------------------- */
	function fnSelectConfferDocs(){
		console.log('data 검색');
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/res/selectConfferList.do' />'
			, datatype : 'json'
			, async : false
			, data : fnGetReportPageParam()
			, success : function(result) {
				console.log('SERVER CALL >> user res report RESULT> ');
				console.log(result);
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버와 통신에 실패하였습니다.');
				}else{
					$('#txt_listCnt').text(result.result.aaData.length);
					fnSetGrid(result.result.aaData);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}

	/*	[그리드] 참조품의 현황 그려주기
	----------------------------------------- */
	function fnSetGrid( aaData ){
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$("#divGridArea").html("");
		$('.gt_paging').remove();
		$("#divGridArea").GridTable({
			'tTablename': 'gridConfferReport_123'
            , 'nTableType': 1 
            , 'nHeight': 300
            , 'module' : 'expReport3'
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
	            , colgroup: '17'
	        }, {
	            no: '1'
	            , renderValue: '제목'
	            , colgroup: '28'
	        }, {
	            no: '2'
	            , renderValue: '기안자'
	            , colgroup: '11'
	        }, {
	            no: '3'
	            , renderValue: '장소'
	            , colgroup: '13'
	        }, {
	            no: '4'
	            , renderValue: '출장 기간'
	            , colgroup: '33'
	        },  {
	            no: '5'
	            , renderValue: '여비지급'
	            , colgroup: '12'
	        }, {
	            no: '6'
		        , renderValue: '출장자'
	            , colgroup: '15'
	        }, {
	            no: '7'
			        , renderValue: '경비합계'
		            , colgroup: '12'
	        }]
            , "aoDataRender": [{          // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
                no: '0',      
                render: function (idx, item) {                        	                     	
                	return '<a class="resDoc" style="cursor:pointer" title="품의문서보기">' + item.docNo + '</a>';
                }
            }, {
                no: '1',
                render: function (idx, item) {                        	                     	
                	return item.docTitle;
                } ,
                class: 'le'
            }, {
                no: '2',
                render: function (idx, item) {   
                	return item.empName;
                } 
            }, {
                no: '3',
                render: function (idx, item) {                        	                     	
                	return (item.locationName || '');
                }
            }, {
                no: '4',
                render: function (idx, item) {                        	                     	
                	return (item.tripDate || '');
                } 
            }, {
                no: '5',
                render: function (idx, item) {                        	                     	
                	return (item.tripExpenseName || '');
                } 
            }, {
                no: '6',
                render: function (idx, item) {                        	                     	
                	return (item.travelerText || '');
                } 
            }, {
                no: '7',
                render: function (idx, item) {                        	                     	
                	return fnGetCurrencyFormat(item.totalAmt || '');
                } ,
                class: 'ri'
            }]
	        , 'fnGetDetailInfo' : function(){
	        }
	        , 'fnTableDraw' : function(){
	        	
	        }
	        , 'fnRowCallBack' : function(row, aData){
	        	$(row).attr('value', escape(JSON.stringify(aData)) );
	        	
	        	$(row).find('.resDoc').click(function(){
        			fnAppdocPop(aData.docSeq, aData.formSeq);
        		});
	        	
	        	$(row).click(function(){
        			$(this).siblings().removeClass('on');
        			$(this).addClass('on');
        		});
	        	
	        	$(row).dblclick(function (){
	        		fnCallback(JSON.parse( unescape( $(row).attr('value') ) ));
	        	});
	        }
		});	
	}
	
	/*	[품의 정보 콜백] 정보 콜백 시작
	--------------------------------------------*/
	function fnCallback(aData){
		try{
			opener.fnSelectConsConfferReturn(aData);
			this.close();
		}catch(e){
			alert('참조품의서 반영에 실패 하였습니다.');
		}
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
	
</script>