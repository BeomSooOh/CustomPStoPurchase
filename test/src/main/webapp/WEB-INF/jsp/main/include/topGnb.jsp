<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="neos.cmm.util.code.CommonCodeSpecific" %>
<%@ page import="neos.cmm.util.BizboxAProperties" %>


<script type="text/javascript">

/**
 * SSO 연동도 고려해야함!!!
 */

var parentOptionValue = "${parentOptionValue}";
//var parentOptionValue = "0";
var optionValueLogoutTime = "";
var limitYn = 1;		// 제한 여부
var logonTime = "${logonTime}";
console.log(logonTime);
// 로그인 통제 옵션 사용 시 (상위 옵션)
if(parentOptionValue == "1") {
	// 자동 로그아웃 시간
	optionValueLogoutTime = "${optionValueLogoutTime}";
	localStorage.setItem("limitYn", 1);		
	
	// 강제 로그아웃 시간 값이 존재할때 
	if(optionValueLogoutTime > 0) {

		// 동작 이벤트 (시간 초기화)
		$(window).bind("keyup", function () { resetTimer(); });
		$(window).bind("click", function () { resetTimer(); });
		
		// 사용 기록이 없을 때
		if(localStorage.getItem("LATime") == "" || localStorage.getItem("LATime") == null) {
			resetTimer();
		} else if (logonTime != null && logonTime != "") {
            resetTimer();
        }

		// 강제 로그 아웃 되었을 때
		if ((parseInt(localStorage.getItem("LATime")) + (60000 * optionValueLogoutTime) < (+new Date()))) {
            //alert('여기 오긴함?');
            //$("html").hide();
            document.location.href = 'uat/uia/actionLogout.do';
            alert("보안설정으로 인해 자동 로그아웃 되었습니다.");
        } else {
            resetTimer();
            setInterval(function () { idleCheck(); }, 10000);
        }
	}
}


function idleCheck() {
	if (limitYn == "1" && (parseInt(localStorage.getItem("LATime")) + (60000 * optionValueLogoutTime) - (+new Date())) < 0) {
		localStorage.setItem("limitYn", 0);
		
        $("#idleCheckDiv, .idleCheckDivLock").show();
        limitYn = 0;
        countDown();
    }
}


function countDown() {
	var sec = parseInt($("#limitSec").html());

	if(limitYn == "0"){
		if (sec > 0) {
	        setTimeout("countDown()", 1000);
	        $("#limitSec").html(sec -1);
	    } else {
	         $("#secuText").html("보안설정으로 인해 자동 로그아웃 되었습니다.");
	         $("#logonPw").find('input').val("");
	         $("#logonPw").show();
	         $("#limitSec").hide();
	         $('[name=inSession]').hide();
	         $('[name=outSession]').show();
	    }
	}
}



// 동작 이벤트 발생 시 시간 초기화
function resetTimer() {
	if(limitYn == "1") {
		localStorage.setItem("LATime", (+new Date()));	
	}
}


function loginButton() {
    if (event.keyCode == 13) {
        reLogon();
    }
}


