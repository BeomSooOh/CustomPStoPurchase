<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEx.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>

<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';
    /* iCUBE의 사용자 정의 관리항목 여부 */
	var isCustMng = false;
    
    /* 소수점 들어가는 관리항목 Array */
	var arrDotNum = ['B25', 'B26', 'D08'];
    
    var manageMent = ['H','I','J'];
    
    /* 지출결의 - 항목 분개 관리항목 */
    var expendMng = new kendo.data.ObservableObject(ExExpendMng);
    expendMng.bind('change', function( e ) {
        if (e.field == 'mngName' || e.field == 'mngCode') {
            if (this.get('mngName') != '' && this.get('mngCode') != '') {
                $('#tdMngName').html('[' + this.get('mngCode') + '] ' + this.get('mngName'));
            }
        }

        if (e.field == 'ctdCode') {
            $('#txtCtdCode').val(this.get('ctdCode'));
        }

        if (e.field == 'ctdName' || e.field == 'mngFormCode') {
            if (this.get('ctdName') != '' && this.get('mngFormCode') != '') {
                var ctdName = this.get('ctdName');

                switch (this.get('mngFormCode')) {
                    case "0": /* ( ERPiU : 일반 / iCUBE : ) */
                        $('#txtCtdName').val(ctdName);
                        break;
                    case "1": /* ( ERPiU : 날짜 / iCUBE : ) */
                        ctdName = [ ctdName.substring(0, 4), ctdName.substring(4, 6), ctdName.substring(6, 8) ].join('-');
                        $('#txtCtdName').val(ctdName);
                        break;
                    case "2": /* ( ERPiU : 금액 / iCUBE : ) */
                    case "3": /* ( ERPiU : 수량 / iCUBE : ) */
                    case "4": /* ( ERPiU : 율(%) / iCUBE : ) */
                    case "6": /* ( ERPiU : 환율(%) / iCUBE : ) */
                    	/* 2018-02-20 / 김상겸 / ERPiU 환율 예외처리 / 정규식 미적용 */
                    	/* 2018-03-15 / 신재호 / this.get()에러 발생으로 인하여 expendMng로 변경 및 소수점 입력 시 자리수 구분 오류 수정 */
						if (arrDotNum.indexOf((expendMng.get('mngCode') || '').toString()) > -1 ) {
							/* ERPiU - 환율 */
							if(ctdName.indexOf('.') > -1){
								var sp1 = ctdName.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",").split('.');
								var underDot = sp1[1].replace(/\,/g,'');
// 								if(underDot.length > 3){
// 									underDot = underDot.substr(0,3)
// 								}
								ctdName = sp1[0] + '.' + underDot;
							}else{
								ctdName = ctdName.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
							}
						} else {
                        	ctdName = ctdName.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						}
                        $('#txtCtdName').val(ctdName);
                        break;
                    default:
                        $('#txtCtdName').val(ctdName);
                        break;
                }
            } else {
                $('#txtCtdName').val(this.get('ctdName'));
            }
        }
    });

    /* 문서로드 */
    $(document).ready(function() {
        fnExpendMngInit();
        fnExpendMngEventInit();
        $('#btnMngSearch').click();
    });

    /* 초기화 */
    function fnExpendMngInit() {
//         fnCopyToBOservalbe(JSON.parse(fnConvertSpecialCharater('${ViewBag.mngInfo}')), expendMng);
		<c:if test = "${ViewBag.mngInfo ne '' && ViewBag.mngInfo ne null}">
        	fnCopyToBOservalbe(${ViewBag.mngInfo}, expendMng);
        </c:if>
        $("#txtMngSearchStr").val(expendMng.searchStr);
        if( ifSystem === 'iCUBE'){
        	if( (expendMng.mngCode =="F1" || expendMng.mngCode =="F2" || expendMng.mngCode =="F3"
			|| expendMng.mngCode =="G1" || expendMng.mngCode =="G2" || expendMng.mngCode =="G3")){
        		expendMng.set('mngFormCode','1');
        	}
        	if( expendMng.mngCode == 'C1' || expendMng.mngCode == 'D4'){
        		$('#txtCtdCode').prop('disabled',true);
        		$('#txtCtdName').prop('disabled',true);
        	}
        	/*iCUBE 연동타입에 따른 숫자입력 도움창 개발 2019. 05. 16 - 이준성 */ 
            if(manageMent.indexOf(expendMng.mngCode.substring(0,1).toUpperCase()) != -1 ){   
            	$('#txtCtdCode').prop('disabled',true);
            
            	var validCheck = {
            		    keyDown : function (e) {
            		        var key;
            		        if(window.event)
            		            key = window.event.keyCode; //IE
            		        else
            		            key = e.which; //firefox
            		        var event;
            		        if (key == 0 || key == 8 || key == 46 || key == 9){
            		            event = e || window.event;
            		            if (typeof event.stopPropagation != "undefined") {
            		                event.stopPropagation();
            		            } else {
            		                event.cancelBubble = true;
            		            }   
            		            return;
            		        }
            		        if (key < 48 || (key > 57 && key < 96) || key > 105 || e.shiftKey) {
            		            e.preventDefault ? e.preventDefault() : e.returnValue = false;
            		        }
            		    },        
            		    keyUp : function (e) {
            		        var key;
            		        if(window.event)
            		            key = window.event.keyCode; //IE
            		        else
            		            key = e.which; //firefox
            		        var event;
            		        event = e || window.event;        
            		        if ( key == 8 || key == 46 || key == 37 || key == 39 ) 
            		            return;
            		        else
            		            event.target.value = event.target.value.replace(/[^0-9]/g, "");
            		    },
            		    focusOut : function (ele) {
            		        ele.val(ele.val().replace(/[^0-9]/g, ""));
            		    }
            		};
            	 
            	$('#txtCtdName').css("ime-mode", "disabled").keydown( function(e) {
            	    validCheck.keyDown(e);
            	}).keyup( function(e){
            	    validCheck.keyUp(e);
            	    $('#txtCtdCode').val($('#txtCtdName').val().replace(/[^0-9]/g,'')); 
            	}).focusout( function(e){        
            	    validCheck.focusOut($(this));
            	});
            
        	}

	       }
        fnExpendMngLayout();
        return;
    }
    /* 초기화 - layout */
    function fnExpendMngLayout() {
        switch (expendMng.get('mngFormCode')) {
	    	case "0": /* ERPiU : 일반 */
	    		if(ifSystem =='ERPiU') {
			        if (expendMng.get('mngChildYN') != 'Y') {
			        	// 하위코드 없는 경우 텍스트 입력 기능 요구 접수 ( 2019-01-02 )
			        	// ERPiU : 한연옥 차장 요구, Bizbox Alpha : 이훈 수석, 이억대 대리 요구
			        	// 김상겸 지원 ( 2019-01-03 )
			        	// ERPiU 관리항목 설정에서 FI_MNG.YN_CDMNG >> N(NO), FI_MNG.TP_MNGFORM >> 0(일반) 설정 시 텍스트 입력
			        	// 하위코드를 설정하여도 위 설정에 따라서 텍스트 입력으로 바뀜 ( 코드 조회가 안되요! 라고 발생되는 문제점은 ERP 설정 변경으로 대응 안내 필요 )
			        	// 관리항목 하위코드가 조회 안되요! >> 관리항목 설정에서 코드부여값을 YES로 설정해주세요!
			        	
			        	// 하위코드 미사용인 경우만 해당
						$('#divMngSearch').hide();
						$('#divMngDList').hide();
	
			            $('#txtCtdName').bind('keyup', function( event ) {
							expendMng.set('ctdCode', ($(this).val()).replace(/,/g, ''));
			                expendMng.set('ctdName', ($(this).val()).replace(/,/g, ''));
			            });
	
			            $('#txtCtdName').focus();
			        }
	        	}
	    		break;
            case "1": /* ( ERPiU : 날짜 / iCUBE : ) */
                $("#txtCtdName").kendoDatePicker({
                    culture : "ko-KR",
                    format : "yyyy-MM-dd",
                    change : function() {
                        expendMng.set('ctdCode', (this._oldText).toString().replace(/-/g, ''));
                        expendMng.set('ctdName', (this._oldText).toString().replace(/-/g, ''));
                    }
                });
                var datePicker = $("#txtCtdName");
                datePicker.kendoMaskedTextBox({
                    mask : '0000-00-00'
                });
                datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');

                $('#txtCtdName').focus();
                $('#divMngSearch').hide();
                break
            case "2": /* ( ERPiU : 금액 / iCUBE : ) */
            case "3": /* ( ERPiU : 수량 / iCUBE : ) */
            case "4": /* ( ERPiU : 율(%) / iCUBE : ) */
            case "6": /* ( ERPiU : 환율(%) / iCUBE : ) */
            	/* 2018-02-20 / 김상겸 / ERPiU 환율 예외처리 / 정규식 미적용 */
            	/* 2018-03-15 / 신재호 / this.get()에러 발생으로 인하여 expendMng로 변경 */
				if (arrDotNum.indexOf((expendMng.get('mngCode') || '').toString()) === -1 ) {
					// 소수점이 들어가지 않는 경우에 실행 
					$('#txtCtdName').maskMoney({
						precision : 0
					});
				}

                $('#txtCtdName').bind('keypress', function( event ) {
                    expendMng.set('ctdCode', ($(this).val()).replace(/,/g, ''));
                    expendMng.set('ctdName', ($(this).val()).replace(/,/g, ''));
                });
                $('#txtCtdName').bind('keyup', function( event ) {
                	if (arrDotNum.indexOf((expendMng.get('mngCode') || '').toString()) > -1 ) {
						if($(this).val().indexOf('.') > -1 && $(this).val().split('.')[1].replace(/\,/g,'').length > 4){
                			var newVal = $(this).val().split('.')[0] + '.' + $(this).val().split('.')[1].replace(/\,/g,'').substr(0,4);
                			expendMng.set('ctdCode', newVal.replace(/,/g, ''));
                            expendMng.set('ctdName', newVal.replace(/,/g, ''));
                            $("#txtCtdName").val(newVal);
                		}else{
                			expendMng.set('ctdCode', ($(this).val()).replace(/,/g, ''));
                            expendMng.set('ctdName', ($(this).val()).replace(/,/g, ''));	
                		}
                	}
                });

                $('#txtCtdName').focus();
                $('#divMngSearch').hide();
                break;
        }
    }

    /* 이벤트 초기화 */
    function fnExpendMngEventInit() {
        /* 검색 */
        $('#btnMngSearch').click(function() {
            fnExpendMngDListInfoSelect();
            $('#txtMngSearchStr').focus();
        });
        $('#txtMngSearchStr').bind('keypress', function( event ) {
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13) {
                $('#btnMngSearch').click();
            }
            return;
        });
        /* 확인 */
        $('#btnMngSave').click(function() {
            fnExpendMngInfoUpdate(); /* 저장 */
        });
        /* 취소 */
        $('#btnMngClose').click(function() {
            fnExpendMngPopClose(); /* 취소 */
        });
        return;
    }

    /* 이벤트 - 관리항목 하위코드 조회 */
    function fnExpendMngDListInfoSelect() {
        /* parameter : ExExpendMngVO */
        /* 변수정의 */
        var param = {};
        $.extend(param, expendMng.toJSON());
        param.compSeq = '${mngVo.compSeq}';
        param.formSeq = '${mngVo.formSeq}';
        param.searchStr = $('#txtMngSearchStr').val();
        /* ERPiU 거래처계좌번호 예외처리(선택된 거래처의 계좌번호만 조회되도록) */
        if(expendMng.mngCode == 'C15'){
        	/* MngVo에 별도 변수 추가하지 않고 callback에 임시로 저장  */
        	param.callback = slipPartnerCodeInfo.partnerCd;
        }
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/mng/ExCodeMngDListInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	if (data.aaData.length == 1 && reflectResultPop) {
				    expendMng.set('ctdCode', data.aaData[0].ctdCode);
				    expendMng.set('ctdName', data.aaData[0].ctdName);
				    $('#btnMngSave').click();
				}
            	if(data.exExpendMngVO.mngCode.indexOf('M')!= -1){
            		isCustMng = true;
            	}
                fnExpendMngDDatatableBind(data.aaData || '');
                return; 
            },
            error : function( data ) {
                console.log("! [EX][FNEXPENDMNGDLISTINFOSELECT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }


    
    /* 이벤트 - 버튼 - 저장 */
    function fnExpendMngInfoUpdate() {
        /* 변수정의 */
        var param = {};
        /* ERPiU의 00거래처는 사용자가 거래처 명 입력 가능 2018. 03. 29 - 신재호 */
        if(ifSystem =='ERPiU' && expendMng.mngCode == 'A06' && expendMng.ctdCode == '00'){
        	expendMng.ctdName = $("#txtCtdName").val(); 
        }
        
        /*iCUBE 연동타입에 따른 숫자입력 도움창 개발 2019. 05. 16 - 이준성 */ 
        if(ifSystem =='iCUBE' && manageMent.indexOf(expendMng.mngCode.substring(0,1).toUpperCase()) != -1 ){
        	
        	expendMng.ctdCode = $("#txtCtdName").val().replace(/[^0-9]/g,'');
        	expendMng.ctdName = $("#txtCtdName").val();  
        }
        
        
        $.extend(param, expendMng.toJSON());
        param.formInfo = JSON.stringify(formInfo);
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/mng/ExMngInfoUpdate.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                window['${mngVo.callback}'](data.exExpendMngVO);
            },
            error : function( data ) {
                console.log("! [EX][FNEXPENDMNGINFOUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 이벤트 - 버튼 - 취소 */
    function fnExpendMngPopClose() {
        //layerPopClose('');
		fnExCloseLayPop();
        return;
    }

    /* 검색결과 테이블 반영 */
    function fnExpendMngDDatatableBind( source ) {
        source = (source || {});
        oTable = $('#tblMngDList').dataTable({
            /* "fixedHeader" : true, */
            "select" : true,
            "pageLength" : 7,
            "sScrollY" : "260px",
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000001063","데이터가 없습니다.")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000001063","데이터가 없습니다.")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	if( expendMng.mngCode == 'C1' || expendMng.mngCode == 'D4'){
                		return false;
                	}
                	expendMng.set('ctdCode', aData.ctdCode);
                    expendMng.set('ctdName', aData.ctdName);
                }));
                $(nRow).on('dblclick', (function() {
                	if( expendMng.mngCode == 'C1' || expendMng.mngCode == 'D4'){
                		return false;
                	}
                    expendMng.set('ctdCode', aData.ctdCode);
                    expendMng.set('ctdName', aData.ctdName);
                    $('#btnMngSave').click();
                }));
                return nRow;
            },
            columnDefs : [ {
    			"targets" : 1,
    			"data" : null,
    			"render"  : function(data) {
    				if(ifSystem === 'ERPiU'){
	    				/* ERPiU 관리항목이 거래처인 경우 사업자 등록번호 표시 */
						/* 2017-11-24 팀장님 승인(kukjetrust), 2017-11-26 구현 */
	    				if(expendMng.get("mngCode").toString() === 'A06'){
	    					if((data.subDummy1 || '') !== ''){
	    						if(data.subDummy1.length === 10){
	    							return data.ctdName + ' (' + data.subDummy1.toString().replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3') + ')';
	    						} else {
	    							return data.ctdName + ' (' + data.subDummy1 + ')';
	    						}
	    					} else {
	    						return data.ctdName;
	    					}
	    				} else {
	    					return data.ctdName;
	    				}
    				} else {
    					return data.ctdName;
    				}
    			}
    		} ],
            "aoColumns" : [ {
                "sTitle" : "${CL.ex_code}",
                "mDataProp" : "ctdCode",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_name}",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            } ]
        });
        
        /* 검색 이벤트  iCUBE인 경우에 사용자 정의 관리항목인 경우만 진행*/
        if(ifSystem === 'iCUBE' && isCustMng){
        	$('#tblMngDList').DataTable().search(
       			$('#txtMngSearchStr').val()
       		).draw();	
        }
		
        return;
    }
