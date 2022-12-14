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
	<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/ExAmtCommon.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.event.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.format.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.pop.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.valid.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
   
	<script type="text/javascript">
		var defaultInfo = {};
		var eaType = "";
		
		$(document).ready(function() {
			defaultInfo = {
				budgetNm : decodeURI('${budgetNm}'),
				budgetCd : decodeURI('${budgetCd}'),
				budgetYm : decodeURI('${budgetYm}'),
				budgetFg : decodeURI('${budgetFg}'),
				acctNm : decodeURI('${acctNm}'),
				acctCd : decodeURI('${acctCd}'),
				dataFg : decodeURI('${dataFg}'),
				budYmType : decodeURI('${budYmType}')
			}; 
			
			fnAdminYesilDetailPopInit();
			fnAdminYesilDetailPopEventInit();
			
			fnGetMaingridData(1);
		});
		
		//???
		function tab_nor_Fn(num){
			$(".tab"+num).show();
			$(".tab"+num).siblings().hide();
			
			var inx = num -1
	
			$(".tab_nor li").eq(inx).addClass("on");
			$(".tab_nor li").eq(inx).siblings().removeClass("on");
			
			/* common.js ?????? ?????? ?????? tab_nor_Fn ?????? ??????
			 * $(document).ready(function(){}) ?????? ?????? ?????? ??????????????? 
			 * ????????? ?????? ?????? ?????? 
			 */
			if(num != undefined)
				fnGetMaingridData(num);
		}
		
		/* ????????? */
		function fnAdminYesilDetailPopInit() {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopInit');
			fnAdminYesilDetailPopLayout();
			fnAdminYesilDetailPopDatepicker();
			fnAdminYesilDetailPopInitInput();
			fnAdminYesilDetailPopInitButton();
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopInit');
			return;
		}
		
		/* ????????? - Layout */
		function fnAdminYesilDetailPopLayout() {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopLayout');
			$('#tbl_top tr td:eq(0)').text(defaultInfo.budgetYm + "<%=BizboxAMessage.getMessage("TX000000435","???")%>");
			$('#tbl_top tr td:eq(1)').text(defaultInfo.budYmType);
			$('#tbl_top tr td:eq(2)').text('( '+ defaultInfo.budgetCd + ' ) '+defaultInfo.budgetNm);
			$('#tbl_top tr td:eq(3)').text('( '+ defaultInfo.acctCd+ ' ) '+defaultInfo.acctNm);
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopLayout');
			return;
		}
		
		/* ????????? - Datepicker */
		function fnAdminYesilDetailPopDatepicker() {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopDatepicker');
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopDatepicker');
			return;
		}
		
		/* ????????? - Event */
		function fnAdminYesilDetailPopEventInit() {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopEventInit');
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopEventInit');
			return;
		}
		
		/* ????????? - Input */
		function fnAdminYesilDetailPopInitInput() {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopInitInput');
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopInitInput');
			return;
		}
		
		/* ????????? - Button */
		function fnAdminYesilDetailPopInitButton(defaultInfo) {
			log('+ [AdminYesilDetailPop] fnAdminYesilDetailPopInitButton');
			//????????????
			$(".controll_btn button").kendoButton();
			
			$('#closeBtn').click(function(){
				window.close();
			});
			log('- [AdminYesilDetailPop] fnAdminYesilDetailPopInitButton');
			return;
		}
		
		/* ???????????? ?????? */
		function fnSetParamData(num){
			var param = {};
			
			var budgetYm = defaultInfo.budgetYm; 
			var sendYn = "";
			var budgetDate = "";
			
			if(defaultInfo.dataFg == 'Q'){
				var type = defaultInfo.budYmType;
				if(type.substring(0,1) == 1){
					budgetDate = "'"+budgetYm +"01','" + budgetYm + "02','" + budgetYm + "03'";
				}else if(type.substring(0,1) == 2){
					budgetDate = "'"+budgetYm +"04','" + budgetYm + "05','" + budgetYm + "06'";
				}else if(type.substring(0,1) == 3){
					budgetDate = "'"+budgetYm +"07','" + budgetYm + "08','" + budgetYm + "09'";
				}else if(type.substring(0,1) == 4){
					budgetDate = "'"+budgetYm +"10','" + budgetYm + "11','" + budgetYm + "12'";
				}
			}else if(defaultInfo.dataFg == 'H'){
				var type = defaultInfo.budYmType;
				if(type == "<%=BizboxAMessage.getMessage("TX000009443","?????????")%>"){
					budgetDate = "'"+budgetYm + "01','" + budgetYm + "02','" + budgetYm + "03','" + budgetYm + "04','" + budgetYm + "05','" + budgetYm + "06'";
				}else if(type == "<%=BizboxAMessage.getMessage("TX000009442","?????????")%>"){
					budgetDate = "'"+budgetYm + "07','" + budgetYm + "08','" + budgetYm + "09','" + budgetYm + "10','" + budgetYm + "11','" + budgetYm + "12'";	
				}
			}else if(defaultInfo.dataFg == 'M'){
				budgetDate = "'"+budgetYm + defaultInfo.budYmType.substring(0,2)+"'";
			}
			
			if(num == 1){
				sendYn = "";
			}else if(num == 2){
				sendYn = "Y";
			}
			
			param.acctCd = defaultInfo.acctCd;
			param.budgetCd = defaultInfo.budgetCd;
			param.budgetDate = budgetDate;
			param.sendYn = sendYn;
			
			return param;
		}
		
		/* [ ????????? ?????? ] ????????? ??????
		-----------------------------------------------*/
		function fnResizeForm() {
			var strWidth = $('.pop_wrap').outerWidth() + (window.outerWidth - window.innerWidth);
			var strHeight = $('.pop_wrap').outerHeight() + (window.outerHeight - window.innerHeight);
			
			$('.pop_wrap').css("overflow","auto");
			
			var isFirefox = typeof InstallTrigger !== 'undefined';
			var isIE = false || !!document.documentMode;
			var isEdge = !isIE && !!window.StyleMedia;
			var isChrome = !!window.chrome && !!window.chrome.webstore;
			
			if(isFirefox){
				
			}if(isIE){

			}if(isEdge){
				strWidth = 1100;
				strHeight = 650;
			}if(isChrome){
			}
			
			try{
				window.resizeTo(strWidth, strHeight);
			    
			}catch(exception){
				console.log('window resizing cat not run dev mode.');
			}
		}
		
		function fnGetMaingridData(num){
			var param = fnSetParamData(num);
			
			// ?????? ?????? ??? ?????? ????????? ??????
		    $.ajax({
		        type : 'post',
		        url : '<c:url value="/ex/expend/admin/ExAdminYesilDetailPopInfo.do" />',
		        datatype : 'json',
		        async : true,
		        data : param,
		        success : function( data ) {	  
		        	eaType = data.eaType;
		        	fnSetMainList(data.result.params);
		        	fnResizeForm();
		        },
		        error : function( data ) {
		            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
		        }
		    });
		}
		
		function fnSetMainList(data){
			
			var id = "";
			$(".tab_nor ul li").each(function(){
				if( $(this).hasClass('on') == true){
					id = $(this).attr('id');
				}
			});
			
			var total_expend = data.total_expend || '0';
			total_expend = total_expend.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			$('#'+id+'_total').text(total_expend+"<%=BizboxAMessage.getMessage("TX000000626","???")%>" );
			
			$table = $('#'+id+'_tbl');
			
			$table.DataTable({
				aaSorting: [],
				fixedHeader : false,
				bJQueryUI : true, //jQuery UI ????????? ????????????
				bProcessing : true, //?????? ??? ??????
				bServerSide : false,
				bDestroy : true,
				bAutoWidth : false,
				ordering : true,
				info : false, 
				pageLength : 8,
				"lengthMenu" : [ [ 10, -1 ], [ 10, "All" ] ],
				"language" : {
	                "lengthMenu" : "?????? _MENU_",
	                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
	                "info" : "_PAGE_ / _PAGES_",
	                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
	                "infoFiltered" : "(?????? _MAX_ ???.)"
	            },
				"fnDrawCallback": function() {
			        $table.dataTable()._fnScrollDraw();        
			        $table.closest(".dataTables_scrollBody").height(300); //?????? Tbody height ??????
				},
			   	scrollY : "300px", //max-height ??????
			   	scrollX : false,
				scrollCollapse : true, 
				data: data.resultData,
				"fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
					$(nRow).css("cursor", "pointer");
					
					$(nRow).on("click" , function(){
						if( aData.doc_sts_cd == '10'){	// ??????????????? ?????? ???????????? ?????? ??????
							if( ${erpEmpCd} == aData.ex_emp_no ){
								var size = popupAutoResize();
								var url = '/'+ eaType +'/ea/docpop/EAAppDocViewPop.do' + '?form_id=' + aData.form_id + '&doc_id=' + aData.doc_id;
								window.open(url, "AdminYesil", "width=" + size.width + ", height=" + size.height + ", left=" + size.left + ", top=" + size.top + ", scrollbars=yes"  );
							}else{
								alert("<%=BizboxAMessage.getMessage("TX000019005","???????????? ????????? ???????????? ?????? ??? ??? ????????????.")%>");
							}
						}else{
							var size = popupAutoResize();
							var url = '/'+ eaType +'/ea/docpop/EAAppDocViewPop.do' + '?form_id=' + aData.form_id + '&doc_id=' + aData.doc_id;
							window.open(url, "AdminYesil2", "width=" + size.width + ", height=" + size.height + ", left=" + size.left + ", top=" + size.top + ", scrollbars=yes" );
						}
						
					}); 
				},
				columnDefs : [ {
	    			"targets" : 0,
	    			"data" : null,
	    			"render"  : function(data) {
	    				return  data.expend_date || '' ;
	    			}
	    		},{
	    			"targets" : 1,
	    			"data" : null,
	    			"render"  : function(data) {
	    				return  data.ea_user_nm || '' ;
	    			}
	    		}, {
	    			"targets" : 2,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.ea_dept_nm || '' ;
	    			}
	    		}, {
	    			"targets" : 3,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.ex_emp_nm || '' ;
	    			}
	    		}, {
	    			"targets" : 4,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.ex_dept_nm || '' ;
	    			}
	    		}, {
	    			"targets" : 5,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.doc_title || '' ;
	    			}
	    		}, {
	    			"targets" : 6,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	    			}
	    		}, {
	    			"targets" : 7,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.card_num || '' ;
	    			}
	    		}, {
	    			"targets" : 8,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.doc_sts || '' ;
	    			}
	    		}, {
	    			"targets" : 9,
	    			"data" : null,
	    			"render" : function(data) {
	    				return  data.doc_no || '' ;
	    			}
	    		} ],
				aoColumns : //????????? ???????????? ??????
				[
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000019000","????????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "80"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000499","?????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "70"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000500","????????????")%>",
						bVisible : true,
						bSortable : true,
						sClass : "",
						sWidth : ""
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000019001","?????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "70"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000009968","????????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "",
						sClass : ""
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000003457","????????????")%>",
						bVisible : true,
						bSortable : true,
						sClass : "",
						sWidth : "200"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000552","??????")%>",
						bVisible : true,
						bSortable : true,
						sClass : "",
						sWidth : "90"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000526","????????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "125"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000005832","????????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : "70"
					},
					{
						sTitle : "<%=BizboxAMessage.getMessage("TX000000663","????????????")%>",
						bVisible : true,
						bSortable : true,
						sWidth : ""
					}
				]
			});
		}
		
		/*[??????] ???????????? ?????? ????????? ?????? */
		function popupAutoResize() {
		    var maxThisX = 1000;
		    var maxThisY = screen.height - 150;
		    
		    if(maxThisX > 1000) {
		    	maxThisX = 1000;
		    }
		    var marginY = 0;
		    // ??????????????? ?????? ??????. (?????? ??? ????????? ????????? ????????????.)
		    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45;        // IE 6.x
		    else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75;    // IE 7.x
		    else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
		    else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
		    else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape

	        maxThisY = maxThisY - marginY;
		    
		    var dual = 0;
	        if('availLeft' in screen&&screen.availLeft > 0){ 
	            dual=screen.availLeft; 
	        } 
	        
		    // ?????? ??????
		    var windowX = dual + (screen.width - (maxThisX+10))/2;
		    var windowY = (screen.height - (maxThisY))/2 - 20;
		    
		    var size = {
		    	width : maxThisX,
		    	height: maxThisY,
		    	left : windowX,
		    	top : windowY
		    };
		    
		    return size;
		}
		
	</script>

