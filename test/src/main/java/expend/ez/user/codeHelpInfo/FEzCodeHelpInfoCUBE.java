package expend.ez.user.codeHelpInfo;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;

public interface FEzCodeHelpInfoCUBE {

	/* 이지바로 코드값 판별 및 데이터 가져오기 */
	public List<Map<String, Object>> EzDistinguishCodeSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 전자세금계산서 선택항목 가져오기 */
	public List<Map<String, Object>> EzETaxListInfo(Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 공통코드 가져오기 */
	public List<Map<String, Object>> EzCommonCodeInfo(Map<String, Object> param, ConnectionVO conVo)  throws Exception;
	
	/* 이지바로 공통코드 설정하기 */
	public Map<String, Object> EzCommonCodeUpdate(List<Map<String, Object>> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 지급은행 가져오기  */
	public Map<String, Object> EzBankInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 사용자 지급은행 가져오기  */
	public Map<String, Object> EzEmpBankInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 사용자 계좌정보 가져오기  */
	public Map<String, Object> EzEmpAcctInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 이지바로 소득구분 가져오기 */
	public List<Map<String, Object>> EzIncomeGbnSelect(Map<String,Object>param, ConnectionVO conVo) throws Exception;
}
