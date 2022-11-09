<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
 /**
  * @Class Name : AcBgtStepStatusView.jsp
  * @Description : 예산단계별현황
  * @Modification Information
  */

%>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ac/g20/acG20State.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ac/g20/acG20Code.js"></c:url>'></script>

<script type="text/javascript">
var BudgetConStatus = {};

$(function(){
	
	$("#DIV_CD").data("kendoComboBox");
	$("#DIV_FG").data("kendoComboBox");
	acG20State.init();
	$("#BGT_DIFF_D").data("kendoComboBox").value("6");
	
	acG20State.fnStateInit();	
    
	
    /*조회버튼*/
    $(".btnSearch").click(function(){
//         if("${link_yn}" =="N"){
//         	alert("${message}");
//             return;       
//         }

//         $("#searchYN").val("Y" );                       
//         $("#EXCEL_YN").val("N" );
        //$("form#searchForm").submit();
        BudgetConStatus.seachList();
    });
    
    $("#btnExcel").click(function(){
    	$("#grid").data("kendoGrid").saveAsExcel();
    	
//         if("${link_yn}" =="N"){
//             alert("ERP 연동되어 있지 않습니다. 관리자에게 문의 바랍니다. ");
//             return;       
//         }
//         $("#searchYN").val("N" );
//         $("#EXCEL_YN").val("Y" ); 
//         //$("form#searchForm").submit();
//         BudgetConStatus.seachListExcel();
	});

    BudgetConStatus.seachList();
    
});
    
