package expend.ex2.admin.auth;

import java.util.ArrayList;
//import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

//import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FEx2AdminAuthServiceIDAO" )
public class FEx2AdminAuthServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	//private SqlSessionFactory sqlSessionFactory;

	/* 증빙유형 코드 조회 */
	public List<Map<String, Object>> setAdminAutoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "ExUserCode.ExCommonCodeAcctSelect", params );
		return result;
	}
}
