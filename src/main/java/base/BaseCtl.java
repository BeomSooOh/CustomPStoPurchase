package base;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import exception.ExceptionCheckAuthorityAdmin;
import exception.ExceptionCheckAuthorityMaster;
import exception.ExceptionCheckAuthorityUser;
import exception.ExceptionNotFoundLoginSession;
import exception.ExceptionType;
import model.common.Mlogin;

public class BaseCtl {

    // logger
    private static Logger logger = LoggerFactory.getLogger(BaseCtl.class);

    // set base controller
    protected ModelAndView SetBaseCtl(HttpServletRequest request) {
        // model and view
        ModelAndView mnv = new ModelAndView();

        // ViewBag map
        Map<String, Object> viewBag = new HashMap<String, Object>();

        // error type
        String errorType = null;

        // login
        Mlogin mLogin = null;
        try {
        	mLogin = new Mlogin();
        } catch (ExceptionNotFoundLoginSession e) {
            // 로그인 정보를 확인할 수 없는 경우
            logger.error(e.getLocalizedMessage());
            viewBag.put("error", e.getLocalizedMessage());
            errorType = ExceptionType.NOT_FOUND_LOGIN_SESSION.toString();
        } catch (Exception e) {
            // 정의되지 않은 오류
            logger.error(e.getLocalizedMessage());
            viewBag.put("error", e.getLocalizedMessage());
            errorType = ExceptionType.EXCEPTION.toString();
        }

        mLogin.setIpAddr(this._GetIp(request));
        mLogin.setReqUrl(this._GetUrl(request));
        viewBag.put("login", mLogin);

        mnv.addObject("ViewBag", viewBag);
        mnv.setViewName(this._GetPathUrl(request, errorType));

        return mnv;
    }

    // get request info - url
    /**
     * <pre>
     * 호출된 url 경로 반환
     * </pre>
     *
     * @param request
     * @return
     */
    private String _GetUrl(HttpServletRequest request) {
    	String url = request.getRequestURI();
        return "";
    }

    // get request info - ip address
    /**
     * <pre>
     * client ip 반환
     * </pre>
     *
     * @param request
     * @return
     */
    private String _GetIp(HttpServletRequest request) {
        String ipAddr = request.getHeader("X-FORWARDED-FOR");

        if (ipAddr == null) {
            ipAddr = request.getRemoteAddr();
        }

        logger.debug("ip address : " + ipAddr);
        return ipAddr;
    }

    // get request info - path url
    /**
     * <pre>
     * 호출된 url 기준으로 반환 path 정의
     * </pre>
     *
     * @param request
     * @param errorType
     * @return
     */
    private String _GetPathUrl(HttpServletRequest request, String errorType) {
        String callUrl = this._GetUrl(request);
        String returnPath = "";

        if (errorType != null) {
            if (ExceptionType.EXCEPTION.toString().equals(errorType)) {
                // 정의되지 않은 오류
                // TODO : Exception url 정의 및 jsp 정의
            } else if (ExceptionType.NOT_CONNECT_ERP.toString().equals(errorType)) {
                // ERP 연결정보 확인 불가 오류
                // TODO : ExceptionNotConnectERP url 정의 및 jsp 정의
            } else if (ExceptionType.NOT_FOUND_LOGIN_SESSION.toString().equals(errorType)) {
                // 로그인 정보 확인 불가 오류
                // TODO : ExceptionNotFoundLoginSession url 정의 및 jsp 정의
            }

            returnPath = "";
        } else {
            try {
                if (this.GetUserAuth().toUpperCase().equals("USER")) {
                    returnPath = this._GetUserPathUrl(callUrl);
                } else if (this.GetUserAuth().toUpperCase().equals("ADMIN")) {
                    returnPath = this._GetAdminPathUrl(callUrl);
                } else if (this.GetUserAuth().toUpperCase().equals("MASTER")) {
                    returnPath = this._GetMasterPathUrl(callUrl);
                }
            } catch (ExceptionCheckAuthorityUser e) {
                // TODO : ExceptionCheckAuthorityUser url 정의 및 jsp 정의
                returnPath = "";
            } catch (ExceptionCheckAuthorityAdmin e) {
                // TODO : ExceptionCheckAuthorityAdmin url 정의 및 jsp 정의
                returnPath = "";
            } catch (ExceptionCheckAuthorityMaster e) {
                // TODO : ExceptionCheckAuthorityMaster url 정의 및 jsp 정의
                returnPath = "";
            } catch (ExceptionNotFoundLoginSession e) {
                // TODO : ExceptionNotFoundLoginSession url 정의 및 jsp 정의
                returnPath = "";
            } catch (Exception e) {
                // TODO : Exception url 정의 및 jsp 정의
                returnPath = "";
            }
        }

        logger.debug("callUrl : " + callUrl + " >>> returnPath : " + returnPath);
        return returnPath;
    }

