package egovframework.com.sec.security.common;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.sec.security.userdetails.EgovUserDetails;
import egovframework.com.sec.security.userdetails.jdbc.EgovUsersByUsernameMapping;

/**
 * mapRow 결과를 사용자 EgovUserDetails Object 에 정의한다.
 *
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      		수정자          		 수정내용
 *  ----------  -------------   ----------------------
 *  2009.03.10	ByungHun Woo    최초 생성
 *  2009.03.20	이문준				UPDATE
 *  2012.05.23	박기환			 	내용 추가
 *  2016.02.23	진규현				EA_TYPE, emailDomain 추가
 *
 *      </pre>
 */

public class EgovSessionMapping extends EgovUsersByUsernameMapping {

	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 *
	 * @param ds
	 *            DataSource
	 * @param usersByUsernameQuery
	 *            String
	 */
	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery) {
		super(ds, usersByUsernameQuery);
	}

	public EgovSessionMapping(DataSource ds, String usersByUsernameQuery, String companyCD) {
		super(ds, usersByUsernameQuery, companyCD);
	}

	/**
	 * mapRow Override
	 *
	 * @param rs
	 *            ResultSet 결과
	 * @param rownum
	 *            row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
	protected Object mapRow(ResultSet rs, int rownum) throws SQLException {
		logger.debug("## EgovUsersByUsernameMapping mapRow ##");

		String strUserId = rs.getString("user_id");
		String strPassWord = rs.getString("password");
		boolean strEnabled = rs.getBoolean("enabled");
		String strUserNm = rs.getString("user_nm");
		String strUserSe = rs.getString("user_se");
		String strUserEmail = rs.getString("user_email");
		String strOrgnztId = rs.getString("orgnzt_id");
		String strUniqId = rs.getString("esntl_id");
		/** 2010.06.30 *이용 *조직명 추가 */
		String strOrgnztNm = rs.getString("orgnzt_nm");
		/** 2012.05.23 내용추가(박기환 주임연구원) */
		String classCode = rs.getString("CLASS_CODE");
		String classNm = rs.getString("CLASS_NM");
		String positionCode = rs.getString("POSITION_CODE");
		String positionNm = rs.getString("POSITION_NM");
		String organId = rs.getString("ORGAN_ID");
		String organNm = rs.getString("ORGAN_NM");
		String authorCode = rs.getString("AUTHOR_CODE");
		String erpEmpCd = rs.getString("ERP_EMP_CD");
		String erpEmpNm = rs.getString("ERP_EMP_NM");
		String erpCoCd = rs.getString("ERP_CO_CD");
		String emplNo = rs.getString("EMPL_NO");
		String langCode = rs.getString("LANG_CODE");
		String groupSeq = rs.getString("GROUP_SEQ");
		String bizSeq = rs.getString("BIZ_SEQ");
		String compSeq = rs.getString("COMP_SEQ");
		String picFileId = rs.getString("PIC_FILE_ID");
		/** 2016.02.23 내용추가(진규현 선임연구원) 시작 **/
		String emailDomain = rs.getString("email_domain");
		String eaType = rs.getString("ea_type");
		/** 2016.02.23 내용추가(진규현 선임연구원) 끝 **/

		// 세션 항목 설정
		LoginVO loginVO = new LoginVO();
		loginVO.setId(strUserId);
		loginVO.setPassword(strPassWord);
		loginVO.setName(strUserNm);
		loginVO.setUserSe(strUserSe);
		loginVO.setEmail(strUserEmail);
		loginVO.setOrgnztId(strOrgnztId);
		loginVO.setUniqId(strUniqId);
		/** 2010.06.30 *이용 *조직명 추가 */
		loginVO.setOrgnztNm(strOrgnztNm);
		loginVO.setClassCode(classCode);
		loginVO.setClassNm(classNm);
		loginVO.setPositionCode(positionCode);
		loginVO.setPositionNm(positionNm);
		loginVO.setOrganId(organId);
		loginVO.setOrganNm(organNm);
		loginVO.setAuthorCode(authorCode);
		loginVO.setErpEmpCd(erpEmpCd);
		loginVO.setErpEmpNm(erpEmpNm);
		loginVO.setErpCoCd(erpCoCd);
		loginVO.setEmpl_no(emplNo);
		/** 언어 추가 */
		loginVO.setLangCode(langCode);
		loginVO.setGroupSeq(groupSeq);
		loginVO.setBizSeq(bizSeq);
		loginVO.setCompSeq(compSeq);
		loginVO.setPicFileId(picFileId);
		/** 2016.02.23 내용추가(진규현 선임연구원) 시작 **/
		loginVO.setEmailDomain(emailDomain);
		loginVO.setEaType(eaType);
		/** 2016.02.23 내용추가(진규현 선임연구원) 끝 **/

		/*
		 * System.out.println("loginVO.getClassCode():"+loginVO.getClassCode()); System.out.println("loginVO.getClassNm():"+loginVO.getClassNm()); System.out.println("loginVO.getDn():"+loginVO.getDn()); System.out.println("loginVO.getEmail():"+loginVO.getEmail()); System.out.println("loginVO.getId():"+loginVO.getId()); System.out.println("loginVO.getIhidNum():"+loginVO.getIhidNum()); System.out.println("loginVO.getIp():"+loginVO.getIp()); System.out.println("loginVO.getName():"+loginVO.getName()); System.out.println("loginVO.getOrganId():"+loginVO.getOrganId()); System.out.println("loginVO.getOrganNm():"+loginVO.getOrganNm()); System.out.println("loginVO.getOrgnztId():"+loginVO.getOrgnztId()); System.out.println("loginVO.getOrgnztNm()):"+loginVO.getOrgnztNm()); System.out.println("loginVO.getPassword():"+loginVO.getPassword()); System.out.println("loginVO.getPasswordCnsr():"+loginVO.getPasswordCnsr()); System.out.println("loginVO.getPasswordHint():"+loginVO.getPasswordHint());
		 * System.out.println("loginVO.getPositionCode():"+loginVO.getPositionCode()); System.out.println("loginVO.getPositionNm():"+loginVO.getPositionNm()); System.out.println("loginVO.getUniqId():"+loginVO.getUniqId()); System.out.println("loginVO.getUrl():"+loginVO.getUrl()); System.out.println("loginVO.getUserSe():"+loginVO.getUserSe());
		 */

		return new EgovUserDetails(loginVO.getGroupSeq() + strUserId, strPassWord, strEnabled, loginVO);
	}
}
