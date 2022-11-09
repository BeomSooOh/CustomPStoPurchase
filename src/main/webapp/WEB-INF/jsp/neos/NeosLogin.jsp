<%@page import="neos.cmm.util.code.CommonCodeSpecific"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%
	/**
	 * 
	 * @title Neos 로그인 화면 
	 **/
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Bizbox A</title>
<!--Kendo ui css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.default.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.default.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.mobile.all.min.css' />" />

<!-- Theme -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

<!--css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>" />

<!--Kendo UI customize css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css'/>" />

<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>

<script>
    $(document).ready(function() {

        /*리사이즈*/
        var loginWidth = $('#login_b1_type').width();
        var loginHeight = $('#login_b1_type').height();
        $('#login_b1_type').css("margin-top", -loginHeight * 0.5);
        $('#login_b1_type').css("margin-left", -loginWidth * 0.5);

        $(window).resize(function() {
            var loginWidth = $('#login_b1_type').width();
            var loginHeight = $('#login_b1_type').height();
            $('#login_b1_type').css("margin-top", -loginHeight * 0.5);
            $('#login_b1_type').css("margin-left", -loginWidth * 0.5);
        });

        /*리사이즈*/
        var loginWidth = $('#login_b2_type').width();
        var loginHeight = $('#login_b2_type').height();
        $('#login_b2_type').css("margin-top", -loginHeight * 0.5);
        $('#login_b2_type').css("margin-left", -loginWidth * 0.5);

        $(window).resize(function() {
            var loginWidth = $('#login_b2_type').width();
            var loginHeight = $('#login_b2_type').height();
            $('#login_b2_type').css("margin-top", -loginHeight * 0.5);
            $('#login_b2_type').css("margin-left", -loginWidth * 0.5);
        });

        if (typeof (parent.document.getElementById("idBtnLogout")) != "undefined" && parent.document.getElementById("idBtnLogout") != null) {
            parent.document.location.href = "<c:url value='/NeosMain.do'/>";
        }
    });

    //focus이벤트
    function focusInput( id ) {
        $("#" + id + "_label").text("");
    }

    //blur이벤트
    function blurInput( id ) {
        if ($("#" + id).val() == "") {
            var msg = "";
            switch (id) {
                case "id":
                    msg = "아이디";
                    break;
                case "password":
                    msg = "비밀번호";
                    break;
            }
            $("#" + id + "_label").text(msg + " 입력");
        }
    }

    function actionLogin() {

        saveid(document.loginForm);

        if (document.loginForm.id.value == "") {
            alert("아이디를 입력하세요");
        } else if (document.loginForm.password.value == "") {
            alert("비밀번호를 입력하세요");
        } else {
            var httpsYN = "<nptag:commoncode  codeid = 'HP001' code='HTTPS'/>";
            if (httpsYN == "Y") {
                var serverName = "${pageContext.request.serverName}";
                var port = "<nptag:commoncode  codeid = 'HP001' code='HTTPS_PORT' />";
                document.loginForm.action = "https://" + serverName + ":" + port + "<c:url value='/uat/uia/actionLogin.do'/>";
            } else {
                document.loginForm.action = "<c:url value='/uat/uia/actionLogin.do'/>";
            }
            //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
            //document.loginForm.action="<c:url value='/j_spring_security_check'/>";

            document.loginForm.submit();
        }
    }

    function setCookie( name, value, expires ) {
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expires.toGMTString();
    }

    function getCookie( Name ) {
        var search = Name + "=";
        if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
            offset = document.cookie.indexOf(search);
            if (offset != -1) { // 쿠키가 존재하면
                offset += search.length;
                // set index of beginning of value
                end = document.cookie.indexOf(";", offset);
                // 쿠키 값의 마지막 위치 인덱스 번호 설정
                if (end == -1) end = document.cookie.length;
                return unescape(document.cookie.substring(offset, end));
            }
        }
        return "";
    }

    function saveid( form ) {
        var expdate = new Date();
        // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
        if (document.loginForm.checkId.checked) expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
        else expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
        setCookie("saveid", document.loginForm.id.value, expdate);
    }

    function getid( form ) {
        document.loginForm.checkId.checked = ((document.loginForm.id.value = getCookie("saveid")) != "");

        if (document.loginForm.id.value.length > 0) {

            $("#userId_label").css("display", "none");

            $("#id").removeClass("id_blur01");
            $("#id").addClass("id_blur01_1");
        }
    }

    function fnInit() {

        var message = document.loginForm.message.value;
        if (message != "") {
            alert(message);
        }

        getid(document.loginForm);
        // 포커스
        //document.loginForm.rdoSlctUsr.focus();

    }
