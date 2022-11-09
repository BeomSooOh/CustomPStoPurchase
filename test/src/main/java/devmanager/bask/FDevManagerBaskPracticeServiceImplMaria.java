package devmanager.bask;

//import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import common.vo.common.CommonInterface.commonCode;
//import neos.cmm.util.code.CommonCodeUtil;
//import neos.cmm.util.code.service.impl.CommonCodeDAO;
//import common.vo.common.ResultVO;


@Service ( "FDevManagerBaskPracticeService" )
public class FDevManagerBaskPracticeServiceImplMaria implements FDevManagerBaskPracticeService {

	@Resource(name = "FDevManagerPracticeDAOMaria")
    private FDevManagerBaskPracticeDAOMaria dao;

	@Override
	public List<Map<String, Object>> selectBaskMenu(Map<String, Object> params) {
		List<Map<String,Object>> result = dao.selectBaskMenu(params);

		return result;
	}
}
