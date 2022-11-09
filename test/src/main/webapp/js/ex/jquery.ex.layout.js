/**
 * layout 관련
 */

(function( $ ) {
})(jQuery);

/* 입력항목 표현 처리 */
function fnSetInfoLayout( ifSyste, module, option ) {
    var target = '';

    switch (module) {
        case 'E':
            target = 'Expend';
            break;
        case 'L':
            target = 'ExpendList';
            break;
        case 'S':
            target = 'ExpendSlip';
            break;
        case 'M':
            target = 'ExpendMng';
            break;
    }

    $.each(option, function( idx, item ) {
        if (item.option_gbn == '02') {
            /* 사용자정보 입력 설정 */
            if (item.option_code == '020000' && item.setValue == module) {
                $('.' + ifSystem + '.' + target + 'Emp').show();
            }
            /* 프로젝트정보 입력 설정 */
            if (item.option_code == '020001' && item.setValue == module) {
                $('.' + ifSystem + '.' + target + 'Project').show();
            }
            /* 거래처정보 입력 설정 */
            if (item.option_code == '020002' && item.setValue == module) {
                $('.' + ifSystem + '.' + target + 'Partner').show();
            }
            /* 카드정보 입력 설정 */
            if (item.option_code == '020003' && item.setValue == module) {
                $('.' + ifSystem + '.' + target + 'Card').show();
            }
            /* 기본입력 적요 설정 */
            if (item.option_code == '020004' && item.setValue == module) {
                $('.' + ifSystem + '.' + target + 'BaseNote').show();
            }
        }
    });
}

function fnSetExpendLayout( ifSystem, option ) {
    var option_code = '';

    switch (ifSystem) {
        case 'BizboxA':
            option_code = '020100';
            break;
        case 'iCUBE':
            option_code = '020200';
            break;
        case 'ERPiU':
            option_code = '020300';
            break;
    }

    $.each(option, function( idx, item ) {
        if (item.option_gbn == '02') {
            if (item.option_code == option_code) {
                /* L : List */
                if (item.set_value.indexOf('L') >= 0) {
                    $('.Expend.ExpendList').show();
                    if (codeExpendListViewStat) {
                        codeExpendListViewStat = true;
                    }
                } else {
                    $('.Expend.ExpendList').hide();
                }
                /* S : Slip */
                if (item.set_value.indexOf('S') >= 0) {
                    $('.Expend.ExpendSlip').show();
                    if (codeExpendSlipViewStat) {
                        codeExpendSlipViewStat = true;
                    }
                } else {
                    $('.Expend.ExpendSlip').hide();
                }
                /* M : Mng */
                if (item.set_value.indexOf('M') >= 0) {
                    $('.Expend.ExpendMng').show();
                    if (codeExpendMngViewStat) {
                        codeExpendMngViewStat = true;
                    }
                } else {
                    $('.Expend.ExpendMng').hide();
                }
            }
        }
    });
}