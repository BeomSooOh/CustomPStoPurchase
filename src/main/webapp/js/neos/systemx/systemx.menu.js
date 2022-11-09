var menu = {};

menu.topMenuInfo = {};

menu.leftMenuList = [];

menu.edmsDomain = null;

menu.isFirstMenu = true;

menu.callMenuInfo = {};

menu.directMoveUrl = {};

menu.directUrlId = null;

menu.docParameters = {};

var mainmenu = {};

var pageFlag = true;

var firstMenu = "";

var exceptMenuType = "";

var edmsCategoryList = "";

var dirGroupNo = "";


/** top 메뉴 클릭 **/
mainmenu.clickTopBtn = function(no, name, url, urlGubun, email){
	
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
	
};


mainmenu.mainToLnbMenu = function(no, name, url, urlGubun, email, portletType, gnbMenuNo, lnbMenuNo, lnbName , mainForward){
	
	$("#no").val(no);
	$("#name").val(name);
	$("#url").val(url);
	$("#urlGubun").val(urlGubun);
	$("#portletType").val(portletType);
	$("#gnbMenuNo").val(gnbMenuNo);
	$("#lnbMenuNo").val(lnbMenuNo);
	$("#lnbName").val(lnbName);
	$("#mainForward").val(mainForward);
	
		
	
	if (urlGubun == 'mail' || urlGubun == 'adminMail') {
		form.action="bizboxMail.do";
	}else {
		form.action="bizbox.do";
	}
	
	form.submit();
	
};


/** 초기화 **/
menu.init = function() {
	
	console.log('menu.init');
	
	menu.leftMenuList = [];
	menu.isFirstMenu = true;
	menu.callMenuInfo = {};
	menu.docParameters = {};
	menu.directMoveUrl = {};
	
};


/** top 메뉴 클릭 **/
menu.clickTopBtn = function(no, name, url, urlGubun, menuGubun) {

	if (urlGubun == 'mail') {
		menu.go(urlGubun, url);
		return;
	}
		
	menu.init();
	
	menu.topMenuInfo = {};	
	menu.topMenuInfo.name = name;
	menu.topMenuInfo.menuNo = no;
	
	/* 왼쪽메뉴 상단 제목 */
	$(".sub_nav_title").html(name);
	
	/* 왼쪽메뉴 상단 아이콘 */
	/* ma 메일
	   ea 전자결재
	   dc 문서
	   st 시스템설정
	   sc 일정
	   ds 대사우서비스		
	   wk 업무
	   gt 근태관리	
	   bd 게시판	
	   mp 마이페이지	
	   mg 메신저
	   et 확장기능
	   nt 노트 */
	/* 현재 메뉴를 구분할 수 있는 값이 name밖에 없어 일단 name으로 처리합니다. */
	$(".side_wrap").removeClass("ma ea dc st sc ds wk gt bd mp mg et nt");
	if (name == "메일") {
		$(".side_wrap").addClass("ma");
	} else if (name == "전자결재" || name == "전자결재(영리)") {
		$(".side_wrap").addClass("ea");
	} else if (name == "문서") {
		$(".side_wrap").addClass("dc");
	} else if (name == "시스템설정") {
		$(".side_wrap").addClass("st");
	} else if (name == "일정" || name == "일정관리") {
		$(".side_wrap").addClass("sc");
	} else if (name == "대사우서비스") {
		$(".side_wrap").addClass("ds");
	} else if (name == "업무" || name == "업무관리") {
		$(".side_wrap").addClass("wk");
	} else if (name == "근태관리") {
		$(".side_wrap").addClass("gt");
	} else if (name == "게시판") {
		$(".side_wrap").addClass("bd");
	} else if (name == "마이페이지") {
		$(".side_wrap").addClass("mp");
	} else if (name == "메신저") {
		$(".side_wrap").addClass("mg");
	} else if (name == "확장기능") {
		$(".side_wrap").addClass("et");
	} else {
		$(".side_wrap").addClass("nt");
	}
	
	menu.topMenuInfo.url = url;
	menu.topMenuInfo.urlGubun = urlGubun;
	menu.setLeftMenu(no);
};


menu.timeline = function(target){
	
	menu.leftMenuList = [];
	menu.isFirstMenu = false;
	menu.callMenuInfo = {};
	
	if (target == "timeline") {
		form.action="timeline.do";
	}
	else {
		form.action="userMain.do";
	}
	
	form.submit();
	
};


/** 메인에서 페이지 이동 **/
menu.mainforwardPage = function(url) {
	
	if (url == null || url == '') {
		//alert('1');
		//alert("죄송합니다. 서비스 준비중입니다.");
		return;
	}
	
	if (forwardType == 'main') {
		$("#mainForward").val("mainForward");
		$("#url").val(url);
		form.submit();
	}
	
};



/** 한글 기안 팝업 **/
menu.approvalPopup = function(popType, param, popName) {
	
	if(ncCom_Empty(popName)) {
		popName = "popDocApprovalEdit";
	}
	if(popType == "POP_ONE_DOCVIEW") {
		param= "multiViewYN=N&"+param;
	}else {
		param= "multiViewYN=Y&"+param;
    }
	
	var uri = "/ea/edoc/eapproval/docCommonDraftView.do?"+ param;
	
	return openWindow2(uri,  popName,  _g_aproval_width_, _g_aproval_heigth_, 1,1) ;
	
};


