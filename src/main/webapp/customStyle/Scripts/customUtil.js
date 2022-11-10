
function viewKorean(num) { 
    var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십"); 
    var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천"); 
    var result = ""; 
    for(i=0; i<num.length; i++) { 
        str = ""; 
        han = hanA[num.charAt(num.length-(i+1))]; 
        if(han != "") str += han+danA[i]; 
        if(i == 4) str += "만"; 
        if(i == 8) str += "억"; 
        if(i == 12) str += "조"; 
        result = str + result; 
    } 
    
    if(num.length > 1){
    	result = (result.charAt(0) == "일" ? "일" : "") + result.replaceAll("일","") + (result.charAt(result.length-1) == "일" ? "일" : "");
    }
    
    if(result != ""){
    	result = "(금" + result + "원)";
    }
    
    return result ; 
}


function confirmAlert(width, height, type, content, confirmBtnName, confirmBtnCallback, cancelBtnName, cancelBtnCallback){
	
	var puddDialog = Pudd.puddDialog({
	 
			width : width
		,	height : height
	 
		,	message : {
	 
				type : type
			,	content : content
			}
		,	footer : {
		
				// puddDialog message 에서 제공되는 버튼 사용하지 않고 별도로 진행할 경우
				buttons : [
					{
						attributes : {}// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
					,	value : confirmBtnName
					,	clickCallback : function( puddDlg ) {
							
							if(confirmBtnCallback != ""){
								eval(confirmBtnCallback);	
							}
							
							puddDlg.showDialog( false );
						}
						// dialog 생성시에 확인 버튼으로 기본 포커스 설정
					,	defaultFocus :  true// 기본값 true
					}
				,	{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
					,	value : cancelBtnName
					,	clickCallback : function( puddDlg ) {
		
							if(cancelBtnCallback != ""){
								eval(cancelBtnCallback);	
							}
							
							puddDlg.showDialog( false );
						}
					}
				]
			}
	});	
	
}		


function msgAlert(type, content, callback){
	var puddDialog = Pudd.puddDialog({
		 
		width : 350
	,	height : 100
 
	,	message : {
			type : type
		,	content : content
		}
	
	,	defaultClickCallback : function( puddDlg ) {
		
			if(callback != ""){
				eval(callback);
			}
		
			puddDlg.showDialog( false );	
		}
	});			
}

