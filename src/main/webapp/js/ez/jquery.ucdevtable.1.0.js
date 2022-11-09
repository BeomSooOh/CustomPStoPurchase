/* 
 * =======================================================================================================================================
 * AC TABLE PLUG IN - 2017.02.08 Account Part dev. team  
 * 참고사항 :파라메터, 그리드 Headerjson 필수, 생성할 위치의 id 필수, 테이블타입필수, 높이(선택), 백그라운드 이미지(선택)
 * 개발 그리드 테이블 사용할 jsp 파일에 해당 스크립트를 링크하여 사용합니다.
 * =======================================================================================================================================
 */

(function ($) {
	/* UCTABLE 포커스 JSON ARRARY */
	groupClassId = '';
	groupClass = '';
	
	focusJsonList = {
			//json헤더 json Array 타입으로 등록해야한다.			
			//arrfocusKey는 테이블간 관계를 의미한다.
			arrfocusKey : [{key : '', linkeInfo : [{linkTableName : '', autoCreateRow : '', linkTableType : '', linkParentElementId: '', linkJsonData:'', focusYN : '',tableRowNumVariableName: ''}]}]
	};
	
    var p = {
        drawType1: function (pHeaderJSONList, pLocationId, pFirstAddRowYN ,pTableType, pTableHeight, pBackgroundYN) {
            try {
                var firstTopDiv = document.createElement("DIV");
                var secTopDiv = document.createElement("DIV");
                              
                p.setAttribute(firstTopDiv, 'id', pLocationId);
                p.setAttribute(secTopDiv, 'class', 'cus_ta');

                /* 조립 */
                firstTopDiv.appendChild(secTopDiv);

                var roundTable = document.createElement("TABLE");
                var roundTR = document.createElement("TR");
                var roundTD = document.createElement("TD");

                p.setAttribute(roundTD, 'class', 'p0 brn posi_re');
                p.setAttribute(roundTD, 'width', '*');
                p.setAttribute(roundTD, 'valign', 'top');

                /* 조립 */
                secTopDiv.appendChild(roundTable);
                roundTable.appendChild(roundTR);
                roundTR.appendChild(roundTD);

                /* SCROLL HEADER */
                var scrollSpanHeader = document.createElement("SPAN");
                p.setAttribute(scrollSpanHeader, 'class', 'scy_head2');

                /* 조립 */
                roundTD.appendChild(scrollSpanHeader);

                /* RIGHT HEADER */
                var rightDivHeader = document.createElement("DIV");
                p.setAttribute(rightDivHeader, 'class', 'cus_ta ovh mr17 rightHeader');

                var rightTableHeader = document.createElement("TABLE");
                p.setAttribute(rightTableHeader, 'id', pLocationId+'_TH');
                var rightTRHeader = document.createElement("TR");

                //테이블 헤더 그리기
                $.each(pHeaderJSONList, function (index, item) {
                    var nTH = document.createElement("TH");
                    $(nTH).css("width", item.width);
                    $(nTH).html(item.titleName);
                    p.setAttribute(nTH, 'class', item.displayClass);
                    rightTRHeader.appendChild(nTH);
                });
                /* 조립 */
                rightDivHeader.appendChild(rightTableHeader);
                rightTableHeader.appendChild(rightTRHeader);

                /* 조립 */
                roundTD.appendChild(rightDivHeader);

                /* RIGHT CONTENTS */
                var rightDivContents = document.createElement("DIV");
                $(rightDivContents).css('height', ( pTableHeight ||'162px'));
                p.setAttribute(rightDivContents, 'class', 'cus_ta scroll_fix rightContents');
                p.setAttribute(rightDivContents, 'onScroll', "table1Scroll("+pLocationId+")");

                var rightTableContents = document.createElement("TABLE");
                p.setAttribute(rightTableContents, 'id', pLocationId + '_TRDATA');
                var rightTRContnets = document.createElement("TR");

                //행추가
                if(pFirstAddRowYN ==='Y'){
                	p.addRow(pLocationId, pHeaderJSONList, rightTRContnets);
                }
                /* 조립 */
                
                roundTD.appendChild(rightDivContents);        
                if(pFirstAddRowYN ==='Y'){
                	rightTableContents.appendChild(rightTRContnets);
                }
                rightDivContents.appendChild(rightTableContents);

                /* 최종 조립 */
                var elementLocation = document.getElementById(pLocationId);
                elementLocation.appendChild(firstTopDiv);
                return;
            } catch (e) {
                console.log(e);
            }
        },
        drawType2: function (pHeaderJSONList, pLocationId, pFirstAddRowYN, pTableType, pTableHeight, pBackgroundYN) {
            try {
                //테이블 헤더그리기
                var firstTopDiv = document.createElement("DIV");
                var secTopDiv = document.createElement("DIV");

                //p.setAttribute(firstTopDiv, 'class', 'table2');
                p.setAttribute(firstTopDiv, 'id', pLocationId);
                p.setAttribute(secTopDiv, 'class', 'cus_ta');

                /* 조립 */
                firstTopDiv.appendChild(secTopDiv);

                var roundTable = document.createElement("TABLE");
                var roundTR = document.createElement("TR");

                /* LEFT FIX ZONE */
                var roundFixTD = document.createElement("TD");

                p.setAttribute(roundFixTD, 'class', 'p0 brn scbg');
                p.setAttribute(roundFixTD, 'width', '68px');
                p.setAttribute(roundFixTD, 'valign', 'top');

                /* LEFT HEADER(FIXED) */
                var leftHeaderDiv = document.createElement("DIV");
                p.setAttribute(leftHeaderDiv, 'class', 'cus_ta ovh leftHeader');

                var leftHeaderTable = document.createElement("TABLE");
                p.setAttribute(leftHeaderTable, 'id', pLocationId+'_LEFT_TH');
                var leftHeaderTR = document.createElement("TR");
                var leftHeaderTH1 = document.createElement("TH");
                $(leftHeaderTH1).html('NO');

                var leftHeaderTH2 = document.createElement("TH");
                p.setAttribute(leftHeaderTH2, 'class', 'p0');
                $(leftHeaderTH2).css('width', '34px');

                var leftHeaderInput = document.createElement("INPUT");
                p.setAttribute(leftHeaderInput, 'type', 'checkbox');
                p.setAttribute(leftHeaderInput, 'name', pLocationId + 'Chk');
                p.setAttribute(leftHeaderInput, 'onclick','fnCheck(this)');
                
                p.setAttribute(leftHeaderInput, 'id', pLocationId + '_checkAll'); //아이디 동적 수정 필요

                var leftHeaderLable = document.createElement("LABEL");
                p.setAttribute(leftHeaderLable, 'for', pLocationId + '_checkAll');
                //$(leftHeaderLable).style('margin-left','-14px', 'important');
                leftHeaderLable.style.setProperty('margin-left','-14px', 'important');
              
                /* 조립 */
                leftHeaderDiv.appendChild(leftHeaderTable);
                leftHeaderTable.appendChild(leftHeaderTR);
                leftHeaderTR.appendChild(leftHeaderTH1);
                leftHeaderTR.appendChild(leftHeaderTH2);
                leftHeaderTH2.appendChild(leftHeaderInput);
                leftHeaderTH2.appendChild(leftHeaderLable);

                /* LEFT CONTENTS(FIXED) */
                var leftContentDiv = document.createElement("DIV");
                p.setAttribute(leftContentDiv, 'class', 'cus_ta ovh leftContents scbg');
                p.setAttribute(leftContentDiv, 'onmousewheel', 'onmousewheel()');
                p.setAttribute(leftContentDiv, 'onScroll', 'table2Scroll('+ pLocationId +')');
                $(leftContentDiv).css('height', '145px');

                var leftContentTable = document.createElement("TABLE");
                p.setAttribute(leftContentTable, 'id', pLocationId + "_TRDATA" + '_FIX'); // 아이디 동적 수정 필요          
                
                if(pFirstAddRowYN === 'Y'){
                	p.addFixRow('2', pLocationId, leftContentTable);
                }
                
                /* 조립 */
                leftContentDiv.appendChild(leftContentTable);

                /* 조립 */
                roundFixTD.appendChild(leftHeaderDiv);
                roundFixTD.appendChild(leftContentDiv);

                /* RIGHT CONTENTS ZONE */
                var roundMoveTD = document.createElement("TD");
                p.setAttribute(roundMoveTD, 'class', 'p0 brn posi_re');
                p.setAttribute(roundMoveTD, 'width', '*');
                p.setAttribute(roundMoveTD, 'valign', 'top');

                /* SCROLL HEADER */
                var scrollHeader = document.createElement("SPAN");
                p.setAttribute(scrollHeader, 'class', 'scy_head1');

                /* RIGHT HEADER */
                var rightHeader = document.createElement("DIV");
                p.setAttribute(rightHeader, 'class', 'cus_ta ovh mr17 rightHeader');

                var rightHeaderTable = document.createElement("TABLE");
                p.setAttribute(rightHeaderTable, 'id', pLocationId+'_RIGHT_TH');
                var rightTRHeader = document.createElement("TR");

                //테이블 헤더 그리기
                $.each(pHeaderJSONList, function (index, item) {
                    var nTH = document.createElement("TH");
                    $(nTH).css("width", item.width);
                    $(nTH).html(item.titleName);              
                    p.setAttribute(nTH, 'class', item.displayClass);
                    rightTRHeader.appendChild(nTH);
                });
                rightHeaderTable.appendChild(rightTRHeader);
                rightHeader.appendChild(rightHeaderTable);
                roundMoveTD.appendChild(rightHeader);


                var rightContentDiv = document.createElement("DIV");
                //옵션값 받기
                if (pBackgroundYN === 'Y') { //이미지
                    p.setAttribute(rightContentDiv, 'class', 'cus_ta scroll_fix rightContents scbg_img');
                }
                else {
                    p.setAttribute(rightContentDiv, 'class', 'cus_ta scroll_fix rightContents scbg_non_img');
                }
                p.setAttribute(rightContentDiv, 'onScroll', 'table2Scroll('+ pLocationId +')');
                $(rightContentDiv).css('height', (pTableHeight || '162'));

                var rightContentTable = document.createElement("TABLE");
                p.setAttribute(rightContentTable, 'id', pLocationId + '_TRDATA');
                var rightTRContnets = document.createElement("TR");
                p.setAttribute(rightTRContnets, 'class', 'lineOn onSel');

                //행추가
                if(pFirstAddRowYN === 'Y'){
                	p.addRow(pLocationId,pHeaderJSONList, rightTRContnets);
                }
                
                /* 조립 */
                rightContentDiv.appendChild(rightContentTable);
                if(pFirstAddRowYN === 'Y'){
                	rightContentTable.appendChild(rightTRContnets);
                }
                roundMoveTD.appendChild(scrollHeader);
                roundMoveTD.appendChild(rightHeader);
                roundMoveTD.appendChild(rightContentDiv);

                secTopDiv.appendChild(roundTable);
                roundTable.appendChild(roundTR);
                roundTR.appendChild(roundFixTD);
                roundTR.appendChild(roundMoveTD);

                /* 최종 조립 */
                var elementLocation = document.getElementById(pLocationId);
                elementLocation.appendChild(firstTopDiv);
                return;

            } catch (e) {
                console.log(e);
            }
        },
        //코드 도움창1
        drawCodeType1 : function (pHeaderJSONList, pLocationId ,pTableType, pTableHeight, pBackgroundYN) {
        	try {
                var firstTopDiv = document.createElement("DIV");
                var secTopDiv = document.createElement("DIV");

                p.setAttribute(firstTopDiv, 'class', 'searchTable mt20');
                p.setAttribute(secTopDiv, 'class', 'cus_ta');

                /* 조립 */
                firstTopDiv.appendChild(secTopDiv);

                var roundTable = document.createElement("TABLE");
                var roundTR = document.createElement("TR");
                var roundTD = document.createElement("TD");

                p.setAttribute(roundTD, 'class', 'p0 brn posi_re');
                p.setAttribute(roundTD, 'width', '*');                
                p.setAttribute(roundTD, 'valign', 'top');

                /* 조립 */
                secTopDiv.appendChild(roundTable);
                roundTable.appendChild(roundTR);
                roundTR.appendChild(roundTD);

                /* SCROLL HEADER */
                var scrollSpanHeader = document.createElement("SPAN");
                p.setAttribute(scrollSpanHeader, 'class', 'scy_head1');

                /* 조립 */
                roundTD.appendChild(scrollSpanHeader);

                /* RIGHT HEADER */
                var rightDivHeader = document.createElement("DIV");
                p.setAttribute(rightDivHeader, 'class', 'cus_ta ovh mr17 rightHeader');

                var rightTableHeader = document.createElement("TABLE");
                var rightTRHeader = document.createElement("TR");

                //테이블 헤더 그리기
                $.each(pHeaderJSONList, function (index, item) {
                    var nTH = document.createElement("TH");
                    $(nTH).css("width", item.width);
                    $(nTH).html(item.titleName);
                    if (item.displayClass === 'loseSight') {
                        $(nTH).css("display", 'none');
                    }
                    p.setAttribute(nTH, 'class', item.displayClass);
                    rightTRHeader.appendChild(nTH);
                });
                /* 조립 */
                rightDivHeader.appendChild(rightTableHeader);
                rightTableHeader.appendChild(rightTRHeader);

                /* 조립 */
                roundTD.appendChild(rightDivHeader);

                /* RIGHT CONTENTS */
                var rightDivContents = document.createElement("DIV");
                $(rightDivContents).css('height', pTableHeight || '346px');
                p.setAttribute(rightDivContents, 'class', 'cus_ta scroll_fix rightContents scbg_img');
                p.setAttribute(rightDivContents, 'onScroll', "searchTableScroll()");

                var rightTableContents = document.createElement("TABLE");
                p.setAttribute(rightTableContents, 'id', pLocationId+"_TABLE");
                var rightTRContnets = document.createElement("TR");
                /* 조립 */
                roundTD.appendChild(rightDivContents);        
                rightDivContents.appendChild(rightTableContents);

                /* 최종 조립 */
                var elementLocation = document.getElementById(pLocationId);
                elementLocation.appendChild(firstTopDiv);
                return;
            } catch (e) {
                console.log(e);
            }
        	
        	
        },
        //코드 도움창2
        drawCodeType2 : function (pHeaderJSONList, pLocationId ,pTableType, pTableHeight, pBackgroundYN) {
        	//테이블 헤더그리기
            var firstTopDiv = document.createElement("DIV");
            var secTopDiv = document.createElement("DIV");
            
            p.setAttribute(firstTopDiv, 'class', 'searchTable mt20');
            p.setAttribute(firstTopDiv, 'id', pLocationId);
            p.setAttribute(secTopDiv, 'class', 'cus_ta');

            /* 조립 */
            firstTopDiv.appendChild(secTopDiv);

            var roundTable = document.createElement("TABLE");
            var roundTR = document.createElement("TR");

            /* LEFT FIX ZONE */
            var roundFixTD = document.createElement("TD");

            p.setAttribute(roundFixTD, 'class', 'p0 brn scbg');
            p.setAttribute(roundFixTD, 'width', '68px');
            p.setAttribute(roundFixTD, 'valign', 'top');

            /* LEFT HEADER(FIXED) */
            var leftHeaderDiv = document.createElement("DIV");
            p.setAttribute(leftHeaderDiv, 'class', 'cus_ta ovh leftHeader');

            var leftHeaderTable = document.createElement("TABLE");
            p.setAttribute(leftHeaderTable, 'id', pLocationId+'_LEFT_TH');
            var leftHeaderTR = document.createElement("TR");
            var leftHeaderTH1 = document.createElement("TH");
            $(leftHeaderTH1).html('NO');

            var leftHeaderLable = document.createElement("LABEL");
            p.setAttribute(leftHeaderLable, 'for', pLocationId + '_checkAll');      
            leftHeaderLable.style.setProperty('margin-left','-14px', 'important');
          
            /* 조립 */
            leftHeaderDiv.appendChild(leftHeaderTable);
            leftHeaderTable.appendChild(leftHeaderTR);
            leftHeaderTR.appendChild(leftHeaderTH1);
            
            /* LEFT CONTENTS(FIXED) */
            var leftContentDiv = document.createElement("DIV");
            p.setAttribute(leftContentDiv, 'class', 'cus_ta ovh leftContents scbg');
            p.setAttribute(leftContentDiv, 'onmousewheel', 'onmousewheel()');
            p.setAttribute(leftContentDiv, 'onScroll', 'table2Scroll('+ pLocationId +')');
            
            var tmpHeight = pTableHeight.replace('px','');
            
            $(leftContentDiv).css('height', tmpHeight - 17 +'px');

            var leftContentTable = document.createElement("TABLE");
            p.setAttribute(leftContentTable, 'id', pLocationId + "_TRDATA" + '_FIX'); // 아이디 동적 수정 필요          
           
            /* 조립 */
            leftContentDiv.appendChild(leftContentTable);

            /* 조립 */
            roundFixTD.appendChild(leftHeaderDiv);
            roundFixTD.appendChild(leftContentDiv);

            /* RIGHT CONTENTS ZONE */
            var roundMoveTD = document.createElement("TD");
            p.setAttribute(roundMoveTD, 'class', 'p0 brn posi_re');
            p.setAttribute(roundMoveTD, 'width', '*');
            p.setAttribute(roundMoveTD, 'valign', 'top');

            /* SCROLL HEADER */
            var scrollHeader = document.createElement("SPAN");
            p.setAttribute(scrollHeader, 'class', 'scy_head1');

            /* RIGHT HEADER */
            var rightHeader = document.createElement("DIV");
            p.setAttribute(rightHeader, 'class', 'cus_ta ovh mr17 rightHeader');

            var rightHeaderTable = document.createElement("TABLE");
            p.setAttribute(rightHeaderTable, 'id', pLocationId+'_RIGHT_TH');
            var rightTRHeader = document.createElement("TR");

            //테이블 헤더 그리기
            $.each(pHeaderJSONList, function (index, item) {
                var nTH = document.createElement("TH");
                $(nTH).css("width", item.width);
                $(nTH).html(item.titleName);              
                p.setAttribute(nTH, 'class', item.displayClass);
                rightTRHeader.appendChild(nTH);
            });
            rightHeaderTable.appendChild(rightTRHeader);
            rightHeader.appendChild(rightHeaderTable);
            roundMoveTD.appendChild(rightHeader);


            var rightContentDiv = document.createElement("DIV");
            //옵션값 받기
            if (pBackgroundYN === 'Y') { //이미지
                p.setAttribute(rightContentDiv, 'class', 'cus_ta scroll_fix rightContents scbg_img');
            }
            else {
                p.setAttribute(rightContentDiv, 'class', 'cus_ta scroll_fix rightContents scbg_non_img');
            }
            p.setAttribute(rightContentDiv, 'onScroll', 'table2Scroll('+ pLocationId +')');
            $(rightContentDiv).css('height', (pTableHeight || '162'));

            var rightContentTable = document.createElement("TABLE");
            p.setAttribute(rightContentTable, 'id', pLocationId + '_TRDATA');
            var rightTRContnets = document.createElement("TR");
            p.setAttribute(rightTRContnets, 'class', 'lineOn onSel');

            /* 조립 */
            rightContentDiv.appendChild(rightContentTable);
            roundMoveTD.appendChild(scrollHeader);
            roundMoveTD.appendChild(rightHeader);
            roundMoveTD.appendChild(rightContentDiv);

            secTopDiv.appendChild(roundTable);
            roundTable.appendChild(roundTR);
            roundTR.appendChild(roundFixTD);
            roundTR.appendChild(roundMoveTD);

            /* 최종 조립 */
            var elementLocation = document.getElementById(pLocationId);
            elementLocation.appendChild(firstTopDiv);
            return;
        },
        //행 추가
        addRow: function (pLocationId, headerJsonList, parentElement, newRowNumber) {
            //테이블 헤더 그리기
            $.each(headerJsonList, function (index, item) {
                var nTD = document.createElement("TD");
                $(nTD).css('width', item.width);
                p.setAttribute(nTD, 'class', item.tdClass);               
                p.setAttribute(nTD, 'class', item.displayClass);
                var nINPUT = document.createElement("INPUT");
                p.setAttribute(nINPUT, 'inputType', item.type);
                p.setAttribute(nINPUT, 'class', item.inputClass);
                if(item.mask != ''){
                	$(nINPUT).addClass(item.mask);
                }
                p.setAttribute(nINPUT, 'id', item.id);
                if (newRowNumber == undefined) {
                    p.setAttribute(nINPUT, 'id', item.id + '_' + '0' + '_' + item.no);
                }
                else {
                    p.setAttribute(nINPUT, 'id', item.id + '_' + newRowNumber + '_' + item.no);
                }
                
                if(typeof item.value == 'function'){
                    $(nINPUT).val(item.value());
                } else {
                    $(nINPUT).val(item.value || '');
                }
                
                nTD.appendChild(nINPUT);
                parentElement.appendChild(nTD);
            });
          
            var sGroupClass= groupClass.split('_');
            if(sGroupClass[0] === pLocationId)
        	{
            	if (newRowNumber == undefined) {
            		groupClass = pLocationId+'_0';
            	}
            	else{
            		groupClass = pLocationId+'_'+newRowNumber;
            	}
        	}       
            p.setAttribute(parentElement, 'class', groupClass);
            
        },

        //왼쪽 고정 추가(체크박스)
        addFixRow: function (pTableType, pLocationId, pParentElement, pNewRowNumber) {
            //newTable2_fix
            switch (pTableType) {
                case '2':
                    var leftContentTR = document.createElement("TR");
                    var leftContentTH = document.createElement("TH");
                    $(leftContentTH).html((pNewRowNumber || 0));
                    var leftContentTD = document.createElement("TD");
                    $(leftContentTD).css('width', '33px');
                    var leftContentInput = document.createElement("INPUT");
                    p.setAttribute(leftContentInput, 'type', 'checkbox');
                    var leftContentLabel = document.createElement("LABEL");
                    if (pNewRowNumber == undefined) {
                        p.setAttribute(leftContentInput, 'id', pLocationId + '_check_0'); //아이디 동적 수정 필요
                        p.setAttribute(leftContentInput, 'name', pLocationId + 'Chk'); //아이디 동적 수정 필요
                        p.setAttribute(leftContentLabel, 'for', pLocationId + '_check_0'); //아이디 동적 수정 필요
                        leftContentLabel.style.setProperty('margin-left','-14px', 'important');
                    }
                    else {
                        p.setAttribute(leftContentInput, 'id', pLocationId + '_check_' + pNewRowNumber); //아이디 동적 수정 필요
                        p.setAttribute(leftContentInput, 'name', pLocationId.replace('_TRDATA_FIX','') + 'Chk'); //아이디 동적 수정 필요
                        p.setAttribute(leftContentLabel, 'for', pLocationId + '_check_' + pNewRowNumber); //아이디 동적 수정 필요
                        leftContentLabel.style.setProperty('margin-left','-14px', 'important');
                    }
                    
                    var sGroupClass= groupClass.split('_');
                    if(sGroupClass[0] === pLocationId)
                	{
                    	if (pNewRowNumber == undefined) {
                    		groupClass = pLocationId+'_0';
                    	}
                    	else{
                    		groupClass = pLocationId+'_'+pNewRowNumber;
                    	}
                	}       
                    p.setAttribute(leftContentTR, 'class', groupClass);
                    
                    pParentElement.appendChild(leftContentTR);
                    leftContentTR.appendChild(leftContentTH);
                    leftContentTR.appendChild(leftContentTD);
                    leftContentTD.appendChild(leftContentInput);
                    leftContentTD.appendChild(leftContentLabel);
                    break;

            }
        },
        //코드 도움창 데이터 넣기 
        /* 파라메터(코드팝업헤더JSON, 코드데이터리스트, 엘리먼트 아이디(테이블 위치) */
        addrowCodeType1 : function(pHeaderJsonList, pCodeJsonList, pLocationId){
            /* 데이터 반복문 호출 */
        	for(var i=0; i < pCodeJsonList.length; i++){
        		var nTR = document.createElement("TR");
        		p.setAttribute(nTR, 'tabindex', '-1');
	            $.each(pCodeJsonList[i], function(itemKey,itemValue){
	            	var nTD = document.createElement("TD");
	            	var nSPAN = document.createElement("SPAN");
	            	$.each(pHeaderJsonList, function(headKey,headValue){     		
	            		if(itemKey === headValue.id){
	            			$(nTD).css('width',headValue.width);
	            			p.setAttribute(nTD, 'class', headValue.tdClass);
	            			if(headValue.displayClass ==='loseSight'){
	            				$(nTD).css('display','none');
	            			}	            				         
	            			return false;
	            		}
	            	});
	            	p.setAttribute(nSPAN, 'class', 'search_span');
	            	p.setAttribute(nSPAN, 'title', itemValue);
	            	$(nSPAN).html(itemValue);
	               	/* 조립 */
	            	nTD.appendChild(nSPAN);
	            	nTR.appendChild(nTD);
	            });	     
	            
	            $(nTR).prop('data', pCodeJsonList[i]);	         
	            // console.log(pCodeJsonList[i]);
	            
            	var elementTable = document.getElementById(pLocationId+"_TABLE");
            	elementTable.appendChild(nTR);
            }  
        	//첫번째 테이블 TR 위치 
        },
        /* 파라메터(코드팝업헤더JSON, 코드데이터리스트, 엘리먼트 아이디(테이블 위치) */
        addrowCodeType2 : function(pHeaderJsonList, pCodeJsonList, pLocationId){
        	
        	/* 오른쪽 컨텐츠 삽입 */        	       
        	for(var i=0; i < pCodeJsonList.length; i++){
        		var nTR = document.createElement("TR");
        		p.setAttribute(nTR, 'tabindex', '-1');
	            $.each(pCodeJsonList[i], function(itemKey,itemValue){
	            	var nTD = document.createElement("TD");
	            	var nSPAN = document.createElement("SPAN");
	            	$.each(pHeaderJsonList, function(headKey,headValue){     		
	            		if(itemKey === headValue.id){
	            			$(nTD).css('width',headValue.width);
	            			p.setAttribute(nTD, 'class', headValue.tdClass);
	            			if(headValue.displayClass ==='loseSight'){
	            				$(nTD).css('display','none');
	            			}	            				         
	            			return false;
	            		}
	            	});
	            	p.setAttribute(nSPAN, 'class', 'search_span');
	            	p.setAttribute(nSPAN, 'title', itemValue);
	            	$(nSPAN).html(itemValue);
	               	/* 조립 */
	            	nTD.appendChild(nSPAN);
	            	nTR.appendChild(nTD);
	            });	     
	            
	            $(nTR).prop('data', pCodeJsonList[i]);	         	          	            
            	var elementTable = document.getElementById(pLocationId+"_TRDATA");
            	elementTable.appendChild(nTR);
            } 
        	
        	var eleLeftTable = document.getElementById(pLocationId+"_TRDATA_FIX");
        	/* 왼쪽 고정 컨텐츠 삽입*/
        	for(var i=0; i < pCodeJsonList.length; i++){
        	      var nTR = document.createElement("TR");
                  var nTH = document.createElement("TH");
                  $(nTH).html(i);                  
                  nTR.appendChild(nTH);
                  eleLeftTable.appendChild(nTR);
        	}        	        	        	
        },
        //테이블 행 삭제 
        deleteRowType1 : function(pLocationId, pRowIndex, pTableRowCountId){
        	//$("#"+pLocationId).find('TR').eq(pRowIndex).remove()

        },
        //테이블 행 삭제 
        deleteRowType2 : function(pLocationId, pRowIndex){
        	//$("#newTable2_TRDATA_FIX").find('TR').eq(0);
        },
        //클릭 유효성 검사 - 필수값을 입력하지 않고 클릭포커스를 이동하면 유효성 검사를 하여 최초 필수값으로 이동한다.
        validateInput : function(headerJsonList, curElement){
        	//리턴값 설정
        	var returnValue = ''; 
        	//입력데이터가 존재하면 리턴한다.
        	if($(curElement).val().length > 0){
        		var curElementId = $(curElement).attr('id');
				//input id 정보 자르기
				var arrElement = curElementId.split('_');
				
				var tableElement = $(curElement).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
				//현재 테이불 아이디 확인
				var currentTableId = $(tableElement).attr('id');
				//json 리스트에 존재하는 key 확인
				var jsonTableName = currentTableId;
				
				$.each(headerJsonList[jsonTableName], function (index, item) {	
					if(arrElement[0] === item.id){
						if(item.focusCustFunc != ''){
							window[item.focusCustFunc](headerJsonList,curElement);
						}
						return false;
					}
				});
        		
        		returnValue = 'SUCCESS'; 
        		return returnValue;
        	}
        	else{
        		//현재 input id 확인
				var curElementId = $(curElement).attr('id');
				//input id 정보 자르기
				var arrElement = curElementId.split('_');
				//현재 input 행렬정보
				var row_num = Number(arrElement[1]);
				//현재 input 행렬정보
				var column_num = Number(arrElement[2]);
				
				//현재 테이블 요소 셀렉터
				var tableElement = $(curElement).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
				//현재 테이불 아이디 확인
				var currentTableId = $(tableElement).attr('id');
				//json 리스트에 존재하는 key 확인
				var jsonTableName = currentTableId;
				//포커스 아이디 선언
				var eleId = '';
				//유효성 검사 체크	
	        	$.each(headerJsonList[jsonTableName], function (index, item) {	
		        		if(item.requierdYN === 'Y' && item.displayClass === '')
	        			{
		        			eleId = item.id + '_'+ row_num + '_' + item.no;
		        			if($("#"+eleId).val().length <= 0)
	        				{
		        				returnValue = eleId; //아이디 부여
		        				$("#"+eleId).focus();
		        				$("#"+txtHelpMsgElementId).html(item.helpDeskMessage);
		        				return false;
	        				}
	        			}
		        		else if(item.id === arrElement[0])
		        		{
		        			$("#"+txtHelpMsgElementId).html(item.helpDeskMessage);
		        			return false;
		        		}
	        	});
	        	
	        	if(returnValue === '')
	        	{
	        		returnValue = 'SUCCESS';
	        	}
	        	
	        	$.each(headerJsonList[jsonTableName], function (index, item) {	
					if(arrElement[0 ]=== item.id){
						if(item.focusCustFunc != ''){
							window[item.focusCustFunc](headerJsonList,curElement);
						}
						return false;
					}
				});
	        	
        	}
        	return returnValue;
        },
        //행 삭제
        deleteRow: function (pLocationId, deleteRowNumber) {

        },
        //어트리뷰트 설정
        setAttribute: function (element, id, value) {
            return $(element).attr(id, value);
        },
        //엘리먼트 스타일 설정
        setStyle: function (element, id, value) {
            return $(element).css(id, value);
        }
    }

    $.devTable = {
        /* 파라메터(그리드헤더 JSON리스트, 엘리먼트 아이디(테이블 위치), 테이블종류, 테이블높이(고정 최대값), 워터마크 여부(Y/N), 그룹 테이블 행 보이기 여부 */
        create: function (pHeaderJSONList, pLocationId, pFirstAddRowYN, pTableType, pTableHeight, pBackgroundYN, pGroupClassYN, pGroupTRDisplayYN ) {
            pHeaderJSONList = pHeaderJSONList ? pHeaderJSONList : '[]';
            pLocationId = pLocationId ? pLocationId : '';
            pTableType = pTableType ? pTableType : '';
            pTableHeight = pTableHeight ? pTableHeight : '';
            pBackgroundYN = pBackgroundYN ? pBackgroundYN : 'N';
            pGroupClassYN = pGroupClassYN ?pGroupClassYN : 'N';

            //그룹 클래스 지정
            if(pGroupClassYN === 'Y'){
            	groupClass = pLocationId;
            }
            
            //테이블 생성 타입 구분 
            switch (pTableType) {
                case '1':
                    p.drawType1(pHeaderJSONList, pLocationId, pFirstAddRowYN, pTableType, pTableHeight, pBackgroundYN);
                    break;

                case '2':
                    p.drawType2(pHeaderJSONList, pLocationId, pFirstAddRowYN, pTableType, pTableHeight, pBackgroundYN);
                    break;

                default:
                    console.log('생성할 테이블 타입이 존재하지 않습니다.');
                    break;
            }
            setDevTableRowFocusStyle(pGroupTRDisplayYN);
        },
        /* 파라메터(추가그리드헤더,테이블 종류, 테이블 엘리먼트 아이디(테이블위치 + _TRDATA), 추가하는 행의 순번 */
        addrow: function (pLocationId, pHeaderJsonList, pTableType , pParentElement, pNewRowNumber, pGroupTRDisplayYN) {
            pHeaderJsonList = pHeaderJsonList ? pHeaderJsonList : '[]';
            pTableType = pTableType ? pTableType : '';
            pParentElement = pParentElement ? pParentElement : '';
            var parentElement = document.getElementById(pParentElement);
            var rightTRContnets = document.createElement("TR");

            switch (pTableType) {
                case '1':
                    p.addRow(pLocationId,pHeaderJsonList, rightTRContnets, pNewRowNumber);
                    parentElement.appendChild(rightTRContnets);
                    setDevTableRowFocusStyle(pGroupTRDisplayYN);
                    break;
                case '2':
                    p.setAttribute(rightTRContnets, 'class', 'lineOn onSel');
                    p.addRow(pLocationId,pHeaderJsonList, rightTRContnets, pNewRowNumber);
                    parentElement.appendChild(rightTRContnets);

                    var fixTableElement = pParentElement + "_FIX";
                    var fixParentElement = document.getElementById(fixTableElement);
                    p.addFixRow(pTableType, fixTableElement, fixParentElement, pNewRowNumber);

                    setDevTableRowFocusStyle(pGroupTRDisplayYN);
                    break;

                default:
                    console.log('행 추가하려는 테이블 타입이 존재하지 않습니다.');
                    break;
            }
        },
        /* 파라메터(추가그리드헤더,코드팝업 위치, 코드팝업종류,  테이블높이(고정 최대값), 워터마크 여부(Y/N) */
        createCodeHelper : function (pHeaderJSONList, pLocationId, pTableType, pTableHeight, pBackgroundYN) {
        	 pHeaderJSONList = pHeaderJSONList ? pHeaderJSONList : '[]';
             pLocationId = pLocationId ? pLocationId : '';
             pTableType = pTableType ? pTableType : '';
             pTableHeight = pTableHeight ? pTableHeight : '';
             pBackgroundYN = pBackgroundYN ? pBackgroundYN : 'N';
             
             //테이블 생성 타입 구분 
             switch (pTableType) {
                 case '1':
                     p.drawCodeType1(pHeaderJSONList, pLocationId, pTableType, pTableHeight, pBackgroundYN);
                     break;
                 case '2':
                     p.drawCodeType2(pHeaderJSONList, pLocationId, pTableType, pTableHeight, pBackgroundYN);
                     break;
                 default:
                     console.log('생성할 코드팝업 테이블 타입이 존재하지 않습니다.');
                     break;
             }
             
        },
        /* 파라메터(코드팝업헤더JSON, 코드데이터리스트, 코드팝업타입, 엘리먼트 아이디(테이블 위치) */
        addrowCodeData : function(pHeaderJsonList, pCodeJsonList, pCodePopType ,pLocationId, pNewRowNumber){
        	pLocationId = pLocationId ? pLocationId : '';
        	pCodeJsonList = pCodeJsonList ? pCodeJsonList : [];
        	pCodePopType = pCodePopType ? pCodePopType : '';
        	pLocationId = pLocationId ? pLocationId : '';
        	
        	//테이블 생성 타입 구분 
            switch (pCodePopType) {
                case '1':
                    p.addrowCodeType1(pHeaderJsonList, pCodeJsonList, pLocationId);
                    setDevCodePopTableFocusStyle();
                    $("#"+pLocationId+ "_TABLE").find('TR').eq(0).click().focus();             
                    break;
                case '2':
                	p.addrowCodeType2(pHeaderJsonList, pCodeJsonList, pLocationId);
                    setDevCodePopTableFocusStyle();
                    $("#"+pLocationId+ "_TRDATA").find('TR').eq(0).click().focus();    
                	break;
                default:
                    console.log('매핑할 코드팝업 데이터에 대한 테이블 타입이 존재하지 않습니다.');
                    break;
            }
        }
    },
 
    //체크박스 이벤트
    fnCheck = function( obj ) {
        var name = obj.name;
        var chk = $("input[name=" + name + "]:checkbox");
        
        $.each(chk, function( idx, target ) {
            $(target).prop('checked', obj.checked);
        });
    },
    
    //휠스크롤 이벤트
	fixDataOnWheel = function () {
	    if (event.wheelDelta < 0) {
	        DataScroll.doScroll('scrollbarDown');
	    } else {
	        DataScroll.doScroll('scrollbarUp');
	    }
	    $.table1Scroll();
	    $.table2Scroll();
	    $.devTable3Scroll();
	},

    //입력 테이블 스타일 지정	
	setDevTableRowFocusStyle = function (pGroupTRDisplayYN) {
		var displayGroupOption = '';
		
		if(pGroupTRDisplayYN == undefined || pGroupTRDisplayYN == '' ){
			displayGroupOption = 'N';
		}
		else{
			displayGroupOption = pGroupTRDisplayYN || '';
		}
		
	    // 이지바로 테이블 로우 선택
	    var TR = $('.rightContents.cus_ta table tr');
	    var TD = $('.rightContents.cus_ta table tr td');
	    var iFocus = $('.rightContents.cus_ta table tr td input');

	    TR.unbind('click');
	    TR.click(function () {
	        TR.removeClass('lineOn onSel');
	        $(this).addClass('lineOn onSel');
	    });

	    TD.unbind('focusin');
	    TD.focusin(function () {    	
	    	TD.removeClass('focus');
	    	$(this).addClass('focus');
	    });
	    
	    TD.unbind('focusout');
	    TD.focusout(function () {
	        TD.removeClass('focus')
	    });
	    
	    iFocus.unbind('click');
	    //전역변수필요 focusJsonList
	    iFocus.click(function (e) {
	    	//e.stopPropagation();
	    	
			var eleId = p.validateInput(focusJsonList,this);
			if(eleId === 'SUCCESS'){
				iFocus.removeClass('focus');
	    		$(this).addClass('focus');
	    		
	    		var curTRClass = $(this).parent().parent().attr('class');
	    		var arrTRClass =curTRClass.split(' ');
	   
	    		var isMatch = false;
	    		for(var i =0 ; i<curTRClass.length; i++){
	    			for(var j=0; j<arrTRClass.length; j++){
	    				if(arrTRClass[j].indexOf(curTRClass[i]) != -1){
	    					groupClass = arrTRClass[j];
	    					isMatch = true;
	    					break;
	    				}
	    			}
	    			if(isMatch == true){
	    				break;
	    			}
	    		}
	    		
	    		$.each(focusJsonList['arrfocusKey'],function(index,item){	    	
	    			if(item.key !== groupClassId){	    		
	    				
		    			$.each($("#"+item.key+"_TRDATA").find('tr'), function(index,item){
		    				var classValue = ($(item).attr('class') || '');
		    				if(classValue.indexOf(groupClass) == -1){	
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','none');
		    					}
		    				}
		    				else{
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','');
		    					}
		    				}
		    			});
		    			$.each($("#"+item.key+"_TRDATA_FIX").find('tr'), function(index,item){
		    				var classValue = ($(item).attr('class') || '');
		    				if(classValue.indexOf(groupClass) == -1){
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','none');
		    					}
		    				}
		    				else{
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','');
		    					}
		    				}
		    			});
	    			}
	    		});
	    			
			}
	    	else{
	    		iFocus.removeClass('focus');
	    		$('#'+eleId).addClass('focus');	
	    		
	    		var curTRClass = $("#"+eleId).parent().parent().attr('class');
	    		var arrTRClass =curTRClass.split(' ');
	   
	    		var isMatch = false;
	    		for(var i =0 ; i<curTRClass.length; i++){
	    			for(var j=0; j<arrTRClass.length; j++){
	    				if(arrTRClass[j].indexOf(curTRClass[i]) != -1){
	    					groupClass = arrTRClass[j];
	    					isMatch = true;
	    					break;
	    				}
	    			}
	    			if(isMatch == true){
	    				break;
	    			}
	    		}
	    		
	    		
	    		var curTRClass = $(this).parent().parent().attr('class');
	    		var arrTRClass =curTRClass.split(' ');
	   
	    		var isMatch = false;
	    		for(var i =0 ; i<curTRClass.length; i++){
	    			for(var j=0; j<arrTRClass.length; j++){
	    				if(arrTRClass[j].indexOf(curTRClass[i]) != -1){
	    					groupClass = arrTRClass[j];
	    					isMatch = true;
	    					break;
	    				}
	    			}
	    			if(isMatch == true){
	    				break;
	    			}
	    		}
	    		
	    		$.each(focusJsonList['arrfocusKey'],function(index,item){	    	
	    			if(item.key !== groupClassId){	    		
	    				
		    			$.each($("#"+item.key+"_TRDATA").find('tr'), function(index,item){
		    				var classValue = ($(item).attr('class') || '');
		    				if(classValue.indexOf(groupClass) == -1){
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','none');
		    					}
		    				}
		    				else{
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','');
		    					}
		    				}
		    			});
		    			$.each($("#"+item.key+"_TRDATA_FIX").find('tr'), function(index,item){
		    				var classValue = ($(item).attr('class') || '');
		    				if(classValue.indexOf(groupClass) == -1){
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','none');
		    					}
		    				}
		    				else{
		    					if(displayGroupOption == 'Y'){
		    						$(item).css('display','');
		    					}
		    				}
		    			});
	    			}
	    		});
	    	}	
	    });
	    
	    $('.loseSight').css('display','none');
	},
	//코드팝업 테이블 스타일 지정
	setDevCodePopTableFocusStyle =function(){
		var TR = $('.rightContents.cus_ta table tr');
		
	    TR.click(function(){ 
	        TR.removeClass('onSel'),$(this).addClass('onSel');
	    });
	},
    //테이블 타입1 스크롤 
	table1Scroll = function (locationId) {
		var eleId = $(locationId).attr('id');
	    $("#"+eleId+" .rightHeader").scrollLeft($("#"+eleId+" .rightContents").scrollLeft());
	},
    //테이블 타입2 스크롤
	table2Scroll = function (locationId) {
		var eleId = $(locationId).attr('id');
	    $("#"+eleId+" .leftContents").scrollTop($("#"+eleId+" .rightContents").scrollTop());
	    $("#"+eleId+" .rightHeader").scrollLeft($("#"+eleId+" .rightContents").scrollLeft());
	},
    //테이블 타입3 스크롤
	devTable3Scroll = function () {
	    $(".table3 .leftContents").scrollTop($(".table3 .rightContents").scrollTop());
	    $(".table3 .rightHeader").scrollLeft($(".table3 .rightContents").scrollLeft());
	},
	//코드팝업 스크롤
	searchTableScroll= function() {
    	$(".searchTable .rightHeader").scrollLeft($(".searchTable .rightContents").scrollLeft());
    }
})(jQuery)