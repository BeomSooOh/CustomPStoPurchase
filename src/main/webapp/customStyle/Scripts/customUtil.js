
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
    	result = "(" + result + "원)";
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

function msgSnackbar(type, msg, callback){
	Pudd.puddSnackBar({
		 
		type	: type		// success, error, warning, info
	,	message : msg
	,	duration : 3000			// 1초 = 1000
		// snackbar show 완료 후 callback
	,	showDoneCallback : function() {
			if(callback != ""){
				eval(callback);
			}
		}
	});			
}


function checkVal(type, elementFor, objName, func, subValueFor){
	
	var returnVal = "";
	var focusTarget;
	
	if(type == "text" || type == "select"){
		returnVal = $(elementFor).val();
		
		if(subValueFor == "parseToInt"){
			returnVal = returnVal.replace(/,/g, "")
		}
		
	}else if(type == "radio"){
		returnVal = $("[name='"+elementFor+"']:checked").val();
		
		if(subValueFor.indexOf(returnVal) > -1){
			
			var subValueForValue = $("input[name='"+elementFor+ "_" + returnVal +"']").val();
			
			if(subValueForValue == ""){
				
				console.log("필수값 누락 objName > " + objName + " > " + returnVal);
				
				msgSnackbar("error", "필수항목 ("+objName+") 을 입력해 주세요.")
				
				$("[name='"+elementFor+ "_" + returnVal +"']").focus();
				
				return "$failAlert$";
				
			}else{
				returnVal += "▦" + subValueForValue;	
			}					
			
		}				
		
	}else if(type == "date"){
		returnVal = $("[name='"+elementFor+"']").val();
	}else if(type == "checkbox"){
		
		if(func == "checkYn"){
			returnVal = $(elementFor).attr("checked") == "checked" ? "Y" : "N";
		}else{
			
			var statusVal = false;
			
			$.each($("[name='"+elementFor+"']:checked"), function( key, objInfo ) {
				
				returnVal += (returnVal == "" ? "" : "▦▦") + $(objInfo).val();
				
				if(subValueFor.indexOf($(objInfo).val()) > -1){
					
					var subValueForValue = $("[name='"+elementFor+ "_" + $(objInfo).val() +"']").val();
					
					if(subValueForValue == ""){
						
						console.log("필수값 누락 objName > " + objName + " > " + $(objInfo).val());
						
						msgSnackbar("error", "필수항목 ("+objName+") 을 입력해 주세요.")
						
						$("[name='"+elementFor+ "_" + $(objInfo).val() +"']").focus();
						
						statusVal = true;
						return false;
						
					}else{
						returnVal += "▦" + subValueForValue;	
					}
					
				}
				
			});
			
			if(statusVal){
				return "$failAlert$";
			}
			
		}
		
	}else if(type == "table"){
		
		var breakYn = false;
		
		$.each($("[name='"+elementFor+"'] [name='addData']"), function( key, objInfo ) {
			
			var values = "";
			
			$.each($(objInfo).find("[name=tableVal]"), function( key, tableVal ) {
				
				console.log($(tableVal).attr("requiredNot"));
				
				if($(tableVal).attr("requiredNot") == "true"){
					$(tableVal).val(" ");
				}
				
				if($(tableVal).val() != ""){
					values += (values == "" ? "" : "▦") + $(tableVal).val();
				}else{
					
					focusTarget = tableVal;
					
					if(subValueFor == "notnull"){
						returnVal = "";	
						breakYn = true;					
					}
					
					values = "";
					return false;
				}
				
			});
			
			if(breakYn){
				return false;
			}
			
			if(values != ""){
				returnVal += (returnVal == "" ? "" : "▦▦") + values;	
			}
			
		});	
		
	}
	
	if(returnVal == ""){
		
		if(func != "mustAlert" && !eval(func)){
			func = "";
		}				
		
		if(func != ""){
			
			if(func != "mustAlert" && !eval(func)){
				func = "";
			}
			
			console.log("필수값 누락 objName > " + objName);
			returnVal = "$failAlert$";
			msgSnackbar("error", "필수항목 ("+objName+") 을 입력해 주세요.")
			
			if(type == "text"){
				$(elementFor).focus();
			}else if(type == "table"){
				
				$(focusTarget).focus();
				
			}			
		}				
	}
	
	return returnVal;
}		


function selectDate(e){
	
	return true;
}

