<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<div class="sub_contents_wrap" style=" min-width:1300px">
	<!-- 컨트롤박스 -->
	<div class="top_box">
	
	<dl>
		<dt>BizboxAlpha 구축 지원 / 지출결의 양식 </dt><dd></dd>
	</dl>
	
	</div>
	<!-- 메인 테이블 박스 -->
	<div class="com_ta mt20">
		<table>
			<colgroup>
				<col width="280" />
				<col width="" />
			</colgroup>
			<tr>
				<th> 지출결의 양식</th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/expend_form.html" />" download="expend_form.html">expend_form.html</a>
				</td>
			</tr>
			<tr>
				<th> 표준적요 등록 요청 양식 </th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/summary_form.xlsx" />" download="summary_form.xlsx">summary_form.xlsx</a>
				</td>
			</tr>
			<tr>
				<th> 스마트자금관리] 자금일보 - 헤더 </th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/fundDayReportHeaderForm.html" />" download="fundDayReportHeaderForm.html">fundDayReportHeaderForm.html</a>
				</td>
			</tr>
			<tr>
				<th> 스마트자금관리] 자금일보 - 본문 </th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/fundDayReportMainForm.html" />" download="fundDayReportMainForm.html">fundDayReportMainForm.html</a>
				</td>
			</tr>
			<tr>
				<th> 스마트자금관리] 자금이체 - 헤더 </th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/fundTransferHeaderForm.html" />" download="fundTransferHeaderForm.html">fundTransferHeaderForm.html</a>
				</td>
			</tr>
			<tr>
				<th> 스마트자금관리] 자금계획 - 헤더 </th>
				<td>
					<a id="downloadType1" href="<c:url value="../../resource/basefile/fundScheduleHeaderForm.html" />" download="fundScheduleHeaderForm.html">fundScheduleHeaderForm.html</a>
				</td>
			</tr>
		</table>
	</div>
</div>
