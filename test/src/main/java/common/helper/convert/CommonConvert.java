package common.helper.convert;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.eclipse.jetty.util.log.Log;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("CommonConvert")
public class CommonConvert {

    private static String getDateCode(Object o) {
        String toO = "";
        String returnVal = "";
        try {
            toO = o.toString();
            toO = toO.replace("-", "");
            returnVal = toO.substring(0, 4) + "-" + toO.substring(4, 6) + "-" + toO.substring(6, 8);
        } catch (Exception ex) {
            returnVal = "";
        }
        return returnVal;
    }

    private static String getCurrencyCode(Object o) {
        String returnVal = "";
        try {
            returnVal = String.format("%,.0f", Double.parseDouble(o.toString()));
        } catch (Exception ex) {
            returnVal = "0";
        }
        return returnVal;
    }

    /**
     * NP ?????? ?????? ??????
     */
    public static ResultVO setNpResultFormat(ResultVO param) {

        /* resultVO aData ?????? */
        Map<String, Object> resultAData = new HashMap<String, Object>();
        Map<String, Object> aData = param.getaData();
        Iterator<String> iterator = aData.keySet().iterator();

        while (iterator.hasNext()) {
            String key = iterator.next();
            switch (key) {
                case "resDate":
                case "regDate":
                    resultAData.put(key, getDateCode(aData.get(key)));
                    break;
                case "tradeAmt":
                case "tradeStdAmt":
                case "tradeVatAmt":
                case "resAmt":
                case "budgetAmt":
                case "erpOpenAmt":
                case "erpApplyAmt":
                case "erpLeftAmt":
                case "budgetStdAmt":
                case "budgetTaxAmt":
                    resultAData.put(key, getCurrencyCode(aData.get(key)));
                default:
                    resultAData.put(key, aData.get(key));
                    break;
            }
        }
        param.setaData(resultAData);

        /* resultVO aaData ?????? */
        List<Map<String, Object>> aaData = param.getAaData();

        for (int i = 0; i < aaData.size(); i++) {
            Map<String, Object> item = aaData.get(i);
            Iterator<String> iterator2 = item.keySet().iterator();

            while (iterator2.hasNext()) {
                String key = iterator2.next();
                switch (key) {
                    case "resDate":
                    case "regDate":
                        item.put(key, getDateCode(item.get(key)));
                        break;
                    case "tradeAmt":
                    case "tradeStdAmt":
                    case "tradeVatAmt":
                    case "resAmt":
                    case "budgetAmt":
                    case "erpOpenAmt":
                    case "erpApplyAmt":
                    case "erpLeftAmt":
                    case "budgetStdAmt":
                    case "budgetTaxAmt":
                    case "consDocAmt":
                        item.put(key, getCurrencyCode(item.get(key)));
                    default:
                        item.put(key, item.get(key));
                        break;
                }
            }
        }
        param.setAaData(aaData);

        /* ?????? ????????? ?????? */
        return param;
    }

    /* NULL to ... */
    /* NULL to ... - EmptyStr ?????? */
    public static String CommonGetStr(Object params) {
        String result = commonCode.EMPTYSTR;
        if (params != null) {
            result = (StringUtils.isEmpty(String.valueOf(params)) ? commonCode.EMPTYSTR : String.valueOf(params));
        }
        return result;
    }

    /* NULL to ... - EmptySeq ?????? */
    public static String CommonGetSeq(Object params) {
        String result = commonCode.EMPTYSEQ;
        if (params != null) {
            result = (StringUtils.isEmpty(String.valueOf(params)) ? commonCode.EMPTYSEQ : String.valueOf(params));
        }
        return result;
    }

    /* NULL to ... - 0.0 ?????? */
    public static double CommonGetDouble(Object params) {
        double result = Double.parseDouble("0.0");
        if (params != null) {
            if ((CommonConvert.CommonGetStr(params).equals(""))) {
                result = Double.parseDouble("0.0");
            } else {
                if (CommonConvert.CommonGetStr(params).indexOf(".") > -1) {
                    result = Double.parseDouble(CommonConvert.CommonGetStr(params));
                } else {
                    result = Double.parseDouble(CommonConvert.CommonGetStr(params) + ".0");
                }
            }
        }
        return result;
    }

