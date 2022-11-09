var documentUtil = {};


documentUtil.getDikeycode = function(){
	var arrCheckedValue = checkBoxSelectedValue(document.getElementsByName("chkDoc"));
    var rowNum = arrCheckedValue.length;                                   
    if(rowNum == 0 ) {
        alert("문서를 선택해주세요.");
        return ;
    }
    if(rowNum > 1 ) {
        alert("문서는 1개만 선택해주세요.");
        return ;
    }
    var grid = $("#grid").data("kendoGrid");                                  
    var dataItem = grid.dataItem(grid.select());
    return dataItem.C_DIKEYCODE;
};   

documentUtil.addReading = function(){
	var c_dikeycode = documentUtil.getDikeycode();
    
    if(!c_dikeycode){
        return;
    }
    
    $("#c_dikeycode").val(c_dikeycode);                                 
    //alert(c_dikeycode);
    var url = _g_contextPath_ +"/neos/edoc/record/popup/readerSelectPop.do?c_dikeycode=" + c_dikeycode+"&openPlace=doc";
    var popup = window.open(url, "userSelect", 'toolbar=no, scrollbar=no, width=575, height=605, resizable=no, status=no');
    popup.focus(); 
}

documentUtil.secretFlag = function(c_dikeycode){
	var ids = $("#list").jqGrid('getDataIDs');								
	var userkey = $("#userkey").val();
	var c_kluserkey = "";
	var c_disecretgrade = "";	
	var chkid = 0;
    for (var i = 0; i < ids.length; i++) {
        var rowdata = $("#list").getRowData(ids[i]);
        if(c_dikeycode == rowdata.c_dikeycode){
        	c_kluserkey = rowdata.c_kluserkey;
        	c_disecretgrade = rowdata.c_disecretgrade;
        	if(c_disecretgrade=='009'){
            	var usertmp = c_kluserkey.split('/');
//            	alert(usertmp.length);
            	for(var j=0;j<usertmp.length;j++){			            		
            		if(userkey==usertmp[j]){			            			
            			chkid++;
            		}
            	}
        	}else return true;
        }  
    }
    if(chkid==0) {return false;}
    else return true;
};

documentUtil.deleteDoc = function(c_dikeycode){
	var ids = $("#list").jqGrid('getDataIDs');								
	
    for (var i = 0; i < ids.length; i++) {
        var rowdata = $("#list").getRowData(ids[i]);
        if(c_dikeycode == rowdata.c_dikeycode){
        	c_rideleteopt = rowdata.c_rideleteopt;
        	if(c_rideleteopt=='d'){
        		return false;
        	}else return true;
        }
    }    
        
};

/** 재기안 (문서함) **/
documentUtil.ReDraftForm = function (keycode, diUserkey){
    if(!documentUtil.secretFlag(keycode)) {
        alert('보안문서는 기안자와 결재라인의 사용자만 재기안 할수 있습니다.');
        return;
    }
    
    if(!documentUtil.deleteDoc(keycode)) {
        alert('삭제된 문서는 재기안 할 수 없습니다.');
        return;
    }
    
    $("#diKeyCode").val(keycode);
    var html = '';
        html += '<p class="f_brown bold">원본 기안문서정보</p>';
        html += '<p class="graybgBox mT10">';
    if(diUserkey == $("#userkey").val()){
        html += '<input type = "checkbox" name="copyApprovalLine" id="copyApprovalLine" value = "Y" /> 기존 결재선정보';    
    }
    else{
        html += '<input type = "checkbox" name="copyApprovalLine" id="copyApprovalLine" value = "Y" disabled /> 기존 결재선정보';  
    }
        html += '<span class="L20"><input type = "checkbox" name="copyAttachFile" id="copyAttachFile" value = "Y"/> 첨부파일 포함</span></p>';
        html += '<p class="mT8 tC"><a href="#" class=" defaultBtn" onclick="javascript:documentUtil.ReDraftPop();"><span><strong>확인</strong></span></a> <a href="#" class=" defaultBtn" onclick="$(this).parent().parent().hide()"><span><strong>취소</strong></span></a></p>';
        html += '<a href="#" style="position:absolute; right:8px; top:8px;" onclick="$(this).parent().hide()"><img src="' +_g_contextPath_ + '/images/btn/btn_close_s.gif" alt="닫기" /></a>';
        
        $("#memoView").html(html); 
        $("#memoView").css("top",event.clientY-30);
        $("#memoView").show();        
};     

