var main = {};


$(function(){
	
});

  
 


main.userLogout = function() {
	location.href = "uat/uia/actionLogout.do";
};


//기안작성 팝업 eaType => eap :  영리, ea : 비영리
main.fnEaFormPop = function(eaType) {

	// 디폴트 eap
	if(!eaType){
		eaType = "eap";
	}
	
	var kendoWin = $("#formWindow");
	var url = "/" + eaType + "/FormListPop.do";
	
	kendoWin.kendoWindow({
		iframe: true ,
		draggable: false,
		width : "400px",
		height: "500px",
		title : "양식함",
		visible : false,
		content : {
			url : url,
			type : "GET",
		},
		actions: [
	          "Minimize",
	          "Close",
	          "Refresh"
		          ]
	}).data("kendoWindow").center().open();
//	kendoWin.data("kendoWindow").refresh();
};

//기안작성 팝업 close 
main.fnEaFormClose = function()
{
   $("#formWindow").data("kendoWindow").close();
};