    /* Map to ... */
    /* map to ... - Map to Get String ?????? */
    public static String CommonGetParamStr(Map<String, Object> params) {
        String keyAttribute = commonCode.EMPTYSTR;
        StringBuilder result = new StringBuilder();
        Iterator<String> itr = params.keySet().iterator();
        while (itr.hasNext()) {
            keyAttribute = itr.next();
            if (!CommonConvert.CommonGetStr(result).equals(commonCode.EMPTYSTR)) {
                result.append("&" + keyAttribute + "=" + (String) params.get(keyAttribute));
            } else {
                result.append("?" + keyAttribute + "=" + (String) params.get(keyAttribute));
            }
        }
        return result.toString();
    }

    /* Map to ... - Map to String ?????? */
    public static String CommonGetMapStr(Map<String, Object> params) {
        String result = commonCode.EMPTYSTR;
        result = (params == null ? commonCode.EMPTYSTR : params.toString());
        return result;
    }

    /* Map to ... - Map to JSON String ?????? */
    public static String ConvertMapToJson(Map<String, Object> params) {
        return CommonConvert.CommonGetMapToJSONStr(params);
    }

    public static String CommonGetMapToJSONStr(Map<String, Object> params) {
        String result = commonCode.EMPTYSTR;
        JSONObject json = new JSONObject();
        Set<String> key = params.keySet();
        for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
            String keyName = CommonConvert.CommonGetStr(iterator.next());
            json.put(keyName, CommonGetStr(params.get(keyName)));
        }
        result = CommonGetStr(json.toString());
        return result;
    }

    /* Map to ... - Map to JSON Object ?????? */
    public static JSONObject CommonGetMapToJSONObj(Map<String, Object> params) {
        JSONObject result = new JSONObject();
        Set<String> key = params.keySet();
        for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
            String keyName = CommonConvert.CommonGetStr(iterator.next());
            result.put(keyName, CommonGetStr(params.get(keyName)));
        }
        return result;
    }

    /* Helper - ListMap To JSON */
    public static String CommonGetListMapToJson(List<Map<String, Object>> param) throws Exception {
        String result = commonCode.EMPTYSTR;
        JSONArray jsonArray = JSONArray.fromObject(param);
        result = jsonArray.toString();
        return result;
    }

    /* Helper - ListMap To JSON */
    public static JSONArray ConvertListMapToJson(List<Map<String, Object>> param) throws Exception {
        return CommonConvert.CommonGetListMapToJsonArray(param);
    }

    public static JSONArray CommonGetListMapToJsonArray(List<Map<String, Object>> param) throws Exception {
        JSONArray jsonArray = JSONArray.fromObject(param);
        return jsonArray;
    }

    /* Map to ... - Map to Object ?????? */
    public static Object ConvertMapToObject(Map<String, Object> params, Object objClass) {
        return CommonConvert.CommonGetMapToObject(params, objClass);
    }

    public static Object CommonGetMapToObject(Map<String, Object> params, Object objClass) {
        String keyAttribute = null;
        String setMethodString = "set";
        String setMethod = null;
        String getMethodString = "get";
        String getMethod = null;
        Object obj = new Object();
        Iterator<String> itr = params.keySet().iterator();
        while (itr.hasNext()) {
            keyAttribute = itr.next();
            setMethod = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
            getMethod = getMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
            try {
                Method[] methods = objClass.getClass().getDeclaredMethods();
                /* Get */
                for (int i = 0; i <= methods.length - 1; i++) {
                    if (getMethod.equals(methods[i].getName())) {
                        obj = methods[i].invoke(objClass);
                    }
                }
                /* Set */
                for (int i = 0; i <= methods.length - 1; i++) {
                    if (setMethod.equals(methods[i].getName())) {
                        if (obj.getClass().getName().equals("java.lang.String")) {
                            methods[i].invoke(objClass, CommonConvert.CommonGetStr(params.get(keyAttribute)));
                        } else {
                            methods[i].invoke(objClass, Integer.parseInt(CommonConvert.CommonGetSeq(params.get(keyAttribute))));
                        }
                    }
                }
            } catch (SecurityException e) {
                /* e.printStackTrace(); */
            } catch (IllegalAccessException e) {
                /* e.printStackTrace(); */
            } catch (IllegalArgumentException e) {
                /* e.printStackTrace(); */
            } catch (InvocationTargetException e) {
                /* e.printStackTrace(); */
            }
        }
        return objClass;
    }
    /* List to ... */

    /* Object to ... */
    /* Object to ... - Object to Map ?????? */
    public static Map<String, Object> ConverObjectToMap(Object params) {
        return CommonConvert.CommonGetObjectToMap(params);
    }

    public static Map<String, Object> CommonGetObjectToMap(Object params) {
        try {
            Field[] fields = params.getClass().getDeclaredFields();
            Map<String, Object> result = new HashMap<String, Object>();
            for (int i = 0; i <= fields.length - 1; i++) {
                fields[i].setAccessible(true);
                result.put(fields[i].getName(), CommonGetStr(fields[i].get(params)));
            }
            return result;
        } catch (IllegalArgumentException e) {
            /* e.printStackTrace(); */
        } catch (IllegalAccessException e) {
            /* e.printStackTrace(); */
        }
        return null;
    }

    /* JSON to ... */
    /* JSON to ... - JSON to Map */
    public static Map<String, Object> ConvertJsonToMap(String params) {
        return CommonConvert.CommonGetJSONToMap(params);
    }

    public static Map<String, Object> CommonGetJSONToMap(String params) {
        params = CommonCharSetToString(CommonGetStr(params));
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = mapper.readValue(params, new TypeReference<Map<String, String>>() {});
        } catch (JsonParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }

    /* JSON to ... - JSON to ListMap */
    public static List<Map<String, Object>> ConvertJsonToListMap(String jsonStr) throws Exception {
        return CommonConvert.CommonGetJSONToListMap(jsonStr);
    }

    public static List<Map<String, Object>> CommonGetJSONToListMap(String jsonStr) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        jsonStr = CommonCharSetToString(jsonStr);
        try {
            result = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>() {});
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }

    public static String CommonCharSetToString(String params) {
        params = params.replaceAll("&nbsp;", " ");
        params = params.replaceAll("&nbsp", " ");
        params = params.replaceAll("&lt;", "<");
        params = params.replaceAll("&lt", "<");
        params = params.replaceAll("&gt;", ">");
        params = params.replaceAll("&gt", ">");
        params = params.replaceAll("&amp;", "&");
        params = params.replaceAll("&amp", "&");
        params = params.replaceAll("&quot;", "\"");
        params = params.replaceAll("&quot", "\"");
        return params;
    }

    /**
     * <pre>
     * # ????????? ????????? ????????? ????????????, ????????? ????????? ????????? Map?????? ??????
     *   - ????????? ????????? : id
     *   - ?????? ????????? : groupSeq
     *   - ?????? ????????? : compSeq
     *   - ????????? ????????? : bizSeq
     *   - ?????? ????????? : deptSeq
     *   - ?????? ????????? : empSeq
     *   - ?????? ?????? : empName
     *   - ???????????? ?????? : langCode
     *   - ????????? ?????? ?????? : userSe
     *   - ERP ?????? ?????? : erpEmpSeq
     *   - ERP ?????? ?????? : erpCompSeq
     *   - ?????? ???????????? ?????? : eaType
     *
     * # ?????? ??????
     *   - interlock.exp.web.VInterlockPopController ?????? ??????
     *   - interlock.exp.web.BInterlockController ?????? ??????
     * </pre>
     *
     * @return
     * @throws NotFoundLoginSessionException
     */
    public static Map<String, Object> CommonGetEmpInfo() throws NotFoundLoginSessionException {
        Map<String, Object> result = new HashMap<String, Object>();
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        if (loginVo == null) {
            throw new NotFoundLoginSessionException("Not found login session..");
        }

        result.put(commonCode.ID, CommonConvert.CommonGetStr(loginVo.getId())); /* ????????? ????????? */
        result.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(loginVo.getGroupSeq())); /* ??????????????? */
        result.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(loginVo.getCompSeq())); /* ??????????????? */
        result.put(commonCode.BIZSEQ, CommonConvert.CommonGetStr(loginVo.getBizSeq())); /* ?????????????????? */
        result.put(commonCode.DEPTSEQ, CommonConvert.CommonGetStr(loginVo.getOrgnztId())); /* ??????????????? */
        result.put(commonCode.EMPSEQ, CommonConvert.CommonGetStr(loginVo.getUniqId())); /* ??????????????? */
        result.put(commonCode.EMPNAME, CommonConvert.CommonGetStr(loginVo.getName())); /* ???????????? */
        result.put(commonCode.LANGCODE, CommonConvert.CommonGetStr(loginVo.getLangCode())); /* ?????????????????? */
        result.put(commonCode.USERSE, CommonConvert.CommonGetStr(loginVo.getUserSe())); /* ????????????????????? */
        result.put(commonCode.ERPEMPSEQ, CommonConvert.CommonGetStr(loginVo.getErpEmpCd())); /* ERP???????????? */
        result.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetStr(loginVo.getErpCoCd())); /* ERP???????????? */
        result.put(commonCode.EATYPE, CommonConvert.CommonGetStr(loginVo.getEaType())); /* ?????? ???????????? ?????? */

        return result;
    }

    /**
     * <pre>
     * # ????????? ????????? ?????? ??????
     *
     * # ?????? ??????
     *   - interlock.exp.web.VInterlockPopController ?????? ??????
     *   - interlock.exp.web.BInterlockController ?????? ??????
     *
     * # ?????? ?????? getter
     *   - ????????? ????????? : getId()
     *   - ?????? ????????? : getGroupSeq()
     *   - ?????? ????????? : getCompSeq()
     *   - ????????? ????????? : getBizSeq()
     *   - ?????? ????????? : getOrgnztId()
     *   - ?????? ????????? : getUniqId()
     *   - ?????? ?????? : getName()
     *   - ???????????? ?????? : getLangCode()
     *   - ????????? ?????? ?????? : getUserSe()
     *   - ERP ?????? ?????? : getErpEmpCd()
     *   - ERP ?????? ?????? : getErpCoCd()
     *   - ?????? ???????????? ?????? : getEaType()
     *
     * </pre>
     *
     * @return bizbox.orgchart.service.vo.LoginVO
     * @throws NotFoundLoginSessionException
     */
    public static LoginVO CommonGetEmpVO() throws NotFoundLoginSessionException {
        LoginVO loginVo = new LoginVO();
        loginVo = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);

        if (loginVo == null) {
            /* ERPiU oracle ????????? */
            // loginVo = new LoginVO();
            // loginVo.setId("oracle");
            // loginVo.setGroupSeq("dragons_test");
            // loginVo.setCompSeq("1300");
            // loginVo.setBizSeq("1300");
            // loginVo.setOrgnztId("1302");
            // loginVo.setUniqId("1303");
            // loginVo.setName("ERPiU(?????????)");
            // loginVo.setLangCode("kr");
            // loginVo.setUserSe("ADMIN");
            // loginVo.setErpEmpCd("1");
            // loginVo.setErpCoCd("1000");
            // loginVo.setEaType("eap");

            /* iCUBE ????????? */
            // loginVo = new LoginVO();
            // loginVo.setId("admin");
            // loginVo.setGroupSeq("dragons_test");
            // loginVo.setCompSeq("1000");
            // loginVo.setBizSeq("1000");
            // loginVo.setOrgnztId("1110");
            // loginVo.setUniqId("1");
            // loginVo.setName("admin");
            // loginVo.setLangCode("kr");
            // loginVo.setUserSe("ADMIN");
            // loginVo.setErpEmpCd("admin");
            // loginVo.setErpCoCd("3585");
            // loginVo.setEaType("eap");

            /* ????????????????????? */
            // loginVo = new LoginVO();
            // loginVo.setId("admin");
            // loginVo.setGroupSeq("sbtrustastest");
            // loginVo.setCompSeq("1000");
            // loginVo.setBizSeq("1000100");
            // loginVo.setOrgnztId("1000111140");
            // loginVo.setUniqId("23324");
            // loginVo.setName("?????????");
            // loginVo.setLangCode("kr");
            // loginVo.setUserSe("USER");
            // loginVo.setErpEmpCd("00274");
            // loginVo.setErpCoCd("1000");
            // loginVo.setEaType("eap");

            /* ??????????????? - ????????? */
            // loginVo = new LoginVO();
            // loginVo.setId("admin");
            // loginVo.setGroupSeq("THSMC");
            // loginVo.setCompSeq("1000");
            // loginVo.setBizSeq("104104");
            // loginVo.setOrgnztId("104H09007");
            // loginVo.setUniqId("16276");
            // loginVo.setName("?????????");
            // loginVo.setLangCode("kr");
            // loginVo.setUserSe("ADMIN");
            // loginVo.setErpEmpCd("104");
            // loginVo.setErpCoCd("04150HS18");
            // loginVo.setEaType("eap");

          /* ERPiU - ?????? ?????? ?????? */
          //loginVo = new LoginVO();
          //loginVo.setId("ERPiU");
          //loginVo.setGroupSeq("dragons_test");
          //loginVo.setCompSeq("1229");
          //loginVo.setBizSeq("1229");
          //loginVo.setOrgnztId("1231");
          //loginVo.setUniqId("1233");
          //loginVo.setName("ERPiU");
          //loginVo.setLangCode("kr");
          //loginVo.setUserSe("ADMIN");
          //loginVo.setErpEmpCd("0529");
          //loginVo.setErpCoCd("10000");
          //loginVo.setEaType("eap");

            // ExpInfo.TempLog("Not found login session..", null);
            // throw new NotFoundLoginSessionException("Not found login session..");
        }

        /*
        StringBuilder sb = new StringBuilder();
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] =======================================");
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ????????? : " + loginVo.getId());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ??????????????? : " + loginVo.getGroupSeq());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ??????????????? : " + loginVo.getCompSeq());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ?????????????????? : " + loginVo.getBizSeq());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ??????????????? : " + loginVo.getOrgnztId());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ??????????????? : " + loginVo.getUniqId());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ????????? : " + loginVo.getName());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ???????????? : " + loginVo.getLangCode());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ?????? : " + loginVo.getUserSe() + " / " + loginVo.getId());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ???????????? : " + loginVo.getErpEmpCd());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ???????????? : " + loginVo.getErpCoCd());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ???????????? : " + loginVo.getEaType());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] ?????? : " + RequestContextHolder.getRequestAttributes().getSessionId());
        sb.append(System.getProperty("line.separator"));
        sb.append("[_LOGIN] =======================================");
        sb.append(System.getProperty("line.separator"));
		*/
        // ExpInfo.InfoLog(sb.toString());

        return loginVo;
    }

    /* Map ?????? Map ?????? ?????? ?????? - target ????????? */
    public static Map<String, Object> CommonSetMapCopy(Map<String, Object> source) {
        Map<String, Object> result = new HashMap<String, Object>();
        result = CommonSetMapCopy(source, result);
        return result;
    }

    /* key ?????? ( Map > Map ) */
    public static Map<String, Object> CommonSetMapCopy(Map<String, Object> source, Map<String, Object> target, String[] keys) throws Exception {
        if (source != null && source.size() > 0) {
            for (String item : keys) {
                if (null == source.get(item)) {
                    target.put(item, null);
                } else {
                    target.put(item, source.get(item));
                }
            }
        }
        return target;
    }

    /* key ??? ???????????? ?????? ( Map > Map ) */
    public static Map<String, Object> CommonSetMapCopyNotKey(Map<String, Object> source) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        if (source != null) {
            Set<String> key = source.keySet();
            for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
                String keyName = CommonConvert.CommonGetStr(iterator.next());
                result.put(keyName, source.get(keyName));
            }
        }
        return result;
    }

    /* Map ?????? Map ?????? ?????? ?????? - target ?????? */
    public static Map<String, Object> CommonSetMapCopy(Map<String, Object> source, Map<String, Object> target) {
        if (source != null) {
            Set<String> key = source.keySet();
            for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
                String keyName = CommonConvert.CommonGetStr(iterator.next());
                switch (keyName) {
                    case "group_seq":
                    case commonCode.GROUPSEQ:
                        target.put(commonCode.GROUPSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "comp_seq":
                    case commonCode.COMPSEQ:
                        target.put(commonCode.COMPSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "biz_seq":
                    case commonCode.BIZSEQ:
                        target.put(commonCode.BIZSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "dept_seq":
                    case commonCode.DEPTSEQ:
                        target.put(commonCode.DEPTSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "user_id":
                    case "emp_seq":
                    case commonCode.EMPSEQ:
                        target.put(commonCode.EMPSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "erp_emp_seq":
                    case commonCode.ERPEMPSEQ:
                        target.put(commonCode.ERPEMPSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "erp_co_cd":
                    case "erpCoCd":
                    case commonCode.ERPCOMPSEQ:
                        target.put(commonCode.ERPCOMPSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "lang_code":
                    case commonCode.LANGCODE:
                        target.put(commonCode.LANGCODE, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "form_id":
                    case "formId":
                    case "template_key":
                    case commonCode.FORMSEQ:
                        target.put(commonCode.FORMSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        target.put("form_id", source.get(keyName));
                        target.put("formId", source.get(keyName));
                        target.put("template_key", source.get(keyName));
                        break;
                    case "form_tp":
                    case commonCode.FORMTP:
                        target.put(commonCode.FORMTP, source.get(keyName));
                        target.put("processId", source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "form_d_tp":
                    case commonCode.FORMDTP:
                        target.put(commonCode.FORMDTP, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "doc_id":
                    case "diKeyCode":
                    case commonCode.DOCID:
                    case commonCode.DOCSEQ:
                        target.put("diKeyCode", source.get(keyName));
                        target.put(commonCode.DOCSEQ, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "appro_key":
                    case "approkey":
                    case commonCode.APPROKEY:
                        target.put(commonCode.APPROKEY, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "type":
                    case commonCode.PROCESSID:
                        target.put(commonCode.PROCESSID, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "stat":
                    case commonCode.DOCSTS:
                        target.put(commonCode.DOCSTS, source.get(keyName));
                        target.put(keyName, source.get(keyName));
                        break;
                    case "doc_title":
                    case commonCode.DOCTITLE:
                        target.put(commonCode.DOCTITLE, source.get(keyName));
                        break;
                    case "doc_content":
                    case commonCode.DOCCONTENT:
                        target.put(commonCode.DOCCONTENT, source.get(keyName));
                        break;
                    case "interlock_url":
                    case commonCode.INTERLOCKURL:
                        target.put(commonCode.INTERLOCKURL, source.get(keyName));
                        break;
                    case "interlock_name":
                    case commonCode.INTERLOCKNAME:
                        target.put(commonCode.INTERLOCKNAME, source.get(keyName));
                        break;
                    default:
                        target.put(keyName, source.get(keyName));
                        break;
                }
                target.put(keyName, source.get(keyName));
            }
        }
        return target;
    }

    /* ????????? ???????????? ??? ?????? */
    @SuppressWarnings("deprecation")
    public static Map<String, Object> CommonSetParams(Map<String, Object> source, String[] keyArray) {
        for (String key : keyArray) {
            if (!source.containsKey(key)) {
                source.put(key, "");
                Log.debug("parameter ?????? : " + key);
            }
        }
        return source;
    }

    /* iCUBE ??????????????? G20 ??? ?????? ?????? */
    public static boolean CommonGetNP(ConnectionVO conVo) {
        switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
            case commonCode.ICUBE: /* ERP iCUBE */
                if (CommonConvert.CommonGetStr(conVo.getG20YN()).toUpperCase().equals(commonCode.EMPTYYES)) {
                    return true;
                }
                /* return false; */
                return true; /* ????????? ?????? ????????? ?????? */
            default:
                return false;
        }
    }

    /* client IP ?????? ???????????? */
    public static String CommonGetClientIP(HttpServletRequest request) {
        String result = request.getHeader("X-FORWARDED-FOR");
        if (result == null || result.length() == 0) {
            result = request.getHeader("Proxy-Client-IP");
        }
        if (result == null || result.length() == 0) {
            result = request.getHeader("WL-Proxy-Client-IP"); // ??????????
        }
        if (result == null || result.length() == 0) {
            result = request.getRemoteAddr();
        }
        if (result == null) {
            result = "";
        }
        return result;
    }

    /* Javascript??? ' ?????? ????????? ?????? */
    public static String CommonConvertSpecialCharaterForHTML(String value) {
        String result = value;
        if (result.indexOf("'") > -1) {
            result = result.replaceAll("'", "&#39;");
        }
        if (result.indexOf("\"") > -1) {
            result = result.replaceAll("\"", "&quot;");
        }
        return result;
    }

    /* Ajax ?????? ????????? ???????????? ?????? ?????? */
    public static String CommonConvertSpecialCharaterForJava(String value) {
        String result = value;
        if (result.indexOf("&apos;") > -1) {
            result = result.replaceAll("&apos;", "'");
        }
        if (result.indexOf("&quot;") > -1) {
            result = result.replaceAll("&quot;", "\"");
        }
        return result;
    }

    /* ????????? ?????? ??? ?????? ?????? */
    public static String CommonLoginAuthChk(String path, String authType) throws Exception {
        Map<String, Object> loginInfo = new HashMap<String, Object>();
        loginInfo = CommonConvert.CommonGetEmpInfo();
        if (loginInfo != null) {
            if (CommonConvert.CommonGetStr(loginInfo.get(commonCode.USERSE)).equals(authType)) {
                return path;
            } else {
                /* ?????? ?????? ?????? ?????? */
                return commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH;
            }
        } else {
            /* ????????? ?????? ?????? */
            return commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN;
        }
    }

    /* toString with null check */
    public static String NullToString(Object o) {
        String result = "";
        try {
            result = o == null ? "" : o.toString();
        } catch (Exception ex) {
            result = "";
        }
        return result;
    }

    /* toString with null check */
    public static int NullToInt(Object o) {
        int result = 0;
        try {
            result = o == null ? 0 : Integer.parseInt( o.toString() );
        } catch (Exception ex) {
            result = 0;
        }
        return result;
    }

    /* toString with null check */
    public static double NullToDouble(Object o) {
        double result = 0;
        try {
            result = o == null ? 0 : Double.parseDouble( o.toString() );
        } catch (Exception ex) {
            result = 0;
        }
        return result;
    }

    /* toString with null check */
    public static long NullToLong(Object o) {
        long result = 0;
        try {
            result = o == null ? 0 : Long.parseLong( o.toString() );
        } catch (Exception ex) {
            result = 0;
        }
        return result;
    }

    /* toString with null check */
    public static String NullToStringZero(Object o) {
        String result = "0";
        try {
            result = o == null ? "0" : o.toString();
        } catch (Exception ex) {
            result = "0";
        }
        return result;
    }

    /* toString with null check */
    public static String NullToString(Object o, String defaultStr) {
        String result = defaultStr;
        try {
            result = o == null ? defaultStr : o.toString();
            result = o.equals("") ? defaultStr : o.toString();
        } catch (Exception ex) {
            result = defaultStr;
        }
        return result;
    }

    public static String ReturnDateFormat(Object date) {
        String returnStr = NullToString(date);
        if (returnStr.length() > 7) {
            returnStr = returnStr.substring(0, 4) + "-" + returnStr.substring(4, 6) + "-" + returnStr.substring(6, 8);
        }
        return returnStr;
    }

    public static String ReturnIntComma(String num) {
        DecimalFormat df = new DecimalFormat("#,###");
        if (num.equals("")) {
            return "";
        } else {
            return df.format(Integer.parseInt(num));
        }
    }

    public static Map<String, Object> CloudParamCheck(Map<String, Object> param) {
        try {
            if (!param.containsKey(commonCode.GROUPSEQ)) {
                param.put(commonCode.GROUPSEQ, CommonGetStr(CommonGetEmpVO().getGroupSeq()));
            } else {
                if (CommonGetStr(param.get(commonCode.GROUPSEQ)).equals("")) {
                    param.put(commonCode.GROUPSEQ, CommonGetStr(CommonGetEmpVO().getGroupSeq()));
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
            param.put(commonCode.GROUPSEQ, "");
        }
        return param;
    }

    public static Map<String, Object> ConToMap(ConnectionVO conVo) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("erpCompName", CommonConvert.CommonGetStr(conVo.getErpCompName()));
        map.put("erpCompSeq", CommonConvert.CommonGetStr(conVo.getErpCompSeq()));
        map.put("erpTypeCode", CommonConvert.CommonGetStr(conVo.getErpTypeCode()));
        map.put("g20YN", CommonConvert.CommonGetStr(conVo.getG20YN()));

        return map;
    }

    public static String GetToday() {
        Calendar day = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
        return df.format(day.getTime());
    }

    public static void Append(StringBuilder sb, String appender) {
        sb.append(appender);
        sb.append(System.getProperty("line.separator"));
    }

}
