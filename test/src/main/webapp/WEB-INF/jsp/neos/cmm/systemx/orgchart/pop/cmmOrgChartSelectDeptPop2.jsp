<meta http-equiv="X-UA-Compatible" contentType="IE=8" />
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"    uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html>
<head>
<%-- <script type="text/javascript" src="<spring:message code='neos.comonPath' />/js/neos/tab.js"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/util/jquery.urlParam.js' />"></script> --%>

    <script type="text/javascript">
        $(document).ready(function() {  
        //기본버튼
           $(".controll_btn button").kendoButton();
        
//            var c_dikeycode = $.urlParam("c_dikeycode");
//            var c_dikeycode = ""; 
//            $("#c_dikeycode").val(c_dikeycode);
//            search_tree();
//            selectReadingStatus();
           //getSusinList();
           getCount();
        });
    
    function selectReadingStatus(){
        var data = get_input_data("hiddenvalue", "input", "hidden");
        var resultData = '';
        $.ajax({
            type:"post",
            url:'<c:url value="/record/board/selectReadingStatus.do" />?readingtype=2',
            datatype:"json",
            data: data,
            success:function(data){     
                resultData = data.resultList;
                
                var org="";
                for(var i=0;i<resultData.length;i++){
                	org = '<tr name="'+resultData[i].c_rsuserkey+'">';
                    org += '<td>';
                    org += '<input type="checkbox" name="department" class="k-checkbox" value="'+resultData[i].c_rsuserkey+'" id="'+resultData[i].c_rsuserkey+'"/><label class="k-checkbox-label" for="'+resultData[i].c_rsuserkey+'" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">';
                    org += '</td>';
//                     org += '<td id="">'+resultData[i].c_rsusername+'</td>';
                    org += '<td class="le" id="orgName">'+resultData[i].c_rsusername+'</td>';
                    org += '</tr>';
                    //org = '<li><a href="javascript:;" name="'+resultData[i].c_rsuserkey+'" ><span class="check"><input type="checkbox"  name="department"  value="'+resultData[i].c_rsusername+'"/></span><span class="icoArea"><img src="<c:url value="/images/common/ico_human.gif"/>"  alt="" /></span></a> '+resultData[i].c_rsusername+'</li>';
                    $("#selectOrgan").append(org);                  
                }
                getCount();
            },error:function(e){

            }           
        });
        
    }

    function deleteOrganSelect() {
        var checkedList = $("#selectOrgan :checkbox[name=department][checked=checked]");
        $(checkedList).each(function() {
            var aTag = $(this).parent().parent();
            if (aTag.length) {
                aTag.remove();
            }
        });
        getCount();
    }
    
    function deleteChkboxSelect(){
        var checkedList = $("#selectOrgan :checkbox[name=department]");
        if($("#check_all").attr("checked")=="checked"){
            checkedList.attr("checked",true);
        }else {
            checkedList.attr("checked",false);
        }       
    }

    function deleteOrganList() {
        var checkedList = $("#selectOrgan :checkbox[name=department]");
        $(checkedList).each(function() {
            var aTag = $(this).parent().parent();
            if (aTag.length) {
                aTag.remove();
            }
        });
        getCount();
    }

    function callbackOrgChart(item) {
        $("#organId").val(item.seq);
        $("#organNm").val(item.name);
//         $("#organIDOfDept").val(organIDOfDept);
        $("#deptChk").val(item.gbn);
        var deptChk = $("#deptChk").val();
        var organNm = $("#organNm").val();
        var organId = $("#organId").val();
//         var sendderNm = $("#sendderNm").val();
        var isFlag = $("#selectOrgan tr[name=" + organId + "]").length;
        if (deptChk != 'd') {
            alert('부서만 추가 가능합니다.');
            return;
        }
        if (isFlag) {
            alert('동일한 부서는 추가하실 수 없습니다.');
            return;
        }       
        if (organId == $("#c_oiorgcode").val()) {
        //    alert('자신이 속한 부서는 추가하실 수 없습니다.');
        //    return;
        }
        var num = 0;
        var org = "";
        if (organNm != "") {
            org = '<tr name="'+organId+'">';
            org += '<td><input type="checkbox" name="department" value="'+organId+'" class="k-checkbox" id="'+organId+ '"><label class="k-checkbox-label" for="'+organId+'" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;"></td>';
            org += '<td class="le" id="orgName">'+organNm+'</td>';
            /* org += '<a href="javascript:;" name="'+organId+'" ><span><input type="hidden" name="deptNm" value="'+organNm+'"/><input type="checkbox"  name="department"    value="'+sendderNm+'"/>'
                    + sendderNm + '</span></a>'; */
            org += '</tr>';     
            num++;
        }

        var html = $("#selectOrgan").html();
        $("#selectOrgan").append(org);
        getCount();
    }
    
    function getCount(){
        var i = 0;
        var checkedList = $("#selectOrgan :checkbox[name=department]");
        $(checkedList).each(function() {
            i++;            
        });
        $("#totalCnt").html(i);
        
    }

    function keywordSearch(){
        var treeSearch = $("#searchKeyword").val();
        
        if(treeSearch !== "") {
            $("#treeview .k-group .k-group .k-in").closest("li").hide();
            $("#treeview .k-group .k-group .k-in:contains(" + treeSearch + ")").each(function() {
                $(this).parents("ul, li").each(function () {
                    $(this).show();
                });
            });
        } else {
            $("#treeview .k-group").find("ul").show();
            $("#treeview .k-group").find("li").show();
            
        }    	
        
    }
    
    function deptInsert(){
        var checkedList = $("#selectOrgan :checkbox[name=department]");
        var userIdArray = [];
        var userIdString = "";
        var userNmArray = [];
        var userNmString = "";
        $(checkedList).each(function(){
            var aTag = $(this).parent();
            
            if(aTag.length){
                var aName = $(aTag).parent().attr("name");
                var Nm = $(this).val();
                if(aName){
                    userIdArray[userIdArray.length] = aName;
                    userIdString = userIdString+","+aName;
                }
                if(Nm){
                    userNmArray[userNmArray.length] = Nm;
                    userNmString = userNmString+","+Nm;
                }
            }           
        });
        if(userIdString!=''){
            userIdString = userIdString.substring(1);
        }
        if(userNmString!=''){
            userNmString = userNmString.substring(1);
        }
        //alert(userIdArray.join(","));
         
        success_method(userIdString, userNmString);

    }
    
    function success_method(obj,objNm){

        var objId = obj;
        if(obj){
            objId = obj.split(",");
        }
        $("#readingUserId").val(objId);
        $("#readingUserNm").val(objNm);
        //alert(obj+" : "+objNm);
        insert_DeptForArchive();
    }
    
    function insert_DeptForArchive(){  
        var data = get_input_data("hiddenvalue", "input", "hidden");
        //alert(data.c_dikeycode);
        $.ajax({
            type:"post",
            url:'<c:url value="/archive/popup/insertShareArchive.do" />',
            datatype:"json",
            data: data,
            success:function(data){
            	if(data.result >0){
            		alert("공유처리 되었습니다.");
            		window.close();
            	}else{
            		alert('공유처리 실패하였습니다.');
            	}
                
                opener.location.reload();
                
            },error:function(e){
                alert('공유처리 실패하였습니다.');
            }           
        });
        //window.close();
    }