/** 알림 데이터 조회 폴링방식 
 *  알림 카운트만 조회하도록 변경. 한용일.
 * **/
menu.alertPolling = function() {
	
	setTimeout(function(){
		$.ajax({ 
			type:"post",
			url: _g_contextPath_ + "/alertCnt.do", 
			datatype:"text",
			complete: menu.alertPolling,
			success:function(data){	
				
				if (data.alertCnt != null) {
					var cnt = parseInt(data.alertCnt);
					if (cnt > 0) {
						$("#alertCnt").attr("class", "alert_cnt");
						$("#alertCnt").html(cnt);
					}
				}
				//$("#alertBox").html(data); 
			},
			error: function(xhr) { 
		      console.log('FAIL : ', xhr);
		    }
		});
	}, 600000); // 10분 
	
}; 

/** 1회용 알림 카운트 조회 **/
menu.alertCnt = function() {
	$.ajax({ 
		type:"post",
		url: _g_contextPath_ + "/alertCnt.do", 
		datatype:"text",
		complete: menu.alertPolling,
		success:function(data){	
			
			if (data.alertCnt != null) {
				var cnt = parseInt(data.alertCnt);
				if (cnt > 0) {
					$("#alertCnt").attr("class", "alert_cnt");
					$("#alertCnt").html(cnt);
				}
			}
			//$("#alertBox").html(data); 
		},
		error: function(xhr) { 
	      console.log('FAIL : ', xhr);
	    }
	});
};

/** 1회용 알림 데이터 조회 **/
menu.alertInfo = function() {
	$.ajax({ 
		type:"post",
		url: _g_contextPath_ + "/alertInfo.do", 
		datatype:"text",
		success:function(data){								
			$("#alertBox").html(data); 
		},
		error: function(xhr) { 
	      console.log('FAIL : ', xhr);
		}
	});
};


/** 알림 읽음 처리 및 페이지 이동 처리 
 * 
 * alertSeq 	: 알림 seq -> t_co_alert
 * forwardType  : 메인, 서브
 * type  		: 페이지 이동 종류(NOTICE 또는 메뉴 구분 MENU001 ..)
 * gnbMenuNo	: 상단 메뉴 번호
 * lnbMenuNo	: 왼쪽 메뉴 번호(선택 할 메뉴)
 * url			: iframe 보여질 페이지 url
 * urlGubun		: 컨네이터명(edms,gw, project, schedule)
 * seq			: 게시판 번호 -> 게시판 메뉴는 DB 없고, 게시판 솔루션에서 개발한 API를 호출하여 즉시 만들기 때문에 메뉴번호가 아닌 seq를 소분류 메뉴와 합산하여 정하기 위한 seq
 * name			: 메뉴명
 * 
 * */
menu.moveAndReadCheck = function(alertSeq, forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name) {
	
	if (alertSeq != null && alertSeq.length > 0) {
		menu.alertReadCheck(alertSeq);
	}
	
	menu.move(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name);
	
	menu.hideGbnPopup();
	
}

menu.moveAndReadCheck2 = function(alertSeq, forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name) {
	
	if (alertSeq != null && alertSeq.length > 0) {
		menu.alertReadCheck(alertSeq);
	}
	
	menu.clickTimeline(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name)
	
	menu.hideGbnPopup();
	
}


/** 알림 읽첨 처리 db  **/
menu.alertReadCheck = function(alertSeq) {
	$.ajax({
	    url: _g_contextPath_ + "/alertReadCheckProc.do",
	    dataType: 'json',
	    data:{alertSeq:alertSeq},
	    success: function(data) { 
	    	//console.log(data);
	    },
	    error: function(xhr) { 
	      console.log('FAIL : ', xhr);
	    }
   });
};


/** 페이지 이동 */
menu.move = function(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name) {
		
	// 공지사항은 게시판으로 선택될 메뉴 시퀀스를 만들어줘야함(2단메뉴 + 시퀀스)
	if (type == 'NOTICE' || type == 'MENU005') {
		
		if (seq != null && seq != '') {
			lnbMenuNo = parseInt(lnbMenuNo)+parseInt(seq);
		}
		
		name = "게시판";
		
		urlGubun = "edms";
	}
	
	if (forwardType == 'main') {
		$("#mainForward").val("mainForward");
		$("#url").val(url);
		$("#urlGubun").val(urlGubun);
		$("#gnbMenuNo").val(gnbMenuNo);
		$("#no").val(gnbMenuNo);
		$("#name").val(name);
		$("#lnbMenuNo").val(lnbMenuNo);
		
		form.submit();
	} else {
		// bixbox.do
		menu.forwardFromMain(type, gnbMenuNo, lnbMenuNo, url, urlGubun, name,'');
	}
	
};

menu.clickTimeline = function(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name){
	
	$("#mainForward").val(forwardType);
	$("#url").val(url);
	$("#urlGubun").val(urlGubun);
	$("#gnbMenuNo").val(gnbMenuNo);
	$("#no").val(gnbMenuNo);
	$("#name").val(name);
	$("#lnbMenuNo").val(lnbMenuNo);
	
	if (urlGubun == 'mail') {
		form.action="bizboxMail.do";
	} else {
		form.action="bizbox.do";
	}
	
	form.submit();
	
};


