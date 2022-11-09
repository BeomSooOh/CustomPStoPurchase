/* ajax 호출 정의 */
/*ajax 호출 반환읜 항상 { "result" : {"result" : {} } } 로 반환*/
var ajax = function ( params ) {
	try {
		/* log(' ! [FNC] ajax(' + JSON.stringify(params) + ')'); */
		var result = JSON.parse ( $.ajax ( {
			type: 'post',
			url: _g_contextPath_ + ( params.url || '' ),
			datatype: 'json',
			async: params.async,
			data: params.parameter
		} ).responseText ).result;

		return result;
	} catch ( e ) {
		/* log ( ' ! [FNC] ajax(' + JSON.stringify ( params ) + ') >> ERROR >> ' + e ); */
	}
};