</script>
</head>
<div id="hiddenvalue">
	<input type="hidden" id="c_oiorgcode" value="${c_oiorgcode}" />
	<input type="hidden" id="organId" value="" />
	<input type="hidden" id="organNm" value="" />
	<input type="hidden" id="deptChk" value="" />
	<input type="hidden" id="sendderNm" value="" />
	<input type="hidden" id="c_dikeycode" name="c_dikeycode" value="${c_dikeycode}"/>
	<input type="hidden" id="readingUserId" value=""/>
	<input type="hidden" id="readingUserNm" value=""/>
</div>
<body>
    
<div class="pop_wrap viewer_wrap" style="width:598px;">    
    <div class="pop_head">
        <h1>공유부서선택</h1>
              <a href="javascript:window.close();" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo01.png'/>" alt="" /></a>
    </div>
    <div class="pop_con">
        <div class="box_left">

                <p class="record_tabSearch">
                    <input class="k-textbox input_search" id="searchKeyword" type="text" value="" style="width:184px;" placeholder="조직검색" onfocusin="javascript:clearContent(this);"  onKeyDown="javascript:if (event.keyCode == 13) { keywordSearch(); }">
                    <a href="javascript:keywordSearch();" class="btn_search"></a>
                </p>

                <!-- 부서탭-->
                <div class="treeCon" >                                  
                    <div id="treeview" class="tree_icon" style="height:463px;">
<%--                     <jsp:include page='/systemx/include/orgChartListChkBox.do'></jsp:include> --%>
                    <jsp:include page='/systemx/orgChartList.do'></jsp:include>
                    </div>
                </div>                          
                            
        </div><!-- //box_left -->   

        <div class="box_right">
        <div class="option_top">
            <ul>
                <li><input type="checkbox" name="check_all" id="check_all" class="k-checkbox"  onclick="javascript:deleteChkboxSelect();">
                    <label class="k-checkbox-label" for="check_all" style="padding:0.2em 0 0 1.5em;">선택리스트</label>
<!--                     <input type="checkbox" name="num_chk" id="num_chk2" class="k-checkbox"> -->
<!--                     <label class="k-checkbox-label" for="num_chk2" style="margin:0 0 0 6px; padding:0.2em 0 0 1.5em;">숫자열람</label> -->
                </li>
<!--                 <li> -->
<!--                     <div class="updo_div"> -->
<%--                         <a href="" class="up"><img src="<c:url value='/Images/ico/ico_order_up01.png'/>" alt="" /></a> --%>
<%--                         <a href="" class="down"><img src="<c:url value='/Images/ico/ico_order_down01.png'/> " alt="" /></a> --%>
<!--                     </div> -->
<!--                 </li> -->
            </ul>
            
            <div id="" class="controll_btn" style="padding:0px;float:right;">
                <button id=""  type="button" onclick="deleteOrganSelect();">삭제</button>
            </div>
        </div>
        
        <div class="com_ta2" >
            <table id="selectOrgan">
                <colgroup>
                    <col width="50"/>
<%--                     <col width="120"/> --%>
                    <col />
                </colgroup>
            </table>
        </div>
        
        </div><!-- //box_right -->
                
    </div>
    
    <div class="pop_foot">
        <div class="btn_cen pt12">
            <input type="button" value="등록" onclick="javascript:deptInsert();"/>
            <input type="button" class="gray_btn" value="취소" onclick="javascript:window.close();"/>
        </div>
    </div><!-- //pop_foot -->
    </div><!-- //pop_wrap -->

</body>
</html>
