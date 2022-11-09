package expend.bi.user.report;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiUserReportServiceADAO" )
public class FBiUserReportServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
}