/** 메인에서 페이지 이동 신규 **/
menu.mainMove = function(type, urlPath, seq) {
	
	$.ajax({
	    url: _g_contextPath_ + "/mainPortletLnb.do",
	    dataType: 'json',
	    data:{langCode:'kr', portletType:type},
	    success: function(data) { 
	      var portlet = data.portletInfo;
	       
	      console.log("portlet",portlet);
	      $("#mainForward").val("mainForward");
		  $("#url").val(urlPath);
		  $("#urlGubun").val(portlet.lnbMenuGubun);
		  $("#gnbMenuNo").val(portlet.gnbMenuNo);
		  $("#no").val(portlet.gnbMenuNo);
		  $("#portletType").val(type);
		  $("#name").val(portlet.gnbMenuNm);
		  $("#lnbName").val(portlet.lnbMenuNm);
		   
		  var lnbMenuNo = portlet.lnbMenuNo;
		  // 공지사항은 게시판으로 선택될 메뉴 시퀀스를 만들어줘야함(2단메뉴 + 시퀀스)
		  if (type == 'NOTICE') {
			  
			  if (seq != null && seq != '') {
				  lnbMenuNo = parseInt(lnbMenuNo)+parseInt(seq);
			  }
		  }
		  
		  $("#lnbMenuNo").val(lnbMenuNo);
		  if (portlet.lnbMenuGubun == 'mail') {
			  form.action="bizboxMail.do";
		  } else {
			  form.action="bizbox.do";
		  }
		  form.submit();
	      
	    },
	    error: function(xhr) { 
	      console.log('FAIL : ', xhr);
	    }
   });
	
};


/** 메인 iframe에서 페이지 이동 **/    

menu.forwardFromMain = function(portletType, gnbMenuNo, lnbMenuNo, url, urlGubun, menuNm , lnbName , mainForward) { 
	
	// 왼쪽 메뉴 붙이기
	$("#sub_nav_jstree").html(""); 
	
	
	$.ajax({
		type:"post",
		url: _g_contextPath_ + "/cmm/system/getMenu2Depth.do",
		data:{startWith : gnbMenuNo}, 
		datatype:"json",			 
		success:function(data){	
			
			var items = "";	
			var menuNo = [];
			var menuType = "";
			if (data.depth2Menu) {
				
				$.each(data.depth2Menu,function (index,val){
					items += "<div class='sub_2dep' id='"+index+'dep'+"'><span  class='"+val.expendClass+"'>"+val.name+"</span></div>";			

					/* 특정 매뉴는 api를 호출하기때문에 예외처리(게시판 , 문서 , 프로젝트관리 , 웹팩스)*/
					if((val.childCount > 0) || ((val.menuNo == "501000000") || (val.menuNo == "505000000") || (val.menuNo == "601000000") || (val.menuNo == "901000000") ) ) {
						items += "<div id='"+val.menuNo+"'class='sub_2dep_in'></div>";
					}
					menuNo[index] = val.menuNo ;	
										
					if(val.urlPath != "" && val.childCount == 0 ){	
						menu.directMoveUrl = {urlGubun: val.urlGubun , url : val.urlPath , text : val.name };
						menu.directUrlId = val.menuNo;
						$(document).on('click',"#"+index+'dep',function () {
							fncDirectUrl();
						});
					}
				});
												
				$("#sub_nav_jstree").html(items);
				

				menu.topMenuInfo = {};
	
				menu.topMenuInfo.name = menuNm;
				
				menu.topMenuInfo.menuNo = gnbMenuNo;
				
				
				
				$(".sub_nav_title").html(menuNm);
														
				for(var idx = 0 ; idx < menuNo.length; idx++) {
					//전자결재 일 경우
					if(menuNo[idx] == "2002000000") {
						menuType = "eaBox";
					}else if(menuNo[idx] == "501000000") {
						menuType = "edms";
					}else if(menuNo[idx] == "505000000") {
						menuType = "project";
					}else if(menuNo[idx] == "601000000") {
						menuType = "doc";
					}else {	menuType = "";
					}
					menu.setForwardLnb(menuNo[idx],lnbMenuNo,gnbMenuNo,url,urlGubun,menuType,mainForward ,portletType);
					
				}	
			}
		} 
	});
}