function reLogon() {
	if ($("#logonPw").find('input').val() == "") {
        alert("패스워드를 입력해 주십시오.");
        return;
    }
	
	var param = {};
	param.passwd = $("#logonPw").find('input').val();
	

	$.ajax({
		type: "POST"
		, data: param
		, url: '<c:url value="/uat/uia/loginPwCheck.do" />'
		, success: function(result) {
			console.log(JSON.stringify(result.result));
			if(result.result > 0) {
				$('#idleCheckDiv, .idleCheckDivLock').hide();
                localStorage.setItem("limitYn", 1);
                limitYn = 1;
                resetTimer();
                $('#limitSec').html('60');
                $("#limitSec").show();
                $('[name=inSession]').show();
                $('[name=outSession]').hide();
                $("#logonPw").hide();
			} else {
				alert('패스워드가 일치하지 않습니다.');
				$("#logonPw").focus();
			}
		}
		, error: function(result) {
			alert("실패실패");
		}
	});
}

	var topType = '${topType}';	
	var popType = 0; // 0:모두,1:프로필팝업, 2:알림팝업, 3:나의메뉴
	var clickCnt = 0;
	var chkInOut = false;
	
	function getTopMenu() {
		return menu.topMenuInfo;
	}
	
	function getLeftMenuList() {
		return menu.leftMenuList;
	}
	
	function onclickTopMenu(no, name, url, urlGubun) {
		
		if (topType == 'main' || topType == 'timeline' || topType == 'mail' || urlGubun == 'mail' || urlGubun == 'adminMail') {
			
			$("#no").val(no);
			$("#name").val(name);
			$("#url").val(url);
			$("#urlGubun").val(urlGubun);
				
			
			if (urlGubun == 'mail' || urlGubun == 'adminMail') {
				form.action="bizboxMail.do";
			}else {
				form.action="bizbox.do";
			}
			
			form.submit();			
			
			//return mainmenu.clickTopBtn(no, name, url, urlGubun);
		} else {
			return menu.clickTopBtn(no, name, url, urlGubun);
		}
	}
	
	function changeMode(userSe) {
		location.href = "changeUserSe.do?userSe="+userSe;
	}
	
	function forwardPage(alertSeq, menuGugun, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name) {
		menu.hideGbnPopup(this.Event);
		
		if (topType == 'timeline' || topType == 'mail' || urlGubun == 'mail') {
			if (urlGubun == 'ea' || urlGubun == 'eap' || (urlGubun == 'schedule' && url.search("report") > 0)) {
				window.open("../"+urlGubun+url);
				//window.close();
			}
			else {
				menu.moveAndReadCheck2(alertSeq, topType, menuGugun, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name);
			}
		}
		else {
			if (urlGubun == 'ea' || urlGubun == 'eap' || (urlGubun == 'schedule' && url.search("report") > 0)) {
				window.open("../"+urlGubun+url);
				//window.close();
			}
			else {
				menu.moveAndReadCheck(alertSeq, topType, menuGugun, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name);
			}
		}
	}
	
	function changeMainContent(target) {
		/*
		if (target == "timeline") {
			form.action="timeline.do";
		}
		else {
			form.action="userMain.do";
		}
		
		form.submit();
		*/
		menu.timeline(target);
	}
	
	
	$(document).ready(function() {
		
		if("${groupMap.groupDomain}" == "${titleMap.compDomain}"){
			if("${groupMap.groupDisplayName}" != "")
				document.title = "${groupMap.groupDisplayName}";
		}
		else{
			if("${titleMap.compDomain}" != "" && "${titleMap.compDisplayName}" != "")
				document.title = "${titleMap.compDisplayName}";
		}
		
		
// 		$("#alertInfo").focusout(function(e){
// 			  if($(this).has(document.activeElement).length == 0) {				  
// 				    alertBtn_Click();
//  					$(".alert_box").css("display", "none");		
// 			   }
// 		}); 
		$(".alert_box").focusout(function(e){
				if(!chkInOut){
					$(".alert_box").css("display", "none");
					alertBtn_Click();
				}
					
		});
		
		$(".profile_box").focusout(function(e){
			if(!chkInOut)
				$(".profile_box").css("display", "none");
		});		
		
		$(".mymenu_box").focusout(function(e){
			if(!chkInOut)
				$(".mymenu_box").css("display", "none");
		});
		
		
		$(".alert_box").on('mouseenter', function(){
			chkInOut = true;
		});
		$(".alert_box").on('mouseleave', function(){
			chkInOut = false;
		});
		
		
		$(".profile_box").on('mouseenter', function(){
			chkInOut = true;
		});
		$(".profile_box").on('mouseleave', function(){
			chkInOut = false;
		});		
		
		$(".mymenu_box").on('mouseenter', function(){
			chkInOut = true;
		});
		$(".mymenu_box").on('mouseleave', function(){
			chkInOut = false;
		});
		
		if(topType == "timeline") {
			$("#tTap").addClass('on');
		}
		else {
			$("#pTap").addClass('on');
		}
		 
		// 알림 카운트 조회
		menu.alertCnt();
		menu.alertPolling();	// 주기적으로 호출
		 
		// edms는 서버가 다를수 있음.
		menu.edmsDomain = '${groupMap.edmsUrl}';			
		
// 		<c:if test="${userSe == 'ADMIN' || userSe == 'MASTER'}">
// 			$("body").prop("class", "${bodyClass}");
// // 			$("body").addClass("main_bg ${bodyClass} ");
// 			if("${imgMap}" != ""){
// 				// $(".logo > a").find("img").attr("src","/upload/img/logo/${loginVO.groupSeq}/${loginVO.compSeq}/IMG_COMP_LOGO_${loginVO.compSeq}_thum."+"${imgMap.file_extsn}");
// 			}
// 			else	
// 				// $(".logo > a").find("img").attr("src","<c:url value='/Images/temp/logo_admin.png' />");
// 		</c:if>
// 		<c:if test="${userSe == 'USER'}">
// 			if("${imgMap}" != ""){
// 				// $(".logo > a").find("img").attr("src","/upload/img/logo/${loginVO.groupSeq}/${loginVO.compSeq}/IMG_COMP_LOGO_${loginVO.compSeq}_thum."+"${imgMap.file_extsn}");
// 			}
// 		</c:if>
		
		
// 		<c:if test="${userSe == 'MASTER' }">
// 			$("#selCompSeq").change(function(e){
// 				var seq = this.value;
// 				if (seq != null && seq != '') {
// 					changeCompany(seq);
// 				}
// 			});
// 		</c:if>
		
		$("#remoteAS").click(function(){
			window.open("http://1.244.116.142/SSC", "원격A/S", "width=800, height=700");
		});
		
		// 검색
		$(".search_btn").click(function(e){
			readyInfo();
		});
		
// 		// 열린 메뉴 다른 영역 클릭시 닫기
// 		$('.header_wrap').on("click", function(e){
// 			console.log("header_wrap click");
// 			//e.stopPropagation(); 
// 			if (popType != 1 && popType != 2) {
// 				menu.hideGbnPopup(0);
// 			}
// 		});
// 		$('.main_wrap').on("click", function(e){
// 			console.log("main_wrap click");
// 			//e.stopPropagation(); 
// 			if (popType != 1 && popType != 2) {
// 				menu.hideGbnPopup(0);
// 			}
// 		}); 
		
		$('iframe').on("click", function(e){
			console.log("iframe click");
			//e.stopPropagation(); 
			menu.hideGbnPopup(0);
		});
		
		// 프로필팝업 조직도선택
		$("#multiDivi").kendoDropDownList();
		
		//사진등록임시
		$(".phogo_add_btn").on("click",function(){
			$(".hidden_file_add").click();
		})
		
		$(".hidden_file_add").on("change",function (){
			
			/* IE 10 버젼 이하에서 작동이 안될 수 있음. 추후 다른 방법으로 변경 예정. */
			var formData = new FormData();
			var pic = $("#userPic")[0];
			
			formData.append("file", pic.files[0]);
			formData.append("pathSeq", "910");	//이미지 폴더
			formData.append("relativePath", ""); // 상대 경로
			 
	       //  menu.userImgUpload(formData, "userImg");

	    });
		
		//프로필팝업 온오프
		$(".divi_txt").on("mousedown",function(e){
			console.log("divi_txt click");
			popType = 1;
			menu.hideGbnPopup(popType);
			$(".profile_box").toggle();
			$(".h_pop_box").focus();
			chkInOut = true;
			e.stopPropagation(); 
		}) 
		
// 	   //알림팝업 온오프
	   $(".alert_btn").on("mousedown",function(e){
		   console.log("alert_btn click");
		   popType = 2;
		   menu.hideGbnPopup(popType);
			$(".alert_box").toggle();
			$(".h_pop_box").focus();
			chkInOut = true;
			
		   e.stopPropagation();
		})
		
		//나의메뉴팝업 온오프
	   $(".mymenu_btn").on("mousedown",function(e){
		   console.log("mymenu_btn click");
		   popType = 3;
		   menu.hideGbnPopup(popType);
		   
		  var mymenu_box = $(".mymenu_box").css("display");
		  
		  // 나의메뉴 데이터 호출
		  if (mymenu_box == 'none') {
			myMenu();
		  }
		   
			$(".mymenu_box").toggle();
			$(".mymenu_box").focus();
			chkInOut = true;
		   e.stopPropagation(); 
		});
		
		//if($(".profile_box").css("display"))
	   $("#multiDivi").on("click",function(e){
		   e.stopPropagation();
	   });   
		
	   $("#multiDivi").on("change",function(e){
		   //e.stopImmediatePropagation(); 
		   menu.changePosition($("#multiDivi").val());
		   
		   //return false; 
		});   
		    
	});  
	
	function myMenu() {
		 menu.myMenu();
	}
	 
	<c:if test="${userSe == 'MASTER' }">
	function changeCompany(seq) {
		$.ajax({ 
			type:"post",
			url: _g_contextPath_ + "/cmm/systemx/compChangeProc.do",
			data:{compSeq : seq}, 
			datatype:"json",			  
			success:function(data){								
				if (data.result) {
					if (topType != 'main') {
						menu.contentReload();
					}
				} else {
					alert("회사 변경 실패");	
				}
			}  
		});  
	}
	</c:if>
	
	function alertBtn_Click(){
		// 알림 버튼 클릭시 알림 리스트 조회
		var alert_box = $(".alert_box").css("display");
		if (alert_box == 'block' || alert_box == '') {
		    menu.alertInfo();
		}
		$.ajax({ 
			type:"POST",
			url: '<c:url value="/alertRemoveNew.do"/>',
			datatype:"json",			  
			success:function(data){								
			}  
		});
		
		if(clickCnt >= 1){
			setAlertRemoveNew();
			clickCnt = 0;
		}
		else{
 			clickCnt++;	
		}
	}
	
	function setAlertRemoveNew(){
		$("li[name=li_item]").attr("class","");
		$("#alertCnt").attr("class", "");
		$("#alertCnt").html("");		  
	}
	 
	// 비밀번호 변경 팝업 호출
	function fn_pwdPop(type){
			var url = "/gw/cmm/systemx/myinfoPwdModPop.do?type="+type;
	    	var pop = window.open(url, "myinfoPwdModPop", "width=500,height=390,scrollbars=yes");    		
	}
	
	function fn_masterAuthPage(){
		mainmenu.mainToLnbMenu('1900000000', '시스템설정', '/cmm/system/authorMasterManageView.do', 'gw', '', 'main', '1900000000', '1903050000', '마스터권한설정', 'main');
	}
	
	
