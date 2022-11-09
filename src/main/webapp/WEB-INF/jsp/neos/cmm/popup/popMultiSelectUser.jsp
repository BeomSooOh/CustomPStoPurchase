<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
 
var openerCode = '0';
var conUrlCode = '0';
var selectUserList = {};
selectUserList.searchDefault = "사용자명 검색";
selectUserList.initData = {};
selectUserList.root = "${root}";
$(function(){
	
	$("#treeSearch").val(selectUserList.searchDefault);
	selectUserList.setEvent();
	
	selectUserList.search_tree();
});


selectUserList.init = function(){
	
	if(opener){ 
		try {
			selectUserList.initData = opener.getMultiSelectUser();	
		} catch (e) {
		}
	}
	
	var name = (selectUserList.initData.name || "").split(",");
	var id = (selectUserList.initData.id || "").split(",");
	var dept = (selectUserList.initData.dept || "").split(",");
	
	 
	if(id.length == name.length && id.length == dept.length){
		for(var i=0, max = id.length; i< max; i++){
			if(id[i] && name[i] && dept[i]){
				var t_id = id[i];
				var t_dept = dept[i];
				var curNode = $.jstree._reference("#organization_tree")._get_node("#" + $.trim(t_id));			
			    for(var j=0;j<curNode.length;j++){
			        if( $(curNode[j]).attr("co_id") == $.trim(t_dept)){
			            $.jstree._reference("#organization_tree").check_node(curNode[j]);  
			        }
			    }
			}

		}
	}
};



selectUserList.setEvent = function(){
	/* 사용자명 검색 엔터 (text) */
	$("#treeSearch").bind({
		keydown : function(e){ 
			if(e.keyCode == 13){
				selectUserList.keywordSearch();
			}
		},
		focus : function(){
			if(selectUserList.isClear()){
				$("#treeSearch").val("");
			}
			
			$(this).css("color","#333");
		},
		focusout : function(){
			$(this).css("color","#a5a5a5");
		}
	});
	
	/* 검색 버튼 */
	$("#btnSearch").bind({
		click : function(){
			selectUserList.keywordSearch();
		}
	});
	
	
	/* 선택리스트 */
	$("#chkListAll").bind({
		click : function(){
			selectUserList.actionTreeCheckAll();
		}
	});
	
	$("#btnDelete").bind({
		click : function(){
			selectUserList.deleteSelect();
		}
	});
	
	$("#btnOk").bind({
		click : function(){
			selectUserList.insert_FolderAdmin();
		}
	});
	$("#btnCancel").bind({
		click : function(){
			selectUserList.cancel();
		}
	});
	$("#close").bind({
		click : function(){
			selectUserList.close();
		}
	});
};


/* 검색창 포커스시 검색창 초기화 시켜야 되는지 ? */
selectUserList.isClear = function(){
	var b = false;
	if($("#treeSearch").val() == selectUserList.searchDefault){
		b = true;
	}
	return b;
};

/* 사용자명 검색 */
selectUserList.keywordSearch = function(){
	selectUserList.search_clear();
    $("#organization_tree").jstree("search", $("#treeSearch").val());
    var search_list = $("#organization_tree .jstree-search");
    
    selectUserList.openSearchBox(search_list);  
};
 
selectUserList.openSearchBox = function(search_list)
{
    var html = '';
    html += '<dl class="searchResult" >';
    html += '<dt class="clearfx"><span>검색결과<strong> ' + search_list.length + '건</strong></span> <a href="javascript:;" onclick="javascript:selectUserList.closeSearchBox();"><img src="' + '<c:url value="/images/btn/btn_close_s.gif" />' + '" width="11" height="11" alt="닫기" /></a>';
    
    var htmlO = '';
    var htmlD = '';
    var htmlE = '';
    for(var i=0; i<search_list.length; i++)
    {
        if($(search_list[i]).attr("rel") == 'O')
        {
            htmlO += '<dd><a href="javascript:;" onclick="javascript:selectUserList.addListSearchBox(\'' + search_list[i].id + '\' ,\'' +  $(search_list[i]).attr("co_id")  +'\' ,\''+ search_list[i].nm  + '\');"><img src="' + '<c:url value="/images/neos/ico/icon_tree_dep1.gif" />' + '" > ' + $(search_list[i]).attr("title") + '</a></dd>';
        }else if($(search_list[i]).attr("rel") == 'D')
        {
            htmlD += '<dd><a href="javascript:;" onclick="javascript:selectUserList.addListSearchBox(\'' + search_list[i].id +'\' ,\'' +  $(search_list[i]).attr("co_id")+ '\');"><img src="' + '<c:url value="/images/neos/ico/icon_tree_dep2.gif" />' + '" > ' + $(search_list[i]).attr("title") + '</a></dd>';
        }else
        {
            htmlE += '<dd><a href="javascript:;" onclick="javascript:selectUserList.addListSearchBox(\'' + search_list[i].id +'\' ,\'' +  $(search_list[i]).attr("co_id")  + '\');"><img src="' + '<c:url value="/images/neos/ico/icon_tree_people.gif" />' + '" > ' + $(search_list[i]).attr("title") + '</a></dd>';
        }
    }
    html += htmlO;
    html += htmlD;
    html += htmlE;
    html += '</dl>';
    $("#searchResult").html(html);
    $("#searchResult").show();
};


