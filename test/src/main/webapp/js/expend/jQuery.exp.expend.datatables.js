/*datatable 참고 site >> http://legacy.datatables.net/ref */

/* commonTableInfoDef : Datatables 기초 데이터 */
var commonTableInfoDef = {
	columnDefs : {
		list : [],
		slip : [],
		mng : [],
		summary : [],
		auth : [],
		project : [],
		partner : [],
		card : [],
		car : []
	},
	columns : {
		list : [],
		slip : [],
		mng : [],
		summary : [ {
			"sTitle" : "코드",
			"mData" : "summaryCode",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "명칭",
			"mData" : "summaryName",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		} ],
		auth : [ {
			"sTitle" : "코드",
			"mData" : "authCode",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "명칭",
			"mData" : "authName",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		} ],
		project : [],
		partner : [],
		card : [],
		car : []
	},
	page : {},
	language : {
		lengthMenu : "보기 _MENU_",
		zeroRecords : "데이터가 없습니다.",
		info : "_PAGE_ / _PAGES_",
		infoEmpty : "데이터가 없습니다.",
		infoFiltered : "(전체 _MAX_ 중.)"
	}
};

/* setTable : Datatables 설정 */
var setTable = function(target, type, aaData, count) {

	log('+ [FNC] setTable(' + type + ', ' + (JSON.stringify(aaData) || '') + ')');

	if (typeof type === "undefined") {
		return;
	}
	if (typeof aaData === "undefined") {
		return;
	}

	target.dataTable({
		select : true,
		bAutoWidth : false,
		destroy : true,
		lengthMenu : [ [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, -1 ], [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, "All" ] ],
		language : getTableDef('language'),
		data : aaData,
		columnDefs : getTableDef('columnDefs', type),
		aoColumns : getTableDef('columns', type)
	});

	$('select[name=tblExpendUserReport_length]').val(count || 5);
	$('select[name=tblExpendUserReport_length]').trigger('change');

	log('- [FNC] setTable(' + type + ', ' + (JSON.stringify(aaData) || '') + ')');
};

var setTableCust = function(target, columnDefs, columns, aaData, count) {

	log('+ [FNC] setTableCust(' + (JSON.stringify(aaData) || '') + ')');

	if (typeof columnDefs === "undefined") {
		return;
	}
	if (typeof columns === "undefined") {
		return;
	}
	if (typeof aaData === "undefined") {
		return;
	}

	target.dataTable({
		select : true,
		bAutoWidth : false,
		destroy : true,
		lengthMenu : [ [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, -1 ], [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, "All" ] ],
		language : getTableDef('language'),
		data : aaData,
		columnDefs : columnDefs || [],
		aoColumns : columns || '',
		bSort : false,
		paging : true 
	});

	$('select[name=' + $(target).attr("id") + '_length]').val(count || 5);
	$('select[name=' + $(target).attr("id") + '_length]').trigger('change');

	log('- [FNC] setTableCust(' + (JSON.stringify(aaData) || '') + ')');
};

/* getTableDef : 기초코드 조회 */
var getTableDef = function(catagory, type) {

	log('+ [FNC] getTableDef(' + catagory + ', ' + type + ')');

	var result = new Object();

	switch (catagory) {
	case "page":
	case "language":
		if (typeof commonTableInfoDef[catagory] === 'object') {
			log(' ! [FNC] getTableDef - exists >> ' + catagory + ', ' + type);
			result = commonTableInfoDef[catagory];
		} else {
			log(' ! [FNC] getTableDef - not exists >> ' + catagory + ', ' + type);
			result = {};
		}
		break;
	default:
		if (typeof commonTableInfoDef[catagory][type] === 'object') {
			log(' ! [FNC] getTableDef - exists >> ' + catagory + ', ' + type);
			result = commonTableInfoDef[catagory][type];
		} else {
			log(' ! [FNC] getTableDef - not exists >> ' + catagory + ', ' + type);
			result = [];
		}
		break;
	}

	log('- [FNC] getTableDef(' + catagory + ', ' + type + ')');

	return result;
};