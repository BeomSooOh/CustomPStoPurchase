<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
	
<h2 class="label_title"> 신입사원 테스트 페이지2 </h2> <br>	

<span> 
	1. 곱하기 <br>
	<input class="multi" type="text" id="num1" /> *
	<input class="multi" type="text" id="num2" >=
	<input class="multi" type="text" id="result" >
	<br>
	<input type="button" id="cal" value="계산"/> <br>
	
	2.
	<input type="button" id="save" value="저장"/>
	<input type="button" id="reset" value="초기화"/>
	<input type="button" id="load" value="불러오기"/> <br>
	이름 : <input class="resume" type="text" id="name" /> <br>
	나이 : <input class="resume" type="text" id="age" /> <br>
	성별 : <input class="resume" type="text" id="gender" />
<span>


<script>
var resume = new Object();

$("#cal").click(function(){
	cal();
})

$("#save").click(function(){
	save();
})

$("#reset").click(function(){
	reset();
})

$("#load").click(function(){
	load();
})

// Q1. 곱셈 연산하는 버튼 이벤트
// function cal : 숫자 (num1, num2)의 곱
function cal() {
	var num1 = parseInt($("#num1").val());
	var num2 = parseInt($("#num2").val());
	var result;
	
	// 인자 숫자 여부 체크
	if (!$.isNumeric(num1) || !$.isNumeric(num2)) {
		alert("숫자를 입력해주세요.");
	}
	else {
		result = num1 * num2;
		$("#result").val(result);
	}
}

// Q2. json 객체에 저장, 초기화, 불러오기 버튼 이벤트
// function save : 텍스트 박스(name, age, gender)의 데이터를 json 객체로 저장
function save(){
	resume.name = $("#name").val();
	resume.age = $("#age").val();
	resume.gender = $("#gender").val();
	alert("저장되었습니다.");
}

// function reset : 텍스트 박스 (name, age, gender) 초기화
function reset(){
	$(".resume").val('');
	alert("초기화 되었습니다.");
}

// function load : 저장된 json 객체를 불러옴
function load(){

	$("#name").val(resume.name);
	$("#age").val(resume.age);
	$("#gender").val(resume.gender);
	alert("불러왔습니다.");
}

</script>