package neos.cmm.system.member.vo;

import java.io.Serializable;

/**
 * 
 * @title 사용자 관리 Vo
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 6. 4.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 6. 4.  박기환        최초 생성
 *
 */
@SuppressWarnings("serial")
public class MemberInfo implements Serializable {		
		
	/**
	* 사용자키코드
	*/
	private String esntlId = "";
	
	/**
	* 사용자ID
	*/
	private String emplyrId = "";
	
	/**
	* 부서ID
	*/
	private String orgnztId = "";	
	
	/**
	 * 변경 부서 ID
	 */
	private String orgnztIdNew = "";
	
	/**
	 * 부서명
	 */
	private String orgnztNm = "";
	
	/**
	* 사용자명
	*/
	private String userNm = "";
	
	/**
	* 비밀번호
	*/
	private String password = "";
	
	/**
	* 사원번호
	*/
	private String emplNo = "";
	
	/**
	* 주민등록번호
	*/
	private String ihidnum = "";
	
	/**
	* 성별코드
	*/
	private String sexdstnCode = "";
	
	/**
	* 생일
	*/
	private String brthdy = "";
	
	/**
	* 팩스번호
	*/
	private String fxnum = "";
	
	/**
	* 주택주소
	*/
	private String houseAdres = "";
	
	/**
	* 비밀번호힌트
	*/
	private String passwordHint = "";
		
	/**
	* 비밀번호정답
	*/
	private String passwordCnsr = "";
	
	/**
	* 전화번호 국번
	*/
	private String houseEndTelno = "";    
	
	/**
	* 지역번호
	*/
	private String areaNo = "";
	
	/**
	* 상세주소
	*/
	private String detailAdres = "";
	
	/**
	* 우편번호
	*/
	private String zip = "";
	
	/**
	* 사무실전화번호
	*/
	private String offmTelno = "";
	
	/**
	* 이동전화번호
	*/
	private String mbtlnum = "";
	
	/**
	* 이메일주소
	*/
	private String emailAdres = "";		
	
	/**
	* 주택중간전화번호
	*/
	private String houseMiddleTelno = "";
	
	/**
	* 그룹ID
	*/
	private String groupId = "";
	
	/**
	* 소속기관코드
	*/
	private String pstinstCode = "";
	
	/**
	* 사용자상태코드
	* 재직구분(공통코드:COM081)
	*/
	private String emplyrSttusCode = "";
	
	private String emplyrSttusNm = "";
	
	/**
	* 인증DN값
	*/
	private String crtfcDnValue = "";
	
	/**
	* 입사일자
	*/
	private String sbscrbDe = "";
	
	/**
	* 직급코드(공통코드:COM152)
	*/
	private String classCode = "";
	
	/**
	* 직급명
	*/
	private String classNm = "";
	
	/**
	* 직위코드(공통코드:COM077)
	*/
	private String positionCode = "";
	
	/**
	* 직위명
	*/
	private String positionNm = "";
	
	/**
	 * 사용자 사진 ID
	 */
	private String picId = "";
	
	/**
	 * 싸인 ID
	 */
	private String signId = "";
	
	/**
	 * 기관 ID
	 */
	private String organId = "";
	
	/**
	 * 기관 이름
	 */
	private String organNm = "";
	
	/**
	 * 주부서, 부부서 구분 이름
	 */
	private String subpositionNm = "";
	
	/**
	 * 겸직여부, 주부구분
	 */
	private String subpositionFlag = "";
	
	/**
	 * 사무실 주소
	 */
	private String offmAdres = "";
	
	/**
	 * 사무실 상세 주소
	 */
	private String offmDetailAdres = "";

	/**
	 * 사무실 우편번호
	 */
	private String offmZip = "";	
	
	/**
	 * 퇴직날짜
	 */
	private String resignDe = "";	
	
	/**
	 * 신규 구분
	 */
	private String newInfo = "";
	
	/**
	 * 메신저 seq
	 */
	private int seq = 0;
	
	/**
	 * ERP 사번
	 */
	private String erpEmpCd = "";
	
	/**
	 * ERP 사용자
	 */
	private String erpEmpNm = "";
	
	/** 사용자정렬순서 **/
	private String emplyrOrdr = "";

