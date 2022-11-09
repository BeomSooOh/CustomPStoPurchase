/* LayerPop */
/* LayerPop - 팝업열기 */

/* layerInfoDef : Layer 호출 기초 데이터 */
var layerInfoDef = {
    baseIndex : "20",
    contentsWrap : {
        "1" : ".sub_contents_wrap",
        "2" : ".pop_sign_wrap",
        "4" : ".pop_sign_wrap",
        "default" : "#_PARENTCLASS_"
    },
    contentsDiv : {
        "1" : "<div id='modal' class='modal;></div>",
        "2" : "<div id='modal' class='modal;></div>",
        "4" : "<div id='modal' class='modal' style='height:_MODALHEIGHT_px;'></div>",
        "default" : "<div id='modal__CHILDRENCLASS_' class='modal'></div>"
    },
    childrenWrap : {
        "1" : ".pop_wrap_dir",
        "2" : ".pop_wrap_dir"
    },
    popInfo : {
        list : {
            url : _g_contextPath_ + "/ex/expend/list/ExUserListPop.do",
            title : "항목"
        },
        slip : {
            url : _g_contextPath_ + "/ex/expend/slip/ExUserSlipPop.do",
            title : "분개"
        },
        mng : {
            url : _g_contextPath_ + "/ex/expend/mng/ExUserMngPop.do",
            title : "관리항목"
        },
        emp : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserEmpPop.do",
            title : "사용자"
        },
        pc : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserPcPop.do",
            title : "회계단위"
        },
        cc : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserCcPop.do",
            title : "코스트센터"
        },

        budget : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserBudgetPop.do",
            title : "예산단위"
        },
        bizplan : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserBizplanPop.do",
            title : "사업계획"
        },
        bgacct : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserBgAcctPop.do",
            title : "예산계정"
        },
        project : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserProjectPop.do",
            title : "프로젝트"
        },
        partner : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserPartnerPop.do",
            title : "거래처"
        },
        card : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserCardPop.do",
            title : "카드"
        },
        car : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserCarPop.do",
            title : "차량"
        },
        summary : {
            url : _g_contextPath_ + "/ex/expend/code/ExExpendSummaryPop.do",
            title : "표준적요"
        },
        auth : {
            url : _g_contextPath_ + "/ex/expend/code/ExUserAuthPop.do",
            title : "증빙유형"
        }
    }
}

