<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


<input type="button" onclick="javascript:btnClick();" value="실패 사유 팝업 호출"/>

<br>
<input type="text" id="txt_code" value="" width="500"/>

<script>

/*	[document] 공통코드 선택업 테스트 페이지 준비
 -------------------------------------------------- */
$(document).ready(function(){
	
});

/* 테스트 메소드 정의 */
function btnClick(){
	
	var pageInfo = {
		pageTitle : "팝업 타이틀임 ㅇㅇ"
		, colGbn : "왼쪽 컬럼 간판"
		, colDetail : "나는 오른쪽"
		, colData : JSON.stringify([
			{
				colGbn : '[문서번호1]'
				, colDetail : '그냥 전송실패'
			}
			, {
				colGbn : '[문서번호2]'
				, colDetail : '나도 그냥 전송실패'
			}
        ])
	};
	
	var popWidth = 600;
	var popHeight = 420;
	
	var isFirefox = typeof InstallTrigger !== 'undefined';
	var isIE = false || !!document.documentMode;
	var isEdge = !isIE && !!window.StyleMedia;
	var isChrome = !!window.chrome && !!window.chrome.webstore;
	
	if(isFirefox){
		popWidth = 600;
		popHeight = 423;
	}if(isIE){
		popWidth = 600;
		popHeight = 370;
	}if(isEdge){
		popWidth = 600;
		popHeight = 419;
	}if(isChrome){
		popWidth = 600;
		popHeight = 370;
	}
	
	var screenLeft=0, screenTop=0;
	var defaultParams = { }
    var name = 'MyWindow';
    var width = popWidth;
    var height = popHeight;
	
	
    if(typeof window.screenLeft !== 'undefined') {
        screenLeft = window.screenLeft;
        screenTop = window.screenTop;
    } else if(typeof window.screenX !== 'undefined') {
        screenLeft = window.screenX;
        screenTop = window.screenY;
    }
    
    var features_dict = {
            toolbar: 'no',
            location: 'no',
            directories: 'no',
            left: screenLeft + ($(window).width() - width) / 2,
            top: screenTop + ($(window).height() - height) / 2,
            status: 'yes',
            menubar: 'no',
            scrollbars: 'yes',
            resizable: 'no',
            width: width,
            height: height
        };
        features_arr = [];
        for(var k in features_dict) {
            features_arr.push(k+'='+features_dict[k]);
        }
        features_str = features_arr.join(',')

        var qs = "<c:url value="/ex/expend/common/ProcessFailPop.do" />" + '?' + $.param($.extend({}, defaultParams, pageInfo));
        var win = window.open(qs, name, features_str);
        win.focus();
}

</script>