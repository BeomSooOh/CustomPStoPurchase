<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/dzt-1.0.0.js'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>


<div class="pop_wrap">
	    <div class="pop_sign_head posi_re">
        <h1 id="h1_consDocTitle">물품명세 등록  <!--품의서 작성--></h1>
        <div class="psh_btnbox">
            <!-- 양식팝업 오른쪽 버튼그룹 -->
            <div class="psh_right">
                <div class="btn_cen mt8">
                    <input type="button" class="psh_btn" value="저장" id="btnApproval" />
                </div>
            </div>
        </div>
    </div>
	<div style="padding:0px 16px 5px 16px" >
    <div id="" class="btn_div cl">
    	<div class="right_div">
           	<div class="controll_btn p0">
           		<button id="btnItemDelete" class="k-button" value="" > 삭제 </button>
            </div>
        </div>            	
    </div>
    </div>
    <div id="itemTbl">
    
    </div>
	
	<div class="hover_no com_ta2 bg_lightgray" onscroll="" style="height: 38px;">
		<table item="{}">
			<colgroup item="{}">
				<col width="107" item="{}">
				<col width="35" item="{}">
				<col width="35" item="{}">
				<col width="35" item="{}">
				<col width="35" item="{}">
				<col width="4" item="{}">
			</colgroup>
			<tbody id="gridYesilReprtTotal" item="{}">
				<tr>
					<td style="background: #f9f9f9;" class="ri"> 합계 </td>
					<td id="itemCnt" style="background: #f9f9f9;" class="ri" id="">0</td>
					<td id="unitAmt" style="background: #f9f9f9;" class="ri" id="">0</td>
					<td id="itemAmt" style="background: #f9f9f9;" class="ri" id="">0</td>
					<td style="background: #f9f9f9;"></td>
					<td style="background: #f9f9f9;"></td>
				</tr>							
			</tbody>
		</table>	
	</div>	
	   
</div>   

