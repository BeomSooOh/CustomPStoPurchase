package common.procedure.npG20;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("BCommonProcG20DAO")
public class BCommonProcG20DAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource(name = "CommonLogger")
	private CommonLogger cmLog;
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect();
	/* 변수정의 */
	//private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
		String mapPath = "ex";
		if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
			CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
		}
		return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
	}

	/* 공통사용 */
	/* 공통사용 - 파라미터 검증 */
	@SuppressWarnings("unused")
	private class paramChecker {

		public String msg;
		public boolean resultCode;

		paramChecker() {
			this.msg = "";
			this.resultCode = true;
		}
	}

	private paramChecker ParameterCheck(Map<String, Object> params, String[] args) {
		paramChecker c = new paramChecker();
		for (String item : args) {
			if (params.get(item) == null) {
				c.resultCode = false;
				c.msg = "not found parameter parameter " + item;
				return c;
			}
		}
		c.resultCode = true;
		c.msg = "success";
		return c;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectGisuCloseCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "erpGisu", "erpDivSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectGisuCloseCheck", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectSyscFg(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "moduleSeq", "ctrSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectSyscfg", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectEmpList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "subUseYN", "erpEmpSeq", "toDate",
					"erpDivSeq", "erpDeptSeq", "baseDate", "empName" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectEmpList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectGisuList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "gisu" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectGisuList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectBankList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "btrSeq", "btrName" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBankList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectAbsdocuInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectAbsdocuInfo", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectBottomList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] {});
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList;

			if(CommonConvert.NullToString(params.get("groupSeq")).equals("bumin") ) {
				resultList = session.selectList("g20Procedure.selectBottomListBumin", params);
			}
			else {
				resultList = session.selectList("g20Procedure.selectBottomList", params);
			}

			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectBottomList2(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] {});
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBottomList2", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectGisuInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectGisuInfo", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectGisuForDate(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "date" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectGisuForDate", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectBtrList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBtrList", params);
			List<Map<String, Object>> returnList = new ArrayList<>();
			for (Map<String, Object> item : resultList) {
				Map<String, Object> t = new HashMap<>();
				t.put("trSeq", item.get("TR_CD"));
				t.put("atTrName", item.get("ATTR_NM"));
				t.put("REG_NB", item.get("regNumber"));
				t.put("BA_NB", item.get("bankNumber"));
				t.put("CEO_NM", item.get("ceoName"));
				t.put("TR_FG_NM", item.get("trFgName"));
				t.put("TR_FG", item.get("trFg"));
				t.put("JIRO_CD", item.get("jiroSeq"));
				t.put("TR_NM", item.get("trName"));
				t.put("JEONJA_YN", item.get("jeonjaYN"));
				t.put("LIQ_RS", item.get("liqRs"));
				t.put("EMAIL", item.get("eMail"));
			}
			result.setAaData(returnList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectDivList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "baseDate" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectDivList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectTrList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params,
					new String[] { "erpCompSeq", "trType", "trSeq", "trName", "trDetailType" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectTrList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectCommonGisuInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "baseDate" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectCommonGisuInfo", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectProjectList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "erpPjtSeq", "erpPjtName",
					"erpPjtStatus", "erpPjtType", "baseDate", "erpEmpSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectProjectList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectDeptList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "erpEmpSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectDeptList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectBudgetInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			if (params.get("sumAm") == null || String.valueOf(params.get("sumAm")).equals("")) {
				params.put("sumAm", "0");
			}
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params,
					new String[] { "erpCompSeq", "erpDivSeq", "erpMgtSeq", "erpBudgetSeq", "erpGisuDate", "sumAm" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBudgetInfo", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO selectCardSunginList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "cardNumber", "fromDate", "toDate" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectCardSunginList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	public ResultVO selectErpHpmeticList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "baseDate" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectErpHpmeticList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	public ResultVO selectErpHincomeicList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectErpHincomeList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public ResultVO selectBgtList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBgtList", params);

			/* 확장파라미터에 의한 데이터 보정
			 * 품의참조 결의서인 경우 확장파라미터로 2차 필터링 진행
			 * */
			if(params.get( "advParam_erpBudgetSeqs" ) != null){
				List<Map<String, Object>> filterdList = new ArrayList<>( );
				String consBudgetSeq = params.get( "advParam_erpBudgetSeqs" ).toString( );
				for(Map<String, Object> item : resultList){
					if( consBudgetSeq.indexOf( "|" + item.get( "BGT_CD" ).toString( ) + "|" ) > -1){
						filterdList.add( item );
					}
				}
				resultList = filterdList;
			}
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	public ResultVO selectBgtlabelList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectBgtlabelList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	public ResultVO selectIncomeList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			if (params.get("dataCd") == null) {
				params.put("dataCd", "");
			}
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "residence" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectIncomeList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	public Map<String, Object>	selectTrade(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "trName", "trRegNb", "ceoName", "tel", "zip", "addr1", "addr2" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP 조회 진행 */
			result = session.selectOne("g20Procedure.USP_C0MMON_GET_TR_CD_FOR_NOT_EXIST_INSERT", params);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}

		return result;
	}

	public List<Map<String, Object>>	selectTradeInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "trRegNb" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}

			/* ERP 조회 진행 */
			result = session.selectList( "g20Procedure.selectTradeInfo", params );
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}

		return result;
	}

	public ResultVO selectCtrList(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			/* parameter 검증 진행. */
			if (params.get("dataCd") == null) {
				params.put("dataCd", "");
			}
			paramChecker c = ParameterCheck(params, new String[] {  });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* ERP DATA BASE 조회 진행 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectCtrList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail(ex.getMessage(), ex);
		} finally {
			session.close();
		}
		return result;
	}

	/** G20 예실대비 현황 기본리스트 조회
	 * 	[ params ]
	 * 		erpCompSeq, erpGisu, erpDivSeq	, erpMgtSeq	, zeroLineCode, grCode
	 * 		, budgetCnt, divCode, fromBudgetSeq, toBudgetSeq, option12, option13
	 * 		, option14, fromDate, toDate, fromDate, erpEmpSeq, bottomSeq
	 * */
	public ResultVO	selectYesil(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* 예실대비 현황 조회 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectYesilList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail( "예실대비 현황 조회 실패", ex );
		} finally {
			session.close();
		}
		return result;
	}

	/** G20 예실대비 현황 예산별 사용리스트
	 * 	[ params ]
	 * 		erpCompSeq, erpDivSeq, erpMgtSeq, erpBudgetSeq, fromDate, toDate, erpEmpSeq
	 * */
	public ResultVO	selectERPResList(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* 예산별 결의서 조회 */
			if(params.get("erpResGbn") == null) {
				params.put("erpResGbn", "0");
			}
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectERPResList", params);
			result.setAaData(resultList);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail( "예산별 사용리스트 조회", ex );
		} finally {
			session.close();
		}
		return result;
	}

	/** G20 거래처 코드 중복 확인
	 * 	[ params ]
	 * 		erpCompSeq, trSeq
	 * */
	public ResultVO	selectTradeCodeExistsCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* 거래처 코드 중복 확인 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectTradeCodeExistsCheck", params);

			if(resultList.size( ) != 1){
				throw new Exception ("거래처 조회 정보가 단건이 아닙니다." + resultList.size( ));
			}

			Map<String, Object> returnAData = new HashMap<>( );
			Map<String, Object> resultAData = resultList.get( 0 );

			if( CommonConvert.NullToString( resultAData.get( "IS_EXISTS" ) ).equals( "1" ) ){
				/* 코드 중복 */
				String tryTrSeq = CommonConvert.NullToString(  resultAData.get( "TR_CD" ) );
				String ixistsTrName = CommonConvert.NullToString(  resultAData.get( "TR_NM" ) );
				returnAData.put( "chkResult", "N" );
				returnAData.put( "chkResultMessage", "[" + tryTrSeq + "]코드는 사용중인 거래처 코드("+ixistsTrName+")입니다." );
				returnAData.put( "trSeq", tryTrSeq );
			}
			else {
				/* 코드 사용가능 */
				String tryTrSeq = CommonConvert.NullToString(  resultAData.get( "TR_CD" ) );
				returnAData.put( "chkResult", "Y" );
				returnAData.put( "chkResultMessage", "[" + tryTrSeq + "]코드는 신규 추가 가능합니다." );
				returnAData.put( "trSeq", tryTrSeq );
			}
			result.setaData(returnAData);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail( "거래처 코드 중복확인 실패", ex );
		} finally {
			session.close();
		}
		return result;
	}

	/** G20 거래처 코드 자동채번
	 * 	[ params ]
	 * 		erpCompSeq, trSeq
	 * */
	public ResultVO	selectTradeAutoTrSeq(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}
			/* 거래처 코드 중복 확인 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectTradeAutoTrSeq", params);
			if(resultList.size( ) != 1){
				throw new Exception ("거래처 채번 정보가 단건이 아닙니다." + resultList.size( ));
			}

			Map<String, Object> returnAData = new HashMap<>( );
			Map<String, Object> resultAData = resultList.get( 0 );
			String newTrSeq = CommonConvert.NullToString(  resultAData.get( "TR_CD" ) );
			returnAData.put( "trSeq", newTrSeq );
			result.setaData(returnAData);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail( "거래처 코드 자동채번 실패", ex );
		} finally {
			session.close();
		}
		return result;
	}

	/** G20 신규 거래처 등록
	 * 	[ params ]
	 *
	 * */
	public ResultVO	insertTradeInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception{

		ResultVO result = new ResultVO();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}

			/* 거래처 코드 중복 확인 */
			List<Map<String, Object>> resultList = session.selectList("g20Procedure.selectTradeCodeExistsCheck", params);
			if(resultList.size( ) != 1){
				throw new Exception ("거래처 조회 정보가 단건이 아닙니다." + resultList.size( ));
			}
			List<Map<String, Object>> regNbCheckList = session.selectList("g20Procedure.selectTradeRegNbCheck", params);

			Map<String, Object> returnAData = new HashMap<>( );
			Map<String, Object> resultAData = resultList.get( 0 );
			if( CommonConvert.NullToString( resultAData.get( "IS_EXISTS" ) ).equals( "1" ) ){
				/* 코드 중복 */
				String tryTrSeq = CommonConvert.NullToString(  resultAData.get( "TR_CD" ) );
				String ixistsTrName = CommonConvert.NullToString(  resultAData.get( "TR_NM" ) );
				returnAData.put( "saveResult", "N" );
				returnAData.put( "trSeq", tryTrSeq );
				returnAData.put( "chkResultMessage", "[" + tryTrSeq + "]코드는 사용중인 거래처 코드("+ixistsTrName+")입니다." );
			}else if(regNbCheckList.size()>0 && params.get("configNewTradeInsert").equals("0") && params.get("trGbn").equals("1")){
				returnAData.put( "saveResult", "REG" );
				returnAData.put( "chkResultMessage", "동일 사업자번호로 등록된 거래처가 존재합니다. 등록 하시겠습니까?" );
			}else {
				/* 코드 사용가능 */
				List<Map<String, Object>> saveResult = session.selectList("g20Procedure.insertTradeInfo", params);
				returnAData.put( "saveResult", "Y" );
			}
			result.setaData( returnAData );
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail( "거래처 코드 자동채번 실패", ex );
		} finally {
			session.close();
		}
		return result;
	}

	public List<Map<String, Object>> selectCustTradeInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception{
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		connect(conVo);
		SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();

		try {
			paramChecker c = ParameterCheck(params, new String[] { "erpCompSeq", "trRegNb" });
			if (!c.resultCode) {
				throw new Exception(c.msg);
			}

			/* ERP 조회 진행 */
			result = session.selectList( "g20Procedure.selectCustTradeInfo", params );
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}

		return result;
	}
	
}