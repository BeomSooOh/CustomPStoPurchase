package common.helper.logger;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "CommonLoggerDAO" )
public class CommonLoggerDAO extends EgovComAbstractDAO {

	public void CommonSetLogToDatabaseInsert ( Map<String, Object> params ) {
		/* INSERT INTO t_expend_log ( `comp_seq`, `module_type`, `log_type`, `message`, `create_date` ) VALUES ( '$compSeq$', '$moduleType$', '$logType$', '$message$', NOW() ) */
		insert( "CommonLoggerDAO.CommonSetLogToDatabaseInsert", params );
	}
}