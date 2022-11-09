package expend.ez.user.codeHelpInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ez.common.EzCommon;


@Service ( "FEzCodeHelpInfoCUBE" )
public class FEzCodeHelpInfoCUBEImpl implements FEzCodeHelpInfoCUBE {

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource (name = "EzCommon")
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */
	@Resource ( name = "FEzCodeHelpInfoCUBEDAO" )
	private FEzCodeHelpInfoCUBEDAO IcodeDAO;


	/* 이지바로 코드 판별 및 코드 데이터 가져오기 */
	@Override
	public List<Map<String, Object>> EzDistinguishCodeSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 코드팝업(아이큐브)진입 - EzDistinguishCodeSelect");
		cmLog.CommonSetInfo("[EZ]이지바로 코드팝업(아이큐브)진입 - EzDistinguishCodeSelect, param : "+ param);

		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		String codeType = EgovStringUtil.isNullToString( param.get( "type" ) );
		LoginVO loginVo = ezCmm.EzCommonGetLoginVO();

		try{
			switch (codeType) {
				case "project":
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzPrjoectCodeInfoSelect(param,conVo);
					break;
				case "bmcode":
					resultList = IcodeDAO.EzBMCodeInfoSelect(param,conVo);
					List<Map<String, Object>> resultDataList = new ArrayList<Map<String, Object>>( );
					for ( Map<String, Object> map : (List<Map<String, Object>>) resultList ) {
						switch ( (String) map.get( "BMCODE" ) ) {
//							case "KR072010":
//							case "KR072070":
//							case "KR072020":
//							case "KR072030":
//							case "KR310100":
//							case "KR410100":
//							case "KR620100":
								/* [KR072010] 내부인건비 >> 제외 */
								/* [KR072070] 연구수당 >> 제외 */
								/* [KR072020] 외부인건비 >> 제외 */
								/* [KR072030] 학생인건비 >> 제외 */
							case "":
								break;
							default:
								/* [KR072080] 위탁연구개발비 >> 사용 */
								/* [KR072050] 연구활동비 >> 사용 */
								/* [KR072060] 연구과제추진비 >> 사용 */
								/* [KR072050] 연구활동비 >> 사용 */
								/* [KR072040] 연구장비.재료비 >> 사용 */
								resultDataList.add( map );
								break;
						}
					}
					resultList = resultDataList;
					break;
				case "use" :
					param.put("CDDIV","A01");
					resultList = IcodeDAO.EzUseCodeInfoSelect(param,conVo);
					break;
				case "execmtd":
					param.put( "CDDIV", "A06" );
					resultList = IcodeDAO.EzExecMtdCodeInfoSelect(param,conVo);
					break;
				case "execreqdiv":
					param.put( "CDDIV", "A05" );
					resultList = IcodeDAO.EzExecReqDivCodeInfoSelect(param,conVo);
					break;
				case "inoutaccount":
					param.put( "P_HELP_TY", "STRADE_CODE" );
					param.put( "P_USE_YN", "1" );
					param.put( "P_WHERE", "TR_FG >= \'\'5\'\' AND USE_YN = \'\'1\'\'" );
					resultList = IcodeDAO.EzInOutAccountInfoSelect(param,conVo);
				case "partner" :
					if(param.get("partnergbn").equals("1")){ //거래처등록
						param.put( "P_HELP_TY", "STRADE_CODE" );
						resultList = IcodeDAO.EzPartnerInfoSelect(param,conVo);
					}else if(param.get("partnergbn").equals("2")){//사원등록
						param.put( "P_HELP_TY", "SEMP_CODE" );
						resultList = IcodeDAO.EzPartnerInfoSelect(param,conVo);
					}else if(param.get("partnergbn").equals("4")){//기타소득
						resultList = IcodeDAO.EzETCPartnerInfoSelect(param,conVo);
					}else if(param.get("partnergbn").equals("8")){//급여등록
						param.put( "P_HELP_TY", "SEMP_CODE" );
						resultList = IcodeDAO.EzPartnerInfoSelect(param,conVo);
					}
					break;
				case "researcher":
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzResearcherInfoSelect(param,conVo);
					break;
				case "bank":
					param.put( "CDDIV", "A07" );
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzBankInfoSelect(param,conVo);
					break;
				case "itemgbn":
					param.put( "CDDIV", "A08" );
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzItemGbnInfoSelect(param,conVo);
					break;
				case "belonggbn":
					param.put( "CDDIV", "A16" );
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzBelongGbnInfoSelect(param,conVo);
					break;
				case "inoutgbn":
					param.put( "CDDIV", "A18" );
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzInoutGbnInfoSelect(param,conVo);
					break;
				case "usemethod":
					param.put( "CDDIV", "A17" );
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzUsemethodInfoSelect(param,conVo);
					break;
				case "taxapprno":
					resultList = IcodeDAO.EzTaxApprNoInfoSelect(param,conVo);
					break;
				case "cardnum":
					resultList = IcodeDAO.EzCardNumInfoSelect(param,conVo);
					break;
				case "rate" :
					param.put( "LANGKIND", "KOR" ); /* 사용언어 구분 */
					param.put( "CO_CD", loginVo.getErpCoCd( ) ); /* ERP 회사코드 */
					resultList = IcodeDAO.EzRateInfoSelect(param, conVo);
				default:
					break;
			}
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return resultList;
	}