/** 재기안 (회수함) **/
documentUtil.ReDraftForm2 = function (keycode){
    
    $("#diKeyCode").val(keycode);
    var html = '';
    /*
        html += '<p class="f_brown bold">원본 기안문서정보</p>';
        html += '<p class="graybgBox mT10">';
        html += '<input type = "checkbox" name="copyApprovalLine" id="copyApprovalLine" value = "Y" />기존 결재선정보';    
        html += '<span class="L20"><input type = "checkbox" name="copyAttachFile" id="copyAttachFile" value = "Y"/> 첨부파일 포함</span></p>';
        html += '<p class="mT8 tC"><a href="#" class=" defaultBtn" onclick="javascript:documentUtil.ReDraftPop();"><span><strong>확인</strong></span></a> <a href="#" class=" defaultBtn" onclick="$(this).parent().parent().hide()"><span><strong>취소</strong></span></a></p>';
        html += '<a href="#" style="position:absolute; right:8px; top:8px;" onclick="$(this).parent().hide()"><img src="' +_g_contextPath_ + '/images/btn/btn_close_s.gif" alt="닫기" /></a>';
    */
        
        html += '<div class="pop_tit">';
        html += '	<h6>재기안</h6>';
        html += '	<a href="#" class="btn_close" title="닫기" onclick="$(this).parent().parent().hide()"></a>';
        html += '</div>';
        html += '<div class="pop_con">';
        html += '	<p>원본 기안문서정보</p>';
        html += '	<div class="box_gray">';
        html += '		<input type="checkbox" name="copyApprovalLine" id="copyApprovalLine" value = "Y" class="k-checkbox">';
        html += '		<label class="k-checkbox-label" for="copyApprovalLine" style="padding:0.2em 0 0 1.5em;">기존 결재선정보</label>';
        html += '		<input type="checkbox" name="copyAttachFile" id="copyAttachFile" value = "Y" class="k-checkbox">';
        html += '		<label class="k-checkbox-label" for="copyAttachFile" style="margin:0 0 0 15px;padding:0.2em 0 0 1.5em;">첨부파일 포함</label>';
        html += '	</div>';
        html += '</div>';
        html += '<div class="pop_btn">';
        html += '	<button type=button id="textButton" class="k-primary" onclick="javascript:documentUtil.ReDraftPop();">확인</button>';
        html += '	<button type=button id="textButton" onclick="$(this).parent().parent().hide()">취소</button>';
        html += '</div>';
           
        $("#memoView").html(html); 
        $("#memoView").css("top",event.clientY-30);
    
        //팝업버튼
        $(".pop_btn button").kendoButton();
        
        $("#memoView").show();
        
};   

documentUtil.ReDraftPop = function (){
    
       $("input:checkbox[name='copyApprovalLine']").each(function(){
           if(this.checked==true){
               $("#copyApprovalLine").val("Y");
           }else{
               $("#copyApprovalLine").val("N");
           }
       });
       
       $("input:checkbox[name='copyAttachFile']").each(function(){
           if(this.checked==true){
               $("#copyAttachFile").val("Y");
           }else{
               $("#copyAttachFile").val("N");
           }
       });
       
       var obj = {
               diKeyCode : $("#diKeyCode").val(),
               copyApprovalLine : $("#copyApprovalLine").val(),
               copyAttachFile : $("#copyAttachFile").val()
               };
       var param = NeosUtil.makeParam(obj);        
       
       var uri = getContextPath()+ "/edoc/eapproval/workflow/docApprovalCopyPopup.do?"+ param;
       openWindow2(uri,  "popDocApprovalCopy", 1000, 700, 0, 1) ;
   };
   