</script>
</head>
<c:if test="${loginType eq 'A'}">
	<body id="login" onLoad="fnInit();">


		<div id="login_b1_type">
			<div class="company_logo">
				<c:if test="${empty imgMap.IMG_COMP_LOGIN_LOGO_A.fileId}">
					<img src="<c:url value='/Images/temp/duzon_logo.png'/>" alt="" id="">
				</c:if>
				<c:if test="${!empty imgMap.IMG_COMP_LOGIN_LOGO_A.fileId}">
					<img src="<c:url value='/cmm/file/attachFileDownloadProc.do?fileId=${imgMap.IMG_COMP_LOGIN_LOGO_A.fileId}&fileSn=0' />" alt="" id="">
				</c:if>
			</div>
			<div class="login_wrap">
				<div class="login_user_img">
					<c:if test="${empty imgMap.IMG_COMP_LOGIN_BANNER_A.fileId}">
						<img src="<c:url value='/Images/temp/login_b1_type_img.png'/>" alt="" id="">
					</c:if>
					<c:if test="${!empty imgMap.IMG_COMP_LOGIN_BANNER_A.fileId}">
						<img src="<c:url value='/cmm/file/attachFileDownloadProc.do?fileId=${imgMap.IMG_COMP_LOGIN_BANNER_A.fileId}&fileSn=0' />" alt="" id="">
					</c:if>
				</div>

				<div class="login_form_wrap">
					<p class="log_tit">더존 그룹웨어에 오신것을 환영합니다.</p>
					<form name="loginForm" action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
						<input type="hidden" name="message" value="${message}" /> <input name="userSe" type="hidden" value="USER" /> <input name="j_username" type="hidden" />
						<fieldset>
							<label class="i_label" for="userId" id="userId_label" onclick="javascript:focusInput('userId');" style="font-size: 12px;">아이디 입력</label> <input type="text" class="inp" id="userId" name="id" onfocus="focusInput('userId');" onblur="blurInput('userId');"> <label class="i_label" for="userPw" id="userPw_label" onclick="javascript:focusInput('userPw');" style="font-size: 12px;">비밀번호 입력</label> <input type="password" class="inp" id="userPw" name="password" onfocus="focusInput('userPw');" onblur="blurInput('userPw');">

							<div class="chk">
								<input type="checkbox" id="checkId" type="checkbox" name="checkId" style="border: none; vertical-align: middle;" onClick="javascript:saveid(document.loginForm);" /> <label for="chk_id">아이디저장</label>
							</div>
							<div class="log_btn">
								<input type="image" value="로그인" src="<c:url value='/Images/btn/login_a1_type_btn.png'/>" onclick="actionLogin();">
							</div>
						</fieldset>
					</form>
				</div>
			</div>

			<div class="copy">Copyright duzon IT GROUP. All right reserved.</div>
		</div>
	</body>
</c:if>
<c:if test="${loginType eq 'B'}">
	<c:if test="${empty imgMap.IMG_COMP_LOGIN_BG_B.fileId}">
		<body class="login_b2_type_bg" id="login" onLoad="fnInit();">
	</c:if>
	<c:if test="${!empty imgMap.IMG_COMP_LOGIN_BG_B.fileId}">
		<body class="login_b2_type_bg" id="login" onLoad="fnInit();" style="background-image:url('<c:url value='/cmm/file/attachFileDownloadProc.do?fileId=${imgMap.IMG_COMP_LOGIN_BG_B.fileId}&fileSn=0'/>') ">
	</c:if>
	<div id="login_b2_type">

		<div class="company_logo">
			<c:if test="${empty imgMap.IMG_COMP_LOGIN_LOGO_B.fileId}">
				<img src="<c:url value='/Images/temp/duzon_logo.png'/>" alt="" id="">
			</c:if>
			<c:if test="${!empty imgMap.IMG_COMP_LOGIN_LOGO_B.fileId}">
				<img src="<c:url value='/cmm/file/attachFileDownloadProc.do?fileId=${imgMap.IMG_COMP_LOGIN_LOGO_B.fileId}&fileSn=0' />" alt="" id="">
			</c:if>
		</div>
		<div class="login_wrap">
			<div class="login_form_wrap">
				<p class="log_tit">더존 그룹웨어에 오신것을 환영합니다.</p>
				<form name="loginForm" action="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
					<input type="hidden" name="message" value="${message}" /> <input name="userSe" type="hidden" value="USER" /> <input name="j_username" type="hidden" />
					<fieldset>
						<label class="i_label" for="userId" id="userId_label" onclick="javascript:focusInput('userId');" style="font-size: 12px;">아이디 입력</label> <input type="text" class="inp" id="userId" name="id" onfocus="focusInput('userId');" onblur="blurInput('userId');"> <label class="i_label" for="userPw" id="userPw_label" onclick="javascript:focusInput('userPw');" style="font-size: 12px;">비밀번호 입력</label> <input type="password" class="inp" id="userPw" name="password" onfocus="focusInput('userPw');" onblur="blurInput('userPw');">

						<div class="chk">
							<input type="checkbox" id="checkId" type="checkbox" name="checkId" style="border: none; vertical-align: middle;" onClick="javascript:saveid(document.loginForm);" /> <label for="chk_id">아이디저장</label>
						</div>
						<div class="log_btn">
							<input type="image" value="로그인" src="<c:url value='/Images/btn/login_b2_type_btn.png'/>" onclick="actionLogin();">
						</div>
					</fieldset>
				</form>
			</div>

		</div>
		<div class="copy">Copyright duzon IT GROUP. All right reserved.</div>
	</div>
	</body>
</c:if>
</html>