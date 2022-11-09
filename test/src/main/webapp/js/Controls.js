var WeatherJson = [
                        { "CD": '0', "KR": '토네이도', "EN": 'tornado', "JP": 'トルネード', "CN": '', "GB": '龙卷风' },
                        { "CD": '1', "KR": '태풍', "EN": 'typhoon', "JP": '台風', "CN": '', "GB": '台风' },
                        { "CD": '10', "KR": 'freezing rain', "EN": 'freezing rain', "JP": 'freezing rain', "CN": '', "GB": '冻雨' },
                        { "CD": '11', "KR": '약한비', "EN": 'light rain', "JP": '小雨', "CN": '', "GB": '小雨' },
                        { "CD": '12', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '13', "KR": 'snow flurries', "EN": 'snow flurries', "JP": 'snow flurries', "CN": '', "GB": '阵雪' },
                        { "CD": '14', "KR": '약한눈', "EN": 'light snow', "JP": '小雪', "CN": '', "GB": '小雪' },
                        { "CD": '15', "KR": 'blowing snow', "EN": 'blowing snow', "JP": 'blowing snow', "CN": '', "GB": '暴风雪' },
                        { "CD": '16', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '17', "KR": '우박', "EN": 'hail', "JP": '雹', "CN": '', "GB": '冰雹' },
                        { "CD": '18', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '19', "KR": '먼지', "EN": 'dust', "JP": 'ほこり', "CN": '', "GB": '灰尘' },
                        { "CD": '2', "KR": '허리케인', "EN": 'hurricane', "JP": 'ハリケーン', "CN": '', "GB": '飓风' },
                        { "CD": '20', "KR": '안개', "EN": 'fog', "JP": '霧', "CN": '', "GB": '雾' },
                        { "CD": '21', "KR": '연무', "EN": 'smoke and fog', "JP": '煙霧', "CN": '', "GB": '雾霾' },
                        { "CD": '22', "KR": '안개', "EN": 'fog', "JP": '霧', "CN": '', "GB": '雾' },
                        { "CD": '23', "KR": '강풍', "EN": 'strong wind', "JP": '強風', "CN": '', "GB": '强风' },
                        { "CD": '24', "KR": '바람', "EN": 'wind', "JP": '風', "CN": '', "GB": '风' },
                        { "CD": '25', "KR": '강추위', "EN": 'severe cold', "JP": '酷寒', "CN": '', "GB": '强冷空气' },
                        { "CD": '26', "KR": '흐림', "EN": 'cloudy', "JP": '曇り', "CN": '', "GB": '阴' },
                        { "CD": '27', "KR": '구름많음', "EN": 'very cloudy', "JP": '雲が多い', "CN": '', "GB": '多云' },
                        { "CD": '28', "KR": '구름많음', "EN": 'very cloudy', "JP": '雲が多い', "CN": '', "GB": '多云' },
                        { "CD": '29', "KR": '구름조금', "EN": 'a little cloudy', "JP": '雲が少ない', "CN": '', "GB": '少云' },
                        { "CD": '3', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '30', "KR": '구름조금', "EN": 'a little cloudy', "JP": '雲が少ない', "CN": '', "GB": '少云' },
                        { "CD": '31', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '32', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '33', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '34', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '35', "KR": '우박/비', "EN": 'hale/rain', "JP": '雹/雨', "CN": '', "GB": '冰雹/雨' },
                        { "CD": '36', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '37', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '38', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '39', "KR": '맑음', "EN": 'sunny', "JP": '晴れ', "CN": '', "GB": '晴' },
                        { "CD": '4', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '40', "KR": '우박/비', "EN": 'hale/rain', "JP": '雹/雨', "CN": '', "GB": '冰雹/雨' },
                        { "CD": '41', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '42', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '43', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '44', "KR": '구름조금', "EN": 'a little cloudy', "JP": '雲が少ない', "CN": '', "GB": '少云' },
                        { "CD": '45', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '46', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '47', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '5', "KR": '눈/비', "EN": 'snow/rain', "JP": '雪/雨', "CN": '', "GB": '雨加雪' },
                        { "CD": '6', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '7', "KR": '눈', "EN": 'snow', "JP": '雪', "CN": '', "GB": '雪' },
                        { "CD": '8', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                        { "CD": '9', "KR": '비', "EN": 'rain', "JP": '雨', "CN": '', "GB": '雨' },
                   ];

function fnGetWeatherJsonParsing(Code, DefStr) {

    var rtnValue = DefStr;

    $.each(WeatherJson, function (i, t) {

        if (t.CD == Code) {

            switch ($.cookie('BxUserLanguage')) {
                case 'KR':
                    rtnValue = t.KR;
                    break;
                case 'JP':
                    rtnValue = t.JP;
                    break;
                case 'EN':
                    rtnValue = t.EN;
                    break;
                case 'CN':
                    rtnValue = t.CN;
                    break;
                case 'GB':
                    rtnValue = t.GB;
                    break;
                default:
                    rtnValue = t.KR;
            }

            if (rtnValue == "") rtnValue = t.KR;

            return false;
        }
    });

    return rtnValue;
}

var LANGPACKJson = [
                        { "CD": 'TX000000260', "KR": '쪽지', "EN": 'Note', "JP": 'メッセージ', "CN": '', "GB": '纸条' },
                        { "CD": 'TX000000262', "KR": '메일', "EN": 'Mail', "JP": 'メール', "CN": '', "GB": '邮件' },
                        { "CD": 'TX000000263', "KR": 'SMS', "EN": 'SMS', "JP": 'SMS', "CN": '', "GB": 'SMS' },
                        { "CD": 'TX000000435', "KR": '년', "EN": 'Year', "JP": '年', "CN": '', "GB": '年' },
                        { "CD": 'TX000000436', "KR": '월', "EN": 'Month', "JP": '月', "CN": '', "GB": '月' },
                        { "CD": 'TX000000884', "KR": '사원선택', "EN": 'Select employees.', "JP": '社員選択', "CN": '', "GB": '选择员工' },
                        { "CD": 'TX000000893', "KR": '알림', "EN": 'Notifications', "JP": 'お知らせ', "CN": '', "GB": '提醒' },
                        { "CD": 'TX000002003', "KR": '작업이 실패했습니다.', "EN": 'The operation failed.', "JP": '作業が失敗しました。', "CN": '', "GB": '作业失败。' },
                        { "CD": 'TX000002629', "KR": '는', "EN": 'Is', "JP": 'は', "CN": '', "GB": '需省略' },
                        { "CD": 'TX000002687', "KR": '부서선택', "EN": 'Select the department', "JP": '部署選択', "CN": '', "GB": '部门选择' },
                        { "CD": 'TX000002745', "KR": '부서/사원선택', "EN": 'Select the department/ employee', "JP": '部署/社員選択', "CN": '', "GB": '部门/员工 选择' },
                        { "CD": 'TX000003810', "KR": '사내통신', "EN": 'Communication at office', "JP": '社内通信', "CN": '', "GB": '公司内部通讯' },
                        { "CD": 'TX000006615', "KR": '은[는] 필수 입력입니다.', "EN": '', "JP": '', "CN": '', "GB": '' },
                        { "CD": 'TX000006621', "KR": '첨부파일보기', "EN": '', "JP": '', "CN": '', "GB": '' },
                        { "CD": 'TX000006622', "KR": '보다 작을 수 없습니다.', "EN": '', "JP": '', "CN": '', "GB": '' },
                        { "CD": 'TX000006623', "KR": '보다 클 수 없습니다.', "EN": '', "JP": '', "CN": '', "GB": '' }
                   ];

function fnGetLANGPACKJsonParsing(Code, DefStr) {

    var rtnValue = DefStr;
    
    $.each(LANGPACKJson, function (i, t) {

        if (t.CD == Code) {

            switch ($.cookie('BxUserLanguage')) {
                case 'KR':
                    rtnValue = t.KR;
                    break;
                case 'JP':
                    rtnValue = t.JP;
                    break;
                case 'EN':
                    rtnValue = t.EN;
                    break;
                case 'CN':
                    rtnValue = t.CN;
                    break;
                case 'GB':
                    rtnValue = t.GB;
                    break;
                default:
                    rtnValue = t.KR;
            }

          
            if (rtnValue == "") rtnValue = t.KR;

            return false;
        }
    });

    return rtnValue;
}

var LANGPACKXml = null;

function fnGetLANGPACKXmlCall(Lang, Code, DefStr) {

    var rtnValue = DefStr;

    if (LANGPACKXml == null) {
        $.ajax({
            type: "POST",
            cache: false,
            async: false,
            url: "/Langpack/LANGPACK.xml",
            dataType: "xml",
            success: function (xml) {
                LANGPACKXml = xml;
            }
        , error: function (data, status, err) {
            LANGPACKXml = null;
        }
        });
    }

    if (LANGPACKXml != null) {
        rtnValue = fnGetLANGPACKXmlParsing(Lang, Code, DefStr, LANGPACKXml)
    }
   
    return rtnValue;
    
}

function fnGetLANGPACKParsing(Lang, Code, DefStr, xml) {
    var rtnValue = DefStr;

    $(xml).find("LANGPACK_ITEM").each(function () {

        if ($(this).attr("CD") == Code) {
            rtnValue = $(this).find(Lang).text();
            return false;
        }
    });

    return rtnValue;
}


String.prototype.replaceAll = function (searchStr, replaceStr) {
    var temp = this;

    while (temp.indexOf(searchStr) != -1) {
        temp = temp.replace(searchStr, replaceStr);
    }

    return temp;
}

String.prototype.format = function () {
    var s = this,
            i = arguments.length;

    while (i--) {
        s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }

    return s;
}

if (jQuery) (function () {

    $.extend($.fn, {

        rightClick: function (handler) {
            $(this).each(function () {
                $(this).mousedown(function (e) {
                    var evt = e;
                    $(this).mouseup(function () {
                        $(this).unbind('mouseup');
                        if (evt.button == 2) {
                            handler($(this));
                            return false;
                        } else {
                            return true;
                        }
                    });
                });
                $(this)[0].oncontextmenu = function () {
                    return false;
                }
            });
            return $(this);
        },

        rightMouseDown: function (handler) {
            $(this).each(function () {
                $(this).mousedown(function (e) {
                    if (e.button == 2) {
                        handler($(this));
                        return false;
                    } else {
                        return true;
                    }
                });
                $(this)[0].oncontextmenu = function () {
                    return false;
                }
            });
            return $(this);
        },

        rightMouseUp: function (handler) {
            $(this).each(function () {
                $(this).mouseup(function (e) {
                    if (e.button == 2) {
                        handler($(this));
                        return false;
                    } else {
                        return true;
                    }
                });
                $(this)[0].oncontextmenu = function () {
                    return false;
                }
            });
            return $(this);
        },

        noContext: function () {
            $(this).each(function () {
                $(this)[0].oncontextmenu = function () {
                    return false;
                }
            });
            return $(this);
        }

    });

})(jQuery);	

// 체크박스 전체 체크/언체크
function fnAllCheckBoxChecked(obj, objChked) {
    if ((typeof objChked) == 'undefined')
        return;

    if ((typeof objChked.length) == 'undefined') {
        objChked.checked = obj.checked;
        return;
    }

    var nfor, nlen;
    nlen = objChked.length;
    for (nfor = 0; nfor < nlen; nfor++) {
        if (objChked[nfor].disabled == false) {
            objChked[nfor].checked = obj.checked;
        }
    }
}


function fnGetCmCode(co_id, div, cm_cd) {
    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;

    var url = getContextPath()+"/cmm/GetCodeBind.do";
    
	var list = "" ;
	try {
        $.ajax({
            type: "POST",
            url: url,
            async: false,
            datatype: "text",
            data: tblParam,
            success: function (data) {
            	list =  data.list;
            },
            error: function (XMLHttpRequest, textStatus) {
            }
        });
    }
    catch (e) {

    }
	return list ;
	
}

function fnGetCmCode_SP(co_id, div, cm_cd) {
    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;
    tblParam.sp_yn = "Y";

//    var url = "/Cm/CMCommon/GetCodeBind";
    var url = getContextPath()+"/cmm/GetCodeBind.do";

    var rtncd;

    $.ajax({
        type: "POST"
//        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: false
        , global: false
//        , data: JSON.stringify(tblParam)
        , data: tblParam
        , success: function (res) {
            rtncd = res;
        }
        , error: function (res) {
            alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }
    });

    return rtncd;
}

// 코드리스트 - DDL
function fnSetCodeDDL(co_id, target, div, cm_cd, type, callback) {    // ( co_id, target, div, cm_cd, type, callback ) ** type : N=int, S=string

    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;

    var url = getContextPath()+"/Cmm/GetCodeBind.do";

    $.ajax({
        type: "POST"
//        , contentType: "application/json; charset=utf-8"
        , url: url
        , data: JSON.stringify(tblParam)
        , data: tblParam
        , success: function (res) {
            fnSelectDataBind(res, target, type, callback); 
        }
        , error: function (res) {
           alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }

    });
}

function fnSetCodeDDL(co_id, target, div, cm_cd, type, callback, async) {    // ( co_id, target, div, cm_cd, type, callback, async ) ** type : N=int, S=string

    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;

   
    var url = getContextPath()+"/cmm/GetCodeBind.do";
//    var url = "/Cm/CMCommon/GetCodeBind";


    $.ajax({
        type: "POST"
//        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , global: async
//        , data: JSON.stringify(tblParam)
        , data: tblParam
        , success: function (res) {
        	var res = res.list;
            fnSelectDataBind(res, target, type, callback);
        }
        , error: function (res) {
            alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }

    });
}

function fnSetUserCoDDL(target, type, callback, async) {    // ** type : N=int, S=string

    var url = "/Ot/OtPjtMng/GetCoList";


    $.ajax({
        type: "POST"
        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , global: async
        , success: function (res) {
            fnSelectDataBind(res, target, type, callback);
        }
        , error: function (res) {
            alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }

    });
}

// 데이터바인딩(코드리스트 - DDL 리턴함수)
function fnSelectDataBind(obj, target, type, callback) {
    fnSelectControl(obj, target, type);

    if (callback != "") {
        eval(callback)();
    }
}

// SelectControl
function fnSelectControl(obj, target, type) {   //type : N=int, S=string
    var i = 0;
    
    if (target[0] != null) {
        if (type == "N") {
            for (var i in obj) {
                target[0].add(new Option(obj[i]["cd_nm"], obj[i]["cd_id"]));
            }
        }
        else if (type == "S") {
            for (var i in obj) {
                target[0].add(new Option(obj[i]["cd_nm"], obj[i]["cd_val"]));
            }
        }
        else if (type == "B") {  //근태예외처리 
            for (var i in obj) {
                target[0].add(new Option(obj[i]["cd_nm"], obj[i]["cd_nm"]));
            }
        }
        else {
            for (var i in obj) {
                target[0].add(new Option(obj[i]["cd_nm"], obj[i]["cd_val"]));
            }
        }
    }
}

// 코드리스트 - RBL
function fnSetCodeRBL(co_id, id, target, div, cm_cd, type, callback) {    // ( co_id, id, target, div, cm_cd, type, callback ) ** type : N=int, S=string
    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;

//    var url = "/Cm/CMCommon/GetCodeBind";
    var url = getContextPath()+"/cmm/GetCodeBind.do";

    $.ajax({
        type: "POST"
//        , contentType: "application/json; charset=utf-8"
        , url: url
//        , data: JSON.stringify(tblParam)
        , data: tblParam
        , success: function (res) {
            fnRadioDataBind(res, id, target, type, callback);
        }
        , error: function (res) {
            alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }

    });
}

function fnSetCodeRBL(co_id, id, target, div, cm_cd, type, callback, async) {    // ( co_id, id, target, div, cm_cd, type, callback ) ** type : N=int, S=string
    var tblParam = {};

    tblParam.co_id = co_id;
    tblParam.div = div;
    tblParam.cm_cd = cm_cd;

//    var url = "/Cm/CMCommon/GetCodeBind";
    var url = getContextPath()+"/cmm/GetCodeBind.do";

    $.ajax({
        type: "POST"
//        , contentType: "application/json; charset=utf-8"
        , url: url
        , async: async
        , global: async
        , data: JSON.stringify(tblParam)
        , data: tblParam
        , success: function (res) {
            fnRadioDataBind(res, id, target, type, callback);
        }
        , error: function (res) {
            alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다."));
        }

    });
}

// 데이터바인딩(코드리스트 - DDL 리턴함수)
function fnRadioDataBind(obj, id, target, type, callback) {
    fnRadioControl(obj, id, target, type);

    if (callback != "") {
        eval(callback)();
    }
}

// RadioControl
function fnRadioControl(obj, id, target, type) {   //type : N=int, S=string
    var i = 0;
    var control = "";

    for (var i in obj) {
        var val = type == "N" ? obj[i]["cd_id"] : obj[i]["cd_val"];
        if (val != null) {
            var nm = obj[i]["cd_nm"];
            var chk = "";
            if (i == 0) chk = "checked";
            control += "<input type='radio' id='" + id + i + "' name='" + id + "' value='" + val + "' class='input-radio' " + chk + "><label for='" + id + i + "'>" + nm + "</label>&nbsp;&nbsp;";
        }
    }
    target.html(control);
}

// ***** 공통팝업
// 사원부서선택 팝업
var ctl_DeptUserId;
var ctl_DeptUserNm;
var ctl_DeptUserBind;

function fnOpenUserDeptPop(orgDiv, co_id, callback, ctl_ID, ctl_NM, ctl_Bind, div, multiYN) {
    ctl_DeptUserId = ctl_ID;
    ctl_DeptUserNm = ctl_NM;
    ctl_DeptUserBind = ctl_Bind;
    
    if (callback == "") {
        if (div == "UD") { callback = "fnSetDeptUserInfo"; }
        if (div == "D") { callback = "fnSetDeptInfo"; }
        if (div == "U") { callback = "fnSetUserInfo"; }
    }

    fnSelectPop(orgDiv, co_id, callback, ctl_Bind, div, multiYN);
}

function fnBindUserDeptInfo(ctl_ID, ctl_NM, ctl_Bind, div, oParam) {
    ctl_DeptUserId = ctl_ID;
    ctl_DeptUserNm = ctl_NM;
    ctl_DeptUserBind = ctl_Bind;

    var call = "";
    var obj;
    var arrDept = new Array();
    var arrUser = new Array();

    if (div == "UD") {
        call = "fnSetDeptUserInfo";

        $(oParam['D']).each(function () {
            var tblDept = {};
            tblDept.co_id = this.co_id;
            tblDept.dept_id = this.dept_id;
            tblDept.user_id = "";
            tblDept.dept_nm = this.dept_nm;
            arrDept.push(eval(tblDept));
        });

        $(oParam['U']).each(function () {
            var tblUser = {};
            tblUser.co_id = this.co_id;
            tblUser.dept_id = this.dept_id;
            tblUser.user_id = this.user_id.replace('U', '');
            tblUser.user_nm = this.user_nm;
            arrUser.push(eval(tblUser));
        });

        obj = { 'D': arrDept, 'U': arrUser };
    }
    else if (div == "D") {
        call = "fnSetDeptInfo";

        $(oParam).each(function () {
            var tblDept = {};
            tblDept.co_id = this.co_id;
            tblDept.dept_id = 'D' + this.dept_id;
            tblDept.user_id = "";
            tblDept.dept_nm = this.dept_nm;
            arrDept.push(eval(tblDept));
        });

        obj = { 'D': arrDept, 'U': null };
    }
    else if (div == "U") {
        call = "fnSetUserInfo";

        $(oParam).each(function () {
            var tblUser = {};
            tblUser.co_id = this.co_id;
            tblUser.dept_id = this.dept_id;
            tblUser.user_id = this.user_id;
            tblUser.user_nm = this.user_nm;
            arrUser.push(eval(tblUser));
        });

        obj = { 'D': null, 'U': arrUser };
    }

    if (div != "") {
        eval(call)(obj);
    }
}

// 사원부서선택 콜백
function fnSetDeptUserInfo(obj) {
    var ids = ""
    var nms = "";

    for (i = 0; i < obj['D'].length; i++) {
        ids += obj['D'][i].dept_id + "/";
        nms += obj['D'][i].dept_nm + "/";
    }

    for (i = 0; i < obj['U'].length; i++) {
        ids += 'U' + obj['U'][i].user_id.replace('U', '') + "/";
        nms += obj['U'][i].user_nm + "/";
    }
    
    //var DTO = { 'D': arrDept, 'U': arrUser };

    $(ctl_DeptUserBind).val(JSON.stringify(obj));
    $(ctl_DeptUserId).val(ids.substr(0, ids.length - 1));
    $(ctl_DeptUserNm).val(nms.substr(0, nms.length - 1));

    ctl_DeptUserId = "";
    ctl_DeptUserNm = "";
    ctl_DeptUserBind = "";
}

// 부서선택 콜백
function fnSetDeptInfo(obj) {
    var dept_ids = ""
    var dept_nms = "";
    
    for (i = 0; i < obj['D'].length; i++) {
        dept_ids += obj['D'][i].dept_id.substr(1) + "/";
        dept_nms += obj['D'][i].dept_nm + "/";
    }

    //var DTO = { 'D': arrDept };

    $(ctl_DeptUserBind).val(JSON.stringify(obj));
    $(ctl_DeptUserId).val(dept_ids.substr(0, dept_ids.length - 1));
    $(ctl_DeptUserNm).val(dept_nms.substr(0, dept_nms.length - 1));

    ctl_DeptUserId = "";
    ctl_DeptUserNm = "";
    ctl_DeptUserBind = "";
}

// 사원선택 콜백
function fnSetUserInfo(obj) {
    var user_ids = "";
    var user_nms = "";

    for (i = 0; i < obj['U'].length; i++) {
        user_ids += obj['U'][i].user_id + "/";
        user_nms += obj['U'][i].user_nm + "/";
    }

    //var DTO = { 'U': arrUser };

    $(ctl_DeptUserBind).val(JSON.stringify(obj));
    $(ctl_DeptUserId).val(user_ids.substr(0, user_ids.length - 1));
    $(ctl_DeptUserNm).val(user_nms.substr(0, user_nms.length - 1));

    ctl_DeptUserId = "";
    ctl_DeptUserNm = "";
    ctl_DeptUserBind = "";
}


// 사원/부서선택 팝업 호출 공통함수
// orgDiv : ALL(전체회사), GROUP(소속그룹 전체회사), CO(소속회사)
// co_id : orgDiv가 "CO"일경우만 사용됨
// callback : 리턴함수(파라미터는 json)  ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
// ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
// div : U(사원), D(부서), UD(부서/사원)
// multiYN : 1(멀티), 0(단일)
/*function fnSelectPop(orgDiv, co_id, callback, ctl_Bind, div, multiYN) {
    // 사원선택
    if (div == "U") {
        // 사원선택 단일
        if (multiYN == "0") {
            fnOpenUserPop(orgDiv, co_id, callback, ctl_Bind);
        }
        // 사원선택 멀티
        if (multiYN == "1") {
            fnOpenUserMultiPop(orgDiv, co_id, callback, ctl_Bind);
        }
    }

    // 부서선택
    if (div == "D") {
        // 부서선택 단일
        if (multiYN == "0") {
            fnOpenDeptPop(orgDiv, co_id, callback, ctl_Bind);
        }
        // 부서선택 멀티
        if (multiYN == "1") {
            fnOpenDeptMultiPop(orgDiv, co_id, callback, ctl_Bind);
        }
    }

    // 부서사원선택
    if (div == "UD") {
        // 부서/사원선택 멀티
        fnOpenUserDeptMultiPop(orgDiv, co_id, callback, ctl_Bind);
    }
}*/

function fnSelectPop(orgDiv, co_id, callback, ctl_Bind, div, multiYN) {
    // 사원선택
    if (div == "m") {
        // 사원선택 단일
        if (multiYN == "0") {
            fnOpenUserPop(orgDiv, co_id, callback, ctl_Bind);
        }
        // 사원선택 멀티
        if (multiYN == "1") {
            fnOpenUserMultiPop(orgDiv, co_id, callback, ctl_Bind);
        }
    }

    // 부서선택
    if (div == "d") {
        // 부서선택 단일
        if (multiYN == "0") {
            fnOpenDeptPop(orgDiv, co_id, callback, ctl_Bind);
        }
        // 부서선택 멀티
        if (multiYN == "1") {
            fnOpenDeptMultiPop(orgDiv, co_id, callback, ctl_Bind);
        }
    }

    // 부서사원선택
    if (div == "md") {
        // 부서/사원선택 멀티
        fnOpenUserDeptMultiPop(orgDiv, co_id, callback, ctl_Bind);
    }
}

function selectPop(orgDiv, co_id, callback, ctl_Bind, moduleType, selectType) {
	var url = "/gw/cmm/systemx/cmmOcType1Pop.do?orgDiv="+escape(orgDiv)+"&groupSeq="+escape(co_id)+"&callback="+escape(callback)+"&ctl_Bind=" + escape(ctl_Bind)+"&moduleType="+moduleType+"&selectType="+selectType;
	window.open(url, "empInfo1Pop", "width=700,height=606,scrollbars=no");

}


//사원선택 단일  ** co_id, callback, ctl_Bind  ** callback : 리턴함수(파라미터는 json), ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
function fnOpenUserPop(orgDiv, co_id, callback, ctl_Bind) {
	selectPop(orgDiv, co_id, callback, ctl_Bind, 'e', 's');
   // var formNm = fnGetLANGPACKJsonParsing('TX000000884', '사원선택');
    //dlg.OpenDialog("/Cm/CMCommon/CmSelectUserPop?orgDiv=" + escape(orgDiv) + "&co_id=" + escape(co_id) + "&callback=" + escape(callback) + "&ctl_Bind=" + escape(ctl_Bind), 780, 550, formNm);
}

//사원선택 멀티  ** co_id, callback, ctl_Bind  ** callback : 리턴함수(파라미터는 json), ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
function fnOpenUserMultiPop(orgDiv, co_id, callback, ctl_Bind) {
	selectPop(orgDiv, co_id, callback, ctl_Bind, 'e', 'm');
    //var formNm = fnGetLANGPACKJsonParsing('TX000000884', '사원선택');
    //dlg.OpenDialog("/Cm/CMCommon/CmSelectUserMultiPop?orgDiv=" + escape(orgDiv) + "&co_id=" + escape(co_id) + "&callback=" + escape(callback) + "&ctl_Bind=" + escape(ctl_Bind), 780, 550, formNm);
}

// 부서선택 단일  ** co_id, callback, ctl_Bind  ** callback : 리턴함수(파라미터는 json), ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
function fnOpenDeptPop(orgDiv, co_id, callback, ctl_Bind) {
	selectPop(orgDiv, co_id, callback, ctl_Bind, 'd', 's');
    //var formNm = fnGetLANGPACKJsonParsing('TX000002687', '부서선택');
    //dlg.OpenDialog("/Cm/CMCommon/CmSelectDeptPop?orgDiv=" + escape(orgDiv) + "&co_id=" + escape(co_id) + "&callback=" + escape(callback) + "&ctl_Bind=" + escape(ctl_Bind), 400, 500, formNm);
}

// 부서선택 멀티  ** co_id, callback, ctl_Bind  ** callback : 리턴함수(파라미터는 json), ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
function fnOpenDeptMultiPop(orgDiv, co_id, callback, ctl_Bind) {
	selectPop(orgDiv, co_id, callback, ctl_Bind, 'd', 'm');
    //var formNm = fnGetLANGPACKJsonParsing('TX000002687', '부서선택');
    //dlg.OpenDialog("/Cm/CMCommon/CmSelectDeptMultiPop?orgDiv=" + escape(orgDiv) + "&co_id=" + escape(co_id) + "&callback=" + escape(callback) + "&ctl_Bind=" + escape(ctl_Bind), 400, 550, formNm);
}

// 부서/사원선택 멀티  ** co_id, callback, ctl_Bind  ** callback : 리턴함수(파라미터는 json), ctl_Bind : "#ID"  ** 기존선택된 값(json) ex) {"U":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...], "D":[{"co_id":co_id,"dept_id":dept_id,"grade_cd":grade_cd,"user_id":user_id}, ...]}
function fnOpenUserDeptMultiPop(orgDiv, co_id, callback, ctl_Bind) {
	selectPop(orgDiv, co_id, callback, ctl_Bind, 'ed', 'm');
    //var formNm = fnGetLANGPACKJsonParsing('TX000002745', '부서/사원선택');
    //dlg.OpenDialog("/Cm/CMCommon/CmSelectUserDeptMultiPop?orgDiv=" + escape(orgDiv) + "&co_id=" + escape(co_id) + "&callback=" + escape(callback) + "&ctl_Bind=" + escape(ctl_Bind), 780, 550, formNm);
}

//지출결의용 첨부파일 뷰어
function fn_ex_file_attach_view(arg1, arg2) {

    var formNm = fnGetLANGPACKJsonParsing('TX000006621', '첨부파일보기');
    dlg.OpenDialog("/Ex/EXDOC/AttchView?pExpendNo=" + arg1 + "&pLineNo=" + arg2, 750, 550, formNm);
    //PopUp(6, 600, 500, "EX_ATTACH_VIEW", "/Ex/EXDOC/ExDocAttchView?sExpendNo=" + arg1 + "&sLineNo=" + co_id);
}

function fnExSlipListPop(nExpendNo, nLineNo, ex200, nWinPopYN) {
    var url = "";

    if (ex200 == "2") {
        url = "/Ex/EXDoc/ExDocSlipListPopCol?nExpendNo=" + nExpendNo + "&nLineNo=" + nLineNo;
    }
    else if (ex200 == "3") {
        url = "/Ex/EXDoc/ExDocSlipListPopSep?nExpendNo=" + nExpendNo + "&nLineNo=" + nLineNo;
    }

    if (nWinPopYN == 1) {
        var intWidth = 850;
        var intHeight = 600;
        var intLeft = screen.width / 2 - intWidth / 2;
        var intTop = screen.height / 2 - intHeight / 2 - 40;

        window.open(url, "SlipListPop", 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
    }
    else {
        //dlg.OpenDialog("/Ex/EXDoc/ExDocSlipListPop?nExpendNo=" + nExpendNo + "&nLineNo=" + nLineNo, 850, 550, "");
        dlg.OpenDialog(url, 850, 580, "");
    }
}

function fnExMngListPop(nExpendNo, nLineNo, nSlipNo, nWinPopYN) {
    if (nWinPopYN == 1) {
        var intWidth = 800;
        var intHeight = 550;
        var intLeft = screen.width / 2 - intWidth / 2;
        var intTop = screen.height / 2 - intHeight / 2 - 40;
        var url = "/Ex/EXDoc/ExDocMngListPop?nExpendNo=" + nExpendNo + "&nLineNo=" + nLineNo + "&nSlipNo=" + nSlipNo;

        window.open(url, "SlipListPop", 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
    }
    else {
        dlg.OpenDialog("/Ex/EXDoc/ExDocMngListPop?nExpendNo=" + nExpendNo + "&nLineNo=" + nLineNo + "&nSlipNo=" + nSlipNo, 800, 500, "");
    }
}

//////////////////////////////////////////////////////////////////////////////
//    * 항목관리 및 사원,부서 팝업 호출 및 결과 처리를 위해 공통함수
//    * 사용처 : 문서함관리, 항목 동적 생성 System 타입 
//    * 작성자 : 홍성갑 - 수정시 꼭 얘기해주세요
//
//    1) 함수명을 fnUserCtl_ 로 시작하고 
//    2) CtrId => ID  속성값으로 #이 붙어서 파라메터로 넘어옴
//    3) CtrObj => this
//    4) CtrName => Name 속성값이 파라메터로 넘어옴
/////////////////////////////////////////////////////////////////////////////

var gValueSep = "▥";
var gGroupSep = ",";
var gDecimalSep = ".";
// URL를 받아서 처리
function fnUserCtl_DeptUserSetting(url, co_id, SystemID, unique_id) {

    $(document).find(':input').each(function () {

        if ($(this).attr('ManYn') != undefined) {
            var ManYn = $(this).attr('ManYn');

            if (ManYn == "1") {
                $(this).addClass('ui-icon-must');
            }
        }

        if ($(this).attr('UserType') != undefined) {

            var code = $(this).attr('Id').split("_");


            if (code[1] == "10") {

                var objVal = "#" + $(this).attr('Id')
                var objNm = "#" + $(this).attr('Id').replace('hidden', 'text');

                var tblParam = {};

                tblParam.co_id = co_id;
                tblParam.system_id = SystemID;
                tblParam.unique_id = unique_id;
                tblParam.item_id = code[2];

                //var url = "/KD/KDDoc/GetUserDeptInfo";

                $.ajax({
                    "cache": false
                        , type: "POST"
                        , async: false
                        , global: false
                        , contentType: "application/json; charset=utf-8"
                        , url: url
                        , data: JSON.stringify(tblParam)
                        , beforeSend: function () { }
                        , success: function (result) { fnSetDeptUserBinding(objVal, objNm, result); }
                        , error: function (data, status, err) { fnSetDeptUserBinding(objVal, objNm, null); }
                        , complete: function () { }

                });
            }
        }
    });
}

function fnUserCtl_IsRequired() {

    var rtn = true;

    $(document).find(':input').each(function () {
        if ($(this).attr('UserType') != undefined) {

            var ManYn = $(this).attr('ManYn');
            var DisName = $(this).attr('DisName');
            var val = $(this).val();

            if (ManYn == "1" && $.trim(val) == "") {
                //alert(DisName + " " + fnGetLANGPACKJsonParsing("TX000006615", "은[는] 필수 입력입니다."));
            	alert(DisName + " 은[는] 필수 입력입니다.");
                rtn = false;
                return false;
            }

        }
    });

    return rtn;
}

function fnUserCtl_GetAllValue() {

    var Value = new Array();

    $(document).find(':input').each(function () {
        if ($(this).attr('UserType') != undefined) {

            var code = $(this).attr('Id').split("_");

            var tblParam = {};

            tblParam.doc_id = 0;
            tblParam.item_tp = code[1];
            tblParam.item_id = code[2];
            tblParam.item_text = "";

            var objVal = "#" + $(this).attr('Id')

            if (code[1] == "10") {
                result = fnGetDeptUserBinding(jQuery.parseJSON($(objVal).val()));

                if (result != null) {

                    var u = "";

                    /*$.each(result, function (i, t) {
                        if (t.org_div == "D") {
                            u = u + "D|" + t.dept_id + ",";
                        }
                        else if (t.org_div == "W") {
                            u = u + "W|" + t.dept_id + ",";
                        }
                        else if (t.org_div == "C") {
                            u = u + "C|" + t.co_id + ",";
                        }
                        else {
                            if (t.dept_id != "") {
                                u = u + "U|" + t.dept_id + "|" + t.user_id + ",";
                            }
                        }
                    });*/
                    $.each(result, function (i, t) {
                        if (t.org_div == "d") {
                            u = u + "d|" + t.dept_id + ",";
                        }
                        else if (t.org_div == "b") {
                            u = u + "b|" + t.dept_id + ",";
                        }
                        else if (t.org_div == "c") {
                            u = u + "c|" + t.co_id + ",";
                        }
                        else {
                            if (t.dept_id != "") {
                                u = u + "m|" + t.dept_id + "|" + t.user_id + ",";
                            }
                        }
                    });

                    tblParam.item_value = u.substring(0, u.length - 1);
                    tblParam.item_text = $("#" + code[0] + "_" + code[1] + "_" + code[2] + "_text").val();

                }
                else {
                    tblParam.item_value = "";
                    tblParam.item_text = "";
                }
            }
            else if (code[1] == "40" || code[1] == "50") {

                tblParam.item_value = $(objVal).val().split('▥')[0];

                if ($(objVal).val().split('▥').length > 1) {
                    tblParam.item_text = $(objVal).val().split('▥')[1];
                }
            }
            else {
                tblParam.item_value = $(objVal).val();
                tblParam.item_text = $(objVal).val();
            }

            Value.push(tblParam);
        }
    });


    return Value;

}

// 기간 년월일시
function fnUserCtl_DoubleYearMontDayHour_Change(StartDateId, StartHourId, EndDateId, EndHourId, targetId) {

    var StartDate = $(StartDateId).val().replaceAll("-", "");
    var StartHour = $(StartHourId).val();
    var EndDate   = $(EndDateId).val().replaceAll("-", "");
    var EndHour   = $(EndHourId).val();

    $(targetId).val(StartDate + StartHour + "," + EndDate + EndHour + gValueSep + $(StartDateId).val() + $(StartHourId).val() + "," + $(EndDateId).val() + $(EndHourId).val());
}

// 단일 년월일시
function fnUserCtl_SingleYearMontDayHour_Change(DateId, HourId, targetId) {

    var Date = $(DateId).val().replaceAll("-", "");
    var Hour = $(HourId).val();

    $(targetId).val(Date + Hour + gValueSep + $(DateId).val() + $(HourId).val());
}

// 기간 년월일
function fnUserCtl_DoubleYearMontDays_Change(StartYearId,  EndYearId, targetId) {

    var StartYear = $(StartYearId).val().replaceAll("-","");
    var EndYear = $(EndYearId).val().replaceAll("-", "");

    $(targetId).val(StartYear + "," + EndYear + gValueSep + $(StartYearId).val() + "," + $(EndYearId).val());
}

// 단일 년월일
function fnUserCtl_SingleYearMontDays_Change(StartYearId,  targetId) {

    var StartYear = $(StartYearId).val().replaceAll("-", "");
    $(targetId).val(StartYear + gValueSep + $(StartYearId).val());
}

//기간 년월
function fnUserCtl_DoubleYearMonths_Change(StartYearId, StartMonthId, EndYearId, EndMonthId, targetId) {

    var StartYear     = $(StartYearId + " option:selected");
    var StartMonth    = $(StartMonthId + " option:selected");
    var EndYear       = $(EndYearId + " option:selected");
    var EndMonth      = $(EndMonthId + " option:selected");

    $(targetId).val(StartYear.val() + StartMonth.val() + "," + EndYear.val() + EndMonth.val() + gValueSep + StartYear.text() + fnGetLANGPACKJsonParsing('TX000000435', '년') + StartMonth.text() + fnGetLANGPACKJsonParsing('TX000000436', '월') + "," + EndYear.text() + fnGetLANGPACKJsonParsing('TX000000435', '년') + EndMonth.text() + fnGetLANGPACKJsonParsing('TX000000436', '월'));
}

// 단일 년월
function fnUserCtl_SingleYearMonths_Change(YearId, MonthId, targetId) {

    var Year = $(YearId + " option:selected");
    var Month = $(MonthId + " option:selected");

    $(targetId).val(Year.val() + Month.val() + gValueSep + Year.text() + fnGetLANGPACKJsonParsing('TX000000435','년') + Month.text() + fnGetLANGPACKJsonParsing('TX000000436', '월'));
}

//기간 년
function fnUserCtl_DoubleYear_Change(StartYearId, EndYearId, targetId) {

    var StartYear = $(StartYearId + " option:selected");
    var EndYear = $(EndYearId + " option:selected");

    $(targetId).val(StartYear.val() + "," + EndYear.val() + gValueSep + StartYear.text() + fnGetLANGPACKJsonParsing('TX000000435', '년') + "," + EndYear.text() + fnGetLANGPACKJsonParsing('TX000000435', '년'));
}


function fnUserCtl_DropDown_Change(CtrObj, targetId) {
    var id = $(CtrObj).attr("Id");
    $(targetId).val($(CtrObj).val() + gValueSep + $("#" + id + " option:selected").text());
}

function fnUserCtl_List_Change(eventCtr, targetId) {

    var id = $(CtrObj).attr("Id");
    var v = "";
    var t = "";

    $("#" + id + " :selected").each(function (i, selected) {
        v += $(selected).val() + ",";
        t += $(selected).text() + ",";
    });

    $(targetId).val(v.substring(0, v.length - 1) + gValueSep + t.substring(0, t.length - 1));
}

function fnUserCtl_Check_Click(CtrName, targetId) {

    var v = "";
    var t = "";

    for (var i = 0; i < $("input[name='" + CtrName + "']:checkbox").length; i++) {
        if ($("input:checkbox")[i].checked == true) {
            v += $("input:checkbox")[i].value + ",";

            var radChecked  = $("input:checkbox")[i].id;

            t += $('label[for=' + radChecked + ']').text() + ",";
        }
    }

    $(targetId).val(v.substring(0, v.length - 1) + gValueSep + t.substring(0, t.length - 1));

}

function fnUserCtl_Radio_Click(CtrName, targetId) {

    var radChecked = $("input[name='" + CtrName + "']:checked").attr("id");

    $(targetId).val($("input[name='" + CtrName + "']:checked").val() + gValueSep + $('label[for=' + radChecked + ']').text());

}


function fnUserCtl_Number_Blur(CtrObj , Title) {

    var MaxValue = $(CtrObj).attr('MaxValue').replaceAll(",", "");
    var MinValue = $(CtrObj).attr('MinValue').replaceAll(",", "");
    var Point    = $(CtrObj).attr('Point');
    var Value    = $(CtrObj).val().replaceAll(",", "");

    if ($.trim(Value) != "") {
        if (parseFloat(Value) < parseFloat(MinValue)) {
            alert(Title + fnGetLANGPACKJsonParsing('TX000002629', '는') + " [ " + DisplayAmount(MinValue, Point) + " ]" + fnGetLANGPACKJsonParsing('TX000006622', '보다 작을 수 없습니다.'));
            $(CtrObj).val("");
        }

        if (parseFloat(Value) > parseFloat(MaxValue)) {
            alert(Title + fnGetLANGPACKJsonParsing('TX000002629', '는') + " [ " + DisplayAmount(MaxValue, Point) + " ]" + fnGetLANGPACKJsonParsing('TX000006623', '보다 클 수 없습니다.'));
            $(CtrObj).val("");
        }
    }
}

function fnUserCtl_Number_Focus(CtrObj) {
    $(CtrObj).css("ime-mode", "disabled");
    $(CtrObj).select();
}

function fnUserCtl_Number_Keydown(CtrObj, evt) {
    $(CtrObj).css("ime-mode", "disabled");

    var strValue = $(CtrObj).val();

    if (!isAmount(strValue)) {
        event.returnValue = false;
    }
}

function fnUserCtl_Number_Keyup(CtrObj, evt) {
    var strValue = $(CtrObj).val();

    if (!isAmount(strValue)) {
        strValue = ChangeAmount(strValue); //  strValue.substring(0, strValue.length - 1);
        $(CtrObj).val(strValue);
        $(CtrObj).focus();
    }

    if (strValue.indexOf(gDecimalSep, 0) != -1) {
        var oTemp = strValue.split(gDecimalSep);
        if (oTemp.length > 2) {
            $(CtrObj).val(oTemp[0] + gDecimalSep + oTemp[1]);
        }
    }

    strValue = $(CtrObj).val();

    var Point = $(CtrObj).attr("point");

    strValue = DisplayAmount(strValue, Point);

    $(CtrObj).val(strValue);
}

function isAmount(strNum) {
    var chars = "0123456789" + gGroupSep + gDecimalSep;
    return containsCharsOnly(strNum, chars);
}

function containsCharsOnly(strChars, chars) {
    for (var inx = 0; inx < strChars.length; inx++) {
        if (chars.indexOf(strChars.charAt(inx)) == -1) {
            return false;
        }
    }

    return true;
}

function ChangeAmount(strNum) {
    var chars = "0123456789" + gGroupSep + gDecimalSep;
    return ChangecontainsCharsOnly(strNum, chars);
}

function ChangecontainsCharsOnly(strChars, chars) {
    for (var inx = 0; inx < strChars.length; inx++) {
        if (chars.indexOf(strChars.charAt(inx)) == -1) {
            strChars = strChars.replace(strChars.charAt(inx), "");
            return strChars;
        }
    }

    return strChars;
}

function DisplayAmount(strValue, Point) {
    var dp = "";
    var sAfterDecimalSep = "";
    var bUseDecimalSep = false;
    var sBeforeDecimalSep = "";
    var sReturnValue = "";

    if (gDecimalSep != " " && gGroupSep != " ")
        strValue = $.trim(strValue);

    if (strValue.indexOf(gDecimalSep, 0) != -1) {
        var oTemp = strValue.split(gDecimalSep);

        sBeforeDecimalSep = oTemp[0];

        if (oTemp[1].length > Point)
            sAfterDecimalSep = oTemp[1].substring(0, Point);
        else
            sAfterDecimalSep = oTemp[1];

        bUseDecimalSep = true;
    }
    else
        sBeforeDecimalSep = strValue;

    var sTempValue = sBeforeDecimalSep.split(gGroupSep);
    sBeforeDecimalSep = sTempValue.join("");

    dp = sBeforeDecimalSep.length;
    dp -= 3;

    while (dp > 0) {
        sReturnValue = gGroupSep + sBeforeDecimalSep.substr(dp, 3) + sReturnValue;
        dp -= 3;
    }

    if (dp <= 0) {
        if (sReturnValue.length > 0)
            sReturnValue = sBeforeDecimalSep.substr(0, dp + 3) + sReturnValue;
        else
            sReturnValue = sBeforeDecimalSep;
    }

    if (bUseDecimalSep > 0)
        sReturnValue = sReturnValue + gDecimalSep + sAfterDecimalSep;

    return sReturnValue;
}

var valueCtl;
var textCtl;
var TokenCtl;

function fnDeptUserSelectPopToken(co_id, valueId, tokenId) {
    fnDeptUserSelectDivPopToken("GROUP", co_id, valueId, tokenId);
}

function fnDeptUserSelectDivPopToken(orgDiv, co_id, valueId, textId, tokenId) {

    valueCtl = valueId;
    textCtl = textId;
    TokenCtl = tokenId;

    if ($(textCtl).attr("div") == undefined) return;

    if ($(textCtl).attr("multiyn") == undefined) return;

    var div = $(textCtl).attr("div");

    var multiYN = $(textCtl).attr("multiyn");

    if ($(valueCtl).val() == "") {
        //var obj = { 'U': null, 'D': null };
        fnSelectPop(orgDiv, co_id, "fnSetDeptUserCallbackToken", valueCtl, div, multiYN);
    }
    else {
        //var obj = jQuery.parseJSON($(valueCtl).val());
        fnSelectPop(orgDiv, co_id, "fnSetDeptUserCallbackToken", valueCtl, div, multiYN);
    }
}

function fnSetDeptUserCallbackToken(rtnJson) {

    var disType = "2|1";

    if ($(textCtl).attr("distype") !== undefined) {
        disType = $(textCtl).attr("distype");
    }

    $(valueCtl).val(JSON.stringify(rtnJson));

    var nm = "";

    var index = 0;
    $.each(rtnJson, function (x) {
        $.each(rtnJson[x], function (i, t) {
            if (x == "U") {
                nm += fnSetDeptUserName(disType.split("|")[0], t.dept_nm, t.grade_nm, t.user_nm) + "/";
            }
            else if (x == "D") {
                var div = t.dept_id.substring(0, 1);

                if (div == "D") {
                    nm += fnSetDeptUserName(disType.split("|")[1], t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (div == "W") {
                    nm += fnSetDeptUserName("1", t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (div = "C") {
                    nm += fnSetDeptUserName("1", t.co_nm, t.grade_cd, t.user_nm) + "/";
                }
            }


        });

    });

    $(textCtl).val(nm.substring(0, nm.length - 1));

    fnTokenInputDisplayUserInfo($(valueCtl).attr("rec_div"), jQuery.parseJSON($(valueCtl).val()));
}

function fnDeptUserSelectPop(co_id, valueId, textId) {
    fnDeptUserSelectDivPop("GROUP", co_id, valueId, textId);
}

function fnDeptUserSelectDivPop(orgDiv , co_id, valueId, textId) {

    valueCtl = valueId;
    textCtl = textId;

    /*if ($(textCtl).attr("div") == undefined) return;

    if ($(textCtl).attr("multiyn") == undefined) return;*/
    if (!$(textCtl).attr("div")) return;
    if (!$(textCtl).attr("multiyn")) return;
    
    var div = $(textCtl).attr("div");

    var multiYN = $(textCtl).attr("multiyn");

    if ($(valueCtl).val() == "") {
        //var obj = { 'U': null, 'D': null };
        fnSelectPop(orgDiv, co_id, "fnSetDeptUserCallback", valueCtl, div, multiYN);
    }
    else {
        //var obj = jQuery.parseJSON($(valueCtl).val());
        fnSelectPop(orgDiv, co_id, "fnSetDeptUserCallback", valueCtl, div, multiYN);
    }
}


function fnSetDeptUserCallback(rtnJson) {

    var disType = "2|1";

    if ($(textCtl).attr("distype") !== undefined) {
        disType = $(textCtl).attr("distype");
    }

    $(valueCtl).val(JSON.stringify(rtnJson));
       
    var nm = "";

    var index = 0;
    $.each(rtnJson, function (x) {
        $.each(rtnJson[x], function (i, t) {
            if (x == "m") {
                nm += fnSetDeptUserName(disType.split("|")[0], t.dept_nm, t.grade_nm, t.user_nm) + "/";
            }
            else if (x == "d") {
                var div = t.dept_id.substring(0, 1);

                if (div == "d") {
                    nm += fnSetDeptUserName(disType.split("|")[1], t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (div == "b") { //사업장
                    nm += fnSetDeptUserName("1", t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (div = "c") {
                    nm += fnSetDeptUserName("1", t.co_nm, t.grade_cd, t.user_nm) + "/";
                }
            }
          
          
        });

    });

    $(textCtl).val(nm.substring(0, nm.length - 1));
}

function fnSetDeptUserBinding(cd_target, nm_target, result) {


    var disType = "2|1"; //사원명, 부서명

    if ($(nm_target).attr("distype") !== undefined)
        disType = $(nm_target).attr("distype");

    var User = new Array();
    var Dept = new Array();

    var nms = "";
    
    if (result != null) {
        $.each(result, function (i, t) {

            if (t != null) {

                var item = {};

                item.co_id = t.co_id;
                item.work_id = t.work_id;
                item.user_id = t.user_id;

                if (t.org_div == "U") {
                    item.dept_id = t.dept_id;
                    User.push(item);
                    nms += fnSetDeptUserName(disType.split("|")[0], t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (t.org_div == "D") {
                    item.dept_id = "D" + t.dept_id;
                    Dept.push(item);
                    nms += fnSetDeptUserName(disType.split("|")[1], t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (t.org_div == "C") {
                    item.dept_id = "C" + t.co_id;
                    Dept.push(item);
                    nms += fnSetDeptUserName("1", t.co_nm, t.grade_cd, t.user_nm) + "/";
                }
                else if (t.org_div == "W") {
                    item.dept_id = "W" + t.dept_id;
                    Dept.push(item);
                    nms += fnSetDeptUserName("1", t.dept_nm, t.grade_cd, t.user_nm) + "/";
                }
            }

        });
    }

    var DTO = { 'U': User, 'D': Dept };

    $(cd_target).val(JSON.stringify(DTO));
    $(nm_target).val(nms.substring(0, nms.length - 1));
}

function fnGetDeptUserBinding(rtnJson) {

    var User = new Array();

    var org_div = "DEPT";

    $.each(rtnJson, function (x) {
        $.each(rtnJson[x], function (i, t) {
            if (x == "m") {

                var item = {};

                item.org_div = x;
                item.co_id = t.co_id;
                item.work_id = t.work_id;
                item.dept_id = t.dept_id;
                item.user_id = t.user_id;

                User.push(item);
            }
            else if (x == "d" || x == "b") {

                var div = t.dept_id.substring(0, 1);

                var item = {};

                item.org_div = div;
                item.co_id = t.co_id;
                item.work_id = t.work_id;
                item.dept_id = t.dept_id.substring(1, t.dept_id.length);
                item.user_id = t.user_id;

                User.push(item);
            }
        });

    });

    return User;

}

function fnGetDeptUserBinding2(rtnJson) {

    var User = new Array();

    var org_div = "DEPT";

    $.each(rtnJson, function (x) {
        $.each(rtnJson[x], function (i, t) {
            if (x == "U") {

                var item = {};

                item.org_div = x;
                item.co_id = t.co_id;
                item.work_id = t.work_id;
                item.dept_id = t.dept_id;
                item.user_id = t.user_id;
                item.co_nm = t.co_nm;
                item.work_nm = t.work_nm;
                item.dept_nm = t.dept_nm;
                item.user_nm = t.user_nm;
                item.grade_nm = t.grade_nm;

                User.push(item);
            }
            else if (x == "D") {

                var div = t.dept_id.substring(0, 1);

                var item = {};

                item.org_div = div;
                item.co_id = t.co_id;
                item.work_id = t.work_id;
                item.dept_id = t.dept_id.substring(1, t.dept_id.length);
                item.user_id = t.user_id;
                item.co_nm = t.co_nm;
                item.work_nm = t.work_nm;
                item.dept_nm = t.dept_nm;


                User.push(item);
            }
        });

    });

    return User;

}

function fnSetDeptUserName(DisType, deptNm, gradeNm, userNm) {


    var rtnValue = "";

    switch (DisType) {
        case "1":
            rtnValue = "{0}".format(deptNm);
            break;
        case "2":
            rtnValue = "{0}".format(userNm);
            break;
        case "3":
            rtnValue = "{0}|{1}".format(deptNm, userNm);
            break;
        case "4":
            rtnValue = "{0}|{1}|{2}".format(deptNm, gradeNm, userNm);
            break;
        case "5":
            rtnValue = "{0}|{1}".format(gradeNm, userNm);
            break;
        default:
            rtnValue = "";
    }


    return rtnValue;


}

// 관리자권한정보 - target1 : 권한구분, target2 : 그룹(그룹+회사, 그룹 권한자일경우), target3 : 회사(그룹+회사, 그룹, 회사 권한자일결우)
function fnGetAdminInfo(pUserID, target1, target2, target3) {
    var tblParam = {};
    tblParam.user_id = pUserID;

    var url = "/Cm/CmCommon/GetAdminInfo";

    $.ajax({
        type: "POST"
            , contentType: "application/json; charset=utf-8"
            , url: url
            , async: false
            , global: false
            , data: JSON.stringify(tblParam)
            , success: function (result) {
                //alert(result);
                if (result[0].admin_div != "") {
                    $("#" + target1.attr("id")).val(result[0].admin_div); //admin_div : M(마스터), SM(시스템), GC(그룹+회사), G(그룹), C(회사)
                    $("#" + target2.attr("id")).val(result[0].group_ids);
                    $("#" + target3.attr("id")).val(result[0].co_ids);
                }
                else {

                }
            }
            , error: function (result) { alert(fnGetLANGPACKJsonParsing("TX000002003", "작업이 실패하였습니다.")); }
    });

}

// 페이징 스크립트 생성함수
function fnLoadPaging(Target, callback, TotalPageCount, pagePerScreen, PageIndex) {

    $('#hidPaging').val(PageIndex);

    var url = "/KD/KDDoc/Paging?callback=" + callback + "&TotalPageCount=" + TotalPageCount + "&pagePerScreen=" + pagePerScreen + "&PageIndex=" + PageIndex;

    $.ajax({
        type: "POST"
                , contentType: "application/json; charset=utf-8"
                , url: url
                , async: false
                , global: false
                , success: function (result) {
                    $(Target).html("");
                    $(Target).html(result);
                }
                , error: function (data, status, err) {
                    alert("code:" + data.status + " message:" + data.responseText);
                }

    });
}

// DropDownList 관리회사 바인딩
function fnSetAdminDDL(GwUserLevel, BindValues, Control) {
    if (GwUserLevel == "SM" || GwUserLevel == "GW") {
        //
    }
    else {
        var arrBindValue = BindValues.split(',');
        var selCnt = Control.get(0).length;
        
        for (i = selCnt; i >= 0; i--) {
            var cnt = 0;
            $.each(arrBindValue, function (j) {
                if ($("#" + Control.attr("id") + " option:eq(" + i + ")").val() == arrBindValue[j]) {
                    cnt++;
                }
            });

            if (cnt == 0) {
                $("#" + Control.attr("id") + " option:eq(" + i + ")").remove();
            }
        }
    }
}

//숫자 콤마 제거 
(function ($) {
    $.fn.toPrice = function (cipher) {
        var strb, len, revslice, minus;
        minus = '';
        strb = $(this).val().toString();
        if (strb.charAt(0) == '-')
            minus = strb.charAt(0);
        strb = strb.replace(/-,/g, '');
        strb = $(this).getOnlyNumeric();
        strb = parseInt(strb, 10);
        if (isNaN(strb)) {
            return $(this).val(minus + '');
        }
        strb = strb.toString();
        len = strb.length;

        if (len < 4) {
            return $(this).val(minus + strb);
        }
        if (cipher == undefined || !isNumeric(cipher))
            cipher = 3;

        count = len / cipher;
        slice = new Array();

        for (var i = 0; i < count; ++i) {
            if (i * cipher >= len)
                break;
            slice[i] = strb.slice((i + 1) * -cipher, len - (i * cipher));
        }

        revslice = slice.reverse();
        return $(this).val(minus + revslice.join(','));
    }

    $.fn.getOnlyNumeric = function (data) {
        var chrTmp, strTmp;
        var len, str;

        if (data == undefined) {
            str = $(this).val();
        }
        else {
            str = data;
        }

        len = str.length;
        strTmp = '';

        for (var i = 0; i < len; ++i) {
            chrTmp = str.charCodeAt(i);
            
            if ((chrTmp > 47 || chrTmp <= 31) && chrTmp < 58) {
                strTmp = strTmp + String.fromCharCode(chrTmp);
            }
        }

        if (data == undefined)
            return strTmp;
        else
            return $(this).val(strTmp);
    }

    var isNumeric = function (data) {
        var len, chrTmp;

        len = data.length;
        for (var i = 0; i < len; ++i) {
            chrTmp = str.charCodeAt(i);
            if ((chrTmp <= 47 && chrTmp > 31) || chrTmp >= 58) {
                return false;
            }
        }

        return true;
    }
})(jQuery);

// IF설정에 따른 체크박스 생성 - div(target)를 넘겨주면 설정값에 따라 checkbox를 생성
function fnSetIFCheckBox(target, co_id, if_id) {
    var tblParam = {};
    tblParam.co_id = co_id;
    tblParam.if_id = if_id;

    var url = "/Sm/SmOptionIF/GetOptionIFSetInfo";

    $.ajax({
        type: "POST"
        , async: false
        , global: false
        , contentType: "application/json; charset=utf-8"
        , url: url
        , data: JSON.stringify(tblParam)
        , success: function (result) {

            var chkList = "";

            //            10	메신저쪽지
            //            20	메신저알람
            //            30	메일
            //            40	사내통신
            //            50	SMS


            $(result).each(function () {

                if (result[0].paper_yn == "1") {
                    chkList += "<input type='checkbox' id='chkPaper' name='chkAlramGroup' value='10' class='input-check'/><label>" + fnGetLANGPACKJsonParsing('TX000000260', '쪽지') + "&nbsp </label>";
                   
                }
                // 알림
                if (result[0].alert_yn == "1") {
                    chkList += "<input type='checkbox' id='chkAlert' name='chkAlramGroup' value='20' class='input-check'/><label>" + fnGetLANGPACKJsonParsing('TX000000893', '알림') + "&nbsp </label>";
                }
                // 메일
                if (result[0].mail_yn == "1") {
                    chkList += "<input type='checkbox' id='chkMail' name='chkAlramGroup' value='30' class='input-check'/><label>" + fnGetLANGPACKJsonParsing('TX000000262', '메일') + "&nbsp </label>";
                }
                // SMS
                if (result[0].sms_yn == "1") {
                    chkList += "<input type='checkbox' id='chkSMS' name='chkAlramGroup' value='50' class='input-check'/><label>" + fnGetLANGPACKJsonParsing('TX000000263', 'SMS') + "&nbsp </label>";
                }
                // 사내통신
                if (result[0].ic_yn == "1") {
                    chkList += "<input type='checkbox' id='chkIC' name='chkAlramGroup' value='40' class='input-check'/><label>" + fnGetLANGPACKJsonParsing('TX000003810', '사내통신') + "&nbsp </label>";
                }
            });

            $(target).html(chkList);

        }

    });
}

// 옵션IF 설정값 조회
function fnGetOptionIFSet(co_id, if_id) {
    var arrReturn = new Array();
    
    var tblParam = {};
    tblParam.co_id = co_id;
    tblParam.if_id = if_id;

    var url = "/Sm/SmOptionIF/GetOptionIFSetInfo";
    
    $.ajax({
        type: "POST"
        , async: false
        , global: false
        , contentType: "application/json; charset=utf-8"
        , url: url
        , data: JSON.stringify(tblParam)
        , success: function (result) {
            arrReturn = result;
        }
    });

    return arrReturn;
}

// 옵션IF 알림대상 조회
function fnGetOptionIFTarget(co_id, if_id) {
    var arrReturn = new Array();
    
    var tblParam = {};
    tblParam.co_id = co_id;
    tblParam.if_id = if_id;

    var url = "/Sm/SmOptionIF/GetOptionIFTargetInfo";

    $.ajax({
        type: "POST"
        , async: false
        , global: false
        , contentType: "application/json; charset=utf-8"
        , url: url
        , data: JSON.stringify(tblParam)
        , success: function (result) {
            arrReturn = result;
        }
    });

    return arrReturn;
}

function isValidPhone(input) {

    var format = /^(\d+)-(\d+)-(\d+)$/;

    var chkFlg = format.test(input);

    return chkFlg;

}

function isValidPhone1(input) {
    var rgEx = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;
    var chkFlg = rgEx.test(input);

    return chkFlg
}

function isNumHyphen(input) {
    var chars = "-0123456789";

    return containsCharsOnly(input, chars);
}

// 스크립트 쿠기 생성
function setCookie(cName, cValue, cDay) {
    var expire = new Date();

    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + cValue + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.

    if (typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';

    document.cookie = cookies;
}


function fnBackspacePageLoad(funcCall) {
    $(document).keydown(function (e) {

        var $target = $(event.target);
        var element = e.target.nodeName.toLowerCase();
        var tagname = $(e.target).attr("type");


        if (element != 'input' && element != 'textarea' && element != 'select') {
            if (e.keyCode === 8) {

                fnDynamicFunctionCall(funcCall);
                return false;
            }
        } else {

            var readonly = $(e.target).attr("readonly");
            var is_readonly = readonly != 'undefined' && readonly == 'readonly';
            var disabled_or_readonly = $(e.target).is(':disabled') || is_readonly;

            if (disabled_or_readonly) return false;

            if (tagname == "checkbox" || tagname == "radio") return false;

            if (element == 'select') return false;

        } return true;
    });
}

function fnDynamicFunctionCall(funcCall) {
    ret = eval(funcCall);
}

$(function () {
    $(".click_mymn").click(function () {
        $(".mymn_list").css("display", "block");
    });
    $(".click_mymn").mouseleave(function () {
        $(".mymn_list").css("display", "none");
    });
});

function mymn_on(obj) {
    obj.style.backgroundColor = "#e4eff9";
}

function mymn_off(obj) {
    obj.style.backgroundColor = "#fff";
}

function fnPopDetail(paramUrl) {

    var intWidth = 1030;
    var intHeight = 720;
    var intLeft = screen.width / 2 - intWidth / 2;
    var intTop = screen.height / 2 - intHeight / 2 - 40;
    var url = paramUrl;

    window.open(url, "Detail_VIEW", 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);

    //dlg.OpenDialog(url, intWidth, intHeight, "상세보기");
    //PopUp(6, 1030, 720, "Detail_VIEW", paramUrl);
}


//고객정보 가져오기

var ctl_cust_id;
var ctl_cust_cd;
var ctl_cust_nm;


function fnCustSelect(callback, seltype,  objCustId, objCustCd, objCustNm) {

    ctl_cust_id = objCustId;
    ctl_cust_cd = objCustCd;
    ctl_cust_nm = objCustNm;

//    var FormNm = '@NeoBizBoxS2.Web.Helpers.TermHelpers.Get("TX000007074", "고객조회")';
    var FormNm = "고객조회";
    dlg.OpenDialog("/MP/MPCUST/CustSelPop/?callback=" + callback + "&SelType=" + seltype, 600, 500, FormNm);
}

function fnSetCustSelectCallBack(result) {

    var id = "";
    var cd = "";
    var nm = "";

    $.each(result, function (i) {
        id = id + result[i].cust_id + "/";
        cd = cd + result[i].cust_cd + "/";
        nm = nm + result[i].cust_nm + "/";
    });

    if (ctl_cust_id != "") $(ctl_cust_id).val(id.substring(0, id.length - 1));
    if (ctl_cust_cd != "") $(ctl_cust_cd).val(cd.substring(0, cd.length - 1));
    if (ctl_cust_nm != "") $(ctl_cust_nm).val(nm.substring(0, nm.length - 1));

    ctl_cust_id = "";
    ctl_cust_cd = "";
    ctl_cust_nm = "";
}

// 프로젝트 정보가져오기
var ctl_pjt_id;
var ctl_pjt_nm;

function fnPjtSelect(callback, seltype, objPjtId, objPjtNm) {

    ctl_pjt_id = objPjtId;
    ctl_pjt_nm = objPjtNm;

    var FormNm = "프로젝트선택";
//    var FormNm = '@NeoBizBoxS2.Web.Helpers.TermHelpers.Get("TX000007079", "프로젝트선택")';
    dlg.OpenDialog("/OT/OTPJTMNG/PjtSelPop/?callback=" + callback + "&SelType=" + seltype, 600, 500, FormNm);
}


function fnSetPjtSelectCallBack(result) {

    var id = "";
    var nm = "";

    $.each(result, function (i) {
        id = id + result[i].pjt_id + "/";
        nm = nm + result[i].pjt_name + "/";

    });

    if (ctl_pjt_id != "") $(ctl_pjt_id).val(id.substring(0, id.length - 1));
    if (ctl_pjt_nm != "") $(ctl_pjt_nm).val(nm.substring(0, nm.length - 1));

    ctl_pjt_id = "";
    ctl_pjt_nm = "";

}

// 첨부파일 확장자 체크
function fnAttFileCheck(strFileName) {
    LimitExt = new Array("exe", "dll", "scr", "bat", "com", "scr", "vbs", "reg", "js", "asp", "aspx", "asa", "cer", "msi", "lnk");

    if (LimitExt.length == 0) {
        return true;
    }

    var bRet = true;
    var strExt = strFileName.split(".");
    var strExt2 = strExt[strExt.length - 1].toLowerCase();

    for (var i = 0; i < LimitExt.length; i++) {
        var limitExt2 = LimitExt[i].toLowerCase();

        if (strExt2 == limitExt2) {
            bRet = false;
            break;
        }
    }

    if (!bRet) {
        alert(strExt2 + " 파일은 선택 하실 수 없습니다.");
    }

    return bRet;
}

//이미지 확장자 및 파일용량 체크
function FileCheck(fileId) {
    var returnVal = 0;
    if (!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test($(fileId).val())) {
        fileId.outerHTML = fileId.outerHTML;
        alert("이미지 형식의 파일을 선택하십시오.");
        returnVal = -1;
    }

    var iSize = 0;

    if ($.browser.msie) {
        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
        var sPath = $(fileId)[0].value;
        var objFile = objFSO.getFile(sPath);
        iSize = objFile.size;
    } else {
        iSize = ($(fileId)[0].files[0].size);
    }

    // 파일의 크기가 커지면 불러오는 시간이 길어지기 때문 
    if (iSize > 245760) {
        fileId.outerHTML = fileId.outerHTML;
        alert("용량이 300KB를 초과한 파일은 선택하실 수 없습니다.");
        returnVal = -1;
    }

    return returnVal;
}

//이미지 확장자체크
function FileCheckSizeFree(fileId) {
    var returnVal = 0;
    if (!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test($(fileId).val())) {
        fileId.outerHTML = fileId.outerHTML;
        alert("이미지 형식의 파일을 선택하십시오.");
        returnVal = -1;
    }

    var iSize = 0;

    if ($.browser.msie) {
        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
        var sPath = $(fileId)[0].value;
        var objFile = objFSO.getFile(sPath);
        iSize = objFile.size;
    } else {
        iSize = ($(fileId)[0].files[0].size);
    }
    return returnVal;
}

//브라우저 체크 메소드 -1이상이면 IE이다
function getInternetExplorerVersion() {
    var rv = -1;
    if (navigator.appName == 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    else if (navigator.appName == 'Netscape') {
        var ua = navigator.userAgent;
        var re = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}

//메뉴이동 히스토리
function fnSetMoveMenuHistory(user_id, use_menu_id, login_ip) {

    var tblParam = {};
    tblParam.user_id = user_id;
    tblParam.menu_id = use_menu_id;

    var url = "/Sm/SmAdmin/SetUseMenuHistory";

    $.ajax({
        type: "POST"
        , async: false
        , global: false
        , contentType: "application/json; charset=utf-8"
        , url: url
        , data: JSON.stringify(tblParam)
        , success: function (result) {
            arrReturn = result;
        }
    });

    return arrReturn;
}

function fnTextAreaMaxlength(obj) {
    var limit = parseInt($(obj).attr('maxlength'));
    var text = $(obj).val();
    var chars = text.length;

    if (chars > limit) {
        var new_text = text.substr(0, limit);
        $(obj).val(new_text);
    }
}

//대상 컨트롤은 input태그만 처리
//특수문자 치환해주는 작업
$(window).load(function () {
    //some code after ready 
    
    var tags = document.getElementsByTagName("input");
    for (var i = 0; i < tags.length; i++) {
        if ($(tags[i]).length > 0) {
            //change메소드는 특수문자 치환해주는 작업
            if (tags[i].type != "file") {//file은 제외시킨다
                $(tags[i]).change(function () {
                    var str = $(this).val();
                    if (str == undefined)
                        str = "";
                    var convertStr = str.replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"");
                    $(this).val(convertStr);
                }).change();
            }
        }
    }
});

//검색일자 달력 클릭 시 배경화면 숨김처리        
$.each($(".date-nobg"), function (index) {
    $(this).next("image").click(function () {
        $("#viewLoading2").css("display", "none");
    });
});

// input박스 라디오, 체크박스에 포인터 스타일 적용
$("input:radio").next().css("cursor", "pointer");
$("input:radio").css("cursor", "pointer");

//태그에 입력할 텍스트에서 문제가 될만한 문자를 escape처리함
var entityMap = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'\/]/g, function (s) {
        return entityMap[s];
    });
}


function coComboBox() {
    var coId = fnGetCmCode("", "CO", ""); // 회사리스트 - 관리자 겸직 전체 
	$("#co_id").kendoComboBox({
		dataSource : coId,
        dataTextField: "cd_nm",
        dataValueField: "cd_id",
        index: 0,
        change : onCoChange
    });
	
    var coCombobox = $("#co_id").data("kendoComboBox");
    
    coCombobox.dataSource.insert(0, { cd_nm: "전체", cd_id: "" });
    coCombobox.refresh();
    coCombobox.select(0);
}

//전체조회 제거
function coComboBoxNotAll() {
	 var coId = fnGetCmCode("", "CO", ""); // 회사리스트 - 관리자 겸직 전체 
		$("#co_id").kendoComboBox({
			dataSource : coId,
	        dataTextField: "cd_nm",
	        dataValueField: "cd_id",
	        index: 0,
	        change : onCoChange
	    });
		
	    var coCombobox = $("#co_id").data("kendoComboBox");
	    
	    coCombobox.refresh();
	    coCombobox.select(0);
}
