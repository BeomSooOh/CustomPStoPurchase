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
		fnFavoritesListSelect();
	});
	
	/*	[초기화] 페이지 엘리먼트 초기화
	----------------------------------------- */
	function fnInit(){
		
		/* 엔터 검색 이벤트 지정 */
		$('#txtConfferFilter').keydown(function (event) {
            if (event.keyCode === 13) {
                /* 즐겨찾기 결의서 리스트 조회 */
            	fnFavoritesListSelect();
            }
        });
		
		/* 검색 이벤트 지정 */
		$('#btnSearch').unbind('click').click(function(){
			/* 권한 품의서 리스트 조회 */
			fnFavoritesListSelect();
		});
		
		if('${ViewBag.empInfo.langCode}'=='en'){
			Pudd.Resource.Calendar.weekName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
			Pudd.Resource.Calendar.todayNameStr = "today";
		}
	}
	
	/*	[참조 품의 가져오기] 즐겨찾기 리스트 조회
	----------------------------------------- */
	function fnFavoritesListSelect(){
		var data = {};
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/np/user/cons/ConsFavoritesListSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : data,
	        success : function( result ) {
	        	if(result.result.resultCode == 'SUCCESS'){
	        		fnDrawFavoritesInfo( fnSearchListFilter(result.result.aaData) );
	        		$('#count').html(result.result.aaData.length);
	        	}else{
	        		alert('즐겨찾기 조회에 실패하였습니다.');
	        	}
	        },
	        error : function( data ) {
	            console.log('오류다!확인해봐!이상해~!!악!');
	        }
	    });
	}
	
	/*	[참조 품의 데이터 그리기] 참조 품의 내용 그리기
	----------------------------------------- */
	function fnDrawFavoritesInfo(data){
		data = data || [];
		var length = data.length;
		var htmlCode = '';
		for(var i=0; i< length; i++){
			var item = data[i];
			var trCode = '';
			trCode += '<tr>';
			trCode += '	<td> <a value=' + escape(JSON.stringify(item)) + '>' + item.docNo + '</a></td>';
			trCode += ' <td style="text-align:left;padding-left:10px;"><a class="favoriteDoc" onclick="fnFavoritesUpdate(\'' + escape(JSON.stringify(item)) + '\')" style="cursor:pointer"><img src="/exp/Images/ico/ico_book01_on.png" index="' + i + '" id="' + item.consDocSeq + '"></a>' + ' ' + item.consDocNote + '</td>';
			trCode += '	<td>'+item.createDate+'</td>';
			trCode += '	<td style="text-align:right;padding-right:10px;">'+fnGetCurrenyCode(item.totalAmt,0)+'</td>';
			trCode += '</tr>';
			htmlCode += trCode;
		}
		$('#tblFavoritesInfo tr').remove();
		$('#tblFavoritesInfo').append(htmlCode);
		$('#tblFavoritesInfo tr').dblclick(function(){
			if(!overlapYN){
				overlapYN = !overlapYN;
				window.close();
				var idx = $(this).find('img').attr('index');
				var returnObj = data[idx];
				window.opener.fnCallbackFavorites(returnObj);
			}
		});
	}
	
	
	/*	[공통] 검색리스트 필터 적용
	----------------------------------------- */
	function fnSearchListFilter(aaData){
		var createDate = $('#createDate').val()||'';
		var searchCode = $('#txtConfferFilter').val()||'';
		var resultList = [];
		for(var i=0; i<aaData.length;i++){
			if(aaData[i].createDate.indexOf(createDate)==-1){
				continue;
			}	
			if(aaData[i].docNo.indexOf(searchCode)==-1 && aaData[i].consDocNote.indexOf(searchCode)==-1){
				continue;
			}		
					
			resultList.push(aaData[i]);
		}
		return resultList;
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
	
	/* 즐겨찾기 추가 및 삭제 */
	function fnFavoritesUpdate(aData){
		aData = JSON.parse(unescape(aData));
		var consDocSeq = aData.consDocSeq;
		var param = {
				    consDocSeq : aData.consDocSeq
				    , favoritesStatus : 'N'
				    , consDocNote : aData.consDocNote
					};
		$.ajax({
		    type : 'post'
		    , url : '/exp/ex/np/user/cons/FavoritesUpdate.do'
		    , datatype : 'json'
		    , async : false
		    , data : param
		    , success : function(result) {
		    	alert("즐겨찾기에 제외되었습니다.");
		    	fnFavoritesListSelect();
		    }
		    , error : function(result) {
		   		alert("즐겨찾기 삭제 실패");
		    }
		});
	}
	
</script>


<div class="pop_wrap">
	<div class="pop_sign_head posi_re">
		<h1 id="lbl_consTitle">${CL.ex_favorite}</h1>
	</div>	
    
    <div class="pop_con">   
    	<div class="top_box">
		    <dl class="">
		        <dt>${CL.ex_draftDate}</dt>
		        <dd>
		            <input type="text" autocomplete="off" style="width:130px;" id="createDate" class="w113 enter puddSetup" pudd-type="datepicker" readonly/> 
		        </dd> 
		        <dt>
		            ${CL.ex_keyWord}  <!--검색어-->
		        </dt>
		        <dd>
		            <input type="text" autocomplete="off" style="width:230px;" id="txtConfferFilter" />
		        </dd>
		        <dd>
		            <input type="button" id="btnSearch" value="${CL.ex_search} "/> <!--검색-->
		        </dd>
		    </dl>
		</div>   
	    <div class="btn_div cl">
	    	<div class="left_div">
	    		${CL.ex_yeCount} <span id="count">0</span> ${CL.ex_gun}
	    	</div>
	    	<span style="color:red;">&nbsp;&nbsp;&nbsp;${CL.ex_favoriteMessage}</span>
		</div>

        <div class="com_ta2 mt14 scroll_y_on bg_lightgray" style="height:300px;" >
            <table border="0">
                <colgroup>
                	<col width="60" />
                    <col width="150" />
                    <col width="40" />
                    <col width="70" />
                </colgroup>
                <thead>
                    <tr>
                    	<th>${CL.ex_originDocNum}  <!--원문문서번호--></th>
                        <th>${CL.ex_originDocTitle}  <!--원본제목--></th>
                        <th>${CL.ex_originDocDate}  <!--원본기안일자--></th>
                        <th>${CL.ex_originDocAmt}  <!--금액--></th>
                    </tr>
                </thead>                  
                <tbody id="tblFavoritesInfo">

                </tbody>  
            </table>
        </div>  
    </div>
</div>   