BudgetConStatus.seachList = function(){
	
	modal(true);
	var tblParam = {};
	tblParam.CO_CD       = $("#CO_CD").val();
	tblParam.GISU        = $("#GISU").val();
	tblParam.DIV_CD      = $("#DIV_CD").val();
	tblParam.DIV_CDS     = $("#DIV_CD").val() + "|";
	tblParam.MGT_CD      = $("#MGT_CD").val();
	tblParam.MGT_CDS     = $("#MGT_CDS").val();
	tblParam.ZEROLINE_FG = $("#ZEROLINE_FG").val();
	tblParam.DIV_FG      = $("#DIV_FG").val();
	tblParam.GR_FG       = $("#GR_FG").val();
// 	tblParam.BGT_CNT     = $("#BGT_CNT").val() || "0";
	tblParam.BGT_CD_FROM = $("#BGT_CD_FROM").val();
	tblParam.BGT_CD_TO   = $("#BGT_CD_TO").val();
	tblParam.BGT_CD_TO   = $("#BGT_DIFF_S").val();
	tblParam.BGT_CD_TO   = $("#BGT_DIFF_D").val();
	tblParam.DATE_FROM   = $("#DATE_FROM").val();
	tblParam.DATE_TO     = $("#DATE_TO").val();
	tblParam.FR_DT       = $("#FR_DT").val();
	tblParam.TO_DT       = $("#TO_DT").val();
	tblParam.EMP_CD      = $("#EMP_CD").val();
	tblParam.BOTTOM_CD   = $("#BOTTOM_CD").val();
	tblParam.BOTTOM_CDS   = $("#BOTTOM_CD").val() + "|";
	
    var opt = {  
            type:"post",
            url: '<c:url value="/Ac/G20/State/getErpBgtStepStatus.do" />' ,
            datatype:"json",        
            data: tblParam,
            success:function(data){     
            	if(data.selectList){
            		//grid table
                    $("#grid").kendoGrid({ 
                    	dataSource: data.selectList,
                    	excel: {
                    		filterable:true,
                    		allPages: true,
                    		fileName: "예실단계별현황.xlsx"
                    		},                	
                        columns: [                    
                            {
                                field:"BGT_CD", title:"예산코드", 
                                width:112,
                                headerAttributes: {style: "text-align:center;"}, 
                                attributes: {style: "text-align:left;"},
                            },
                            {
                                field:"DIV_FG_NM", 
                                title:"구분",
                                width:54,
                                headerAttributes: {style: "text-align:center;"}, 
                                attributes: {style: "text-align:center;"},
                            },
                            {
                                field:"BGT_NM",
                                title : "예산과목명", 
                                headerAttributes: {style: "text-align:center;"}, 
                                attributes: {style: "text-align:left;"},
                                template: "<a href=javascript:acG20State.datailPop('#=BGT_CD#');>#: data.BGT_NM# </a>"
                            },
                            {
                                title : "예산금액", 
                                headerAttributes: {style: "text-align:center;"}, 
                                columns: [
                                        {
                                        	  field:"PROP_AM",
                                        	  title : "당초예산", 
                                        	  width:115, 
                                        	  headerAttributes: {style: "text-align:center;"}, 
                                        	  attributes: {style: "text-align:right;"},
                                        },
                                        {
                                        	field:"CF_AM", 
                                        	title : "최종예산", 
                                        	width:115,
                                        	headerAttributes: {style: "text-align:center;"}, 
                                        	attributes: {style: "text-align:right;"},
                                        }
                                      ]
                            },
                            {
                                title : "품의단계", 
                                headerAttributes: {style: "text-align:center;"}, 
                                columns: [
                                        {
                                        	  field:"PLAN_AM",
                                        	  title : "기안금액", 
                                        	  width:115, 
                                        	  headerAttributes: {style: "text-align:center;"}, 
                                        	  attributes: {style: "text-align:right;"},
                                        },
                                        {
                                        	field:"EXEC_AM", 
                                        	title : "승인금액", 
                                        	width:115,
                                        	headerAttributes: {style: "text-align:center;"}, 
                                        	attributes: {style: "text-align:right;"},
                                        },
                                        {
                                        	field:"gwREFER_AM", 
                                        	title : "GW기안금액", 
                                        	width:115,
                                        	headerAttributes: {style: "text-align:center;"}, 
                                        	attributes: {style: "text-align:right;"},
                                        }
                                      ]
                            },
                            {
                                title : "집행단계", 
                                headerAttributes: {style: "text-align:center;"}, 
                                columns: [
                                        {
                                        	  field:"PRE_CONF_AM",
                                        	  title : "결의금액", 
                                        	  width:115, 
                                        	  headerAttributes: {style: "text-align:center;"}, 
                                        	  attributes: {style: "text-align:right;"},
                                        },
                                        {
                                        	field:"CONF_AM", 
                                        	title : "승인금액", 
                                        	width:115,
                                        	headerAttributes: {style: "text-align:center;"}, 
                                        	attributes: {style: "text-align:right;"},
                                        }
                                      ]
                            },
                            {
                                field:"DIFF_AM", 
                                title : "예산차이", 
                                width:132,
                                headerAttributes: {style: "text-align:center;"}, 
                                attributes: {style: "text-align:right;"},
                            },
                            {
                                field:"gwDIFF_AM", 
                                title : "GW예산잔액", 
                                width:132,
                                headerAttributes: {style: "text-align:center;"}, 
                                attributes: {style: "text-align:right;"},
                            }
                        ],
                        selectable: "single",
                        groupable: false,
                        columnMenu:false,
                        editable: false,
                        sortable: true,
                        pageable: false
                    });
            	}else{
            		alert("오류가 발생하였습니다. 관리자에게 문의하세요.");
            	}
            	
//                 $("#PROP_AM").html(getToPrice(data.totalList.PROP_AM));
//                 $("#CF_AM").html(getToPrice(data.totalList.CF_AM));
//                 $("#PLAN_AM").html(getToPrice(data.totalList.PLAN_AM));
//                 $("#EXEC_AM").html(getToPrice(data.totalList.EXEC_AM));
//                 $("#gwREFER_AM").html(getToPrice(data.totalList.gwREFER_AM));
//                 $("#PRE_CONF_AM").html(getToPrice(data.totalList.PRE_CONF_AM));
//                 $("#CONF_AM").html(getToPrice(data.totalList.CONF_AM));
//                 $("#DIFF_AM").html(getToPrice(data.totalList.DIFF_AM));
                modal(false);
            },
    	    error: function (request,status,error) {
    	    	alert("오류가 발생하였습니다. 관리자에게 문의하세요.\n오류메시지 :"+error+"\n");
    	    	modal(false);
        	}
    };
    $.ajax(opt); 
};

// BudgetConStatus.seachListExcel = function(){
//     document.searchForm.action = "<c:url value="/Ac/G20/State/getErpBgtStepStatus.do" />";
//     document.searchForm.submit();
// };

</script>

            <input type="hidden" id="CO_CD" name="CO_CD"  class="formData" />
            <input type="hidden" id="EMP_CD" name="EMP_CD"  class="formData"  />
            <input type="hidden" id="FR_DT" name="FR_DT"  class="formData"  />
            <input type="hidden" id="TO_DT" name="TO_DT"  class="formData"  />
            <input type="hidden" id="DIV_CDS" name="DIV_CDS"  class="formData" />
            <input type="hidden" id="MGT_CDS" name="MGT_CDS"  class="formData" />
            <input type="hidden" id="BOTTOM_CDS" name="BOTTOM_CDS"  class="formData" /> 
                    <!-- 컨텐츠내용영역 -->
                    <div class="sub_contents_wrap">
