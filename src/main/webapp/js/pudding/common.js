
/**
 * <pre>
 * 1. 개요
 * 		INPUT에 대한 공통적인 유용한 기능모음에 대한 객체 리터럴
 * 2. 처리내용
 * 		- BizLogic 처리 :
 *			1) CastToJSONObject : 문자열 -> JSON 변환
 *			2) CastUnit : 스타일 속성의 문자열에 px 및 %이 존재하지 않으면 강제 px 를 지정
 *			3) CreateId : 엘리먼트 아이디 생성
 * 3. 입력 Data :  
 * 4. 출력 Data : 
 * </pre>
 * @Method Name : CastToJSONObject, CastUnit, CreateId, SearchSVGObject
 * @param $
 */
var CommonUtil = {
		castToJSONObject : function( str ){
			var retJSON = {};
		
			if( typeof str == 'string'){
				retJSON =  JSON.parse( JSON.stringify( str ) );
			}
			else if( typeof str == 'object'){
				retJSON = str;
			}
			
			return retJSON;
		},
		
		castUnit : function( str ){
			var postFix = "px";
			str = str.toString();
			
			if( str.indexOf("%") != -1 ){
				return str;
			}else if( str.indexOf("px") != -1 ){
				return str;
			}else if( str.indexOf("pX") != -1 ){
				str.replace('pX','px');
				return str;
			}else if( str.indexOf("Px") != -1 ){
				str.replace('Px','px');
				return str;
			}else if( str.indexOf("PX") != -1 ){
				str.replace('PX','px');
				return str;
			}else if( !CommonUtil.isNumber( str ) ){
				return str;
			}else{
				return str = str + postFix;
			}
		},
		
		createId : function( id, tagname ){
			var _newKey = "";
			_newKey = id + "_" + tagname;
			return _newKey;
		},
		
		searchSVGObject : function( searchType ){
			searchType = searchType == undefined ? "" : searchType;
			var xmlNode = PuddManager.getGlobalVariable( 'SVGCollection' ).filter( function( item ){    
				return item.type === searchType;
			}); 
			return str = String( xmlNode[0].html ).replace(/\t/g, '').replace(/\n/g, '');
		},
		
		convertAttributeToJSON : function( $element, attribute  ){
			var styles = $element.attr( attribute ).split( ';' ), i = styles.length, json = { style: { } }, style, k, v;
			while ( i-- )
			{
			    style = styles[ i ].split( ':' );
			    k = $.trim( style[ 0 ] );
			    v = $.trim( style[ 1 ] );
			    if ( k.length > 0 && v.length > 0 )
			    {
			        json.style[ k ] = v;
			    }
			}
			console.log( $.toJSON(json) );
			return $.toJSON( json) ;
		},
		
		isNumber : function( s ){
			s += ''; // 문자열로 변환
			s = s.replace( /^\s*|\s*$/g, ''); // 좌우 공백 제거
			if (s == '' || isNaN( s ) ){ 
				 return false;
			}
			return true;
		},
		
		extractSelector : function( j ){
			var $selector = null;
			if( j.id != undefined ){
				$selector = $( "#" + j.id );
			}else if( j.class != undefined ){
				$selector = $( "." + j.class );
			}else if( j.name != undefined ){
				var tagName = j.tagName || '';				
				$selector = $( tagName +"[name=" + j.name +"]" );
			}
			return $selector;
		},
		
}

/**
 * <pre>
 * 1. 개요
 * 		중복 스크립트방지용 함수
 *        
 * 2. 처리내용
 * 		- BizLogic 처리 :
 *			1)   
 *			2)
 *			3) 
 * 3. 입력 Data :  
 * 4. 출력 Data : true or false
 * </pre>
 * @Method Name : String.prototype.IsKorean
 * @param $
 */
function fnDevCommonScriptYN(){}


/**
 * <pre>
 * 1. 개요
 * 		한글여부 판별 String 프로토타입 메소드( IsKorean )
 * 		- 사용 예)
 *        "abc!@#()[]{}".IsKorean();
 * 2. 처리내용
 * 		- BizLogic 처리 :
 *			1) 해당 문자가 한글인지 확인( 유니코드 )
 *			2)
 *			3) 
 * 3. 입력 Data :  
 * 4. 출력 Data : true or false
 * </pre>
 * @Method Name : String.prototype.IsKorean
 * @param $
 */
String.prototype.IsKorean = function(){
		var arg = arguments[ 0 ] === undefined ? this.toString( ) : arguments[ 0 ];
		if( arg === undefined || arg === null ){ 
			throw "입력한 문자가 존재하지 않습니다.";
		}else{
			var _chk = true
			var _sp = /\s+/;
			
			if( typeof (arg) != "string" ){
				throw " 입력한 문자는 문자열 타입이 아닙니다.";
			}
			
			for( var i = 0; i < arg.length; i++ ){
				var _ch = arg[i].charCodeAt( );
				_chk = _chk && ( ( _ch >= 0x3131 && _ch <= 0x318E ) || ( _ch >= 0xAC00 && _ch <= 0xD7AF ) || _sp.test( arg[i] ) );
			}
			
			return _chk;
		}
	 }		
	
/**
 * <pre>
 * 1. 개요
 * 		한글여부 판별 ( IsKorean unbound 버전 )
 * 		- 사용 예)
 *        String.IsKorean("abc!@#()[]{}");
 * 2. 처리내용
 * 		- BizLogic 처리 :
 *			1) 해당 문자가 한글인지 확인( 유니코드 )
 *			2) 
 *			3) 
 * 3. 입력 Data :  arg
 * 4. 출력 Data : true or false
 * </pre>
 * @Method Name : String.IsKorean
 * @param $
 */
String.IsKorean = function( arg ){
	if (arg === undefined || arg === null) { 
		throw "입력한 문자가 존재하지 않습니다."; 
	}
    else {
        if (typeof (arg) != "string") { 
        	throw "입력한 문자는 문자열 타입이 아닙니다."; 
        }
        return arg.IsKorean();
    }
}
