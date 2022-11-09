package expend.ex2.admin.code;

import java.util.Map;

import common.vo.common.ResultVO;

public interface BEx2AdminCodeService {
	
	/* Biz - 공통코드 - 공통코드 조회 */
	ResultVO Ex2CommonCodeInfoSelect(Map<String, Object> params) throws Exception;
}