<!-- contents -->            
                        <div class="top_box">
                            <dl>
                                <dt>회사코드</dt>
                                <dd><span id="coInfo"/></dd>
                                <dt>기수기준일</dt>
                                <dd><input id="GISU_DT"  name="GISU_DT"  class="dpWid formData"/></dd>
                                <dt>기수</dt>
                                <dd><input type="text"name="GISU"  id="GISU"  style="width:40px;" class="formData" readonly="readonly"> 기</dd>
                            </dl>
                        </div>
                           
                        <!-- 컨트롤버튼 -->                      
                        <div>
                            <div id="" class="controll_btn">
                                <button type="button" id="btnExcel" >Excel 다운로드</button>
                            </div>
                        </div>       
                        
                        <input type="hidden" id="searchYN" name="searchYN" value=""/>
                        <input type="hidden" id="EXCEL_YN" name="EXCEL_YN" value=""/>
                        <!-- 조회조건 -->
                        <div class="com_ta">
                            <table id="searchTable">
                                <colgroup>
                                    <col width="93"/>
                                    <col width=""/>
                                    <col width="93"/>
                                    <col width=""/>
                                </colgroup>
                                <tr>
                                    <th>사업장</th>
                                    <td><input id='DIV_CD' name='DIV_CD' class="formData"  style="width:160px;"/> <!-- <select style='width:180px;' id='DIV_CD' name='DIV_CD' class="formData"> --></td>
                                    <th>조회기간</th>
                                    <td>
                                        <input id="DATE_FROM"  name="DATE_FROM"  class="dpWid formData"/>
                                        ~
                                        <input id="DATE_TO"  name="DATE_TO"  class="dpWid formData"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="FG_TYSpan">프로젝트</th>
                                    <td>
                                        <input type="text" style="width:135px;" id="MGT_CD_NM"  name="MGT_CD_NM"  readonly="readonly" class="requirement formData" />
                                        <input type="text" style="width:100px;" id="MGT_CD"  name="MGT_CD"  class="requirement formData" />
                                        <a href="javascript:;" class="search-Event-H btn_search"></a>
<!--                                      <span class="bottonSpan" style="display:none;">  -->
<%--                                         <input type="text" style="width:135px;" id="BOTTOM_NM" name="BOTTOM_NM" readonly="readonly"  value="${ErpBudgetVO.BOTTOM_NM}"  class="requirement formData" /> --%>
<%--                                         <input type="text" style="width:100px;" id="BOTTOM_CD"  name="BOTTOM_CD"  value="${ErpBudgetVO.BOTTOM_CD}"  class="formData"/> --%>
<!--                                         <a href="javascript:;" class="search-Event-H btn_search"></a> -->
<!--                                      </span> -->
                                    </td>
                                    <th>하위사업</th>
                                    <td>
                                        <input type="text" style="width:135px;" id="BOTTOM_NM" name="BOTTOM_NM" readonly="readonly" class="requirement formData" />
                                        <input type="text" style="width:100px;" id="BOTTOM_CD"  name="BOTTOM_CD" class="formData"/>
                                        <a href="javascript:;" class="search-Event-H btn_search"></a>
                                     </span>
                                    </td>                                     
                                </tr>
                                <tr>
                                    <th>예산과목</th>
                                    <td colspan="3">
                                        <div class="dp_ib" style="width:270px;">
                                            <input type="text" style="width:135px;" id="BGT_NM_FROM" name="BGT_NM_FROM" readonly="readonly" class="requirement BGT_CD"  target="FROM"/>
                                            <input type="text" style="width:100px;" id="BGT_CD_FROM" name="BGT_CD_FROM" readonly="readonly" class="requirement BGT_CD" target="FROM"/>
                                            <input type="hidden"  name="SYS_CD_FROM"  id="SYS_CD_FROM"  class="formData"  target="FROM"/>
                                            <a href="#" class="btn_search search-Event-H"></a>
                                        </div>
                                        ~
                                        <div class="dp_ib" style="width:270px;">
                                            <input type="text" style="width:135px;" id="BGT_NM_TO" name="BGT_NM_TO" readonly="readonly"  class="requirement BGT_CD" target="TO"/> 
                                            <input type="text" style="width:100px;" id="BGT_CD_TO" name="BGT_CD_TO" readonly="readonly" class="requirement BGT_CD" target="TO"/>
                                            <input type="hidden"  name="SYS_CD_TO"  id="SYS_CD_TO"  class="formData" target="TO"/>
                                            <a href="javascript:;" class="btn_search search-Event-H"></a>
                                        </div>                               
                                    </td>
                                </tr>                                
                                <tr>
                                    <th>과목구분</th>
                                    <td>
                                        <input id="DIV_FG" name="DIV_FG" style="width:100px;"/>
