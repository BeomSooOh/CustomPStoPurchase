function message(lang, type, msg) {
	if (lang == 'kr') {
		
	}else if (lang == 'en') {
	}
}

function menuName(lang, type) {
	var menuName =  "";
	if (lang == 'kr') {
		return menuNameKr(type) ; 
	}else if (lang == 'en') {
		return menuNameEn(type) ;
	}
}

function menuNameEn(type) {
	var menuName = "" ;
	switch(type) {
		case '00001' :
			menuName = "E-approval" ;
			break ;
		case '00002' :
			menuName = "Pending Documents" ;
			break ;		
		case '00003' :
			menuName = "In Tray box List" ;
			break ;
//		case '00004' :
//			menuName = "In Tray box";
//			break;
		case '00004' :
			menuName = "a written report box List" ;
			break;
		case '00005' :
			menuName = "Submitted" ;			
			break ;	
		case '00006' :
			menuName = "결재예정 리스트" ;			
			break ; 			
		case '00007' :
			menuName = "결재예정함" ;			
			break ; 			
		case '00008' :
			menuName = "Approved List" ;			
			break ; 			
		case '00009' :
			menuName = "Approved" ;			
			break ; 			
		case '00010' :
			menuName = "Return box List" ;			
			break ; 			
		case '00011' :
			menuName = "Return box" ;			
			break ; 			
		case '00012' :
			menuName = "Operate List" ;			
			break ; 			
		case '00013' :
			menuName = "Action" ;			
			break ; 			
		case '00014' :
			menuName = "Approval" ;			
			break ; 			
		case '00015' :
			menuName = "Pending" ;			
			break ; 			
		case '00016' :
			menuName = "Return" ;			
			break ; 	
		case '00017' :
			menuName = "Particular question or comment" ;			
			break ; 				
		case '00018' :
			menuName = "Reference file" ;			
			break ; 				
		case '00019' :
			menuName = "Attached file" ;			
			break ; 				
 				
 			
	}
	return menuName ;
}

function menuNameKr(type) {
	var menuName = "" ;
	switch(type) {
		case '00001' :
			menuName = "전자결재" ;
			break ;
		case '00002' :
			menuName = "전자결재" ;
			break ;			
	}
	return menuName ;
}