selectUserList.addTreeToList = function(node){
	
};

selectUserList.addListSearchBox = function(id, co_id)
{
    var curNode = $.jstree._reference("#organization_tree")._get_node("#" + id);
    for(var j=0;j<curNode.length;j++){
        if( $(curNode[j]).attr("co_id") == co_id){
            $.jstree._reference("#organization_tree").check_node(curNode[j]);  
        }
    }
    selectUserList.closeSearchBox();
};
 
selectUserList.closeSearchBox = function(){
    $("#searchResult").hide();
    selectUserList.search_clear();
};
selectUserList.actionTreeCheckAll = function(){ 
    var isChecked = $("#chkListAll").is(":checked");
    $(":checkbox[name=chkUser]").attr("checked", isChecked);  
};

selectUserList.deleteSelect = function(){
	var chkUser = $(":checkbox[name=chkUser][checked=checked]");
	
      
	chkUser.each(function(){
		var li = $(this).parents("li");
		selectUserList.uncheck_node(li);
	});
}; 

selectUserList.uncheck_node = function(li){
	var user_id = $("[name=user_id]", li).val();
	var user_office = $("[name=user_office]", li).val();
	var curNode = $.jstree._reference("#organization_tree")._get_node("#" + user_id);
	for(var j=0;j<curNode.length;j++){
		if( $(curNode[j]).attr("co_id") == user_office){
			$.jstree._reference("#organization_tree").uncheck_node(curNode[j]);
		}
	}
};

selectUserList.insert_FolderAdmin = function(){
	var name = [];
	var id = [];
	var dept = [];
	
	
	var selectList = $("#selectList");
	var user_id = $(":hidden[name=user_id]", selectList);
	var user_office = $(":hidden[name=user_office]", selectList);
	var chkUser = $(":checkbox[name=chkUser]", selectList);

	for(var i =0, max = user_id.length; i<max; i++){
		id[id.length] = $(user_id[i]).val();
		dept[dept.length] = $(user_office[i]).val();
		name[name.length] = $(chkUser[i]).val();
	}
	if(opener){
		try{
			opener.setMultiSelectUser(name.join(","), id.join(","), dept.join(","));	
		}catch(e){
			
		}	
	}
	
	selectUserList.close();
	
};

selectUserList.cancel = function(){
	var c = confirm("사용자 선택을 취소 하시겠습니까?");
	if(c){
		selectUserList.close();	
	}
};
selectUserList.close = function(){
	
	NeosUtil.close();	
};


selectUserList.search_clear = function(){
    $("#organization_tree").jstree("clear_search");
    $("#organization_tree").jstree("deselect_node");
};
selectUserList.setTreeNodeList = function(){

	$("#chkListAll").attr("checked", false);
	$("#selectList li").remove(); 
	
	$(".jstree-checked, .jstree-undetermined").each(function(){
		var tag = $(this);
		selectUserList.addUser(tag);
	});
};

