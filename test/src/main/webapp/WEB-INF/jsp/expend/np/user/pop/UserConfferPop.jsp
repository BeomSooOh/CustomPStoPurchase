<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>

<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>

<script>
	var overlapYN = false; 

	/*	[참조 품의 가져오기] 문서 준비 document.ready
	----------------------------------------- */
	$(document).ready(function(){
		
		/* 페이지 엘리먼트 초기화 진행 */
		fnInit();
		
		/* 권한 품의서 리스트 조회 */
		fnSelectConfferDocs();
	});
	
	/*	[초기화] 페이지 엘리먼트 초기화
	----------------------------------------- */
	function fnInit(){
		
		/* 엔터 검색 이벤트 지정 */
		$('#txtConfferFilter').keydown(function (event) {
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
		
		if('${ViewBag.empInfo.langCode}'=='en'){
			Pudd.Resource.Calendar.weekName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
			Pudd.Resource.Calendar.todayNameStr = "today";
		}
	}
	
	/*	[참조 품의 가져오기] 권한 품의서 리스트 조회
	----------------------------------------- */
	function fnSelectConfferDocs(){
		var frDt = $("#txtFrDt").val() || '';
		var toDt = $("#txtToDt").val() || '';
		var data = {
			frDt : frDt.replace(/-/gi, '').replace(' ','')
			, toDt : toDt.replace(/-/gi, '').replace(' ','')
			, filter : $('#txtConfferFilter').val().replace("'","''")
			, selBalanceYN : $('#seBalanceYN').val()
			, formSeq : '${formSeq}'
		};
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/np/user/cons/ConsListSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : data,
	        success : function( result ) {
	        	if(result.result.resultCode == 'SUCCESS'){
	        		fnDrawConfferInfo(result.result.aaData);
	        	}else{
	        		alert('권한 품의서 조회에 실패하였습니다.');
	        	}
	        },
	        error : function( data ) {
	            console.log('오류다!확인해봐!이상해~!!악!');
	        }
	    });
	}
	
	/*	[참조 품의 데이터 그리기] 참조 품의 내용 그리기
	----------------------------------------- */
	function fnDrawConfferInfo(data){
		data = data || [];
		var length = data.length;
		var htmlCode = '';
		for(var i=0; i< length; i++){
			var item = data[i];
			var trCode = '';
			trCode += '<tr>';
			trCode += '	<td> <hidden index="'+ i +'"></hidden> '+item.docNo+'</td>';
			trCode += '	<td>'+item.expendDate+'</td>';
			trCode += '	<td>'+item.docTitle+'</td>';
			trCode += '	<td>'+item.empName+'</td>';
			trCode += '	<td>'+fnGetCurrenyCode(item.consAmt, '-')+'</td>';
			trCode += '	<td>'+fnGetCurrenyCode(item.resAmt, '-')+'</td>';
			trCode += '	<td>'+fnGetCurrenyCode(item.balanceAmt, '-')+'</td>';
			trCode += '</tr>';
			htmlCode += trCode;
		}
		$('#tblConfferInfo tr').remove();
		$('#tblConfferInfo').append(htmlCode);
		$('#tblConfferInfo tr').dblclick(function(){
			if(!overlapYN){
				overlapYN = !overlapYN;
				window.close();
				var idx = $(this).find('hidden').attr('index');
				var returnObj = data[idx];
				window.opener.fnCallbackConffer(returnObj);
			}
		});
	}
	
	function fnGetReturnCode(data){
		if(data == 'Y'){
			return '반환완료';
		}else {
			return '미반환';
		}
	}
	
	/*	[공통] 데이트 피커 적용
	----------------------------------------- */
	function fnSetDatepicker(id, format){
		$(id).datepicker({
	  		closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        firstDay: 0,
	        isRTL: false,
	        duration:200,
	        showAnim:'show',
	        showMonthAfterYear: true,
			dateFormat: format
		});
	}
	
	/*	[공통] 통화 코드 적용
	----------------------------------------- */
	function fnGetCurrenyCode(value, defaultVal){
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || (defaultVal != undefined ? defaultVal : '0');
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
</script>

<script>
	function getFormatDate(date){
		var year = date.getFullYear();                                 //yyyy
		var month = (1 + date.getMonth());                     //M
		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
		var day = date.getDate();                                        //d
		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
</script>
<div class="pop_wrap">
	<div class="pop_sign_head posi_re">
		<h1 id="lbl_consTitle"> ${CL.ex_confferConsDocList}  <!--참조품의서 리스트--> </h1>
	</div>	
    
    <div class="pop_con">   
        <div class="top_box">
            <dl class="">
                <dt>${CL.ex_term}</dt>
                <dd>
					<div class="dal_div">
						<input type="text" autocomplete="off" value="" id="txtFrDt" class="w113 puddSetup" pudd-type="datepicker" />
						<script type="text/javascript">
							var d = new Date()
							var monthOfYear = d.getMonth()
							d.setMonth(monthOfYear - 1)
							$("#txtFrDt").val(getFormatDate(d));
						</script>
					</div>
					~
					<div class="dal_div"> 
						<input type="text" autocomplete="off" value="" id="txtToDt" class="w113 puddSetup" pudd-type="datepicker" />
						<script type="text/javascript">
							var d = new Date();
							$("#txtToDt").val(getFormatDate(d));
						</script>
					</div>  
				</dd>
				
                <dt>
                	${CL.ex_keyWord}  <!--검색어-->
               	</dt>
                <dd>
                	<input type="text" autocomplete="off" style="width:205px;" id="txtConfferFilter" />
               	</dd>
                <dt>
                	${CL.ex_balanceCondition}  <!--잔액여부-->
               	</dt>
                <dd>
                	<select class="selectmenu" id="seBalanceYN" style="width:100px;">
						<option value="A">${CL.ex_all}  <!--전체--></option>
						<option value="Y" selected="selected">${CL.ex_exist}  <!--있음--></option>
						<option value="N">${CL.ex_notExist}  <!--없음--></option>
					</select>
               	</dd>
                <dd>
                	<input type="button" id="btnSearch" value="${CL.ex_search} "/> <!--검색-->
               	</dd>
            </dl>
        </div>        

        <div class="com_ta2 mt14 scroll_y_on bg_lightgray" style="height:300px;" >
            <table border="0">
                <colgroup>
                    <col width="80" />
                    <col width="60" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    
                </colgroup>
                <thead>
                    <tr>
                        <th>${CL.ex_consNum}  <!--품의번호--></th>
                        <th>${CL.ex_consDate}</th>
                        <th>${CL.ex_title}  <!--제목--></th>
                        <th>${CL.ex_drafter}  <!--기안자--></th>
                        <th>${CL.ex_consMoney}  <!--품의금액--></th>
                        <th>${CL.ex_useAmount}  <!--사용금액--></th>
                        <th>${CL.ex_balance}  <!--잔액--></th>
                        
                    </tr>
                </thead>                  
                <tbody id="tblConfferInfo">

                </tbody>  
            </table>
        </div>  
    </div>
</div>   

