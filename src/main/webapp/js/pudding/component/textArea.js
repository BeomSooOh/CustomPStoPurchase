/**
* @project_description PUDD( 가칭 ) Component TEXTAREA FILED
*
* @author 임헌용 ( 더존비즈온 UC개발본부 UC개발센터 UC개발1팀 )
* @version PUDD 0.0.0 ( 개발 버전 )
* @Revision_history
* 		- 2017.10.27 	최초 작성( 임헌용 )
*/

(function ($) {
 
	/* 기본 TEXTAREA기능을 위한 Jquery 확장 함수 */
	$.fn.PuddTextArea = function( _opt ){
	
		$.each( $( this ), function(index, item){
			if( $( this ).attr( 'id' ) == undefined || $( this ).attr( 'id' ) == ''){
				$( this ).attr( 'id' , PuddManager.getGlobalVariable( 'fnRandomString' ) );
			}
		
			var parameter = { 
					id : $( this ).attr( 'id' ),
					class : $( this ).attr( 'class' ) || '',
					option : _opt || { },
			};
		
			var puddTextArea = new PuddTextArea( parameter );
			PuddManager.makeComponent( $( this ), puddTextArea );
		});
	};
	
	
	ComponentCommander.textarea = function( ){ };
	
	/* 비활성화 */
	ComponentCommander.textarea.prototype.setDisabled = function( _json ){
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		$selector.attr( 'disabled', 'disabled' );
	};
	
	/* 활성화 */
	ComponentCommander.textarea.prototype.setEnabled = function( _json ){
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		$selector.removeAttr( 'disabled' );
	};
	
	ComponentCommander.textarea.prototype.setStateChange = function( _json ){ 
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		var item = '';
		var message = '';
		
		if( json.state != undefined ){
			var state = json.state;
			if ( state.item != undefined ){
				item = state.item.toUpperCase( ); 
			}else{
				console.error( '상태 값을 입력하지 않았습니다.' );
				return false;
			}
			
			if( state.message != undefined ){
				message = state.message;
			}
		}
		
		$selector.parent( ).removeClass( 'Error' );
		$selector.parent( ).removeClass( 'Success' );
		$selector.parent( ).removeClass( 'Warning' );
		
		switch( item.toUpperCase( ) ){
				case 'SUCCESS' :	
					$selector.parent( ).addClass( 'Success' );
					break;
				case 'WARNING' :
					$selector.parent( ).addClass( 'Warning' );
					break;
				case 'ERROR' :
					$selector.parent( ).addClass( 'Error' );
					break;
				default :
					break;
			}
		
		$.each( $selector, function( index, item ){							
			if ( $( item ).siblings( '.informationText' ).length > 0 ){
				$( item ).siblings( '.informationText' ).remove( );
			}			
		});
		
		if( message != ''){
			$selector.after( '<div class="informationText animated03s fadeInRight">'+ message + '</div>' );
		}else{
			switch( item.toUpperCase( ) ){
				case 'SUCCESS' :	
					$selector.after( '<div class="informationText animated03s fadeInRight">'+ PuddManager.getGlobalVariable( 'SUCCESS' ) + '</div>' );
					break;
				case 'WARNING' :
					$selector.after( '<div class="informationText animated03s fadeInRight">'+ PuddManager.getGlobalVariable( 'WARRING' ) + '</div>' );
					break;
				case 'ERROR' :
					$selector.after( '<div class="informationText animated03s fadeInRight">'+ PuddManager.getGlobalVariable( 'ERROR' ) + '</div>' );
					break;
				default :
					break;
			}
		}				
	};
	
	
	function PuddTextArea( parameter ){
		/* 개발자 옵션 */
		this.id = parameter.id;
		this.class = parameter.class;
		this.$selector = null;
		this.option = parameter.option;
		this.type = parameter.type;
		
		/* 생성할 엘리먼트 */
		this.DIV = null;
		this.TEXTAREA = null;
		this.SPAN = null;
		this.INFO_DIV = null;
		
		
		this.$DIV = null;
		this.$TEXTAREA = null;
		this.$SPAN = null;
		this.$INFO_DIV = null;
		
		
		/* 생성할 이벤트 */
		this.event = [ ];
		
		/* 클래스 및 스타일 추출 */
		this.inStyle = null;
		this.inClass = null;
		this.outStyle = null;
		this.outClass = null;
		
	}
	
	PuddTextArea.prototype = {

		_createElement : function( tagName ){
			tagName = tagName.toUpperCase( );
			switch( tagName ){
				case 'TEXTAREA':
					this.TEXTAREA = document.createElement( 'TEXTAREA' );
					this.$TEXTAREA = $( this.TEXTAREA );
					break;
						
				case 'INFO_DIV':
					this.INFO_DIV = document.createElement( 'DIV' );
					this.$INFO_DIV = $( this.INFO_DIV );
					break;
					
				case 'SPAN':
					this.SPAN = document.createElement( 'SPAN' );
					this.$SPAN = $( this.SPAN );
					break; 
			}
			
		},
		
		init : function( ){
			this.DIV = document.getElementById( this.id );
			this.$DIV = $( this.DIV );
			this.$selector = $( this.DIV );
			 			
			var json = this.$selector.attr( 'data-inline' ) || { };
			json = JSON.parse( JSON.stringify( json ) );
			this.inStyle = json.style || null;
			this.inClass = json.class || null;
			this.outStyle = json.topStyle || null;
			this.outClass = json.topClass || null;
		
			var state = this.option.state == undefined ? false : this.option.state;
			var hint = this.option.hintText == undefined ? false : this.option.hintText;
			
			this._createElement( 'TEXTAREA' );
			if( hint != false ){
				this._createElement( 'SPAN' );
			}
			if( state != false ){
				this._createElement( 'INFO_DIV' );			
			}							
		},
		
		setElementAssembly : function( ){					
			var type = this.type == undefined ? '' : this.type.toUpperCase( );
			this.DIV.appendChild( this.TEXTAREA );
			
			if( this.SPAN != null ){
				this.DIV.appendChild( this.SPAN );
				var hintText = this.option.hintText == undefined ? '' : this.option.hintText;
				this.$SPAN.html( hintText );
			}
			
			if( this.INFO_DIV != null ){
				
				var state = this.option.state || { };
				var type = state.item == undefined ? '' : state.item.toUpperCase( );
				var message = state.message == undefined ? '' : state.message;
				
				if( message !== ''){
					this.$INFO_DIV.html( message );
				}else{
					switch( type ){
						case 'SUCCESS':	
							this.$INFO_DIV.html( PuddManager.getGlobalVariable( 'STATE_SUCCESS_MESSAGE' ) );
							break;
						case 'ERROR':
							this.$INFO_DIV.html( PuddManager.getGlobalVariable( 'STATE_ERROR_MESSAGE' ) );
							break;
						case 'WARNING':
							this.$INFO_DIV.html( PuddManager.getGlobalVariable( 'STATE_WARNING_MESSAGE' ) );
							break;
						default:
							break;
					}
				}
				this.DIV.appendChild( this.INFO_DIV );
			}
		},
		
		setElementStyle : function( ){
			puddTextAreaStyle.pushDivStyle( this.$DIV, this.option.style || { } , this.outStyle );
			puddTextAreaStyle.pushTextAreaStyle( this.$TEXTAREA, this.option.style || { }, this.inStyle );
		},
		
		setElementClass : function( ){			
			puddTextAreaClass.pushDivClass( this.$DIV, this.option, this.type, this.outClass );
			
			if( this.TEXTAREA != null ){
				puddTextAreaClass.pushTextAreaClass( this.$TEXTAREA, this.class, this.inClass );
			}
			
			if( this.SPAN != null ){
				puddTextAreaClass.pushSpanClass( this.$SPAN );
			}
			
			if( this.INFO_DIV != null ){
				puddTextAreaClass.pushInfoDivClass( this.$INFO_DIV );
			}
		},
		
		setElementAttribute : function( ){
			puddTextAreaAttribute.pushDivAttribute( this.$DIV, this.option, this.id );
			if( this.TEXTAREA != null){
				puddTextAreaAttribute.pushTextAreaAttribute( this.$TEXTAREA, this.option, this.id );
			}			
		},
		
		setEvent : function( ){
			if( this.SPAN != null ){
				
				var hintTextEvent = {
					divId : this.$DIV.attr( 'id' ),
					textAreaId : this.$TEXTAREA.attr( 'id' ),
					eventName : 'hintFocusEvent'
				};
				this.event.push( hintTextEvent );
			}
			
			var textAreaEvent = new TextAreaEvent( this.event, this.option );
			textAreaEvent.createEvent( );
		},
	}
	
		
		
	/**
	 * <pre>
	 * 1. 개요
	 * 		스타일 지정에 대한 객체 리터럴
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1) pushDivStyle : 선택자(DIV)에 대한 스타일 지정
	 *			2) pushInputStyle : 선택자(TEXTAREA)에 대한 스타일 지정 
	 *			3) 
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name : pushDivStyle, pushInputStyle
	 * @param $
	 */
	var puddTextAreaStyle = {		
			pushDivStyle : function( $element, styleOption, outStyle ){
				styleOption = styleOption == undefined ? { } : styleOption;
				//JSON 변환
				styleOption = CommonUtil.castToJSONObject( styleOption );
				//옵션 스타일 지정
				if( styleOption.width != undefined ){				
					$element.css( 'width',  CommonUtil.castUnit( styleOption.width ) );
				}
				
				if( styleOption.height != undefined ){				
					$element.css( 'height',  CommonUtil.castUnit( styleOption.height ) );
				}
				
				if( styleOption.marginLeft != undefined ){				
					$element.css( 'margin-left:', CommonUtil.castUnit( styleOption.marginLeft ) );
				}
				
				if( styleOption.marginRight != undefined ){				
					$element.css( 'margin-right:', CommonUtil.castUnit( styleOption.marginRight ) );
				}
				
				if( outStyle != null ){
					outStyle = JSON.parse( JSON.stringify( outStyle ) );
					$.each( outStyle, function( key, vale ){
						$element.css( key, value );
					});
				}
				
			},
			
			pushTextAreaStyle : function( $element, styleJson, inStyle ){
	 			styleJson = styleJson == undefined ? { } : styleJson; 
				if( inStyle != null ){
					inStyle = JSON.parse( JSON.stringify( inStyle ) );
					$.each( inStyle, function( key, vale ){
						$element.css( key, value );
					});
				}
			},			
	}
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		Class 지정을 위한 객체 리터럴
	 * 		※테마 설정 존재 Pudd.THEMA
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 * 			1) pushDivClass : 선택자( DIV )를 에 대한 class 지정
	 * 			2) pushInputClass : TEXTAREA에 대한 class 지정
	 * 			3) pushToolTipDivClass : 툴팁( DIV )에 대한 class 지정
	 * 			4) pushInfoDivClass : 상태( DIV )에 대한 class 지정
	 * 			5) pushSvgClass : SVG에 대한 class 지정
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name : pushDivClass, pushInputClass, pushToolTipDivClass, pushInfoDivClass, pushSvgClass
	 * @param $
	 * 			#TODO 모듈명 NAMESPACE를 IMPORT해야 한다.
	 */
	var puddTextAreaClass = {
			pushDivClass : function( $element, classJson, type, outClass ){
				$element.addClass( 'PUDD-UI-textArea' );
				//테마 설정
				$element.addClass( PuddManager.getGlobalVariable( 'THEMA' ) );
				
				//푸딩 설정
				$element.addClass( PuddManager.getGlobalVariable( 'PRETEXT' ) );
				
				if( classJson.state != undefined ){
					var type = classJson.state.item == undefined ? '' : classJson.state.item.toUpperCase( );
						
					switch( type ){
						case 'SUCCESS':
							$element.addClass( 'Success' );
							break;
						case 'ERROR':
							$element.addClass( 'Error' );
							break;
						case 'WARNING':
							$element.addClass( 'Warning' );
							break;
						default :
							break;
					}
				}
				
				if( outClass != null ){
					$element.addClass( outClass );
				}
				
			},
			
			pushTextAreaClass : function( $element, selectClass, inClass ){
				$element.addClass( selectClass );
				if( inClass != null ){
					$element.addClass( inClass );
				}
			},
			
			pushSpanClass : function( $element ){
				$element.addClass( 'hintText' ); 
			},
			
			pushInfoDivClass : function( $element ){
				$element.addClass( 'informationText animated03s fadeInRight' );
			},
			
	}
	
	
		
	/**
	 * <pre>
	 * 1. 개요
	 * 		Attribute 지정을 위한 객체 리터럴
	 * 		※_CreateInputId 함수※
	 * 		   - TEXTAREA과 TOOLTIP을 위해 아이디를 생성한다.
	 * 		   - *TODO 생성규칙은 다음과 같으나 아이디 생성 정책을 확정하면 수정해야한다.
	 * 		     ( X ) 다음) 모듈이름 + _ + 태그명 + _ + 아이디( selector id ) + _ + 인덱스( 숫자 ) 2017.09.17 수정
	 * 	 		 다음) 아이디( selector id )+ _ + 태그명
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 * 			1) pushDivAttribute : 선택자( DIV )를 위한 어트리뷰트 지정
	 * 			2) pushToolTipAttribute : 툴팁을 위한 어트리뷰트 지정
	 * 			3) pushInputAttribute : TEXTAREA을 위한 어트리뷰트 지정
	 * 			4) pushSvgAttribute : SVG을 위한 어트리뷰트 지정
	 * 			5) pushStatePathAttribute : SVG PATH을 위한 어트리뷰트 지정
	 * 			6) pushRectAttribute : SVG RECT을 위한 어트리뷰트 지정	
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name : pushDivAttribute, pushToolTipAttribute, pushInputAttribute, pushSvgAttribute, pushStatePathAttribute, pushRectAttribute
	 * @param $
	 * 			#TODO 모듈명 NAMESPACE를 IMPORT해야 한다.
	 */
	var puddTextAreaAttribute = {
			
			pushDivAttribute : function( $element, attrJson, id ){
				attrJson = attrJson == undefined ? { } : attrJson;
				attrJson = CommonUtil.castToJSONObject( attrJson );
				$element.attr( 'id', CommonUtil.createId( id, 'div' ) );
			},
			
			pushTextAreaAttribute : function( $element, attrJson, id ){
				attrJson = attrJson == undefined ? { } : attrJson;
				attrJson = CommonUtil.castToJSONObject( attrJson );
				
				//id 생성
				if( id != undefined && id !== ''){
					$element.attr( 'id', id );
				}
				
				//readonly 생성
				if( attrJson.readonly != undefined && attrJson.readonly === true ){
					$element.prop( 'readonly', true );
				}
				
				//disable 생성
				if( attrJson.disabled != undefined && attrJson.disabled === true ){
					$element.prop( 'disabled', true );
				}
				
				//사용자 지정 value( 값 ) 매핑
				if( attrJson.value != undefined ){
					$element.val( attrJson.value );
				}
				
			},
	}
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		TEXTAREA 이벤트 함수
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  이벤트 배열을 멤버변수로 지정한다.
	 *			2)  
	 *			3)  
	 * 3. 입력 Data : eventArrayJson  
	 * 4. 출력 Data :    
	 * @Method Name : TextAreaEvent
	 * @param $
	 */
	function TextAreaEvent( event, optJson ){
		this.event = event;
		this.option = optJson;
	}
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		TEXTAREA 이벤트 생성 및 바인딩
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  멤버변수인 이벤트 배열을 탐색하며 이벤트를 지정한다.
	 *			2)  
	 *			3)  
	 * 3. 입력 Data :   
	 * 4. 출력 Data :    
	 * @Method Name : TextAreaEvent.createEvent
	 * @param $
	 */
	TextAreaEvent.prototype.createEvent= function( ){
		var that = this;
		$.each( this.event, function( index, item ){
			var eventName = item.eventName;
			switch( eventName ){
				case 'hintFocusEvent' :
					that.hintFocusEvent( item );
					break;
				default:
					break;
			}
		});
	}
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		TEXTAREA 툴팁 마우스 오버 이벤트
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  텍스트아레아 포커슨 온/오프 이벤트로 힌트텍스트 보여주기 여부 
	 *			2)  
	 * 3. 입력 Data : event{ divId, textAreaId } 
	 * 4. 출력 Data :    
	 * @Method Name : TextAreaEvent.hintFocusEvent
	 * @param $
	 */
	TextAreaEvent.prototype.hintFocusEvent = function( event ){
		//jquery 셀렉터 변수 할당
		var $DIV = $( '#' + event.divId );
		var $TEXTAREA = $( '#' + event.textAreaId );
		
		//textarea에 값에 따라 hintText 유/무
		$TEXTAREA.focusin( function( ){  
			console.log( 'in' );
			$( this ).siblings( '.hintText' ).hide( );
		}).focusout( function( ){
			console.log( 'out' );
			var thisValue = $( this ).val( );
			if( thisValue == "" ){
				console.log( 'not write' );
				$( this ).siblings( '.hintText' ).show( );
			};
		});
	}
	
	
	

})(jQuery);