//트리에서 선택한 부서를 right 에 보여준다 
selectUserList.addUser = function(tag){
	var obj = {};
	if(tag.attr("contenttype") == "M"){
		var co_nm = tag.attr("co_nm");
		var user_id = tag.attr("id");
		var co_id = tag.attr("co_id");
		obj = {
			user_nm : co_nm,
			user_id : user_id,
			co_id : co_id
		};
	}	
   var html = "";
    if(obj.user_id){
    	html = '<li><span class="check"><input type="checkbox" name="chkUser" value="'+obj.user_nm+'"/>';
    	html +='</span> <input type="hidden" name="user_id" value="'+obj.user_id+'"/>';
    	html +='<input type="hidden" name="user_office" value="'+obj.co_id+'"/>';
    	html +='<span class="icoArea"><img src="<c:url value='/images/common/ico_human.gif'/>"/></span>'+obj.user_nm+'</li>';    
    }
    
    var li = $(html);
    li.css("cursor", "pointer").dblclick(function(){
    	selectUserList.uncheck_node($(this));
    	$("#treeSearch").focus();
    	$("#treeSearch").focusout();
    	 
    });
    
    $("#selectList").append(li); 
};
selectUserList.search_tree = function(){
    var conUrl = '';
    conUrl = '<c:url value="/cmm/system/selectTreeOrganization.do" />';
    
    $.ajax({
        type:"post",
        url:conUrl,
        data:{"root_organ_id":selectUserList.root},
        datatype:"json",
        success:function(data){
            
            $("#organization_tree").jstree({
                "json_data":data,
                "rules":{ clickable:false},
                "themes":{"theme":"default"},
                "plugins":["core", "themes", "json_data", "ui", "types", "search", "checkbox"],
                "types":{
                    "valid_children" :["O", "D", "M"],
                    "types" : {
                        "O":{"icon":{"image":"<c:url value='/images/neos/ico/icon_tree_dep1.gif' />"}},
                        "D":{"icon":{"image":"<c:url value='/images/neos/ico/icon_tree_dep2.gif' />"}},
                        "M":{"icon":{"image":"<c:url value='/images/neos/ico/icon_tree_people.gif' />"}}
                    }
                }
            }).bind("check_node.jstree", function (e, data) {
            	selectUserList.setTreeNodeList();
            }).bind("uncheck_node.jstree", function (e, data) {
            	selectUserList.setTreeNodeList();
            }).bind("dblclick.jstree", function(e, data){
            	var tag = $(e.target).closest("li");
            	if(tag.attr("contenttype") == "M"){
    				var t_id = tag.attr("id");
    				var t_dept = tag.attr("co_id"); 
    				var curNode = $.jstree._reference("#organization_tree")._get_node("#" + t_id);			
    			    for(var j=0;j<curNode.length;j++){
    			        if( $(curNode[j]).attr("co_id") == t_dept){
    			            $.jstree._reference("#organization_tree").check_node(curNode[j]);  
    			        }
    			    }
            	}
            	
            }).bind("loaded.jstree", function (event, data) {
            	selectUserList.init();	
            }); 
            
            $("#organization_tree").delegate("a", "dblclick", function(){
                $("#organization_tree").jstree("toggle_node", this);
            });
            
        }
    }); 
};

</script>


<div class="popupWarp" style="width:530px;">
    <div class="popHead clearfx">
        <h1>사용자 선택</h1>
        <a href="javascript:;" class="close" id="close"><img src="../../images/popup/btn_close.gif" width="60" height="27" alt="닫기" /></a>
    </div>
    <div class="popContents clearfx">
        <div class="groupArea fL">
            <div class="userSearch">
                   <input type="text" name="treeSearch" id="treeSearch" style="width:170px;color:#a5a5a5;" value="사용자명 검색"  /> 
                   <a href="javascript:;" id="btnSearch" ><img src="<c:url value='/images/btn/btn_groupSearch.gif' />" alt="검색" /></a>
            </div>
            <div class="groupTreeArea" style="height:325px;overflow-y:scroll;">
                          <div class="tree_con" id="organization_tree"></div>
            </div>
            <div id="searchResult" style="display:none;">
            </div>
        </div>
        <div class="groupListArea" style="width:225px">
            <h2 class=" clearfx">
                <span class="fL" >
                       <span class="check mR5"><input type="checkbox" id="chkListAll" name="chkListAll" /></span>선택리스트
                </span>
                <span class="fR mT5 mR8"><a href="javascript:;" id="btnDelete" class="btn18"><span>삭제</span></a></span>
            </h2>
            <ul id="selectList" >            
            </ul>
        </div>
    </div>
    <p class="tC T10 mT10 brT">
        <a href="javascript:;"  id="btnOk" class="btn28"><span><img src="<c:url value='/images/popup/btn_select.gif' />" alt="" /> 선택</span></a> 
        <a href="javascript:;"  id="btnCancel" class="btn28"><span><img src="<c:url value='/images/popup/btn_cancel.gif' />" alt="취소" /> 취소</span></a>
</div> 