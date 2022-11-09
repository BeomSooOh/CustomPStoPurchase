/**
 * 페이징 처리 시 필요한 변수	
 * var pageLength = 0;
 * var currentPage = 1;
 * var beforePageLength = 10;
 * var gridDataList;
 * var gridDataLength;
 * */
var pageLength = 0;
var currentPage = 1;
var beforePageLength = 10;
var gridDataList;
var gridDataLength;

$(document).ready(function(){
	/* 셀렉트메뉴  - 페이지 표시 개수 변경 */
	$("#selViewLength").selectmenu({change: function(){
		/* 현재 데이터가 표시되는 페이지 번호 검색 */
		if(gridDataLength % $("#selViewLength").val() > 0){
    		pageLength = Math.floor(gridDataLength / $("#selViewLength").val()) + 1;
    	}else{
    		pageLength = Math.floor(gridDataLength / $("#selViewLength").val());
    	}
		currentPage = Math.ceil( ( ( ( currentPage - 1 ) * beforePageLength ) + 1 ) / $(this).val( ) );
		if(currentPage <= 0){
			currentPage = 1;
		}
		fnSetGrid(gridDataList);
		fnGridPaging();
		beforePageLength = $(this).val();
	}});

	/* 달력 버튼 클릭 이벤트 */
	$(".button_dal").on("click",function(){
		if( !$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("widget").is(":visible") ){
			$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("show");	
		}
	});	
});



/* 체크박스 전체 체크 */
function fnAllChk(id){
	if($("#all_chk").prop("checked")) { 
		$("#" + id + " input[type=checkbox]").not(":disabled").prop("checked",true); 
	} else { 
		$("#" + id + " input[type=checkbox]").not(":disabled").prop("checked",false);
	}
}



/* 데이트 피커 설정 */
function fnSetDatepicker(id, format){
	if( (langCode.toLowerCase()||'kr') == 'en'){
		$(id).datepicker({
	  		closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1 Month','2 Month','3 Month','4 Month','5 Month','6 Month','7 Month','8 Month','9 Month','10 Month','11 Month','12 Month'],
		    monthNamesShort: ['1 Month','2 Month','3 Month','4 Month','5 Month','6 Month','7 Month','8 Month','9 Month','10 Month','11 Month','12 Month'],
	        dayNames: ['Sun','Mon','Thu','Wed','Tue','Fri','Sat'],
	        dayNamesShort: ['Sun','Mon','Thu','Wed','Tue','Fri','Sat'],
	        dayNamesMin: ['Sun','Mon','Thu','Wed','Tue','Fri','Sat'],	
	        weekHeader: 'Wk',
	        firstDay: 0,
	        isRTL: false,
	        duration:200,
	        showAnim:'show',
	        showMonthAfterYear: true,
			dateFormat: format
		});
	}
	else{
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
	
}

/* 테이블 페이징 표시 */
function fnGridPaging(){
	$("#paging").empty();
	if(pageLength <= 5){
		for(var i = 1 ; i <= pageLength ; i++){
			if(currentPage == i){
				$("#paging").append('<li class="on"><a href="javascript:fnMovePage('+i+')" id="page_'+i+'">'+i+'</a></li>');
			}else{
				$("#paging").append('<li><a href="javascript:fnMovePage('+i+')" id="page_'+i+'">'+i+'</a></li>');
			}
		}
	}else{
		/* 첫번째 페이지 */
		if(currentPage == 1){
			$("#paging").append('<li class="on"><a href="javascript:fnMovePage(1)" id="page_1">1</a></li>');
		}else{
			$("#paging").append('<li><a href="javascript:fnMovePage(1)" id="page_1">1</a></li>');	
		}

		if(currentPage <= 3){
			for(var i = 2 ; i < 5 ; i++){
				if(currentPage == i){
					$("#paging").append('<li class="on"><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}else{
					$("#paging").append('<li><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}
			}
			$("#paging").append('<li>…</li>');
		}else if(currentPage >= (pageLength - 2)){
			$("#paging").append('<li>…</li>');
			for(var i = (pageLength - 3) ; i < pageLength ; i++){
				if(currentPage == i){
					$("#paging").append('<li class="on"><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}else{
					$("#paging").append('<li><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}
			}
		}else{
			$("#paging").append('<li>…</li>');
			for(var i = currentPage - 1 ; i <= (currentPage + 1) ; i++){
				if(currentPage == i){
					$("#paging").append('<li class="on"><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}else{
					$("#paging").append('<li><a href="javascript:fnMovePage('+i+')" id="page_' + i + '">'+i+'</a></li>');
				}
			}
			$("#paging").append('<li>…</li>');
		}

		/* 마지막 페이지 */
		if(currentPage == pageLength){
			$("#paging").append('<li class="on"><a href="javascript:fnMovePage('+pageLength+')" id="page_' + pageLength + '">'+pageLength+'</a></li>');
		}else{
			$("#paging").append('<li><a href="javascript:fnMovePage('+pageLength+')" id="page_' + pageLength + '">'+pageLength+'</a></li>');	
		}
	}
}

/* 테이블 페이지 이동 */
function fnMovePage(val){
	if( 0 < val && val <= pageLength){
		currentPage = val;
		fnSetGrid(gridDataList);
		fnGridPaging();	
	}
}

/* 데이터 조회 후 테이블 그리드 및 페이징 처리 */
function fnSetDefaultTable(){
	gridDataLength = gridDataList.length;
	if(gridDataLength == 0){
		pageLength = 0
	}else if(gridDataLength % $("#selViewLength").val() > 0){
		pageLength = Math.floor(gridDataLength / $("#selViewLength").val()) + 1;
	}else{
		pageLength = Math.floor(gridDataLength / $("#selViewLength").val());
	}
	currentPage = 1;
	fnSetGrid(gridDataList);
	fnGridPaging();
}