</script>

<c:if test="${ScriptAppend == 'Y'}">
	<!--iframe style="width:100%;height:80px;" src="custTokTok.do" ></iframe> -->
	
	<script language="javascript" src="http://int.toktok.sk.com/cmnweb/common/js/flashwrite_SKDND2.js"></script>

	<div style="width:100%; background-color: white;">
		<script language="javascript">renderGwpGnb();</script>
	</div>	
	
</c:if>
 	
<!-- header_top_wrap -->
		<div class="header_top_wrap">
			<div class="header_top">
				<!-- logo -->
				<h1 class="logo">
					<a href="<c:url value='${mainPage}' />" title="더존 Bizbox">						
<%-- 						<img src="/upload/img/logo/${loginVO.groupSeq}/${loginVO.compSeq}/IMG_COMP_LOGO_${loginVO.compSeq}_thum.jpg" onerror="this.src='/gw/Images/temp/logo.png'" alt="" height="38"/><!-- 로고이미지는 관리자모드일때 logo.png에서 logo_admin.png로 변경되어야 함. --> --%>
						<%-- <span class="divi_img"><img class="userImg" src="<c:url value='/cmm/file/fileDownloadProc.do?fileId=${picFileId}&fileSn=0' />" alt="" onerror="this.src='Images/temp/pic_Noimg.png'" /></span><a href="#n" class="divi_txt">${loginVO.name} <c:if test="${not empty loginVO.classNm && loginVO.classNm != 'null'}">${loginVO.classNm}</c:if></a> --%>
					</a>
				</h1>
				<div class="top_menu">
				<p class="more_btn"><a href="#n"><span class="arr">더보기</span></a></p>				
				<!-- global nav -->
				<ul class="nav"> 
					<c:forEach items="${topMenuList}" var="list" varStatus="c">
						<li><a href="javascript:onclickTopMenu(${list.menuNo},'${list.name }', '${list.urlPath}', '${list.urlGubun}');" class="nav${c.count}" , '${list.urlPath}', '${list.urlGubun}')" title="${list.name }">${list.name }</a></li>
					</c:forEach>
				</ul>
                </div>
				<!--더보기 메뉴-->
					<div class="more_div" style="display:none;">
						<ul id="more_div_ul">
						  
						</ul>
					</div>
				<!--//더보기 메뉴-->		
				
			</div> 
		</div>
		
		<!-- header_sub_wrap -->
		<div class="header_sub_wrap">
			<div class="header_sub">
			
				<c:if test="${userSe == 'USER' && (topType == 'main' || topType == 'timeline')}">
				<!-- contents tab -->
					<ul class="con_tab">
						<li id="pTap" class=""><a href="javascript:;" class="con_tab1" onClick="changeMainContent('portal')" title="회사포털">회사포털</a></li>
						<li id="tTap" class=""><a href="javascript:;" class="con_tab2" onClick="changeMainContent('timeline')" title="타임라인">타임라인</a></li>
					</ul>
				</c:if>
				
				<!-- user misc -->
				<div class="misc">    
					<!-- 프로필 -->
					<div class="profile_wrap">
						<div class="bg_pic"></div>
						<%-- <span class="divi_img"><img src="<c:url value='/Images/temp/temp_pic.png' />" alt="" /></span><a href="#n" class="divi_txt">김서현 대리</a> --%>
