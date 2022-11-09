/**
* @projectDescription PUDD( 가칭 ) Component RADIO BUTTON
*
* @author 임헌용 ( 더존비즈온 UC개발본부 UC개발센터 UC개발1팀 )
* @version PUDD 0.0.0 ( 개발 버전 )
* @RevisionHistory
* 		- 2017.10.12 최초 작성( 임헌용 )
*/

(function ($) {
 
	
	/* 싱글 RADIO 기능을 위한 Jquery 확장 함수 */
	$.fn.PuddRadio = function( opt ){
		$.each( $( this ), function(index, item){
			if( $( this ).attr( 'id' ) == undefined || $( this ).attr( 'id' ) == ''){
				$( this ).attr( 'id' , PuddManager.getGlobalVariable( 'fnRandomString' ) );
			}
				
			var parameter = { 
					id : $( this ).attr( 'id' ),
					class : $( this ).attr( 'class' ) || '',
					option : opt || { },
			};
			
			var puddRadio = new PuddRadio( parameter );
			//체크박스 생성
			PuddManager.makeComponent( $( this ), puddRadio );
		});
		
	};
	
	/* 멀티 RADIO 기능을 위한 Jquery 확장 함수 */
	$.fn.PuddGroupRadio = function( opt ){
		if( $( this ).attr( 'id' ) == undefined ||  $( this ).attr( 'id' ) == ''){
			$( this ).attr( 'id' , PuddManager.getGlobalVariable( 'fnRandomString' ) );
		}
			
		var _id = $( this ).attr( 'id' );
		var _class = $( this ).attr( 'class' ) || '';
		var _selector = $( this );
		var _opt = opt || {};
		var groupDIV = $( this );
		
		//하위 요소 삭제
		$( this ).empty( );
		//스타일 초기화
		$( this ).removeAttr( 'style' );
		$( this ).removeClass( );
		//이벤트 초기화
		$( this ).off();
		$( this ).unbind( );
		
		
		if( opt.group != undefined ){
			
			if( opt.group.item.length < 0){
				console.log('라디오 그룹 아이템을 지정하지 않았습니다.');
				return false;
			}
			//groupDIV 설정
			puddRadioClass.pushGroupDivClass( $(this), _opt );
			
			$.each( opt.group.item, function( index, item ){
					console.log( JSON.stringify( opt ) );
					//옵션 복사
					var newOpt = JSON.parse( JSON.stringify( opt ) );
					
					//그룹key 삭제
					delete newOpt.group;				
					
					console.log( 'text:' + newOpt.text +', disabled :' + newOpt.disabled );
					
					// 그룹을 가지고 체크박스 옵션을 넣어준다.
					newOpt.text = item.text || '' ;
					newOpt.value = item.value || '' ;
					newOpt.checked = item.checked || false;
					newOpt.name = opt.group.groupName || '';
					newOpt.disabled = item.disabled || false;
					
					// div 생성
					var newDIV = document.createElement( "DIV" );
					$( newDIV ).attr( 'id' , PuddManager.getGlobalVariable( 'fnRandomString' ) );
					$( newDIV ).attr('class', _class + '_' + index );
					
					// div 생성 후 TopDiv 자식으로 설정
					groupDIV.append( newDIV );
					
					var parameter = { 
							id : $( newDIV ).attr( 'id' ),
							class : $( newDIV ).attr( 'class' )|| '',
							option : newOpt || { },
					};
					
					console.log( 'text:' + newOpt.text +', disabled :' + newOpt.disabled );
					// 라디오 생성
					var puddRadio = new PuddRadio( parameter );
					// 라디오 생성
					PuddManager.makeComponent( $( newDIV ), puddRadio );
					
			});
			
		}else{
			console.log('라디오 그룹을 지정하지 않았습니다.');
		}
		
		
	};
	
	
	
	ComponentCommander.radio = function( ){ };    
    ComponentCommander.radio.prototype.setSelected = function( _json ){
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		var $top = $( '#' + $selector.attr( 'id' ) + '_div' );
		
		if( $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
			/* 그룹 체크박스 */
			if( json.index != undefined ){
				$.each( $selector.find( '.PUDD-UI-radio' ), function( index, item ){					
					if( Number( json.index ) == index ){
						$( item ).click( );
						return false;
					}			
				});							
			}
			
		}else if( $top.hasClass( 'PUDDRadio' ) ){
			/* 단일 체크박스 */
			$selector.click( );
		}
		
	};
	
	
	/* 비활성화 */
	ComponentCommander.radio.prototype.setDisabled = function( _json ){
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		var $top = $( '#' + $selector.attr( 'id' ) + '_div' );
		
		if( $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
			/* 그룹 체크박스 */
			if( json.index != undefined ){
				$.each( $selector.find( '.PUDD-UI-radio' ), function( index, item ){					
					if( Number( json.index ) == index ){
						$( item ).find( 'input' ).attr( 'disabled', 'disabled' );						
						$( item ).addClass( 'UI-Disa' );										
						$( item ).find( 'input' ).after( CommonUtil.searchSVGObject( 'RADIO_DISABLE' ) );
						
						return false;
					}			
				});							
			}
			
			
		}else if( $top.hasClass( 'PUDD-UI-radio' ) ){
			$selector.attr( 'disabled', 'disabled' );		
			$top.addClass( 'UI-Disa' );
			$top.find( 'svg' ).remove( );
			$top.find( 'input' ).after( CommonUtil.searchSVGObject( 'RADIO_DISABLE' ) );			
		}
	};
	
	/* 활성화 */
	ComponentCommander.radio.prototype.setEnabled = function( _json ){
		if( _json == undefined ){  console.error( '인자 값이 없습니다.' ); return false; }
		var json = CommonUtil.castToJSONObject( _json );
		var $selector = CommonUtil.extractSelector( _json );
		var $top = $( '#' + $selector.attr( 'id' ) + '_div' );
		
		if( $selector.hasClass( 'PUDD-SET-ChkRadi' ) ){
			/* 그룹 체크박스 */
			if( json.index != undefined ){
				$.each( $selector.find( '.PUDD-UI-radio' ), function( index, item ){					
					if( Number( json.index ) == index ){
						$( item ).find( 'input' ).removeAttr( 'disabled' );
						$( item ).removeClass( 'UI-Disa' );						
						$( item ).find( 'svg' ).remove( );
						$( item ).find( 'input' ).after( CommonUtil.searchSVGObject( 'RADIO' ) );
						
						return false;
					}			
				});							
			}
			
			
		}else if( $top.hasClass( 'PUDD-UI-radio' ) ){
			$selector.removeAttr( 'disabled' );
			$top.removeClass( 'UI-Disa' );			
			$top.find( 'svg' ).remove( );
			$top.find( 'input' ).after( CommonUtil.searchSVGObject( 'RADIO' ) );
			
		}
	};
	
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		radio 함수
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1) 초기 옵션값이 존재하면 값을 매핑하고 없다면 기본 { }을 매핑한다.
	 *			2)
	 * 3. 입력 Data :  json
	 * 4. 출력 Data :    
	 * @Method Name : DevRadio
	 * @param $
	 */
	function PuddRadio( parameter ){
		/* 개발자 옵션 */
		this.id = parameter.id;
		this.class = parameter.class;
		this.$selector = null;
		this.option = parameter.option;
		
		/* 생성할 엘리먼트 */
		this.DIV = null;
		this.INPUT = null;
		this.LABEL = null;
		
		/* 생성할 엘리먼트 선택자*/
		this.$DIV = null;
		this.$INPUT = null;
		this.$LABEL = null;
		
		/* 생성할 이벤트 */
		this.event = [ ];
		
		/* 클래스 및 스타일 추출 */
		this.inStyle = null;
		this.inClass = null;
		this.outStyle = null;
		this.outClass = null;
	}
	
	
	PuddRadio.prototype = {
		_createElement : function( tagName ){
			tagName = tagName.toUpperCase( );
				switch( tagName ){					
					case "INPUT":
						this.INPUT = document.createElement( "INPUT" );
						this.$INPUT = $( this.INPUT );
						break;
						
					case "LABEL":
						this.LABEL = document.createElement( "LABEL" );
						this.$LABEL = $( this.LABEL );
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
			this.inName = json.name || null;
            this.inOnClick = json.onclick || null;
			this.outStyle = json.topStyle || null;
			this.outClass = json.topClass || null;
			
			this._createElement( 'INPUT' );
			this._createElement( 'LABEL' );
			
		},
		
		setElementAssembly : function( ){
			this.DIV.appendChild( this.INPUT );
			
			if( this.option.disabled != undefined && this.option.disabled == true ){
				var svg = CommonUtil.searchSVGObject( 'RADIO_DISABLE' );
				this.$INPUT.after( svg );
				
			}else{
				var svg = CommonUtil.searchSVGObject( 'RADIO' );
				this.$INPUT.after( svg );
			}
			

			if( this.LABEL != null ){
				this.DIV.appendChild( this.LABEL );
				if( this.option.text != undefined ){
					var TEXT = document.createTextNode( this.option.text );
					this.LABEL.appendChild( TEXT );
				}
			}
		},
		
		setElementStyle : function( ){
			puddRadioStyle.pushDivStyle( this.$DIV, this.option, this.outStyle );
			if( this.INPUT != null ){
				puddRadioStyle.pushInputStyle( this.$INPUT, this.option, this.inStyle );
			}
		},
		
		setElementClass : function( ){
			puddRadioClass.pushDivClass( this.$DIV, this.option, this.outStyle );
			puddRadioClass.pushInputClass( this.$INPUT, this.inStyle );
		},
		
		setElementAttribute : function( ){
			puddRadioAttribute.pushDivAttribute( this.$DIV, this.option, this.id );
		
			if( this.INPUT != null){
				puddRadioAttribute.pushInputAttribute( this.$INPUT, this.option, this.id, this.inName, this.inOnClick );
			}
	
			if( this.LABEL != null ){
				puddRadioAttribute.pushLabelAttribute( this.$LABEL, this.option, this.id );
			}
		},
		
		setEvent : function( ){
			if( this.INPUT != null ){
				var multiCheck = this.option.checked == undefined ? false : this.option.checked;
				var radioEvent = {
					inputId : this.$INPUT.attr( 'id' ),
					inputName : this.$INPUT.attr( 'name' ),
					divId : this.$DIV.attr( 'id' ),
					eventName : 'RadioChecked',
				};
				this.event.push( radioEvent );
			}
			var radioEvent = new RadioEvent( this.event, this.option );
			radioEvent.createEvent( );
		}
	}


	
		
	/**
	 * <pre>
	 * 1. 개요
	 * 		Class 지정을 위한 객체 리터럴
	 * 		※테마 설정 존재 Dev.THEMA
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 * 			1) pushGroupDivClass : 그룹 Radio div 클래스 지정
	 * 			2) pushDivClass : 단일 Radio div 클래스 지정
	 * 			3) pushInputClass : Radio input 클래스 지정
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name : 
	 * @param $
	 * 			#TODO 모듈명 NAMESPACE를 IMPORT해야 한다.
	 */
	var puddRadioClass = {
		pushGroupDivClass : function( $element, classJson ){
			var group = classJson.group == undefined ? {} : classJson.group;
			$element.addClass( 'PUDD-SET-ChkRadi' );
			
			//푸딩 설정
			$element.addClass( PuddManager.getGlobalVariable( 'PRETEXT' ) );
			
			if( group.align.toUpperCase( ) === 'HORIZON'){
				$element.addClass( 'PUDD-UI-Horizon' );
			}else{ 
				$element.addClass( 'PUDD-UI-Vertical' );
			}
			
		},
		
		pushDivClass : function( $element, classJson, outClass ){
			$element.addClass( 'PUDD-UI-radio' );
			$element.addClass( PuddManager.getGlobalVariable( 'THEMA' ) );
			$element.addClass( 'PUDD-UI-ChkRadi' );
			
			//푸딩 설정
			$element.addClass( PuddManager.getGlobalVariable( 'PRETEXT' ) );
	
			if( classJson.checked == true ||  String( classJson.checked ).toUpperCase( ) === 'TRUE' ){
				$element.addClass( 'UI-ON' );
			}
			
			if( classJson.disabled == true ||   String( classJson.disabled ).toUpperCase( ) === 'TRUE' ){
				$element.addClass( 'UI-Disa' );
			}
			
			if( outClass != null ){
				$element.addClass( outClass );
			}
		},
		
		pushInputClass : function( $element, inClass ){
			$element.addClass( 'PUDDRadio' );
			if( inClass != null ){
				$element.addClass( inClass );
			}
		},
	}
	
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		스타일 지정에 대한 객체 리터럴
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1) 
	 *			2)  
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name :
	 * @param $
	 */
	var puddRadioStyle = {
	
		pushDivStyle : function( $element, styleJson, outStyle ){
			if( outStyle != null ){
				outStyle = JSON.parse( JSON.stringify( outStyle ) );
				$.each( outStyle, function( key, vale ){
					$element.css( key, value );
				});
			}
		},
		
		pushInputStyle : function( $element, styleJson, inStyle ){
 			if( inStyle != null ){
				inStyle = JSON.parse( JSON.stringify( inStyle ) );
				$.each( inStyle, function( key, vale ){
					$element.css( key, value );
				});
			}
		},
		
		pushLabelStyle : function( $element, styleJson ){

		},
		
	}
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		Attribute 지정을 위한 객체 리터럴
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 * 			1) 
	 * 			2) 
	 * 3. 입력 Data : 
	 * 4. 출력 Data : 
	 * </pre>
	 * @Method Name :
	 * @param $
	 * 			#TODO 모듈명 NAMESPACE를 IMPORT해야 한다.
	 */
	var puddRadioAttribute = {
			
		pushGroupDivAttribute : function( $element, attrJson, id ){
			attrJson = attrJson == undefined ? {} : attrJson;
			attrJson = CommonUtil.castToJSONObject( attrJson );
			$element.attr( "id", CommonUtil.createId( id, "groupDiv" ) );
		},
		
		pushDivAttribute : function( $element, attrJson, id ){
			attrJson = attrJson == undefined ? {} : attrJson;
			attrJson = CommonUtil.castToJSONObject( attrJson );
			$element.attr( "id", CommonUtil.createId( id, "div" ) );
		},
		
	
		pushInputAttribute : function( $element, attrJson, id, name, onClick ) {
			attrJson = attrJson == undefined ? {} : attrJson;
			attrJson = CommonUtil.castToJSONObject( attrJson );
			
			//id 생성
			if( id != undefined && id !== ''){
				$element.attr( "id", id );
			}
			
			//type 생성
			$element.attr( "type", "radio" );
			
			//name 생성
			if( attrJson.name != undefined && attrJson.name !== ''){
				$element.attr( "name", attrJson.name );
			}
			
			// name 생성 ( 인라인 우선 적용 )
            if ( name != undefined ){
                $element.attr( "name", name );
            }
            
            // onClick 생성
            if (attrJson.onClick != undefined ) {
                $element.attr( "onclick", onClick );
            }
			
			//value 생성
			if( attrJson.value != undefined && attrJson.value !== ''){
				$element.attr( "value", attrJson.value );
			}
			
			//checked 생성
			if( attrJson.checked != undefined && ( attrJson.checked == true || String( attrJson.checked ).toUpperCase( ) === 'TRUE' )  ){
				$element.prop( 'checked' , true );
			}
			
			//disabled 생성
			if( attrJson.disabled != undefined && ( attrJson.disabled == true || String( attrJson.disabled ).toUpperCase( ) === 'TRUE')  ){
				$element.prop( 'disabled' , true );
			}
			
			
		},
	
		pushLabelAttribute : function( $element, attrJson ){
			attrJson = attrJson == undefined ? {} : attrJson;
			attrJson = CommonUtil.castToJSONObject( attrJson );
		},
			
	}
	
	
	
	
	
	
	

	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		Radio 이벤트 함수
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  이벤트 배열을 멤버변수로 지정한다.
	 *			2)  
	 *			3)  
	 * 3. 입력 Data : eventArrayJson  
	 * 4. 출력 Data :    
	 * @Method Name : InputEvent
	 * @param $
	 */
	function RadioEvent( eventArrayJson, optJson ){
		this._eventArrayJson = eventArrayJson;
		this._optionJson = optJson;
	}
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		Radio 이벤트 생성 및 바인딩
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  멤버변수인 이벤트 배열을 탐색하며 이벤트를 지정한다.
	 *			2)  
	 *			3)  
	 * 3. 입력 Data :   
	 * 4. 출력 Data :    
	 * @Method Name : RadioEvent.createEvent
	 * @param $
	 */
	RadioEvent.prototype.createEvent= function( ){
		var thisObject = this;
		$.each( this._eventArrayJson, function( index, item ){
			var eventName = item.eventName;
			switch( eventName ){
				case "RadioChecked":
					thisObject.RadioChecked( item );
					break;
				default:
					break;
			}
		});
	}
	
	
	/**
	 * <pre>
	 * 1. 개요
	 * 		Radio 체크 이벤트
	 * 2. 처리내용
	 * 		- BizLogic 처리 :
	 *			1)  
	 *			2)  
	 * 3. 입력 Data : eventJson{ divId, inputId, tooltipId, tooltipMsg } 
	 * 4. 출력 Data :    
	 * @Method Name : RadioEvent.CheCheked
	 * @param $
	 */
	RadioEvent.prototype.RadioChecked = function( eventJson ){
		
		var $INPUT = $( "#" + eventJson.inputId );
		var name = $( "#" + eventJson.inputName );
		var $DIV = $( "#" + eventJson.divId );
		var multiCheck = eventJson.multiCheck ;
		var multiCheckCount = eventJson.multiCheckCount;
		
		$('.PUDD-UI-radio').off('click');
		
		// $('input[type="Radio"][name='+ name +']').click(function(){
		$('.PUDD-UI-radio').on('click',function(){
			var $CHKDIV = $( this );
			var boxName = $( this ).children(' input ').attr('name') || '';
			var boxId = $( this ).children(' input ').attr('id') || '';
			var $Condition = null;
			
	        //클릭 이벤트 발생한 요소가 선택 상태일 경우
	        //체크된 요소 확인후 복수개 선택되있을 경우 체크 해제
			if( $( this ).hasClass( 'UI-Disa' ) ){
				return false;
			}
			
			if( boxName != '' ){
				$Condition = $( 'input[type="radio"][name='+ boxName +']' );
			}else if( boxId != ''){
				$Condition = $(' input[type="radio"][id='+ boxId +']' );
			}
			
			/* 단일 체크 */
			if( $CHKDIV.hasClass( 'UI-ON' ) ){
				console.log('false');
				$Condition.prop( 'checked' , false);
				$CHKDIV.removeClass( 'UI-ON' );
				
			}else{
				$Condition.prop( 'checked', false );
				$Condition.parent( ).removeClass( 'UI-ON' );
				
				$Condition.prop( 'checked' , true);
				$CHKDIV.addClass( 'UI-ON' );
				
				console.log('true');
			}
		
	    });
	}
	


})(jQuery);