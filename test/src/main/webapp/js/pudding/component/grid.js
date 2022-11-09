/**
* @projectDescription PUDD( 가칭 ) Component Grid
*
* @author 임헌용 ( 더존비즈온 UC개발본부 UC개발센터 UC개발1팀 )
* @version PUDD 0.0.0 ( 개발 버전 )
* @RevisionHistory
* 		- 2017.10.18 최초 작성( 임헌용 )
* 		- 프레임워크 테스트 용
*/

(function ($) {
 
	
	/* 싱글 TEST 기능을 위한 Jquery 확장 함수 */
	$.fn.PuddGrid = function( opt ){
		$.each( $( this ), function(index, item){
			if( $( this ).attr( 'id' ) == undefined || $( this ).attr( 'id' ) == ''){
				$( this ).attr( 'id' , DEVManager.getGlobalVariable( 'fnRandomString' ) );
			}
			
			var parameter = { 
					id : $( this ).attr( 'id' ),
					class : $( this ).attr( 'class' ) || '',
					option : _opt || { },					
			};
		
			var puddGrid = new PuddGrid( parameter );
			DEVManager.makeComponent( $( this ), puddGrid );
		});
	};
	
	
	function PuddGrid( parameter ){		
		/* 개발자 옵션 */
		this.id = parameter.id;
		this.class = parameter.class;
		this.$selector = null;
		this.option = parameter.option;
		this.type = parameter.type;
		/* 생성할 엘리먼트 */
		this.DIV = null;
		this.$DIV = null;
		/* 생성할 이벤트 */
		this.event = [ ];
	}
	
	
	PuddGrid.prototype = {					
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
						
		},
		
		_drawHeader : function( ){
			//컬럼 가져오기
			var columns = this.option.columns || [ ];
			//총 행의 수
			var rowCount = columns.length;
			
			//병합 위치
			
		}, 
		
		setElementAssembly : function( ){
			
		},
		
		setElementStyle : function( ){
						
		},
		setElementClass : function( ){
						
		},
		
		setElementAttribute : function( ){
						
		},
		
		setEvent : function( ){
						
		}		
	}
	
	
	var painter = {
		drawDIV : function( ){
			return document.createElement( 'DIV' );
		},
		drawTABLE : function( ){
			return document.createElement( 'TABLE' );
		},
		drawCOLGROUP : function( ){
			return document.createElement( 'COLGROUP' );
		},
		drawCOL : function( ){
			return document.createElement( 'COL' );
		},
		drawTHEAD : function( ){
			return document.createElement( 'THEAD' );
		},
		drawTR : function( ){
			return document.createElement( 'TR' );
		},
		drawTH : function( ){
			return document.createElement( 'TH' );
		},
		drawTBODY : function( ){
			return document.createElement( 'TBODY' );
		}	
	}
		

})(jQuery);