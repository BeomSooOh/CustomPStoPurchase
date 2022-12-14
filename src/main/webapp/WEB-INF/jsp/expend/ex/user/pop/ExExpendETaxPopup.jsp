<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<style type="text/css">
	#tblExpendETaxList th, #tblExpendCardList td { border-left-width: 1px; border-right-width: 1px; }
	#tblExpendETaxList th:first-child, #tblExpendCardList td:first-child { border-left-width: 0; }
	#tblExpendETaxList th:last-child, #tblExpendCardList td:last-child { border-right-width: 0; }
</style>

<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/jquery.dataTables.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.select.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.scroller.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.rowReorder.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.fixedHeader.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosUtil.js'></script> --%>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/CommonEX.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExExpend.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.date.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.event.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.list.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.pop.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.valid.js'></script>

<script>	

    /* ???????????? */
    var ifSystem = '${ViewBag.ifSystem}';
    var ExpendETaxModule = 'ExpendETax';
    /* ?????????????????? ?????? ????????? ?????? ?????? */
    var isInitPage = false;
    var eTable;
    var currentPage = 0;
    
    
    var eTaxPopAttribute = {
        "type" : "",
        "title" : "<%=BizboxAMessage.getMessage("TX000016475","????????????")%>",
        "width" : "650",
        "height" : "689",
        "opener" : "3",
        "parentId" : "layerExpendETax",
        "childerenId" : "layerCommonCode",
        "callback" : "",
        "comp_seq" : (empInfo.compSeq || '0'),
        "form_seq" : (formInfo.formSeq || '0'),
        "search_str" : "",
        "empInfo" : "hidExpendETaxEmpInfo",
        "budgetIfno" : "hidExpendETaxERPiUBudgetInfo"
    };

    var eTaxElement = {
        fromDate : "#txtExpendETaxFromDate", /* ?????? / ?????? */
        toDate : "#txtExpendETaxToDate", /* ?????? / ?????? */
        searchStr : "#txtExpendETaxSearchStr", /* ??????????????? *//* eTaxElement.searchStr */
        emp : { /* ????????? */
            disp : "#txtExpendETaxDispEmp", /* eTaxElement.emp.disp */
            info : "#hidExpendETaxEmpInfo" /* eTaxElement.emp.info */
        },
        dept : {
            disp : "#txtExpendETaxDispDept", /* eTaxElement.dept.disp */
            info : "#hidExpendETaxEmpInfo" /* eTaxElement.dept.info */
        },
        /* pc : {
            disp : "#txtExpendETaxDispPc",
            info : "#hidExpendETaxEmpInfo"
        }, */
        cc : { /* ??????????????? */
            disp : "#txtExpendETaxDispCc", /* eTaxElement.cc.disp */
            info : "#hidExpendETaxEmpInfo"
        },
        summary : { /* ???????????? */
            disp : "#txtExpendETaxDispSummary", /* eTaxElement.summary.disp */
            info : "#hidExpendETaxSummaryInfo" /* eTaxElement.summary.info */
        },
        auth : { /* ???????????? */
            disp : "#txtExpendETaxDispAuth", /* eTaxElement.auth.disp */
            info : "#hidExpendETaxAuthInfo" /* eTaxElement.auth.info */
        },
        va : { /* ???????????? */
            disp : "#txtExpendETaxDispVa", /* eTaxElement.va.disp */
            info : "#hidExpendETaxVaInfo" /* eTaxElement.va.info */
        },
        noTax : { /* ??????????????? */
            disp : "#txtExpendETaxDispNoTax", /* eTaxElement.noTax.disp */
            info : "#hidExpendETaxNoTaxInfo" /* eTaxElement.noTax.info */
        },
        project : { /* ???????????? */
            disp : "#txtExpendETaxDispProject", /* eTaxElement.project.disp */
            info : "#hidExpendETaxProjectInfo" /* eTaxElement.project.info */
        },
        card : { /* ?????? */
            disp : "#txtExpendETaxDispCard", /* eTaxElement.card.disp */
            info : "#hidExpendETaxCardInfo" /* eTaxElement.card.info */
        },
        budget : { /* ???????????? */
            disp : "#txtExpendETaxDispBudget", /* eTaxElement.budget.disp */
            info : "#hidExpendETaxERPiUBudgetInfo" /* eTaxElement.budget.info */
        },
        bizplan : { /* ???????????? */
            disp : "#txtExpendETaxDispBizplan", /* eTaxElement.bizplan.disp */
            info : "#hidExpendETaxBizplanInfo" /* eTaxElement.bizplan.info */
        },
        bgacct : { /* ???????????? */
            disp : "#txtExpendETaxDispBgAcct", /* eTaxElement.bgacct.disp */
            info : "#hidExpendETaxBgAcctInfo" /* eTaxElement.bgacct.info */
        },
        note : "#txtExpendETaxNote", /* eTaxElement.note */
        selectList : "#hidExpendETaxSelected", /* ???????????? */
        showCount : "#selExpendETaxShowCount",
        tableDiv : "#divExpendETaxList" /* ?????? ????????? div */
    };

    var eTaxButton = {
        search : "#btnExpendETaxSearch", /* ?????? *//* eTaxButton.search */
        save : "#btnExpendETaxSave", /* ?????? *//* eTaxButton.save */
        callback : "#btnExpendETaxCallback", /* ?????? */
        close : "#btnExpendETaxClose", /* ?????? */
        emp : "#btnExpendETaxEmpPop", /* ????????? *//* eTaxButton.emp */
        dept : "#btnExpendETaxDeptPop", /* ????????? *//* eTaxButton.dept */
        pc : "#btnExpendETaxPcPop", /* ???????????? *//* eTaxButton.pc */
        cc : "#btnExpendETaxCcPop", /* ??????????????? *//* eTaxButton.cc */
        summary : "#btnExpendETaxSummaryPop", /* ???????????? *//* eTaxButton.summary */
        auth : "#btnExpendETaxAuthPop", /* ???????????? *//* eTaxButton.auth */
        va : "#btnExpendETaxVaPop", /* ???????????? *//* eTaxButton.va */
        noTax : "#btnExpendETaxNoTaxPop", /* ??????????????? *//* eTaxButton.noTax */
        project : "#btnExpendETaxProjectPop", /* ???????????? *//* eTaxButton.project */
        card : "#btnExpendETaxCardPop", /* ?????? *//* eTaxButton.card */
        budget : "#btnExpendETaxBudgetPop", /* ???????????? *//* eTaxButton.budget */
        bizplan : "#btnExpendETaxBizplanPop", /* ???????????? *//* eTaxButton.bizplan */
        bgacct : "#btnExpendETaxBgAcctPop" /* ???????????? *//* eTaxButton.bgacct */
    };

	// ??? ?????? ??? ????????? ???????????? ??????????????? ???????????? ?????????
	var checkedCheckbox = false;
	var clickedRow = false;
    
    /* ???????????? */
    $(document).ready(function() {
    	/*?????? ????????????*/
		pop_position();
		$(window).resize(function() { 
		    pop_position();
		});
        fnExpendETaxInit();
        fnExpendETaxEventInit();
        fnExpendETaxGridListBind('');
        fnSetExOption(option, 'etax');
        // ?????? ?????? ??????
        $(eTaxButton.search).click();
        
     	// ???????????? ???????????? ????????? ?????? ????????? ?????? ???????????? ????????? ????????????.
        if($(eTaxElement.project.disp).is('[disabled=disabled]')){
        	$(eTaxElement.project.disp).val('[' + $('#txtExpendProjectCode').val() + '] ' + $('#txtExpendProjectName').val());

			var projectParam = {};
			projectParam.projectCode = expendProject.projectCode;
			projectParam.projectName = expendProject.projectName;
			projectParam.seq = 0;
			$(eTaxElement.project.info).val(JSON.stringify(projectParam));
        }
     	
     	// ?????? ???????????? ????????? ?????? ????????? ?????? ???????????? ????????? ????????????.
        if($(eTaxElement.card.disp).is('[disabled=disabled]')){
        	$(eTaxElement.card.disp).val('[' + $('#txtExpendCardCode').val() + '] ' + $('#txtExpendCardName').val());

			var cardParam = {};
			cardParam.cardCode = expendCard.cardCode;
			cardParam.cardName = expendCard.cardName;
			cardParam.cardNum = expendCard.cardNum;
			cardParam.seq = 0;
			$(eTaxElement.card.info).val(JSON.stringify(cardParam));
        }
     	
     	// ERPiU??? ???????????? ?????? ?????? ??????
     	if('${ViewBag.ifSystem}' != 'ERPiU'){
     		$(".ExpendEtaxBudget").hide();
     	}
     	
     	fnSetETaxEmpDeptOptionSet();

		// ??????????????? ??????????????? ??????????????? ?????? ???????????? ?????? ?????? ??????
		if ($('#divAuthDate').is(":visible")) {
			var defaultCheckedAuthDateOption = option.filter(function (item) {
				if (item.option_code === '003110') {
					return item.option_value;
				}
			});
			if (defaultCheckedAuthDateOption[0].option_value == "Y") {
				$("#chkAuthDate").prop("checked", true);
			}
		}

        return;
    });
    
    function fnSetETaxEmpDeptOptionSet() {
    	if(expendEmpChange) {
			$('#txtExpendETaxDispEmp').removeAttr('disabled');
			$('#btnExpendETaxEmpPop').css("display", "inline-block");
    	} else {
			$('#txtExpendETaxDispEmp').attr('disabled', 'disabled');
			$('#btnExpendETaxEmpPop').hide();
    	}
    	
    	if(expendDeptChange) {
			$('#txtExpendETaxDispDept').removeAttr('disabled');
			$('#btnExpendETaxDeptPop').show();
    	} else {
			$('#txtExpendETaxDispDept').attr('disabled', 'disabled');
			$('#btnExpendETaxDeptPop').hide();
    	}
    	
    	if(expendEmpDeptLink) {
			$('#txtExpendETaxDispDept').attr('disabled', 'disabled');
			$('#btnExpendETaxDeptPop').hide();
    	}
    	
    	return;
    }

    /* ????????? */
    function fnExpendETaxInit() {
        fnExpendETaxInitLayout();
        fnExpendETaxInitDatepicker();
        fnExpendETaxInitInput();
        
        if(!expendEmpChange) {
        	$('#txtExpendETaxDispEmp').attr('readonly', 'readonly');
        	$('#txtExpendETaxDispEmp').attr('disabled', 'disabled');
        } else {
        	$('#txtExpendETaxDispEmp').removeAttr('readonly', 'readonly');
        	$('#txtExpendETaxDispEmp').removeAttr('disabled', 'disabled');
        }
        
        if(!expendDeptChange) {
        	$('#txtExpendETaxDispDept').attr('readonly', 'readonly');
        	$('#txtExpendETaxDispDept').attr('disabled', 'disabled');
        } else {
        	$('#txtExpendETaxDispDept').removeAttr('readonly', 'readonly');
        	$('#txtExpendETaxDispDept').removeAttr('disabled', 'disabled');
        }
        
        return;
    }
    /* ????????? - Layout */
    function fnExpendETaxInitLayout() {
        /* ????????? ?????? ????????? */
        /* ????????? ??????, ???????????? ??????, ???????????? ??????, ???????????? ??????, ?????? ??????, ???????????? ??????, ???????????? ??????, ?????? ?????? */
        $('input[type=hidden].ExpendETax').inputReset();
        /* ?????????, ????????????, ????????????, ??????, ????????????, ????????????, ??????, ????????????, ????????????, ???????????? */
        $('.com_ta input[type=text].ExpendETax').inputReset();
        /* ?????? ??? ????????? */
        $('#eTaxReqNote, #eTaxReqProject, #eTaxReqCard').hide();

        if ((typeof expendUseEmp.empSeq != 'undefined' && expendUseEmp.empSeq != '') || (typeof expendUseEmp.erpEmpSeq != 'undefined' && expendUseEmp.erpEmpSeq != '')) {
			/* ????????? */
			var disp_emp_name = ((expendUseEmp.erpEmpName == '' ? expendUseEmp.empName : expendUseEmp.erpEmpName) || '');
			var disp_emp_seq = ((expendUseEmp.erpEmpSeq == '' ? expendUseEmp.empSeq : expendUseEmp.erpEmpSeq) || '');
			$(eTaxElement.emp.info).val(JSON.stringify(expendUseEmp));
			$(eTaxElement.emp.disp).val('[' + disp_emp_seq + '] ' + disp_emp_name);
			
		    /* ?????? */
			var disp_dept_name = ((expendUseEmp.erpDeptName == '' ? expendUseEmp.deptName : expendUseEmp.erpDeptName) || '');
			var disp_dept_seq = ((expendUseEmp.erpDeptSeq == '' ? expendUseEmp.deptSeq : expendUseEmp.erpDeptSeq) || '');
			$(eTaxElement.dept.disp).val('[' + disp_dept_seq + '] ' + disp_dept_name);
			
			if ('${ViewBag.ifSystem}' == 'ERPiU') {
				/* ???????????? */
				var disp_pc_name = ($('#txtExpendPcName').val() || '');
				var disp_pc_seq = ($('#txtExpendPcCode').val() || '');
				/* $(eTaxElement.pc.disp).val('[' + disp_pc_seq + '] ' + disp_pc_name); */
				/* ??????????????? */
				var disp_cc_name = (expendUseEmp.erpCcName || '');
				var disp_cc_seq = (expendUseEmp.erpCcSeq || '');
				$(eTaxElement.cc.disp).val('[' + disp_cc_seq + '] ' + disp_cc_name);
				
			} else {
				/* $(eTaxElement.pc.disp).parent('td').parent('tr').hide(); */ /* ?????? tr ????????? */ 
				$(eTaxElement.cc.disp).parent('td').parent('tr').hide(); /* ?????? tr ????????? */
			}
			
			
			if (${ViewBag.isEmpInfoLocateExpend} ) {
				$(eTaxElement.emp.disp).attr('disabled', 'disabled');
				$(eTaxButton.emp).hide();
				$(eTaxElement.dept.disp).attr('disabled', 'disabled');
				/* $(eTaxElement.pc.disp).attr('disabled', 'disabled'); */
				$(eTaxButton.pc).hide();
				$(eTaxElement.cc.disp).attr('disabled', 'disabled');
				$(eTaxButton.cc).hide();
			}else{
	            $(eTaxElement.emp.disp).removeAttr('disabled', 'disabled');
	            $(eTaxButton.emp).show();
	            $(eTaxElement.dept.disp).attr('disabled', 'disabled');
// 	            $(eTaxElement.dept.disp).removeAttr('disabled', 'disabled');
	            if ('${ViewBag.ifSystem}' == 'ERPiU') {
		            /* $(eTaxElement.pc.disp).removeAttr('disabled', 'disabled'); */
					$(eTaxButton.pc).show();
					$(eTaxElement.cc.disp).removeAttr('disabled', 'disabled');
					$(eTaxButton.cc).show();
	            }
			}
		}

        /* ???????????? */
        if ('${ViewBag.ifSystem}' == 'ERPiU') {
            $('.ERPiUBudget').show();
            var etaxBudgetInfo = {};
            $.extend(etaxBudgetInfo, ExCodeBudget);
            etaxBudgetInfo.budget_ym = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
            $(eTaxElement.budget.info).val(JSON.stringify(etaxBudgetInfo));
            $(eTaxElement.budget.disp).val('');
            $(eTaxElement.bizplan.disp).val('');
            $(eTaxElement.bgacct.disp).val('');
        } else {
            $('.ERPiUBudget').hide();
        }

        return;
    }
    /* ????????? - Datepicker */
    function fnExpendETaxInitDatepicker() {
        $([ eTaxElement.fromDate, eTaxElement.toDate ].join(', ')).setKendoDatePicker();
        $([ eTaxElement.fromDate, eTaxElement.toDate ].join(', ')).setKendoDatePickerMask();
        $(eTaxElement.toDate).resetDate();
        $(eTaxElement.fromDate).resetDate(-10);

        return;
    }
    /* ????????? - Input */
    function fnExpendETaxInitInput() {
        setComboBox($(eTaxElement.showCount), fnGetListCount([ 5, 10, 15, -1 ]), function() {
        	if($(eTaxElement.showCount).val() == '??????'){
        		$(eTaxElement.showCount).val(-1);
        	}
            $('select[name=tblExpendETaxList_length]').val($(eTaxElement.showCount).val());
            $('select[name=tblExpendETaxList_length]').trigger('change');
            return;
        }); /* ???????????? ?????? */
        /* ???????????? ?????? ?????? */
		fnSetNote();
        
        /* ???????????? ?????? - ?????????*/
        $('#etaxSortingAsc').change(function() {
            if ($(this).is(':checked')) {
            	$("#tblExpendETaxList").DataTable().order([[4,'asc']]).draw();
            }
        });
        /* ???????????? ?????? - ?????????*/
        $('#etaxSortingDesc').change(function() {
            if ($(this).is(':checked')) {
            	$("#tblExpendETaxList").DataTable().order([[4,'desc']]).draw();
            }
        });
        return;
    }

	// ???????????? ?????? ??????
	function fnSetNote() {
		if ($("#txtExpendETaxNote").val() == "") {
			if ($("#txtExpendBaseNote").val() != "") {
				$("#txtExpendETaxNote").val(parent.$("#txtExpendBaseNote").val());
			}
		}
	}

    //?????? ?????? ??? 
    //?????? ?????? / ?????? ???????????? 
   	function fnChAuthFail(){
   		// ?????? ????????????
   		$('#divAuthDate').hide();
   		// ?????? ????????????
   		$('#laAuth').hide();
   		// ?????? -> unchecked
   		$("#chkAuthDate").attr("checked", false);
   		// ?????????????????? ?????? 
   		localStorage.removeItem( 'foid') ;
   		localStorage.removeItem( 'emcomp');
   		$('#chkAuthDate').attr('disabled', 'disabled');
   		
   		return;
   	}
    //?????? ?????? ???
    //?????? ????????? / ?????? ???????????? 
    function fnChAuthSucceed(){
    
   		// ?????? ?????????  
   		$('#divAuthDate').show();
   		// ?????? ?????????  
   		$('#laAuth').show();
   		// ?????? -> checked
   		//$("#chkAuthDate").attr("checked", true); // ??? ?????? ????????? ?????? ????????? ????????? ???????????? ???????????? ????????????
   		// ?????????????????? ??????  
   		localStorage.setItem( 'foid', formInfo.formId) ;
		localStorage.setItem( 'emcomp', empInfo.compSeq);
    	$('#chkAuthDate').removeAttr('disabled', 'disabled');
/*     	//?????? ?????? ?????? 
    	 var checked = JSON.parse(localStorage.getItem("checkbox1"));
	     document.getElementById("chkAuthDate").checked = checked||''; */
	    
    	return;
    }
    
    function fnChAuthButton(){
    	//?????? ????????? - ?????????  
    	$("#chkAuthDate").change(function(){
			
    		 if($("#chkAuthDate").is(":checked")){
					// ?????????????????? ?????? 
    	       		localStorage.setItem( 'foid', formInfo.formId) ;
    	    		localStorage.setItem( 'emcomp', empInfo.compSeq);
/*     	    		//?????? ?????? ??????
    	    	    var checkbox = document.getElementById("chkAuthDate");
    	    	    localStorage.setItem("checkbox1", checkbox.checked);
    				 */    	           		    	            
    	        }else{
    	       		// ?????????????????? ?????? 
    	       		localStorage.removeItem( 'foid') ;
    	       		localStorage.removeItem( 'emcomp');
    	       		localStorage.removeItem( 'checkbox1');
    	        }
    	});	

    	return;
    }

    /* ????????? ????????? */
    function fnExpendETaxEventInit() {
        $('button').kendoButton(); /* ?????????????????? */
        fnExpendETaxEventInitButton();
        fnExpendETaxEventInitEnter();
        return;
    }
    
    function fnExpendAuthChk(){
    	
   	 // ??????????????? ??????  
       	if ($("input:checkbox[id='chkAuthDate']").is(":checked") == true){
       		
       		var ETaxChkVal;
       		$("input[name=inp_ETaxchk]:checked").each(function() {
       			if( $(this).val() !== 'on'){
       				ETaxChkVal = $(this).val();
       				console.log(ETaxChkVal);
       			}
			});
       		ETaxChkVal = ETaxChkVal.split('|')[1];
       		ETaxChkVal = [ETaxChkVal.substring(0, 4), ETaxChkVal.substring(4, 6), ETaxChkVal.substring(6, 8)].join('-');

			/* ???????????? ????????? ?????? ?????? */
			var isClosed = false;
			for( var i = 0 ; i < expendDateList.length ; i++){
				var tDate = expendDateList[i];
				// ?????? ???????????? ????????? ????????? ????????? ??????????????? ?????? ?????? ?????? ????????????.
				if( tDate.closeFromDate <= ETaxChkVal && ETaxChkVal <= tDate.closeToDate ){
					isClosed = true;
					break;
				}
			}

			/* ????????? ????????? ?????? ????????? ??????????????? ?????? */
			if( !isClosed ){
				expend.set('expendDate', ETaxChkVal);
				datepicker.value(ETaxChkVal);
				$('#txtExpendDate').val(ETaxChkVal);
			}else{
				alert("????????? ??????????????? ???????????? ?????? ?????? ????????? ???????????? ?????? ????????? ???????????????.");
			}
        }
		return;
    }
    
   
    /* ????????? ????????? - ?????? */
    function fnExpendETaxEventInitButton() {
    	//?????? ?????? - ????????? 
    	if( isUseBudget == true ){ 
    		fnChAuthFail();
    	}
    	else if(($("#tblExpendList").find('tbody tr:first td').attr('colspan')|| 1) == 1 ){
    		if( $("#tblExpendList").find('tbody tr').length >= 1){
    			fnChAuthFail();
    		}	
		}//?????? ????????? 
    	else{
    		fnChAuthSucceed();
    	}    	
    	
    	// ??????????????? ?????? 
    	fnChAuthButton();
    	
        /* ?????? ?????? ????????? */
        /* ???????????? ????????? - ?????? */
//         $(eTaxButton.search).btnClick('fnExpendETaxEventSearch');
		$("#btnExpendETaxSearch").on("click",function(){
        	isInitPage = false;
        	fnExpendETaxEventSearch();
        });

        /* ???????????? ????????? - ?????? */
//         $(eTaxButton.save).btnClick('fnExpendETaxEventSave');
        $("#btnExpendETaxSave").on("click", function(){
        	isInitPage = true;
        	fnExpendETaxEventSave();
        })
        
        $("#txtExpendETaxNote").keyup(function(e){
			var NoteContent = $(this).val();
			if(NoteContent.length >= 100){
				alert('????????? ??????(100byte)??? ?????????????????????.');
				return  $(this).val(NoteContent.substring(0, 100));
			}
		})
        
        
        $('#btnExpendETaxInfoReset').on("click", function(){
        	isInitPage = false;
        	fnExpendETaxInfoReset();
        });
        if( isUseBudget == false){
        	$('#btnListiCUBEBudgetChk').hide(); 
	        $('#btnListERPiUBudgetChk').hide();    
        }else {
	        if( expendBudgetInfo.useYN ==='Y' &&  ifSystem == 'ERPiU'){
		        /* ????????? ?????? !!!! ==> ??????????????? ????????????????????????... +- */
		        $('#btnListiCUBEBudgetChk').hide(); 
		        $('#btnListERPiUBudgetChk').show();
		        
		        $('#btnListERPiUBudgetChk').click(function(){
		        	var budgetInfo = JSON.parse(($('#hidExpendETaxERPiUBudgetInfo').val() || '{}'));
		        	if((budgetInfo.budgetCode || '') == '') {
		        		alert('??????????????? ???????????????.');
		        		return;
		        	}
		        	if((budgetInfo.bgacctCode || '') == '') {
		        		alert('??????????????? ???????????????.'); 
		        		return;
		        	}
		        	
		        	fnExpendERPiUBudgetChk();
		        	
		        	return;
		        });
	        }else if(expendBudgetInfo.useYN ==='Y' && ifSystem == 'iCUBE' ){
	        	$('#btnListERPiUBudgetChk').hide();
	        	$('#btnListiCUBEBudgetChk').show(); 
	        	
	        	$('#btnListiCUBEBudgetChk').click(function(){
	        		
		        	fnExpendiCUBEBudgetChk();	
		        	return;
	        	});
	        }
        
        }
        
        /* ???????????? ????????? - ?????? */
        $(eTaxButton.callback).btnClick('fnExpendETaxEventCallback');
       
        /* ???????????? ????????? - ?????? */
        $("#btnExpendETaxClose").click(function(){
//         	layerPopClose('');
        	fnExCloseLayPop();
        });
        /* ???????????? ????????? - ?????????, ????????????, ???????????????, ????????????, ????????????, ????????????, ??????, ????????????, ????????????, ????????????, ????????????, ??????????????? */
		$("#btnExpendETaxEmpPop, #btnExpendETaxDeptPop, #btnExpendETaxPcPop, #btnExpendETaxCcPop, "
		+ "#btnExpendETaxSummaryPop, #btnExpendETaxAuthPop, #btnExpendETaxCardPop, #btnExpendETaxProjectPop, "
        + "#btnExpendETaxBudgetPop, #btnExpendETaxBizplanPop, #btnExpendETaxBgAcctPop, #btnExpendETaxVaPop, "
        + "#btnExpendETaxNoTaxPop").click(function(){
        	var btnType = $(this).attr('id').replace('btnExpendETax','').replace('Pop','');
        	
        	var btnCallback = '';
        	switch(btnType){
	        	case 'Budget' :
	        	case 'Bizplan' :
	        	case 'BgAcct' :
	        		btnCallback = 'fnExpendETaxCallbackBudget';
	        		break;
	        	default :
	        		btnCallback = 'fnExpendETaxCallback';
	        		break;
        	}
        	
        	if(!expendEmpChange && btnType == 'Emp') {
        		alert('???????????? ????????? ??? ????????????.');
        		return;
        	}
        	
			if(!expendDeptChange && btnType == 'Dept') {
				alert('??????????????? ????????? ??? ????????????.');
        		return;
        	}
			
        	fnOpenCommonCodePop('N', btnType, btnCallback);
		});

        return;
    }
    
    /* ????????? ????????? - ?????? */
    function fnExpendETaxEventInitEnter() {
    	
    	$(document).keydown(function(event){
    		if(event.keyCode == '27'){
    			$("#btnExpendETaxClose").click();
			}
    	})
    	
    	/* ?????? */
        $("#txtExpendETaxFromDate, #txtExpendETaxToDate, #txtExpendETaxSearchStr, #txtIssNo, #txtPartnerNo").keydown(function(event){
			if(event.keyCode == '13'){
				isInitPage = false;
				fnExpendETaxEventSearch();	
			}
    	});
    	/* ?????? ????????? - ?????????, ????????????, ???????????????, ????????????, ????????????, ????????????, ????????????, ????????????, ????????????, ????????????, ??????????????? */
		$("#txtExpendETaxDispEmp, #txtExpendETaxDispCc, "
		+ "#txtExpendETaxDispSummary, #txtExpendETaxDispAuth, #txtExpendETaxDispProject, #txtExpendETaxDispCard, "
  	    + "#txtExpendETaxDispBudget, #txtExpendETaxDispBizplan, #txtExpendETaxDispBgAcct, #txtExpendETaxDispVa, "
  	    + "#txtExpendETaxDispNoTax").keydown(function(event){
			if(event.keyCode == '13'){
	        	var txtType = $(this).attr('id').replace('txtExpendETaxDisp','');
	        	var txtCallback = '';
	        	var isReq = false;
	        	switch(txtType){
		        	case 'Budget' :
		        	case 'Bizplan' :
		        	case 'BgAcct' :
		        		txtCallback = 'fnExpendETaxCallbackBudget';
		        		if($("#expendEtaxReq"+txtType).is(":visible")){
		        			isReq = true;
		        		}else{
		        			isReq = false;
		        		}
		        		break;
		        	default :
		        		txtCallback = 'fnExpendETaxCallback';
			        	if($("#eTaxReq"+txtType).is(":visible")){
		        			isReq = true;
		        		}else{
		        			isReq = false;
		        		}
		        		break;
	        	}
	        	if(isReq){
	        		fnOpenCommonCodePop('Y', txtType, txtCallback);	
	        	}else{
	        		fnSetFocus($(this).attr('id'));
	        	}
			}
		});
    	
    	$("#txtExpendETaxNote").keydown(function(event){
			if(event.keyCode == '13'){
				if($("#eTaxReqNote").is(":visible")){
					if($("#txtExpendETaxNote").val() != ''){
						fnSetFocus('txtExpendETaxNote');	
					}
				}else{
					fnSetFocus('txtExpendETaxNote');
				}
			}
    	});
        return;
    }
    
    function fnOpenCommonCodePop(input, codeType, callBack){
    	var budgetCode = '';
    	var bizplanCode = '';
    	if($(eTaxElement.budget.info).val() != ''){
    		budgetCode = ( JSON.parse( $(eTaxElement.budget.info).val() ) || '' ).budgetCode;
    		bizplanCode = ( JSON.parse( $(eTaxElement.budget.info).val() ) || '' ).bizplanCode || '***';
    	}
		// ?????? ???????????? ???????????? ??????
		if(input === 'Y'){
			fnOpenCodePop({
				codeType : codeType,
				callback : callBack,
				searchStr : $("#txtExpendETaxDisp" + codeType).val(),
				erp_emp_seq : (JSON.parse($(eTaxElement.emp.info).val()).erpEmpSeq || expendUseEmp.erpEmpSeq || ''),
				erp_dept_seq : (expendEmpDeptLink ? (JSON.parse($(eTaxElement.emp.info).val()).erpDeptSeq || expendUseEmp.erpDeptSeq || '') : ''),
				acct_code : (JSON.parse($(eTaxElement.summary.info).val() || '{}').drAcctCode || ''),
				budget_code : budgetCode,
				bizplan_code : bizplanCode,
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				vat_type : ($('#hidExpendETaxVatTypeInfo').val() || ''),
				codeSortType : codeSortType
			});
		}else{ // ?????? ???????????? ???????????? ??????
			fnOpenCodePop({
				codeType : codeType,
				callback : callBack,
				searchStr : '',
				erp_emp_seq : (JSON.parse($(eTaxElement.emp.info).val()).erpEmpSeq || expendUseEmp.erpEmpSeq || ''),
				erp_dept_seq : (expendEmpDeptLink ? (JSON.parse($(eTaxElement.emp.info).val()).erpDeptSeq || expendUseEmp.erpDeptSeq || '') : ''),
				acct_code : (JSON.parse($(eTaxElement.summary.info).val() || '{}').drAcctCode || ''),
				budget_code : (budgetCode),
				bizplan_code : bizplanCode,
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				vat_type : ($('#hidExpendETaxVatTypeInfo').val() || ''),
				codeSortType : codeSortType
			});
		}
	}

    /* ????????? ?????? */
    /* ????????? ?????? ?????? - ?????? */
    function fnExpendETaxEventSearch( param ) { /* ?????? */
        param = ((typeof param == 'object' ? '' : param) || '');

        /* ???????????? */
        var data = {};
        $.extend(data, ExCodeETax);
        data.compSeq = '${ViewBag.empInfo.compSeq}';
        data.searchFromDt = $(eTaxElement.fromDate).val().toString().replace(/-/g, '');
        data.searchToDt = $(eTaxElement.toDate).val().toString().replace(/-/g, '');
        data.searchPartnerNm = $("#txtExpendETaxSearchStr").val();
        data.searchPartnerNo = $("#txtPartnerNo").val().toString().replace(/-/g, '');
        data.searchIssNo = $("#txtIssNo").val();
        
        data.expendSeq = ('${ViewBag.expendSeq}' || '0');
        //data.bizplanCode = expendWriter.erpBizSeq + "|";
        data.bizplanCode = '';
        /* ???????????? */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/ex/user/etax/ExETaxListInfoSelect.do" />';
        ajaxParam.async = true;
        ajaxParam.data = fnConvertJavaParam(data);
        ajaxParam.callback = function( data ) {
            fnExpendETaxGridListBind(data.aaData);
            if($("#txtExpendETaxSearchStr").val() != ''){
            	$("#spanShowText").hide();	
            }else{
            	$("#spanShowText").show();
            }
            isInitPage = false;
        };

        fnCallAjax(ajaxParam);

        return;
    }
    /* ????????? ?????? ?????? - ?????? - ????????? ????????? */
    function fnExpendETaxGridListBind( param ) {
        param = (param || {});
        $(eTaxElement.tableDiv).resetDataTable();
        
        eTable = $('#tblExpendETaxList').dataTable({
            "fixedHeader" : true,
            "select" : true,
            "lengthMenu" : [ [ 5, 10, 15, -1 ], [ 5, 10, 15, "All" ] ],
            "pageLength" : ($(eTaxElement.showCount).val() == '-1' ? 100 : $(eTaxElement.showCount).val()),
            "sScrollY" : 370,
            "bAutoWidth" : false,
            "paging" : true,
            "bSort" : true,
            "destroy" : true,
            "language" : dataTableLanguage,
            "bStateSave" : isInitPage,
            "fnInfoCallback" : function(oSettings, iStart, iEnd, iMax, iTotal, sPre){
            	if( Number(iMax) != 0){
            		var cPage = sPre.split(' / ')[0];
            		if( !isInitPage && cPage != currentPage){
            			currentPage = cPage;
            		}
            	}
            },
            "data" : param,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                
                $(nRow).on('click', (function() {
					if (!clickedRow) {
						clickedRow = true;
						var checkbox = $(this).find("input[name='inp_ETaxchk']:checkbox");
						checkedCheckbox = checkbox.prop("checked");
						setTimeout(function() {
							checkbox.prop("checked", !checkedCheckbox);
							clickedRow = false;
						}, 10);
						fnExpendETaxRowClick(aData);
					}
					return;
                }));
                
                $(nRow).on('dblclick', (function() {
                	fnExpendETaxRowDblClick(aData);
                    return;
                }));

                return nRow;
            },
            "columnDefs" : [ {
                "targets" : 0,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                        return '<span onclick="fnExpendETaxRowClick(data); event.stopPropagation();"><input type="checkbox" name="inp_ETaxchk" id="inp_ETaxchk' + data.issNo + '|'  + data.issDt + '|' + data.trregNb + '|' +  data.hometaxIssNo + '" value="' + data.issNo + '|' + data.issDt + '|' + data.trregNb + '|' +  data.hometaxIssNo + '|' + (data.syncId || '0') + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_ETaxchk' + data.issNo + '|'  + data.issDt + '|' + data.trregNb + '|'  +  data.hometaxIssNo + '"></label></span>';
                    } else {
                        return "";
                    }
                }
            }, {
                "targets" : 1,
                "data" : null,
                "render" : function( data ) {
                    var result = '';
                    result += '<span>[';
                    result += data.dummy2;
                    result += '] ';

                    if (data.issDt.length == 8) {
                        result += data.issDt.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
                    } else {
                        result += data.issDt;
                    }

                    result += '</span><br /><span>';
                    result += data.trNm;
                    result += '</span><br />';
					
                    //????????? ??????????????? ????????? ????????? ??????????????? ???????????? ????????? ?????? ??????????????? ????????????.
                    var issNoStr = (data.hometaxIssNo == '') ? data.issNo : data.hometaxIssNo;
                    if (issNoStr.length == 24) {
                    	issNoStr = issNoStr.toString().replace(/^(\d{8})(\d{8})(\d{8})$/, '$1-$2-$3');
                    } else {
                    	issNoStr = issNoStr;
                    }                    
                    
                    result += '<a class="text_blue" style="text-decoration:underline;cursor:pointer;" href="javascript:;" onclick="fnEtaxDetailPopup(&quot;' + data.issNo + '&quot;);">' + issNoStr + '</a>';
                    return result;
                }
            }, {
                "targets" : 2,
                "data" : null,
                "render" : function( data ) {
                    var result = '';

                    result += '<span class="fwb">';
                    data.sumAm = data.sumAm.replace('.0000', '');
                    result += data.sumAm.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    result += '</span><br /><span>';
                    data.vatAm = data.vatAm.replace('.0000', '');
                    result += data.vatAm.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    result += '</span><br /> <span>';
                    data.supAm = data.supAm.replace('.0000', '');
                    result += data.supAm.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    result += '</span>';

                    return result;
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( data ) {
                    var result = '';
                    /* ???????????? */
                    if (data.summaryCode != null && data.summaryCode != '') {
                        if (result != '') {
                            result += '<br />'
                        }

                        result += '<span>';
                        result += "${CL.ex_standardOutline} : " + data.summaryName;
                        result += '</span>';
                    }
                    /* ?????? */
                    if (data.note != null && data.note != '') {
                        if (result != '') {
                            result += '<br />'
                        }

                        result += '<span>';
                        result += "${CL.ex_note} : " + data.note;
                        result += '</span>';
                    }
                    /* ???????????? */
                    if (data.authCode != null && data.authCode != '') {
                        if (result != '') {
                            result += '<br />'
                        }

                        result += '<span>';
                        result += "${CL.ex_evidenceType} : " + data.authName;
                        result += '</span>';
                    }
                    /* ???????????? */
                    if (data.projectCode != null && data.projectCode != '') {
                        if (result != '') {
                            result += '<br />'
                        }

                        result += '<span>';
                        result += "${CL.ex_project} : " + data.projectName;
                        result += '</span>';
                    }

                    return result;
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<input type='checkbox' id='inp_ETaxchk' name='inp_ETaxchk' onclick='fnChk(this)'>",
                "bSearchable" : false,
                "bSortable" : false,
                "bVisible" : true,
                "sWidth" : "34px",
                "sClass" : "center"
            }, {
                sTitle : "${CL.ex_electronicInvoice}",
                bVisible : true,
                bSortable : false,
                sWidth : "170px",
                sClass : "td_le"
            }, {
                sTitle : "${CL.ex_amount}",
                bVisible : true,
                bSortable : false,
                sWidth : "120px",
                sClass : "td_ri"
            }, {
                sTitle : "${CL.ex_informationResolution}",
                bVisible : true,
                bSortable : false,
                sWidth : "",
                sClass : "td_le"
            }, {
                sTitle : "????????????", // ???????????? ??????
                mData  : "issDt",
                bVisible : false,
                bSortable : true,
                sWidth : "",
                sClass : "td_le"
            } ]
        });
        eTable.dataTable().fnPageChange( (Number(currentPage) - 1));
        if($(eTaxElement.showCount).val() == '??????'){
    		$(eTaxElement.showCount).val(-1);
    	}
        $('select[name=tblExpendETaxList_length]').val($(eTaxElement.showCount).val());
        $('select[name=tblExpendETaxList_length]').trigger('change');

        /* ???????????? ?????? - ?????????*/
        if($("#etaxSortingAsc").is(':checked')){
        	$("#tblExpendETaxList").DataTable().order([[4,'asc']]).draw();
        }else{
        	$("#tblExpendETaxList").DataTable().order([[4,'desc']]).draw();
        }
        return;
    }
	
    function fnEtaxDetailPopup(etaxIssNo) {
        var popup = window.open("../../../expend/np/user/UserETaxDetailPop.do?syncId=" + etaxIssNo, "", "width=900, height=520 , scrollbars=yes");
		event.stopPropagation();
    }
    
    /* ????????? ?????? ?????? - ?????? */
    function fnExpendETaxEventSave( param ) { /* ?????? */
        param = ((typeof param == 'object' ? '' : param) || '');

        var data = {};
        data.key = fnGetCheckboxInfo('inp_ETaxchk');
        if(data.key.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018831","????????? ?????? ??? ???????????? ????????????.")%>");
        	return false;
        }

        /* ????????? ?????? ?????? */
        data.empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
        if (!$(eTaxElement.emp.info).chkValid(expendType.emp)) { return; }

        /* ???????????? ?????? ?????? */
        data.summaryInfo = $(eTaxElement.summary.info).getJson(ExCodeSummary);
        if (!$(eTaxElement.summary.info).chkValid(expendType.summary)) { return; }

        /* ???????????? ?????? ?????? */
        data.authInfo = $(eTaxElement.auth.info).getJson(ExCodeAuth);
        if (!$(eTaxElement.auth.info).chkValid(expendType.auth)) { return; }

        /* ?????? ?????? ?????? *//* ?????? ?????? ???????????? ?????? ???????????? ??????. */
        data.note = ($(eTaxElement.note).val() || '');
        if (!$(eTaxElement.note).chkValid(expendType.note, data.authInfo)) { return; }

        
        /* ???????????? ?????? ?????? *//* ?????? ?????? ???????????? ?????? ???????????? ??????. */
        var isDeleteProject = false; /* ???????????? ?????? ?????? ?????? */
        if($('#txtExpendETaxDispProject').val() == '' && $(eTaxElement.project.info).val( ) != '') {
        	var projectInfo = JSON.parse( $(eTaxElement.project.info).val( ) );
			if( projectInfo.seq != 0 ){
				isDeleteProject = true;
			}
			projectInfo.seq = 0 ;
			$(eTaxElement.project.info)  .val(JSON.stringify(projectInfo));
        }
        data.isDeleteProject = isDeleteProject;
        data.projectInfo = $(eTaxElement.project.info).getJson(ExCodeProject);
        if (!$(eTaxElement.project.info).chkValid(expendType.project, data.authInfo)) { return; }

        
        /* ?????? ?????? ?????? *//* ?????? ?????? ???????????? ?????? ???????????? ??????. */
        var isDeleteCard = false; /* ?????? ?????? ?????? ?????? */
        if($('#txtExpendETaxDispCard').val() == '' && $(eTaxElement.card.info).val( ) != '') {
        	var cardInfo = JSON.parse( $(eTaxElement.card.info).val( ) );
			if( cardInfo.seq != 0 ){
				isDeleteCard = true;
			}
			cardInfo.seq = 0 ;
			$(eTaxElement.card.info).val(JSON.stringify(cardInfo)); 
        }
        data.isDeleteCard = isDeleteCard;
        data.cardInfo = $(eTaxElement.card.info).getJson(ExCodeCard);
        if (!$(eTaxElement.card.info).chkValid(expendType.card, data.authInfo)) { return; }
        
        
        /* ?????? ?????? ?????? */
        if(expendBudgetInfo.useYN ==='Y' && isUseBudget){
	        data.budgetInfo = {};
	        var budgetERPiUInfo = $(eTaxElement.budget.info).getJson(ExCodeBudget);
	        if ('${ViewBag.ifSystem}' == 'ERPiU') {
	        	data.budgetInfo = budgetERPiUInfo; /* ?????? */
	        	if($("#expendEtaxReqBudget").is(":visible") && $(".ExpendEtaxReqBudget").is(":visible")){
					if($("#txtExpendETaxDispBudget").val() === ''){
						alert("<%=BizboxAMessage.getMessage("TX000018804","??????????????? ????????? ???????????????. ????????? ???????????? ?????????.")%>");
						return false;
					}
				}
				if($("#expendEtaxReqBizplan").is(":visible") && $(".ExpendEtaxReqBizplan").is(":visible")){
					if($("#txtExpendETaxDispBizplan").val() === ''){
						alert("<%=BizboxAMessage.getMessage("TX000018805","??????????????? ????????? ???????????????. ????????? ???????????? ?????????.")%>");
						return false;
					}
				}
				if($("#expendEtaxReqBgAcct").is(":visible") && $(".ExpendEtaxReqBgAcct").is(":visible")){
					if($("#txtExpendETaxDispBgAcct").val() === ''){
						alert("<%=BizboxAMessage.getMessage("TX000018806","??????????????? ????????? ???????????????. ????????? ???????????? ?????????.")%>");
						return false;
					}
				}
	        } else if ('${ViewBag.ifSystem}' == 'iCUBE' ) {
	            data.budgetInfo.erpEmpSeq =  data.empInfo.erpEmpSeq;
	            data.budgetInfo.erpDeptSeq = data.empInfo.erpDeptSeq;
	            data.budgetInfo.erpCompSeq = data.empInfo.erpCompSeq;
	            data.budgetInfo.budYm = '';//???????????? ??????
	            data.budgetInfo.budgetJsum ='';//???????????? ??????
	            data.budgetInfo.budgetActsum ='';//???????????? ??????
	            data.budgetInfo.budgetControlYN = 'Y';//
	            data.budgetInfo.budgetYm =  expend.expendDate.substr(0, 6);
	            data.budgetInfo.budgetGbn = expendBudgetInfo.budgetType;
	            data.budgetInfo.budgetType = expendBudgetInfo.erpType;
	            data.budgetInfo.seq = ( budgetERPiUInfo.expendBudgetSeq || 0 );
	            data.budgetInfo.bgacctCode = data.summaryInfo.drAcctCode;
	            data.budgetInfo.bgacctName = data.summaryInfo.drAcctName;
	            
	            if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'D'){
	            	/* ????????? ?????? ?????? */
	            	//data.budgetInfo.budgetCode = expendUseEmp.erpDeptSeq;
	            	//data.budgetInfo.budgetName = expendUseEmp.erpDeptName;
	            	data.budgetInfo.budgetCode = data.empInfo.erpDeptSeq;
	            	data.budgetInfo.budgetName = data.empInfo.erpDeptName;
	            	data.budgetInfo.budgetGbn = 'D';
				}
	            else if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'P'){
	            	if(data.projectInfo.projectCode === ''){
	            		alert("<%=BizboxAMessage.getMessage("TX000005109","??????????????? ????????? ?????????.")%>");
	            		
	            		return false;
	            	}
	            	data.budgetInfo.budgetCode = data.projectInfo.projectCode;
	            	data.budgetInfo.budgetName = data.projectInfo.projectName;
	            	data.budgetInfo.budgetGbn = 'P';
				}
	        	
	        }
        }else if(expendBudgetInfo.useYN ==='N'){
        	data.budgetInfo = {};
        	var budgetInfo = $(eTaxElement.budget.info).getJson(ExCodeBudget);
        	data.budgetInfo = budgetInfo; /* ?????? */
        }

        data = fnConvertJavaParam(data); /* Java ????????? ??????, ?????? JSON ??? string ?????? ?????? */

        /* ???????????? */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/ex/user/etax/ExExpendETaxInfoMapUpdate.do" />';
        ajaxParam.async = true;
        ajaxParam.data = data;
        ajaxParam.callback = function( data ) {
        	//????????? ????????? input??? ?????????
			fnInitExpendETaxInput();
			
			//????????????, ??????????????? ????????????
        	$('#ExpendETaxVa, #ExpendETaxNoTax').hide();
			
			//????????????????????? ??????
            fnExpendETaxEventSearch();
        };

        fnCallAjax(ajaxParam);

        return;
    }

    /* ????????? ?????? ( ??????????????????????????? ) */
    function fnExpendETaxCallback( param ) {
        var target;
		var type = param.type;
		var nowId;
        switch (type) {
	        case expendType.emp:
	        	nowId = 'txtExpendETaxDispEmp';
	        	target = $([ eTaxElement.emp.info, eTaxElement.emp.disp
	        	             , eTaxElement.dept.info, eTaxElement.dept.disp
	        	             , eTaxElement.cc.info, eTaxElement.cc.disp ].join(', '));
	            var empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
	            /* ????????? */
	            empInfo.erpEmpName = (param.obj.erpEmpName || '');
	            empInfo.erpEmpSeq = (param.obj.erpEmpSeq || '');
	            /* ?????? */
	            empInfo.erpDeptName = (param.obj.erpDeptName || '');
	            empInfo.erpDeptSeq = (param.obj.erpDeptSeq || '');
	            /* ????????? */
                empInfo.erpBizName = (param.obj.erpBizName || '');
                empInfo.erpBizSeq = (param.obj.erpBizSeq || '');
	            if(ifSystem === 'ERPiU'){
	                /* ???????????? */
	                empInfo.erpPcName = ($('#txtExpendPcName').val() || '');
	                empInfo.erpPcSeq = ($('#txtExpendPcCode').val() || '');
	                /* ??????????????? */
	                empInfo.erpCcName = (param.obj.erpCcName || '');
	                empInfo.erpCcSeq = (param.obj.erpCcSeq || '');
	            }
	            empInfo.seq = 0;
	            param.obj = empInfo;
	        	break;
	        case expendType.dept:/* 2021-10-22 ????????? ,cardElement??? ???????????? ???????????????????????? ??????,*/
	        	target = $([ eTaxElement.dept.info, eTaxElement.dept.disp ].join(', '));
	        	
	        	/* ?????? */
	        	var empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpDeptName = (param.obj.erpDeptName || '');
                empInfo.erpDeptSeq = (param.obj.erpDeptSeq || '');
                
                param.obj = empInfo;
	        	
	        	break;
            case expendType.pc:
            	// nowId = 'txtExpendETaxDispPc';
                // target = $([ eTaxElement.emp.info, eTaxElement.pc.disp ].json(', '));
                var empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpPcName = ($('#txtExpendPcName').val() || '');
                empInfo.erpPcSeq = ($('#txtExpendPcCode').val() || '');
                empInfo.seq = 0;
                param.obj = empInfo;
                break;
            case expendType.cc:
            	nowId = 'txtExpendETaxDispCc';
                target = $([ eTaxElement.emp.info, eTaxElement.cc.disp ].join(', '));
                var empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpCcName = (param.obj.erpCcName || '');
                empInfo.erpCcSeq = (param.obj.erpCcSeq || '');
                empInfo.seq = 0;
                param.obj = empInfo;
                break;
            case expendType.summary:
            	nowId = 'txtExpendETaxDispSummary';
                target = $([ eTaxElement.summary.info, eTaxElement.summary.disp ].join(', '));
                if ('${ViewBag.ifSystem}' == 'iCUBE' && isUseBudget){
                	var budgetInfo = $(eTaxElement.budget.info).getJson(ExCodeBudget);
                	budgetInfo.bgacctCode = param.obj.drAcctCode;
                	budgetInfo.bgacctName= param.obj.drAcctName;
                }
                if(isAutoInputNoteInfo){
                	$("#txtExpendETaxNote").val(param.obj.summaryName);
                }
                
              	//???????????? ?????? ??? ???????????? ?????????(????????????, ????????????, ????????????)_ERPiU??? ??????
                if(ifSystem == "ERPiU" && '${ViewBag.isSummaryChangeReset}' == "Y"){
	                $("#txtExpendETaxDispBudget, #txtExpendETaxDispBizplan, #txtExpendETaxDispBgAcct").val("");
                }
                break;
            case expendType.auth:
            	nowId = 'txtExpendETaxDispAuth';
                target = $([ eTaxElement.auth.info, eTaxElement.auth.disp ].join(', '));
                break;
            case expendType.va: //????????????
            	nowId = 'txtExpendETaxDispVa';
                target = $([ eTaxElement.va.info, eTaxElement.va.disp ].join(', '));
                break;
            case expendType.notax: //???????????????
            	nowId = 'txtExpendETaxDispNoTax';
                target = $([ eTaxElement.noTax.info, eTaxElement.noTax.disp ].join(', '));
                break;    
            case expendType.project:
            	nowId = 'txtExpendETaxDispProject';
                target = $([ eTaxElement.project.info, eTaxElement.project.disp ].join(', '));
                break;
            case expendType.card:
            	nowId = 'txtExpendETaxDispCard';
                target = $([ eTaxElement.card.info, eTaxElement.card.disp ].join(', '));
                break;
        }

        fnSetExpendDispValue(target, param.obj, type); /* ????????? ????????? */
        
        if (type == 'auth') {
            fnSetRequired('eTax', param.obj); /* ????????? ?????? */
            
            if(ifSystem == "iCUBE"){
        		/*
					23 : ??????(????????????)
					24 : ??????(???????????????)
					26 : ??????(?????????????????????)
					?????? ?????? ???????????? ?????? ???????????? ??????.
				*/
        		switch (param.obj.vatTypeCode) {
					case '23':
					case '24':
					case '26':
						//????????????
						type = 'va'
						target = $([ eTaxElement.va.disp, eTaxElement.va.info ].join(', '));
						fnSetExpendDispValue(target, param.obj, type); 
						$('#ExpendETaxVa').show();		
						
						//???????????????
						$("#hidExpendETaxVatTypeInfo").val(param.obj.vatTypeCode);
						break;	
					default:
						//???????????? ?????????
						$('#ExpendETaxVa').hide();
					    $([ eTaxElement.va.disp, eTaxElement.va.info ].join(', ')).val("");
					    
					    //??????????????? ?????????
						$("#hidExpendETaxVatTypeInfo").val("");
					    
						var authInfoId = $(eTaxElement.auth.info);
						var authInfo = JSON.parse(authInfoId.val());
						
						authInfo.vaTypeCode = '';
						authInfo.vaTypeName = '';
						
						authInfoId.val(JSON.stringify(authInfo));		
						break;
				}
        	}else if(ifSystem == "ERPiU"){
        		/*
					22 : ??????(???????????????)
					50 : ??????(????????????)
					?????? ?????? ????????? ?????? ?????? ???????????? ??????.
				*/
				switch (param.obj.vatTypeCode) {
					case '22':
					case '50':
						//???????????????
						type = 'notax'
						target = $([ eTaxElement.noTax.disp, eTaxElement.noTax.info ].join(', '));
						fnSetExpendDispValue(target, param.obj, type); 
						$('#ExpendETaxNoTax').show();		
						break;	
					default:
						//??????????????? ?????????
						$('#ExpendETaxNoTax').hide();
						$([ eTaxElement.noTax.disp, eTaxElement.noTax.info ].join(', ')).val("");
						
						var authInfoId = $(eTaxElement.auth.info);
						var authInfo = JSON.parse(authInfoId.val());
						
						authInfo.noTaxCode = '';
						authInfo.noTaxName = '';
						
						authInfoId.val(JSON.stringify(authInfo));			
						break;
				}
        	}
        }else if(type == 'va'){
        	if(ifSystem == "iCUBE"){
        		//???????????? ????????? ???????????? ?????? ???????????? ?????? ??????
        		var authInfoId = $(eTaxElement.auth.info);
				var vaInfo = JSON.parse(authInfoId.val());
				
				vaInfo.vaTypeCode = param.obj.vaTypeCode;
				vaInfo.vaTypeName = param.obj.vaTypeName;
				vaInfo.seq = 0;
				
				authInfoId.val(JSON.stringify(vaInfo));		
				
				//????????? ??????
				$(eTaxElement.note).focus();
			}
        }else if(type == 'notax'){
        	if(ifSystem == "ERPiU"){
        		//???????????? ????????? ??????????????? ?????? ???????????? ?????? ??????
        		var authInfoId = $(eTaxElement.auth.info);
				var noTaxInfo = JSON.parse(authInfoId.val());
				
				noTaxInfo.noTaxCode = param.obj.noTaxCode;
				noTaxInfo.noTaxName = param.obj.noTaxName;
				noTaxInfo.seq = 0;
				
				authInfoId.val(JSON.stringify(noTaxInfo));	
				
				//????????? ??????
				$(eTaxElement.note).focus();
			}
        }
        fnSetFocus(nowId);
        return;
    }

    /* ????????? ?????? - ?????? */
    function fnExpendETaxCallbackBudget( param ) {
        var target;
        var budgetInfo = $(eTaxElement.budget.info).getJson(ExCodeOrg);
        var type = param.type;
        var nowId;
        switch (type) {
            case expendType.budget:
            	nowId = 'txtExpendETaxDispBudget';
                budgetInfo.budgetCode = param.obj.budgetCode;
                budgetInfo.budgetName = param.obj.budgetName;
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                target = $([ eTaxElement.budget.info, eTaxElement.budget.disp ].join(', '));
                break;
            case expendType.bizplan:
            	nowId = 'txtExpendETaxDispBizplan';
                budgetInfo.bizplanCode = (param.obj.bizplanCode || '***');
                budgetInfo.bizplanName = (param.obj.bizplanName || '***');
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                target = $([ eTaxElement.budget.info, eTaxElement.bizplan.disp ].join(', '));
                break;
            case expendType.bgacct:
            	nowId = 'txtExpendETaxDispBgAcct';
                budgetInfo.bgacctCode = param.obj.bgacctCode;
                budgetInfo.bgacctName = param.obj.bgacctName;
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                budgetInfo.cdBgLevel = (param.obj.cdBgLevel || '');
                budgetInfo.ynControl = (param.obj.ynControl || '');
                budgetInfo.tpControl = (param.obj.tpControl || '');
                target = $([ eTaxElement.budget.info, eTaxElement.bgacct.disp ].join(', '));
                break;
        }
        fnSetExpendDispValue(target, budgetInfo, type); /* ????????? ????????? */
        fnSetFocus(nowId); /* ????????? ?????? */

        return;
    }

    /* ????????? ?????? ?????? - ?????? */
    function fnExpendETaxEventCallback( param ) { /* ?????? */
    	
    	fnExpendAuthChk();
        param = ((typeof param == 'object' ? '' : param) || '');

        var data = {};
        var target = new Array();
        var tempData = fnGetCheckboxInfo('inp_ETaxchk');
        $.each(tempData, function( idx, item ) {
        	var temp = {};
        	temp.item_0 = item.item_0;
        	temp.item_1 = item.item_1;
            temp.item_2 = item.item_2;
            temp.item_3 = item.item_3;
            target.push(temp);
        });
        data.expendSeq = expend.get("expendSeq");

        if(!tempData || tempData.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018831","????????? ?????? ??? ???????????? ????????????.")%>");
        	return false;
        }else if((listCount + tempData.length) > maxListLength){
        	alert("<%=BizboxAMessage.getMessage("TX000016473","????????? ?????? ??? ??? ????????????. (?????? : ???????????? ?????? ?????? ?????? ??????.) ")%>"+ "\n" + 
    				"<%=BizboxAMessage.getMessage("TX000016481","???????????? ???????????? ?????? ??? ??? ????????????.")%>"
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016498","????????? ??????")%>" + " : "+ tempData.length
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496","????????? ?????? ??????")%>" + " : "+ maxListLength); 
    		return false;	
        }
        data.emp = JSON.stringify($(eTaxElement.emp.info).getJson(ExCodeOrg));
        data.expendSeq = expend.get("expendSeq");
		if (skipBudgetCheck != "1") {
			data.isUseBudget = isUseBudget;
		} else {
			data.isUseBudget = false;
		}
        
    	/* ?????? ???????????? ???????????? ????????? ?????? ??????/????????? ?????? ?????? */
    	if(ifSystem == 'ERPiU'){
    		var budgetUseYn = option.filter(function(item){
        	    if(item.option_code === '003302'){
        	        return item.option_value;
        	    }
        	})	
        	/* ?????? ???????????? ???????????? ????????? ?????? ??????/????????? ?????? ?????? */
            data.budgetUseYn = budgetUseYn[0].option_value;
    	}
        
        /* ???????????? ?????? ?????? ?????? */
        data.isSlipMode = isInsertSlipMode;
        /* ?????? ??? ?????? ?????? ?????? */
        data.formInfo = JSON.stringify(formInfo);
        
