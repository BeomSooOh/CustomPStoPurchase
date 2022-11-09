    var mobile = {}; 
    //if(domain.equals("m.branksome.asia")){

    mobile.init =function(){
        if(mobile.domain == "m.branksome.asia"){
            $(".ui-bar-b").css("background", "#006224");
            $(".ui-bar-b").css("border-color" ,"#02451b");
            $(".ui-btn-up-b").css("border-color" ,"#032b12");
            $(".ui-btn-up-b").css("background" ,"#005030");
            $(".ui-btn-up-b").css("text-shadow-color" ,"#255037");
            $(".ui-btn-hover").css("background" ,"#447440");
            $(".ui-btn-hover").css("border-color" ,"#02451b");
            $(".ui-btn-down-b").css("border-color" ,"#1C2B22");
            $(".ui-btn-down-b").css("background" ,"#447440");
            $(".ui-btn-down-b").css("text-shadow-color" ,"#255037");
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#2C2B6E");
            $(".ui-btn-up-a").css("color" ,"#fff");
        }else if(mobile.domain == "m.nlcsjeju.kr"){
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#70481C");
            $(".ui-btn-up-a").css("color" ,"#fff");
        }/*else if(mobile.domain == "10.102.60.141"){
            $(".ui-bar-b").css("background", "#006224");
            $(".ui-bar-b").css("border-color" ,"#02451b");
            $(".ui-btn-up-b").css("border-color" ,"#032b12");
            $(".ui-btn-up-b").css("background" ,"#005030");
            $(".ui-btn-up-b").css("text-shadow-color" ,"#255037");
            $(".ui-btn-hover").css("background" ,"#447440");
            $(".ui-btn-hover").css("border-color" ,"#02451b");
            $(".ui-btn-down-b").css("border-color" ,"#1C2B22");
            $(".ui-btn-down-b").css("background" ,"#447440");
            $(".ui-btn-down-b").css("text-shadow-color" ,"#255037");
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#2C2B6E");
            $(".ui-btn-up-a").css("color" ,"#fff");
        }*/
    };
    
    mobile.main =function(){
        if(mobile.domain == "m.branksome.asia"){
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#2C2B6E");
            $(".ui-btn-up-a").css("color" ,"#fff");
        }else if(mobile.domain == "m.nlcsjeju.kr"){
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#70481C");
            $(".ui-btn-up-a").css("color" ,"#fff");
        }/*else if(mobile.domain == "10.102.60.141"){
            $(".ui-btn-up-a").css("border-color" ,"#032b12");
            $(".ui-btn-up-a").css("background" ,"#2C2B6E");
            $(".ui-btn-up-a").css("color" ,"#fff");
            //$(".ui-btn-down-b a.ui-link-inherit").css("color" ,"#fff");
        }*/
    };
    
    mobile.login = function(){
        if(mobile.domain == "m.branksome.asia"){
            $("#loginbody").css("background-color" ,"#2C2B6E");
            $("#loginbody").css("border-color" ,"#2C2B6E");
        }else if(mobile.domain == "m.nlcsjeju.kr"){
            $("#loginbody").css("background-color" ,"#70481C");
            $("#loginbody").css("border-color" ,"#70481C");
        }else if(mobile.domain == "m.haewul.com"){
            $("#loginbody").css("background-color" ,"#1368AA");
            $("#loginbody").css("border-color" ,"#1368AA");
        }/*else if(mobile.domain == "10.102.60.141"){
            $("#loginbody").css("background-color" ,"#2C2B6E");
            //$(".ui-btn-down-b a.ui-link-inherit").css("color" ,"#fff");
        }*/
    };
    
    mobile.main = function(arg1, arg2, arg3) {
  		switch (arg1) {
  			case 'V' : //결재화면 상세보기
  				document.location.href = _g_contextPath_ + "/edoc/eapproval/docCommonDraftView.do?diKeyCode="+arg2 ; 
  				$.mobile.hidePageLoadingMsg();
  				break;
  			case 'Q' : //결재리스트
  				frmMain.action = _g_contextPath_ + "/mobileweb/edoc/docApprovalCnt.do" ;
  				frmMain.submit();
  				$.mobile.hidePageLoadingMsg();
  				break;
  			case 'QP': //겸직정보
  				frmMain.action = _g_contextPath_ +  "/mobileweb/edoc/memberPositionList.do" ;
  				frmMain.submit();
  				$.mobile.hidePageLoadingMsg();
  				break;
  			case 'LO' : //로그아웃 
  				frmMain.action = _g_contextPath_ +  "/uat/uia/actionLogout.do";
  				frmMain.submit();
  				break;  			
  			case 'B' ://뒤로
  				history.back(); 
  				break;
  			case 'H' : //홉으로
  				var url =  _g_contextPath_ +  "/NeosMain.do";
  				document.location.href = url ;  	
  				break;
  			case 'CP': //부서변경
	  			var url = _g_contextPath_ +  "/NeosMoveDept.do?id="+arg2+"&orgnztId="+arg3 ;
	  			location.href = url ;	
  				break;
  		}
  	};
	