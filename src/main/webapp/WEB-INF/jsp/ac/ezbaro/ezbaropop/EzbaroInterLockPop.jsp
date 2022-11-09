<%@ page language="java" contentType="text/html; charset=utf-8" import="main.web.BizboxAMessage" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<script type="text/javascript">
	
	$(document).ready(function() {			
		fnSetInterlockInfo();
	});
	function fnSetInterlockInfo()
	{
		var g_interlock = {};
		g_interlock =  JSON.parse('${aaData}');
		
		
		
		//결의일자
		$("#txtResolDate").html( g_interlock.RESOLDATE || '-');
		
		console.log( g_interlock.RESOLDATE);
		//연구과제
		$("#txtProJect").html( g_interlock.PRJNAME || '-');
		console.log( g_interlock.PRJNAME);
		
		//g20프로젝트
		$("#txtG20Project").html( g_interlock.PJT_NM || '-');
		console.log( g_interlock.PJT_NM);
		
		//g20예산과목
		$("#txtG20BgSubj").html( g_interlock.BGT_NM || '-');
		console.log( g_interlock.BGT_NM);
		
		//세목
		$("#txtDetails").html( g_interlock.BMNAME || '-');
		console.log( g_interlock.BMNAME);
		
		//사용용도
		$("#txtUse").html( g_interlock.EXECDIV_NM || '-');
		console.log( g_interlock.EXECDIV_NM);
		
		//집행방법
		$("#txtExecMethod").html( g_interlock.EXECMTD_NM || '-');
		console.log( g_interlock.EXECMTD_NM);
		
		//집행요청구분
		$("#txtExecReqGb").html( g_interlock.EXECREQDIV_NM || '-');
		console.log( g_interlock.EXECREQDIV_NM);
		
		//G20거래처
		$("#txtG20Partner").html( g_interlock.TR_NM || '-');
		console.log( g_interlock.TR_NM);
		
		//결의내용
		$("#txtResolNote").html( g_interlock.CONT || '-');
		console.log( g_interlock.CONT);
		
		//출장자
		$("#txtEntrant").html( g_interlock.NM || '-');
		console.log( g_interlock.NM);
		
		//지급은행
		$("#txtBankName").html( g_interlock.EXECBANK_NM || '-');
		console.log( g_interlock.EXECBANK_NM);
		
		//지급계좌번호
		$("#txtBankAccNum").html( g_interlock.EXECREQACCNO || '-');
		console.log( g_interlock.EXECREQACCNO);
		
		//지급예금주
		$("#txtBankAccHolder").html( g_interlock.ACCOWNER || '-');
		console.log( g_interlock.ACCOWNER);
		
		//공급가액
		$("#txtSupplyAmt").html( g_interlock.SUPCOST || '-');
		console.log( g_interlock.SUPCOST);
		
		//세액
		$("#txtTaxAmt").html( g_interlock.EXTTAX || '-');
		console.log( g_interlock.EXTTAX);
		
		//결의금액
		$("#txtTotalAmt").html( g_interlock.RESOLAMT || '-');
		console.log( g_interlock.RESOLAMT);
		
	}
</script>

<div class="pop_wrap_dir" id="layerCommonCode" style="width: 600px;">
	<div class="pop_con">
		<div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th>import="main.web.BizboxAMessage"</th>
							<td class="le"><span  id="txtResolDate" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009434","연구과제가 선택되지 않았습니다")%></th>
							<td class="le"><span  id="txtProJect" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%></th>
							<td class="le"><span  id="txtG20Project" style="width: 99%"></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000003622","예산과목")%></th>
							<td class="le"><span  id="txtG20BgSubj" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009965","세목")%></th>
							<td class="le"><span  id="txtDetails" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009964","사용용도")%></th>
							<td class="le"><span  id="txtUse" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009963","집행방법")%></th>
							<td class="le"><span  id="txtExecMethod" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009962","집행요청구분")%></th>
							<td class="le"><span  id="txtExecReqGb" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le"><span  id="txtG20Partner" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></th>
							<td class="le"><span  id="txtResolNote" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000011204","출장자")%></th>
							<td class="le"><span  id="txtEntrant" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le"><span  id="txtBankName" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le"><span  id="txtBankAccNum" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le"><span  id="txtBankAccHolder" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le" colspan="3" ><span  id="txtSupplyAmt" style="width: 99%"></td>							
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le" colspan="3" ><span  id="txtTaxAmt" style="width: 99%"></td>							
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le" colspan="3" ><span  id="txtTotalAmt" style="width: 99%"></td>							
						</tr>
                    </table>
                </div>
	</div>
	<!--// pop_con -->
</div>