</script>

<div class="pop_wrap_dir pop_wrap_dir_expend" style = "position:fixed;"  id="layerExpendMng">
	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div id="divMngSearch" class="top_box">
			<dl>
				<dt>${CL.ex_keyWord}</dt>
				<dd>
					<input id="txtMngSearchStr" type="text" style="width: 200px;" value="" />
				</dd>
				<dd>
					<div class="controll_btn p0">
						 <button id="btnMngSearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>
				
			</dl>
		</div>

		<!-- 관리항목, 코드명 -->
		<div class="com_ta mt14">
			<table>
				<colgroup>
					<col width="25%" />
					<col width="" />
				</colgroup>
				<tr>
					<th>${CL.ex_controlProvision}</th>
					<td id="tdMngName"></td>
				</tr>
				<tr>
					<th>${CL.ex_code}/${CL.ex_name}</th>
					<td>
						<input id="txtCtdCode" readonly="readonly" type="text" style="width: 30%;" /> 
						<input id="txtCtdName" type="text" style="width: 60%;" />
					</td>
				</tr>
			</table>
		</div>

		<!-- 테이블 -->
		<div id="divMngDList" class="com_ta2 mt14" style="height: 333px;">
			<table id="tblMngDList">
			</table>
		</div>


	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<button id="btnMngSave">${CL.ex_check}</button> 
   			<button id="btnMngClose" class="gray_btn">${CL.ex_cancel}</button>
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->