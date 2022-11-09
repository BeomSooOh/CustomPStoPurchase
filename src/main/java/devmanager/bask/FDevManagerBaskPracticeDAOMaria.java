package devmanager.bask;

//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

//import common.helper.convert.CommonConvert;
//import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;



@Repository ( "FDevManagerPracticeDAOMaria" )
public class FDevManagerBaskPracticeDAOMaria extends EgovComAbstractDAO {

	public List<Map<String,Object>> selectBaskMenu(Map<String,Object> params){
		List<Map<String,Object>> result = null;
		try {
			result = list("DevMgrTest.selectMenu", params);
		} catch(Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}