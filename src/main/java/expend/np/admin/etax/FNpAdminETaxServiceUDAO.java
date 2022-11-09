package expend.np.admin.etax;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
//import common.map.np.ETax;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpAdminETaxServiceUDAO")
public class FNpAdminETaxServiceUDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource(name = "CommonLogger")
	private CommonLogger	cmLog;
	/* 변수정의 - class */
	CommonExConnect			connector	= new CommonExConnect();

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "np";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 관리자 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 목록 조회 ( 사용자 )
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, partnerName, eTaxStat, partnerRegNo, eTaxIssNo, approvalEmpName )
	 * @param conVo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GetETaxList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			Map<String, Object> tpTbTaxCompany = new HashMap<String, Object>();
			tpTbTaxCompany = (Map<String, Object>) session.selectOne("npAdminETaxU.GetETaxListOption", param);
			param.put("tpTbTaxCompany", CommonConvert.CommonGetStr(tpTbTaxCompany.get("tpTbTaxCompany")));
			result = session.selectList("npAdminETaxU.GetETaxList", param);
		}
		catch (Exception ex) {
			StringWriter sw = new StringWriter();
			ex.printStackTrace(new PrintWriter(sw));
			ex.printStackTrace();
			session.rollback();
			session.close();
			throw ex;
		}
		finally {
			session.close();
		}

		return result;
	}
}
