package expend.np.user.etax;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.map.np.ETax;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpUserETaxServiceIDAO")
public class FNpUserETaxServiceIDAO extends EgovComAbstractDAO {

	@Resource(name = "CommonLogger")
	private final CommonLogger			cmLog	= new CommonLogger();

	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "np";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}

	/* iCUBE 세금계산서 데이터 조회 */
	public List<Map<String, Object>> selectETaxList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			result = session.selectList("selectETaxList", params);
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

	// /* 변수정의 - Common */
	// @Resource(name = "CommonLogger")
	// private CommonLogger cmLog;
	// /* 변수정의 - class */
	// CommonExConnect connector = new CommonExConnect();
	// /* 변수정의 */
	// private SqlSessionFactory sqlSessionFactory;
	//
	// /* 공통사용 */
	// /* 공통사용 - 커넥션 */
	// private boolean connect(ConnectionVO conVo) throws Exception {
	// boolean result = false;
	// try {
	// // 환경 설정 파일의 경로를 문자열로 저장 / String resource =
	// // "sample/mybatis/sql/mybatis-config.xml";
	// String resource = "egovframework/sqlmap/config/" +
	// conVo.getDatabaseType()
	// + "/ERPiU/np/sql-map-mybatis-ERPiU-config.xml";
	// Properties props = new Properties();
	// props.put("databaseType", conVo.getDatabaseType());
	// props.put("driver", conVo.getDriver());
	// props.put("url", conVo.getUrl());
	// props.put("username", conVo.getUserId());
	// props.put("password", conVo.getPassword());
	// props.put("erpTypeCode", conVo.getErpTypeCode());
	// // 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
	// Reader reader = Resources.getResourceAsReader(resource);
	// // reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory =
	// // new SqlSessionFactoryBuilder().build(reader, props);
	// if (sqlSessionFactory == null) {
	// sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
	// } else {
	// sqlSessionFactory = null;
	// sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
	// }
	// result = true;
	// } catch (Exception e) {
	// cmLog.CommonSetError(e);
	// throw e;
	// }
	// return result;
	// }
	//
	// /* 테스트 DAO */
	// @SuppressWarnings("unchecked")
	// public List<Map<String, Object>> npTest(Map<String, Object> params,
	// ConnectionVO conVo) throws Exception {
	// List<Map<String, Object>> result = new ArrayList<>();
	// connect(conVo);
	// SqlSession session = sqlSessionFactory.openSession();
	// try {
	// session.selectList("npUserCodeU.TestCode", params);
	// result = (List<Map<String, Object>>) params.get("result");
	// } catch (Exception ex) {
	// cmLog.CommonSetError(ex);
	// throw ex;
	// } finally {
	// session.close();
	// }
	// return result;
	// }
	//
	// /* iCUBE 세금계산서 데이터 조회 */
	// public List<Map<String, Object>> selectETaxList(Map<String, Object>
	// params, ConnectionVO conVo) throws Exception {
	// List<Map<String, Object>> result = new ArrayList<>();
	// connect(conVo);
	// SqlSession session = sqlSessionFactory.openSession();
	// try {
	// result = session.selectList("selectETaxList", params);
	// } catch (Exception ex) {
	// cmLog.CommonSetError(ex);
	// throw ex;
	// } finally {
	// session.close();
	// }
	// return result;
	// }
	//
	// /* ## iCUBE 매입전자세금계산서 연동 처리 ## */
	// /* ## iCUBE 매입전자세금계산서 연동 처리 - 보관, 상신 ## */
	// public int updateETaxStatApproval(Map<String, Object> params,
	// ConnectionVO conVo) throws Exception {
	// /* ETAXUP.GET_FG : 1 */
	// /* ETAXUP.APPRO_STATE : 0 */
	//
	// connect(conVo);
	// SqlSession session = sqlSessionFactory.openSession();
	// return session.update("npUserETaxU.updateETaxStatApproval", params);
	// }
	//
	// /* ## iCUBE 매입전자세금계산서 연동 처리 - 반려, 삭제 ## */
	// public int updateETaxStatReturn(Map<String, Object> params, ConnectionVO
	// conVo) throws Exception {
	// /* ETAXUP.GET_FG : 0 */
	// /* ETAXUP.APPRO_STATE : 4 */
	//
	// connect(conVo);
	// SqlSession session = sqlSessionFactory.openSession();
	// return session.update("npUserETaxU.updateETaxStatReturn", params);
	// }
	//
	// /* ## iCUBE 매입전자세금계산서 연동 처리 - 종결 ## */
	// public int updateETaxStatEnd(Map<String, Object> params, ConnectionVO
	// conVo) throws Exception {
	// /* ETAXUP.GET_FG : 1 */
	// /* ETAXUP.APPRO_STATE : 1 */
	//
	// connect(conVo);
	// SqlSession session = sqlSessionFactory.openSession();
	// return session.update("npUserETaxU.updateETaxStatEnd", params);
	// }

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
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
	public List<Map<String, Object>> GetETaxList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			// result = session.selectList(ETax.Map.User.List, param);
			result = session.selectList(ETax.Map.User.LIST2, param);
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

	public List<Map<String, Object>> GetETaxApprovalList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			result = session.selectList(ETax.Map.User.APPROVALLIST, param);
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