documentUtil.setReadYN = function (c_dikeycode){
	var data = {"c_dikeycode":c_dikeycode};
	$.ajax({
		type:"post",
		url: getContextPath()+ '/neos/edoc/delivery/receive/setReadYN.do',
		datatype:"json",
		data: data,
		async: true,
		success:function(data){	
			if(data=='ok'){
				location.reload();
			}
			//location.reload();
		},error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);		       
		}
	});
};

documentUtil.readChk = function(c_dikeycode){
	var id = $("#list").getGridParam('selarrrow');
	var ids = $("#list").jqGrid('getDataIDs');								
	var c_dikeycode = c_dikeycode;
	var readyn = "";
	//alert(userkey);
    for (var i = 0; i < ids.length; i++) {
        var rowdata = $("#list").getRowData(ids[i]);
        if(c_dikeycode == rowdata.c_dikeycode){
        	readyn = rowdata.c_rireadyn;
        	if(readyn == 'Y'){
        		return true;
        	}else {return false;}
        }  
    }
};

documentUtil.makeSubgrid = function(c_dikeycode,c_diseqnum,subgrid_id, row_id){
	$(".sgexpanded").click();
	$("#dischk").val('1');
	var resultData = {};
	var end = 0;
	var fail = 0;
    var dodal = 0;
    var susin = 0;
    var jubsu = 0;		
    var resendreq = 0;
    var etc = 0;
    var bansong = 0;
	$.ajax({ 
    	   type:"post",
    	   url: _g_contextPath_ +"/send/popup/detailStatus.do?c_dikeycode="+c_dikeycode+"&c_diseqnum="+c_diseqnum,
           datatype: "json",  	           

           success:function(data){	
        	   resultData = data.resultList;  								        	   
        	   var html = "";
        	   for(var i=0;i<resultData.length;i++){
        		   var status = "";
        		   if(resultData[i].c_sistatus=='003'){
        			   end++; status = "<font class=\"f_gray \">" +resultData[i].sistatus +"</font>";
        		   }
        		   else if(resultData[i].c_sistatus=='004' || resultData[i].c_sistatus=='900') {
                	   fail++;
                	   status = "<font class=\"f_red\">" +resultData[i].sistatus +"</font>";
                   }
                   else if(resultData[i].c_sistatus=='005'){
                    	dodal++; 
                    	status = "<font class=\"f_gray \">" +resultData[i].sistatus +"</font>";
                    }
                    else if(resultData[i].c_sistatus=='006'){
                    	susin++;
                    	status = "<font class=\"f_green\">" +resultData[i].sistatus +"</font>";
                    }
                    else if(resultData[i].c_sistatus=='007'){
                    	bansong ++;
                    	status = "<font class=\"f_orange\">" +resultData[i].sistatus +"</font>";
                    }
                    else if(resultData[i].c_sistatus==''){
                    	jubsu++;
                    	status = "<font class=\"f_blue\">" +resultData[i].sistatus +"</font>";
                    }
                    else if(resultData[i].c_sistatus=='010'){
                    	resendreq++;
                    	status = "<font class=\"f_blue\">" +resultData[i].sistatus +"</font>";
                    }else if(resultData[i].c_sistatus=='902'){
                    	etc++;
                    	status = "<font class=\"f_blue\">" +resultData[i].sistatus +"</font>";
                    }else{
                        etc++;
                        status = "<font class=\"\">" +resultData[i].sistatus +"</font>";
                    }
        		   if(resultData[i].c_sireceivecode=='zzzzzzz'){
        			   resultData[i].sisendtype = '비전자';
        		   }
                    html+="                                <tr>";
                    html+="                                <td align='center'><input type='checkbox' class='subgridCheckbox' c_sireceivecode='"+resultData[i].c_sireceivecode+"' c_sireceivename='"+resultData[i].c_sireceivename+"'/></td>";
                    html+="                               <td class='left'>"+resultData[i].c_sireceivename+"</td>";
                    html+="                               <td align='center'>"+resultData[i].sisendtype+"</td>";
                    html+="                               <td align='center'>"+status+"</td>";
                    html+="                               <td class='left'>"+resultData[i].c_sijubsukigwan+"</td>";
                    html+="                               <td align='center'>"+resultData[i].c_sijubsuuser+"</td>";
                    html+="                               <td align='center'>"+resultData[i].c_sireceiveday+"</td>";
                    html+="                               <td align='left'>"+resultData[i].c_simemo+"</td>";
                    html+="                               </tr>";
               }
        	   
        	   var html2="";
        	   html2+="<tr class='subTableArea' style='border-top: 1px solid #d5d5d5;'>";
        	   html2+="                <td colspan='8'>";                    
        	   html2+="                     <p class='subTableTitle' style='margin: 5px 0px 2px 20px; font-size: 12px;'><strong class==\"mL15\">총 "+resultData.length+"건</strong>"; 
        	   html2+="                        [발송중: <font class=\"f_red\">"+end+"</font>건, 발송실패: <font class=\"f_red\">"+fail+"</font>건, 도달: <font class=\"f_red\">"+dodal+"</font>건, 수신: <font class=\"f_red\">"+susin+"</font>건, 접수: <font class=\"f_red\">"+jubsu+"</font>건, 재전송요청 : <font class=\"f_red\">" + resendreq +"</font>건 , 반송 : <font class=\"f_red\">" + bansong +"</font>건 , 기타 : <font class=\"f_red\">" + etc +"</font>건]</p>";
        	   html2+="                        <div class='subtable' style='padding-left:50px;'>";
        	   html2+="                            <table width='100%' border='0' cellspacing='0' cellpadding='0' class='table_board3'>";
        	   html2+="                            <col width='28' />";
        	   html2+="                            <col width='145' />";
        	   html2+="                            <col width='75' />";
        	   html2+="                            <col width='75' />";
        	   html2+="                            <col width=''' />";
        	   html2+="                            <col width='105' />";
        	   html2+="                            <col width='105' />";
        	   html2+="                            <col width='105' />";
        	   html2+="                                <tr>";
        	   html2+="                                    <th scope='col'><input type='checkbox' onclick='documentUtil.subgridCheckOnClick(this)' /></th>";
        	   html2+="                                    <th scope='col'>수신처</th>";
        	   html2+="                                    <th scope='col'>구분</th>";
        	   html2+="                                    <th scope='col'>상태</th>";
        	   html2+="                                    <th scope='col'>접수기관</th>";
        	   html2+="                                    <th scope='col'>접수자</th>";
        	   html2+="                                    <th scope='col'>일시</th>";
        	   html2+="                                    <th scope='col'>비고</th>";
        	   html2+="                                </tr>" ; 
        	   html2+=html;
        	   html2+="                            </table>";
        	   html2+="                        </div>" ;                   
        	   html2+="                </td>";
        	   html2+="            </tr>";
        	   var tr = $(html2);
        	   $(".ui-subgrid").replaceWith(tr).addClass("sgexpanded"); 
       	      	
           } 
    });
};