menu.setForwardLnb = function(upperMenuNo,lnbMenuNo,gnbMenuNo,url,urlGubun,menuType,mainForward ,portletType) {	
			
	var mainForwardCheck = ""
		mainForwardCheck = mainForward;
	$('#'+upperMenuNo).jstree({
	'core' : {
		  'data' : {
		   'url' :  _g_contextPath_ + '/cmm/system/getJsTreeList.do',
		   'cache' : false,
		   'dataType': 'JSON',
		   'data' : function (node) {
				  if(node.id != "#") {
					   if(node.id == '602010000' || node.original.exceptGubun == 'eaCategory') {
						   // 문서 > 전자결재 > 카테고리별 문서관리 하위에 트리를 만들기 위해 예외처리
						   menuType = 'eaCategory';
					   }					   
					   if(menu.docParameters.dirRootNode != 'undifined' || menu.docParameters.dirRootNode != null){
						   // 카테고리 분류 Root노드가 아닐경우 
						   menu.docParameters.dirRootNode = 'childeNodes';
					   }
				  }
			      return {'upperMenuNo' : (node.id == "#" ? upperMenuNo : node.id ) 
			    	  ,'level' : (node.id == "#" ? "1" : node.original.level )  
			    	  ,'firstDepthMenuNo' : gnbMenuNo , 'menuType' :  menuType 
			    	  ,'dir_group_no' : (menu.docParameters.dirGroupNo == null ? 0 : menu.docParameters.dirGroupNo)/*뷴류선택  카테고리 그룹No 업무분류(0) 카테고리(그룹번*/
			    	  ,'dir_type' :( menu.docParameters.dirType == null ? "W" : menu.docParameters.dirType)/*뷴류선택 카테고리 Type 업무뷴류(W) 카테고리(C)*/
			    	  ,'dir_rootNode' : (menu.docParameters.dirRootNode == null ? "root" : menu.docParameters.dirRootNode)}/*Root 폴더를 만들기 위해 필요한 파라미터*/
			   }
			  }
			}})
		.bind("loaded.jstree", function(event, data) {
			// 트리 Load 시		
						
			if(upperMenuNo.toString().substring(0,3) == lnbMenuNo.toString().substring(0,3)){
				var activeDepth2Menu = $("#"+lnbMenuNo).parents('.sub_2dep_in').prev();
				//activeDepth2Menu.addClass("active");
				activeDepth2Menu.next(".sub_2dep_in").show();	
				$('#'+upperMenuNo).jstree("open_all");
			}
			
			//문서 > 일반문서 예외처리 (별도 api 제공)
			if(upperMenuNo == '601000000' && $("#userSe").val() == 'USER'){
														
				//일반 문서 메뉴 일 경우 분류선택 Button
				menu.fnGetEdmsGroupContens();		
				var categoryListBox = "<a href='#n' onClick='' class='type_btn'>분류선택</a><div id='' class='type_list'>"+edmsCategoryList+"</div>"; 
				$('#'+upperMenuNo).append(categoryListBox);
				$('#rootClass').addClass('select_item');
				$('#'+upperMenuNo).jstree("open_all");	

			}	
			//$(this).jstree("open_all");
			$(this).jstree('select_node', '#'+lnbMenuNo);
			
		})
		.bind("after_open.jstree", function(event,data) {
				var activeDepth2Menu = $("#"+lnbMenuNo).parents('.sub_2dep_in').prev();
				//activeDepth2Menu.addClass("active");
				activeDepth2Menu.next(".sub_2dep_in").show();			

				if($(this).jstree(true).get_node('#'+lnbMenuNo, true)){
					$(this).jstree(true).get_node('#'+lnbMenuNo, true).children('.jstree-anchor').focus();				
					$(this).jstree('select_node', '#'+lnbMenuNo);
				}
		})
		.bind("select_node.jstree", function(event, data) {	
			//메인 iframe 호출 시 모든노드를 펼친후 찾는다.
			if( mainForwardCheck == 'mainForward'){
				menu.callMenuInfo.menuNo = lnbMenuNo ;
				menu.go(urlGubun,url);
				mainForwardCheck = 'leftForward';
			}else{
				menu.onSelect(data);
			}
			menu.getLeftMenuHistory(data);
		})
		.bind("refresh.jstree", function(event, data) { 
				//refresh 하면 분류선택 버튼이 없어지기 떄문에 function다시 호출하여 버튼 생성
				if(upperMenuNo == '601000000'){					
					//일반 문서 메뉴 일 경우 분류선택 Button
					menu.fnGetEdmsGroupContens();
					var categoryListBox = "<a href='#n' class='type_btn'>분류선택</a><div id='' class='type_list'>"+edmsCategoryList+"</div>"; 
					$('#'+upperMenuNo).append(categoryListBox);
					$('#rootClass').removeClass('select_item');

					$("#"+upperMenuNo).jstree("open_all");	
				}
		});	
	
};

/** 
 * 왼쪽 메뉴 히스토리 가져오기 위한 ajax
 * 
 * 번호  메뉴명
 * 100 전자결재
 * 110  ㄴ문서함
 * 111    ㄴ결대대시함
 * 
 */
menu.getMenuHistoryOfMenuNo = function(no, callbackFunction) {
	
	
	$.ajax({
	    url: _g_contextPath_ + "/cmm/system/getMenuListOfMenuNo.do",
	    dataType: 'jsonp',
	    data:{menuNo:no},
	    jsonpCallback: "myCallback",
	    success: function(data) { 
	      console.log('SUCESS : ', data);  
	      
	      if (data.length > 0) {  
	    	  
	    	  if (callbackFunction != null && callbackFunction != undefined) {
	    		callbackFunction(data);  
	    	  } else {
	    	  
		    	  var jsonArr = data[0];
		    	  
		    	  if (jsonArr != [] && jsonArr.length > 0) {
		    		  
		    		  var topMenu = jsonArr[0];
		    		  
		    		  var callMenu = jsonArr[jsonArr.length-1];
		    		  
		    		  // LNB 동일
		    		  if (menu.topMenuInfo.menuNo != null && menu.topMenuInfo.menuNo != '' 
		    			  && menu.topMenuInfo.menuNo == topMenu.menuNo) {
		    			  
		    			  menu.menuSelect(callMenu);
		    			  
		    			  
		    			  menu.getLeftMenuHistory(callMenu.menuNo);
		    			  
		    			   
		    		  } 
		    		  // LNB 다름. GNB 이동후 LNB 호출하고 page view 처리
		    		  else {
		    			  
		    			  menu.init();
		    			  
		    			  menu.isFirstMenu = false;
		    			  
		    			  menu.topMenuInfo.menuNo = topMenu.menuNo;
		    			  
		    			  menu.callMenuInfo = callMenu;
		    			 
		    			  menu.setLeftMenu(topMenu.menuNo);
		    			  
		    		  }
		    		  
		    		  menu.go(callMenu.urlGubun, callMenu.urlPath);
		    	  }
		      } 
	      }
	    },
	    error: function(xhr) { 
	      console.log('FAIL : ', xhr);
	    }
   });
	
};