<%-- 						<span class="divi_img"><img class="userImg" src="/upload/img/profile/${loginVO.groupSeq}/${loginVO.uniqId}_thum.jpg?<%=System.currentTimeMillis()%>" alt="" onerror="this.src='/gw/Images/temp/pic_Noimg.png'" /></span><a href="#n" class="divi_txt">${optionValueInfo} <c:if test="${not empty loginVO.positionNm && loginVO.positionNm != 'null'}">${loginVO.positionNm}</c:if></a> 						 --%>
						<span class="divi_img"><img class="userImg" src="<c:url value='/cmm/file/fileDownloadProc.do?fileId=${picFileId}&fileSn=0' />" alt="" onerror="this.src='Images/temp/pic_Noimg.png'" /></span><a href="#n" class="divi_txt">${loginVO.name} <c:if test="${not empty loginVO.classNm && loginVO.classNm != 'null'}">${loginVO.classNm}</c:if></a>						
						<!-- 팝업::프로필 --> 
						<div class="header_pop_wrap profile_box" style="display:none;">  
							<div class="h_pop_box" id="profileInfo" tabindex="1" style="outline: none;"> 
								<div class="pop_shape"></div> 
								<div class="con">    
									<div class="profile_top">
										<!-- 프로필사진 -->
										<div class="profile_pic">
											<div class="circle_bg"></div>
