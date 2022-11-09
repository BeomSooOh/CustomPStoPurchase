package egovframework.com.sec.security.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 *
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 8. 29.
 * @version 1.0
 * @see
 *
 *      <pre>
 * 개정이력(Modification Information)
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 29.    서준식        최초생성
 *
 *      </pre>
 */
public class EgovSpringSecurityLoginFilter implements Filter {

	private FilterConfig config;
	protected final static Log LOG = LogFactory.getLog( EgovSpringSecurityLoginFilter.class );

	@Override
    public void destroy ( ) {
		LOG.info(config);
	}

	@Override
    public void doFilter ( ServletRequest request, ServletResponse response, FilterChain chain ) throws IOException, ServletException {
		//
		//		//로그인 URL
		//		String loginURL = config.getInitParameter("loginURL");
		//		loginURL = loginURL.replaceAll("\r", "").replaceAll("\n", ""); // 2011.10.25 보안점검 후속조치
		//
		//		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		//		EgovLoginService loginService = (EgovLoginService) act.getBean("loginService");
		//		EgovMessageSource egovMessageSource = (EgovMessageSource) act.getBean("egovMessageSource");
		//
		//		HttpServletRequest httpRequest = (HttpServletRequest) request;
		//		HttpServletResponse httpResponse = (HttpServletResponse) response;
		//		HttpSession session = httpRequest.getSession();
		//		//String isLocallyAuthenticated = (String)session.getAttribute("isLocallyAuthenticated");
		//		String isRemotelyAuthenticated = null;
		//
        // LoginVO loginVO = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
		//
		//		//		System.out.println("#### loginVO : " + loginVO);
		//
		//		if (session != null) {
		//			isRemotelyAuthenticated = (String) session.getAttribute("isRemotelyAuthenticated");
		//			LoginVO sessionLoginVO = (LoginVO) session.getAttribute("loginVO");
		//
		//			//			System.out.println("#### sessionLoginVO : " + sessionLoginVO);
		//
		//			/**
		//			 * loginVO session 저장하기 actionLogin 통해 로그인을 했더라도 loginVO에는 간략한 정보만 가지고 있음 j_spring_security_check 타야지만 그외정보(compSeq,groupSeq 등) 조회 따라서 loginVO에서 유효성 체크하고 false 일때 인증받은 loginVO로 셋팅한다.
		//			 */
		//			if (sessionLoginVO != null && loginVO != null && !EgovStringUtil.isEmpty(loginVO.getId()) && !EgovStringUtil.isEmpty(loginVO.getUserSe()) && !EgovStringUtil.isEmpty(loginVO.getGroupSeq()) && !EgovStringUtil.isEmpty(loginVO.getCompSeq()) && loginVO != sessionLoginVO) {
		//
		//				System.out.println("######## loginVO reSetting!!!!!  ########");
		//
		//				session.setAttribute("loginVO", loginVO);
		//			}
		//
		//		}
		//
		//		String requestURL = ((HttpServletRequest) request).getRequestURI();
		//		String paramUserID = httpRequest.getParameter("id");
		//		if (requestURL.contains("/uat/uia/actionLogin") && loginVO != null && !EgovStringUtil.isEmpty(paramUserID)) {
		//			if (!loginVO.getId().equals(paramUserID)) {
		//				EgovUserDetailsHelper.reSetAuthenticatedUser();
		//				//session.invalidate();
		//			}
		//		}
		//
		//		//스프링 시큐리티 인증이 처리 되었는지 EgovUserDetailsHelper.getAuthenticatedUser() 메서드를 통해 확인한다.
		//		//context-common.xml 빈 설정에 egovUserDetailsSecurityService를 등록 해서 사용해야 정상적으로 동작한다.
		//		if (EgovUserDetailsHelper.getAuthenticatedUser() == null) {
		//
		//			if (isRemotelyAuthenticated != null && isRemotelyAuthenticated.equals("true")) {
		//				try {
		//					//세션 토큰 정보를 가지고 DB로부터 사용자 정보를 가져옴
		//					loginVO = (LoginVO) session.getAttribute("loginVOForDBAuthentication");
		//					loginVO = loginService.actionLoginByEsntlId(loginVO);
		//
		//					if (loginVO != null && loginVO.getId() != null && !loginVO.getId().equals("")) {
		//						//세션 로그인
		//						session.setAttribute("loginVO", loginVO);
		//
		//						System.out.println("j_spring_security_check");
		//
		//						System.out.println("## loginVO.getGroupSeq() : " + loginVO.getGroupSeq());
		//						//로컬 인증결과 세션에 저장
		//						session.setAttribute("isLocallyAuthenticated", "true");
		//						String uri = httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getGroupSeq() + loginVO.getId() + "&j_password=" + loginVO.getUniqId();
		//						//스프링 시큐리티 로그인
		//						httpResponse.sendRedirect(uri);
		//						return;
		//					}
		//
		//				} catch (Exception ex) {
		//					//DB인증 예외가 발생할 경우 로그를 남기고 로컬인증을 시키지 않고 그대로 진행함.
		//					LOG.debug("Local authentication Fail : " + ex.getMessage());
		//					RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
		//					dispatcher.forward(httpRequest, httpResponse);
		//					chain.doFilter(request, response);
		//					return;
		//				}
		//
		//			} else if (isRemotelyAuthenticated == null) {
		//				if (requestURL.contains("/uat/uia/actionLogin")) {
		//					if (CommonCodeSpecific.getHttpsYN().equals("Y") && request.isSecure() == false) {
		//						httpResponse.sendRedirect(loginURL);
		//						return;
		//					}
		//					String password = httpRequest.getParameter("password");
		//					//2011.10.11 보안점검 후속 조치(Password 검증)
		//					if (password == null || password.equals("") || password.length() < 6 || password.length() > 20) {
		//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login.password"));
		//						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
		//						dispatcher.forward(httpRequest, httpResponse);
		//
		//						chain.doFilter(request, response);
		//						return;
		//					}
		//
		//					loginVO = new LoginVO();
		//
		//					loginVO.setId(httpRequest.getParameter("id"));
		//					loginVO.setPassword(password);
		//
		//					//					if(loginVO.getPassword().equals(NeosConstants.SUPER_PWD)){
		//					////						loginVO.setUserSe("ADMIN");
		//					//			    	}else
		//					loginVO.setUserSe(httpRequest.getParameter("userSe"));
		//					loginVO.setGroupSeq(httpRequest.getSession().getAttribute("loginGroupSeq") + "");
		//
		//					try {
		//
		//						//사용자 입력 id, password로 DB 인증을 실행함
		//						loginVO = loginService.actionLogin(loginVO);
		//
		//						LoginFailInfoVO loginFailInfoVO = (LoginFailInfoVO) loginService.selectLoginFailInfo(paramUserID);
		//
		//						if (loginFailInfoVO == null || loginFailInfoVO.getId() == null || loginFailInfoVO.getId().equals("")) {
		//							loginService.LoginFailInfo(paramUserID);
		//						} else {
		//							//					        loginFailCnt = (String)loginFailInfoVO.getFailCnt();
		//							//				            loginLock = (String)loginFailInfoVO.getLoginLock();
		//							//				            creteDt   = (String)loginFailInfoVO.getCreateDt();
		//							//				            timeGap   = (String)loginFailInfoVO.getTimeGap();
		//						}
		//
		//						if (loginVO != null && loginVO.getId() != null && !loginVO.getId().equals("")) {
		//							//세션 로그인
		//							session.setAttribute("loginVO", loginVO);
		//							//로컬 인증결과 세션에 저장
		//							session.setAttribute("isLocallyAuthenticated", "true");
		//							//							System.out.println("## loginVO.getGroupSeq() : " + loginVO.getGroupSeq());
		//							//							System.out.println("#### j_spring_security_check ### ");
		//
		//							String uri = httpRequest.getContextPath() + "/j_spring_security_check?j_username=" + loginVO.getGroupSeq() + loginVO.getId() + "&j_password=" + loginVO.getUniqId();
		//							//스프링 시큐리티 로그인
		//							httpResponse.sendRedirect(uri);
		//						} else {
		//
		//							//사용자 정보가 없는 경우 로그인 화면으로 redirect 시킴
		//							httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
		//							RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
		//							dispatcher.forward(httpRequest, httpResponse);
		//							chain.doFilter(request, response);
		//							return;
		//						}
		//
		//					} catch (Exception ex) {
		//						//DB인증 예외가 발생할 경우 로그인 화면으로 redirect 시킴
		//						LOG.error("Login Exception : " + ex.getCause());
		//						httpRequest.setAttribute("message", egovMessageSource.getMessage("fail.common.login"));
		//						RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginURL);
		//						dispatcher.forward(httpRequest, httpResponse);
		//						chain.doFilter(request, response);
		//						return;
		//
		//					}
		//					return;
		//				}
		//
		//			}
		//		}
		chain.doFilter( request, response );
		return;
	}

	@Override
    public void init ( FilterConfig filterConfig ) throws ServletException {
		this.config = filterConfig;
	}
}
