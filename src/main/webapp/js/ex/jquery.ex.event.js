/**
 * 이벤트 관련 기능
 */

(function( $ ) {
    /* input[type=text] bind event */
    $.fn.txtEnter = function( fnc, type, shiftFunc ) {
        return this.each(function() {
            fnc = (fnc || '');
            type = (type || null);
            shiftFunc = ( shiftFunc || '');
            
            $(this).bind('keypress', function() {
            	/* shift key가 입력되었으며, shift 델리게이터가 있는경우. */ 
            	if (event.keyCode == 13 && event.shiftKey && ( typeof shiftFunc == 'function' || shiftFunc != '')){
            		if( (typeof shiftFunc == 'string') && window[shiftFunc]){
            			window[shiftFunc]($(this).val());
            		}else if((typeof shiftFunc == 'function')){
            			shiftFunc();
            		}
            	}           	
            	/* 일반 엔터 검색의 델리게이터 호출의 경우 */
            	else if (event.keyCode == 13) {
                    if ( (typeof fnc == 'string') && window[fnc]) {
                        window[fnc]($(this).val());
                    }else if((typeof fnc == 'function')){
                    	fnc();
                    }
                } 
            	/* 숫자의 경우 */
            	else {
                    if (type == 'numeric') {
                        $(this).val($(this).val().replace(/[^0-9]/gi, ""));
                    }
                }
            });
        });
    },
    
    /* input[type=text] change event */
    $.fn.txtChange = function( type, name ) {
        return this.each(function() {
            if (type == 'kendoData_searchParam') {
                searchParam.set(name, ($(this).val() || ''));
            }
        });
    },
    /* input[type=button] bind event */
    $.fn.btnClick = function( fnc, param ) {
        return this.each(function() {
            fnc = (fnc || '');
            param = (param || null);

            $(this).click(function() {
                if (window[fnc]) {
                    window[fnc](param);
                }
            });
        });
    }
})(jQuery);

/* ajax call */
function fnCallAjax( ajaxParam ) {
    $.ajax({
        type : 'post',
        url : ajaxParam.url,
        datatype : 'json',
        async : ajaxParam.async,
        data : ajaxParam.data,
        success : function( data ) {
            if (typeof ajaxParam.callback == 'function') {
                ajaxParam.callback(data);
            }
        },
        error : function( data ) {
            alert(NeosUtil.getMessage("TX000008120", "오류가 발생하였습니다"));
        }
    });
}