<%-- 											<span class="divi_pic"><img class="userImg" src="/upload/img/profile/${loginVO.groupSeq}/${loginVO.uniqId}_thum.jpg?<%=System.currentTimeMillis()%>" onerror="this.src='/gw/Images/temp/pic_Noimg.png'" alt="" /></span> --%>
											<%-- <span class="divi_img"><img class="userImg" src="<c:url value='/cmm/file/fileDownloadProc.do?fileId=${picFileId}&fileSn=0' />" alt="" onerror="this.src='Images/temp/pic_Noimg.png'" /></span><a href="#n" class="divi_txt">${loginVO.name} <c:if test="${not empty loginVO.classNm && loginVO.classNm != 'null'}">${loginVO.classNm}</c:if></a> --%>					
											<a href="javascript:;" class="phogo_add_btn" title="프로필사진등록"><img src="<c:url value='/Images/btn/profile_photo_add.png' />" alt="프로필사진등록" /></a>
											<input type="file" id="userPic" class="hidden_file_add" name="userPic" style="position:absolute;top:-1000px;" />
										</div>
										<!-- 프로필정보 -->
										<div class="profile_info">
											<span class="txt_nm">${loginVO.name} <span><c:if test="${not empty loginVO.positionNm && loginVO.positionNm != 'null'}">${loginVO.positionNm}</c:if></span></span>
											<span class="txt_email">${loginVO.email}</span> 
										</div>
										<!-- 조직도선택 --> 
										<c:if test="${userSe ne 'MASTER' }">		<!-- 마스터 계정일 때 제외 처리 2016.05.17 장지훈 추가 -->
										<div class="profile_mulltidivi">  
											<select id="multiDivi" style="width:100%;" >
												<c:forEach items="${positionList}" var="list">
													<option value="${list.seq}" <c:if test="${list.deptSeq == loginVO.orgnztId}">selected</c:if> >${list.pathName}</option>
												</c:forEach>
								            </select> 
										</div>
										</c:if>
									</div>
									<div class="profile_log">
										<dl>
											<dt>마지막 접속</dt>
											<dd>${logVO.creatDt}</dd>
										</dl>
										<dl>
											<dt>현재 접속 IP</dt>
											<dd>${logVO.loginIp}</dd>
										</dl>
									</div>
								</div>
								<c:if test="${userSe eq 'MASTER' }">
								<c:if test="${userType eq 'MASTER' }">
								<div class="bot">
									<div class="btn_cen pt12">
										<input type="button" class="gray_btn" value="패스워드변경" onclick="fn_pwdPop('def');"/>
										<input type="button" value="로그아웃" onclick="javascript:main.userLogout();"/>
									</div>
								</div>
								</c:if>
								<c:if test="${userType eq 'USER' }">
								<div class="bot">
									<div class="btn_cen pt12">
										<input type="button" class="gray_btn" value="마스터 권한 변경" onclick="fn_masterAuthPage();"/>
										<input type="button" value="로그아웃" onclick="javascript:main.userLogout();"/>
									</div>
								</div>
								</c:if>
								
								</c:if>
								<c:if test="${userSe ne 'MASTER' }">
								<div class="bot">
									<div class="btn_cen pt12">
										<input type="button" class="gray_btn" value="화면설정" onclick="readyInfo()" style="display: none;"/>
										<input type="button" class="gray_btn" onclick="onclickTopMenu('800000000','마이페이지', '', 'gw')" value="마이페이지" />
										<input type="button" value="로그아웃" onclick="javascript:main.userLogout();"/>
									</div>
								</div>
								</c:if>
							</div>
						</div><!-- //팝업::프로필종료 -->
						
					</div>
					
					<!-- 기타버튼 -->
					<div class="fn_wrap">
						<ul class="fn_list">
							<li class="firstbar"></li>
							<!-- <li><a href="javascript:;" id="" class="ea_btn" title=""></a><span class="alert_cnt">1</span></li>
							<li><a href="javascript:;" id="" class="mail_btn" title=""></a><span class="alert_cnt">2</span></li>
							<li><a href="javascript:;" id="" class="ms_btn" title=""></a><span class="alert_cnt">3</span></li>
							<li><a href="javascript:;" id="" class="msp_btn" title=""></a><span class="alert_cnt">4</span></li>
							<li><a href="javascript:;" id="" class="noti_btn" title=""></a><span class="alert_cnt">5</span></li> -->
							<li>
								<a href="javascript:;" id="" class="alert_btn" title="" onclick="alertBtn_Click();"></a><span id="alertCnt"></span>
								<!-- 팝업::알림 -->
								<div class="header_pop_wrap alert_box" style="display:none;">
    								<div class="h_pop_box" id="alertInfo" tabindex="2" style="outline: none;">
										<div class="pop_shape"></div>
										<div class="pop_t">
											<h3>알림</h3>											
										</div>
										<div class="pop_c" id="alertBox">	
										</div> 
									</div>
								</div>
							</li>
