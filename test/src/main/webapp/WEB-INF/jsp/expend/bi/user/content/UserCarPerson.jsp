<%--
todo
- rowData null 처리
- 차량선택 팝업 - 
- 운행기록부 운행구분 기획 확인 직접 입력 추가 , 즐겨찾기 삭제

? 직업입력 데이터 관련
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!-- iframe wrap -->
<div class="iframe_wrap">
	<input type="hidden" id="hidCarNbInfo" />
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>조회기간</dt>
			<dd>
				<div class="dal_div">
					<input type="text" id="useDateFrom" value="" class="w113" readonly />
					<a href="#n" class="button_dal"></a>
				</div>
				~
				<div class="dal_div">
					<input type="text" id="useDateTo" value="" class="w113" readonly />
					<a href="#n" class="button_dal"></a>
				</div>
			</dd>
			<dt>차량</dt>
			<dd>
				<input class="input_search fl" id="selCarNb" type="text" value="" style="width:130px;" placeholder="+ 버튼을 눌러주세요.">
				<a id="btnSelectCar" href="#" class="btn_add"></a>
			</dd>
			<dt class="ml40">전송여부</dt>
			<dd>
				<select class="selectmenu" style="width:80px;">
					<option value="" selected="selected">전체</option>
					<option value="">전송</option>
					<option value="">미전송</option>
				</select>
			</dd>
			<dd><input type="button" id="btnSearch" value="검색" /></dd>
		</dl>
	</div>

	<div class="sub_contents_wrap posi_re">
		<!-- 관리부서 -->
		<div class="btn_div">
			<div class="right_div">
				<div class="controll_btn p0">
					<button id="btnAddRow">행추가</button>
					<button id="btnRemoveRow">행삭제</button>
					<%--<button id="btnBookmark">즐겨찾기</button>--%>
					<%--<button id="btnExcel">엑셀저장</button>--%>
					<%--<button id="btnUpload">업로드</button>--%>
					<button id="btnClose">마감</button>
					<%--<button id="btnCloseCancel">마감취소</button>--%>
					<%--<button id="" style="display: none;">주행거리 검색(F6)</button>--%>
					<%--<button id="" style="display: none;">안분(F7)</button>--%>
					<%--<button id="" style="display: none;">복사</button>--%>
					<%--<button id="" style="display: none;">재계산</button>--%>
				</div>
			</div>
		</div>
		<!-- ////////////////////////////////////////////////////////////////////////////////////////////// -->

		<div id="tblInputBizCarHistory"></div>
		
		<div class="vehicles_detail clear">
			<dl class="fl clear" style="width: 50%;">
				<dt class="tit_p" style="width: 100px;">출발지 상세주소</dt>
				<dd style="width: 65%;">
					<input style="width: 100%;" type="text" id="" />
				</dd>
			</dl>
			<dl class="fr clear" style="width: 50%;">
				<dt class="tit_p" style="width: 100px;">도착지 상세주소</dt>
				<dd style="width: 65%;">
					<input style="width: 100%;" type="text" id="" />
				</dd>
			</dl>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->



<link rel="stylesheet" type="text/css" href='<c:url value="/js/jqueryui/jquery-ui.css"></c:url>'>
<script type="text/javascript" src='<c:url value="/js/common/jquery.dtable-1.0.3.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/common/jquery.codelayer.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.mask.min.js"></c:url>'></script>

<%--<script type="text/javascript" src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>--%>
<%--<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery.min.js"></c:url>'></script>--%>
<script type="text/javascript" src='<c:url value="/js/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/css/recalendar.css"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/common/jquery.date-1.0.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/common/jquery-neos-common-1.0.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/common/jquery.codetable-1.0.0.js"></c:url>'></script>


