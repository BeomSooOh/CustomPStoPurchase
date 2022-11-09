
/*	[포커스 이동] 입력된 ids에 맞게 포커스 이동
 * -------------------------------------------------*/
function focus_fnTextFocusMove(ids, action, savedIdx){
	var id = $(':focus').attr('id');
	if(savedIdx){
		id = ids[savedIdx];
	}
	
	var idx = ids.indexOf(id);
	var orginIdx = idx;
	var length = ids.length;
	
	if(!id){
		return;
	}
	do{
		/* 인덱스 루프 인크리징 사용 */
		idx = ( idx + 1 ) % length;
		
		/* unvisible객체 필터링 */
		if( !$('#' + ids[idx] + ':visible').length ){
			continue;
		}
		
		/* 포커스 이동 수행 */
		$('#' + ids[idx]).focus();
		
		FOCUS_FOCUS_ELEM_IDS = ids;
		FOCUS_FOCUS_ELEM_IDX = idx;
        
		event.stopPropagation ? event.stopPropagation() : (event.cancelBubble=true);

		return ;
		
	}while(idx != orginIdx);
	
	/* 모든 입력 완료시 함수 호출 */
	if(typeof(action) === 'function'){
		action();
	}
}


/*	[포커스 이동] 입력된 ids에 맞게 포커스 이동
 * -------------------------------------------------*/
function focus_fnTextFocusMoveForElem(elem, action, savedIdx){
	var id = $(':focus').attr('id');
	if(savedIdx){
		id = elem[savedIdx].id;
	}
	
	var idx = 0;
	for(var i=0;i<elem.length;i++){
		if(elem.id == id){
			idx = i;
			break;
		}
	}
	var orginIdx = idx;
	var length = elem.length;
	
	if(!id){
		return;
	}
	do{
		/* 인덱스 루프 인크리징 사용 */
		idx = ( idx + 1 ) % length;
		
		/* unvisible객체 필터링 */
		if( !$('#' + elem[idx].id + ':visible').length ){
			continue;
		}
		
		/* 포커스 이동 수행 */
		if( !$('#' + elem[idx].id).val() ){
			if(elem[orginIdx].pop && !$('#' + elem[orginIdx].id).val()){
				return;
			}
			$('#' + elem[idx].id).focus();
			
			FOCUS_FOCUS_ELEM_IDS = elem;
			FOCUS_FOCUS_ELEM_IDX = idx;
			return ;
		}
	}while(idx != orginIdx);
	
	/* 모든 입력 완료시 함수 호출 */
	if(typeof(action) === 'function'){
		action();
	}
}

var FOCUS_FOCUS_ELEM_IDX = 0;
var FOCUS_FOCUS_ELEM_IDS = [];
function focus_fnSetNextFocus(){
	focus_fnTextFocusMove(FOCUS_FOCUS_ELEM_IDS, '', FOCUS_FOCUS_ELEM_IDX);
}

/*	[포커스 이동] 입력된 ids 엘리먼트들에게 포커스 검색 이벤트 부여
 * -------------------------------------------------*/
function focus_fnSetFocusEvent(ids, action){
	
	for(var i = 0; i < ids.length; i++ ){
		// $('#' + ids[i]).unbind('keydown');
		$('#'+ ids[i]).bind ('keydown', function (event) {
            if (event.keyCode === 13) {               
                focus_fnTextFocusMove(ids, action);
            }
        });
	}
}


/*	[포커스 이동] 입력된 ids 엘리먼트들에게 포커스 검색 이벤트 부여
 * -------------------------------------------------*/
function focus_fnSetFocusEventForElem(elem, action){
	for(var i = 0; i < elem.length; i++ ){
		$('#'+ elem[i].id).bind ('keydown', function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = false;
                
                focus_fnTextFocusMoveForElem(elem, action);
            }
        });
	}
}



/*=========================================================
	[focus v2.0] 
=========================================================*/