<!-- 							<li class="lastbar"></li> -->
<!-- 							<li> -->
<!-- 								<a href="javascript:;" id="" class="mymenu_btn" title=""></a> -->
								
<!-- 								팝업::나의메뉴 -->
<!-- 								<div class="header_pop_wrap mymenu_box" style="display:none;" id="myMenu"> </div> -->
<!-- 								//팝업::마이메뉴설정종료 -->
<!-- 							</li> -->
						</ul>
					</div> 
					
					<!-- 검색 -->
<!-- 					<div class=""><input type="text" class="search"/><a href="#n" class="search_btn"  title="검색">검색</a></div> -->
					
					<!-- 원격버튼 -->
					<div><a href="#" class="as_btn" title="" id="remoteAS">원격A/S</a></div>
					
					<c:if test="${userSe == 'USER'}"> 
						 <div class="">  
						 <c:if test="${isAdminAuth == true}"> 
						 <a href="#" onclick="changeMode('ADMIN')" class="fn_btn" title="관리자">관리자</a>
						 </c:if>
						 <c:if test="${isMasterAuth == true}"> 
						 <a href="#" onclick="changeMode('MASTER')" class="fn_btn" title="마스터">마스터</a>
						 </c:if>
						 </div>  
					</c:if>		

					<c:if test="${userSe == 'ADMIN'}"> 
						 <div class="">  
						 <a href="#" onclick="changeMode('USER')" class="fn_btn" title="사용자">사용자</a>
						 <c:if test="${isMasterAuth == true}"> 
						 <a href="#" onclick="changeMode('MASTER')" class="fn_btn" title="마스터">마스터</a>
						 </c:if>
						 </div>  
					</c:if>
					
					<c:if test="${userSe == 'MASTER' && id != 'master'}"> 
						 <div class="">  
						 <a href="#" onclick="changeMode('USER')" class="fn_btn" title="사용자">사용자</a>
						 <c:if test="${isAdminAuth == true}"> 
						 <a href="#" onclick="changeMode('ADMIN')" class="fn_btn" title="관리자">관리자</a>
						 </c:if>
						 </div>  
					</c:if>													
			</div>
		</div> 
