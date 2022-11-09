<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!-- 테이블 -->
<div class="com_ta2 mt14">
	<table id="tbl_codePopTbl">
	</table>
</div>

<script>
	/*	[뷰]	테이블 아이템 렌더링 준비
	--------------------------------------------*/
	$ ( document ).ready ( function ( ) {

		// 델리게이터 지정
		delegatorSetMainList = fnSetMainList;
		delegatorGetReturnObj = fnGetReturnObj;
		delegatorGetAdvFilter = fnGetAdvFilter;
	} );

	/*	[델리게이터] 메인리스트 설정
	--------------------------------------------*/
	function fnSetMainList ( defaultInfo, data ) {
		// 파라메터 data의 가공 필요.
		var aoColumn = [ {
			"sTitle": "${CL.ex_vendor} ${CL.ex_code}", // 거래처 코드
			"mDataProp": "partnerCode",
			"bVisible": true,
			"bSortable": true,
			"sWidth": "25%"
		}, {
			"sTitle": "${CL.ex_vendor} ${CL.ex_name}", // 거래처 명칭
			/* "mDataProp": "partnerName", */
			"bVisible": true,
			"bSortable": true,
			"sWidth": "55%",
			"sClass": "le"
		},{
			"sTitle": "${CL.ex_representive}", // 대표자
			"mDataProp": "ceoName",
			"bVisible": true,
			"bSortable": true,
			"sWidth": "20%",
			"sClass": "le"
		} ];

		var columDefs = [{
			"targets": 1,
			"data": null,
			"render": function ( data ) {
				var result = '';
				var partnerName = '';
				if ( typeof data.partnerName != 'undefined' ) {
					partnerName = data.partnerName;
				} else {
					partnerName = '';
				}

				var partnerNo = '';
				if ( data.partnerNo  || data.partnerNo === 0 ) {
					partnerNo = data.partnerNo;
				} else {
					partnerNo = '';
				}

				var resNo = '';
				if ( typeof data.resNo != 'undefined' && data.resNo.trim() != '' ) {
					resNo = data.resNo;
				} else {
					resNo = '';
				}
				
				var pplNo = '';
				if ( typeof data.pplNo != 'undefined' ) {
					pplNo = data.pplNo;
				} else {
					pplNo = '';
				}
				
				if((data.pratnerFg || '') == '3'){
					if ( partnerName != '' && pplNo != '' ) {
						result = partnerName + ' [' + pplNo.toString().substring(0,6) +'-' +pplNo.toString().substring(6,7) +'******'+ ']';
						
					} else {
						if ( partnerName != '' && resNo != '' ) {
							result = partnerName + ' [' + resNo + ']';
						} else if ( partnerName != '' && partnerNo != '' ) {
							result = partnerName + ' [' + partnerNo.toString().replace(/(^[0-9]{3})-?([0-9]{2})-?([0-9]{5})$/,"$1-$2-$3") + ']';
						} else {
							result = partnerName;
						}
					}
				} else {
					if ( partnerName != '' && partnerNo != '' && partnerNo != '8888888888') {
						result = partnerName + ' [' + partnerNo.toString().replace(/(^[0-9]{3})-?([0-9]{2})-?([0-9]{5})$/,"$1-$2-$3") + ']';
					} else if  ( partnerName != '' && resNo != '' ){
						result = partnerName + ' [' + resNo + ']';
					} else {
						result = partnerName;
					}
				}
				return result;
			}
		} ];

		// 그리드 그리기 호출
		cmmFnc_SetGridView ( defaultInfo, 'tbl_codePopTbl', data.result.aaData, aoColumn, columDefs );
	}

	/*	[델리게이터] 저장데이터 객체 리턴
	--------------------------------------------*/
	function fnGetReturnObj ( defaultInfo ) {
		// 콜백으로 넘어갈 데이터 리턴
		var data = JSON.parse ( $ ( '#hid_cmmDataTrunk' ).val ( ) );
		return {
			obj: data
		};
	}

	/*	[델리게이터] 확장필터 적용
	--------------------------------------------*/
	function fnGetAdvFilter ( defaultInfo ) {
		// 확장데이터 파라미터 리턴
		return {
			testProp: 'test'
		};
	}
</script>