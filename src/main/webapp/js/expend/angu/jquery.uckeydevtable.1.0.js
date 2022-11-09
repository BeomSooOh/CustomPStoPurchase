/* 
 * =======================================================================================================================================
 * AC TABLE KEY PLUG IN - 2017.02.08 Account Part dev. team 1  
 * 참고사항 :focusJsonList JSON LIST 변수 필수 
 * 개발 그리드 테이블 사용할 jsp 파일에 해당 스크립트를 링크하여 사용합니다.
 * =======================================================================================================================================
 */

(function ($) {
    txtHelpMsgElementId = '';

    var pKey = {
        enterEvent: function (obj) {
            //현재 input value 확인
            var nInputValueLen = $(obj).val().length;

            //현재 input id 확인
            var curElementId = $(obj).attr('id');

            //input id 정보 자르기
            var arrElement = curElementId.split('_');

            //새로운 아이디 할당
            var curRowNumber = Number(arrElement[1]);
            var newRowNumber = Number(arrElement[2]) + 1;

            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();

            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');
            //json 리스트에 존재하는 key 확인
            var jsonTableName = currentTableId;

            //다음 요소 엘리먼트 아이디 변수 선언 
            var nextEleId = '';
            //each문에서 현재 아이디와 일치여부를 확인하기 위한 변수 선언
            var jsonNo = -1;

            //다음 json 테이블이 없다면 끝낸다.
            if (focusJsonList[jsonTableName] == undefined) {
                return;
            }

            $.each(focusJsonList[jsonTableName], function (jsonName, item) {
            	if(!item.bindId || item.bindId != $('input.focus').prop('id')){
            		item.bindId = $('input.focus').prop('id');
            	}
                if (jsonNo === -1) {
                    //현재 선택한 INPUT과 반복문내 아이디가 일친
                    if (item.id === arrElement[0]) {
                        /* 필수 값 필수값 체크 */
                        //필수입력, 코드도움창X, 입력값이 미존재
                        if (item.requierdYN === 'Y' && item.codeHelperYN === 'N' && nInputValueLen <= 0) {
                            nextEleId = item.id;
                            newRowNumber = item.no;
                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            return false;
                        }
                        //필수입력, 코드도움창
                        else if (item.requierdYN === 'Y' && item.codeHelperYN === 'Y') {
                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            if (window.hasOwnProperty(item.popupCustLoadFunc)) {
                                if (typeof window[item.popupCustLoadFunc] === 'function') {
                                	if(Object.keys($('#' + item.bindId).data() || {}).length == 0 && item.bindId){
                                		item.tableId = jsonTableName;
                                		window[item.popupCustLoadFunc]($(obj).attr('id'), item);
                                	} else {
                                		if($('#' + item.bindId).parent().next('td').find('input').length > 0){
                                			$('#' + item.bindId).parent().next('td').find('input').focus().select();
                                			$('#' + item.bindId).parent().next('td').find('input').click();
                                		}
                                	}
                                }
                            }
                            jsonNo = 0;
                            return false;
                        } else if (item.requierdYN === 'N' && item.codeHelperYN === 'Y') {
                            var retValue;

                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            if (window.hasOwnProperty(item.popupCustLoadFunc)) {
                                if (typeof window[item.popupCustLoadFunc] === 'function') {
                                    item.tableId = jsonTableName;
                                    retValue = window[item.popupCustLoadFunc]($(obj).attr('id'), item);
                                    if (retValue == false) {
                                        //현재 each문에 존재하는 순번 저장
                                        jsonNo = item.no;
                                        //다음 json 요소 순번 지정 
                                        jsonNo = Number(jsonNo) + 1;
                                    }
                                }
                            }
                            if (retValue != false) {
                                jsonNo = 0;
                                return false;
                            }
                        }
                        //마지막 요소가 아니라면
                        else if (item.tail == 'N') {
                            //현재 each문에 존재하는 순번 저장
                            jsonNo = item.no;
                            //다음 json 요소 순번 지정 
                            jsonNo = Number(jsonNo) + 1;
                        }
                    }
                } else {
                    //지정한 요소 순번과 일치
                    if (item.no == jsonNo) {
                        //반복문내 현재 key 화면에 보여지다면
                        if (item.displayClass === '') {
                            //다음 요소 id 지정 
                            nextEleId = item.id;
                            newRowNumber = item.no;
                            //다음 요소 헬프데스크 지정
                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            return false;
                        } else {
                            //반복문내 현재 key값이 존재하지만 화면이 보여지지 않으므로 순번을 1더하여 지정
                            jsonNo = Number(jsonNo) + 1;
                        }
                    }
                }
            });
            //엘리먼트가 존재하지 않고 다음 순번의 엘리먼트 요소를 찾지 못하였다면 다음 테이블의 첫번째 row로 이동
            if (nextEleId === '' && jsonNo === -1)
            //if(nextEleId === '')
            {
                //다음 테이블 정보
                var nextJsonInfo;
                //전체 테이블 포커스 카운트
                var focusTableTotalCount = focusJsonList['arrfocusKey'].length;
                //현재 포커스한 자신의 테이블 정보를 가져온다.					
                $.each(focusJsonList['arrfocusKey'], function (index, item) {
                    if (item.key === jsonTableName) {
                        nextJsonInfo = item;
                        return false;
                    }

                });
                //현재 테이블 정보에서 연결된 테이블 정보가 존재한다면 포커스를 이동한다.
                if (typeof nextJsonInfo == 'object') {
                    //다음 테이블 정보에 대한 변수 선언
                    var tableInfo = nextJsonInfo.linkInfo;
                    //테이블 정보를 통한 포커스 이동(연결된 테이블이 여러개 일 수 있기 때문에 로우를 생성한 후 포커스를 이동 linkinfo는 json array이다. 
                    $.each(tableInfo, function (index, info) {
                        if (focusJsonList[info.linkTableName] == undefined) {
                            return;
                        }
                        //json array를 순차적으로 실행한다.
                        $.each(focusJsonList[info.linkTableName], function (jsonName, item) {
                            //컬럼을 화면에 표시하는 여부
                            if (item.displayClass === '') {
                                //연결된 테이블의 row를 새로 생성하는지 옵션 여부
                                if (info.autoCreateRow === 'Y') {
                                    //새로운 테이블의 포커스엘리먼트아이디 확인
                                    var nextElementId = '';

                                    if (info.linkTableName === info.myTableName) { //자기자신의 테이블로 연결되어 있다면 로우 추가											
                                        // console.log($(obj).parent().parent().index());							
                                        var eleGroupTR = $('#' + info.linkTableName + '_TRDATA').find("TR[class^=" + groupClass + "]");

                                        $.each(eleGroupTR, function (index, item) {
                                            if ($(item).index() > $(obj).parent().parent().index()) {
                                                var eleId = $(item).find('input').eq(0).attr('id');
                                                var arrIdInfo = eleId.split('_');
                                                nextEleId = arrIdInfo[0];
                                                curRowNumber = arrIdInfo[1];
                                                newRowNumber = arrIdInfo[2];
                                                nextElementId = eleId;
                                            }
                                        });


                                        if (nextElementId === '') {
                                            //curRowNumber = Number(curRowNumber)+1;
                                            //nextElementId = item.id + '_' + curRowNumber + '_' + item.no;
                                            window[info.tableRowNumVariableName] = Number(window[info.tableRowNumVariableName]) + 1;
                                            curRowNumber = window[info.tableRowNumVariableName];
                                            
                                            if(info.linkParentElementId == 'regContent_TRDATA'){
                                            	var nowRowValue = $('#' + info.linkParentElementId + ' tr:last td:first input').val();
                                            	var beforeRowValue = $($('#' + info.linkParentElementId + ' tr:last').prev('tr').find('td input')[0]).val();
                                            	
                                            	if(!(nowRowValue == '' && beforeRowValue == '')){
                                            		$.devTable.addrow(info.linkTableName, info.linkJsonData, info.linkTableType, info.linkParentElementId, window[info.tableRowNumVariableName]);
                                                    fnRegUCTableKeyEvent();                                            		
                                            	}
                                            } else {
                                            	$.devTable.addrow(info.linkTableName, info.linkJsonData, info.linkTableType, info.linkParentElementId, window[info.tableRowNumVariableName]);
                                                fnRegUCTableKeyEvent();
                                            }
                                        }
                                    } else { //자기자신이 아니라면 클래스를 찾은 후 존재하면 해당행으로 이동 아니라면 생성
                                        var eleGroup = $("#" + info.linkTableName).find('table tr' + '.' + groupClass);
                                        var dispStat = true;
                                        $.each(eleGroup, function (idx, tr) {
                                            if ($(tr).css('display') == 'none') {
                                                dispStat = true;
                                            } else if ($(tr).css('display') != 'none') {
                                                dispStat = false;
                                                return false;
                                            }
                                        });

                                        //엘리먼트가 존재하지 않으면
                                        /*if (eleGroup.length <= 0 && dispStat) {*/
                                        if (dispStat || eleGroup.length <= 0) {
                                            //row카운트 수 증가
                                            window[info.tableRowNumVariableName] = Number(window[info.tableRowNumVariableName]) + 1;
                                            curRowNumber = Number(window[info.tableRowNumVariableName]);
                                            nextElementId = item.id + '_' + curRowNumber + '_' + item.no;
                                            //row 생성
                                            $.devTable.addrow(info.linkTableName, info.linkJsonData, info.linkTableType, info.linkParentElementId, window[info.tableRowNumVariableName]);
                                            //key 이벤트 등록
                                            fnRegUCTableKeyEvent();
                                        } else {
                                            $.each(eleGroup, function (index, value) {
                                                if ($(value).find('input:checkbox').length <= 0) {
                                                    nextElementId = $(value).find('input').eq(0).attr('id');
                                                    var arrInfo = nextElementId.split('_');
                                                    curRowNumber = arrInfo[1];
                                                    return false;
                                                }
                                            });
                                        }
                                    }

                                }
                                //연결된 링크이 테이블에 대해 포커스 지정 여부 확인
                                if (info.focusYN === 'Y') {
                                    //포커스로 지정할 아이디 
                                    nextEleId = item.id;
                                    //새로 생성한 row 넘저 지정
                                    newRowNumber = item.no;
                                    //포커스 헬프데스크 지정
                                    $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                                }
                                return false;
                            } else {
                                //반복문내 현재 key값이 존재하지만 화면이 보여지지 않으므로 순번을 1더하여 지정
                                jsonNo = Number(jsonNo) + 1;
                            }
                        });

                    });
                }
            }
            //다음 id 구하기
            var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
            //다음 오소 포커스 지정
            $("#" + nextElementId).click().focus().select();
        },
        leftEvent: function (obj) {
            //현재 input id 확인
            var curElementId = $(obj).attr('id');
            //input id 정보 자르기
            var arrElement = curElementId.split('_');
            //새로운 아이디 부여
            var curRowNumber = Number(arrElement[1]);
            var newRowNumber = Number(arrElement[2]) - 1;

            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');

            //json 리스트에 존재하는 key 확인
            var jsonTableName = currentTableId;
            //each문에서 현재 아이디와 일치여부를 확인하기 위한 변수 선언
            var jsonNo = -1;
            //다음 요소 엘리먼트 아이디 변수 선언 
            var nextEleId = '';
            //역순으로 정렬한 jsonList 생성
            var jsonList = JSON.parse(JSON.stringify(focusJsonList[jsonTableName]));
            //each문에서 현재 아이디와 일치여부를 확인하기 위한 변수 선언
            var jsonNo = -1;
            $.each(jsonList.reverse(), function (jsonName, item) {
                if (jsonNo === -1) {
                    if (item.id === arrElement[0]) {
                        jsonNo = item.no;
                        jsonNo = Number(jsonNo) - 1;
                    }
                } else {
                    if (item.no == jsonNo) {
                        if (item.displayClass === '') {
                            nextEleId = item.id;
                            newRowNumber = item.no;
                            //다음 요소 헬프데스크 지정
                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            return false;
                        } else {
                            jsonNo = Number(jsonNo) - 1;
                        }
                    }
                }
            });
            //다음 id 구하기
            var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
            //다음 오소 포커스 지정
            $("#" + nextElementId).click().focus().select();
        },
        upEvent: function (obj) {
            //현재 input id 확인
            var curElementId = $(obj).attr('id');
            //input id 정보 자르기
            var arrElement = curElementId.split('_');
            //새로운 아이디 부여
            var curRowNumber = Number(arrElement[1]) - 1;
            var newRowNumber = Number(arrElement[2]);
            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');
            //다음 요소 엘리먼트 아이디 변수 선언 
            var nextEleId = arrElement[0];
            //다음 id 구하기
            var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;

            while (true) {
                var displayYN = ($("#" + nextElementId).parent().parent().css('display') || '');

                if (displayYN != 'none') {
                    break;
                }
                curRowNumber = Number(curRowNumber) - 1;
                nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
            }
            //다음 오소 포커스 지정
            $("#" + nextElementId).click().focus().select();
        },
        rightEvent: function (obj) {
            //현재 input id 확인
            var curElementId = $(obj).attr('id');
            //input id 정보 자르기
            var arrElement = curElementId.split('_');
            //새로운 아이디 부여
            var curRowNumber = Number(arrElement[1]);
            var newRowNumber = Number(arrElement[2]) + 1;
            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');
            //json 리스트에 존재하는 key 확인
            var jsonTableName = currentTableId;
            //다음 요소 엘리먼트 아이디 변수 선언 
            var nextEleId = '';
            //each문에서 현재 아이디와 일치여부를 확인하기 위한 변수 선언
            var jsonNo = -1;

            $.each(focusJsonList[jsonTableName], function (jsonName, item) {
                if (jsonNo === -1) {
                    if (item.id === arrElement[0]) {
                        jsonNo = item.no;
                        jsonNo = Number(jsonNo) + 1;
                    }
                } else {
                    if (item.no == jsonNo) {
                        if (item.displayClass === '') {
                            nextEleId = item.id;
                            newRowNumber = item.no;
                            //다음 요소 헬프데스크 지정
                            $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                            return false;
                        } else {
                            jsonNo = Number(jsonNo) + 1;
                        }
                    }
                }
            });

            //다음 id 구하기
            var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
            //다음 오소 포커스 지정
            $("#" + nextElementId).click().focus().select();

        },
        downEvent: function (obj) {
            //현재 input id 확인
            var curElementId = $(obj).attr('id');
            //input id 정보 자르기
            var arrElement = curElementId.split('_');
            //새로운 아이디 부여
            var curRowNumber = Number(arrElement[1]) + 1;
            var newRowNumber = Number(arrElement[2]);
            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');
            //다음 요소 엘리먼트 아이디 변수 선언 
            var nextEleId = arrElement[0];
            //다음 id 구하기
            var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;

            while (true) {
                var displayYN = ($("#" + nextElementId).parent().parent().css('display') || '');

                if (displayYN != 'none') {
                    break;
                }
                curRowNumber = Number(curRowNumber) + 1;
                nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
            }

            //다음 오소 포커스 지정
            $("#" + nextElementId).click().focus().select();
        },
        codeHelperEvent: function (obj) {
            //현재 테이블 요소 셀렉터
            var currentElement = $(obj).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();
            //현재 테이불 아이디 확인
            var currentTableId = $(currentElement).attr('id');
            //현재 input id 확인
            var curElementId = $(obj).attr('id');
            //input id 정보 자르기
            var arrElement = curElementId.split('_');
            //json 리스트에 존재하는 key 확인
            var jsonTableName = currentTableId;
            //each문에서 현재 아이디와 일치여부를 확인하기 위한 변수 선언
            var jsonNo = -1;
            $.each(focusJsonList[jsonTableName], function (jsonName, item) {
                if (item.id === arrElement[0]) {
                    if (item.codeHelperYN === 'Y') {
                        if (window.hasOwnProperty(item.popupCustLoadFunc)) {
                            if (typeof window[item.popupCustLoadFunc] === 'function') {
                                item.tableId = jsonTableName;
                                window[item.popupCustLoadFunc]($(obj).attr('id'), item);
                            }
                        }
                    }
                }
            });
        }
    }

    //REG KEY EVENT FUNCTION
    fnRegUCTableKeyEvent = function (e) {
        //Must check json list variable
        if (focusJsonList == undefined) {
            return false;
        }

        // console.log('Enter key event');
        //PREVENT THIS FUNCTION OF EVENT BUBBLING PREVENT
        //		var evt = e || window.event;
        //	    if(evt.stopPropagation) {
        //	        evt.stopPropagation();  // W3C 표준
        //	    }
        //	    else { 
        //	        evt.cancelBubble = true; // 인터넷 익스플로러 방식
        //	    }

        //KEY EVENT DELETE
        $('.td_inp').unbind('keydown');

        //INPUT KEY EVET BIND(KEYDOWN)
        $('.td_inp').on('keydown', function (e) {
            switch (e.keyCode) {
                /* ENTER EVENT */
                case 13:
                    pKey.enterEvent(this);
                    break;
                    /* LEFT ARROW EVENT */
                case 37:
                    pKey.leftEvent(this);
                    break;
                    /* UP ARROW EVENT */
                case 38:
                    pKey.upEvent(this);
                    break;
                    /* RIGHT ARROW EVENT */
                case 39:
                    pKey.rightEvent(this);
                    break;
                    /* DOWN ARROW EVENT */
                case 40:
                    pKey.downEvent(this);
                    break;
                    /* F2 EVENT */
                case 113:
                    pKey.codeHelperEvent(this);
                    break;
                default:
                    break;

            }
        });
    }

    fnRegUCTableCodePopKeyEvent = function (e, pLocationId, pCodePopDataId, pInputPopDataId, pHeadJsonData, pCodeTableType) {
        //PREVENT THIS FUNCTION OF EVENT BUBBLING PREVENT
        var evt = e || window.event;
        if (evt.stopPropagation) {
            evt.stopPropagation(); // W3C 표준
        } else {
            evt.cancelBubble = true; // 인터넷 익스플로러
        }

        //코드도움 테이블 명 저장
        var locationId = pLocationId + "_TABLE";

        //코드도움2 테이블 명 저장
        var otherLocationId = pLocationId + "_TRDATA";

        //히든 코드 도움창 json 정보
        var jsonDataId = pCodePopDataId;

        //히든 인풋(셀) json 정보
        var jsonInputDataId = pInputPopDataId;

        //코드그리드헤더 정보
        var headJson = pHeadJsonData;

        //코드테이블 타입정보
        var codeTableType = pCodeTableType;

        //KEY EVENT DELETE
        $('.UCSearch').unbind();
        //$('.onSel').unbind();
        $('#' + locationId).unbind();

        //INIT FOCUS ELEMENT
        //$('.UCSearch').focus();

        //선택한 데이터에 대한  더블클릭 이벤트
        /*$('.onSel').on('click', function(e){
        	fnSelectRow();
        });*/

        //INPUT KEY EVET BIND(KEYDOWN)
        $('.UCSearch').on('keydown', function (e) {
            switch (e.keyCode) {
                /* ENTER EVENT */
                case 13:
                    fnSearchStr(jsonDataId, $(".UCSearch").val(), locationId, headJson, codeTableType);
                    $("#" + locationId).find('TR').eq(0).click().focus();
                    return false;
                    break;
                    /* LEFT ARROW EVENT */
                case 37:
                    break;
                    /* UP ARROW EVENT */
                case 38:
                    $("#" + locationId).find('.onSel').prev().click().focus();
                    return false;
                    break;
                    /* RIGHT ARROW EVENT */
                case 39:

                    break;
                    /* DOWN ARROW EVENT */
                case 40:
                    $("#" + locationId).find('.onSel').next().click().focus();
                    return false;
                    break;

                default:
                    $('.UCSearch').focus();
                    break;

            }
        });


        //TABLE KEY EVET BIND(KEYDOWN)
        $('#' + locationId).on('keydown', function (e) {
            switch (e.keyCode) {
                /* ENTER EVENT */
                case 13:
                    fnSelectRow();
                    break;
                    /* LEFT ARROW EVENT */
                case 37:
                    break;
                case 38:
                    $("#" + locationId).find('.onSel').prev().click().focus();
                    return false;
                    //console.log($("#" + locationId).find('.onSel').prev().prop('data'));
                    break;
                    /* RIGHT ARROW EVENT */
                case 39:
                    break;
                    /* DOWN ARROW EVENT */
                case 40:
                    $("#" + locationId).find('.onSel').next().click().focus();
                    return false;
                    break;

                default:
                    $('.UCSearch').focus();
                    break;
            }
        });

        //TABLE KEY EVET BIND(KEYDOWN)
        $('#' + otherLocationId).on('keydown', function (e) {
            switch (e.keyCode) {
                /* ENTER EVENT */
                case 13:
                    fnSelectRow();
                    break;
                    /* LEFT ARROW EVENT */
                case 37:
                    break;
                case 38:
                    $("#" + otherLocationId).find('.onSel').prev().click().focus();
                    return false;
                    //console.log($("#" + locationId).find('.onSel').prev().prop('data'));
                    break;
                    /* RIGHT ARROW EVENT */
                case 39:
                    break;
                    /* DOWN ARROW EVENT */
                case 40:
                    $("#" + otherLocationId).find('.onSel').next().click().focus();
                    return false;
                    break;

                default:
                    //  $('.UCSearch').focus();
                    break;
            }
        });


        //Search json Data on hidden json value
        function fnSearchStr(jsonDataId, searchStr, tableName, headJson, codeTableType) {
            if (searchStr.length > 0) {
                var data = $("#" + jsonDataId).val();
                var jsonArr = JSON.parse(data);
                var resultJsonArr = [];
                for (var i = 0; i < jsonArr.length; i++) {
                    $.each(jsonArr[i], function (key, value) {
                        if (value.indexOf(searchStr) !== -1) {
                            resultJsonArr.push(jsonArr[i]);
                        }
                    });
                }
                // console.log(resultJsonArr);
                $("#" + tableName).empty();
                tableName = tableName.replace('_TABLE', '');
                $.devTable.addrowCodeData(headJson, resultJsonArr, codeTableType, tableName)

            } else {
                var data = $("#" + jsonDataId).val();
                var jsonArr = JSON.parse(data);
                $("#" + tableName).empty();
                // console.log(jsonArr);
                tableName = tableName.replace('_TABLE', '');
                $.devTable.addrowCodeData(headJson, jsonArr, codeTableType, tableName)
            }
        }

        //SELECT ROW EVENT FUNCTION 
        function fnSelectRow() {
            var eleSelect = $("#" + locationId).find('.onSel');
            //코드도움2인경우 아래 아이디로 지정한다.
            if (eleSelect.length == 0) {
                eleSelect = $("#" + otherLocationId).find('.onSel');
            }

            var rowData = $(eleSelect).prop('data');
            var popInfo;

            //개발시 로직을 분기한다.
            if ($("#" + jsonInputDataId).val() != "") {
                popInfo = JSON.parse($("#" + jsonInputDataId).val());
            }

            if (popInfo != undefined) {
                var eleId = popInfo.bindId;
                //팝업 바인드 함수 호출 
                if (popInfo.popupCustBindFunc !== '') {
                    //테이블 바인드 아이디, 로우데이터
                    window[popInfo.popupCustBindFunc](eleId, rowData);
                }
                var arrElement = eleId.split('_');
                var curRowNumber = Number(arrElement[1]);
                var newRowNumber = Number(arrElement[2]) + 1;

                var jsonNo = -1
                var nextEleId = '';

                $.each(focusJsonList[popInfo.tableId], function (index, item) {
                    if (jsonNo === -1) {
                        if (item.id === popInfo.id) {
                            //이전값 저장
                            //item.value = rowData.reachPrj;
                            //다음요소를 찾기위한 순번저장, /마지막 요소가 아니라면
                            if (item.tail == 'Y') {
                                return false;
                            } else if (item.tail == 'N') {
                                //현재 each문에 존재하는 순번 저장
                                jsonNo = item.no;
                                //다음 json 요소 순번 지정 
                                jsonNo = Number(jsonNo) + 1;
                            }

                        }
                    } else {
                        //지정한 요소 순번과 일치
                        if (item.no == jsonNo) {
                            //반복문내 현재 key 화면에 보여지다면
                            if (item.displayClass === '') {
                                //다음 요소 id 지정 
                                nextEleId = item.id;
                                newRowNumber = item.no;
                                //다음 요소 헬프데스크 지정
                                $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                                return false;
                            } else {
                                if (item.tail == 'N') {
                                    jsonNo = item.no;
                                    //다음 json 요소 순번 지정 
                                    jsonNo = Number(jsonNo) + 1;
                                }
                            }
                        }
                    }
                });

                //엘리먼트가 존재하지 않고 다음 순번의 엘리먼트 요소를 찾지 못하였다면 다음 테이블의 첫번째 row로 이동
                if (nextEleId === '' && jsonNo === -1)
                //if(nextEleId === '')
                {
                    //다음 테이블 정보
                    var nextJsonInfo;
                    //전체 테이블 포커스 카운트
                    var focusTableTotalCount = focusJsonList['arrfocusKey'].length;
                    //현재 포커스한 자신의 테이블 정보를 가져온다.					
                    $.each(focusJsonList['arrfocusKey'], function (index, item) {
                        if (item.key === popInfo.tableId) {
                            nextJsonInfo = item;
                            return false;
                        }

                    });
                    //현재 테이블 정보에서 연결된 테이블 정보가 존재한다면 포커스를 이동한다.
                    if (typeof nextJsonInfo == 'object') {
                        //다음 테이블 정보에 대한 변수 선언
                        var tableInfo = nextJsonInfo.linkInfo;
                        //테이블 정보를 통한 포커스 이동(연결된 테이블이 여러개 일 수 있기 때문에 로우를 생성한 후 포커스를 이동 linkinfo는 json array이다. 
                        $.each(tableInfo, function (index, info) {
                            if (focusJsonList[info.linkTableName] == undefined) {
                                return;
                            }
                            //json array를 순차적으로 실행한다.
                            $.each(focusJsonList[info.linkTableName], function (jsonName, item) {
                                //컬럼을 화면에 표시하는 여부
                                if (item.displayClass === '') {
                                    //연결된 테이블의 row를 새로 생성하는지 옵션 여부
                                    if (info.autoCreateRow === 'Y') {
                                        //새로운 테이블의 포커스엘리먼트아이디 확인
                                        var nextElementId = '';

                                        if (info.linkTableName === info.myTableName) { //자기자신의 테이블로 연결되어 있다면 로우 추가											
                                            //console.log($(obj).parent().parent().index());							
                                            var eleGroupTR = $('#' + info.linkTableName + '_TRDATA').find("TR[class^=" + groupClass + "]");

                                            $.each(eleGroupTR, function (index, item) {
                                                if ($(item).index() > $("#" + popInfo.bindId).parent().parent().index()) {
                                                    var eleId = $(item).find('input').eq(0).attr('id');
                                                    var arrIdInfo = eleId.split('_');
                                                    nextEleId = arrIdInfo[0];
                                                    curRowNumber = arrIdInfo[1];
                                                    newRowNumber = arrIdInfo[2];
                                                    nextElementId = eleId;
                                                }
                                            });


                                            if (nextElementId === '') {
                                                window[info.tableRowNumVariableName] = Number(window[info.tableRowNumVariableName]) + 1;
                                                curRowNumber = window[info.tableRowNumVariableName];
                                                $.devTable.addrow(info.linkTableName, info.linkJsonData, info.linkTableType, info.linkParentElementId, window[info.tableRowNumVariableName]);
                                                fnRegUCTableKeyEvent();
                                            }

                                        } else { //자기자신이 아니라면 클래스를 찾은 후 존재하면 해당행으로 이동 아니라면 생성
                                            var eleGroup = $("#" + info.linkTableName).find('table tr' + '.' + groupClass);
                                            //엘리먼트가 존재하지 않으면
                                            if (eleGroup.length <= 0) {
                                                //row카운트 수 증가
                                                window[info.tableRowNumVariableName] = Number(window[info.tableRowNumVariableName]) + 1;
                                                curRowNumber = Number(window[info.tableRowNumVariableName]);
                                                nextElementId = item.id + '_' + curRowNumber + '_' + item.no;
                                                //row 생성
                                                $.devTable.addrow(info.linkTableName, info.linkJsonData, info.linkTableType, info.linkParentElementId, window[info.tableRowNumVariableName]);
                                                //key 이벤트 등록
                                                fnRegUCTableKeyEvent();
                                            } else {
                                                $.each(eleGroup, function (index, value) {
                                                    if ($(value).find('input:checkbox').length <= 0) {
                                                        nextElementId = $(value).find('input').eq(0).attr('id');
                                                        var arrInfo = nextElementId.split('_');
                                                        curRowNumber = arrInfo[1];
                                                        return false;
                                                    }
                                                });
                                            }
                                        }

                                    }
                                    //연결된 링크이 테이블에 대해 포커스 지정 여부 확인
                                    if (info.focusYN === 'Y') {
                                        //포커스로 지정할 아이디 
                                        nextEleId = item.id;
                                        //새로 생성한 row 넘저 지정
                                        newRowNumber = item.no;
                                        //포커스 헬프데스크 지정
                                        $("#" + txtHelpMsgElementId).html(item.helpDeskMessage);
                                    }
                                    return false;
                                } else {
                                    //반복문내 현재 key값이 존재하지만 화면이 보여지지 않으므로 순번을 1더하여 지정
                                    jsonNo = Number(jsonNo) + 1;
                                }
                            });

                        });
                    }
                }

                //팝업닫기
                var eleSelect = $("#" + locationId).find('.onSel');
                if (eleSelect.length > 0) {
                    //레이어팝업 정보 초기화
                    //$("#divCodeHelperPop").css('display', 'none');
                    $("#" + locationId).parents("div").filter(".divTopPopup").css('display', 'none');
                    $("#" + pLocationId).empty();
                    $("#" + jsonInputDataId).val('');
                    $("#" + jsonDataId).val('');
                    $(".UCSearch").val('');
                    //$("#txtCodeSearch").val('');
                } else if ($("#" + otherLocationId).find('.onSel').length > 0) {
                    //$("#divTaxCodeHelperPop").css('display', 'none');
                    $("#" + otherLocationId).parents("div").filter(".divTopPopup").css('display', 'none');
                    $("#" + otherLocationId).empty();
                    $("#" + jsonInputDataId).val('');
                    $("#" + jsonDataId).val('');
                }

                //KEY EVENT DELETE
                $('.UCSearch').unbind();
                $('.onSel').unbind();
                if (eleSelect.length > 0) {
                    $('#' + locationId).unbind();
                } else {
                    $('#' + otherLocationId).unbind();
                }

                //다음 id 구하기
                var nextElementId = nextEleId + '_' + curRowNumber + '_' + newRowNumber;
                //다음 요소 강제 클릭 
                $("#" + nextElementId).click().focus().select();
            }
            return;
        }

    }

})(jQuery)
