<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript" src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>

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
                "sTitle" : "${CL.ex_cardNumber}", // 카드 번호
                "mDataProp" : "cardNum",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_card} ${CL.ex_name}", // 카드명
                "mDataProp" : "cardName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "le"
          } ];

		var columDefs  = [ {
			"targets" : 0,
			"data" : null,
			"render" : function( data ) {
				if(data){
					if (isDisplayFullNumber === 'false') {
						return data.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{1,4})$/,"$1-****-****-$4");
					}else{
						return data.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{1,4})$/,"$1-$2-$3-$4");
					}
				}
			}
		} ] ;
		
		// 그리드 그리기 호출
		cmmFnc_SetGridView(defaultInfo, 'tbl_codePopTbl', data.result.aaData, aoColumn, columDefs);
	}
	
	/*	[델리게이터] 저장데이터 객체 리턴
	--------------------------------------------*/
	function fnGetReturnObj(defaultInfo){
		// 콜백으로 넘어갈 데이터 리턴
		var data = JSON.parse($('#hid_cmmDataTrunk').val());
		if(isDisplayFullNumber === 'false'){
			data.displayCardNum = data.cardNum.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-****-****-$4");
		}else {
			data.displayCardNum = data.cardNum;
		}
		return {obj : data };
	}
	
	/*	[델리게이터] 확장필터 적용
	--------------------------------------------*/
	function fnGetAdvFilter(defaultInfo){
		// 확장데이터 파라미터 리턴
		return {testProp : 'test'};
	}
	
</script>