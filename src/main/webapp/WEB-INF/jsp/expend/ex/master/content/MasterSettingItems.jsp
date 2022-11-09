<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/jquery.tablednd.js"></c:url>'></script>



<script>
    $(document).ready(function() {
        //fnGetACompanyInfo();//회사코드
        $("#tabstrip").kendoTabStrip({
            animation : {
                open : {
                    effects : ""
                }
            }
        });
        fnInit();
        fnReg();
        //$('#flip-navigation li a:eq(0)').click();
    });

    //초기화
    function fnDisplayReset() {
        $("#hdnAddItemList").val("");
        $("#hdnSelectItemList").val("");
        $("#DataTableSlipInfoGrid").html("");
        $("#DataTableListInfoGrid").html("");
        $("#divListPreview").css("display", "none");
        $("#divSlipPreview").css("display", "none");

        fnGetItemInfo();
    }

    function fnInit() {
        fnGetACompanyInfo();//회사코드
        //fnGetAFormInfo();//양식코드
        //fnGetItemInfo();//항목불러오기
        fnSetQuickFlip();
    }

    function fnGetSelectedData() {
        var paramComCode = $("#company_sel option:selected").val(); // 텍스트값
        var paramFormCode = $("#form_sel option:selected").val(); // 텍스트값
    }

    function fnReg() {
        //회사 선택 이벤트
        $('#company_sel').change(function() {
            var selectedText = $(":selected").val();
            fnGetSelectedData();
            $("#company_sel").html('');
            fnMoveChkBox();

            fnGetAFormInfo();
        });
        //구분 선택 이벤트
        $('#form_sel').change(function() {
            var selectedText = $(":selected").val();
            fnGetSelectedData();
            $("#form_sel").html('');
            fnMoveChkBox();

            fnGetItemInfo();
        });
        
        //기본버튼
        $("button").kendoButton();

        $("#btnPriview").click(function() {
            fnSetPreView();
        });

        $("#btnInit").click(function() {
            fnDisplayReset();
        });

        $("#btnSave").click(function() {
            fnSave();
        });

    }
    /*-------------------------------------------------------------------*/
    /* fnSetTab 플립 미사용! 명칭만 플립
    /*-------------------------------------------------------------------*/
    function fnSetQuickFlip() {
        // $('#flip-container').quickFlip();
        $('#flip-navigation li a').each(function() {
            $(this).click(function() {
                $('#flip-navigation li').removeClass('k-state-active');
                $(this).parent().addClass('k-state-active');
                var flipid = $(this).attr('id').substr(4);

                if (flipid == 0) { //전표
                    $("#hdnDataSelectGrid").val("");
                    $("#hdnDataAddGrid").val("");
                    $("#hdnAddItemList").val("");
                    $("#hdnSelectItemList").val("");
                    $("#divListPreview").css("display", "none");
                    $("#divSlipPreview").css("display", "none");
                } else if (flipid == 1) { //분개
                    $("#hdnDataSelectGrid").val("");
                    $("#hdnDataAddGrid").val("");
                    $("#hdnAddItemList").val("");
                    $("#hdnSelectItemList").val("");
                    $("#divListPreview").css("display", "none");
                    $("#divSlipPreview").css("display", "");
                    $("#divListPreview").css("display", "none");
                    $("#divSlipPreview").css("display", "none");
                } else { //잘못된 플립 선택(에러)
                    $("#hdnDataSelectGrid").val("");
                    $("#hdnDataAddGrid").val("");
                    $("#divListPreview").css("display", "none");
                    $("#divSlipPreview").css("display", "none");
                }
                fnGetItemInfo();
                fnMoveChkBox();
                return false;
            });
        });
    }

    //콤보박스 데이터 바인드
    function fnSetComboBox( aaData, comboType ) {
        //console.log(aaData);
        if (comboType == 'Company') {
            setComboBox($('#company_sel'), aaData, function( event ) {
                fnSetComboBox_Change(event);
            }, 'name', 'value');/* 회사설정 */
        } else if (comboType == 'Form') {
            setComboBox($('#form_sel'), aaData, function( event ) {
                fnSetComboBox_Change(event);
            }, 'name', 'value');/* 회사설정 */
        }
        return;
    }

    function fnSetComboBox_Change() {
        /* 공통사항 */
        var eventType = event.target.parentElement.id.replace('_', '').replace('sel', '');
        /* 콤보박스별 처리 */
        switch (eventType) {
            case "company":
                fnGetSelectedData();
                $("#company_sel").html('');
                //  fnGetSettingForm();
                fnMoveChkBox();
                fnGetAFormInfo();
                break;
            case "form":
                //fnSetComboBox_Change_Form();
                fnGetItemInfo();
                break;
        }
        return;
    }

    // 아이템 코드 호출
    function fnGetItemInfo() {
        // 회사코드가 바인딩 되지 않은 경우에는 취소
        if (($("#company_sel").val() || '') == null || ($("#company_sel").val() || '') == '') {
            alert("<%=BizboxAMessage.getMessage("TX000009587","회사가 선택되지 않았습니다")%>");
            return false;
        }

        // 양식정보가 바인딩 되지 않은 경우에는 취소
        if (($("#form_sel").val() || '') == null || ($("#form_sel").val() || '') == '') {
            alert("<%=BizboxAMessage.getMessage("TX000009586","양식이 선택되지 않았습니다")%>");
            return false;
        }

        var tblParam = {};
        tblParam.comp_seq = $('#company_sel').val();
        tblParam.form_seq = $('#form_sel').val();
        tblParam.item_gbn = $(".k-state-active a").attr("title");

        url = '<c:url value="/ex/master/config/ExpendItemListSelect.do" />';
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            data : tblParam,
            async : true,
            success : function( res ) {
                if (res.aaData.configBasicItem != null) {
                    var datas = {};
                    datas.aaData = res.aaData.configBasicItem;
                    fnSetSelectGrid(datas); //선택항목 (기본항목)
                }
                if (res.aaData.configSelectItem != null) {
                    var datas = {};
                    datas.aaData = res.aaData.configSelectItem;
                    var index = 0;
                    $.each(datas.aaData, function( key, value ) {
                        if (datas.aaData[key].langpack_name == '체크박스') {
                            datas.aaData[key].order_num = 0; //0 
                            index = index + 1;
                        } else {
                            datas.aaData[key].order_num = index;
                            index = index + 1;
                        }
                    });
                    fnSetAddGrid(datas)//dispaly 항목(선택한 항목)
                }
            },
            error : function( result ) {
                alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
            }
        });
    }

 // 회사코드 호출
    function fnGetACompanyInfo() {
        var tblParam = {};
        tblParam.sCodeGb = "Company";
        tblParam.sSearch = "";

        url = '<c:url value="/ex/master/config/GetCompanyList.do" />';
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            data : tblParam,
            async : false,
            success : function( result ) {
                if (result.aaData.length > 0) {
                    fnSetComboBox(result.aaData, "Company");
                }
            },
            error : function( result ) {
                alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
            }
        });
    }

    // 양식코드 호출
    function fnGetAFormInfo() {
        var tblParam = {};

        tblParam.sCodeGb = "Form";
        tblParam.sSearch = ($("#company_sel").val() || '');
        url = '<c:url value="/ex/master/config/GetFormList.do" />';
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            data : tblParam,
            async : false,
            success : function( result ) {
                if (result.aaData.length > 0) {
                    fnSetComboBox(result.aaData, "Form");
                }
            },
            error : function( result ) {
                alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
            }
        });
    }

    //기본명칭 데이터 바인드
    function fnSetSelectGrid( data ) {
        if (typeof data.aaData == 'undefined') {
            data.aaData = "";
        }
        $("#hdnSelectItemList").val(JSON.stringify(data.aaData));
        //console.log(JSON.stringify(data.aaData));
        //테이블
        var oTable = $('#DataTableSelectGrid').dataTable({
            "bJQueryUI" : true, //jQuery UI 테마를 적용받음
            "sDom" : '<r>t', //컬럼 드레그 재정렬
            "bProcessing" : true, //처리 중 표시
            "bServerSide" : false,
            "bDestroy" : true,
            "sScrollY" : "369px",
            "bAutoWidth" : false,
            "paging" : false,
            "ordering" : false,
            "info" : false,
            "fixedHeader" : true,
            "select" : true,
            "data" : data.aaData,
            "iDisplayLength" : -1, // 로우수
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "fnRowCallback" : function( nRow, aData ) {
                $(nRow).css("cursor", "pointer");
                return nRow;
                //$(nRow).on( 'click', (function() { fnConfigAuthEventSelect_Row(aData); }));
            },
            "columnDefs" : [ {
                "targets" : 0,
                "data" : null,
                "render" : function( aData, data, type, meta, row ) {
                    if (aData.langpack_name == "체크박스") {
                        return "<input type='checkbox' id='chkSel1' checked='true'  name='chkSel1' value='" + meta.row + "' />"
                    } else {
                        return "<input type='checkbox' id='chkSel1' name='chkSel1' value='" + meta.row + "' />"
                    }
                },
            }, {
                "targets" : 1,
                "data" : null,
                "render" : function( aData, data, type, meta, row ) {
                    return '<div id="div-item_name' + meta.row + '" name="div-' + meta.row + '" style= width:80% data-value="' + aData.langpack_code + "|" + aData.langpack_name + "|" + aData.display_align + "|" + meta.row + "|" + aData.item_gbn + "|" + aData.head_code + '">' + aData.langpack_name + '</div>'
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<input type='checkbox' id='chkSels1' name='chkSels1' onclick='fnAllCheckBoxChecked(this, " + '"' + "chkSel1" + '"' + " )'>",
                "bSearchable" : false,
                "bSortable" : false,
                "sWidth" : "5",
                "sClass" : "center"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000005521","항목")%>",
                //"mDataProp" : "langpack_name",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            } ]
        });
    }

    //추가 명칭 데이터 바인드
    function fnSetAddGrid( data ) {
        if (typeof data.aaData == 'undefined') {
            data.aaData = "";
        }
        $("#hdnAddItemList").val(JSON.stringify(data.aaData));
        //console.log("추가명칭 바인딩 :" + JSON.stringify(data.aaData));
        //테이블
        var oTable = $('#DataTableAddGrid').dataTable({
            "bJQueryUI" : true, //jQuery UI 테마를 적용받음
            "sDom" : '<r>t', //컬럼 드레그 재정렬
            "bProcessing" : true, //처리 중 표시
            "bServerSide" : false,
            "bDestroy" : true,
            "sScrollY" : "369px",
            "bAutoWidth" : false,
            "paging" : false,
            "ordering" : false,
            "info" : false,
            "fixedHeader" : true,
            "select" : true,
            "data" : data.aaData,
            "iDisplayLength" : -1, // 로우수
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "fnRowCallback" : function( nRow, aData ) {
                $(nRow).css("cursor", "pointer");
                return nRow;
                //$(nRow).on( 'click', (function() { fnConfigAuthEventSelect_Row(aData); }));
            },
            "columnDefs" : [ {
                "targets" : 0,
                "data" : null,
                "render" : function( aData, data, type, meta, row ) {
                    if (aData.langpack_name == "체크박스") {
                        return "<input type='checkbox' id='chkSel2' disabled  name='chkSel2' value='" +meta.row + "' />"
                    } else {
                        return "<input type='checkbox' id='chkSel2' name='chkSel2' value='" + meta.row + "' />"
                    }
                }
            }, {
                "targets" : 1,
                "data" : null,
                "render" : function( aData, data, type, meta, row ) {
                    return '<div id="div-add_item_name' + meta.row + '" name="div-' + meta.row + '" style= width:80% data-value="' + aData.langpack_code + "|" + aData.langpack_name + "|" + aData.display_align + "|" + meta.row + "|" + aData.item_gbn + "|" + aData.head_code + '">' + aData.langpack_name + '</div>'
                }
            }, {
                "targets" : 2,
                "data" : null,
                "render" : function( aData, data, type, meta, row ) {
                    if (aData.display_align == 'left') {//왼쪽
                        return '<select id="ddl-' + meta.row + '" name="ddl-' + meta.row + '" style= width:80% onChange="fnChangeAlignGb(' + meta.row + ',this.value)" >' + '<option value="left" selected="selected">left</option><option value="center" >center</option><option value="right">right</option></select>'
                    } else if (aData.display_align == 'center') { //가운데
                        return '<select id="ddl-' + meta.row + '" name="ddl-' + meta.row + '" style= width:80% onChange="fnChangeAlignGb(' + meta.row + ',this.value)" >' + '<option value="left">left</option><option value="center" selected="selected" >center</option><option value="right">right</option></select>'
                    } else if (aData.display_align == 'right') {//오른쪽
                        return '<select id="ddl-' + meta.row + '" name="ddl-' + meta.row + '" style= width:80% onChange="fnChangeAlignGb(' + meta.row + ',this.value)" >' + '<option value="left">left</option><option value="center" >center</option><option value="right" selected="selected">right</option></select>'
                    } else { //시스템 기본값으로 입력 - 가운데
                        return '<select id="ddl-' + meta.row + '" name="ddl-' + meta.row + '" style= width:80% onChange="fnChangeAlignGb(' + meta.row + ',this.value)" >' + '<option value="left" selected="selected">left</option><option value="center" >center</option><option value="right">right</option></select>'
                    }
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<input type='checkbox' id='chkSels2' name='chkSels2' onclick='fnAllCheckBoxChecked(this, " + '"' + "chkSel2" + '"' + " )'>",
                "bSearchable" : false,
                "bSortable" : false,
                "sWidth" : "5",
                "sClass" : "center"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000005521","항목")%>",
                //"mDataProp" : "langpack_name",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000043","정렬")%>",
                //"mDataProp" : "langpack_name",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            } ]
            , 'createdRow' : function (row, data, dataIndex){
            	$(row).attr('data', JSON.stringify(data));
            	if(dataIndex == 0){
            		$(row).addClass('nodrag nodrop');	
            	}
            }
        });
        
        // table drag and drop 설정
        oTable.tableDnD({
	        onDrop: function(table, row) {
	        	fnSetDataReorder();
	        },
	        onDragStart: function(table, row) {
	        	$('#DataTableAddGrid .selected').removeClass('selected');
	        }
        });
        
        // oTable.rowReordering();
    }

    	
    /*	[재정렬] 테이블에 대한 데이터 재정렬 
    	테이블 view 정렬값에 따라서 내부 데이터를 재정렬합니다.
    	해당의 함수는 tableDnD 플러그인에서 호출됩니다.
    ---------------------------------------------*/
    function fnSetDataReorder(){
    	
    	$('#DataTableAddGrid>tbody>tr').each(function (idx,item){
    		var className = (idx % 2 == 0) ? 'odd' : 'even'; 
    		$(this).removeClass('even').removeClass('odd').addClass(className);
    	});
    }
    
    function fnChangeAlignGb( selBoxIndex, selValue ) {
        //변경된 값에 대해서 실시간으로 저장해야한다.
        var objAddList = [];
        objAddList = JSON.parse($("#hdnAddItemList").val());
        objAddList[selBoxIndex].display_align = selValue;

        var dataAddObj = [];
        dataAddObj.aaData = objAddList;
        fnSetAddGrid(dataAddObj);
    }

    function fnMoveItem( action ) {
        // action 파라메터 I : 항목추가  D : 항목삭제 
        // 조건:
        // 항목추가시 선택항목만 체크
        // 항목삭제시 추가내역만 체크
        // 공통 :
        // 추가내역 추가 후 전표정보 순서를 담을 수 있는 value값에 담기 (미리보기시 보여주기)
        // 추가내역에 있는 리스트의 순서가 바로 정렬 순서를 의미, 기본값 부여 item_code: 2000 즉, 체크박스 고정에 대해 순서 변경이 없다. 
        if (action == 'I') {
            var inputData = [];
            var chkCount = $("#chkSel1:checked").length;
            if (chkCount == 0) {
                alert("<%=BizboxAMessage.getMessage("TX000009583","선택항목에서 추가하려는 항목을 선택해 주세요")%>");
                return false;
            }
            //기존 데이터 넣어 주기
            var oldData = [];
            oldData = JSON.parse($("#hdnAddItemList").val());

            if (oldData != "") {
                $.each(oldData, function( key, value ) {
                    inputData.push(oldData[key]);
                });
            }

            var basicData = [];
            $("input[name = chkSel1").each(function( index ) {
                if ($(this).is(":checked")) {
                    var rowData = {};
                    var arrData = $('#div-item_name' + $(this).val()).attr('data-value');
                    var itemInfo = arrData.split('|');
                    rowData.langpack_code = itemInfo[0];
                    rowData.langpack_name = itemInfo[1];
                    rowData.display_align = itemInfo[2];
                    rowData.order_num = itemInfo[3];
                    if (rowData.order_num == '') { //현재 순서 값을 기본값으로 넣어줌
                        rowData.order_num = $(this).val();
                    }
                    rowData.item_gbn = itemInfo[4];
                    rowData.head_code = itemInfo[5];
                    inputData.push(rowData);

                } else {
                    var rowData = {};
                    var arrData = $('#div-item_name' + $(this).val()).attr('data-value');
                    var itemInfo = arrData.split('|');
                    rowData.langpack_code = itemInfo[0];
                    rowData.langpack_name = itemInfo[1];
                    rowData.display_align = itemInfo[2];
                    rowData.order_num = itemInfo[3];
                    if (rowData.order_num == '') { //현재 순서 값을 기본값으로 넣어줌
                        rowData.order_num = $(this).val();
                    }
                    rowData.item_gbn = itemInfo[4];
                    rowData.head_code = itemInfo[5];
                    basicData.push(rowData);
                }
            });

            //반드시 체크박스(고정)는 리스트 최상위로 올라가야 한다.

            var index = 1;
            $.each(inputData, function( key, value ) {
                if (inputData[key].langpack_name == '체크박스') {
                    inputData[key].order_num = 0; //0 
                    //index = index + 1;
                } else {
                    inputData[key].order_num = index;
                    index = index + 1;
                }
            });

            //합친 데이터에 대한 아이템 정렬
            inputData.sort(CompareForSort);
            //선택 데이터 아이템 정렬
            basicData.sort(CompareForSort);

            var dataSelectObj = [];
            dataSelectObj.aaData = basicData;
            //데이터 바인드
            fnSetSelectGrid(dataSelectObj);

            var dataAddObj = [];
            dataAddObj.aaData = inputData;
            //데이터 바인드
            fnSetAddGrid(dataAddObj);
        } else if (action == 'D') {
            var inputData = [];
            var chkCount = $("#chkSel2:checked").length;
            if (chkCount == 0) {
                alert("<%=BizboxAMessage.getMessage("TX000009582","추가내역에서 삭제하려는 항목을 선택해 주세요")%>");
                return false;
            }

            var basicData = [];
            $("input[name = chkSel2").each(function( index ) {
                if ($(this).is(":checked")) {
                    var rowData = {};
                    var arrData = $('#div-add_item_name' + $(this).val()).attr('data-value');
                    var itemInfo = arrData.split('|');
                    rowData.langpack_code = itemInfo[0];
                    rowData.langpack_name = itemInfo[1];
                    rowData.display_align = itemInfo[2];
                    rowData.order_num = itemInfo[3];
                    if (rowData.order_num == '') { //현재 순서 값을 기본값으로 넣어줌
                        rowData.order_num = $(this).val();
                    }
                    rowData.item_gbn = itemInfo[4];
                    rowData.head_code = itemInfo[5];
                    basicData.push(rowData);

                } else {
                    var rowData = {};
                    var arrData = $('#div-add_item_name' + $(this).val()).attr('data-value');
                    var itemInfo = arrData.split('|');
                    rowData.langpack_code = itemInfo[0];
                    rowData.langpack_name = itemInfo[1];
                    rowData.display_align = itemInfo[2];
                    rowData.order_num = itemInfo[3];
                    if (rowData.order_num == '') { //현재 순서 값을 기본값으로 넣어줌
                        rowData.order_num = $(this).val();
                    }
                    rowData.item_gbn = itemInfo[4];
                    rowData.head_code = itemInfo[5];
                    inputData.push(rowData);
                }
            });

            var index = 1;
            $.each(inputData, function( key, value ) {
                if (inputData[key].langpack_name == '체크박스(고정)') {
                    inputData[key].order_num = 0; //0 
                    //index = index + 1;
                } else {
                    inputData[key].order_num = index;
                    index = index + 1;
                }
            });

            //기존 데이터 넣어 주기
            var oldData = [];
            oldData = JSON.parse($("#hdnSelectItemList").val());

            if (oldData != "") {
                $.each(oldData, function( key, value ) {
                    basicData.push(oldData[key]);
                });
            }

            //추가 데이터에 대한 아이템 정렬
            inputData.sort(CompareForSort);
            //선택 데이터 아이템 정렬
            basicData.sort(CompareForSort);

            var dataSelectObj = [];
            dataSelectObj.aaData = basicData;
            //데이터 바인드
            fnSetSelectGrid(dataSelectObj);

            var dataAddObj = [];
            dataAddObj.aaData = inputData;
            //데이터 바인드
            fnSetAddGrid(dataAddObj);

        } else {
            alert("<%=BizboxAMessage.getMessage("TX000008120","오류가 발생하였습니다")%>");
            return false;
        }
    }

    // 정렬
    function CompareForSort( first, second ) {
        if (first.order_num == second.order_num) return 0;
        if (first.order_num < second.order_num) return -1;
        else return 1;
    }

    /*-------------------------------------------------------------------*/
    /* 사용 <> 미사용 이동 및 위, 아래 설정
    /*-------------------------------------------------------------------*/
    function fnSetItemUp() {
        var objAddList = [];
        objAddList = JSON.parse($("#hdnAddItemList").val());

        var arrSortNum = [];
        var rowNumList = [];
        $("input[name = chkSel2").each(function( index ) {
            if ($(this).val() == 1 && $(this).is(":checked")) {
                alert("<%=BizboxAMessage.getMessage("TX000009580","항목을 위로 이동할 수 없습니다")%>");
                return false;
            }
            if ($(this).is(":checked")) {
                var rowData = {};
                var arrData = $('#div-add_item_name' + $(this).val()).attr('data-value');
                var itemInfo = arrData.split('|');
                rowData.order_num = itemInfo[3];
                if (rowData.order_num != 0 && rowData.order_num != 1) { // 0: 체크박스, 1: 위로 이동할 수 없는 상태
                    rowData.order_num = Number(rowData.order_num) - 1;
                    rowData.langpack_code = itemInfo[0];
                    $.each(objAddList, function( key, value ) {
                        var row_num;
                        if (objAddList[key].order_num == rowData.order_num && objAddList[key].langpack_code != rowData.langpack_code) {
                            objAddList[key].order_num = Number(objAddList[key].order_num) + 1;
                        } else if (objAddList[key].order_num != rowData.order_num && objAddList[key].langpack_code == rowData.langpack_code) {
                            objAddList[key].order_num = Number(objAddList[key].order_num) - 1;
                        }
                    });
                    row_num = $(this).val(); //이동시 체크박스 체크를 위한 행의 순번가져오기
                    row_num = Number(row_num) - 1; //변경시 체크를 위한 행의 순번
                    rowNumList.push(row_num); //해당행 순번 저장
                }
            }
        });
        objAddList.sort(CompareForSort);
        var dataAddObj = [];
        dataAddObj.aaData = objAddList;
        //데이터 바인드
        fnSetAddGrid(dataAddObj);
        //$("#hdnAddItemList").find("tr").eq(rowNumList[rowNumList.length - 1]).focus();
        $.each(rowNumList, function( key, value ) {
            $("input[name = chkSel2").each(function( index ) {
                if ($(this).val() == value) {
                    $(this).attr("checked", "true");
                }
            });
        });
    }

    function fnSetItemDown() {
        jQuery.fn.reverse = [].reverse;
        var objAddList = [];
        objAddList = JSON.parse($("#hdnAddItemList").val());
        var arrSortNum = [];
        var rowNumList = [];
        $("input[name = chkSel2").reverse().each(function( index ) {
            if ($(this).is(":checked") && $(this).is(":checked")) {
                if ($(this).val() == objAddList.length - 1) {
                    alert("<%=BizboxAMessage.getMessage("TX000009579","항목을 아래로 이동할 수 없습니다")%>");
                    return false;
                }
                var rowData = {};
                var arrData = $('#div-add_item_name' + $(this).val()).attr('data-value');
                var itemInfo = arrData.split('|');
                rowData.order_num = itemInfo[3];

                if (rowData.order_num != objAddList.length - 1) {
                    rowData.order_num = Number(rowData.order_num) + 1;
                    rowData.langpack_code = itemInfo[0];

                    for (var key = objAddList.length - 1; key >= 0; key--) {
                        var row_num;
                        if (objAddList[key].order_num == rowData.order_num && objAddList[key].langpack_code != rowData.langpack_code) {
                            objAddList[key].order_num = Number(objAddList[key].order_num) - 1;
                        } else if (objAddList[key].order_num != rowData.order_num && objAddList[key].langpack_code == rowData.langpack_code) {
                            objAddList[key].order_num = Number(objAddList[key].order_num) + 1;
                        }
                    }

                    row_num = $(this).val(); //이동시 체크박스 체크를 위한 행의 순번가져오기
                    row_num = Number(row_num) + 1; //변경시 체크를 위한 행의 순번
                    rowNumList.push(row_num); //해당행 순번 저장
                }
            }
        });
        objAddList.sort(CompareForSort);
        var dataAddObj = [];
        dataAddObj.aaData = objAddList;
        //데이터 바인드
        fnSetAddGrid(dataAddObj);
        //$("#hdnAddItemList").find("tr").eq(rowNumList[rowNumList.length - 1]).focusWithoutScrolling();		
        $("#hdnAddItemList").animate();
        $.each(rowNumList, function( key, value ) {
            $("input[name = chkSel2").each(function( index ) {
                if ($(this).val() == value) {
                    $(this).attr("checked", "true");
                }
            });
        });
    }

    /*-------------------------------------------------------------------*/
    /* 미리보기 갱신
    /*-------------------------------------------------------------------*/
    function fnSetPreView() {
        var objColList = [];
        var objAddList = [];
        objAddList = JSON.parse($("#hdnAddItemList").val());

        if (objAddList != "") {
            $.each(objAddList, function( key, value ) {
                var rowData = {};
                var arrData = $('#div-add_item_name' + key).attr('data-value');
                var itemInfo = arrData.split('|');
                var objCol = {};

                objCol.sTitle = itemInfo[1];
                objCol.mDataProp = "";
                objCol.bVisible = true;
                if (itemInfo[0] == '2000') { //미리보기시 체크박스의 가로사이즈는 작게 설정
                    objCol.sWidth = "7%";
                }
                objCol.sClass = itemInfo[2];
                objCol.bSortable = false;
                objColList.push(objCol);
            });
        }
        var data = []
        data.aaData = "";

        //전표보이기
        var flipType = $(".k-state-active a").attr("title");
        if (flipType == "EX2002001") {
            $("#divListPreview").css("display", "");
            fnSetPreviewGrid(data, objColList, "DataTableListInfoGrid");
        } else if (flipType == "EX2002002") {
            $("#divSlipPreview").css("display", "");
            fnSetPreviewGrid(data, objColList, "DataTableSlipInfoGrid");
        }
    }

    function fnMoveChkBox() {
        var chkCount = $("#chkSel1:checked").length;
        if (chkCount == 0) {
            return false;
        } else {
            fnMoveItem('I');
        }
    }

    function fnSetPreviewGrid( data, dt_col, girdName ) {

        $("#" + girdName).html("");

        if (typeof data.aaData == 'undefined') {
            data.aaData = "";
        }
        var oTable;
        oTable = $("#" + girdName).dataTable({
            "bJQueryUI" : true, //jQuery UI 테마를 적용받음
            "sDom" : '<r>t', //컬럼 드레그 재정렬
            "sPaginationType" : "full_numbers",
            "bProcessing" : true, //처리 중 표시
            "bServerSide" : false,
            "bDestroy" : true,
            "bAutoWidth" : false,
            "iDisplayLength" : -1, // 로우수
            // "aaSorting": [[0, "asc"]],
            "aaData" : data.aaData,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex ) {
                $(nRow).css("cursor", "pointer");
                return nRow;
            },
            "aoColumns" : dt_col
        //컬럼과 프로퍼티 연결
        });
    }

    /*-------------------------------------------------------------------*/
    /* 항목 조회 & 저장
    /*-------------------------------------------------------------------*/
    function fnSave() {

        //console.log('-------------1.기본내역:'+$("#hdnSelectItemList").val());
        //console.log('-------------1.추가내역:'+$("#hdnAddItemList").val());

        if ($("#company_sel").val() == '') {
            alert("<%=BizboxAMessage.getMessage("TX000009576","회사 선택 오류발생")%>");
            return;
        }
        if ($("#form_sel").val() == '') {
            alert("<%=BizboxAMessage.getMessage("TX000009575","전자결재 양식 선택 오류발생")%>");
            return;
        }
        if ($(".k-state-active a").attr("title") == '') {
            alert("<%=BizboxAMessage.getMessage("TX000009574","전표분개 선택 오류발생")%>");
            return;
        }
        var tblParam = {}, ajaxCallParam = {};
        /*
        

        tblParam.comp_seq = $("#company_sel").val();
        tblParam.form_seq = $("#form_sel").val();
        tblParam.item_gbn = $(".k-state-active a").attr("title");
        
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : false,
            url : '<c:url value="/ex/config/GetExistList.do" />',
            data : tblParam,
            success : function( res ) {
                //console.log(res);
            },
            error : function( res ) {
                alert("항목 저장 중 오류가 발생하였습니다.");
                return false;
            }
        });
        */
        
        // 넘길 데이터
        var selectedData = new Array();
        $("#DataTableAddGrid>tbody>tr").each(function (idx){
        	
        	var item = JSON.parse($(this).attr('data'));
        	
        	var temp = {};
        	temp.comp_seq = $("#company_sel").val();
        	temp.display_align = item.display_align;
        	temp.form_seq = $("#form_sel").val();
        	temp.head_code = item.head_code;
        	temp.item_gbn = item.item_gbn;
        	temp.langpack_code = item.langpack_code;
        	temp.langpack_name = item.langpack_name;
        	temp.order_num = ( idx + 1);
        	temp.select_yn = 'Y';
        	selectedData.push(temp);
        	
        });
        
        // 저장시 배열로 넘겨서 한번에 처리. 
        // 선택값 저장
        var selectedTable = $("#DataTableAddGrid").DataTable();
        var selDataList = selectedTable.rows().data();
        // 데이터테이블에 있는 정보 불러오기
        
     	// 미선택값 저장
        var basicTable = $("#DataTableSelectGrid").DataTable();
     // 데이터테이블에 있는 정보 불러오기
        var basicDataList = basicTable.rows().data();
        // 넘길 데이터
        var basicData = new Array();
        $.each(basicDataList, function( i ) {
        	var temp = {};
        	temp.comp_seq = $("#company_sel").val();
        	temp.display_align = basicDataList[i].display_align;
        	temp.form_seq = $("#form_sel").val();
        	temp.head_code = basicDataList[i].head_code;
        	temp.item_gbn = basicDataList[i].item_gbn;
        	temp.langpack_code = basicDataList[i].langpack_code;
        	temp.langpack_name = basicDataList[i].langpack_name;
        	temp.order_num = basicDataList[i].order_num;
        	temp.select_yn = 'N';
        	basicData.push(temp);
        });
        
        var falseCount = 0;

        tblParam.comp_seq = $("#company_sel").val();
        tblParam.form_seq = $("#form_sel").val();
        tblParam.item_gbn = $(".k-state-active a").attr("title");
        tblParam.selectedList =  JSON.stringify(selectedData);
        tblParam.basicList =  JSON.stringify(basicData);
        
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : false,
            url : '<c:url value="/ex/master/config/ExpendItemListUpdate.do" />',
            data : tblParam,
            success : function( res ) {
                //console.log(res);
                if (res.aaData == 'false') {
                    falseCount = Number(falseCount + 1);
                }
            },
            error : function( res ) {
                alert("<%=BizboxAMessage.getMessage("TX000009573","항목 저장 중 오류가 발생하였습니다")%>");
                return false;
            }
        });

        if (falseCount > 0) {
            alert("<%=BizboxAMessage.getMessage("TX000002299","저장에 실패하였습니다.")%>");
            return;
        } else {
            falseCount = 0;
        }
	
        alert("항목을 저장하였습니다.");
        
    }
</script>
</head>
<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>회사</dt>
			<dd>
				<div class="dod_search">
					<input type="text" id="company_sel" class="kendoComboBox" style="width: 200px;" />
				</div>
			</dd>
			<dt>양식</dt>
			<dd>
				<input type="text" id="form_sel" class="kendoComboBox" style="width: 200px;" />
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn">
		<button id="btnInit" class="k-button"><%=BizboxAMessage.getMessage("TX000002960","초기화")%></button>
		<button id="btnSave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
	</div>

	<div class="tab_page">
		<div class="tab_style" id="tabstrip">
			<ul id="flip-navigation" class="mb20">
				<!-- 	<li class="k-state-active">전표정보</li>
				    <li>분개정보</li> -->
				<li class="k-state-active" title='EX2002001'><a href="javascript:;" id="tab-0" title="EX2002001"><%=BizboxAMessage.getMessage("TX000007461","전표정보")%></a></li>
				<li title='EX2002002'><a href="javascript:;" id="tab-1" title="EX2002002"><%=BizboxAMessage.getMessage("TX000007462","분개정보")%></a></li>
			</ul>
		</div>
		<div class="tab1">

			<div class="fl" style="width: 47%;">
				<div class="btn_div mt0">
					<div class="left_div">
						<h5><%=BizboxAMessage.getMessage("TX000009569","선택항목")%></h5>
					</div>
				</div>
				<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
					<table id='DataTableSelectGrid'>
						<colgroup>
							<col width="34" />
							<col width="" />
						</colgroup>
					</table>
				</div>
			</div>

			<div class="fl t_trans_tool" style="width: 6%; height: 490px;">
				<ul>
					<li><a id="btnAddItem" href="javascript:;" onclick="fnMoveItem('I');"><img src="../../Images/btn/btn_arr01.png" alt=""></a></li>
					<li><a href="javascript:;" onclick="fnMoveItem('D');"><img src="../../Images/btn/btn_arr02.png" alt=""></a></li>
				</ul>
			</div>

			<div class="fr" style="width: 47%;">
				<!-- 컨트롤버튼영역 -->
				<div class="btn_div mt0">
					<div class="left_div">
						<h5><%=BizboxAMessage.getMessage("TX000009568","추가내역")%></h5>
					</div>
				</div>

				<div class="com_ta4 bgtable3 ova_sc sel_ta1" style="height: 408px">
					<table id="DataTableAddGrid">
						<colgroup>
							<col width="34%" />
							<col width="" />
							<col width="35%" />
						</colgroup>
					</table>
				</div>

				<div class="fl ovh mt14" style="width: 100%">
					<div class="updo_div fl mr20">
						<a href="javascript:fnSetItemUp();" class="up"><img src="../../Images/ico/ico_order_up01.png" alt="" /></a> <a href="javascript:fnSetItemDown();" class="down"><img src="../../Images/ico/ico_order_down01.png" alt="" /></a>
					</div>
					<div class="controll_btn fr p0">
						<button id="btnPriview" class="k-button""><%=BizboxAMessage.getMessage("TX000003080","미리보기")%></button>
					</div>
				</div>
			</div>


			<div id="divListPreview" style="display: none; width: 99%; margin-left: 0px;">
				<div class="cl mt10">
					<p style="margin-bottom: 8px;"><%=BizboxAMessage.getMessage("TX000007461","전표정보")%></p>
				</div>
				<div class="com_ta4" style="width: 100%; background: #f5f5f5;">
					<table border="0" id="DataTableListInfoGrid" cellpadding="0" cellspacing="0" class="display" width="100%">
					</table>
				</div>
			</div>
			<div id="divSlipPreview" style="display: none; width: 99%; margin-left: 0px;">
				<div class="cl mt10">
					<pstyle="margin-bottom: 8px;"> <%=BizboxAMessage.getMessage("TX000007462","분개정보")%>
					</p>
				</div>
				<div class="com_ta4" style="width: 100%; background: #f5f5f5;">
					<table border="0" id="DataTableSlipInfoGrid" cellpadding="0" cellspacing="0" class="display" width="100%"></table>
				</div>
			</div>
		</div>
		<!--// tab_style -->
	</div>
</div>
<input type="hidden" id="hdnAddItemList" />
<input type="hidden" id="hdnSelectItemList" />
<input type="hidden" id="hdnCheckItemList" />

