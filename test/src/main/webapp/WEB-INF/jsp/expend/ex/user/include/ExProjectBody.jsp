<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- 테이블 -->
<div class="com_ta2 mt14">
	<table id="tbl_codePopTbl">
	</table>
</div>

<script>

	/*	[뷰]	테이블 아이템 렌더링 준비
	--------------------------------------------*/
	$(document).ready(function(){
		
		// 델리게이터 지정
		delegatorSetMainList = fnSetMainList;
		delegatorGetReturnObj = fnGetReturnObj;
		delegatorGetAdvFilter = fnGetAdvFilter;
	});
	
	/*	[델리게이터] 메인리스트 설정
	--------------------------------------------*/
	function fnSetMainList(defaultInfo, data){
		// 파라메터 data의 가공 필요.
		var aoColumn = [ {
                "sTitle" : "${CL.ex_project} ${CL.ex_code}", // 프로젝트 코드
                "mDataProp" : "projectCode",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_project} ${CL.ex_name}", // 프로젝트 명칭
                "mDataProp" : "projectName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "le"
          } ];
		
		var columnDefs = [ {
	            "targets" : 1,
	            "data" : null,
	            "render" : function( data ) {
                    return fnConvertSpecialCharacter(data);
                }
          } ];
		
		// 그리드 그리기 호출
		cmmFnc_SetGridView(defaultInfo, 'tbl_codePopTbl', data.result.aaData, aoColumn, columnDefs);
	}
	
	//특수문자 변환
	function fnConvertSpecialCharacter(str){
		 str = str.replace(/</g,"&lt;");
		 str = str.replace(/>/g,"&gt;");
		 
		 return str;
	}
	
	/*	[델리게이터] 저장데이터 객체 리턴
	--------------------------------------------*/
	function fnGetReturnObj(defaultInfo){
		// 콜백으로 넘어갈 데이터 리턴
		var data = JSON.parse($('#hid_cmmDataTrunk').val());
		return {obj : data };
	}
	
	/*	[델리게이터] 확장필터 적용
	--------------------------------------------*/
	function fnGetAdvFilter(defaultInfo){
		// 확장데이터 파라미터 리턴
		return {testProp : 'test'};
	}
	
</script>