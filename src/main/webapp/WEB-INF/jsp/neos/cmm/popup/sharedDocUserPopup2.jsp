<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
    <script type="text/javascript">
    
    var idx = 0;   // row 복제후 id값 변경을 위해 인덱스 선언
    
    $(document).ready(function() {  
        
        $('#btnText').focus();
        
        //기본버튼
        $(".controll_btn button").kendoButton();
        
        //검색
        $(".btn_search").click(function(e){
            search();
            
        });
        //순서열람 체크
        var inOrderCheck = "${inOrder}";
        if(inOrderCheck == "0"){
            $("#inorder").attr("checked",true);
        }
        
        $("input[name='empSeq']").attr("checked",true);

        $('#btnText').on('keypress', function(e) {
            if (e.which == 13) {
                search();
            }
        }); 
        
        getInitUser();

        //조직도검색 셀렉트
        $("#organ_sel").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource : [
                        {text:"전체", value:"0"}, 
                        {text:"이름", value:"1"},
                        {text:"아이디", value:"2"}
            ],
            index: 0
        }); 
        
        $("#removeSelEmpBtn").click(function(e){
             var arr = $("#selEmpListTable").find("input:checked");
             if (arr.length > 0) {
                for(var i = 0; i < arr.length; i++) {
                    $(arr[i]).parents("tr").remove();
                }
             }
             $("input[name='empSeq']").attr("checked",true);
             setCount();
        }); 
        
        $("#empListChkAll").click(function(e){
             var ischeck = $(this).is(':checked');
             var arr = $("#empListTable").find(".empchk");
             if (arr.length > 0) {
                for(var i = 0; i < arr.length; i++) {
                    $(arr[i]).prop("checked", ischeck);         // 프로퍼티를 변경해야 이벤트가 정상적으로 동작
                    if (ischeck == true) {
                        selectEmp(arr[i]);
                    } 
                } 
             }
        });  
        
        $("#selEmpListChkAll").click(function(e){ 
             var ischeck = $(this).is(':checked');  
             var arr = $("#selEmpListTable").find(".selempchk");
             if (arr.length > 0) {
                for(var i = 0; i < arr.length; i++) {
                    $(arr[i]).prop("checked", ischeck);         // 프로퍼티를 변경해야 이벤트가 정상적으로 동작
                }
             }
        }); 
        
        $("#fncSave").click(function(e){             
        	var selectList = $("#selEmpListTable");
            var arrUserID = $(":hidden[name=empSeq]", selectList);
            var arrUserOffice = $(":hidden[name=deptSeq]", selectList);
            var arrUserLoginId = $(":hidden[name=viewName]", selectList);
            var arrChkUser = $(":hidden[name=empName]", selectList);
            var arrSuContentType = $(":hidden[name=suContentType]", selectList);
            
            if ( typeof(arrUserID) == "undefined") {
                alert("선택된 사용자가 없습니다.");
                return ;
            }
            
            var rowNum = arrUserID.length ;
            
            var suUserKey = "" ;
            var suOrgCode = "" ;
            var userName = "" ;
            var userId = "";
            var suContentType = "" ;
            
            var arrContentType = new Array(rowNum);
            var arrUserName = new Array(rowNum);
            var arrUserKey  = new Array(rowNum);
            var arrOrgnztID = new Array(rowNum);
            var arrUserId = new Array(rowNum);
            
            for(var inx =0 ; inx < rowNum; inx++){
                suUserKey = $(arrUserID[inx]).val();
                suOrgCode= $(arrUserOffice[inx]).val();
                userName = $(arrChkUser[inx]).val();
                suContentType =$(arrSuContentType[inx]).val();
                userId = $(arrUserLoginId[inx]).val();
                
                arrContentType[inx] = 'M';
                arrUserName[inx] = userName;
                arrUserKey[inx] = suUserKey;
                arrOrgnztID[inx] = suOrgCode;
                arrUserId[inx] = userId;
            }      
            if(opener){
                try{
//                  alert(opener);
//                  $(opener.location).attr("href", "javascript:${param.methodName}('"+arrContentType.join(",")+"', '"+arrUserName.join(",")+"', '"+arrUserKey.join(",")+"', '"+arrOrgnztID.join(",")+"');");
                    eval("opener.${param.methodName}('"+arrContentType.join(",")+"', '"+arrUserId.join(",")+"', '"+arrUserKey.join(",")+"', '"+arrOrgnztID.join(",")+"');"); 
                }catch(e){
                    alert(e);
                }   
            }
            self.close();
            
            
            
        }); 
        
        
        
        var moveRowUp = function(element) {
            if( element.prev().html() != null ){
                element.insertBefore(element.prev());
            }  else {
                alert("최상단입니다.");
            }
        };
        
        var moveRowDown = function(element) {  
            if( element.next().html() != null){
                element.insertAfter(element.next());
            } else {
                alert("최하단입니다.");
            }
        };
        
        $("#down").click(function(e){ 
              var check = $("#selEmpListTable").find("input:checked");
              if (check.length > 1 ) {
                  alert("이동하려는 행을 하나만 선택해주세요");
              } 
              else if(check.length == 0) {
                  alert("이동 하려는 행을 선택해주세요");
              }
              else {
                  var element = check.parents("tr");
                  moveRowDown(element);
              }
          });
          
        $("#up").click(function(e){
            var check = $("#selEmpListTable").find("input:checked");
              if (check.length > 1 ) {
                  alert("이동하려는 행을 하나만 선택해주세요");
              } 
              else if(check.length == 0) {
                  alert("이동 하려는 행을 선택해주세요");
              }
              else {
                  var element = check.parents("tr");
                  moveRowUp(element);
              }
          });
             
    });  
    
    function getInitUser() {
        var arrContentType;
        var arrUserName ;
        var arrUserKey ;
        var arrOrgnztID ;
            try {
                opener.getMultiSelectUser("${param.pageType}"); 
                
                arrContentType = opener.g_arrContentType;
                arrUserName =  opener.g_arrUserName;
                arrUserKey = opener.g_arrUserKey;
                arrOrgnztID = opener.g_arrOrgnztID;
                if(typeof(arrContentType) == "undefined") return ;
                
                arrContentType = arrContentType.split(",");
                arrUserName = arrUserName.split(",");
                arrUserKey = arrUserKey.split(",");
                arrOrgnztID = arrOrgnztID.split(",");
                
            } catch (e) {
            }
        var rowNum = 0 ;

        if( typeof(arrContentType) == "undefined"  ) {
            return;
        } 
        rowNum = arrContentType.length ;

        if( typeof(rowNum) == "undefined"  ) {
            rowNum = 0 ;
        }
        
        var contentType = "" ; 
        var orgCode = "" ; 
        var userKey = "" ; 
        var userName = "" ; 
        var readingUserList = "";
        for(var inx = 0 ; inx < rowNum ;inx++) {
        	
             contentType = arrContentType[inx];
             orgCode     = arrOrgnztID[inx] ;
             userKey     = arrUserKey[inx] ;
             userName    = arrUserName[inx];
             
             var c_count = inx+1;
             if(contentType!=""){
             arrContentType[inx] = 'M';
             readingUserList += "<tr>";
             readingUserList += "    <td class=\"le\">";
             readingUserList += "        <input type=\"checkbox\" id=\"selchk_"+c_count+"\" name=\"empSeq\" value=\""+userKey+"\" class=\"k-checkbox selempchk\">";
             readingUserList += "        <label class=\"k-checkbox-label\" for=\"selchk_"+c_count+"\" style=\"margin:0 0 0 10px; padding:0.2em 0 0 1.5em;\">";
             readingUserList +=          userName;
             readingUserList += "        <input type=\"hidden\" name=\"deptSeq\" value=\""+orgCode+"\">";
             readingUserList += "    </td>  ";
             readingUserList += "    <td class=\"\"></td>";
             readingUserList += "    <td class=\"\"></td>";
             readingUserList += "</tr>  ";
             }
             /* var curNode = $.jstree._reference("#organization_tree")._get_node("#" + $.trim(userKey));
                
             for(var j=0;j<curNode.length;j++){
             if( $(curNode[j]).attr("co_id") == $.trim(orgCode)){
             $.jstree._reference("#organization_tree").check_node(curNode[j]);
             }
             } */
         }
        
        $("#selEmpListTable").append(readingUserList);
        
             
    }
    
    // 선택된 사원 목록 총개 갱신
    function setCount() {
                
        var rowCount = $('#selEmpListTable tr').length;
                
        $("#selectEmpCount").html("("+rowCount+")");
    }
    
    function search() {
        var type = $("#organ_sel").val();
            
            var data = {};
            
            var keyword = $("#btnText").val();
            
            switch (type) { 
                case 0 : 
                    data.nameAndLoginId = keyword; 
                    break;
                case 1 : data.empName = keyword; 
                    break;
                case 2 : data.loginId = keyword; 
                    break;
                default: 
                    data.nameAndLoginId = keyword; 
                    break;
            } 
            
            data.mainDeptYn = $("#mainDeptYn").val();
            
            $.ajax({
                type:"post",
                url:'<c:url value="/cmm/systemx/cmmOrgChartInnerEmpList.do" />',
                data:data,
                datatype:"json",            
                success:function(data){
                    $("#empListDiv").html(data);
                } 
            });
        
        
    }
    
            
            
    </script>


