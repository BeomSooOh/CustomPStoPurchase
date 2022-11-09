var eventTarget = {
	emp : "#btnExpendEmpSearch, #btnExpendApproval",
	pc : [],
	cc : [],
	budget : [],
	bizplan : [],
	bgacct : [],
	project : [],
	partner : [],
	card : [],
	car : [],
	search : "#btnSearch, #btnReportExpendAdmSearch"
};

/* click event */
var setClick = function(target, fnc, param) {
	target
			.each(function() {
				log('+ [FNC] setClick(' + ($(this)[0].id || '') + ')');

				if (typeof $._data($(this).get(0), 'events') === 'undefined') {
					if (typeof fnc === 'function') {
						log(' ! [FNC] setClick - click event not exists >> '
								+ ($(this)[0].id || ''));
						$(this).click(function() {
							fnc(param);
						});
					}
				} else if ($._data($("#btnExpendApproval").get(0), 'events').click.length === 0) {
					if (typeof fnc === 'function') {
						log(' ! [FNC] setClick - click event not exists >> '
								+ ($(this)[0].id || ''));
						$(this).click(function() {
							fnc(param);
						});
					}
				} else {
					log(' ! [FNC] setClick - click event exists >> '
							+ ($(this)[0].id || ''));
				}

				log('- [FNC] setClick(' + ($(this)[0].id || '') + ')');
			});
};

/* focus event */
/* keypress event */