<div class="pop_wrap" style="width: 1100px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000019002","???????????? ???????????? ??????")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con">
		<div class="com_ta">
			<table id="tbl_top">
				<colgroup>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000003649","????????????")%></th>
					<td></td>
					<th><%=BizboxAMessage.getMessage("TX000000696","??????")%></th>
					<td></td>
					<th><%=BizboxAMessage.getMessage("TX000007201","????????????")%></th>
					<td></td>
					<th><%=BizboxAMessage.getMessage("TX000005263","????????????")%></th>
					<td></td>
				</tr>
			</table>
		</div>
			
		<div class="posi_re cl mt20">
			<div class="tab_nor" >
				<ul>
					<li id="noTrans" class="on"><a href="javascript:tab_nor_Fn(1);"><%=BizboxAMessage.getMessage("TX000019003","????????? ????????????")%></a></li>
					<li id="yesTrans"><a href="javascript:tab_nor_Fn(2)"><%=BizboxAMessage.getMessage("TX000019004","?????? ????????????")%></a></li>
				</ul>
			</div>
			
			<div class="tab_area">
				<!-- ????????? ???????????? ??? --------------------------------------------------------------------------------------------------------------------->
				<div class="tab1">
					<div class="btn_div mt20">
						<div class="left_div">
							<p class="tit_p m0 mt5"><%=BizboxAMessage.getMessage("TX000005432","?????????")%> <span id="noTrans_total"></span></p>
						</div>
					</div>
					
					<div class="com_ta2 bg_lightgray">
						<table id="noTrans_tbl"></table>
					</div>
				</div>
				
				<!-- ?????? ???????????? ??? --------------------------------------------------------------------------------------------------------------------->
				<div class="tab2" style="display:none;">
					<div class="btn_div mt20">
						<div class="left_div">
							<p class="tit_p m0 mt5"><%=BizboxAMessage.getMessage("TX000005432","?????????")%> <span id="yesTrans_total"></span></p>
						</div>
					</div>
					<div class="com_ta2 bg_lightgray">
						<table id="yesTrans_tbl"></table>
					</div>
				</div>
			</div>
		</div>
	</div><!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="closeBtn" value="<%=BizboxAMessage.getMessage("TX000002972","??????")%>" />
		</div>
	</div><!-- //pop_foot -->
</div><!-- //pop_wrap -->
