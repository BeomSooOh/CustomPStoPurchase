package expend.ez.user.sendInfo;

import java.util.Map;

public interface FEzSendInfoGW {
	 
	 /* 이지바로 GW 그룹웨어 마스터 정보 생성하기 */
	 Map<String,Object> EzMasterInfoInsert(Map<String,Object> map) throws Exception;
	 
	 /* 이지바로 GW 그룹웨어 ERP 마스터 정보 생성하기 */
	 Map<String,Object> EzErpMasterInsert(Map<String,Object> map) throws Exception;
	 
	 /* 이지바로 GW 그룹웨어 ERP 슬레이브 정보 생성하기 */
	 Map<String,Object> EzErpSlaveInsert(Map<String,Object> map) throws Exception;
	 
	 /* 이지바로 GW 그룹웨어 파라메터 정보 생성하기 */
	 Map<String,Object> EzGwParamsInsert(Map<String,Object> map) throws Exception;
	 
	 /* 이지바로 GW 그룹웨어 마스터 정보 생성하기 */
	 Map<String,Object> EzGwMasterInsert(Map<String,Object> map) throws Exception;
	 
	 /* 이지바로 GW 그룹웨어 슬레이브 정보 생성하기 */
	 Map<String,Object> EzGwSlaveInsert(Map<String,Object> map) throws Exception;
	 
	 
}
