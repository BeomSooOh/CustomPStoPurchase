<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
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
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>

<script>
    /* 변수정의 */
    var baseUrl = '<c:url value="/" />';
    var ifSystem = '';

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigVatTypeInit();
        fnConfigVatTypeInitEvent();
        $('#btnConfigVatTypeSearch').click();
        return;
    });

    /* 초기화 */
    function fnConfigVatTypeInit() {
        $('button').kendoButton(); /* 켄도버튼정의 */
        setComboBox($('#selCompany'), JSON.parse('${ViewBag.compListInfo}'), function() {
            $('#btnConfigVatTypeSearch').click();
        });/* 회사설정 */
        setComboBox($('#selUsed'), JSON.parse('${ViewBag.commonCodeListUseYN}'));/* 사용여부 */
        return;
    }

    /* 이벤트 초기화 */
    function fnConfigVatTypeInitEvent() {
        /* 변수정의 */
        var param = {};
        /* 조회 */
        $('#btnConfigVatTypeSearch').click(function() {
            fnConfigVatTypeSearch();
        });
        /* 신규 */
        $('#btnConfigVatTypeNew').click(function() {
            fnConfigVatTypeNew();
        });
        /* 저장 */
        $('#btnConfigVatTypeSave').click(function() {
            fnConfigVatTypeSave();
        });
        /* 삭제 */
        $('#btnConfigVatTypeDelete').click(function() {
            fnConfigVatTypeDelete();
        });
        return;
    }

    /* 버튼클릭 이벤트 - 조회 */
    function fnConfigVatTypeSearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
        param.comp_seq = $('#selCompany').val();
        param.search_str = "";
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/VatTypeListInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 연동정보 저장 */
                ifSystem = data.ifSystem;
                $('#btnConfigVatTypeNew').click();

                var checkbox = false;
                if (ifSystem == 'BizboxA') {
                    checkbox = true;
                } else {
                    checkbox = false;
                }

                /* 테이블바인딩 */
                $('#divConfigVatTypeList').empty();
                $('#divConfigVatTypeList').append('<table id="tblConfigVatTypeList"></table>');

                $('#tblConfigVatTypeList').dataTable({
                    "fixedHeader" : true,
                    "select" : true,
                    "pageLength" : 7,
                    "bAutoWidth" : false,
                    "destroy" : true,
                    "language" : {
                        "lengthMenu" : "보기 _MENU_",
                        "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                        "info" : "_PAGE_ / _PAGES_",
                        "infoEmpty" : " ",
                        "infoFiltered" : "(전체 _MAX_ 중.)"
                    },
                    "data" : data.aaData,
                    "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                        $(nRow).css("cursor", "pointer");
                        $(nRow).on("click", (function() {
                            fnConfigVatTypeInitEventSelect_Row(aData);
                        }));
                    },
                    columnDefs : [ /* {
                                                              "targets" : 0,
                                                              "data" : null,
                                                              "render" : function( aData ) {
                                                                  if (data != null && data != "") {
                                                                      return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.compSeq + '|' + aData.vat_type_code + '" value="' + aData.compSeq + '|' + aData.vat_type_code + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_chk' + aData.compSeq + '|' + aData.vat_type_code + '"></label>';
                                                                  } else {
                                                                      return "";
                                                                  }
                                                              }
                                                          }, */{
                        "targets" : 2,
                        "data" : "use_yn",
                        "render" : function( data ) {
                            if (data != null && data != '') {
                                if (data == 'Y') {
                                    return "<%=BizboxAMessage.getMessage("TX000002850","예")%>";
                                } else {
                                    return "<%=BizboxAMessage.getMessage("TX000006217","아니오")%>";
                                }
                            } else {
                                return '';
                            }
                        }
                    } ],
                    aoColumns : [ /* {
                                                              "sTitle" : "<input type='checkbox' id='chk' name='inp_chk' onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>",
                                                              "bSearchable" : false,
                                                              "bSortable" : false,
                                                              "sWidth" : "34",
                                                              "sClass" : "center"
                                                          }, */{
                        "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","코드")%>",
                        "mDataProp" : "vat_type_code",
                        "bVisible" : true,
                        "bSortable" : true,
                        "sWidth" : ""
                    }, {
                        "sTitle" : "<%=BizboxAMessage.getMessage("TX000000209","코드명")%>",
                        "mDataProp" : "vat_type_name",
                        "bVisible" : true,
                        "bSortable" : true,
                        "sWidth" : ""
                    }, {
                        "sTitle" : "<%=BizboxAMessage.getMessage("TX000000028","사용여부")%>",
                        "bVisible" : true,
                        "bSortable" : true,
                        "sWidth" : ""
                    } ]
                });
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 신규 */
    function fnConfigVatTypeNew() {
        $('#txtVatTypeCode').val(''); /* 계정과목 코드 */
        $('#txtVatTypeName').val(''); /* 계정과목 명칭 */
        var combobox = $('#selUsed').data('kendoComboBox');
        combobox.value('Y');
        combobox.trigger("change"); /* 사용여부 */

        if (ifSystem == 'BizboxA') {
            $('#txtVatTypeCode').removeAttr('disabled', 'disabled'); /* 선택시, 코드 변경이 가능하도록 처리 */
            $('#txtVatTypeName').removeAttr('disabled', 'disabled'); /* 선택시, 명칭 변경이 가능하도록 처리 */
            combobox = $('#selUsed').data('kendoComboBox');
            combobox.enable(true); /* 선택시, 사용여부 변경이 가능하도록 처리 */

            // 버튼표현 처리
            $('#btnConfigVatTypeSearch').hide(); /* 조회 안보임 */
            $('#btnConfigVatTypeNew').show(); /* 신규 보임 */
            $('#btnConfigVatTypeSave').show(); /* 저장 보임 */
            $('#btnConfigVatTypeDelete').show(); /* 삭제 보임 */

            // 수정기능
            $('.com_ta').show(); /* 보임 */
        } else {
            $('#txtVatTypeCode').attr('disabled', 'disabled'); /* 선택시, 코드 변경이 불가능하도록 처리 */
            $('#txtVatTypeName').attr('disabled', 'disabled'); /* 선택시, 명칭 변경이 불가능하도록 처리 */
            combobox = $('#selUsed').data('kendoComboBox');
            combobox.enable(false); /* 선택시, 사용여부 변경이 불가능하도록 처리 */

            // 버튼표현 처리
            $('#btnConfigVatTypeSearch').hide(); /* 조회 안보임 */
            $('#btnConfigVatTypeNew').hide(); /* 신규 안보임 */
            $('#btnConfigVatTypeSave').hide(); /* 저장 안보임 */
            $('#btnConfigVatTypeDelete').hide(); /* 삭제 안보임 */

            // 수정기능
            $('.com_ta').hide(); /* 안보임 */
        }
        return;
    }
    /* 버튼클릭 이벤트 - 저장 */
    function fnConfigVatTypeSave() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
        param.comp_seq = $('#selCompany').val();
        param.vat_type_code = $('#txtVatTypeCode').val();
        param.vat_type_name = $('#txtVatTypeName').val();
        param.use_yn = $('#selUsed').val();

        /* 호출 URL 정의 */
        var url = '';
        var attr = $('#txtVatTypeCode').attr('disabled');
        if (typeof attr !== typeof undefined && attr !== false) {
            url = '<c:url value="/ex/code/vat/ExCodeVatTypeInfoUpdate.do" />';
        } else {
            url = '<c:url value="/ex/code/vat/ExCodeVatTypeInfoInsert.do" />';
        }

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                $('#btnConfigVatTypeSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 삭제 */
    function fnConfigVatTypeDelete() {
        if (!confirm("<%=BizboxAMessage.getMessage("TX000007261","삭제된 내용은 복구할 수 없습니다. 삭제를 진행하시겠습니까?")%>")) { return; }
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
        param.comp_seq = $('#selCompany').val();
        param.vat_type_code = $('#txtVatTypeCode').val();
        param.vat_type_name = $('#txtVatTypeName').val();
        param.use_yn = $('#selUsed').val();
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/code/vat/ExCodeVatTypeInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                $('#btnConfigVatTypeSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 행클릭 이벤트 */
    function fnConfigVatTypeInitEventSelect_Row( data ) {
        $('#txtVatTypeCode').val(data.vat_type_code); /* 계정과목 코드 */
        $('#txtVatTypeName').val(data.vat_type_name); /* 계정과목 명칭 */
        /* http://docs.telerik.com/kendo-ui/api/javascript/ui/combobox */
        var combobox = $('#selUsed').data('kendoComboBox');
        combobox.value(data.use_yn);
        combobox.trigger("change"); /* 사용여부 */

        if (ifSystem == 'BizboxA') {
            $('#txtVatTypeCode').attr('disabled', 'disabled'); /* 선택시, 코드 변경이 불가능하도록 처리 */
        } else {
            $('#txtVatTypeCode').attr('disabled', 'disabled'); /* 선택시, 코드 변경이 불가능하도록 처리 */
            $('#txtVatTypeName').attr('disabled', 'disabled'); /* 선택시, 명칭 변경이 불가능하도록 처리 */
            combobox = $('#selUsed').data('kendoComboBox');
            combobox.enable(false); /* 선택시, 사용여부 변경이 불가능하도록 처리 */
        }
        return;
    }
</script>

<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt>
			<dd>
				<div class="dod_search">
					<input type="text" id="selCompany" class="kendoComboBox" style="width: 200px;" />
				</div>
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn">
		<button id="btnConfigVatTypeSearch" class="k-button"><%=BizboxAMessage.getMessage("TX000000899","조회")%></button>
		<button id="btnConfigVatTypeNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
		<button id="btnConfigVatTypeSave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
		<button id="btnConfigVatTypeDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
	</div>

	<div id="divConfigVatTypeList" class="com_ta2">
		<table id="tblConfigVatTypeList"></table>
	</div>

	<div class="com_ta mt20">
		<table>
			<colgroup>
				<col width="140" />
				<col width="" />
				<col width="140" />
				<col width="" />
				<col width="140" />
				<col width="" />
			</colgroup>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000045","코드")%></th>
				<td>
					<input type="text" style="width: 90%" id="txtVatTypeCode" />
				</td>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000209","코드명")%></th>
				<td>
					<input type="text" style="width: 90%" id="txtVatTypeName" />
				</td>
				<th><%=BizboxAMessage.getMessage("TX000000028","사용여부")%></th>
				<td>
					<input id="selUsed" style="width: 90%" />
				</td>
			</tr>
		</table>

	</div>
</div>
<!-- //sub_contents_wrap -->