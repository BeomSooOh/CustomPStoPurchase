/**
 * 팝업 호출 관련
 */

(function( $ ) {
    $.fn.setPopup = function( attribute ) {
        return this.each(function() {
            if ($(this).get(0).tagName == 'INPUT' && $(this).get(0).type == 'text') {
                $(this).bind('keypress', function() {
                    if (event.keyCode == 13) {
                        var url = _g_contextPath_;

                        switch (attribute.type) {
                            case popType.emp:
                            	url +=  '/ex/code/org/ExEmpPopup.do';
                                break;
                            case popType.dept:
                                break;
                            case popType.pc:
                                url += '/ex/code/org/ExPcPopup.do';
                                break;
                            case popType.cc:
                                url += '/ex/code/org/ExCcPopup.do';
                                break;
                            case popType.summary:
                                url += '/ex/code/summary/ExSummaryPopup.do';
                                break;
                            case popType.auth:
                                url += '/ex/code/auth/ExAuthPopup.do';
                                break;
                            case popType.project:
                                url += '/ex/code/project/ExProjectPopup.do';
                                break;
                            case popType.card:
                                url += '/ex/code/card/ExCardPopup.do';
                                break;
                            case popType.budget:
                                url += '/ex/code/budget/ExBudgetPopup.do';
                                break;
                            case popType.bizplan:
                                url += '/ex/code/budget/ExBizplanPopup.do';
                                break;
                            case popType.bgacct:
                                url += '/ex/code/budget/ExBgAcctPopup.do';
                                break;
                            case popType.partner:
                                url += '/ex/code/partner/ExPartnerPopup.do';
                                break;
                        }

                        if (url == _g_contextPath_) { return; }
                        url += '?callback=' + (attribute.callback || '');
                        url += '&comp_seq=' + (attribute.comp_seq || '');
                        url += '&from_seq=' + (attribute.form_seq || '');
                        url += '&search_str=';
                        /* 예산단위 사용 */
                        /* 사업계획 사용 */
                        url += '&erp_emp_seq=';
                        /* 사업계획 사용 */
                        url += '&budget_code=';
                        /* 예산계정 사용 */
                        url += '&bizplan_code=';

                        url = url.replace('&search_str=', '&search_str=' + encodeURI($(this).val()));

                        if (typeof attribute.empInfo != 'undefined') {
                            url = url.replace('&erp_emp_seq=', '&erp_emp_seq=' + ($(attribute.empInfo).getJson().erp_emp_seq || ''));
                        }

                        if (typeof attribute.budgetIfno != 'undefined') {
                            url = url.replace('&budget_code=', '&budget_code=' + ($(attribute.budgetIfno).getJson().budget_code || ''));
                            url = url.replace('&bizplan_code=', '&bizplan_code=' + ($(attribute.budgetIfno).getJson().bizplan_code || '***'));
                        }

                        url = encodeURI(url);
                        layerPopOpen(url, '', attribute.title, attribute.width, attribute.height, attribute.opener, attribute.parentId, attribute.childerenId);
                    }
                });
            } else {
                $(this).click(function() {
                    var url = _g_contextPath_;

                    switch (attribute.type) {
                        case popType.emp:
                        	url +=  '/ex/code/org/ExEmpPopup.do';
                            break;
                        case popType.dept:
                            break;
                        case popType.pc:
                            url += '/ex/code/org/ExPcPopup.do';
                            break;
                        case popType.cc:
                            url += '/ex/code/org/ExCcPopup.do';
                            break;
                        case popType.summary:
                            url += '/ex/code/summary/ExSummaryPopup.do';
                            break;
                        case popType.auth:
                            url += '/ex/code/auth/ExAuthPopup.do';
                            break;
                        case popType.project:
                            url += '/ex/code/project/ExProjectPopup.do';
                            break;
                        case popType.card:
                            url += '/ex/code/card/ExCardPopup.do';
                            break;
                        case popType.budget:
                            url += '/ex/code/budget/ExBudgetPopup.do';
                            break;
                        case popType.bizplan:
                            url += '/ex/code/budget/ExBizplanPopup.do';
                            break;
                        case popType.bgacct:
                            url += '/ex/code/budget/ExBgAcctPopup.do';
                            break;
                        case popType.partner:
                            url += '/ex/code/partner/ExPartnerPopup.do';
                            break;
                    }

                    if (url == _g_contextPath_) { return; }
                    url += '?callback=' + (attribute.callback || '');
                    url += '&comp_seq=' + (attribute.comp_seq || '');
                    url += '&from_seq=' + (attribute.form_seq || '');
                    url += '&search_str=';
                    /* 예산단위 사용 */
                    /* 사업계획 사용 */
                    url += '&erp_emp_seq=';
                    /* 사업계획 사용 */
                    url += '&budget_code=';
                    /* 예산계정 사용 */
                    url += '&bizplan_code=';

                    if (typeof attribute.empInfo != 'undefined') {
                        url = url.replace('&erp_emp_seq=', '&erp_emp_seq=' + ($(attribute.empInfo).getJson().erp_emp_seq || ''));
                    }

                    if (typeof attribute.budgetIfno != 'undefined') {
                        url = url.replace('&budget_code=', '&budget_code=' + ($(attribute.budgetIfno).getJson().budget_code || ''));
                        url = url.replace('&bizplan_code=', '&bizplan_code=' + ($(attribute.budgetIfno).getJson().bizplan_code || '***'));
                    }

                    url = encodeURI(url);
                    layerPopOpen(url, '', attribute.title, attribute.width, attribute.height, attribute.opener, attribute.parentId, attribute.childerenId);
                });
            }
        });
    }
})(jQuery);

/* 팝업을 호출하고자하는 버튼의 클래스에 해당되는 클래스를 포함한다. */
var popType = {
    emp : "empPop", /* 사용자 */
    dept : "deptPop", /* 사용부서 */
    pc : "pcPop", /* 회계단위 */
    cc : "ccPop", /* 코스트센터 */
    summary : "summaryPop", /* 표준적요 */
    auth : "authPop", /* 증빙유형 */
    project : "projectPop", /* 프로젝트 */
    card : "cardPop", /* 카드 */
    partner : "partnerPop", /* 거래처 */
    budget : "budgetPop", /* 예산단위 / ERPiU */
    bizplan : "bizplanPop", /* 사업계획 / ERPiU */
    bgacct : "bgacctPop"/* 예산계정 / ERPiU */
}

/* 기본 팝업 attribute 를 생성하여 전달한다. */
function fnGetPopAttribute( attribute, type, callback, title ) {
    var object = {};
    $.extend(object, attribute);

    object.type = type;
    object.title = title;
    object.callback = callback;

    return object;
}

/* Layer close */
function fnCloseLayer() {
    if ($(".pop_wrap_dir").length > 1) {
        layerPopClose('layerCommonCode');
    } else {
        layerPopClose('');
    }
}