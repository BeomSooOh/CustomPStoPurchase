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

    /* 지출결의 - 항목 분개 관리항목 */
    var expendMng = new kendo.data.ObservableObject(ExExpendMng);
    expendMng.bind('change', function( e ) {
        if (e.field == 'mng_name' || e.field == 'mng_code') {
            if (this.get('mng_name') != '' && this.get('mng_code') != '') {
                $('#tdMngName').html('[' + this.get('mng_code') + '] ' + this.get('mng_name'));
            }
        }

        if (e.field == 'ctd_code') {
            $('#txtCtdCode').val(this.get('ctd_code'));
        }

        if (e.field == 'ctd_name' || e.field == 'mng_form_code') {
            if (this.get('ctd_name') != '' && this.get('mng_form_code') != '') {
                var ctdName = this.get('ctd_name');

                switch (this.get('mng_form_code')) {
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
                        ctdName = ctdName.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        $('#txtCtdName').val(ctdName);
                        break;
                    default:
                        $('#txtCtdName').val(ctdName);
                        break;
                }
            } else {
                $('#txtCtdName').val('');
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
        fnCopyToBOservalbe(JSON.parse('${ViewBag.mngInfo}'), expendMng);
        fnExpendMngLayout();
        return;
    }

    /* 초기화 - layout */
    function fnExpendMngLayout() {
        if (expendMng.get('mng_child_yn') != 'Y') {
            $('#divMngSearch').hide();
            $('#divMngDList').hide();
        }

        switch (expendMng.get('mng_form_code')) {
            case "1": /* ( ERPiU : 날짜 / iCUBE : ) */
                $("#txtCtdName").kendoDatePicker({
                    culture : "ko-KR",
                    format : "yyyy-MM-dd",
                    change : function() {
                        expendMng.set('ctd_code', (this._oldText).toString().replace(/-/g, ''));
                        expendMng.set('ctd_name', (this._oldText).toString().replace(/-/g, ''));
                    }
                });
                var datePicker = $("#txtCtdName");
                datePicker.kendoMaskedTextBox({
                    mask : '0000-00-00'
                });
                datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');

                $('#txtCtdName').focus();
                break
            case "2": /* ( ERPiU : 금액 / iCUBE : ) */
            case "3": /* ( ERPiU : 수량 / iCUBE : ) */
            case "4": /* ( ERPiU : 율(%) / iCUBE : ) */
                $('#txtCtdName').maskMoney({
                    precision : 0
                });

                $('#txtCtdName').bind('keypress', function( event ) {
                    expendMng.set('ctd_code', ($(this).val()).replace(/,/g, ''));
                    expendMng.set('ctd_name', ($(this).val()).replace(/,/g, ''));
                })

                $('#txtCtdName').focus();
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
        param.comp_seq = '${mngVo.comp_seq}';
        param.form_seq = '${mngVo.form_seq}';
        param.search_str = $('#txtMngSearchStr').val();
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/mng/ExCodeMngDListInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                fnExpendMngDDatatableBind(data.aaData || '');

                if (data.aaData.length == 1) {
                	
                	var tmp1 = "<%=BizboxAMessage.getMessage("TX000009625","검색결과가 {0}건입니다 반영하시겠습니까?")%>";
                	tmp1 = tmp1.replace("{0}","1");
                	
                    if (confirm(tmp1)) {
                        expendMng.set('ctd_code', data.aaData[0].ctd_code);
                        expendMng.set('ctd_name', data.aaData[0].ctd_name);
                        $('#btnMngSave').click();
                    }
                }

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
        $.extend(param, expendMng.toJSON());
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/mng/ExMngInfoUpdate.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                window['${mngVo.callback}']();
            },
            error : function( data ) {
                console.log("! [EX][FNEXPENDMNGINFOUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 이벤트 - 버튼 - 취소 */
    function fnExpendMngPopClose() {
        //alert('[fnExpendMngPopClose]서비스 준비중입니다.');
        layerPopClose('');
        return;
    }

    /* 검색결과 테이블 반영 */
    function fnExpendMngDDatatableBind( source ) {
        source = (source || {});

        $('#tblMngDList').dataTable({
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
                    expendMng.set('ctd_code', aData.ctd_code);
                    expendMng.set('ctd_name', aData.ctd_name);
                }));
                $(nRow).on('dblclick', (function() {
                    expendMng.set('ctd_code', aData.ctd_code);
                    expendMng.set('ctd_name', aData.ctd_name);
                    $('#btnMngSave').click();
                }));
                return nRow;
            },
            "aoColumns" : [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","코드")%>",
                "mDataProp" : "ctd_code",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
                "mDataProp" : "ctd_name",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            } ]
        });
        return;
    }
</script>

<div class="pop_wrap_dir" id="layerExpendMng">
	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div id="divMngSearch" class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000399","검색어")%></dt>
				<dd>
					<input id="txtMngSearchStr" type="text" style="width: 200px;" value="" />
				</dd>
				<dd>
					<input id="btnMngSearch" type="button" id="" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" />
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
					<th><%=BizboxAMessage.getMessage("TX000002703","관리항목")%></th>
					<td id="tdMngName"></td>
				</tr>
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000000045","코드")%>/<%=BizboxAMessage.getMessage("TX000000878","명")%></th>
					<td>
						<input id="txtCtdCode" type="text" style="width: 30%;" /> <input id="txtCtdName" type="text" style="width: 60%;" />
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
			<input id="btnMngSave" type="button" value="<%=BizboxAMessage.getMessage("TX000000078","확인")%>" /> <input id="btnMngClose" type="button" class="gray_btn" value="<%=BizboxAMessage.getMessage("TX000002947","취소")%>" />
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->