    /**
     * 사용자 메뉴 path 정의
     *
     * @param callUrl
     * @return
     * @throws ExceptionCheckAuthorityUser
     */
    private String _GetUserPathUrl(String callUrl) throws ExceptionCheckAuthorityUser {
        if (callUrl.equals("")) {
            return "";
        } else {
            throw new ExceptionCheckAuthorityUser();
        }
    }

    /**
     * 관리자 메뉴 path 정의
     *
     * @param callUrl
     * @return
     * @throws ExceptionCheckAuthorityAdmin
     */
    private String _GetAdminPathUrl(String callUrl) throws ExceptionCheckAuthorityAdmin {
        if (callUrl.equals("")) {
            return "";
        } else {
            throw new ExceptionCheckAuthorityAdmin();
        }
    }

    /**
     * 마스터 메뉴 path 정의
     *
     * @param callUrl
     * @return
     * @throws ExceptionCheckAuthorityMaster
     */
    private String _GetMasterPathUrl(String callUrl) throws ExceptionCheckAuthorityMaster {
        if (callUrl.equals("")) {
            return "";
        } else {
            throw new ExceptionCheckAuthorityMaster();
        }
    }

    // get login info - groupSeq
    /**
     * <pre>
     * 로그인 사용자 정보 기준 groupSeq 반환
     * </pre>
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected String GetGroupSeq() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        return mLogin.getGroupSeq();
    }

    /**
     * <pre>
     * 로그인 사용장 정보 기준 compSeq 반환
     * </pre>
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected String GetCompSeq() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        return mLogin.getCompSeq();
    }

    /**
     * <pre>
     * 로그인 사용자 정보 기준 userSe 반환
     * </pre>
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected String GetUserAuth() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        if (mLogin == null) {
            throw new Exception("_login is null");
        }

        if (mLogin.getUserAuth() == null) {
            throw new Exception("_login.getUserAuth() is null");
        }

        if (mLogin.getUserAuth().toUpperCase().equals("")) {
            throw new Exception("_login.getUserAuth() is empty");
        }

        return mLogin.getUserAuth().toUpperCase();
    }

    /**
     * ERPiU 사용 여부
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected boolean GetIsERPiU() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        return mLogin.isERPiU();
    }

    /**
     * iCUBE 사용 여부
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected boolean GetIsiCUBE() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        return mLogin.isiCUBE();
    }

    /**
     * iCUBE G20 사용 여부
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     * @throws Exception
     */
    protected boolean GetIsG20() throws ExceptionNotFoundLoginSession, Exception {
        Mlogin mLogin = null;
        mLogin = new Mlogin();

        return mLogin.isG20();
    }

    protected ModelAndView SetUserInfoToMNV(ModelAndView mv, ConnectionVO con, LoginVO login) throws ExceptionNotFoundLoginSession, Exception {
        Map<String, Object> viewBagLogin = new HashMap<String, Object>();

        viewBagLogin.put(commonCode.ID, login.getId()); /* 로그인 아이디 */
        viewBagLogin.put(commonCode.GROUPSEQ, login.getGroupSeq()); /* 그룹시퀀스 */
        viewBagLogin.put(commonCode.COMPSEQ, login.getCompSeq()); /* 회사시퀀스 */
        viewBagLogin.put(commonCode.BIZSEQ, login.getBizSeq()); /* 사업장시퀀스 */
        viewBagLogin.put(commonCode.DEPTSEQ, login.getOrgnztId()); /* 부서시퀀스 */
        viewBagLogin.put(commonCode.EMPSEQ, login.getUniqId()); /* 사원시퀀스 */
        viewBagLogin.put(commonCode.EMPNAME, login.getName()); /* 사원이름 */
        viewBagLogin.put(commonCode.LANGCODE, login.getLangCode()); /* 사용언어코드 */
        viewBagLogin.put(commonCode.USERSE, login.getUserSe()); /* 사용자접근권한 */
        viewBagLogin.put(commonCode.ERPEMPSEQ, login.getErpEmpCd()); /* ERP사원번호 */
        viewBagLogin.put(commonCode.ERPCOMPSEQ, login.getErpCoCd()); /* ERP회사코드 */
        viewBagLogin.put(commonCode.EATYPE, login.getEaType()); /* 연동 전자결재 구분 */

        viewBagLogin.put("erpTypeCode", con.getErpTypeCode());

        mv.addObject("UserInfo", viewBagLogin);

        return mv;
    }
}
