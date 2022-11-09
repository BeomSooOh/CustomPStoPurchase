<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
	$ ( document ).ready ( function ( ) {
		// alert ( '${ViewBag.alertMessage}' );
	} );
</script>

<div class="pop_wrap_area" id="pop_alert">
	<div class="pop_wrap_dir" style="width: 443px;">
		<div class="pop_head">
			<h1>알림</h1>
			<a href="#n" class="clo" style="display: block"><img src="<c:url value="/Images/btn/btn_pop_clo02.png"></c:url>" alt="" /></a>
		</div>
		<div class="pop_con">
			<table class="fwb ac" style="width: 100%;">
				<tr>
					<td><span class="completionbg">${ViewBag.alertMessage}</span></td>
				</tr>
			</table>
		</div>
		<!-- //pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" value="확인" />
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!-- //pop_wrap -->
</div>