<script type="text/javascript">
    $ ( document ).ready ( function ( ) {
        fnInit ( );
        /* 임시 데이터 insert ajax 연동 후 삭제 예정 */
        $ ( "#hidCarNbInfo" ).val ( '[{"carCode":"1111","carNb":"1가 1111"}]' );
        $ ( "#selCarNb" ).val ( "1111" );
        $ ( "#btnSearch" ).click ( );

    } );

    /* 초기화 */
    function fnInit ( ) {
        fnInitLayout ( );
        fnInitMouseEvent ( );
        fnInitKeyEvent ( );
    }

    /* 레이아웃 초기화 */
    function fnInitLayout ( ) {
        $ ( "#useDateFrom, #useDateTo" ).kendoDatePicker ( {
            culture: "ko-KR",
            format: "yyyy-MM-dd"
        } );

        var datePicker = $ ( "#useDateFrom, #useDateTo" );
        datePicker.kendoMaskedTextBox ( {
            mask: '0000-00-00'
        } );
        datePicker.closest ( ".k-datepicker" ).add ( datePicker ).removeClass ( 'k-textbox' );

        /* 오늘을 기준으로 from >> 동년, 동월, 01 */
        /* 오늘을 기준으로 to >> 동년, 동월, 동일 */
        var dt = new Date ( );
        //$ ( '#useDateFrom' ).val ( [ dt.getFullYear ( ), ( ( Number ( dt.getMonth ( ) ) + 1 ) < 10 ? [ '0', ( Number ( dt.getMonth ( ) ) + 1 ) ].join ( '' ) : ( dt.getMonth ( ) + 1 ) ), '01' ].join ( '-' ) );
        $ ( '#useDateFrom' ).val("2017-01-01");
        $ ( '#useDateTo' ).val ( [ dt.getFullYear ( ), ( ( Number ( dt.getMonth ( ) ) + 1 ) < 10 ? [ '0', ( Number ( dt.getMonth ( ) ) + 1 ) ].join ( '' ) : ( dt.getMonth ( ) + 1 ) ), ( ( dt.getDate ( ) + '' ).length == 2 ? dt.getDate ( ) : '0' + dt.getDate ( ) ) ].join ( '-' ) );

        return;
    }

    /* 마우스 이벤트 초기화 */
    function fnInitMouseEvent ( ) {
        /* 검색 클릭 */
        $ ( "#btnSearch" ).click ( function ( ) {
            fnCarPersonSelect ( );
        } );
        /* 즐겨찾기 클릭 */
        $ ( "#btnBookmark" ).click ( function ( ) {
            fnOpenBookmark ( );
        } );
        /* 엑셀저장 클릭 */
        $ ( "#btnExcel" ).click ( function ( ) {

        } );
        /* 업로드 클릭 */
        $ ( "#btnUpload" ).click ( function ( ) {

        } );
        /* 마감 클릭 */
        $ ( "#btnClose" ).click ( function ( ) {
            fnCarPersonCancel ( 1 );
        } );
        /* 마감취소 클릭 */
        $ ( "#btnCloseCancel" ).click ( function ( ) {
            fnCarPersonCancel ( 0 );
        } );

        $('#btnAddRow').click(function() {
            /* 차량 선택 여부 확인 */
            $('#tblInputBizCarHistory').dtable('rowSetAddData', []);
        });
    }

    /* 키 이벤트 초기화 */
    function fnInitKeyEvent ( ) {
        $ ( "#useDateFrom, #useDateTo" ).keydown ( function ( event ) {
            if ( event.keyCode === 13 ) {
                $ ( '#btnSearch' ).click ( );
            }
        } );
    }

    /* 차량 선택 팝업 */
    $('#btnSelectCar').click(function() {
        fnCarSelectPop();
    });

    /* function - 차량선택팝업 */
    function fnCarSelectPop() {
        var intWidth = '403';
        var intHeight = 696;
        var agt = navigator.userAgent.toLowerCase();

        if (agt.indexOf("safari") != -1) {
            intHeight = intHeight - 70;
        }

        var intLeft = screen.width / 2 - intWidth / 2;
        var intTop = screen.height / 2 - intHeight / 2 - 40;

        if (agt.indexOf("safari") != -1) {
            intTop = intTop - 30;
        }
        var url = "<c:url value="/bi/car/CarSelectPop.do"></c:url>";
        window.open(url, 'AppPop',
            'menubar=0,resizable=0,scrollbars=0,status=no,titlebar=0,toolbar=no,width='
            + intWidth + ',height=' + intHeight + ',left='
            + intLeft + ',top=' + intTop);
    }
    
    function fnReceivePopupData(responseData){
        console.log("### responseData =>"+JSON.stringify(responseData));
	}

    /* 운행기록현황 조회  */
    /* 필요 파라미터 useDateFrom, useDateTo, carCode(예 : 111','333','222 이런식으로), closeYN(미마감:0, 마감:1) */
    function fnCarPersonSelect ( ) {
        console.log("### fnCarPersonSelect");
        var param = {};
        param.useDateFrom = $ ( "#useDateFrom" ).val ( ).toString ( ).replace ( /-/g, '' );
        ;
        param.useDateTo = $ ( "#useDateTo" ).val ( ).toString ( ).replace ( /-/g, '' );
        ;
        /* 선택 전체의 경우는 hidCarNbInfo에 있는 리스트의 carNb값을 넣어준다. 
            조회 쿼리의 경우 IN 검색이므로 ' 기호 넣어서 구분준다.
         */
        if ( $ ( "#selCarNb" ).val ( ) == '선택 전체' ) {
            var tCarNb = JSON.parse ( $ ( "hidCarNbInfo" ).val ( ) );
            var cLength = tCarNb.length;
            var carCode = "";
            for ( var i = 0; i < cLength; i++ ) {
                carCode += tCarNb [ i ].carCode + "','";
            }
            if ( carCode != "" ) {
                carCode = carCode.subStr ( 0, carCode.length - 2 );
            }
            param.carCode = carCode;
        } else if ( $ ( "#selCarNb" ).val ( ) == '' ) {
            /* 선택한 차량이 존재하지 않으므로 조회 진행하지 않는다. */
            return false;
        } else {
            /* 선택한 차량이 한건인 경우 */
            param.carCode = $ ( "#selCarNb" ).val ( );
        }
        param.closeYN = $ ( "#selCloseYN" ).val ( );

        $.ajax ( {
            type: 'post',
            url: '<c:url value="/bi/user/car/BiUserCarPersonListSelect.do"/>',
            datatype: 'json',
            async: true,
            data: param,
            success: function ( data ) {
                /* 데이터 바인딩 */
                fnBindingData ( ( data.result || '{}' ) );
            },
            error: function ( data ) {
                return;
            }
        } );
    }
    /* 운행기록부 리스트 바인딩 */
    function fnBindingData ( result ) {
        var data = ( result.aaData || '{}' );

        for(var i=0; i<result.aaData.length; i++){
            var rowData = data[i];
            console.log("### erpCoCd => "+rowData.erpCoCd);
            console.log("### compSeq => "+rowData.compSeq);

            fnPushTableOptionsData(rowData);
        }

        /* table init */
        $('#tblInputBizCarHistory').dtable(tableOptions);
    }
    
    function fnPushTableOptionsData(data){
        tableOptions.data.push(
            ['', data.carName, data.cardCode, data.carNumber, data.carName, data.useDate, data.useDateYear, data.useDateMonth, data.useDateDay, data.useFlag, data.useFlagCode, data.useFlagName, data.startTime, data.startTimeH, data.startTimeM, data.endTime, data.endTimeH, data.endTimeM, data.startFlag, data.startFlagCode, data.startFlagName, data.startAddr, data.endFlag, data.endFlagCode, data.endFlag, data.endAddr, data.mileageKm, data.beforeKm, data.afterKm, data.rmkCode, data.rmkName]
        )
    }

    /* 마감/취소  */
    /* 필수 파라미터 closeYN(0:취소, 1:마감), carCode, useDate, seqNumber */
    function fnCarPersonCancel ( closeYN ) {
        /* 다중 선택이 가능하므로 반복문 돌려서 처리 진행 */
        var carCode = '';
        var useDate = '';
        var seqNb = '';
        /* 반복 시작 */
        var param = {};
        param.closeYN = closeYN;
        param.carCode = carCode;
        param.useDate = useDate;
        param.seqNumber = seqNb;
        $.ajax ( {
            type: 'post',
            url: '<c:url value="/bi/user/car/BiUserCarPersonClose.do"/>',
            datatype: 'json',

            async: true,
            data: param,
            success: function ( data ) {
            },
            error: function ( data ) {
                return;
            }
        } );
    }

    /* 즐겨찾기 등록 팝업 */
    function fnOpenBookmark ( ) {
        window.open ( url, 'AppDoc', 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop );
    }

    var tableOptions = {
        layout: ['lht', 'rht', 'lct', 'rct', 'mr'],
        colHeaders: ['[checkbox_all]', '차량', '차량코드', '차량번호', '차종', '운행일자', '운행일자-년', '운행일자-월', '운행일자-일', '운행구분', '운행구분코드', '운행구분명', '출발시간', '출발시간-시', '출발시간-분', '도착시간', '도착시간-시', '도착시간-분', '출발구분', '출발구분코드', '출발구분명', '출발지', '도착구분', '도착구분코드', '도착구분명', '도착지', '주행', '주행전', '주행후', '코드', '비고'],
        colKeys: ['', 'carName', 'carCode', 'carNumber', 'carName', 'useDate', 'useDateYear', 'useDateMonth', 'useDateDay', 'useFlag', 'useFlagCode', 'useFlagName', 'startTime', 'startTimeH', 'startTimeM', 'endTime', 'endTimeH', 'endTimeM', 'startFlag', 'startFlagCode', 'startFlagName', 'startAddr', 'endFlag', 'endFlagCode', 'endFlag', 'endAddr', 'mileageKm', 'beforeKm', 'afterKm', 'rmkCode', 'rmkName'],
        colReq: ['N', 'Y', 'N', 'N', 'N', 'Y', 'N', 'N', 'N', 'Y', 'N', 'N', 'Y', 'N', 'N', 'Y', 'N', 'N', 'Y', 'N', 'N', 'Y', 'Y', 'N', 'N', 'Y', 'Y', 'N', 'N', 'N', 'N'],
        colLeftFixed: 18,
        colWidth: [34],
        colAlignments: ['cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'le', 'cen', 'cen', 'cen', 'le', 'ri', 'ri', 'ri', 'cen', 'le'],
        columns: [{
            header: 'checkbox_all',
            key: '',
            type: 'checkbox'
        }, {
            header: '차량',
            key: 'carName',
            type: 'autocomplete',
            url: '',
            name: ['carCode', '. ', 'carNumber', ' (', 'carName', ')'],
            source: [{ 
                'carCode': 'A0001',
                'carNumber': '01가1234',
                'carName': 'K5'
            }, {
                'carCode': 'A0002',
                'carNumber': '02가1234',
                'carName': 'LF소나타'
            }, {
                'carCode': 'A0003',
                'carNumber': '03가1234',
                'carName': '모닝'
            }]
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'date'
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            header: '운행구분',
            key: 'userFlag',
            type: 'autocomplete',
            url: '',
            name: ['useFlagCode', '. ', 'useFlagName'],
            source: [{
                'useFlagCode': '1',
                'useFlagName': '출근'
            }, {
                'useFlagCode': '2',
                'useFlagName': '퇴근'
            }, {
                'useFlagCode': '3',
                'useFlagName': '출/퇴근'
            }, {
                'useFlagCode': '4',
                'useFlagName': '업무용'
            }, {
                'useFlagCode': '5',
                'useFlagName': '비업무용'
            }]
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'time',
            mask: '__:__',
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'time',
            mask: '__:__'
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'autocomplete',
            name: ['startFlagCode', '. ', 'startFlagName'],
            source: [{
                'startFlagCode': '0',
                'startFlagName': '직접입력',
                'startAddr': ''
            }, {
                'startFlagCode': '1',
                'startFlagName': '회사',
                'startAddr': '강원도 춘천시 남산명 수동리'
            }, {
                'startFlagCode': '2',
                'startFlagName': '자택',
                'startAddr': '강원도 춘천수 후평동'
            }, {
                'startFlagCode': '3',
                'startFlagName': '거래처',
                'startAddr': '서울특별시 강남구 대치동'
            }, {
                'startFlagCode': '4',
                'startFlagName': '직전도착지',
                'startAddr': ''
            }, {
                'startFlagCode': '5',
                'startFlagName': '즐겨찾기',
                'startAddr': ''
            }]
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'text'
        }, {
            type: 'autocomplete',
            name: ['endFlagCode', '. ', 'endFlagName'],
            source: [{
                'endFlagCode': '0',
                'endFlagName': '직접입력',
                'endAddr': ''
            }, {
                'endFlagCode': '1',
                'endFlagName': '회사',
                'endAddr': '강원도 춘천시 남산명 수동리'
            }, {
                'endFlagCode': '2',
                'endFlagName': '자택',
                'endAddr': '강원도 춘천시 후평동'
            }, {
                'endFlagCode': '3',
                'endFlagName': '거래처',
                'endAddr': '서울특별시 강남구 대치동'
            }, {
                'endFlagCode': '4',
                'endFlagName': '직전도착지',
                'endAddr': ''
            }, {
                'endFlagCode': '5',
                'endFlagName': '즐겨찾기',
                'endAddr': ''
            }]
        }, {
            type: 'hidden'
        }, {
            type: 'hidden'
        }, {
            type: 'text'
        }, {
            type: 'text'
        }, {
            type: 'text'
        }, {
            type: 'text'
        }, {
            type: 'hidden'
            /* type: 'autocomplete', */
            /* name: ['useFlagCode', '. ', 'useFlagName'], */
            /* source: [] */
        }, {
            type: 'text'
        }],
        'total': {
            title: '총합계',
            colspan: [0, 5],
            sumCol: [10]
        },
        data: [
            //['', '차량', '차량코드', '차량번호', '차종', '20170829', '운행일자-년', '운행일자-월', '운행일자-일', '운행구분', '운행구분코드', '운행구분명', '09:00', '출발시간-시', '출발시간-분', '21:00', '도착시간-시', '도착시간-분', '출발구분', '출발구분코드', '출발구분명', '출발지', '도착구분', '도착구분코드', '도착구분명', '도착지', '주행', '주행전', '주행후', '코드', '비고']
        ]
    };
</script>