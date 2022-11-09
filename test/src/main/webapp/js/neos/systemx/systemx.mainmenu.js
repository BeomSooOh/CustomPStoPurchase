mainmenu = {};

/* top 메뉴 클릭 */
mainmenu.clickTopBtn = function(no, name, url) {
	$("#no").val(no);
	$("#name").val(name);
	$("#nurl").val(url);
	form.submit();
	
};