	@Override
	public List<Map<String, Object>> EzETaxListInfo(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 전자세금계산서 선택항목 가져오기(아이큐브)진입 - EzETaxListInfo");
		cmLog.CommonSetInfo("[EZ]이지바로 전자세금계산서 선택항목 가져오기 - EzETaxListInfo, param : "+ param);
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try{
			resultList = IcodeDAO.EzETaxListInfo(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return resultList;
	}


	@Override
	public List<Map<String, Object>> EzCommonCodeInfo(Map<String, Object> param, ConnectionVO conVo)  throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 공통코드 가져오기(아이큐브)진입 - EzCommonCodeInfo");
		cmLog.CommonSetInfo("[EZ]이지바로 공통코드 가져오기 - EzCommonCodeInfo, param : "+ param);
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try{
			resultList = IcodeDAO.EzCommonCodeInfo(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return resultList;
	}


	@Override
	public Map<String, Object> EzCommonCodeUpdate(List<Map<String, Object>> param, ConnectionVO conVo)throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 공통코드 설정하기(아이큐브)진입 - EzCommonCodeUpdate");
		cmLog.CommonSetInfo("[EZ]이지바로 공통코드 설정하기 - EzCommonCodeUpdate, param : "+ param);
		Map<String,Object>result = new HashMap<String,Object>();
		try{
			for(Map<String,Object> item : param){
				result = IcodeDAO.EzCommonCodeUpdate(item,conVo);
				if(!result.get("result").equals("success")){
					result.put("result", "fail");
					break;
				}
			}
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return result;
	}


	@Override
	public Map<String, Object> EzBankInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 지급은행 가져오기(아이큐브)진입 - EzBankInfoSelect");
		cmLog.CommonSetInfo("[EZ]이지바로 지급은행 가져오기 - EzBankInfoSelect, param : "+ param);
		Map<String,Object>result = new HashMap<String,Object>();
		try{
				result = IcodeDAO.EzReqBankInfoSelect(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return result;
	}


	@Override
	public Map<String, Object> EzEmpBankInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 사용자 지급은행 가져오기(아이큐브)진입 - EzEmpBankInfoSelect");
		cmLog.CommonSetInfo("[EZ]이지바로 사용자 지급은행 가져오기 - EzEmpBankInfoSelect, param : "+ param);
		Map<String,Object>result = new HashMap<String,Object>();
		try{
				result = IcodeDAO.EzEmpReqBankInfoSelect(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return result;
	}


	@Override
	public Map<String, Object> EzEmpAcctInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 사용자 계좌정보 가져오기(아이큐브)진입 - EzEmpAcctInfoSelect");
		cmLog.CommonSetInfo("[EZ]이지바로 사용자 계좌정보 가져오기 - EzEmpAcctInfoSelect, param : "+ param);
		Map<String,Object>result = new HashMap<String,Object>();
		try{
				result = IcodeDAO.EzEmpAcctInfoSelect(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return result;
	}


	@Override
	public List<Map<String, Object>> EzIncomeGbnSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		cmLog.CommonSetInfo("[EZ]이지바로 소득구분 가져오기(아이큐브)진입 - EzCommonCodeInfo");
		cmLog.CommonSetInfo("[EZ]이지바로 소득구분 가져오기 - EzIncomeGbnSelect, param : "+ param);
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try{
			resultList = IcodeDAO.EzIncomeGbnSelect(param,conVo);
		}catch(Exception ex){
			cmLog.CommonSetError(ex);
		}
		return resultList;
	}

}