//         data = fnConvertJavaParam(data); /* Java ????????? ??????, ?????? JSON ??? string ?????? ?????? */
        PLP_fnInitPop();
        PLP_fnShowProgressDialog({
			title : '??????????????????????????? ??????'	
				, progText : '??????????????????????????? ????????? ??????????????????.'
				, endText : '??????????????????????????? ????????? ?????????????????????.'
				, popupPageTitle : '???????????? ?????? ????????????'
				, popupColGbn : '????????????'
				, popupColDetail : '????????????'
		});
        $('#PLP_divMainProgPop > .pop_head:not(:contains("??????"))').remove()
        $("#PLP_divMainProgPop").css("z-index",104);
        PLP_fnSetProgressValue(0, 0, target.length);
        fnRecurForSave(0, data, target);

        return;
    }
    
    /* ??????????????? ?????? ?????? */ 
    function fnRecurForSave(idx, data, orgnTarget){
    	//fnExpendAuthChk();
    	
    	var length = orgnTarget.length;
		if(idx >= length){
			// ??????????????? ?????? ??????
			PLP_fnEndProgressDialog();

			/* ?????? ?????? ?????? ????????? ?????? ?????? ??? ?????? */
			if( plp_errInfo.length == 0 ){
				$('#PLP_btnConfirm').hide();
				setTimeout(function(){
					$('#PLP_btnPopClose').click();
					$("#btnExpendETaxClose").click();
					fnExCloseLayPop();
					
				}, 400);
			} else {
				// ????????? ??????
				setTimeout(function(){
					fnExpendETaxEventSearch();
				},420);
			}
			return ;
		}
// 		data.target = orgnTarget[idx++];
		data.item_0 = orgnTarget[idx].item_0;
		data.item_1 = orgnTarget[idx].item_1;
		data.item_2 = orgnTarget[idx++].item_2;
		
		 /* ???????????? */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/ex/user/etax/ExETaxInfoMake.do" />';
        ajaxParam.async = true;
        ajaxParam.data = data;
        ajaxParam.callback = function( result ) {
        	if (result.aaData.code == 'SUCCESS') {
                window['${ViewBag.callback}']();
                PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
                fnRecurForSave(idx, data, orgnTarget);
            } else {
         	var tempKey = data.item_0; 
//          	synIdsRemove(JSON.parse(data.target)[0].key);
            	PLP_fnSetErrInfo({
					'colGbn' : $('#inp_ETaxchk' + data.item_0 + "\\|" + data.item_1 + "\\|" + data.item_2  ).parent().next('td').html()
					, 'colDetail' : result.aaData.error
				});
            	PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
            	fnRecurForSave(idx, data, orgnTarget);
            }
        };
		
        fnCallAjax(ajaxParam);
    }

    /* ?????? */
    /* ?????? - ??? ?????? */
    function fnExpendETaxRowClick( param ) {
    	fnSetRequired('eTax',param);
        /* ????????? ??????, ???????????? ??????, ???????????? ??????, ???????????? ??????, ?????? ??????, ???????????? ??????, ???????????? ??????, ?????? ?????? */
        $('input[type=hidden].ExpendETax').not(hidExpendETaxEmpInfo).inputReset();
        
        /* ????????? */
        var empInfo = $(eTaxElement.emp.info).getJson(ExCodeOrg);
        if(param.expendEmpSeq != 0){/* ????????? ?????? ???????????? ?????????????????? ?????? ????????? ?????? ?????? */
			empInfo.erpEmpSeq = param.empSeq;
			empInfo.erpEmpName = param.empName;
			empInfo.erpDeptSeq = param.deptSeq;
			empInfo.erpDeptName = param.deptName;
			empInfo.erpPcSeq = $('#txtExpendPcCode').val();
			empInfo.erpPcName = $('#txtExpendPcName').val();
			empInfo.erpCcSeq = param.erpCcSeq;
			empInfo.erpCcName = param.erpCcName;
			$(eTaxElement.emp.disp).inputInit(empInfo.erpEmpSeq, empInfo.erpEmpName);
			$(eTaxElement.dept.disp).inputInit(empInfo.erpDeptSeq, empInfo.erpDeptName);
			/* $(eTaxElement.pc.disp).inputInit(empInfo.erpPcSeq, empInfo.erpPcName); */
			$(eTaxElement.cc.disp).inputInit(empInfo.erpCcSeq, empInfo.erpCcName);
		}else{/* ????????? ?????? ???????????? ?????? ?????? ???????????? ???????????? ???????????? ????????? ?????? ?????? */
			empInfo.erpEmpSeq = expendUseEmp.erpEmpSeq;
			empInfo.erpEmpName = expendUseEmp.erpEmpName;
			empInfo.erpDeptSeq = expendUseEmp.erpDeptSeq;
			empInfo.erpDeptName = expendUseEmp.erpDeptName;
			empInfo.erpPcSeq = $('#txtExpendPcCode').val();
			empInfo.erpPcName = $('#txtExpendPcName').val();
			empInfo.erpCcSeq = expendUseEmp.erpCcSeq;
			empInfo.erpCcName = expendUseEmp.erpCcName;
			empInfo.seq = 0;
			$(eTaxElement.emp.disp).inputInit(expendUseEmp.erpEmpSeq, expendUseEmp.erpEmpName);
			$(eTaxElement.dept.disp).inputInit(expendUseEmp.erpDeptSeq, expendUseEmp.erpDeptName);
			/* $(eTaxElement.pc.disp).inputInit(expendUseEmp.erpPcSeq, expendUseEmp.erpPcName); */
			$(eTaxElement.cc.disp).inputInit(expendUseEmp.erpCcSeq, expendUseEmp.erpCcName);	
		}
		$('#hidExpendETaxEmpInfo').val( JSON.stringify(empInfo) );
        
        /* ???????????? */
        $(eTaxElement.summary.disp).inputInit(param.summaryCode, param.summaryName);
        var summaryParam = {};
		summaryParam.summaryCode = param.summaryCode;
		summaryParam.summaryName = param.summaryName;
		summaryParam.drAcctCode = param.drAcctCode;
		summaryParam.drAcctName = param.drAcctName;
		summaryParam.seq = (param.expendSummarySeq || 0);
		$(eTaxElement.summary.info).val(JSON.stringify(summaryParam));
		
        /* ?????? */
        $(eTaxElement.note).val(param.note);
		fnSetNote();

        /* ???????????? */
        $(eTaxElement.auth.disp).inputInit(param.authCode, param.authName);
        var authParam = {};
        
		//???????????? ?????? ?????????????????? ?????? ????????? ??? ??????????????? ?????? ???????????? ?????? ????????? ????????? ?????? ???????????? ??????
		authParam.seq = param.expendAuthSeq;
		authParam.authDiv = param.authDiv;
		authParam.authCode = param.authCode;
		authParam.authName = param.authName;
		authParam.cashType = param.cashType;
		authParam.crAcctCode = param.crAcctCode;
		authParam.crAcctName = param.crAcctName;
		authParam.vatAcctCode = param.vatAcctCode;
		authParam.vatAcctName = param.vatAcctName;
		authParam.vatTypeCode = param.vatTypeCode;
		authParam.vatTypeName = param.vatTypeName;
		authParam.erpAuthCode = param.erpAuthCode;
		authParam.erpAuthName = param.erpAuthName;
		authParam.authRequiredYN = param.expendAuthRequiredYN;
		authParam.partnerRequiredYN = param.expendPartnerRequiredYN;
		authParam.cardRequiredYN = param.expendCardRequiredYN;
		authParam.projectRequiredYN = param.expendProjectRequiredYN;
		authParam.noteRequiredYN = param.expendNoteRequiredYN;
		authParam.noTaxCode = param.noTaxCode;
		authParam.noTaxName = param.noTaxName;
		authParam.vaTypeCode = param.vaTypeCode;
		authParam.vaTypeName = param.vaTypeName;
		
		$(eTaxElement.auth.info).val(JSON.stringify(authParam));
		
		// ????????????
		if(ifSystem == "iCUBE" && param.vaTypeCode != ""){
			$(eTaxElement.va.disp).inputInit(param.vaTypeCode, param.vaTypeName);
			$(eTaxElement.va.info).val(JSON.stringify(authParam));
			$('#ExpendETaxVa').show();	
			
			//???????????????
			$("#hidExpendETaxVatTypeInfo").val(param.vatTypeCode);
		}else{
			$('#ExpendETaxVa').hide();	
			$([ eTaxElement.va.disp, eTaxElement.va.info, "#hidExpendETaxVatTypeInfo" ].join(', ')).val("");
		}
		
		// ???????????????
		if(ifSystem == "ERPiU" && param.noTaxCode != ""){
			$(eTaxElement.noTax.disp).inputInit(param.noTaxCode, param.noTaxName);
			$(eTaxElement.noTax.info).val(JSON.stringify(authParam));
			$("#ExpendETaxNoTax").show();	
		}else{
			$("#ExpendETaxNoTax").hide();	
			$([ eTaxElement.noTax.disp, eTaxElement.noTax.info ].join(', ')).val("");
		}
		
        /* ???????????? */
		if($(eTaxElement.project.disp).is('[disabled=disabled]') && param.projectCode == ''){
			$(eTaxElement.project.disp).inputInit(expendProject.projectCode, expendProject.projectName);
			var projectParam = {};
			projectParam.projectCode = expendProject.projectCode;
			projectParam.projectName = expendProject.projectName;
			projectParam.seq = 0;
			$(eTaxElement.project.info).val(JSON.stringify(projectParam));
		}else{
			$(eTaxElement.project.disp).inputInit(param.projectCode, param.projectName);
			var projectParam = {};
			projectParam.projectCode = param.projectCode;
			projectParam.projectName = param.projectName;
			projectParam.seq = param.projectSeq;
			$(eTaxElement.project.info).val(JSON.stringify(projectParam));
		}
        /* ?????? */
		if($(eTaxElement.card.disp).is('[disabled=disabled]') && param.cardNum == ''){
			$(eTaxElement.card.disp).inputInit(expendCard.cardNum, expendCard.cardName);
			var cardParam = {};
	        cardParam.cardCode = expendCard.cardCode;
	        cardParam.cardName = expendCard.cardName;
	        cardParam.cardNum = expendCard.cardNum; 
	        cardParam.seq = 0;
			$(eTaxElement.card.info).val(JSON.stringify(cardParam));
		}else{
			$(eTaxElement.card.disp).inputInit(param.cardNum, param.cardName);
			var cardParam = {};
	        cardParam.cardCode = param.cardCode;
	        cardParam.cardName = param.cardName;
	        cardParam.cardNum = param.cardNum;
	        cardParam.seq = param.expendCardSeq;
			$(eTaxElement.card.info).val(JSON.stringify(cardParam));
		}

		var budgetParam = {};
        if( $(eTaxElement.budget.info).val() != '' ){
        	budgetParam = JSON.parse($(eTaxElement.budget.info).val());
        }
        
        /* ???????????? */
        if(param.budgetCode != '0'){
        	$(eTaxElement.budget.disp).inputInit(param.budgetCode, param.budgetName);	
        }else{
        	$(eTaxElement.budget.disp).inputInit('', '');
        }
        /* ???????????? */
        if(param.bizplanCode != '0'){
        	$(eTaxElement.bizplan.disp).inputInit(param.bizpanCode, param.bizplanName);	
        }else{
        	$(eTaxElement.bizplan.disp).inputInit('','');
        }
        /* ???????????? */
        if(param.bgacctCode != '0'){
        	$(eTaxElement.bgacct.disp).inputInit(param.bgacctCode, param.bgacctName);	
        }else{
        	$(eTaxElement.bgacct.disp).inputInit('','');
        }
        
        budgetParam.seq = param.expendBudgetSeq;
        budgetParam.budgetCode = param.budgetCode;
        budgetParam.budgetName = param.budgetName;
        budgetParam.bizplanCode = param.bizplanCode;
        budgetParam.bizplanName = param.bizplanName;
        budgetParam.bgacctCode = param.bgacctCode;
        budgetParam.bgacctName = param.bgacctName;
        
     	// 2020. 02. 27. ?????????, ERPiU ???????????? ?????? ???????????? ?????? ????????? ????????? ???????????? ?????? ?????? ?????? ??????
        budgetParam.cdBgLevel = param.cdBgLevel;
        budgetParam.ynControl = param.ynControl;
        budgetParam.tpControl = param.tpControl;
        
        /* ???????????? */
		$(eTaxElement.budget.info).val(JSON.stringify(budgetParam));
		/* ???????????? */
		$(eTaxElement.bizplan.info).val(JSON.stringify(budgetParam));
		/* ???????????? */
		$(eTaxElement.bgacct.info).val(JSON.stringify(budgetParam));
        return;
    }
    /* ?????? - ??? ???????????? */
    function fnExpendETaxRowDblClick( param ) {
        return;
    }
    
    /* ???????????? - ????????? ?????? */
    function fnSetFocus(nowId) {
        var target = [ 'txtExpendETaxDispSummary', 'txtExpendETaxDispAuth', 'txtExpendETaxNote', 'txtExpendETaxDispProject', 'txtExpendETaxDispCard', 'txtExpendETaxDispBudget', 'txtExpendETaxDispBizplan', 'txtExpendETaxDispBgAcct' ];
        for(var i = 0 ; i < target.length ; i++){
			if(nowId == ''){
				$('#txtExpendETaxDispSummary').focus();
			}else if(target[i] == nowId && i < target.length){
				$('#' + target[(i+1)]).focus();
			}
		}
        inputFlag = true;
        return;
    }
    
    /* ????????? ?????? ?????? - ????????? */
    function fnExpendETaxInfoReset(){
    	if(!confirm("????????? ????????? ???????????????????")) {
    		return;
    	}
    	
    	var data = {};
    	var temp = [];
    	
    	data.target = fnGetCheckboxInfo('inp_ETaxchk');    	
    	$.each(data.target, function( idx, item ) {
    		if((item.item_4 || '') != '' && (item.item_4 || '') != '0') {
    			data.target[idx].syncId = item.item_4;
    			temp.push($.extend({}, data.target[idx]));
    		}
        });
    	
    	data.target = temp;
    	
        /* ???????????? */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/expend/ex/user/etax/ExETaxInfoMapReset.do"/>';
        ajaxParam.async = false;
        ajaxParam.data = fnConvertJavaParam(data);
        ajaxParam.callback = function( data ) {
			//????????? ????????? input??? ?????????
			fnInitExpendETaxInput();
			
			//????????????, ??????????????? ????????????
        	$('#ExpendETaxVa, #ExpendETaxNoTax').hide();
            
			//????????????????????? ??????
            $('#btnExpendETaxSearch').click();
        };

        fnCallAjax(ajaxParam);
    }
    
    //????????? ????????? input??? ?????????
    function fnInitExpendETaxInput(){
    	//?????????, ??????, ??????????????? ????????? ??????
    	var notInitItem = ["emp", "dept", "cc"];
    	
    	//eTaxElement ???????????? ??????
    	$.each(eTaxElement, function(key, val){
    		//?????? ??????????????? ????????? ?????? ?????? notInitItem??? ???????????? ?????? ?????? ?????????
    		if(typeof val == "object" && notInitItem.indexOf(key) == -1){
	    		$.each(val, function(subKey, subVal){
	        		//disp, info input ?????? ?????????
	        		$(subVal).val("");
	    		});
    		}
    		
    		//????????? ?????? ??????????????? ?????? ????????? ?????? ?????????
    		if(key == "note"){
    			$(val).val("");
    		}
    	});
    }
    
    /* ERPiU - ?????? ?????? ?????? - ????????? ????????? */
	function fnExpendERPiUBudgetChk(){
    	
		var budgetInfo = JSON.parse(($('#hidExpendETaxERPiUBudgetInfo').val() || '{}'));
		
		if(expend.get("erpiuBudgetVer") != "" && (budgetInfo.ynControl || '') !== 'Y') {
			alert('???????????? ????????? ????????????.');
			return;
		}
		
		var bgParam = "?callback=&bgacct_code=" + budgetInfo.bgacctCode
		bgParam += "&bgacct_name=" + escape(encodeURIComponent(budgetInfo.bgacctName))
		bgParam += "&budget_code=" + budgetInfo.budgetCode;
		bgParam += "&bizplan_code=" + (budgetInfo.bizplanCode || '***');
		bgParam += "&amt=0";
		bgParam += "&budget_ym=" + ($('#txtExpendDate').val().toString().replace(/-/g, '') || budgetInfo.budgetYm +'01' );
		bgParam += "&drcr_gbn=dr";
		bgParam += "&expendSeq=" + expend.expendSeq;
		bgParam += "&listSeq=0";
		bgParam += "&basicListAmt=0";
		bgParam += "&cd_bg_level=" + (budgetInfo.cdBgLevel || '');
		bgParam += "&yn_control=" + (budgetInfo.ynControl || '');
		bgParam += "&tp_control=" + (budgetInfo.tpControl || '');
		
		var popParam = {};
		popParam.title = "${CL.ex_budgetChk}";
		popParam.width = '';
		popParam.height = '';
		popParam.opener = '3';
		popParam.parentId = '';
		popParam.childId = '';
		popParam.getParam = bgParam;
		var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;
		
		var popupWidth = 500;
		var popupHeight = 380;
		var windowX = (screen.width - popupWidth)/2;
		var windowY = (screen.height - popupHeight)/2;
		
		window.open(url,'????????????',"width=500,height=280,left=" + windowX + ",top=" + windowY);
    	
		return;	
	}
    
	/* iCUBE - ?????? ?????? ?????? */
	function fnExpendiCUBEBudgetChk(){

		var budgetInfoProject = JSON.parse(($('#hidExpendETaxProjectInfo').val() || '{}'));
		var budgetInfoeErpDept = JSON.parse(($('#hidExpendETaxEmpInfo').val() || '{}'));
		 
			if ($("#hidExpendETaxSummaryInfo").val() !== '') {
				var acctInfo = JSON.parse($("#hidExpendETaxSummaryInfo").val())
				
				_acct_code = (acctInfo.drAcctCode || 0);
				_acct_name = (acctInfo.drAcctName || '');
				if (_acct_code === 0) {
					alert("<%=BizboxAMessage.getMessage("TX000018816","????????? ?????????????????????")%>");
					return;
				}
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000007236","??????????????? ????????? ?????????.")%>");
				return;
			}
			
			if ( expendBudgetInfo.budgetType === "D" ) { 
				_budget_code = budgetInfoeErpDept.erpDeptSeq;
				
			} else if ( expendBudgetInfo.budgetType === "P" ) {
				
				if(budgetInfoProject.projectCode && budgetInfoProject.projectCode != '' && budgetInfoProject.projectCode != '0'){
					
					if( (budgetInfoProject.projectCode || '') === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","??????????????? ???????????? ????????????.")%>");
						return false;
					}
					
					_budget_code = budgetInfoProject.projectCode;	
					
				}else{
					
					if( (budgetInfoProject.projectCode || '') === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","??????????????? ???????????? ????????????.")%>");
						return false;
					}
					
					_budget_code = budgetInfoProject.projectCode;
				}
				
			} else {
				
				alert("<%=BizboxAMessage.getMessage("TX000018818","???????????? ????????? ?????????????????????")%>");
				return;
			}

			var bgParam = "?callback=&acct_code=" + _acct_code
					+ "&acct_name=" + escape(encodeURIComponent(_acct_name))
					+ "&budget_code=" + _budget_code
					+ "&amt=" + '0'
					+ "&budget_ym=" + (expend.expendDate || fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, '')) )
					+ "&drcr_gbn=" + 'dr'
					+ "&expendSeq=" + expend.expendSeq
					+ "&listSeq=" + 0
					+ "&basicListAmt=" + "0" ;
			var popParam = {};
			popParam.title = "${CL.ex_budgetChk}";
			popParam.width = '';
			popParam.height = '';
			popParam.opener = '3';
			popParam.parentId = '';
			popParam.childId = '';
			popParam.getParam = bgParam;
			var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;

			var popupWidth = 500;
		    var popupHeight = 380;
		    var windowX = (screen.width - popupWidth)/2;
		    var windowY = (screen.height - popupHeight)/2;
		    
			window.open(url,"${CL.ex_budgetChk}","width=500,height=280,left=" + windowX + ",top=" + windowY);
	}