documentUtil.subgridCheckOnClick = function(target){
	var checked = $(target).attr("checked");
	
    $("#list").resetSelection();
    $(".subgridCheckbox").attr("checked",false);
		
	if(checked){
		var dataIds = $('#list').jqGrid('getDataIDs');
		for(var i=0;i<dataIds.length;i++){
			var data = $("#list").jqGrid("getRowData", dataIds[i]);
			var selector ="#"+dataIds[i]+" td.sgcollapsed";
			var temp = $(selector,$('#list'));
			if(temp.length==0){
				$("#list").jqGrid("setSelection",dataIds[i]);
				$(".subgridCheckbox:not(:disabled)").attr("checked",true);
			}
		                                              }
	//jqg_list_3
	//alert(subgrid_id);
	} 
};

documentUtil.docDeleteChk = function(){
    var c_dikeycode = documentUtil.getDikeycode();
    if(!c_dikeycode){
        return;
    }
    
    //미선택 또는 여러개 선택시 getDikeycode 함수에서 걸러짐
    /*var $jqList = $('#list');
    var rowId = $jqList.getGridParam('selrow');
    var rowItem = $jqList.getRowData(rowId);
    
    var msg = '선택한 문서 [' + $(rowItem.c_dititle).text() + ']를 ' 
    + (rowItem.c_rideleteopt == 'd' ? '복원' : '삭제') + '하시겠습니까?';
    
    if(!confirm(msg)){
        return;
    }*/
    documentUtil.docDelete(c_dikeycode);
};

