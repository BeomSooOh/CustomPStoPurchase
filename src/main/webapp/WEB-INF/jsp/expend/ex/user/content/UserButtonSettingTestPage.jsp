<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

button setting test page
<br><br><br>

화면 맨위
<div id="testDiv" class="btnPosition10">
</div>
<br><br>
항목 영역
<div id="testDiv" class="btnPosition20">
</div>
<br><br>
분개 영역
<div id="testDiv" class="btnPosition30">
</div>
<br><br>
관리항목 영역
<div id="testDiv" class="btnPosition40">
</div>
<br><br>
<button style="width:100px;">항목추가</button>

<script>
	var btnInfo = BtnInfo();
	$(document).ready(function(){
		btnInfo.setBtns(${btnInfo});
		
		printButton();
	});
			
	function printButton(){
		var btns = btnInfo.getBtns();
		var length = btns.length;
		
		for(var i = 0 ; i < length ; i++){
			var item = btns[i];
			var buttonName = item['nm' + '${langKind}'.toUpperCase()] || item.nmBasic;
			var width = item.btnSize;
			var action = item.defaultYN == 'Y' ? 'javascript:fnButtonAction(\''+item.defaultCode+'\')' : item.callURL;
			var btnTag = '<button style="width:'+ width +'px;" onClick="'+action+'">'+ buttonName +'</button>';

			$('.btnPosition' + item.position).append(btnTag);
		}
	}
	
	function fnButtonAction(func){
		console.log(typeof window[func]);
		if(typeof window[func] === 'function'){
			window[func]();
		}
	}
	
	function listAdd(){
		alert('항목 추가');
	}
	
	function submitApproval(){
		alert('결재 상신');
	}
	
	function BtnInfo(){
		var btns;
		var length;
		return {
			setBtns : function (data){
				btns = data;
				length = data.length;
			}
			, getBtns : function (){
				return btns;
			}
			, getBtn : function(code){
				for(var i = 0; i < length; i++ ){
					if( btns[i].defaultCode == code){
						return btns[i];
					}
				}
				return null;
			}
		};
	}
	
</script>


