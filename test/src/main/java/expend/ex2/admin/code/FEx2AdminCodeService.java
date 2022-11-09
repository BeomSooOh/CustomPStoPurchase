package expend.ex2.admin.code;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;

public interface FEx2AdminCodeService {
	
	/* 공통코드 조회 */
	List<Map<String, Object>> Ex2AdminCommCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception;
}