<script>
	var overlapYN = false; 
	var domain = '/exp';

	/*	[참조 품의 가져오기] 문서 준비 document.ready
	----------------------------------------- */
	$(document).ready(function(){
		/* 페이지 엘리먼트 초기화 진행 */
		fnInit();
		fnEventInit();
		fnAddRow();
	});
	
	/*	[초기화] 페이지 엘리먼트 초기화
	----------------------------------------- */
	function fnInit(){
		fnItemSpecTableInit();
		fnSelectItemSpec();
	}
	
	function fnEventInit(){
		/* 결재작성 */
		$('#btnApproval').click(function() {
			$('#itemTbl').dzt('setCommit', true);
			fnEventApproval();
		});
		
		/* 품의정보 삭제 */
		$('#btnItemDelete').click(function() {
			if ($('#itemTbl').find('tr.rowOn').length > 0) {
				var msg = '${CL.ex_deleteRowMessage}';

				if (confirm(msg)) {
					/* 저장 정보 삭제 */
					var tr = $('#itemTbl').dzt('getSelectedRow');
					$('#itemTbl').dzt('setRemoveRow', $(tr));
					
					/* 행이 존재하지 않는 경우 기본 행 추가 */
					if ($('#itemTbl').find('tr').length === 1) {
						fnAddRow();
					}
				}
			} else {
				alert('${CL.ex_deleteRowMessage2}');
			}

			return;
		});
	}
	
	function fnAddRow(){
		
		var items = $('#itemTbl').dzt('getValueAll');
		if(items.length>0){
			if(!items[items.length-1].itemName){
				alert("추가된 행을 먼저 입력해주세요.");
				return;	
			}
		}
		/* 행 추가 */
		var uid = $('#itemTbl').dzt('setAddRow');
		/* 포커스 지정 */
		$('#itemTbl').dzt('setFocus', uid, 'itemName');
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
	
    var Option = {
            Common: {
            	 GetArray: function (obj, key, baseValue) {
                     /* [ parameter ] */
                     /*   - obj : 테이블 생성 시 필요한 columns 정보 */
                     /*   - key : 배열로 변환할 JSON key */
                     /*   - baseValue : 값이 없는 경우 대체할 기본 값 */

                     /* ex) Option.Common.GetArray(columns, 'title', ''); */
                     obj = (obj || []);
                     key = (key || '');
                     baseValue = (baseValue || '');

                     var attrArray = [];

                     if (key !== '') { $.each(obj, function (idx, item) { attrArray.push((item[key] || baseValue)); }); }
                     return attrArray;
                 }
            }
    }
	
	/* ## 테이블 변수정의 ## */
    /* ====================================================================================================================================================== */
    var itemSpecGrid = {
        columns: [
            {
            	/* 테이블 헤더 표시 정보 */
                title: '명칭',
                /* 테이블 컬럼 구분 정보 */
                column: 'itemName',
                /* 사용자 입력 형태 정의 [ 2018.04.11 : text, readonly, combobox, datepicker ] */
                type: 'text',
                /* 화면 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
                display: 'Y',
                /* 필수 입력 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
                req: 'Y'
            },
            {
                title: '규격/용량',
                column: 'itemSize',
                type: 'text',
                display: 'Y',
                req: 'N'
            },
            {
                title: '단위',
                column: 'itemUnit',
                type: 'text',
                display: 'Y',
                req: 'N'
            },{
				title : '수량',
				column : 'itemCnt',
				type : 'text',
				display : 'Y',
				req: 'N'
			},{
				title : '단가',
				column : 'unitAmt',
				type : 'text',
				display : 'Y',
				req: 'N'
			},{
				title : '금액',
				column : 'itemAmt',
				type : 'readonly',
				display : 'Y',
				req: 'N'
			},{
				title : '비고',
				column : 'itemNote',
				type : 'text',
				display : 'Y',
				req: 'N',
				lastCallback : function() {
					/* [1] 사용자 입력 지정 */
					var item = $('#itemTbl').dzt('getValue');
					
					/* [2] 물품명세 필수값 입력 확인 */
					if(!(item.itemName||'')){
						alert('명칭을 입력하세요.');
						return;
					}
					
					/* [3] 데이터 저장 진행 */
					fnAddRow();	
				}
			}
        ]
    };
	
    function fnItemSpecTableInit() {
		/* ## init - 물품명세 테이블 정의 ## */
		var itemColumns = (itemSpecGrid.columns || []);

		$('#itemTbl').dzt({
			/* 테이블 컬럼 제목 */
			title : Option.Common.GetArray(itemColumns, 'title', ''),
			/* 테이블 컬럼 표시 */
			display : Option.Common.GetArray(itemColumns, 'display', 'N'),
			/* 테이블 컬럼 너비 */
			width : Option.Common.GetArray(itemColumns, 'width', ''),
			/* 테이블 컬럼 필수 입력 */
			req : Option.Common.GetArray(itemColumns, 'req', 'N'),
			/* 테이블 기본 높이 지정 */
			height : '135px',
			/* 데이터 변경 시 콜백 ( edit ) */
			changeCallback : function(uid, key) {
				/* console.error('changeCallback [consTbl]'); */
				return true;
			},
			/* 데이터 변경 후 콜백 ( commit ) */
			commitCallback : function(uid, key) {
				
				/* callback 기초 데이터 */
				var item = $('#itemTbl').dzt('getValue');
				
				
				switch (key){
					/* 금액 자동 계산 */
					case 'unitAmt' :
					case 'itemCnt' :
						var items = $('#itemTbl').dzt('getValueAll');
						for(var i=0;i<items.length;i++){
							if(!items[i].itemName){
								items.splice(i,1);
							}
						}
						var totalItemCnt = 0;
						var totalItemAmt = 0;
						var totalUnitAmt = 0;
						
						try{
							var itemCnt = parseFloat( item.itemCnt.replace(/[^-0-9]/gi, ''));
							var unitAmt = parseFloat( item.unitAmt.replace(/[^-0-9]/gi, ''));
							var itemAmt = ( (itemCnt * unitAmt) || '0').toString().split('.')[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") ; 
							var uid = $('#itemTbl').dzt('getUID');
							$('#itemTbl').dzt('setValue', uid, {
								itemAmt : itemAmt
								, unitAmt : (unitAmt||'0').toString().split('.')[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")
							}, false);
							
							for(var i=0;i<items.length;i++){
								totalItemCnt = parseInt(totalItemCnt) + parseInt(items[i].itemCnt.replace(/,/g, ''));
								totalUnitAmt = parseInt(totalUnitAmt) + parseInt(items[i].unitAmt.replace(/,/g, ''));
								totalItemAmt = parseInt(totalItemAmt) + parseInt(items[i].itemAmt.replace(/,/g, ''));
							}
							
							$('#itemCnt').html(totalItemCnt.toString().split('.')[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","));
							$('#unitAmt').html(totalUnitAmt.toString().split('.')[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","));
							$('#itemAmt').html(totalItemAmt.toString().split('.')[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","));
						}catch(e){
							$('#itemTbl').dzt('setValue', uid, {
								itemAmt : '0'
							}, false);
						}
						break;
					case 'itemName' :

						break;
					
				};
				
				return true;
			},
			/* 테이블 컬럼 정보 */
			columns : itemColumns
		});

		return;
	}
    
	/* ## 결재작성 ## */
	/* ====================================================================================================================================================== */
	function fnEventApproval() {

		/* [ parameter ] */
		var parameter = {};
		var url;

 		parameter.consDocSeq = ${params.consDocSeq}+'';
		parameter.consSeq = ${params.consSeq}+'';
		parameter.resDocSeq = ${params.resDocSeq}+'';
		parameter.resSeq = ${params.resSeq}+'';
		parameter.budgetSeq = ${params.budgetSeq}+'';
		
		if(!!parameter.resDocSeq){
			url = '/ex/np/user/res/ResItemSpecInsert.do';
		}
		else{
			url = '/ex/np/user/cons/ConsItemSpecInsert.do';
		}
	
		var itemData = $('#itemTbl').dzt('getValueAll');
		for(var i=0;i<itemData.length;i++){
			if(!itemData[i].itemName){
				itemData.splice(i,1);
			}
		}
		
		for(var i=0;i<itemData.length;i++){
			itemData[i].itemAmt = (itemData[i].itemAmt.replace(/,/g, '')||0);
			itemData[i].unitAmt = (itemData[i].unitAmt.replace(/,/g, '')||0);
		}
		
		
		parameter.innerData = JSON.stringify(itemData);
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + url,
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : parameter,
			/*   - success :  */
			success : function(result) {
				

				if (result.result.resultCode === 'SUCCESS') {
					window.close();
					returnObj = result.result.aaData;
					window.opener.fnCallbackItemSpec(returnObj);
				}
				 else {
					alert("물품명세 저장에 실패하였습니다.");
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}
	
	function fnSelectItemSpec(){
		/* [ parameter ] */
		var parameter = {};
		var url;
		
 		parameter.consDocSeq = ${params.consDocSeq}+'';
		parameter.consSeq = ${params.consSeq}+'';
		parameter.resDocSeq = ${params.resDocSeq}+'';
		parameter.resSeq = ${params.resSeq}+'';
		parameter.budgetSeq = ${params.budgetSeq}+'';
		
		if(!!parameter.resDocSeq){
			url = '/ex/np/user/res/ResItemSpecSelect.do';
		}
		else{
			url = '/ex/np/user/cons/ConsItemSpecSelect.do';
		}
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + url,
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : parameter,
			/*   - success :  */
			success : function(result) {
				if (result.result.resultCode === 'SUCCESS') {
					var aaData = result.result.aaData;
					if(aaData.length == '0'){
						return;
					}
					else{
						for(var i=0;i<aaData.length;i++){
							fnAddRow();
							var uid = $('#itemTbl').dzt('getUID');
							$('#itemTbl').dzt('setValue', uid,aaData[i], false);	
						}
						fnAddRow();
					}
					
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

</script>