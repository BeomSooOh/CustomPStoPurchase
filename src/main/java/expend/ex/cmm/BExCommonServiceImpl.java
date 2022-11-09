package expend.ex.cmm;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;


@Service ( "BExCommonService" )
public class BExCommonServiceImpl implements BExCommonService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	@Resource ( name = "FExCommonServiceADAO" )
	private FExCommonServiceADAO exCommonServiceADAO;

	// 공통코드 조회
	@Override
	public Map<String, Object> CommonCodeSelect(Map<String, Object> params) throws Exception {
		return exCommonServiceADAO.CommonCodeSelect(params);
	}

	// 그룹웨어 URL 조회
	@Override
	public String GroupwareUrlSelect(String groupSeq) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("groupSeq", groupSeq);
		Map<String, Object> gwInfo = exCommonServiceADAO.GroupInfoSelect(params);
		if (gwInfo.containsKey("gwUrl")) {
			return gwInfo.get("gwUrl").toString();
		} else {
			return commonCode.EMPTYSTR;
		}
	}
}