/** contents 페이지 이동 **/
menu.forward = function(url) {
	
	if (url == null || url == '') {
		//alert('3');
		//alert("죄송합니다. 서비스 준비중입니다.");
		return;
	}
	
	$.ajax({
	    url: _g_contextPath_ + "/cmm/system/getMenuListOfUrl.do",
	    dataType: 'jsonp',
	    data:{langCode:'kr', urlPath:url},
	    jsonpCallback: "myCallback",
	    success: function(data) { 
	    	//alert("contents 페이지 이동 : " + JSON.stringify(data));
	      //console.log('SUCESS : ', data);  
	      
	      if (data.length > 0) {  
	    	  
	    	  var jsonArr = data[0];
	    	  
	    	  if (jsonArr != [] && jsonArr.length > 0) {
	    		  
	    		  var topMenu = jsonArr[0];
	    		  
	    		  var callMenu = jsonArr[jsonArr.length-1];
	    		  
	    		  // LNB 동일
	    		  if (menu.topMenuInfo.menuNo != null && menu.topMenuInfo.menuNo != '' 
	    			  && menu.topMenuInfo.menuNo == topMenu.menuNo) {
	    			  
	    			  menu.menuSelect(callMenu);
	    			  
	    			  
	    			  menu.getLeftMenuHistory(callMenu.menuNo);
	    			  
	    			   
	    		  } 
	    		  // LNB 다름. GNB 이동후 LNB 호출하고 page view 처리
	    		  else {
	    			  
	    			  menu.init();
	    			  
	    			  menu.isFirstMenu = false;
	    			  
	    			  menu.topMenuInfo.menuNo = topMenu.menuNo;
	    			  
	    			  menu.callMenuInfo = callMenu;
	    			 
	    			  menu.setLeftMenu(topMenu.menuNo);
	    			  
	    		  }
	    		  
	    		  menu.go(callMenu.urlGubun, callMenu.urlPath);
	    	  }
	      } 
	    },
	    error: function(xhr) { 
	      console.log('FAIL : ', xhr);
	    }
   });
	
};


/** 페이지 이동후 kendo tree 메뉴에서 선택하기(버튼이 선택된 형태로 하기 위해) **/
menu.menuSelect = function(item) {
	
	var treeview = $("#sub_nav").data("kendoTreeView");
				 	
	/* treeview에서 select 처리하여 선택처리*/
	console.log("item.seq : " + item.menuNo);
		
	/* 전부 펼치기(펼치지 않으면 데이터를 못받아옴) */
	treeview.expand(".k-item");
			
	var dataItem = treeview.dataSource.get(item.menuNo);
	var node = treeview.findByUid(dataItem.uid);
	treeview.select(node);
	
	/* 메뉴히스토리 남기기 */
	//menu.getLeftMenuHistory(item.menuNo);
	menu.topMenuInfo.url = item.urlPath;
	menu.topMenuInfo.urlGubun = item.urlGubun;
	
	/* 선택된 메뉴를 제외한 나머지 닫기 */
	var parentNode = treeview.dataItem(treeview.parent(node));
	if (parentNode != null) {
		menu.menuClose(parentNode);
	}
	
};


/** 선택된 메뉴를 제왼 나머지 소분류 메뉴 닫기 **/
menu.menuClose = function(node) {
	
	var treeview = $("#sub_nav").data("kendoTreeView");
	var view = treeview.dataSource.view();
	
	var nodes = menu.getTreeChildNodes(view);	
	
	for(var i = 0; i < nodes.length; i++) {
		var n = nodes[i];
		if (n.seq != node.seq) {
			treeview.collapse(treeview.findByText(n.name));
		}
	}
	
}


/** iframe forward url **/
menu.go = function(urlGubun, url) {
	
	if (urlGubun != 'mail') {
		   //menu.getLeftMenuHistory(menu.callMenuInfo.menuNo);
	}
	
    if (urlGubun != null && urlGubun != '' && urlGubun != 'mail') {
		var params = "";
		if(url != null && url != '') {
			var len = url.indexOf("?");
			if (len > -1) {
				params = "&menu_no="+menu.callMenuInfo.menuNo;
			} else {
				params = "?menu_no="+menu.callMenuInfo.menuNo;
			}
		}
		$("#_content").attr("src","/"+urlGubun + url +params);
	}else {
		$("#_content").attr("src", url);
	} 
	
	
};  


