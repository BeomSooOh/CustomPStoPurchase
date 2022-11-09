<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
	
	
<h2 class="label_title"> 신입사원 테스트 페이지 </h2> <br>	


<span> 
	1. 저의 이름은	<input type="text" id="txt_name" readonly/>입니다. <br>
	
	저의 집은 <input id="txt_location" type="text" value="춘천" readonly>입니다. 
<span>


<script>

$(document).ready(function(){
	practice1();
	
	practice2();
	
	practice3();
});

function practice1(){
	/* jQuery의 ID selector와 val함수를 이용하여 텍스트 박스(txt_name)에 자신의 이름을 동적 삽입하여 보자. */
}

function practice2(){
	/* jQuery의 tag selector를 이용하여 span태그 내의 인풋태그를 검색하는 셀렉터를 구성하고 인풋태그들의 값을 로그로 기록하여보자. */
	// 로그 기록 함수 console.log(logs..);
}

function practice3(){
	/* 인풋태그(txt_location)에 임의의 클래스를 추가하고, class selector를 이용하여 값을 서울로 바꾸어보자. */
}

/* 
	각 셀렉터의 장단점을 서술하고 느낀점을 적어보자
*/

</script>


