package expend.np.admin.etax;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.map.np.ETax;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpAdminETaxServiceIDAO")
public class FNpAdminETaxServiceIDAO extends EgovComAbstractDAO {

	/* Sql Connector */
	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "np";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}

	/* 매입전자세금계산서 목록 조회 */
	public List<Map<String, Object>> GetETaxList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			result = session.selectList(ETax.Map.Admin.LIST, param);
		}
		catch (Exception e) {
			session.rollback();
			session.close();
			throw e;
		}
		finally {
			session.close();
		}
		return result;
	}

	/* 매입전자세금계산서 목록 조회 2차 구현 */
	public List<Map<String, Object>> GetETaxList2(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			result = session.selectList(ETax.Map.Admin.LIST, param);
		}
		catch (Exception e) {
			session.rollback();
			session.close();
			throw e;
		}
		finally {
			session.close();
		}
		return result;
	}
}
