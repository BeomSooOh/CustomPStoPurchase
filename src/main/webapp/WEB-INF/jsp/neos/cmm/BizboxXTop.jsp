<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ page import="neos.cmm.util.code.CommonCodeSpecific" %>
<%
/**
 *
 * @title 화면 레이아웃의 Top 부분
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 24.
 * @version
 * @dscription
 *
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용
 * -----------  -------  --------------------------------
 * 2012. 4. 24.  박기환        최초 생성
 *
 */
%>
<%
String search =  CommonCodeSpecific.getBlueSearch();
%>
<style>
    .gnbv {padding:0.5em; background-color: #111;}
    .gnbv ul li {display: inline; padding: 0.1em;}
    .gnbv ul li a {color:#fff; font-weight:bold; text-transform: uppercase; text-decoration:none;}
</style>
<script type="text/javascript" src="<c:url value='/js/custom.js'/>"></script>
<script>
$(function(){
    <%-- if(<%=search.equals("N")%>)
    {
        $(".headerLayer").css("left","-154px");
    }else{
        $(".headerLayer").css("left","12px");
    } --%>
    $("#subposit").click(function(){
        $(".headerLayer").show();
    });

});
function portal_move()
{
    var linkNm = '${linkNm}';
    var link = '<c:url value="/NeosMain.do" />';
    if(linkNm !=null && linkNm !=''){
        link += '?menu='+linkNm;
    }
    location.href =  link ;
/*
    var form = document.createElement('form');
    form.name = "move";
    form.method = "post";
    form.action = link;

*/

/*
    var element = document.createElement('input');
    element.type = 'hidden';
    element.name = 'menu';
    element.value = '';
    form.appendChild(element);
*/

/*
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
*/
}

function eSign_move()
{
//  새 메뉴이동(패키지) 2013.03.14 박민우
    var arrParam = new Array();
    arrParam[0] = new Param("menuNm", "standingList");
    top.goto_menuDirect(arrParam);
}

function unifiedSearch_move()
{
//  새 메뉴이동(패키지) 2013.03.14 박민우
    var arrParam = new Array();
    var searchKeyword = $("#searchKeyword").val();
    //alert(searchKeyword);
    arrParam[0] = new Param("menuNm", "unifiedSearchList");
    arrParam[1] = new Param("search", searchKeyword);
    ///alert(arrParam[1]);
    top.goto_menuDirect(arrParam);
}
keywordErase = function(){
    $("#searchKeyword").val("");
}
function Eapproval_Count(count){
    $("#eapprovalCnt").html(count);
}
function top_refresh(){

    $.ajax({
        type:"get",
        url:'<c:url value="/neos/main/selectStandingListCount.do" />',
        datatype:"json",
        data: {"userid":"${loginVO.id}"},
        success:function(data){
            $("#eapprovalCnt").html(data.result);
        }
    });
}
$(document).ready( function() {
    //겸직정보 출력
        var nowOrgnztId = "${user.orgnztId}";
        var jsondata = $.parseJSON('${subpositionList}');
        var eapprovalCnt = {};
        var esntlId = "";
        var deptId = "" ;
        var rowNum = 0 ;
        if(typeof(jsondata) != "undefined" && jsondata != ""  ) {
            rowNum = jsondata.length ;
        }

        var sub_html = "";
        for(var inx = 0; inx < rowNum ; inx++ ) {
            esntlId = jsondata[inx].esntlId;

                sub_html += '<li>'
                         +'     <a href="javascript:changeOrgnzt(\''+jsondata[inx].orgnztId+'\', \'\');"><dl';

                        //현재 선택 부서 지정하기
                        if(jsondata[inx].orgnztId==nowOrgnztId){
                            sub_html += ' class="active"';
                        }

                sub_html +=     '>'
                         +'     <dt>부서 : <strong>'+jsondata[inx].orgnztNm+'</strong></dt>'
                         +'     <dd style="width:125px;">직위: <strong>'+jsondata[inx].positionNm+'</strong></dd>'
                         +'     <dd style="width:85px;">결재대기<strong class="f_deepGreen" id="'+jsondata[inx].orgnztId+'_1">[0]</strong></dd>'
                         +'     <dd style="width:75px;">열람문서<strong class="f_deepGreen" id="'+jsondata[inx].orgnztId+'_2">[0]</strong></dd>'
                         +' </dl></a>'
                        +'</li>';


        }
        $("#subposition_info").append(sub_html);

        for( var inx = 0 ; inx  < rowNum ; inx++) {
            esntlId = jsondata[inx].esntlId;
            deptId = jsondata[inx].orgnztId;
            $.ajax({
                type:"get",
                url:'<c:url value="/neos/main/selectMainCount.do" />',
                datatype:"json",
                async: false,
                data: {"userid":esntlId,
                       "deptid":deptId},
                success:function(data){
                    var result = data.result;
                    for(var i=0;i<result.length;i++){
                        //대기문서 갯수 가져오기
                        if(result[i].KEY=="1"){
                            $("#"+deptId+"_1").html("["+result[i].COUNT+"]");
                        }
                        //열람문서 갯수 가져오기
                        if(result[i].KEY=="4"){
                            $("#"+deptId+"_2").html("["+result[i].COUNT+"]");
                        }
                    }
                }
            });
        }

} );


function directMenu(val){
    var arrParam = new Array();
    arrParam[0] = new Param("menuNm", val);
    top.goto_menuDirect(arrParam);
    /* $(".menuList .active").removeClass("active").show();
    $("#menuArea").css({marginLeft:0}); //메뉴Area를 복원한다.
    $(".lnbOpenBtn").show();
    $(".btnOpen").hide(); */
}

function open_adm(){
    var url ="/gw/NeosMain.do";
    
	openWindow(url ,"1024", "700" );
}

</script>
	<div id="headerWrap">
	<div id="header" class="clearfx">
    	<h1><a href="javascript:;" onclick="javascript:portal_move();"><img src="<c:url value='${logoInfo }'/>" width="212"  height="52"/></a></h1>
        <div class="headMenu">
        	<%-- <p class="homeMenu"><a href="#"><img src="<c:url value='/images/layout/btn_home.gif'/>" width="70" height="22" alt="home" /></a><a href="#"><img src="<c:url value='/images/layout/btn_potal.gif'/>" width="79" height="22" alt="마이포털" /></a></p> --%>
            <div class="globalMenu clearfx">
                <!-- 검색 폼 -->
                 <ul class="gnb clearfx">
                	 <!-- <li><a href="javascript:;" onclick="javascript:eSign_move();">전자결재 <strong id="eapprovalCnt"></strong></a></li>
                   <li><a href="#">웹메일 <strong>4</strong></a></li>
                    <li><a href="#">공유알림 <strong>4</strong></a></li> -->
                </ul>
                <p class="text_id"><a href="javascript:;" onclick="javascript:open_adm();" id= "idBtnLogout" class="btnLog"><span>관리자</span></a> </p>
                <p class="text_id"><strong>${loginVO.name} ${loginVO.positionNm}</strong> (${loginVO.orgnztNm}) 
				<a href="<c:url value='/uat/uia/actionLogout.do'/>" id= "idBtnLogout" class="btnLog"><span>로그아웃</span></a> </p>
				<div class="infoBtn2"><a  href="javascript:;" onclick="javascript:eSign_move();"  class="top_doc" title="전자결재"><strong id="eapprovalCnt"></strong></a></div>
				<p class="user"><a href="#" class="infoBtn">겸직정보 <img src="<c:url value='/images/common/arrow_down2.gif'/>" alt="" /></a> </p>
                
				  <%
				if(!CommonCodeSpecific.getBlueSearch().equals("N"))
				{
				%>

				<div class="total_search">
                  <input type="text" name="searchKeyword" id="searchKeyword" value="Blue Search ver1.0" class="total_search_input"  maxlength="50" onclick="javascript:keywordErase();" onkeyup="javascript:if(event.keyCode==13){unifiedSearch_move(); return false;}"/>
                   <div class="total_search_bt"><a href="javascript:;" onclick="javascript:unifiedSearch_move();">검색</a></div>
                </div>


                 <script>
                 	$(".headerLayer").css("left","12px");
                 </script>
                <% 
                 }else{ 
                %>
                <script>
                 	$(".headerLayer").css("left","-92px;");
                 </script>
                <%
                 }
                %>

				
				<div class="headerLayer">
                	<ul class="multiInfo" id="subposition_info">
                    </ul>
                    <a href="#" class="btnClose"><img src="<c:url value='/images/layout/btn_headerClose.gif'/>" alt="닫기" /></a>
                </div>
            </div>
        </div>
    </div>
    
            <nav class="gnbv">
            <ul>
                <li><a href="javascript:;" onclick="javascript:directMenu('EdocMain');" >업무관리 / </a></li>
                <li><a href="javascript:;" onclick="javascript:search_tree_menu('200000000');" >메일 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('scheduleViewMonth');" >일정 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('EdocMain');" >전자결재 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('selectBoardLatestList');" >게시판 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('');" >문서 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('EssUserInfo');" >대사우서비스 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('myinfoView');" >마이페이지 / </a></li>
                <li><a href="javascript:;" onclick="javascript:directMenu('');" >확장기능</a></li>
            </ul>
        </nav>
    
    
    </div>



</header>
    <script>

        function changeOrgnzt(ognztId, menu){
            if(menu.length==0){
                menu = "<%=session.getAttribute("menu")%>";
            }
            var param = "";
            if(menu==null){
                param = "id=${loginVO.id}&orgnztId="+ognztId;
            }else{
                param = "id=${loginVO.id}&orgnztId="+ognztId+"&menu="+menu;
            }
            self.location = "<c:url value='/NeosMoveDept.do?"+param+"'/>";
        }

        //대기문서 갯수
        //var session_uniq_id = "${loginVO.uniqId}";
        //var session_orgnzt_id = "${loginVO.orgnztId}";

        //$.ajax({
        //  type:"get",
        //  url:'<c:url value="/neos/main/selectMainCount.do" />',
        //  datatype:"json",
        //  data: {"userid":session_uniq_id},
        //  success:function(data){
        //      var result = data.result;
        //      for(var i=0;i<result.length;i++){
        //          if(result[i].KEY=="1"){
        //              $("#eapprovalCnt").html(result[i].COUNT);
        //          }
        //      }
        //  }
        //});

    </script>






