package neos.cmm.db;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

//import neos.edoc.eapproval.link.LinkSuit;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

public class DBConnection {
//	public static EgovAbstractDAO  getCommonDAO(HttpServletRequest request, LinkSuit linkSuit) {
	public static EgovAbstractDAO  getCommonDAO(HttpServletRequest request) {
		EgovAbstractDAO commonDAO = null ;
		ServletContext sc = request.getSession().getServletContext();
		ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

//		if(linkSuit == null || linkSuit == LinkSuit.common || linkSuit == LinkSuit.receive ) {
			commonDAO = (CommonSqlDAO)act.getBean("commonSql");
//		}else {
//			commonDAO = (TwoPhaseSqlDAO)act.getBean("twoPhaseSql");
//		}
		return commonDAO ;
	}
	public static EgovAbstractDAO  getCommonDAO(HttpServletRequest request, Map<String, Object>paramMap) {
		@SuppressWarnings("unused")
		Map<String, Object> bParamMap = paramMap;
		/*
		 *db커넥션 가져온다.
		 */
//		LinkSuit linkSuit = (LinkSuit)paramMap.get("linkSuit");
//		return DBConnection.getCommonDAO(request, linkSuit);
		return DBConnection.getCommonDAO(request);

	}

}
