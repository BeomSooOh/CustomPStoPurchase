package common.helper.convert;

import common.helper.exception.CheckAuthorityException;
import common.helper.exception.CheckErpTypeException;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;

public class CommonException {

	/**
	 * Login 점검 <br />
	 * - 정상 로그인이 아닌 경우 NotFoundLoginSessionException 발생
	 * 
	 * @throws NotFoundLoginSessionException
	 */
	public static void Login() throws NotFoundLoginSessionException {
		if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("로그인 세션 검색 실패"); }
	}

	public static void AdminAuth() throws CheckAuthorityException, NotFoundLoginSessionException {
		if (!CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpInfo().get(commonCode.USERSE)).equals(commonCode.ADMIN)) { throw new CheckAuthorityException("권한이 맞지 않습니다."); }
	}

	/**
	 * ERP<br />
	 * - ERP 연동여부 확인
	 * 
	 * @param conVo
	 * @throws CheckErpTypeException
	 */
	public static void ERP(ConnectionVO conVo) throws CheckErpTypeException {
		if (!CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU) && !CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) { throw new CheckErpTypeException("ERP 연동 실패"); }
	}

	/**
	 * iCUBEG20<br />
	 * - iCUBE G20 연동여부 확인
	 * 
	 * @param conVo
	 * @throws CheckICUBEG20TypeException
	 */
	public static void iCUBEG20(ConnectionVO conVo) throws CheckICUBEG20TypeException {
		if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE) && CommonConvert.CommonGetStr(conVo.getG20YN()).equals(commonCode.EMPTYNO)) { throw new CheckICUBEG20TypeException("iCUBE G20 설정확인이 필요함."); }
	}
}