	/** 담당업무 **/
    private String business = "";

	/** 팀ID **/
    private String teamId = "";
    private String teamNm = ""; 
    
	/** 호출 구분 **/
    private String callYn = "";      
    
    private String payPwd = "" ;
    
	public String getPayPwd() {
		return payPwd;
	}

	public void setPayPwd(String payPwd) {
		this.payPwd = payPwd;
	}

	/**
	 * esntlId attribute 값을 리턴한다.
	 * @return esntlId
	 */
	public String getEsntlId() {
		return esntlId;
	}

	/**
	 * esntlId attribute 값을 설정한다.
	 * @param esntlId String
	 */
	public void setEsntlId(String esntlId) {
		this.esntlId = esntlId;
	}

	/**
	 * emplyrId attribute 값을 리턴한다.
	 * @return emplyrId
	 */
	public String getEmplyrId() {
		return emplyrId;
	}

	/**
	 * emplyrId attribute 값을 설정한다.
	 * @param emplyrId String
	 */
	public void setEmplyrId(String emplyrId) {
		this.emplyrId = emplyrId;
	}

	/**
	 * orgnztId attribute 값을 리턴한다.
	 * @return orgnztId
	 */
	public String getOrgnztId() {
		return orgnztId;
	}

	/**
	 * orgnztId attribute 값을 설정한다.
	 * @param orgnztId String
	 */
	public void setOrgnztId(String orgnztId) {
		this.orgnztId = orgnztId;
	}

	/**
	 * orgnztIdNew attribute 값을 리턴한다.
	 * @return orgnztIdNew
	 */
	public String getOrgnztIdNew() {
		return orgnztIdNew;
	}

	/**
	 * orgnztIdNew attribute 값을 설정한다.
	 * @param orgnztIdNew String
	 */
	public void setOrgnztIdNew(String orgnztIdNew) {
		this.orgnztIdNew = orgnztIdNew;
	}

	/**
	 * orgnztNm attribute 값을 리턴한다.
	 * @return orgnztNm
	 */
	public String getOrgnztNm() {
		return orgnztNm;
	}

