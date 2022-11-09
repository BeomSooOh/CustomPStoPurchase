package expend.ez.user.sendInfo;

import java.util.Map;

import common.vo.common.ConnectionVO;


public interface FEzSendInfoCUBE {
	
	public Map<String,Object> EzHReqInsert(Map<String,Object> params, ConnectionVO conVo)throws Exception;
	
	public Map<String,Object> EzHReqDetailInsert(Map<String,Object> params, ConnectionVO conVo)throws Exception;
	
	
}