</script>

<!-- ????????? ?????? -->
<input id="hidExpendETaxEmpInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxSummaryInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxAuthInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxVaInfo" class="ExpendETax" type="hidden" />
<!-- ??????????????? ?????? -->
<input id="hidExpendETaxNoTaxInfo" class="ExpendETax" type="hidden" />
<!-- ??????????????? ?????? -->
<input id="hidExpendETaxVatTypeInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxProjectInfo" class="ExpendETax" type="hidden" />
<!-- ?????? ?????? -->
<input id="hidExpendETaxCardInfo" class="ExpendETax" type="hidden" />
<!-- ?????? ?????? -->
<input id="hidExpendETaxERPiUBudgetInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxBizplanInfo" class="ExpendETax" type="hidden" />
<!-- ???????????? ?????? -->
<input id="hidExpendETaxBgAcctInfo" class="ExpendETax" type="hidden" />
<!-- ?????? ?????? -->
<input id="hidExpendETaxSelected" class="ExpendETax" type="hidden" />

<div class="pop_wrap_dir pop_auto_hei pop_wrap_dir_expend" style = "position:fixed;" id="layerExpendETax">
	<div class="pop_con">
		<div class="top_box clear">
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage("TX000000696","??????")%></dt>
				<dd>
					<input id="txtExpendETaxFromDate" class="dpWid" /> ~ <input id="txtExpendETaxToDate" class="dpWid" />
				</dd>
				<dt>${CL.ex_supplier}</dt>
				<dd>
					<input id="txtExpendETaxSearchStr" type="text" style="width: 180px;ime-mode:active" value=""/>
				</dd>
				<dd>
					<div class="controll_btn p0">
						 <button id="btnExpendETaxSearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>				
			</dl>
			<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724","????????????")%><img id="all_menu_btn"
				  src='../../../Images/ico/ico_btn_arr_down01.png' />
			</span>
		</div>
		<!-- ?????????????????? -->
		<div class="SearchDetail mb5">
			<dl>
				<dt style="width: 60px;">${CL.ex_confirmationNumber}</dt>
				<dd class="mr5">
					<input id="txtIssNo" type="text" value="" style="width: 250px">
				</dd>
				<dt style="width: 100px;">${CL.ex_corporateRegistrationNumber}</dt>
				<dd class="mr5">
					<input id="txtPartnerNo" type="text" value="" style="width: 250px">
				</dd>
			</dl>
		</div>
		
		
		<table class="mt10" style="width: 100%;">
			<colgroup>
				<col style="" />
				<col style="width: 35%" />
			</colgroup>
			<tr>
				<!-- ???????????? -->
				<td class="vt">
					<div class="btn_div mt0">
						<div class="left_div">
							<p class="tit_p m0 mt5">${CL.ex_useDetails}</p>
							
						</div>
						<div class="right_div">
							<span id="spanShowText">????????? ??? ????????? ?????? ${eTaxDefault} ?????? ???????????? ???????????????.</span>
							<span class="mr5">??? ${CL.ex_numberItem} </span> <input id="selExpendETaxShowCount" style="width: 60px;" class="kendoComboBox" />
						</div>
					</div>
					<!-- ????????? -->
					<div id="divExpendETaxList" class="com_ta2">
						<table id="tblExpendETaxList">
						</table>
					</div>
				</td>
				<!-- ?????? -->
				<td class="vt pl10">
					<div class="btn_div mt0">
						<div class="right_div">
							<div id="" class="controll_btn p0">
								<div class="fl mt3" style="margin-right: 40px;">
									<input type="radio" name="etaxSorting" id="etaxSortingAsc" class="" checked="checked"/> 
									<label class="" for="etaxSortingAsc">${CL.ex_PastList} <!--?????????--></label> 
									<input type="radio" name="etaxSorting" id="etaxSortingDesc" class="" />
									<label class="" for="etaxSortingDesc">${CL.ex_Lately} <!--?????????--></label>
								</div>
								<button id="btnExpendETaxInfoReset" class="k-button">${CL.ex_reset}</button><!-- ??????????????? ?????? ????????? -->
								<button id="btnExpendETaxSave" class="k-button ExpendETax">${CL.ex_save}</button>
							</div>
						</div>
					</div>
					<!-- ????????? -->
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="100" />
								<col width="" />
							</colgroup>
							<tr>
								<th>${CL.ex_user}</th>
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispEmp" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxEmpPop" class="btn_sear ExpendETax" href="#"></a>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_useDepartment}</th>
								<td class="dod_search">
									<input id="txtExpendETaxDispDept" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxDeptPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<%-- <tr>
								<th>${CL.ex_accountingUnit}</th>
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispPc" type="text" style="width: 90%;" value="" /> <a id="btnExpendETaxPcPop" class="btn_sear" href="#"></a>
								</td>
							</tr> --%>
							<tr>
								<th>${CL.ex_costCenter}</th>
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispCc" type="text" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxCcPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr>
								<th>
									<img id="eTaxReqSummary" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_standardOutline}
								</th>
								<td class="dod_search">
								 <div class="posi_re mb5">
									<input id="txtExpendETaxDispSummary" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> 
									<a id="btnExpendETaxSummaryPop" class="btn_sear ExpendETax" href="#"></a>
									</div>
									<input id= "btnListiCUBEBudgetChk" style="width: 45%"; type = "button" value="????????????"/>
								</td>
							</tr>
							<tr>
								<th>
									<img id="eTaxReqAuth" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_evidenceType}</th>
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispAuth" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxAuthPop" class="btn_sear ExpendETax" href="#" ></a>
								</td>
							</tr>
							<tr id="ExpendETaxVa" style="display: none;">
								<th>
									<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_reasonType}</th><!-- ???????????? -->
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispVa" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxVaPop" class="btn_sear ExpendETax" href="#"></a>
								</td>
							</tr>
							<tr id="ExpendETaxNoTax" style="display: none;">
								<th>
									<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_noType}</th><!-- ??????????????? -->
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispNoTax" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxNoTaxPop" class="btn_sear ExpendETax" href="#"></a>
								</td>
							</tr>
							<tr>
								<th>
									<img style="display:none;" id="eTaxReqNote" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_note}
								</th>
								<td class="">
									<input id="txtExpendETaxNote" type="text" class="ExpendETax" style="width: 104%;" value="" />
								</td>
							</tr>
							<tr class="ExpendETaxProject">
								<th>
									<img id="eTaxReqProject" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_project}
								</th>
								<td class="dod_search posi_re">
									<input id="txtExpendETaxDispProject" type="text" class="ExpendETax ExpendETaxProject" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxProjectPop" class="btn_sear ExpendETax ExpendETaxProjectBtn" href="#" ></a>
								</td>
							</tr>
							<tr calss="ExpendETaxCard">
								<th>
									<img id="eTaxReqCard" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_card}
								</th>
								<td class="dod_search  posi_re">
									<input id="txtExpendETaxDispCard" type="text" class="ExpendETax ExpendETaxCard" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxCardPop" class="btn_sear ExpendETax ExpendETaxCardtBtn" href="#"  ></a>
								</td>
							</tr>
							<tr class="ExpendEtaxReqBudget ExpendEtaxBudget">
								<th>
									<img id="expendEtaxReqBudget" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_budgetUnit}
								</th>
								<td class="dod_search  posi_re">
									<input id="txtExpendETaxDispBudget" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxBudgetPop" class="btn_sear ExpendETax" href="#"></a>
								</td>
							</tr>
							<tr class="ExpendEtaxReqBizplan ExpendEtaxBudget">
								<th>
									<img id="expendEtaxReqBizplan" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_businessPlan}
								</th>
								<td class="dod_search  posi_re">
									<input id="txtExpendETaxDispBizplan" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/> <a id="btnExpendETaxBizplanPop" class="btn_sear ExpendETax" href="#"></a>
								</td>
							</tr>
							<tr class="ExpendEtaxReqBgAcct ExpendEtaxBudget">
								<th>
									<img id="expendEtaxReqBgAcct" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
									${CL.ex_budgetAccount}
								</th>
								<td class="dod_search">
								<div class="posi_re mb5">
									<input id="txtExpendETaxDispBgAcct" type="text" class="ExpendETax" style="width: 90%;" value="" autocomplete="off"/>
									<a id="btnExpendETaxBgAcctPop" class="btn_sear ExpendETax" href="#"></a>
								</div>
									<input id= "btnListERPiUBudgetChk" style="width: 45%;" type = "button" value="????????????"/>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<div class="ac mt10" id ="divAuthDate">
			<input id = "chkAuthDate" class="mr5" type ="checkbox" />
			<labe id = "laAuth"l>??????????????? ??????????????? ??????????????? ??????</label>
		</div>
	</div>
	<!-- //pop_con -->
	<div class="pop_foot">
		<!-- ??????????????? ?????? -->
		<div class="btn_cen pt12">
			<input id="btnExpendETaxCallback" class="ExpendETax" type="button" value="<%=BizboxAMessage.getMessage("TX000000423","??????")%>" /> 
			<button id="btnExpendETaxClose" class="gray_btn ExpendETax">${CL.ex_cancel}</button>
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->