	/**
	 * orgnztNm attribute 값을 설정한다.
	 * @param orgnztNm String
	 */
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}

	/**
	 * userNm attribute 값을 리턴한다.
	 * @return userNm
	 */
	public String getUserNm() {
		return userNm;
	}

	/**
	 * userNm attribute 값을 설정한다.
	 * @param userNm String
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	/**
	 * password attribute 값을 리턴한다.
	 * @return password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * password attribute 값을 설정한다.
	 * @param password String
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * emplNo attribute 값을 리턴한다.
	 * @return emplNo
	 */
	public String getEmplNo() {
		return emplNo;
	}

	/**
	 * emplNo attribute 값을 설정한다.
	 * @param emplNo String
	 */
	public void setEmplNo(String emplNo) {
		this.emplNo = emplNo;
	}

	/**
	 * ihidnum attribute 값을 리턴한다.
	 * @return ihidnum
	 */
	public String getIhidnum() {
		return ihidnum;
	}

	/**
	 * ihidnum attribute 값을 설정한다.
	 * @param ihidnum String
	 */
	public void setIhidnum(String ihidnum) {
		this.ihidnum = ihidnum;
	}

	/**
	 * sexdstnCode attribute 값을 리턴한다.
	 * @return sexdstnCode
	 */
	public String getSexdstnCode() {
		return sexdstnCode;
	}

	/**
	 * sexdstnCode attribute 값을 설정한다.
	 * @param sexdstnCode String
	 */
	public void setSexdstnCode(String sexdstnCode) {
		this.sexdstnCode = sexdstnCode;
	}

	/**
	 * brthdy attribute 값을 리턴한다.
	 * @return brthdy
	 */
	public String getBrthdy() {
		return brthdy;
	}

	/**
	 * brthdy attribute 값을 설정한다.
	 * @param brthdy String
	 */
	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}

	/**
	 * fxnum attribute 값을 리턴한다.
	 * @return fxnum
	 */
	public String getFxnum() {
		return fxnum;
	}

	/**
	 * fxnum attribute 값을 설정한다.
	 * @param fxnum String
	 */
	public void setFxnum(String fxnum) {
		this.fxnum = fxnum;
	}

	/**
	 * houseAdres attribute 값을 리턴한다.
	 * @return houseAdres
	 */
	public String getHouseAdres() {
		return houseAdres;
	}

	/**
	 * houseAdres attribute 값을 설정한다.
	 * @param houseAdres String
	 */
	public void setHouseAdres(String houseAdres) {
		this.houseAdres = houseAdres;
	}

	/**
	 * passwordHint attribute 값을 리턴한다.
	 * @return passwordHint
	 */
	public String getPasswordHint() {
		return passwordHint;
	}

	/**
	 * passwordHint attribute 값을 설정한다.
	 * @param passwordHint String
	 */
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}

	/**
	 * passwordCnsr attribute 값을 리턴한다.
	 * @return passwordCnsr
	 */
	public String getPasswordCnsr() {
		return passwordCnsr;
	}

	/**
	 * passwordCnsr attribute 값을 설정한다.
	 * @param passwordCnsr String
	 */
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}

	/**
	 * houseEndTelno attribute 값을 리턴한다.
	 * @return houseEndTelno
	 */
	public String getHouseEndTelno() {
		return houseEndTelno;
	}

	/**
	 * houseEndTelno attribute 값을 설정한다.
	 * @param houseEndTelno String
	 */
	public void setHouseEndTelno(String houseEndTelno) {
		this.houseEndTelno = houseEndTelno;
	}

	/**
	 * areaNo attribute 값을 리턴한다.
	 * @return areaNo
	 */
	public String getAreaNo() {
		return areaNo;
	}

	/**
	 * areaNo attribute 값을 설정한다.
	 * @param areaNo String
	 */
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}

	/**
	 * detailAdres attribute 값을 리턴한다.
	 * @return detailAdres
	 */
	public String getDetailAdres() {
		return detailAdres;
	}

	/**
	 * detailAdres attribute 값을 설정한다.
	 * @param detailAdres String
	 */
	public void setDetailAdres(String detailAdres) {
		this.detailAdres = detailAdres;
	}
	
	/**
	 * zip attribute 값을 리턴한다.
	 * @return zip
	 */
	public String getZip() {
		return zip;
	}

	/**
	 * zip attribute 값을 설정한다.
	 * @param zip String
	 */
	public void setZip(String zip) {
		this.zip = zip;
	}

	/**
	 * offmTelno attribute 값을 리턴한다.
	 * @return offmTelno
	 */
	public String getOffmTelno() {
		return offmTelno;
	}

	/**
	 * offmTelno attribute 값을 설정한다.
	 * @param offmTelno String
	 */
	public void setOffmTelno(String offmTelno) {
		this.offmTelno = offmTelno;
	}

	/**
	 * mbtlnum attribute 값을 리턴한다.
	 * @return mbtlnum
	 */
	public String getMbtlnum() {
		return mbtlnum;
	}

	/**
	 * mbtlnum attribute 값을 설정한다.
	 * @param mbtlnum String
	 */
	public void setMbtlnum(String mbtlnum) {
		this.mbtlnum = mbtlnum;
	}

	/**
	 * emailAdres attribute 값을 리턴한다.
	 * @return emailAdres
	 */
	public String getEmailAdres() {
		return emailAdres;
	}

	/**
	 * emailAdres attribute 값을 설정한다.
	 * @param emailAdres String
	 */
	public void setEmailAdres(String emailAdres) {
		this.emailAdres = emailAdres;
	}

	/**
	 * houseMiddleTelno attribute 값을 리턴한다.
	 * @return houseMiddleTelno
	 */
	public String getHouseMiddleTelno() {
		return houseMiddleTelno;
	}

	/**
	 * houseMiddleTelno attribute 값을 설정한다.
	 * @param houseMiddleTelno String
	 */
	public void setHouseMiddleTelno(String houseMiddleTelno) {
		this.houseMiddleTelno = houseMiddleTelno;
	}

	/**
	 * groupId attribute 값을 리턴한다.
	 * @return groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * groupId attribute 값을 설정한다.
	 * @param groupId String
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * pstinstCode attribute 값을 리턴한다.
	 * @return pstinstCode
	 */
	public String getPstinstCode() {
		return pstinstCode;
	}

	/**
	 * pstinstCode attribute 값을 설정한다.
	 * @param pstinstCode String
	 */
	public void setPstinstCode(String pstinstCode) {
		this.pstinstCode = pstinstCode;
	}

	/**
	 * emplyrSttusCode attribute 값을 리턴한다.
	 * @return emplyrSttusCode
	 */
	public String getEmplyrSttusCode() {
		return emplyrSttusCode;
	}

	/**
	 * emplyrSttusCode attribute 값을 설정한다.
	 * @param emplyrSttusCode String
	 */
	public void setEmplyrSttusCode(String emplyrSttusCode) {
		this.emplyrSttusCode = emplyrSttusCode;
	}

	/**
	 * crtfcDnValue attribute 값을 리턴한다.
	 * @return crtfcDnValue
	 */
	public String getCrtfcDnValue() {
		return crtfcDnValue;
	}

	/**
	 * crtfcDnValue attribute 값을 설정한다.
	 * @param crtfcDnValue String
	 */
	public void setCrtfcDnValue(String crtfcDnValue) {
		this.crtfcDnValue = crtfcDnValue;
	}

	/**
	 * sbscrbDe attribute 값을 리턴한다.
	 * @return sbscrbDe
	 */
	public String getSbscrbDe() {
		return sbscrbDe;
	}

	/**
	 * sbscrbDe attribute 값을 설정한다.
	 * @param sbscrbDe String
	 */
	public void setSbscrbDe(String sbscrbDe) {
		this.sbscrbDe = sbscrbDe;
	}

	/**
	 * classCode attribute 값을 리턴한다.
	 * @return classCode
	 */
	public String getClassCode() {
		return classCode;
	}

	/**
	 * classCode attribute 값을 설정한다.
	 * @param classCode String
	 */
	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}

	/**
	 * classNm attribute 값을 리턴한다.
	 * @return classNm
	 */
	public String getClassNm() {
		return classNm;
	}

	/**
	 * classNm attribute 값을 설정한다.
	 * @param classNm String
	 */
	public void setClassNm(String classNm) {
		this.classNm = classNm;
	}

	/**
	 * positionCode attribute 값을 리턴한다.
	 * @return positionCode
	 */
	public String getPositionCode() {
		return positionCode;
	}

	/**
	 * positionCode attribute 값을 설정한다.
	 * @param positionCode String
	 */
	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	/**
	 * positionNm attribute 값을 리턴한다.
	 * @return positionNm
	 */
	public String getPositionNm() {
		return positionNm;
	}

	/**
	 * positionNm attribute 값을 설정한다.
	 * @param positionNm String
	 */
	public void setPositionNm(String positionNm) {
		this.positionNm = positionNm;
	}

	/**
	 * picId attribute 값을 리턴한다.
	 * @return picId
	 */
	public String getPicId() {
		return picId;
	}

	/**
	 * picId attribute 값을 설정한다.
	 * @param picId String
	 */
	public void setPicId(String picId) {
		this.picId = picId;
	}

	/**
	 * signId attribute 값을 리턴한다.
	 * @return signId
	 */
	public String getSignId() {
		return signId;
	}

	/**
	 * signId attribute 값을 설정한다.
	 * @param signId String
	 */
	public void setSignId(String signId) {
		this.signId = signId;
	}

	/**
	 * organId attribute 값을 리턴한다.
	 * @return organId
	 */
	public String getOrganId() {
		return organId;
	}

	/**
	 * organId attribute 값을 설정한다.
	 * @param organId String
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * organNm attribute 값을 리턴한다.
	 * @return organNm
	 */
	public String getOrganNm() {
		return organNm;
	}

	/**
	 * organNm attribute 값을 설정한다.
	 * @param organNm String
	 */
	public void setOrganNm(String organNm) {
		this.organNm = organNm;
	}

	/**
	 * subpositionNm attribute 값을 리턴한다.
	 * @return subpositionNm
	 */
	public String getSubpositionNm() {
		return subpositionNm;
	}

	/**
	 * subpositionNm attribute 값을 설정한다.
	 * @param subpositionNm String
	 */
	public void setSubpositionNm(String subpositionNm) {
		this.subpositionNm = subpositionNm;
	}

	/**
	 * subpositionFlag attribute 값을 리턴한다.
	 * @return subpositionFlag
	 */
	public String getSubpositionFlag() {
		return subpositionFlag;
	}

	/**
	 * subpositionFlag attribute 값을 설정한다.
	 * @param subpositionFlag String
	 */
	public void setSubpositionFlag(String subpositionFlag) {
		this.subpositionFlag = subpositionFlag;
	}

	/**
	 * offmAdres attribute 값을 리턴한다.
	 * @return offmAdres
	 */
	public String getOffmAdres() {
		return offmAdres;
	}

	/**
	 * offmAdres attribute 값을 설정한다.
	 * @param offmAdres String
	 */
	public void setOffmAdres(String offmAdres) {
		this.offmAdres = offmAdres;
	}

	/**
	 * detailAdres attribute 값을 리턴한다.
	 * @return detailAdres
	 */
	public String getOffmDetailAdres() {
		return offmDetailAdres;
	}

	/**
	 * detailAdres attribute 값을 설정한다.
	 * @param detailAdres String
	 */
	public void setOffmDetailAdres(String offmDetailAdres) {
		this.offmDetailAdres = offmDetailAdres;
	}
	
	/**
	 * offmZip attribute 값을 리턴한다.
	 * @return offmZip
	 */
	public String getOffmZip() {
		return offmZip;
	}

	/**
	 * offmZip attribute 값을 설정한다.
	 * @param offmZip String
	 */
	public void setOffmZip(String offmZip) {
		this.offmZip = offmZip;
	}

	/**
	 * resignDe attribute 값을 리턴한다.
	 * @return resignDe
	 */
	public String getResignDe() {
		return resignDe;
	}

	/**
	 * resignDe attribute 값을 설정한다.
	 * @param resignDe String
	 */
	public void setResignDe(String resignDe) {
		this.resignDe = resignDe;
	}

	/**
	 * newInfo attribute 값을 리턴한다.
	 * @return newInfo
	 */
	public String getNewInfo() {
		return newInfo;
	}

	/**
	 * newInfo attribute 값을 설정한다.
	 * @param newInfo String
	 */
	public void setNewInfo(String newInfo) {
		this.newInfo = newInfo;
	}

	/**
	 * seq attribute 값을 리턴한다.
	 * @return seq
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * seq attribute 값을 설정한다.
	 * @param seq int
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * erpEmpCd attribute 값을 리턴한다.
	 * @return erpEmpCd
	 */
	public String getErpEmpCd() {
		return erpEmpCd;
	}

	/**
	 * erpEmpCd attribute 값을 설정한다.
	 * @param erpEmpCd String
	 */
	public void setErpEmpCd(String erpEmpCd) {
		this.erpEmpCd = erpEmpCd;
	}

	/**
	 * erpEmpNm attribute 값을 리턴한다.
	 * @return erpEmpNm
	 */
	public String getErpEmpNm() {
		return erpEmpNm;
	}

	/**
	 * erpEmpNm attribute 값을 설정한다.
	 * @param erpEmpNm String
	 */
	public void setErpEmpNm(String erpEmpNm) {
		this.erpEmpNm = erpEmpNm;
	}

    public String getEmplyrOrdr() {
        return emplyrOrdr;
    }

    public void setEmplyrOrdr(String emplyrOrdr) {
        this.emplyrOrdr = emplyrOrdr;
    }

    public String getBusiness() {
        return business;
    }

    public void setBusiness(String business) {
        this.business = business;
    }

	/**
	 * team id
	 */
	public String getTeamId() {
		return teamId;
	}

	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}	

	public String getTeamNm() {
		return teamNm;
	}

	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}	
	
	/**
	 * call yn
	 */
	public String getCallYn() {
		return callYn;
	}

	public void setCallYn(String callYn) {
		this.callYn = callYn;
	}

    public String getEmplyrSttusNm() {
        return emplyrSttusNm;
    }

    public void setEmplyrSttusNm(String emplyrSttusNm) {
        this.emplyrSttusNm = emplyrSttusNm;
    }
	
	
}
