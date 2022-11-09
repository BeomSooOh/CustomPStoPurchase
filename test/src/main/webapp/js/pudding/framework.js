/**
* @Project PUDDING( 가칭 ) framework 
* @Author 임헌용 ( 더존비즈온 UC개발본부 UC개발센터 UC개발1팀 )
* @Version PUDDING 0.0.0 ( 개발 버전 )
* @Code_regulation
* 	- _로 시작하는 변수는 내부호출용
* @Revision_history
* 		- 2017.09.18 프로토타입 작성( 임헌용 )
* 		- 2017.10.19 프레임워크 구조 변경( 임헌용 )
* 
*/

	//싱글톤 생성을 위한 모듈 객체	
	var PuddManager = (function( ){
		/* 프레임워크 인스턴스 변수 */
		var _INSTANCE;
		
		/* 프레임워크 */
		function PUDDING( module , debugMode ){
			this.PUDD = this.PUDD || { };
			this.CONTAINER = module || 'exp';
			this.debugMode = debugMode || false;
            this.frameworkXMLSrc = '/js/pudding/init/framework.xml';
            this.commonScriptSrc = '/js/pudding/common.js';
		}
		
		/* 프레임워크 멤버( 프로토타입 ) 모음 */
		PUDDING.prototype = {				
			/* private */
			_init : function( ){
				this._initGrobalVariable( );
				this._loadDomain( );
				this._loadframework( );
				this._loadNAMESPACE( );
				this._loadSVG( );	
				this._loadComponent( );
				this._loadCommonScript( );
			},
			
			_initGrobalVariable : function( ){
				console.log( '########## 전역변수 초기화 ##########' );
				this.PUDD = { };
				this.PUDD.fnRandomString = function( ){
					/* 카운트 증가 */
					PuddManager.setNamespaceValue( 'RANDOM_COUNT', Number( PuddManager.getGlobalVariable( 'RANDOM_COUNT' ) ) + Number( 1 ) );
					/* 랜덤 값 생성 */
					var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
					var string_length = 15;
					var randomstring = '';
					
					for ( var i = 0; i < string_length; i++ ){
						var rnum = Math.floor( Math.random( ) * chars.length );
						randomstring += chars.substring( rnum, rnum + 1 );
					}
					
					return randomstring + PuddManager.getGlobalVariable( 'RANDOM_COUNT' );
				};
			},
			
			_loadDomain : function( ){
				console.log( '########## 도메인 로드 ##########' );
				if( !window.location.origin ) {
					window.location.origin = window.location.protocol + '//' + window.location.hostname + ( window.location.port ? ':' + window.location.port : '' );
				}
				var origin = document.location.origin;
				this.makeNamespace( 'domain' );
				this.setNamespaceValue( 'domain', origin );
				return origin;
			},
		
			_loadframework : function( ){
				console.log( '########## 프레임워크 XML 로드 ##########' );
				var xml = new XMLManager( '/' + this.CONTAINER + this.frameworkXMLSrc, this.PUDD[ 'domain' ], 'getFramework' );
				xml.loadXML( );
			},
			
			_loadComponent : function( ){
				console.log( '########## 컴포넌트 로드 ##########' );
				var xmlCollection = this.PUDD.Framework['xml'];
				var url = xmlCollection.filter( function( item ){    
					return item.name === 'component';
				});  
				var xml = new XMLManager( '/' + this.CONTAINER + url[ 0 ].src, this.PUDD[ 'domain' ], 'getComponent' );
				xml.loadXML( );
			},
			
			_loadNAMESPACE : function( ) {
				console.log( '########## 네임스페이스 로드 ##########' );
				var xmlCollection = this.PUDD.Framework['xml'];
				var url = xmlCollection.filter( function( item ){    
					return item.name === 'namespace';
				});  

				var xml = new XMLManager( '/' + this.CONTAINER + url[ 0 ].src, this.PUDD[ 'domain' ], 'getNamespace' );
				xml.loadXML( );
			},
			
			_loadSVG : function( ) {
				console.log( '########## SVG 로드 ##########' );
				var xmlCollection = this.PUDD.Framework['xml'];
				var url = xmlCollection.filter( function( item ){    
					return item.name === 'svg';
				});  
				var xml = new XMLManager( '/' + this.CONTAINER + url[ 0 ].src, this.PUDD[ 'domain' ], 'getSVG' );
				xml.loadXML( );
			},
			
			_loadCommonScript :function( ){
				console.log( '########## 컴포넌트 공용사용 스크립트 로드 ##########' );
				var container = this.CONTAINER;
				var domain = this.PUDD[ 'domain' ];
				var scriptUrl = domain + '/' + container + this.commonScriptSrc;
				this._loadScript( scriptUrl, 'fnDevCommonScriptYN' );
			},

			_loadScript : function( url, fnName, charset ){
				if( !this._checkScript( fnName ) ){
					var head = document.getElementsByTagName( 'head' )[ 0 ];
				    var script = document.createElement( 'script' );
				    script.src = url;
				    script.type = 'text/javascript';
				    if( charset != null ) {
				        script.charset = 'euc-kr';
				    }
				    
				    $.ajax( {
						type: 'GET',
						url: url,
						dataType: 'script',
						async : false,
						success : function( ){
							head.appendChild( script );
						},
						error : function( request, status, error ){
							console.error( '######### '+ url +' 스크립트 로드 실패 #########');
							console.error( "code:" + request.status + "\n" + "error:" + error );
						}
					});
				}
				
			},
			
			_checkScript : function( fnName ){
				if( typeof jQuery.fn[ '\'' + fnName + '\'' ] == 'function' ){
					return true;
				}else{
					if( typeof window[ '\'' + fnName + '\'' ] == 'function'){
						return true;
					}
					return false;
				}
			},
			
			_getComponentName : function( tagName ){
					tagName = tagName == undefined ? '' : tagName;
					tagName = tagName.toUpperCase( );
					var startLength = tagName.indexOf( ':' );
					return tagName.substring( startLength + 1, tagName.length );
			},
			
			_getComponentScript : function( selector ){
				var component =  $( selector )[ 0 ].tagName.toUpperCase( );
				var container = this.CONTAINER;
				var domain = this.PUDD[ 'domain' ];
				
				/* 컴포넌트 명 예외처리 */
				switch( component ){
					case 'SELECT' :
						component = 'COMBO';
						break;
					default :
						break;
				};
				
				/* 컴포넌트 존재 확인 */
				var component = this.PUDD.Component.filter( function( item ){
					return $.trim( item.name.toUpperCase( ) ) === $.trim( component );
				});
				
				var type = component[ 0 ].type.filter( function( item ){
					return $.trim( item.name.toUpperCase( ) ) === $.trim( 'BASIC' );
				});
		
				var url = this.PUDD[ 'domain' ] + '/' + this.CONTAINER + component[ 0 ].src;					
				this._loadScript( url, type[ 0 ].jfunction ,'euc-kr' );
			},
			
			_getExceptionComponentName : function( name ){
				switch( name.toUpperCase( ) ){
					case 'SELECT' :
						name = 'combo';
						break;
					default :
						break;
				};
				return name;
			},
			
			/* public */
			getGlobalVariable : function( ){
				return this.PUDD;
			},
			
			getXmlToString : function( xmlData ) {  
				var xmlString = undefined;
		
				if( window.ActiveXObject ) {
					xmlString = xmlData[ 0 ].xml;
				}
		
				if( xmlString === undefined ) {
					var oSerializer = new XMLSerializer( );
					xmlString = oSerializer.serializeToString( xmlData[ 0 ] ); 
				}
				return xmlString;
			},
			
			makeNamespace : function( ns_string ){
				var parts = ns_string.split( '.' );
				var parent = this.PUDD;
				var i;
				
				if( parts[ 0 ] == this.PUDD ){
					parts = parts.slice( i );
				}
				
				for( i = 0; i < parts.length; i += 1 ){
					if( typeof parent[ parts[ i ] ] === 'undefined' ){
						parent[ parts[ i ] ] = { };
					}
					parent = parent[ parts[ i ] ];
					
				}
				return parent;
			},
			
			setNamespaceValue : function( name, value ){
				this.PUDD[ name ] = value;
			},
			
			importComponent : function( option ){
		
				console.log( '########## 컴포넌트 스크립트 로드 ##########' );
				option = option.toUpperCase( );
				var arrComponent = option.split( ',' );
				var isExist = ( arrComponent.indexOf( 'ALL' ) !== -1 );
				var container = this.CONTAINER;
				var domain = this.PUDD[ 'domain' ];
				
				if( isExist ){
					//전체스크립트 가져오기
					$.each( this.PUDD.Component, function( index, item ){
						var scriptUrl = domain + '/' + container + item.src;
						
						var type = item.type.filter( function( item ){
							return $.trim( item.name.toUpperCase( ) ) === $.trim( 'BASIC' );
						});
						
						this._loadScript( scriptUrl, type.jfunction );
						console.log( item.tagName + '//' + item.version + '//' + item.note + '//' + item.src );
					});
					
				}else{
					for( var i = 0; i <arrComponent.length; i++ ){
						var name = arrComponent[ i ];
						
						var component = this.PUDD.Component.filter( function( item ){
							return $.trim( item.name.toUpperCase( ) ) === $.trim( name );
						});
						
						var type = component[ 0 ].type.filter( function( item ){
							return $.trim( item.name.toUpperCase( ) ) === $.trim( 'BASIC' );
						});
						
						var scriptUrl = domain + '/' + container + component[ 0 ].src;
						this._loadScript( scriptUrl, type[ 0 ].jfunction );
						console.log( component[ 0 ].tagname + '//' + component[ 0 ].version + '//' + component[ 0 ].note + '//' + component[ 0 ].src );
					}
				}
				
				
			},
			
			changeCustomTAG : function( ){
				var $body = $( 'body *' );
				
				/* 
				 * 인자값이 0보다 크면 즉 1이면 테이블에서 호출한 것이다.
				 * arguments[ i ] = Jquery Selector형식으로 넘겨준다.
				 *  
				 * */
				if( arguments.length > 0) {
					$body = $( arguments[ i ] );
				}
				
				var elementCollection = [ ];
				var componentCollection = [ ];
				var pretext = this.PUDD.PRETEXT;
				var that = this;
				
				$.each( $body, function( index, item ){
					var tagName = item.tagName.toUpperCase( );
					if( tagName.indexOf( pretext ) != -1 ){
						elementCollection.push( item );
					}
				});
				
				//컴포넌트 로드를 위한 컴포넌트 이름을 추출한다.
				$.each( elementCollection, function( index, item ){
					var componentName = that._getComponentName( item.tagName );
					var elementJSON = { };
					
					if( componentCollection.indexOf( componentName ) == -1 ){
						componentCollection.push( componentName.toUpperCase( ) );
					}
				});
				
				//컴포넌트 스크립트를 로드한다.
				for( i = 0; i < componentCollection.length; i++ ){
					var name = componentCollection[ i ];
					var component = this.PUDD.Component.filter( function( item ){
						return $.trim( item.name.toUpperCase( ) ) === $.trim( name );
					});
					
					var type = component[ 0 ].type.filter( function( item ){
							return $.trim( item.name.toUpperCase( ) ) === $.trim( 'BASIC' );
					});
					
					var url = this.PUDD[ 'domain' ] + '/' + this.CONTAINER + component[ 0 ].src;					
					this._loadScript( url, type[ 0 ].jfunction ,'euc-kr' );
				}		
				
				$.each( elementCollection, function( index, item ){
					var optJSON  = { }, type = '';
					
					//컴포넌트 옵션 어트리뷰트 확인
					if( $( item ).attr( 'setAttribute' ) != undefined ){
						var strValue = $( item ).attr( 'setAttribute' );						
						if( strValue.length == 0 ){ strValue = '{}'; }
						
						strValue = strValue.replace(/\'/gi,"\"");
						optJSON = JSON.parse( JSON.stringify( eval("(" + strValue + ")") ) );
					} 
					
					//컴포넌트 타입 어트리뷰트 확인
					if( $( item ).attr( 'type' ) != undefined ){
						type = $( item ).attr( 'type' );
					}else{
						type = 'BASIC';
					}
					
//					//컴포넌트 onclick 이벤트 적용					
//					if( $( item ).attr( 'onClick' ) != undefined ){
//						optJSON.onClick = $( item ).attr( 'onClick' );
//					}
//					
//					//컴포넌트 name 적용
					
					
					
					//컴포넌트 타입별 확장 펑션값 가져오기 
					var tagName = that._getComponentName( item.tagName );
					var component = that.PUDD.Component.filter( function( item ){
						return $.trim( item.name.toUpperCase( ) ) === $.trim( tagName.toUpperCase( ) );
					});
					var compoFnc = component[ 0 ].type.filter( function( item ){
						return $.trim( item.name.toUpperCase( ) ) === $.trim( type.toUpperCase( ) );
					});
					var jfunction = compoFnc[ 0 ].jfunction;
					//컴포넌트 juqery 확장 펑션 호출
					$( item )[ jfunction ]( optJSON );
				});
			},
			
			create : function( selector, fnName, json ){
				console.log( '########## 컴포넌트 변환 ##########' );
				if( selector == undefined || $( selector ).length < 1 ){ return false };
				if( typeof jQuery.fn[ '\'' + fnName + '\'' ] != 'function' ) {
					var container = this.CONTAINER;
					var domain = this.PUDD[ 'domain' ];
					var that = this;
					$.each( this.PUDD.Component, function( index, item ){
						var exist = item.type.filter( function( type ){
							if( $.trim( type.jfunction.toUpperCase( ) ) === $.trim( fnName.toUpperCase( ) ) ){
								return $.trim( type.jfunction.toUpperCase( ) ) === $.trim( fnName.toUpperCase( ) );
							}
						});
						if( exist.length > 0 ){
							//스크립트 로드		
							var scriptUrl = domain + '/' + container + item.src ; 
							that._loadScript( scriptUrl, exist[ 0 ].jfunction );
							return false;
						}
					});
					
				}
				//함수 호출
				$( selector )[ fnName ]( json );
			},
			
			
			setStateChange : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setStateChange( json );
			},
			
			setSelected : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'RADIO' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'radio';
				}
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setSelected( json );
			},
			
			setChecked : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'CHECKBOX' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'checkbox';
				}
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setChecked( json );
			},
			
			setAddItem : function( json ){
			var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setAddItem( json );
			},
			
			setRemoveItem : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setRemoveItem( json );
			},
			
			setDisabled : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
								
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'CHECKBOX' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'checkbox';
				}
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'RADIO' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'radio';
				}
				
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setDisabled( json );
			},
			
			setEnabled : function( json ){
				var $selector = CommonUtil.extractSelector( json );
				var componentName =  $selector[ 0 ].tagName.toUpperCase( );
				
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'CHECKBOX' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'checkbox';
				}
				//예외처리
				if( $selector.attr( 'type' ) != undefined 
					&& $selector.attr( 'type' ).toUpperCase( ) === 'RADIO' 
					|| $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
					componentName = 'radio';
				}
				componentName = this._getExceptionComponentName( componentName );
				var component = ComponentCommander.factory( componentName.toLowerCase( ) );
				return component.setEnabled( json );
			},
			
		}
				
		return {
			getInstance : function( ){
				if( _INSTANCE === undefined ){
					_INSTANCE = new PUDDING( );
					_INSTANCE._init( );
				}
				return _INSTANCE;
			},
			
			makeNamespace : function( ns_string ){
				return _INSTANCE.makeNamespace( ns_string );
			},
			
			setNamespaceValue : function( name, value ){
				return _INSTANCE.setNamespaceValue( name, value );
			},

			getGlobalVariable : function( key ){
				if( key != undefined ){
					if( typeof _INSTANCE.PUDD[ key ] === 'function' ){
						return _INSTANCE.PUDD[ key ]( );					
					}else{
						return _INSTANCE.PUDD[ key ];
					}
				}else{
					return _INSTANCE.getGlobalVariable( );
				}
			},
			
			getXmlToString :function( xmlData ){
				return _INSTANCE.getXmlToString( xmlData );
			},
			
			/**
			 * <pre>
			 * 1. 개요
			 * 		현재 페이지에 컴포넌트 스크립트 로드
			 * 		- 사용 예)
			 * 		$( document ).ready(function(){ 선언 }); 
			 *        - DevManager.importComponent( all )
			 *        - DevManager.importComponent( input, button )
			 *        - DevManager.importComponent( input, button, textArea ) 
			 * 2. 처리내용
			 * 		- BizLogic 처리 :
			 *			1) 
			 *			2) 
			 *			3) 
			 * 3. 입력 Data : string
			 * 4. 출력 Data : 페이지 상단 스크립트 동적 로드
			 * </pre>
			 * @Method Name :
			 * @param $
			 */
			importComponentScript : function( option ){
				return _INSTANCE.importComponent( option )
			},
			
			/**
			 * <pre>
			 * 1. 개요
			 * 		컴포넌트 변환
			 * 		- 주의 ) 컴포넌트 라이브러리에서 반드시 호출해주어야 한다.
			 * 		
			 * 2. 처리내용
			 * 		- BizLogic 처리 :
			 *			1) 
			 *			2) 
			 *			3) 
			 * 3. 입력 Data : #셀렉터, 생성한 컴포넌트 인스턴스
			 * 4. 출력 Data : 
			 * </pre>
			 * @Method Name :
			 * @param $
			 */
			makeComponent : function( $selector, instance ){
				var componentMaker = new ComponentMaker( $selector, instance );
				componentMaker.makeComponent( );
				//null 할당
				//componentMaker = null;
			}, 

			//커스텀 태그 컴포넌트 변환
			//	- 주의 ) 커스텀 태그 변환
			pageLoadComponent : function( selector ){
				if( selector != undefined ){
					return _INSTANCE.changeCustomTAG( selector );
				}else{
					return _INSTANCE.changeCustomTAG( );
				}
			},
			//컴포넌트 생성
			create : function( selector, fnName, json ){
				return _INSTANCE.create( selector, fnName, json );
			},
			
			
			/* 공통 기능 호출 함수 */
			
			setSelected : function( json ){
				return _INSTANCE.setSelected( json );
			},
			
			setChecked : function( json ){
				return _INSTANCE.setChecked( json );
			},
						
			setStateChange : function( json ){
				return _INSTANCE.setStateChange( json );
			},
			
			setAddItem : function( selecter, json ){
				return _INSTANCE.setAddItem( selecter, json );
			},
			/* TODO */
			setRemoveItem : function( json){
				return _INSTANCE.setRemoveItem( json );
			},
			
			setDisabled : function( json ){
				return _INSTANCE.setDisabled( json );
			},
			
			setEnabled : function( json ){
				return _INSTANCE.setEnabled( json );
			},
		};
		
	})( );

	

	function ComponentMaker( $selector, instance ){
		this.$selector = $selector;	
		this.instance = instance;
		this.componentInterface = null;	
	}
	
	ComponentMaker.prototype = {
		inlineAttr :{ },
		topAttr : { },
		
		makeComponent : function( ){
			this.extractAttr( );
			this.makeTopDiv( );
			this.removeSelector( );
			this.launch( );
		},
		
		extractAttr : function( ){
			
			var oldElement = function( $selector ){
				return $selector.hasClass( 'old' );
			};
				
			if( oldElement( this.$selector ) ){
				if( this.$selector.attr( 'data-inline' ) != undefined ){
					var strAttr = this.$selector.attr( 'data-inline' ) || { };
					strAttr = JSON.stringify( strAttr );
					var jsonAttr = JSON.parse( strAttr );
					
					this.inlineAttr.class = JSON.parse( JSON.stringify( jsonAttr.class ) );
					this.inlineAttr.style = JSON.parse( JSON.stringify( jsonAttr.style ) );
					
					this.topAttr.topClass = JSON.parse( JSON.stringify( jsonAttr.topClass ) );
					this.topAttr.topStyle = JSON.parse( JSON.stringify( jsonAttr.topStyle ) );
					
				}
			}else{
				if( this.$selector.attr( 'class' ) != undefined ){
					this.inlineAttr.class = this.$selector.attr( 'class' );
				}
				
				if( this.$selector.attr( 'style' ) != undefined ){
					this.inlineAttr.style = this.$selector.attr( 'style' );
				}
				
				if( this.$selector.attr( 'name' ) != undefined ){
					this.inlineAttr.name = this.$selector.attr( 'name' );
				}
				
				if( this.$selector.attr( 'onclick' ) != undefined ){
					this.inlineAttr.onclick = this.$selector.attr( 'onclick' );
				}
				
				if( this.$selector.attr( 'onchange' ) != undefined ){
					this.inlineAttr.onchange = this.$selector.attr( 'onchange' );
				}
				
				if( this.$selector.attr( 'topClass') != undefined ){
					this.topAttr.class = this.$selector.attr( 'topClass' );
				}
				
				if( this.$selector.attr( 'topStyle' ) != undefined ){
					this.topAttr.style = this.$selector.attr( 'topStyle' );
				}
			}
			
		},
		
		makeTopDiv : function( ){
			var DIV = document.createElement( 'DIV' );
			this.$selector.before( DIV );
			
			//$('body').after( DIV );			
			var dataValue = { };
			dataValue.class = this.inlineAttr.class || '';
			dataValue.style = this.inlineAttr.style || '';
			dataValue.topClass = this.topAttr.class || '';
			dataValue.topStyle = this.topAttr.style || '';
			
			if( this.$selector.attr( 'id' ) != undefined ){
				$( DIV ).attr( 'id', String( this.$selector.attr( 'id' ) ) );
			}
			
			if( this.$selector.attr( 'class' ) != undefined ){
				$( DIV ).attr( 'class', this.$selector.attr( 'class' ) );
			}
			
			$( DIV ).attr( 'data-inline', JSON.stringify( dataValue ) );
			/* 임시 주석 처리 */
			//$( DIV ).addClass( 'old' );

		},
		
		removeSelector : function( ){
			this.$selector.empty( );
			this.$selector.unbind( );
			this.$selector.remove( );
		},
		
		launch : function( ){
			this.componentInterface = new ComponentInterface( 'componentInterface', [ 'init', 'setElementAssembly', 'setElementStyle', 'setElementClass', 'setElementAttribute', 'setEvent' ] );
			ComponentInterface.ensureImplements( this.instance, this.componentInterface );
			this.instance.init( );
			this.instance.setElementAssembly( );
			this.instance.setElementStyle( );
			this.instance.setElementClass( );
			this.instance.setElementAttribute( );
			this.instance.setEvent( );
		},
		
	}					
	
	
	
	function XMLManager( url, domain, callback ){
		this.xmlDoc;
		this.xmlUrl = url;
		this.domain = domain;
		this.callback = this[callback]; 
	}	
	
	XMLManager.prototype.loadXML = function(  ){
		var req = new XMLHttpRequest( );
		var callback = this.callback;
		req.onreadystatechange = function( ) {
			if( this.readyState == 4 && this.status == 200) {
				callback.apply( this,[ this ] );
			}
		};
		req.open( 'GET', this.domain + this.xmlUrl , false );
		req.send( );
		
	}
	
	XMLManager.prototype.getFramework = function( xml ){
		
		var xmlDoc = xml.responseXML;
		var framework = xmlDoc.getElementsByTagName( 'Framework' );
		var $framework = $( framework );
		var globalVar = { }; 
		
		PuddManager.makeNamespace( 'Framework' );
		
		var componentCollection = [ ];
		var xmlCollection = [ ];
		
		$framework.children( ).each( function( index, item ){
			console.log( $( this )[ 0 ].tagName );
			
			
			if( $( this )[ 0 ].tagName.toUpperCase( ) === 'VERSION' ){
				globalVar.version = $( this ).text( );
				
			}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'NOTE' ){
				globalVar.description = $( this ).text( );
				
			}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'DATE' ){	
				globalVar.date = $( this ).text( );
				
			}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'COMPONENT' ){
				var $component = $( this );
				var component = { };
				$component.children( ).each( function( index, item ){
					if( $( this )[ 0 ].tagName.toUpperCase( ) === 'NAME' ){
						component.name = $( this ).text( );
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'VERSION' ){
						component.version = $( this ).text( );
					}					
				});
				componentCollection.push( component );	
			}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'XML' ){
				var $xml = $( this );
				var xml = { };
				
				$xml.children( ).each( function( index, item ){					
					if( $( this )[ 0 ].tagName.toUpperCase( ) === 'NAME' ){
						xml.name = $( this ).text( );
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'SRC' ){
						xml.src = $( this ).text( );
					}
				});
				xmlCollection.push( xml );
			}
		});
		globalVar.component = componentCollection;
		globalVar.xml = xmlCollection;
		
		PuddManager.setNamespaceValue( 'Framework', globalVar);
		console.log( PuddManager.getGlobalVariable( ) );
	}
	
	XMLManager.prototype.getSVG = function( xml ){
		var xmlDoc = xml.responseXML;
		var svgCollection = xmlDoc.getElementsByTagName( 'SVGCollection' );
		var $svgCollection = $( svgCollection );
		
		var newData = [ ];
		$svgCollection.children( ).each( function( index, item ){
			var svg = { };
			svg.type = $( this ).find( 'type' ).text( );
			svg.html = PuddManager.getXmlToString( $( this ).find( 'svg' ) );
			
			newData.push( svg );				
		});
		
		PuddManager.makeNamespace( 'SVGCollection' );
		PuddManager.setNamespaceValue( 'SVGCollection', newData );
	}
	
	XMLManager.prototype.getNamespace = function( xml ){
		var xmlDoc = xml.responseXML;
		var nameSpace = xmlDoc.getElementsByTagName( 'namespace' );
		var $nameSpace = $( nameSpace );
		
		$nameSpace.children( ).each( function( index, item ){
			console.log( ' name : ' + $( this ).find( 'name' ).text( ) );
			console.log( ' value : ' + $( this ).find( 'value' ).text( ) );
			
			var key = $( this ).find( 'name' ).text( );
			var value = $( this ).find( 'value' ).text( );
			
			PuddManager.makeNamespace( key );
			PuddManager.setNamespaceValue( key, value );

		});
	}
	
	
	
	XMLManager.prototype.getComponent = function( xml ){
		
		var xmlDoc = xml.responseXML;
		var component = xmlDoc.getElementsByTagName( 'Component' );
		var $component = $( component );
		
		PuddManager.makeNamespace( 'Component' );
		var componentCollection = [ ];
		$component.children( ).each( function( index, item ){
			
			if( $( this )[ 0 ].tagName.toUpperCase( ) === 'ITEM' ){
				var component = { };
				var $item = $( item );
				var typeCollection = [ ];
				$item.children( ).each( function( index, item ){

					if( $( this )[ 0 ].tagName.toUpperCase( ) === 'NAME' ){
						component.name = $( this ).text( );
						
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'TAGNAME' ){
						component.tagname = $( this ).text( );
						
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'VERSION' ){	
						component.version = $( this ).text( );
						
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'NOTE' ){	
						component.note = $( this ).text( );
						
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'SRC' ){	
						component.src = $( this ).text( );
						
					}else if( $( this )[ 0 ].tagName.toUpperCase( ) === 'TYPE' ){
						var $type = $( this );
						var typeInfo = { };
						typeInfo.name = $type.find( 'name' ).text( ) || '';
						typeInfo.jfunction = $type.find( 'jfunction' ).text( ) || '';
						typeCollection.push( typeInfo );
					}
					component.type = typeCollection;
				});
				
				componentCollection.push( component );
			}
			
		});

		PuddManager.setNamespaceValue( 'Component', componentCollection );
		console.log( PuddManager.getGlobalVariable( ) );
	}
	
	var ComponentInterface = function( name, methods ) {
	    if(arguments.length != 2) {
	        throw new Error('인터페이스 생성을 위한 매개변수는 (인터페이스 변수, [메소드])가 필요합니다. 입력한 매개변수 갯수:' + arguments.length + '개');
	    }
	
	    this.name = name;
	    this.methods = [ ];
	
	    for (var i = 0, len = methods.length; i < len; i++) {
	        if(typeof methods[ i ] !== 'string') {
	            throw new Error('메소드 이름은 stirng이여야 합니다.');
	        }
	
	        this.methods.push( methods[ i ] );
	    }
	};
	
	ComponentInterface.ensureImplements = function( object ) {
	    if( arguments.length < 2 ) {
	        throw new Error(' 인터페이스를 구현여부를 확인하기 위해 최소 2개의 매개변수가 필요합니다. 입력한 매개변수 갯수' + arguments.length + '개' );
	    }
	
	    for( var i = 1, len = arguments.length; i < len; i++ ) {
	        var interface = arguments[ i ];
	
	        if( interface.constructor !== ComponentInterface ) {
	            throw new Error('인터페이스를 구현한 객체변수의 생성자가 ComponentInterface가 아닙니다.');
	        }
	
	        for( var j = 0, methodsLen = interface.methods.length; j < methodsLen; j++ ) {
	            var method = interface.methods[ j ];
	
	            if( !object[ method ] || typeof object[ method ] !== 'function') {
	                throw new Error( '인터페이스 객체인 ' + interface.name + '의 인터페이스가 구현되지 않았습니다. 메소드 명 : ' + method );
	            }
	        }
	    }
	};	
	
	
	/* 공통 기능 호출함수 */
	function ComponentCommander( constr ) {
		this.type = constr;
	}
	
	ComponentCommander.prototype = {

		setStateChange : function( json ){
			console.error( '##### ERROR ##### : setStateChange function of ' + this.type + " doesn't exist" );
		},			
		
		setSelected : function( json ){
			console.error( '##### ERROR ##### : setSelected function of ' + this.type + " doesn't exist" );
		},
		
		setChecked : function( json ){
			console.error( '##### ERROR ##### : setChecked function of ' + this.type + " doesn't exist" );
		},
		
		setAddItem : function( json ){
			console.error( '##### ERROR ##### : setAddItem function of ' + this.type + " doesn't exist" );
		},
		/* TODO */
		setRemoveItem : function( json ){
			console.error( '##### ERROR ##### : setRemoveItem function of ' + this.type + " doesn't exist" );
		},
		setDisabled : function( json ){
			console.error( '##### ERROR ##### : setDisabled function of ' + this.type + " doesn't exist" );
		},
		setEnabled : function( json ){
			console.error( '##### ERROR ##### : setEnabled function of ' + this.type + " doesn't exist" );
		},
											
	}
	
	ComponentCommander.factory = function( type ) {
		this.type = type;
		var constr = type, component;

		//생성자 미존재시 에러 발생
		if( typeof ComponentCommander[ constr ] !== "function" ) {
			console.error( '##### ERROR ##### :'+ constr + " doesn't exist" );
			throw new Error( 'message :' + constr + " doesn't exist" );
		}
		//생성자가 존재하면 부모 상속
		if( typeof ComponentCommander[ constr ].prototype.setStateChange !== "function" ) {
			ComponentCommander[ constr ].prototype.setStateChange = new ComponentCommander( constr ).setStateChange;
		}
		if( typeof ComponentCommander[ constr ].prototype.setChecked !== "function" ) {
			ComponentCommander[ constr ].prototype.setChecked = new ComponentCommander( constr ).setChecked;
		}
		if( typeof ComponentCommander[ constr ].prototype.setSelected !== "function" ) {
			ComponentCommander[ constr ].prototype.setSelected = new ComponentCommander( constr ).setSelected;
		}
		if( typeof ComponentCommander[ constr ].prototype.setAddItem !== "function" ) {
			ComponentCommander[ constr ].prototype.setAddItem = new ComponentCommander( constr ).setAddItem;
		}
		/* TODO */
		if( typeof ComponentCommander[ constr ].prototype.setRemoveItem !== "function" ) {
			ComponentCommander[ constr ].prototype.setRemoveItem = new ComponentCommander( constr ).setRemoveItem;
		}
		if( typeof ComponentCommander[ constr ].prototype.setDisabled !== "function" ) {
			ComponentCommander[ constr ].prototype.setDisabled = new ComponentCommander( constr ).setDisabled;
		}
		if( typeof ComponentCommander[ constr ].prototype.setEnabled !== "function" ) {
			ComponentCommander[ constr ].prototype.setEnabled = new ComponentCommander( constr ).setEnabled;
		}
		
		component = new ComponentCommander[ constr ]( );
		return component;
	};
	
	
	
	console.log( '########## PUDD 스크립트 시작 #########' );
	PuddManager.getInstance( );
	
	$( document ).ready( function( ){
		PuddManager.pageLoadComponent( );
	});
	