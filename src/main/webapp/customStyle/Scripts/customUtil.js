var commonCodeSelectInfo = {};

function commonCodeSelectPop(group, codeName, appendType, targetEl, multiYn, ){
	
	commonCodeSelectInfo.group = group;
	commonCodeSelectInfo.codeName = codeName;
	commonCodeSelectInfo.appendType = appendType;
	commonCodeSelectInfo.targetEl = targetEl;
	commonCodeSelectInfo.multiYn = multiYn;
	
	openWindow2("/CustomPStoPurchase/purchase/pop/CodeSelectPop.do?multiYn=" + multiYn + "&group=" + group,  "commonCodeSelectPop", 370, 450, 1, 1) ;
}

function chkChar(obj){
    var RegExp = /[\{\}\[\]\/?;:|\*`!^\_+┼<>@\#$%&\'\"\\\\=]/gi;	//정규식 구문
    if (RegExp.test(obj.value)) {
      // 특수문자 모두 제거    
      obj.value = obj.value.replace(RegExp , '');
    }
    
}

function getUUID() {
	  return 'xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
	    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 3 | 8);
	    return v.toString(16);
	  });
}

function viewKorean(val){
    var numKor = new Array("", "일", "이", "삼", "사","오","육","칠","팔","구","십");                                  // 숫자 문자
    var danKor = new Array("", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천");    // 만위 문자열
    var result = "";
    
    if(val && !isNaN(val)){
        // CASE: 금액이 공란/NULL/문자가 포함된 경우가 아닌 경우에만 처리
        
        for(var i = 0; i < val.length; i++) {
            var str = "";
            var num = numKor[val.charAt(val.length - (i+1))];
            if(num != "")   str += num + danKor[i];    // 숫자가 0인 경우 텍스트를 표현하지 않음
            switch(i){
                case 4:str += "만";break;     // 4자리인 경우 '만'을 붙여줌 ex) 10000 -> 일만
                case 8:str += "억";break;     // 8자리인 경우 '억'을 붙여줌 ex) 100000000 -> 일억
                case 12:str += "조";break;    // 12자리인 경우 '조'를 붙여줌 ex) 1000000000000 -> 일조
            }

            result = str + result;
        }
        
        // Step. 불필요 단위 제거
        if(result.indexOf("억만") > 0)    result = result.replace("억만", "억");
        if(result.indexOf("조만") > 0)    result = result.replace("조만", "조");
        if(result.indexOf("조억") > 0)    result = result.replace("조억", "조");
        
        if(result != ""){
			result = "(금" + result + "원)";
		}
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



function checkVal(type, elementFor, objName, func, subValueFor, valOption){
	
	var returnVal = "";
	var focusTarget;
	var isNtHp = false;
	
	
	if(type == "text" || type == "select"){
		returnVal = $(elementFor).val();
		
		if(subValueFor == "parseToInt"){
			returnVal = returnVal.replace(/,/g, "")
		}else if(subValueFor == "|etc|" && $(elementFor).val() == "etc"){
			
			var subValueForValue = $("[name='"+$(elementFor).attr("name")+ "_etc']").val();
			
			if(subValueForValue == ""){
				
				$("[name='"+$(elementFor).attr("name")+ "_etc']").focus();
				returnVal = "";
				
			}else{
				returnVal += "▦" + subValueForValue;	
			}	
					
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
		
		$.each($("[name='"+elementFor+"'] tr[name='addData']"), function( key, objInfo ) {
			
			var values = "";
			
			$.each($(objInfo).find("[name=tableVal]"), function( key, tableVal ) {
				
				console.log($(tableVal).attr("requiredNot"));
				
				if($(tableVal).val() == "" && eval($(tableVal).attr("requiredNot")) == true){
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
		
	}else if(type == "obj"){
		
		returnVal = [];
		var breakYn = false;
		
		$.each($("[name='"+elementFor+"'] tr[name='addData']"), function( key, objInfo ) {
			
			var obj = {};
			
			$.each($(objInfo).find("[tbval=Y]"), function( key, tableVal ) {
				
				var tableValThis = "";
				
				if($(tableVal).attr("tbType") == "innerText"){
					tableValThis = $(tableVal).text();
				}else if($(tableVal).attr("tbType") == "ul"){
					
					$.each($(tableVal).find("[name='addData']"), function( key, objInfo ) {
						var values = $(objInfo).attr("addcode") + "▦" + $(objInfo).find('[name="addName"]').text();
						tableValThis += (tableValThis == "" ? "" : "▦▦") + values;	
						
					});					
				}else if($(tableVal).attr("tbType") == "file"){
					
					$.each($(tableVal).find("[name='addFile']"), function( key, objInfo ) {
						var values = $(objInfo).find('[name="attachFileName"]').attr("fileid") +
						"▦" + $(objInfo).find('[name="attachFileName"]').text() + "▦" + $(objInfo).find('[name="attachExtName"]').text();
						tableValThis += (tableValThis == "" ? "" : "▦▦") + values;	
						
					});						
				}else{
					tableValThis = $(tableVal).val();
				}
				
				if(eval($(tableVal).attr("requiredNot")) != true && tableValThis == ""){
					console.log("obj필수값 누락 > " + $(tableVal).attr("name"));
					
					if($(tableVal).attr("tbname")){
						objName += " > " + $(tableVal).attr("tbname");
					}
					
					focusTarget = tableVal;
					obj = {};
					breakYn = true;
					return false;
				}
				
				if($(tableVal).attr("amountInput") == "Y"){
					obj[$(tableVal).attr("name")] = tableValThis.replace(/,/g, '');
				}else{
					obj[$(tableVal).attr("name")] = tableValThis;	
				}
				
			});
			
			if(breakYn){
				returnVal = [];
				return false;
			}
			
			returnVal.push(obj);
			
		});	
		
	}else if(type == "ul"){
	
		$.each($("[name='"+elementFor+"'] [name='addData']"), function( key, objInfo ) {
			
			var values = $(objInfo).attr("addcode") + "▦" + $(objInfo).find('[name="addName"]').text();
			
			returnVal += (returnVal == "" ? "" : "▦▦") + values;
			
		});	
		
	}else if(type == "file"){
		
		$.each($("[name='hopeCompanyList'] [name='addData']"), function( key, objInfo ) {
			
			var chkCom = $(objInfo).attr("addcode");
			
			if (chkCom == "00" && isNtHp == false) {
				isNtHp = true;
			}
		});
		
		if (!isNtHp) {
			$.each($("[name='"+elementFor+"'] [name='addFile']"), function( key, objInfo ) {
				
				var values = $(objInfo).find('[name="attachFileName"]').attr("fileid") +
				"▦" + $(objInfo).find('[name="attachFileName"]').text() + "▦" + $(objInfo).find('[name="attachExtName"]').text();
				
				returnVal += (returnVal == "" ? "" : "▦▦") + values;	
				
			});
		}
		
	}else if(type == "innerText"){
		returnVal = $(elementFor).text();
	}
	
/*	if (chkCom == "00" && type == "file"){
		
		returnVal = "테스트"
		
		
	} else {*/
	
	if(returnVal == "" && !isNtHp ){
		
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
			}else if(type == "table" || type == "obj"){
				$(focusTarget).focus();
			}			
		}
						
	}else if(valOption != null){
		
		//(일)원단위 입력제한체크
		if(valOption == "notWon" && returnVal.slice(-1) != "0"){
			
			console.log("(일)원단위 입력불가 objName > " + objName);
			returnVal = "$failAlert$";
			msgSnackbar("error", "(일)원단위 입력이 불가합니다.");
			$(elementFor).focus();
			
		}
		
	} 
	
	return returnVal;
	/*}*/
}		


function selectDate(e){
	
	return true;
}


function fncGetFileClassImg(fileEx){
   	
	var fileClass;
	
   	if(fileEx.indexOf('.') != -1){    	
   		
   		fileEx = fileEx.split('.')[fileEx.split('.').length-1];
   		
        //확장자정규식
        var expBmp = /bmp/i;
        var expCsv = /csv/i;
        var expGif = /gif|gifx/i;
        var expHwp = /hwp/i;
        var expJpg = /jpg|jpeg/i;
        var expPdf = /pdf/i;
        var expPng = /png/i;
        var expTif = /tif/i;
        var expWord = /word|doc|docx/i;
        var expXls = /xls|xlsx/i;
        var expZip = /zip/i;
        var expPpt = /ppt|pptx/i;
        var expTxt = /txt/i;

        if (expBmp.test(fileEx)) {
            fileClass = "ico_bmp";
        } else if (expCsv.test(fileEx)) {
            fileClass = "ico_csv";
        } else if (expGif.test(fileEx)) {
            fileClass = "ico_gif";
        } else if (expHwp.test(fileEx)) {
            fileClass = "ico_hwp";
        } else if (expJpg.test(fileEx)) {
            fileClass = "ico_jpg";
        } else if (expPdf.test(fileEx)) {
            fileClass = "ico_pdf";
        } else if (expPng.test(fileEx)) {
            fileClass = "ico_png";
        } else if (expTif.test(fileEx)) {
            fileClass = "ico_tif";
        } else if (expWord.test(fileEx)) {
            fileClass = "ico_word";
        } else if (expXls.test(fileEx)) {
            fileClass = "ico_xls";
        } else if (expZip.test(fileEx)) {
            fileClass = "ico_zip";
        } else if (expPpt.test(fileEx)) {
            fileClass = "ico_ppt";
        } else if (expTxt.test(fileEx)) {
            fileClass = "ico_txt";
        } else {
            fileClass = "ico_etc";
        }   		
   		
   	}
   	else{
   		fileClass = "ico_etc";
   	}

   return "/customStyle/Images/ico/" + fileClass + ".png";
    
}