menu.contentReload = function() {
	$("#_content").attr("src",$("#_content").attr("src"));
};  
 

/** 
 * LNB 2Depth메뉴 jquery로 가져오기
 * 
 * */
menu.setLeftMenu = function(no) {	
	
	$("#sub_nav_jstree").empty();
	

	$.ajax({
		type:"post",
		url: _g_contextPath_ + "/cmm/system/getMenu2Depth.do",
		data:{startWith : no}, 
		datatype:"json",			 
		success:function(data){	
			
			var items = "";	
			var menuNo = [];
			var menuType = "";
			if (data.depth2Menu) {
				
				$.each(data.depth2Menu,function (index,val){		
					items += "<div class='sub_2dep' id='"+index+'dep'+"'><span  class='"+val.expendClass+"'>"+val.name+"</span></div>";				
					
					if(index == 0) {
						firstMenu = val.menuNo ;
					}
					
					if((val.urlPath != "" || val.urlPath != null)  && val.childCount == 0 ){	
						menu.directMoveUrl = {urlGubun: val.urlGubun , url : val.urlPath , text : val.name };
						menu.directUrlId = val.menuNo;
						$(document).on('click',"#"+index+'dep',function () {
							fncDirectUrl();
						});
					}
					/* 특정 매뉴는 api를 호출하기때문에 예외처리(게시판 , 문서 , 프로젝트관리 , 웹팩스)*/
					if((val.menuNo == "901000000") || (val.childCount > 0) || (val.menuNo == "501000000") || (val.menuNo == "505000000") || (val.menuNo == "601000000") ) {
						items += "<div id='"+val.menuNo+"'class='sub_2dep_in'></div>";
					}
									
					menuNo[index] = val.menuNo ;
				});
												
				$("#sub_nav_jstree").html(items);
				
				
				//하위 Level 메뉴가 없는 Depth2 메뉴가 하나 일경우 
				if(menu.directMoveUrl != null ) {
					fncDirectUrl();
				}
				//각각 							
				for(var i = 0 ; i < menuNo.length; i++) {
					if(menuNo[i] == "2002000000") {
						menuType = "eaBox";
					}else if(menuNo[i] == "501000000") {
						menuType = "edms";
					}else if(menuNo[i] == "505000000") {
						menuType = "project";
					}else if(menuNo[i] == "601000000") {
						menuType = "doc";
					}else {	menuType = "";
					}
					menu.setMenuDepth(no,menuNo[i],menuType);
				}
			}
		} 
	});
		
};

function fncDirectUrl() {
	menu.go(menu.directMoveUrl.urlGubun, menu.directMoveUrl.url);
	menu.leftMenuList.push({name:menu.directMoveUrl.text, url:menu.directMoveUrl.url});
}

menu.setMenuDepth = function (rootMenuNo,upperMenuNo,menuType) {

	
	$('#'+upperMenuNo).jstree({
		'core' : {
			  'data' : {
			   'url' :  _g_contextPath_ + '/cmm/system/getJsTreeList.do',
		   	   'cache' : false,
			   'dataType': 'JSON',
			   'data' : function (node) {

				  menu.docParameters.dirRootNode = null;
				  if(node.id != "#") {
					   if(node.id == '602010000' || node.original.exceptGubun == 'eaCategory') {
						   // 문서 > 전자결재 > 카테고리별 문서관리 하위에 트리를 만들기 위해 예외처리
						   menuType = 'eaCategory';
					   }
					   
					   if(menu.docParameters.dirRootNode != 'undifined' || menu.docParameters.dirRootNode != null){
						   // 카테고리 분류 Root노드가 아닐경우 
						   menu.docParameters.dirRootNode = 'childeNodes';
					   }
				  }
			      return {'upperMenuNo' : (node.id == "#" ? upperMenuNo : node.id ) 
			    	  ,'level' : (node.id == "#" ? "1" : node.original.level )  
			    	  ,'firstDepthMenuNo' : rootMenuNo , 'menuType' :  menuType 
			    	  ,'dir_group_no' : (menu.docParameters.dirGroupNo == null ? 0 : menu.docParameters.dirGroupNo)/*뷴류선택  카테고리 그룹No 업무분류(0) 카테고리(그룹번*/
			    	  ,'dir_type' :( menu.docParameters.dirType == null ? "W" : menu.docParameters.dirType)/*뷴류선택 카테고리 Type 업무뷴류(W) 카테고리(C)*/
			    	  ,'dir_rootNode' : (menu.docParameters.dirRootNode == null ? "root" : menu.docParameters.dirRootNode)}/*Root 폴더를 만들기 위해 필요한 파라미터*/
			   }
			  }
			}})
			.bind("loaded.jstree", function(event, data) {
				//jsTree가 Load 될때 

				//탑 메뉴 호출시 첫번째 메뉴 선택
				if(firstMenu == upperMenuNo) {					
					//첫번째 Depth메뉴 펼치기
					var firstMenuDiv = $(".sub_2dep:first");
					//firstMenuDiv.addClass("active");
					firstMenuDiv.next(".sub_2dep_in").show();					
					// 첫번째 노드 select 
					$(this).jstree('select_node', 'ul > li:first');					
				}
				
				//문서 > 일반문서 예외처리 (별도 api 제공)
				if(upperMenuNo == '601000000' && $("#userSe").val() == 'USER'){
															
					//일반 문서 메뉴 일 경우 분류선택 Button
					menu.fnGetEdmsGroupContens();		
					var categoryListBox = "<a href='#n' onClick='' class='type_btn'>분류선택</a><div id='' class='type_list'>"+edmsCategoryList+"</div>"; 
					$('#'+upperMenuNo).append(categoryListBox);
					$('#rootClass').addClass('select_item');

					//모두 펼치기 
					$("#"+upperMenuNo).jstree("open_all");	
				}	
			})
			.bind("select_node.jstree", function(event, data) {	
				menu.onSelect(data);	
				menu.getLeftMenuHistory(data);				
			})
			.bind("refresh.jstree", function(event, data) { 
				//refresh 하면 분류선택 버튼이 없어지기 떄문에 function다시 호출하여 버튼 생성
				if(upperMenuNo == '601000000'){					
					//일반 문서 메뉴 일 경우 분류선택 Button
					menu.fnGetEdmsGroupContens();
					var categoryListBox = "<a href='#n' class='type_btn'>분류선택</a><div id='' class='type_list'>"+edmsCategoryList+"</div>"; 
					$('#'+upperMenuNo).append(categoryListBox);
					$('#rootClass').removeClass('select_item');

					$("#"+upperMenuNo).jstree("open_all");	
				}
			});
};