/* setLayerPop : Layer 설정 */
var setLayerPop = function( callType, type, params, layerWidth, layerHeight, parentClass, childrenClass ) {
    /* list, slip, mng, summary, auth, project, partner, card, car */
    /* params : json */
    /* widht : base 700px */
    /* height : base 800px */
    /* parentClass : modal id */
    /* childrenClass : layer pop id */

    params = (params || {});
    layerWidth = (layerWidth || '700');
    layerHeight = (layerHeight || '800');
    parentClass = (parentClass || '');
    childrenClass = (childrenClass || '');

    log('+ [FNC] setLayerPop(' + callType + ', ' + type + ', ' + (JSON.stringify(params) || '') + ', ' + layerWidth + ', ' + layerHeight + ', ' + parentClass + ', ' + childrenClass + ')');

    if (getLayerInfoDef('popInfo', type, 'url') === '') {
        log(' ! [FNC] ' + type + ' 의 URL이 정의되지 않았습니다.');
        return;
    }

    $("html, body").scrollTop(0);

    $.ajax({
        type : "post",
        url : getLayerInfoDef('popInfo', type, 'url'),
        datatype : "json",
        async : false,
        data : params,
        success : function( data ) {
            var parent; /* modal 과 layer 가 추가될 div */
            var children; /* Layer div */
            var modalHeight; /* iFrame in Layer use */

            /* parent, children def */
            switch (callType) {
                case "1":
                    /* contents call layer pop */
                    parent = $(getLayerInfoDef('contentsWrap', callType));
                    parent.append(getLayerInfoDef('contentsDiv', callType));
                    parent.append(data);
                    children = $(getLayerInfoDef('contentsWrap', callType));
                    childrenClass = "";
                    break;
                case "2":
                    /* window pop call layer pop */
                    $("body").css("overflow", "hidden");
                    parent = $(getLayerInfoDef('contentsWrap', callType));
                    parent.append(getLayerInfoDef('contentsDiv', callType));
                    parent.append(data);
                    children = $(getLayerInfoDef('contentsWrap', callType));
                    childrenClass = "";
                    break;
                case "4":
                    /* iframe call layer pop */
                    parent = $(getLayerInfoDef('contentsWrap', callType), parent.document);
                    modalHeight = parent.height();
                    parent.append((getLayerInfoDef('contentsDiv', callType)).replace("_MODALHEIGHT_", modalHeight));
                    if (childrenClass) {
                        parent.after(data);
                    } else {
                        parent.append(data);
                    }
                    children = parent.find("#" + parentClass);
                    childrenClass = "";
                    break;
                default:
                    /* layer pop call layer pop */
                    parent = $(getLayerInfoDef('contentsWrap', 'default').toString().replace("_PARENTCLASS_", (parentClass || "")));
                    parent.append(getLayerInfoDef('contentsWrap', 'default').toString().replace("_CHILDRENCLASS_", (childrenClass || "")));
                    if (childrenClass) {
                        parent.after(data);
                    } else {
                        parent.append(data);
                    }
                    children = $("#" + childrenClass);
                    break;
            }

            /* width, height def */
            children.css("width", (layerWidth || "700") + 'px');
            children.css("height", (layerHeight || "800") + 'px');

            /* children set style */
            children.css("border", "1px solid #adadad");
            children.css("z-index", getLayerInfoDef('baseIndex'))

            /* header set */
            var header = "<div class='pop_head'>";
            header += "<h1>" + getLayerInfoDef('popInfo', type, 'title') + "</h1>";
            header += "<a href='javascript:setLayerPopClose(" + '"' + childrenClass + '"' + ");' class='clo' style='display:block;'><img src='" + _g_contextPath_ + "/Images/btn/btn_pop_clo02.png' alt='' /></a>";
            header += "</div>";
            children.prepend(header);

            /* pop width, pop height def */
            children.css("top", "50%").css("left", "50%").css("marginLeft", -((children.outerWidth()) / 2)).css("marginTop", -((children.outerHeight()) / 2));

            return;
        },
        error : function( data ) {
            alert("팝업호출에 실패하였습니다.");
            return;
        }
    });

    log('- [FNC] setLayerPop(' + callType + ', ' + type + ', ' + (JSON.stringify(params) || '') + ', ' + layerWidth + ', ' + layerHeight + ', ' + parentClass + ', ' + childrenClass + ')');

    return;
};

/* getLayerInfoDef : 기초코드 조회 */
var getLayerInfoDef = function( catagory, type, subType ) {

    log('+ [FNC] getLayerInfoDef(' + catagory + ', ' + type + ', ' + subType + ')');

    var result = new Object();

    switch (catagory) {
        case "baseIndex":
            if (typeof layerInfoDef[catagory] === 'object') {
                log(' ! [FNC] getLayerInfoDef - exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = layerInfoDef[catagory];
            } else {
                log(' ! [FNC] getLayerInfoDef - not exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = '';
            }
            break;
        case "popInfo":
            if (typeof layerInfoDef[catagory][type][subType] === 'object') {
                log(' ! [FNC] getLayerInfoDef - exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = layerInfoDef[catagory][type][subType];
            } else {
                log(' ! [FNC] getLayerInfoDef - not exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = '';
            }
            break;
        default:
            if (typeof layerInfoDef[catagory][type] === 'object') {
                log(' ! [FNC] getLayerInfoDef - exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = layerInfoDef[catagory][type];
            } else {
                log(' ! [FNC] getLayerInfoDef - not exists >> ' + catagory + ', ' + type + ', ' + subType);
                result = '';
            }
            break;
    }

    log('- [FNC] getLayerInfoDef(' + catagory + ', ' + type + ', ' + subType + ')');

    return result;
}

/* setLayerPopClose : Layer 종료 */
var setLayerPopClose = function( target ) {

    log('+ [FNC] setLayerPopClose(' + target + ')');

    if (target) {
        log(' ! [FNC] setLayerPopClose - exists >> ' + target);
        $("#" + target).remove();
        $("#modal_" + target).remove();
    } else {
        log(' ! [FNC] setLayerPopClose - not exists >> ' + target);
        $(".pop_wrap_dir").remove();
        $("#modal").remove();
        $("body").css("overflow", "auto");
    }

    log('- [FNC] setLayerPopClose(' + target + ')');

    return;
}