<!--                                         차수<input type="text" name="BGT_CNT"  id="BGT_CNT"  style="width:40px;"> -->
                                    </td>
                                    <th>입출구분</th>
                                    <td><input id="GR_FG" name="GR_FG" style="width:100px;"/></td>                                    
                                    
                                </tr>
                                <tr>
                                    <th>예산차이</th>
                                    <td colspan="">
                                        <input name="BGT_DIFF_S" id="BGT_DIFF_S"  style="width:130px;"/>
                                        ~
                                        <input name="BGT_DIFF_D" id="BGT_DIFF_D"  style="width:130px;"/>
                                    </td>
                                    <th>금액없는 라인</th>
                                    <td>
                                        <input name="ZEROLINE_FG" id="ZEROLINE_FG"  style="width:62px;"/>
                                    </td>                                    
                                </tr>
                            </table>
                        </div>
                        
                        <!-- 조회버튼 -->
                        <div class="btn_cen pt12">
                            <input type="button" class="btnSearch" value="조회">
                        </div>
            
                        <div class="g20_date_grid">        
                            <!-- 테이블 -->
                            <div id="grid" class="data_grid" style="border-width:1px 0 0 0;"></div> 
                                                    
                            <!-- 고정테이블 -->
<!--                             <div class="com_ta"  style="min-width:1360px;"> -->
<!--                                 <table> -->
<%--                                     <colgroup> --%>
<%--                                         <col width="132"/> --%>
<%--                                         <col width="54"/> --%>
<%--                                         <col width=""/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="125"/> --%>
<%--                                         <col width="149"/> --%>
<%--                                     </colgroup> --%>
<!--                                     <tr> -->
<!--                                         <th colspan="3">합계</th> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="PROP_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="CF_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="PLAN_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="EXEC_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="gwREFER_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="PRE_CONF_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="CONF_AM">0</span></td> -->
<!--                                         <td class="ri" style="padding:0 .6em;"><span id="DIFF_AM">0</span></td> -->
<!--                                     </tr> -->
<!--                                 </table> -->
<!--                             </div>                                -->
                        
                        </div>
<!-- //contents -->                                
            </div>
            
<div id="dialog-form-standard" style="display:none">
<div class="pop_wrap_dir" >
    <div class="pop_head">
        <h1></h1>
        <a href="#n" class="clo popClose"><img src="<c:url value='/Images/btn/btn_pop_clo02.png' />" alt="" /></a>
    </div>
    <div class="pop_con">       
        
        <!-- 예산검색 -->     
        <div class="top_box" style="overflow:hidden;display:none;" id="Budget_Search">
            <dl class="">
                <dt style="width:100px;">
                         예산과목표시 :
                 </dt>
                 <dd>                         
                        <input type="radio" name="OPT_01" value="2"  id="OPT_01_2" class="k-radio" checked="checked" />
                        <label class="k-radio-label" for="OPT_01_2" style="padding:0.2em 0 0 1.5em;">당기 편성된 예산과목만 표시</label>
                        <input type="radio" name="OPT_01" value="1" id="OPT_01_1" class="k-radio" />
                        <label class="k-radio-label" for="OPT_01_1" style="padding:0.2em 0 0 1.5em;">모든 예산과목 표시</label>
                        <input type="radio" name="OPT_01" value="3" id="OPT_01_3" class="k-radio" />
                        <label class="k-radio-label" for="OPT_01_3" style="padding:0.2em 0 0 1.5em;">프로젝트 기간 예산 편성된 과목만 표시</label>
                </dd>
            </dl>
            <dl class="">
                <dt style="width:100px;">
                         사용기한 : 
                </dt>
                <dd> 
                        <input type="radio" name="OPT_02" value="1" id="OPT_02_1" class="k-radio"  checked="checked" />
                        <label class="k-radio-label"  for="OPT_02_1" style="padding:0.2em 0 0 1.5em;">모두표시</label>
                        <input type="radio" name="OPT_02" value="2" id="OPT_02_2" class="k-radio" />
                        <label class="k-radio-label"  for="OPT_02_2" style="padding:0.2em 0 0 1.5em;">사용기한경과분 숨김</label>
                </dt>                
            </dl>            
        </div>
                                 
        <div class="com_ta2 mt10 ova_sc_all cursor_p"  style="height:340px;" id="dialog-form-standard-bind">
        </div>
        

    </div><!-- //pop_con -->
</div><!-- //pop_wrap -->
</div> 
<div id="dialog-form-background_dir" style="display:none;"></div>
