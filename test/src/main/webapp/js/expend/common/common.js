/**
 * 공통사용 스크립트
 */

/* Layer Alert */
function fnAlert ( alertMessage ) {
	var ajaxParam = {};
	ajaxParam.alertMessage = alertMessage;

	$ ( "html, body" ).scrollTop ( 0 );

	$.ajax ( {
		type: "post",
		url: url,
		datatype: "json",
		data: ajaxParam,
		success: function ( data ) {
			var $parent; // modal과 레이어가 들어갈 div
			var $children; // 레이어 div

			if ( $ ( '.sub_contents_wrap' ).length > 0 ) {
				$parent = $ ( '.sub_contents_wrap' );
			} else if ( $ ( ".pop_wrap" ).length > 0 ) {
				$parent = $ ( ".pop_wrap" );
			} else if ( $ ( ".pop_wrap" ).length > 0 ) {
				$parent = $ ( ".pop_sign_wrap" );
			} else if ( $ ( '.pop_wrap_dir' ).length > 0 ) {
				$parent = $ ( ".pop_sign_wrap" );
			}
			$parent.append ( '<div id="modal" class="modal"></div>' );
			$parent.append ( data );

			$children = $ ( '#pop_alert' );
			$children.css ( "border", "1px solid #adadad" );
			$children.css ( "z-index", "20" );

			var popWid = $children.outerWidth ( );
			var popHei = $children.outerHeight ( );

			$children.css ( "top", "50%" ).css ( "left", "50%" ).css ( "marginLeft", -popWid / 2 ).css ( "marginTop", -popHei / 2 );
		}
	} );
}