<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
    $ ( document ).ready ( function ( ) {
        fnInit ( );
        $ ( "#btnSearch" ).click ( );
    } );

    /* 초기화 */
    function fnInit ( ) {
        fnInitLayout ( );
        fnInitMouseEvent ( );
        fnInitKeyEvent ( );
    }

    /* 레이아웃 초기화 */
    function fnInitLayout ( ) {
    }

    /* 마우스 이벤트 초기화 */
    function fnInitMouseEvent ( ) {
        /* 검색 클릭 */
        $ ( "#btnSearch" ).click ( function ( ) {
            fnCarListSelect ( );
        } );
    }

    /* 키 이벤트 초기화 */
    function fnInitKeyEvent ( ) {
        $("#searchKeyword").keydown(function (event) {
            console.log("### event.keyCode =>"+event.keyCode);
            if (event.keyCode === 13) {
                $("#btnSearch").click();
            }
        });
    }

    /* 차량 조회 */
    function fnCarListSelect ( ) {
        var param = {};
        param.searchKeyword = $("#searchKeyword").val ();

        $.ajax ( {
            type: 'post',
            url: '<c:url value="/bi/user/car/BiUserCarListSelect.do"/>',
            datatype: 'json',
            async: true,
            data: param,
            success: function ( data ) {
                /* 데이터 바인딩 */
                fnBindingData ( ( data.result || '{}' ) );
            },
            error: function ( data ) {
                return;
            }
        } );
    }
    /* 리스트 바인딩 */
    function fnBindingData ( result ) {

        // bStateSave: isInitPage,
        var data = ( result.aaData || '{}' );
        rowIdx = -1;

        $('#tblCarTable').dataTable( {
            "aaSorting": [],
            "fixedHeader" : true,
            "select" : true,
            "pageLength" : 10,
            // "sScrollY" : param.scrollY,
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
            },
            "columnDefs" : [ {
                "targets" : 0,
                "data" : null,
                "render" : function(data) {
                    var chkObj = $.extend(true, {}, data);
                    chkObj.appDocTitle = '';
                    // chkObj.appDocNo = '';
                    return "<input type='checkbox' name='inp_chk' id='inp_chk"
                        + (++rowIdx)
                        + "' class='k-checkbox tableChkBox' value='"
                        + JSON.stringify(chkObj)
                        + "'><label class='k-checkbox-label bdChk' for='inp_chk"
                        + (rowIdx) + "'></label>";
                }
            }],
            "aoColumns" : [ {
                "sTitle" : "<input type='checkbox' id='chkSel' name='checkAll' class='check2 k-checkbox' onClick='javascript:fnCheckBoxAllCheck();' title='전체선택' id='checkAll' /><label class='k-checkbox-label' for='chkSel'></label>",
                "bVisible" : true,
                "bSortable" : false,
                "sWidth" : "40px"
                
            },{
                "sTitle" : "코드",
                "mDataProp" : "carCode",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "30%",
                "sClass" : ""
            },{
                "sTitle" : "차량번호",
                "mDataProp" : "carNumber",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "%",
                "sClass" : ""
            },{
                "sTitle" : "차종",
                "mDataProp" : "carName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "30%",
                "sClass" : ""
            }]
        });
    }

    /* 체크박스 전체 선택 이벤트 */
    function fnCheckBoxAllCheck() {
        if ($("#chkSel").prop("checked")) {
            $("input[type=checkbox]").filter(".tableChkBox").not(":disabled")
                .prop("checked", true);
        } else {
            $("input[type=checkbox]").filter(".tableChkBox").not(":disabled")
                .prop("checked", false);
        }
    }

    /* 선택한 데이터 */
    function getCheckedData() {
        var chkSels = $("input[name=inp_chk]:checkbox:checked").map(
            function(idx) {
                return JSON.parse(this.value);
            }).get();

        return chkSels;
    }
    
    /* 부모창 데이터 전달 */
    function fnTransmitPopupData(){
        if( getCheckedData().length == 0) return alert("차량을 선택하세요.");
        opener.fnReceivePopupData(getCheckedData());        
    }
</script>

<div class="pop_wrap" style="width:400px;">
    <div class="pop_head">
        <h1>차량선택</h1>
    </div>

    <!-- 컨트롤박스 -->
    <div class="top_box">
        <dl>
            <dt>차량번호</dt>
            <dd><input id="searchKeyword" type="text" value="" style="width:150px;"/></dd>
            <dd><input type="button" id="btnSearch" value="검색" /></dd>
        </dl>
    </div>

    <div class="pop_con">
        <div class="com_ta2">
            <table id="tblCarTable">
            </table>
        </div>
    </div><!--// pop_con -->
    <div class="pop_foot">
        <div class="btn_cen pt12">
            <input type="button" id="btnSubmit" value="확인" onclick="fnTransmitPopupData();"/>
            <input type="button" id="btnCancel" class="gray_btn" value="취소" onclick="javascript:window.close();"/>
        </div>
    </div><!-- //pop_foot -->

</div><!--// pop_wrap -->
