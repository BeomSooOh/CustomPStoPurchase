<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />
<%@page import="main.web.BizboxAMessage"%>

<script>
	
</script>

<div class="pop_sign_wrap" style="height: 99%;">
	<div class="pop_sign_head">
		<h1>표준적요 업로드</h1>

		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8 btnPosition10"></div>
			</div>
		</div>
	</div>
	<div class="pop_con">
		<div class="btn_div mt20">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">
					품의정보<span class="text_red fwn ml10" id="spanConsTooltip"></span>
				</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnSearch">조회</button>
					<button id="btnSave">반영</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //pop_wrap -->