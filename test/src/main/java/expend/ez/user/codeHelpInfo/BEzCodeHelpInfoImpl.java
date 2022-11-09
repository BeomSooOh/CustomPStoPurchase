package expend.ez.user.codeHelpInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import expend.ez.common.EzCommon;


@Service ( "BEzCodeHelpInfo" )
public class BEzCodeHelpInfoImpl implements BEzCodeHelpInfo{
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	
	@Resource (name = "EzCommon")
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */
	
	
	@Resource (name = "FEzCodeHelpInfoCUBE")
	private FEzCodeHelpInfoCUBE ezCodeCube; /* 이지바로 사용자정보 */
	
	/* 이지바로 코드 판별 및 코드 데이터 가져오기 */
	@Override
	public List<Map<String, Object>> EzDistinguishCodeSelect(Map<String, Object> param) throws Exception {
		//리턴 변수
		List<Map<String,Object>>resultList = new ArrayList<Map<String,Object>>();
		cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					resultList =ezCodeCube.EzDistinguishCodeSelect(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return resultList;
	}

	@Override
	public List<Map<String, Object>> EzETaxListInfo(Map<String, Object> param) throws Exception {
		//리턴 변수
		List<Map<String,Object>>resultList = new ArrayList<Map<String,Object>>();
		cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					resultList =ezCodeCube.EzETaxListInfo(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return resultList;	
	}

	@Override
	public List<Map<String, Object>> EzCommonCodeInfo(Map<String, Object> param) throws Exception {
		//리턴 변수
		List<Map<String,Object>>resultList = new ArrayList<Map<String,Object>>();
		cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					resultList =ezCodeCube.EzCommonCodeInfo(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 공통코드 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return resultList;	
	}

	@Override
	public Map<String, Object> EzCommonCodeUpdate(List<Map<String, Object>> param) throws Exception {
		//리턴 변수
		Map<String,Object>result = new HashMap<String,Object>();
		cmLog.CommonSetInfo("이지바로 회계단위 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					result = ezCodeCube.EzCommonCodeUpdate(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 공통코드 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return result;
	}

	@Override
	public Map<String, Object> EzBankInfoSelect(Map<String, Object> param) throws Exception {
		//리턴 변수
		Map<String,Object>result = new HashMap<String,Object>();
		cmLog.CommonSetInfo("이지바로 지급은행 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					result = ezCodeCube.EzBankInfoSelect(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 지급은행 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return result;
	}

	@Override
	public Map<String, Object> EzEmpBankInfoSelect(Map<String, Object> param) throws Exception {
		//리턴 변수
		Map<String,Object>result = new HashMap<String,Object>();
		cmLog.CommonSetInfo("이지바로 사용자 지급은행 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					result = ezCodeCube.EzEmpBankInfoSelect(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 사용자 지급은행 정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return result;
	}

	@Override
	public Map<String, Object> EzEmpAcctInfoSelect(Map<String, Object> param) throws Exception {
		//리턴 변수
		Map<String,Object>result = new HashMap<String,Object>();
		cmLog.CommonSetInfo("이지바로 사용자 지급은행 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					result = ezCodeCube.EzEmpAcctInfoSelect(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 사용자 계좌정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return result;
	}

	@Override
	public List<Map<String, Object>> EzIncomeGbnSelect(Map<String, Object> param) throws Exception {
		//리턴 변수
		List<Map<String,Object>>resultList = new ArrayList<Map<String,Object>>();
		cmLog.CommonSetInfo("이지바로 사용자 지급은행 정보 가져오기 진입");
		try {
			ConnectionVO conVo = ezCmm.EzCommonGetErpType();
			switch(conVo.getErpTypeCode()){
				case commonCode.ERPIU:
					cmLog.CommonSetInfo("개발예정");
					break;
				case commonCode.ICUBE:
					resultList = ezCodeCube.EzIncomeGbnSelect(param, conVo);
					break;
				default :
					cmLog.CommonSetInfo("이지바로 사용자 계좌정보 가져오기: ERP 연결설정 중 erpCode가 없습니다.");
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}	
		return resultList;
	}


}