documentUtil.docDelete = function(c_dikeycode){
	$.ajax({
        type:"post",
        url: getContextPath() + "/neos/edoc/document/record/board/common/docDelete.do",
        datatype:"json",
        data: {"c_dikeycode" : c_dikeycode},
        success:function(data){    
            if(data.deleteChk=="0"){
            	alert("연동문서는 삭제가 불가능합니다.");
            }
            else if(data.deleteChk=="1"){
                alert('완료되었습니다.');
                location.reload();
            }
            else alert('에러가 발생하였습니다.');
        },error:function(e){
            alert(e);
        }
    });
};

documentUtil.docDetail = function(){
    var c_dikeycode = documentUtil.getDikeycode();
//    
//    if($("#"+c_dikeycode).attr("value")=='d'){
//        alert("삭제된 문서는 열수 없습니다.");
//        return;
//    }
    
//    if(!documentUtil.secretFlag(c_dikeycode)){
//    	alert("보안문서는 열수 없습니다.");
//    	return;
//    }
    
    if(!c_dikeycode){
        return;
    }
    
    $("#c_dikeycode").val(c_dikeycode);     

    var url = getContextPath() + '/neos/edoc/document/record/DocDetailPopup.do?c_dikeycode=' + c_dikeycode;
    var popup = window.open(url, "userSelect", 'toolbar=no, scrollbar=no, width=826, height=584, resizable=no, status=no');
    popup.focus();        
};

documentUtil.reDraftG20Chk = function (c_dikeycode, c_tikeycode){
	
	if(!confirm("재기안 하시겠습니까?")){ return; }
	var data = {"c_dikeycode":c_dikeycode};
	$.ajax({
		type:"post",
		url: getContextPath()+ '/erp/g20/chkReDraftPossible.do',
		datatype:"json",
		data: data,
		async: true,
		success:function(data){			
			if(data.abdocuInfo){
				var abdocu = data.abdocuInfo;
				if(abdocu.docu_mode == "1"){
					if(abdocu.abdocu_no_reffer){
						alert("참조품의 결의서는 재기안 할수 없습니다.");
						return;		
					}
				}
				
				documentUtil.reDraftG20(abdocu, c_tikeycode);
				
			}else{
				alert("회계정보가 존재하지 않습니다.");
				return;
			}
		},error:function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
};
	
documentUtil.reDraftG20=function(abdocu, template_key){
		var data = { abdocu_no : abdocu.abdocu_no};
		$.ajax({
			type:"post",
			url: getContextPath()+ "/erp/g20/reDraftG20Copy.do",
			datatype:"json",
			data: data,
			async: true,
			success:function(data){			
				if(data.abdocuInfo){
					var abdocu_no = data.abdocuInfo.abdocu_no;
					var obj = {
							abdocu_no:abdocu_no
							,mode:abdocu.docu_mode
							,focus:"txt_BUDGET_LIST"
							,template_key:template_key
					};
					var param = NeosUtil.makeParam(obj);
					var url = _g_contextPath_ +"/erp/g20/abdocu.do?" + param;
					openWindow(url,"963", "700", "yes" );

				}else{
					return;
				}
			},error:function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});	
		
};