/*	[focus v2.0] 포커스 오브젝트 
----------------------------------------------------*/
var focusObj = null;
function FocusObj(){
	var elemSet;
	var idx = 0;
	var length = 0;
	var bubbleId = '';
	return {
		setStartId : function(id) {
			bubbleId = id;
		}		
		, getStartId : function() {
			return bubbleId;
		}
		, initIdx : function(){
			idx = 0;
			return idx;
		}
		, increaseIdx : function(){
			idx =  (idx + 1) >= length ? length -1 : idx;
			return idx;
		}
		, setElemSet : function(data){
			elemSet = data;
			length = data.length;
			return elemSet;
		}                                                                                                                                                                                                                                                                                                                                                                                                                          
		, getElemSet : function(data){
			return elemSet;
		}
		, getIdx : function(){
			return idx;
		}
		, setIdx : function(value){
			idx = value;
		}
		, getLength : function(){
			return length;
		}
		, getNext : function(){
			// idx = ( idx + 1 ) % length;
			return elemSet[idx];
		}
		, getNextById : function(id){
			for(var i=0; i < length; i++){
				if(elemSet[i].id == id){
					idx = i;
				}
			}
			elemCnt = 0;
			do{
				idx = (idx + 1) >= length ? length -1 : (idx + 1);
				if(elemSet[idx].type == 'radio'){
					elemCnt = $(':radio[name="' +elemSet[idx].name+ '"]:visible').eq(0).length;
				}else{
					elemCnt = $('#' + elemSet[idx].id+':visible').length;
				}
			}while(elemCnt == 0);
			
			return elemSet[idx];
		}
		, getFindById : function(id){
			for(var i=0; i < length; i++){
				if((elemSet[i].type == 'radio') && (elemSet[i].name == id)){
					return elemSet[i];
				}
				if((elemSet[i].type != 'radio') && ( elemSet[i].id == id) ){
					return elemSet[i];
				}
			}
		}
	};
}

/*	[focus v2.0] 포커스 이벤트 설정
 ----------------------------------------------------*/
function focus_fnSetFocusAction(data){
	/* 포커스 오브젝트 생성 */
	var saveIdx = 0;
	if(focusObj){
		saveIdx = focusObj.getIdx();
	}
	focusObj = FocusObj();
	focusObj.setElemSet(data);
	focusObj.initIdx();
	if(saveIdx){
		focusObj.setIdx(saveIdx);
	}
	
	for(var i = 0; i < data.length; i++ ){
		var item = data[i];
		if(item.type == 'radio'){
			$(':radio[name="' +item.name+ '"]').bind('keydown', function (event) {
				focusObj.setStartId( $(this).attr('id' ) );
				if (event.keyCode === 13) {
	                event.returnValue = false;
	                event.cancelBubble = false;
	                focus_fnMoveFocus($(this).attr('name'), false);
	            }
	        });
		}else {
			$('#'+ item.id).bind ('keydown', function (event) {
				focusObj.setStartId( $(this).attr('id' ) );
	            if (event.keyCode === 13) {
	                event.returnValue = false;
	                event.cancelBubble = false;
	                focus_fnMoveFocus($(this).attr('id'), false);
	            }
	        });
		}
		
		if(item.isPrimary && ( item.type == 'code' )){
			$('#' + item.id).attr('placeholder', (codeHelperLngpack || '') + ' [F2, Enter]');
		}
	}
}

/*	[focus v2.0] 포커스 이벤트
----------------------------------------------------*/
function focus_fnMoveFocus(id, isCallback){
	var elemSet = focusObj.getFindById(id);
	if(isCallback || (!elemSet.isPrimary)){
		/* 추가 이벤트 콜백, 필수 코드가 아닌경우 */
		focus_fnDoMove(id);
	}else{
		var value = '';
		if(elemSet.type == 'code'){
			value = $('#' + elemSet.keyId).val();
		}
		else if(elemSet.type == 'date'){
			value = $('#' + elemSet.id).val().replace(/[^(0-9)]/gi, '');
		}
		else if(elemSet.type == 'text'){
			value = $('#' + elemSet.id).val();
		}
		else if(elemSet.type == 'radio'){
			value = $(':radio[name="' +id+ '"]:checked').val();
		}
		
		if( value ){
			/* 필수 코드이면서 텍스트인 경우 */
			focus_fnDoMove(id);
		} else if(elemSet.type == 'code' && (elemSet.code)){
			fnOpenCommonCodePop('Y', elemSet.code);
		} 
	}
}

/*	[focus v2.0] 포커스 이동
----------------------------------------------------*/
function focus_fnDoMove(id){
	var elemSet = null;
	if(id){
		elemSet = focusObj.getNextById(id);
	}else{
		elemSet = focusObj.getNext();
	}		
	if(elemSet.type == 'radio'){
		$(':radio[name="' +elemSet.name+ '"]').eq(0).focus();
	}else{
		$('#' + elemSet.id ).focus();
	}
}

/*	[focus v2.0] 필수 입력 선택
----------------------------------------------------*/
function focus_fnSetprimary(id, isPrimary){
	var set = focusObj.getElemSet();
	var result = [];
	for(var i = 0; i < set.length; i++){
		var item = set[i];
		if(item.id == id && id != 'txtListNoCash'){
			var placeHolder = isPrimary ? (codeHelperLngpack || '') + ' [F2, Enter]' : (codeHelperLngpack || '') + ' [F2]' ;
			placeHolder = item.type == 'code' ? placeHolder : 'ex. 회식비, 교통비 등'; 
			placeHolder = item.type == 'date' ? '____-__-__' : placeHolder ; 
			
			$('#' + id).attr('placeHolder', placeHolder);
			item.isPrimary = isPrimary;
		}
		result.push(item);
	}
	focusObj.setElemSet(result);
}

