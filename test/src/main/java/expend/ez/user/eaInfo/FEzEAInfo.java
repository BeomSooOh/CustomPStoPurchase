package expend.ez.user.eaInfo;

import java.util.List;
import java.util.Map;

public interface FEzEAInfo {
	/* 이지바로 양식정보 가져오기 */
	public Map<String, Object> EzFormInfoSelect(Map<String, Object> param) throws Exception;

	/* 이지바로 비영리 양식정보 가져오기 */
	public Map<String, Object> EzFormEAInfoSelect(Map<String, Object> param) throws Exception;
	
	
	/*  이지바로 전자결재 인터락 결의내역 정보 가져오기 */
	public Map<String, Object> EzInterlockResolInfoSelect(Map<String, Object> param) throws Exception;
	
	
	/*  이지바로 전자결재 인터락 품목상세 리스트 정보 가져오기 */
	public List<Map<String, Object>> EzInspectInterlockPopDatailList(Map<String, Object> param) throws Exception;
	
	/* 이지바로 전자결재 프라이머리키 가져오기 */
	public List<Map<String, Object>> EzErpPrimaryKeyListSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 마스터 데이터 호출하기 - master 테이블 */
	public Map<String, Object> EzMasterInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 ERP Master 데이터 호출하기 - master 테이블 */
	public List<Map<String, Object>> EzErpMasterInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 ERP Slave 데이터 호출하기 - master 테이블 */
	public List<Map<String, Object>> EzErpSlaveListInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 Gw Master 데이터 호출하기 - master 테이블 */
	public List<Map<String, Object>> EzGwMasterInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 GW Slave 데이터 호출하기 - master 테이블 */
	public List<Map<String, Object>> EzGwSlaveListInfoSelect(Map<String, Object> param) throws Exception;
	
	/* 이자바로 기존 작성한 코드파라메터 데이터 호출하기 - master 테이블 */
	public List<Map<String, Object>> EzCodeParamListInfoSelect(Map<String, Object> param) throws Exception;
	
}
