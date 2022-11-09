<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>


<h2 class="label_title">신입사원 테스트 페이지3</h2>
<br>

<div class="sub_contents_wrap" style="min-width: 1300px">
	<div id="" class="controll_btn cl">
		<input id="txtSearch" type="text" />
		<input id="btnSearch" type="button" value="검색" />
		<input id="btnSave" type="button" value="저장" /> 
		<input id="btnDelete" type="button" value="삭제" /> 
		<input id="btnInsert" type="button" value="추가" />
	</div>
	<div class="com_ta2 bg_lightgray">
		<table>
			<colgroup>
				<col width="40" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<tr>
				<th><input class="chkEmpTable" id="checkKey" type="checkbox" /></th>
				<th>이름</th>
				<th>성별</th>
				<th>나이</th>
				<th>주소</th>
			</tr>
	
			<tbody id="tblTablebody">
				<tr>
					<td><input class = "chkEmpTable" id="checkKey1" type="checkbox" /></td>
					<td><input class="searchEmpTable" id="texName" type="text" value="유현석" /></td>
					<td><select id="selGender" class="selectmenu">
							<!-- 공통코드 처리 필요 -->
							<option value="10">남</option>
							<option value="20">여</option>
					</select></td>
					<td><input class="searchEmpTable" id="texAge" type="text" value="30" /></td>
					<td><input class="searchEmpTable" id="texAddr" type="text" value="서울시 어딘가" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<script>

	$(document).ready(function(){
		
		// 저장
		$("#btnSave").click(function(){
			fnRegName();
			fnRegAge();
			fnSave();
		});
	
		// 행 삭제
		$("#btnDelete").click(function(){
			fnDel();
		});
		
		// 행 추가
		$("#btnInsert").click(function(){
			fnInsert();
		});
		
		// 전체 선택 및 해제
		$("#checkKey").change(function(){
			fnCheckboxSetProp($(this).prop('checked'));	// checkbox에 따라 true / false 파라미터로 전달
		});
		
		// 검색 버튼 클릭
		$("#btnSearch").click(function(){
			fnSearch();
		});
		
		// 검색 enter 키
		$("#txtSearch").keypress(function(e){
 			if(e.which == 13) {
 				fnSearch();
			}
		});
	});
	
	/*
	Q1. 각 열 설정
	- 체크박스 : 동적 생성
	- 성별 : 남/여 ; 콤보박스
	- 주소 : 텍스트
	*/
	
	// - 이름 : 한글만 입력
	function fnRegName() {
		var regName = /^[가-힣]+$/;
		$('#tblTablebody tr td input[id=texName]').each(function(idx){
			if(!regName.test($(this).val())) {
				alert((parseInt(idx)+1) + '번째 이름인 ' + $(this).val() + '을(를) 한글로 수정해주세요.');
			}
		});
	};
	
	// - 나이 : 숫자만 입력
	function fnRegAge() {
		var regAge = /^[0-9]+$/;
		$('#tblTablebody tr td input[id=texAge]').each(function(idx){
			if(!regAge.test($(this).val())) {
				alert(idx+1 + '번째 나이인 ' + $(this).val() + '을(를) 숫자로 수정해주세요.');
			}
		});
	};
	
	// Q2. 버튼 설정
	// - 저장 : table data json 형태 console.log 출력 (단, 자료형은 자유)
	function fnSave() {
		var humanArray = [];
		$('#tblTablebody input:checked').each(function(idx, item){
			var human = { name : '', gender : '', age : '', addr : '' };
			$(this).closest('tr').each(function(idx, item){
				human.name = $(this).find('td:eq(1) > input').val();
				human.gender = $(this).find('td:eq(2) > select option:selected').text();
				human.age = $(this).find('td:eq(3) > input').val();
				human.addr = $(this).find('td:eq(4) > input').val();
			});
			humanArray.push((human));
		});
		console.log(humanArray);
	};
	
	// - 삭제 : 체크된 tr 삭제
	function fnDel() {
		if(confirm('정말 삭제하시겠습니까?')){
			$('#tblTablebody input:checked').each(function() {
				$(this).closest('tr').remove();
			});
		}
	};
	
	// - 추가 : tr 동적 생성
	// function fnInsert : 행 추가
	function fnInsert() {
		var row = "<tr>";
			row += "<td><input class = 'chkEmpTable' id='checkKey1' type='checkbox' /></td>";
			row += "<td><input class = 'searchEmpTable' id='texName' type='text' value='' /></td>";
			row += "<td><select id='selGender' class='selectmenu'>";
			row += "<option value='10'>남</option>";
			row += "<option value='20'>여</option>";
			row += "</select></td>";
			row += "<td><input class = 'searchEmpTable' id='texAge' type='text' value='' /></td>";
			row += "<td><input class = 'searchEmpTable' id='texAddr' type='text' value='' /></td>";
			row += "</tr>";
		$("#tblTablebody").append(row);
	};
	
	// Q3. 체크 박스
	// - 최상단 체크박스 체크시 전체 체크 및 해제
	function fnCheckboxSetProp(prop) {
		$(".chkEmpTable").each(function(){
			$(this).prop('checked', prop);
		});
	}

	// Q4. 검색 기능 추가
	// - 참고 : 1110. [관리자]명칭설정
	function fnSearch() {
		var text= $("#txtSearch").val().toString();
		if (text) {
			var isFind = false;
			$('#tblTablebody input[type=text]').each(function(idx, item){
				var temp = $(this).val();
				var n = temp.search(text);
				if ( n >= 0 ) {
					alert('검색결과 : ' + temp);
					isFind = true;
				}
			});
			if(!isFind) {
				alert('검색 결과 없음');
			}
		}
		else {
			alert('검색어를 입력하세요.');
		}
	};
</script>