menu.fnGetEdmsGroupContens = function() {
	$.ajax({
		type:"post",
		async: false,
		url: _g_contextPath_ + "/cmm/system/getEdmsContetnsGroup.do",
		datatype:"json",			 
		success:function(data){
			var html = "";
			html += "<ul><li  id='rootClass' class=''><a href='#n' onclick=\"fnSelectCategory(\'601000000\',\'0\',\'W\')\";>업무분류</a></li>";
			if(data != null){
				$.each(data,function (idx,val){
					var selectClass = "";
					if(menu.docParameters.dirGroupNo == val.dir_group_no){
						selectClass = "select_item";
					}
					html += "<li class='"+selectClass+"'><a href='#n' onclick=\"fnSelectCategory(\'601000000\',\'"+val.dir_group_no+"\',\'C\')\";>"+val.dir_group_nm+"</a></li>";
				});
			}
			html += "</ul>";
			edmsCategoryList = html ;

		},error:function(xhr) {
			console.log("FAIL",xhr);
		}
	});

};

function fnSelectCategory(jstree,parameter,type) {
	menu.docParameters.dirGroupNo = parameter;
	menu.docParameters.dirType = type;
	$('#'+jstree).jstree(true).refresh();
}


/** treeview에서 현재 위치한 메뉴 재클릭시 
 * 이벤트 실행이 안되어(페이지 리로드) 일반 이벤트 등록으로 처리
 *  
*/
menu.onclickLnb = function(e) {
	
	
	var tv = $("#sub_nav").data("kendoTreeView");
					
	var selectedNode = tv.select();
					
	var item = tv.dataItem(selectedNode);

	if (item != null && item != 'undifind') {
		var urlPath = item.urlPath;
		
		if (urlPath != null && urlPath != '') {
			var iframeUrl = $("#_content").attr("src");
			if (iframeUrl.indexOf(urlPath) > 0) {
				menu.contentReload();
			}
		}
	}
	
}


/** 왼쪽 메뉴명 이미지 설정 **/
menu.setSideWrapClass = function(data) {
	
	var jsonArr = data[0];
	if (jsonArr[0] != null) {
		var className = jsonArr[0].menuImgClass;
 		$(".side_wrap").attr("class", "side_wrap " + className + " k-pane k-scrollable");
	}
	
}


/** 사용자 이미지 업로드 **/
menu.userImgUpload = function(data, className) {
	
	$.ajax({ 
        type: "POST",
        url: "cmm/file/profileUploadProc.do",  
        //enctype: 'multipart/form-data', 
        processData: false,
	    contentType: false,
        data: data, 
        success: function (e) {  
           var fileId = e.fileId;
		   if (fileId != null && fileId != '') {
			   var data = {picFileId : fileId};
			   menu.userImgUpdate(data);
			   $("."+className).attr("src", "cmm/file/fileDownloadProc.do?fileId="+fileId+"&fileSn=0");
			   
			   setTimeout('menu.reloadUserInfoIframe()',500);
			    
		   }  
        },  
        error:function (e) { 
        	console.log(e); 
        }
	});
	
};


/** 사용자 이미지 변경시 iframe 페이지는 리로드 **/
menu.reloadUserInfoIframe = function() {
	
	 $("#iframeUserInfo").attr("src",$("#iframeUserInfo").attr("src"));
	 
};


/** 겸직 변경하기 */
menu.changePosition = function(seq) {
	
	$.ajax({ 
        type: "POST", 
        url: "systemx/changeUserPositionProc.do", 
        data: {seq : seq}, 
        success: function (e) {  
         if (e.result == 1) {
        	 location.href = 'userMain.do';
         } 
        },  
        error:function (e) {   
        	console.log(e); 
        } 
	});
	
};
 

