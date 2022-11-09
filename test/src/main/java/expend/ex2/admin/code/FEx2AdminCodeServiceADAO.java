package expend.ex2.admin.code;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
//import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository ( "FEx2AdminCodeServiceADAO" )
public class FEx2AdminCodeServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;

	@SuppressWarnings ( "unchecked" )
	//public List<Map<String, Object>> Ex2CommonCodeSummarySelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	public List<Map<String, Object>> Ex2CommonCodeSummarySelect ( Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		cmLog.CommonSetInfo( "+ [EX] FEx2AdminCodeServiceADAO - Ex2CommonCodeSummarySelect" );
		cmLog.CommonSetInfo( "! [EX] params >> " + params );
		List<Map<String, Object>> result = this.list( "Ex2CommonCodeSummarySelect", params );
		return result;
	}
}