<script>
    //조직도 callback 구현
    function callbackOrgChart(item) {
        $.ajax({
            type:"post",
            url:'<c:url value="/cmm/systemx/cmmOrgChartInnerEmpList.do" />',
            data:{groupSeq:item.groupSeq, compSeq:item.compSeq, bizSeq:item.bizSeq, deptSeq : item.seq, mainDeptYn : $("#mainDeptYn").val()},
            datatype:"json",            
            success:function(data){
                $("#empListDiv").html(data);
            }
        });
    } 
      
</script>

<input type="hidden" id="mainDeptYn" value="${params.mainDeptYn}" />

<div class="pop_wrap organ_wrap" style="width:580px;">
    <div class="pop_head">
        <h1>열람자지정</h1>
        <a href="#n" class="clo" onclick="javascript:window.close();"><img src="<c:url value='/Images/btn/btn_pop_clo01.png' />" alt="" /></a>
    </div>
                    
    <div class="pop_con">
        <div class="box_left">
            

            <p class="record_tabSearch">
                <input id="organ_sel" style="width:66px;" />
                <input class="k-textbox input_search" id="btnText" type="text" value="" style="width:120px;" placeholder="">
                <a href="#" class="btn_search" id=""></a>
            </p>

            <!-- 조직도-->
            <div class="treeCon" >                                  
                <div id="treeview" class="tree_icon" style="height:221px;"></div>
            </div>      
            
            <!-- 사원목록 -->
            <div class="emp_list">
                <p class="tit">사원목록</p>
                <div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="120"/>
                            <col width="75"/>
                            <col />
                        </colgroup>
                        <tr>
                            <th class="le">
                                <input type="checkbox" name="inp_chk" id="empListChkAll" class="k-checkbox">
                                <label class="k-checkbox-label" for="empListChkAll" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">
                                이름
                            </th>
                            <th class="">부서</label></th> 
                            <th class="">직급</label></th>
                        </tr>
                    </table>
                </div>  
        
        <div class="com_ta2"style="height:128px;" id="empListDiv">
            
        </div>
            
            </div>

            <!-- //사원목록 -->
                            
        </div><!-- //box_left -->   

        <div class="box_right2">
        <form id="selectForm" name="selectForm">
        <input type="hidden" id="c_ritypeflag" name="c_ritypeflag" value="1"/>
        <input type="hidden" id="c_dikeycode" name="c_dikeycode" value="${param.c_dikeycode }"/>
        <div class="option_top">        
            <ul>
                <li><input type="checkbox" name="num_chk" id="selEmpListChkAll" class="k-checkbox" style="position: static;">
                    <label class="k-checkbox-label" for="selEmpListChkAll"  style="margin:0 3px 0 3px;">선택리스트</label>
                    <input type="checkbox" name="inorder" id="inorder"  value="true" class="k-checkbox" style="position: static;">
                    <label class="k-checkbox-label" for="inOrder">순차열람</label></li>
                <li>
                    <div class="updo_div">
                        <a href="#none" id="up"><img src="<c:url value='/Images/ico/ico_order_up01.png'/>" alt="위로이동"/></a>
                        <a href="#none" id="down"><img src="<c:url value='/Images/ico/ico_order_down01.png'/>" alt="아래로이동" /></a>
                    </div>
                </li>
            </ul>
            
            <div id="" class="controll_btn" style="padding:0px;float:right;">
                <button type="button" id="removeSelEmpBtn" >삭제</button>
            </div>
        </div>

        <div class="com_ta2">
            <table>
                <colgroup>
                    <col width="120"/>
                    <col width="75"/>
                    <col />
                </colgroup>
                <tr>
                    <th class="">이름</th>
                    <th class="">부서</label></th>
                    <th class="">직급</label></th> 
                </tr>
            </table>
        </div>  
        
        <div class="com_ta2"style="height:387px;margin-top:0px;" >
                <table id="selEmpListTable">
                    <colgroup>
                        <col width="120"/>
                        <col width="75"/>
                        <col />
                    </colgroup>
    
                    <c:forEach items="${selectEmpList}" var="list" varStatus="c">
                        <tr>
                            <td class="le">
                                <input type="checkbox" id="selchk_${c.count}" name="empSeq" value="${list.empSeq}" class="k-checkbox selempchk">
                                <label class="k-checkbox-label" for="selchk_${c.count}" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">
                                ${list.empName}
                                <input type="hidden" name="deptSeq" value="${list.deptSeq}">
                            </td>  
                            <td class="">${list.deptName}</td>
                            <td class="">${list.dutyCodeName}</td>
                        </tr>  
                    </c:forEach>
                
                </table>
        </div>      
        </form>
        </div><!-- //box_right2 -->

    </div><!-- //pop_con -->    

    <div class="pop_foot">
        <div class="btn_cen pt12">
            <input type="button" value="저장" id="fncSave"/>
            <input type="button" class="gray_btn" value="취소" onclick="javascript:window.close();" />
        </div> 
    </div><!-- //pop_foot -->
    </div><!-- //pop_wrap -->


<!-- <div>
    <label for="searchKeyword">사원검색</label> <span   class="k-textbox k-space-right" style="width:200px;"> 
        <input type="text" id="searchKeyword" name="searchKeyword" value="" /> 
        <a href="#" class="k-icon k-i-search" onclick="searchKeyword();">&nbsp;</a>
    </span>
</div> -->



<script>
                var inline = new kendo.data.HierarchicalDataSource({
                    data: [${orgChartList}],
                    schema: {
                        model: {
                            id: "seq",
                            children: "nodes"
                        } 
                    }
                });
                
               /*  var checkChildren = '${checkChildren}';
                
                if (checkChildren == null || checkChildren == '' || checkChildren == 'false') {
                    checkChildren = false;
                } else {
                    checkChildren = true;
                } */ 
    
                $("#treeview").kendoTreeView({
                    /* checkboxes: {
                        checkChildren: checkChildren
                    }, */
                    dataSource: inline,
                    select: onSelect,
                    dataTextField: ["name"],
                    dataValueField: ["seq", "gbn"]
                }); 
                
                function onSelect(e) {
                    var item = e.sender.dataItem(e.node);
                    
                    callbackOrgChart(item); // 반드시 구현
                }
                
            </script>

</div>
</html>