/** 사용자 이미지 DB 업데이트 **/ 
menu.userImgUpdate = function(data) {
	
	 $.ajax({ 
        type: "POST",
        url: "cmm/systemx/userPicUpdateProc.do", 
        data: data, 
        success: function (e) {  
          //console.log(e);
        },  
        error:function (e) { 
        	console.log(e);
        } 
    });
  
}; 


/** 나의메뉴설정 조회 **/
menu.myMenu = function() {
	
	 $.ajax({ 
        type: "POST",
        url: "myMenu.do", 
        success: function (e) {  
          console.log(e);
          
          $("#myMenu").html(e);
          
          
        },  
        error:function (e) { 
        	console.log(e);
        } 
    });
  
};


/** 하위 자식 노드 가져오기 **/
menu.getTreeChildNodes = function (nodes) {
	
	var node, childNodes;
    var _nodes = [];

    for (var i = 0; i < nodes.length; i++) {
		node = nodes[i];
		_nodes.push(node);
		
		if (node.hasChildren) {
			childNodes = menu.getTreeChildNodes(node.items);
			
			if (childNodes.length > 0){
				_nodes = _nodes.concat(childNodes);
			} 
		} 
	}

    return _nodes;

};

/** 왼쪽 메뉴 히스토리  **/
menu.getLeftMenuHistory = function(data) {
	

	var lastNode = data.node;
	var Depth2MenuName = "";
	
	if(lastNode != null) {

		var len = lastNode.parents.length;
		
		if(lastNode.parent != '#'){
			Depth2MenuName  = $("#"+lastNode.parents[len-2]).parent().parent().prev().find('span').text();
		}else {
			Depth2MenuName  = $("#"+lastNode.id).parent().parent().prev().find('span').text();
		}		
		
		menu.leftMenuList = [];		
		menu.leftMenuList.push({name:lastNode.text, url:lastNode.original.urlPath});
		
		
		//console.log(lastNode);
		
		if(lastNode.parent != '#') {
			while(true) {
				
			try {

				var parentId = lastNode.parent;
			    var jtreeNodesId = $('#'+parentId).closest('div').attr("id");
			    var node = $("#"+jtreeNodesId).jstree(true).get_node(parentId);		    
			    var menuClass = node.menuClass;
				
				//console.log("menuClass : " + menuClass);
				
				if (menuClass != null && menuClass != '' && menuClass != 'null') {
					$(".side_wrap").attr("class", "side_wrap " + menuClass);
				}
			  				
			    //console.log(node);
			    menu.leftMenuList.push({name:node.text, url:node.original.urlPath});
			    		    
			    if(node.parent != '#') {
			    	lastNode = node ;
			    	continue;
				}else {
					break;
				}
			}catch(exception) {
					break;
				} 
			}
			  
		}

		//Depth 레벨이 2Lv 일 경우 상위노드를 찾아 넣어준다.
		menu.leftMenuList.push({name:Depth2MenuName, url:''});
		
	}
};
	

/** 왼쪽 메뉴 선택 **/
menu.onSelect = function(e) {
	
	var item = e.node.original;
	var url = item.urlPath;
	var urlGubun = item.urlGubun;
	var exceptGubun = item.exceptGubun;
	var seq = item.id;
				
	menu.callMenuInfo = {menuNo:seq, urlGugun:urlGubun, urlPath:url};

	// 수정본
	if (url != null && url != '') {
		/* iframe에 출력 */
		// 보안관리 솔루션 예외처리
		if(seq == "993010000") {
			window.open(url, '보안관리솔루션');
			menu.go("gw", "/cmm/cmmPage/CmmPageView.do?menuNm=" + menu.topMenuInfo.name);
		} else {
			menu.go(urlGubun, url);
		}
	}else if( (exceptGubun == 'edms' || exceptGubun == 'eaCategory' || exceptGubun == 'doc') && url == '') {
		//게시판 형식이 폴더 형식일때 페이지 이동 차단
		return;
	}else {
			//alert('6');
			if(pageFlag){
				$("#_content").attr("src", "/gw/cmm/cmmPage/CmmPageView.do?menuNm=" + menu.topMenuInfo.name);
				//pageFlag = false;
			} else {
				return;
			}
			//alert("죄송합니다. 서비스 준비중입니다.");
	}	
	
	//$(".k-in").removeClass('k-state-selected');
	
};


/** 알림 팝업(div) 숨기기 **/
menu.hideGbnPopup = function(popType) {
	
	var profile_box = $(".profile_box").css("display");
	if (profile_box == 'block' && popType != 1) {
		$(".profile_box").css("display", "none");
	}
	
	var alert_box = $(".alert_box").css("display");
	if (alert_box == 'block' && popType != 2) {
		$(".alert_box").css("display", "none");
	}
	
	var mymenu_box = $(".mymenu_box").css("display");
	if (mymenu_box == 'block' && popType != 3) {
		$(".mymenu_box").css("display", "none");
	}
	
};

//문서 : 분류선택 클릭 Live 이벤트
$(document).on('click','.type_btn',function(){
	if($(".type_list").css("display") == "none"){
		$(".type_list").show();								
	}else{
		$(".type_list").hide();	
	}
});

//클릭메뉴 초기화
$(document).on("click",".jstree-anchor",function(){
    var This = $(this);
    $(".jstree-anchor").removeClass("jstree-clicked");
    This.addClass("jstree-clicked");
});