</div>



<!-- <script>
			$(document).ready(function() {
                    $(".hidden_file_add").kendoUpload({
                        async: {
                            autoUpload: true
                        },
                        showFileList: false,
                        upload:function(e) { 
                        	var groupSeq = $("#groupSeq").val();
							var empSeq = $("#empSeq").val();
							var dataType = $("#dataType").val();
							var pathSeq = $("#pathSeq").val();
							var relativePath = $("#relativePath").val();
							
							var params = "groupSeq=" + groupSeq;
							params += "&empSeq=" + empSeq;
							params += "&dataType=" + dataType;
							params += "&pathSeq=" + pathSeq;
							params += "&relativePath=" + relativePath;
							
                        	e.sender.options.async.saveUrl = '/gw/cmm/file/attachFileUploadProc.do?'+params;
                        },
                        success: onSuccess,
                        select: attachClickHandler
                    });
            });
			
			function attachClickHandler(e)
			{
			    window.setTimeout(function() {
			        $(".hidden_file_add").click(function(e) {
			            // custom logic
			            if (false) {
			                e.preventDefault();
			                return false;
			            }
			        });
			    }, 1);
			}
			
			function onSuccess(e) {
				if (e.operation == "upload") {
				var fileId = e.response.fileId;
				if (fileId != null && fileId != '') {
					var html = '';
					html += "<div style='float:left;padding-left:20px'>";
					html += "<a href='/gw/cmm/file/attachFileDownloadProc.do?fileId="+fileId+"&fileSn=0'>다운로드("+fileId+")</a>";
					html += "<p><img src='/gw/cmm/file/attachFileDownloadProc.do?fileId="+fileId+"&fileSn=0' width='150px' height='150px' /></p>";
					html += "</div>";
					$("#imgContainer").append(html);
				} else {
					alert(e.response);
				}
				
			}
		}  
	
</script> -->




