package expend.bi.user.code;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.logger.CommonLogger;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FBiUserCodeServiceADAO" )
public class FBiUserCodeServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
}
