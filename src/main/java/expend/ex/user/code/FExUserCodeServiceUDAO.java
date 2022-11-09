package expend.ex.user.code;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMap;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ResultMap;
import org.apache.ibatis.mapping.ResultMapping;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.scripting.defaults.RawSqlSource;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;
import com.ibatis.common.resources.Resources;
import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExCodeAcctVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository("FExUserCodeServiceUDAO")
public class FExUserCodeServiceUDAO extends EgovComAbstractDAO {

    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();
    /* 변수정의 */
    private SqlSessionFactory sqlSessionFactory;

    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
    public List<Map<String, Object>> ExUserEmpListInfoSelect(Map<String, Object> params, common.vo.common.ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = connector.List(conVo, "FExUserCodeServiceUDAO.ExUserEmpListInfoSelect", params);
        return result;
    }

    /* 공통사용 - 커넥션 */
    private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
        String mapPath = "ex";
        if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
            SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
            CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
        }
        return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
    }

    /* 공통사용 - 커넥션 */
    private boolean DynamicCommonConnection(ConnectionVO conVo) throws Exception {
        boolean result = false;
        try {
            // 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
            String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType() + "/iCUBE/ex/sql-map-mybatis-iCUBE-config.xml";
            Properties props = new Properties();
            props.put("databaseType", conVo.getDatabaseType());
            props.put("driver", conVo.getDriver());
            props.put("url", conVo.getUrl());
            props.put("username", conVo.getUserId());
            props.put("password", conVo.getPassword());
            props.put("erpTypeCode", conVo.getErpTypeCode());
            // 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
            Reader reader = Resources.getResourceAsReader(resource);
            // reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            if (sqlSessionFactory == null) {
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            } else {
                sqlSessionFactory = null;
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
            }
            result = true;
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* 공통코드 - 계정과목 조회 */
    public ExCodeAcctVO ExCodeAcctInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            acctVo = session.selectOne("ExCodeAcctInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctVo;
    }

    /* 공통코드 - 계정과목 목록 조회 */
    public List<ExCodeAcctVO> ExCodeAcctListInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>();
        try {
            acctListVo = session.selectList("ExCodeAcctListInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctListVo;
    }

    /* 공통코드 - 차변 계정과목 조회 */
    public ExCodeAcctVO ExCodeAcctDrInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            acctVo = session.selectOne("ExCodeAcctDrInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctVo;
    }

    /* 공통코드 - 차변 계정과목 목록 조회 */
    public List<ExCodeAcctVO> ExCodeAcctDrListInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : search_str, search_str, erp_comp_seq */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>();
        try {
            acctListVo = session.selectList("ExCodeAcctDrListInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctListVo;
    }

    /* 공통코드 - 대변 계정과목 조회 */
    public ExCodeAcctVO ExCodeAcctCrInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            acctVo = session.selectOne("ExCodeAcctCrInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctVo;
    }

    /* 공통코드 - 대변 계정과목 목록 조회 */
    public List<ExCodeAcctVO> ExCodeAcctCrListInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>();
        try {
            acctListVo = session.selectList("ExCodeAcctCrListInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctListVo;
    }

    /* 공통코드 - 부가세 계정과목 조회 */
    public ExCodeAcctVO ExCodeAcctVatInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            acctVo = session.selectOne("ExCodeAcctVatInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctVo;
    }

    /* 공통코드 - 부가세 계정과목 목록 조회 */
    public List<ExCodeAcctVO> ExCodeAcctVatListInfoSelect(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + acctVo.toString(), acctVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>();
        try {
            acctListVo = session.selectList("ExCodeAcctVatListInfoSelect", acctVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return acctListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- 증빙유형 ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 공통코드 - 증빙유형 생성 */
    public Map<String, Object> setExCodeAuthInfoInsert(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + param.toString(), param);

        Map<String, Object> result = new HashMap<String, Object>();
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            int retVal = session.insert("setExCodeAuthInfoInsert", param);
            if (retVal > 0) {
                result.put("resultCode", retVal);
                result.put("resultMessage", BizboxAMessage.getMessage("TX000016500", "생성되었습니다."));
                result.put("resultError", commonCode.EMPTYSTR);
            } else {
                result.put("resultCode", commonCode.EMPTYSEQ);
                result.put("resultMessage", BizboxAMessage.getMessage("TX000016499", "생성에 실패하였습니다."));
                result.put("resultError", commonCode.EMPTYSTR);
            }
            session.close();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- 임시예산 ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 지출결의 - 임시예산 등록 */
    public ExCommonResultVO ExExpendGmmsumOtherInfoInsert(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + budgetVo.toString(), budgetVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            session.insert("ExExpendGmmsumOtherInfoInsert", budgetVo);
            resultVo.setCode(commonCode.SUCCESS);
            resultVo.setMessage(BizboxAMessage.getMessage("TX000009301", "정상처리되었습니다"));
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return resultVo;
    }

    /* 지출결의 - 임시예산 삭제 */
    public ExCommonResultVO ExExpendGmmsumOtherInfoDelete(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + budgetVo.toString(), budgetVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            session.delete("ExExpendGmmsumOtherInfoDelete", budgetVo);
            resultVo.setCode(commonCode.SUCCESS);
            resultVo.setMessage(BizboxAMessage.getMessage("TX000009301", "정상처리되었습니다"));
            session.commit();
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return resultVo;
    }

    /* 공통코드 - 예산단위 목록 조회 */
    public List<ExCodeBudgetVO> ExCodeBudgetListInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + budgetVo.toString(), budgetVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeBudgetVO> budgetListVo = new ArrayList<ExCodeBudgetVO>();
        try {
            budgetListVo = session.selectList("ExCodeBudgetListInfoSelect", budgetVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return budgetListVo;
    }

    /* 공통코드 - 사업계획 목록 조회 */
    public List<ExCodeBudgetVO> ExCodeBizplanListInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + budgetVo.toString(), budgetVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeBudgetVO> bizplanListVo = new ArrayList<ExCodeBudgetVO>();
        try {
            bizplanListVo = session.selectList("ExCodeBizplanListInfoSelect", budgetVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return bizplanListVo;
    }

    /* 공통코드 - 예산계정 목록 조회 */
    public List<ExCodeBudgetVO> ExCodeBgAcctListInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + budgetVo.toString(), budgetVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeBudgetVO> bgacctListVo = new ArrayList<ExCodeBudgetVO>();
        try {
            bgacctListVo = session.selectList("ExCodeBgAcctListInfoSelect", budgetVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return bgacctListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- card ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 공통코드 - 카드 조회 */
    public ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + cardVo.toString(), cardVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            String compSeq = cardVo.getCompSeq();
            String authNum = cardVo.getAuthNum();
            if (CommonConvert.CommonGetStr(cardVo.getSearchStr()).equals("")) {
                cardVo.setSearchStr(cardVo.getSearchCardNum());
            }

            ExpInfo.TipLog(cardVo.toString());
            Map<String, Object> params = new HashMap<String, Object>();

            try {
                cardVo.setErpCompSeq(conVo.getErpCompSeq());
                cardVo = session.selectOne("ExUserCode.ExCodeCardInfoSelect", cardVo);
                params = CommonConvert.CommonGetObjectToMap(cardVo);
            } catch (Exception e) {
                throw new Exception("ERP 카드정보를 확인할 수 없습니다");
            }

            params.put("compSeq", compSeq);
            /* 그룹웨어 카드정보 조회 */
            List<Map<String, Object>> resultBizboxA = list("ExUserCardListInfoSelect", params);
            
            /* ERP 데이터와 그룹웨어 데이터 조인 */
            for (Map<String, Object> gwCardData : resultBizboxA) {
                if (cardVo.getCardCode().equals(CommonConvert.CommonGetStr(gwCardData.get("cardCode")))) {
                    if (gwCardData.get("partnerCode") != null && !CommonConvert.CommonGetStr(gwCardData.get("partnerCode")).equals(commonCode.EMPTYSTR)) {
                        cardVo.setPartnerCode(CommonConvert.CommonGetStr(gwCardData.get("partnerCode")));
                        cardVo.setPartnerName(CommonConvert.CommonGetStr(gwCardData.get("partnerName")));
                        cardVo.setAuthNum( authNum );
                        break;
                    }
                    cardVo.setAuthNum( authNum );
                }
            }
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return cardVo;
    }

    /* 공통코드 - 카드 목록 조회 */
    public List<ExCodeCardVO> ExCodeCardListInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + cardVo.toString(), cardVo);

        /* parameters : erp_comp_seq, search_str, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeCardVO> cardListVo = new ArrayList<ExCodeCardVO>();
        try {
            cardListVo = session.selectList("ExCodeCardListInfoSelect", cardVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return cardListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- mng ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 기타 - 동적쿼리 호출 */
    public Map<String, Object> ExExpendMngDynamicQuerySelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + param.toString(), param);

        DynamicCommonConnection(conVo);
        SqlSession session = sqlSessionFactory.openSession();
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = session.selectOne(this.DynamicQuerySelect(param, conVo, session), param);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* 기타 - 동적쿼리 생헝 */
    private String DynamicQuerySelect(Map<String, Object> param, ConnectionVO conVo, SqlSession session) throws Exception {
    	synchronized(this) {
	        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + param.toString(), param);
	        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + conVo.toString(), conVo);

	        /* parameter : queryKey, execQuery, commandType */
	        /* 참고 : http://qmffjem09.tistory.com/entry/mybatis-%EB%8F%99%EC%A0%81%EC%9C%BC%EB%A1%9C-%EC%BF%BC%EB%A6%AC-%EC%85%8B%ED%8C%85%ED%95%98%EB%8A%94%EB%B0%A9%EB%B2%95 */
	        /* Map<String, Object> result = new HashMap<String, Object>(); */
	        /* connect(conVo); */
	        /* SqlSession session = sqlSessionFactory.openSession(); */
	        String queryKey = ((String) param.get("queryKey") == null ? commonCode.EMPTYSTR : (String) param.get("queryKey"));
	        String execQuery = ((String) param.get("execQuery") == null ? commonCode.EMPTYSTR : (String) param.get("execQuery"));
	        String commandType = ((String) param.get("commandType") == null ? commonCode.EMPTYSTR : (String) param.get("commandType"));
	        try {
	            String keyAttribute = null;
	            Iterator<String> itr = param.keySet().iterator();
	            while (itr.hasNext()) {
	                keyAttribute = itr.next();
	                execQuery = execQuery.replace("${" + keyAttribute + "}", (String) param.get(keyAttribute));
	                execQuery = execQuery.replace("#{" + keyAttribute + "}", "'" + (String) param.get(keyAttribute) + "'");
	            }
	            Configuration configuration = session.getConfiguration();
	            if (queryKey.equals(commonCode.EMPTYSTR) || execQuery.equals(commonCode.EMPTYSTR) || commandType.equals(commonCode.EMPTYSTR)) {
	                throw new Exception(BizboxAMessage.getMessage("TX000009295", "필수입력값이 누락되었습니다"));
	            }
	            if (!(configuration.hasStatement(queryKey))) {
	                RawSqlSource sqlSource = new RawSqlSource(configuration, execQuery, java.util.Map.class);
	                MappedStatement.Builder statementBuilder = new MappedStatement.Builder(configuration, queryKey, sqlSource, SqlCommandType.SELECT);
	                statementBuilder.timeout(configuration.getDefaultStatementTimeout());
	                List<ParameterMapping> parameterMappings = new ArrayList<ParameterMapping>();
	                ParameterMap.Builder inlineParameterMapBuilder = new ParameterMap.Builder(configuration, statementBuilder.id() + "-Inline", java.util.Map.class, parameterMappings);
	                statementBuilder.parameterMap(inlineParameterMapBuilder.build());
	                List<ResultMapping> resultMappings = new ArrayList<ResultMapping>();
	                List<ResultMap> resultMaps = new ArrayList<ResultMap>();
	                ResultMap.Builder resultMapBuilder = new ResultMap.Builder(configuration, statementBuilder.id() + "-Inline", java.util.Map.class, resultMappings);
	                resultMaps.add(resultMapBuilder.build());
	                statementBuilder.resultMaps(resultMaps);
	                MappedStatement statement = statementBuilder.build();
	                configuration.addMappedStatement(statement);
	            }
	        } catch (Exception e) {
	            throw e;
	        }
	        return queryKey;
    	}
    }

    /* 공통코드 */
    /* 공통코드 - 관리항목 전체 목록 조회 */
    public List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        /* parameter : erp_comp_seq, search_str */
        List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>();
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            mngListVo = session.selectList("ExUserCode.ExExpendMngListInfoSelect", mngVo);
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 */
    /* 공통코드 - 관리항목 목록 조회 */
    public List<ExExpendMngVO> getExMngList(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + param.toString(), param);

        List<ExExpendMngVO> list = null;
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            list = session.selectList("getExMngList", param);
            session.close();
        } catch (Exception e) {
            throw e;
        } finally {
            session.close();
        }
        return list;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- org ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 공통코드 - 사용자 조회 */
    public ExCodeOrgVO ExCodeEmpInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            orgVo = session.selectOne("ExCodeEmpInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgVo;
    }

    /* 공통코드 - 사용자 목록 조회 */
    public List<ExCodeOrgVO> ExCodeEmpListInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeOrgVO> orgListVo = new ArrayList<ExCodeOrgVO>();
        try {
            orgListVo = session.selectList("ExCodeEmpListInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgListVo;
    }

    /* 공통코드 - 회계단위 조회 */
    public ExCodeOrgVO ExCodePcInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            orgVo = session.selectOne("ExCodePcInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgVo;
    }

    /* 공통코드 - 회계단위 목록 조회 */
    public List<ExCodeOrgVO> ExCodePcListInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeOrgVO> orgListVo = new ArrayList<ExCodeOrgVO>();
        try {
            orgListVo = session.selectList("ExCodePcListInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgListVo;
    }

    /* 공통코드 - 코스트센터 조회 */
    public ExCodeOrgVO ExCodeCcInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            orgVo = session.selectOne("ExCodeCcInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgVo;
    }

    /* 공통코드 - 코스트센터 목록 조회 */
    public List<ExCodeOrgVO> ExCodeCcListInfoSelect(ExCodeOrgVO orgVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + orgVo.toString(), orgVo);

        /* parameters : erp_comp_seq, search_str */
        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeOrgVO> orgListVo = new ArrayList<ExCodeOrgVO>();
        try {
            orgListVo = session.selectList("ExCodeCcListInfoSelect", orgVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return orgListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- partner ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 공통코드 - 거래처 조회 */
    public ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + partnerVo.toString(), partnerVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            partnerVo = session.selectOne("ExUserCode.ExCodePartnerInfoSelect", partnerVo);
            if (partnerVo == null) {
                partnerVo = new ExCodePartnerVO();
            }
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return partnerVo;
    }

    /* 공통코드 - 거래처 목록 조회 */
    public List<ExCodePartnerVO> ExCodePartnerListInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + partnerVo.toString(), partnerVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodePartnerVO> partnerListVo = new ArrayList<ExCodePartnerVO>();
        try {
            partnerListVo = session.selectList("ExCodePartnerListInfoSelect", partnerVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return partnerListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- project ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /* 공통코드 - 프로젝트 조회 */
    public ExCodeProjectVO ExCodeProjectInfoSelect(ExCodeProjectVO projectVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + projectVo.toString(), projectVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            projectVo = session.selectOne("ExCodeProjectInfoSelect", projectVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return projectVo;
    }

    /* 공통코드 - 프로젝트 목록 조회 */
    public List<ExCodeProjectVO> ExCodeProjectListInfoSelect(ExCodeProjectVO projectVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + projectVo.toString(), projectVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeProjectVO> projectListVo = new ArrayList<ExCodeProjectVO>();
        try {
            projectListVo = session.selectList("ExCodeProjectListInfoSelect", projectVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return projectListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* ---------------------------------- tax ----------------------------------- */
    /* ----------------------------------------------------------------------------- */
    /**
     * @param vatTypeVo
     * @return
     */
    public ExCodeAuthVO ExCodeVatTypeInfoSelect(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + vatTypeVo.toString(), vatTypeVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        try {
            vatTypeVo = session.selectOne("ExCodeVatTypeInfoSelect", vatTypeVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return vatTypeVo;
    }

    /**
     * @param vatTypeVo
     * @return
     */
    public List<ExCodeAuthVO> ExCodeVatTypeListInfoSelect(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + vatTypeVo.toString(), vatTypeVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAuthVO> vatTeypListVo = new ArrayList<ExCodeAuthVO>();
        try {
            vatTeypListVo = session.selectList("ExCodeVatTypeListInfoSelect", vatTypeVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return vatTeypListVo;
    }

    /**
     * <pre>
     * 	불공제구분 리스트 조회
     * </pre>
     *
     * @param vatVo
     * @return
     */
    public List<ExCodeAuthVO> ExCodeNotaxListInfoSelect(ExCodeAuthVO vatVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + vatVo.toString(), vatVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAuthVO> vatListVo = new ArrayList<ExCodeAuthVO>();
        try {
            vatListVo = session.selectList("ExCodeNotaxListInfoSelect", vatVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return vatListVo;
    }

    /**
     * <pre>
     * 	불공제구분 리스트 조회
     * </pre>
     *
     * @param vatVo
     * @return
     */
    public List<ExCodeAuthVO> dExCodeNotaxListInfoSelect(ExCodeAuthVO vatVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + vatVo.toString(), vatVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExCodeAuthVO> vatListVo = new ArrayList<ExCodeAuthVO>();
        try {
            vatListVo = session.selectList("ExCodeNotaxListInfoSelect", vatVo);
        } catch (Exception e) {
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return vatListVo;
    }

    /* ----------------------------------------------------------------------------- */
    /* --------------------------------공통 팝업 조회 영역-------------------------- */
    /* ----------------------------------------------------------------------------- */
    public List<Map<String, Object>> ExCommonCodeAcctSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeAcctSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeBgAcctSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        // 2020. 02. 27. 김상겸, 프로세스 변경 ( 상위 통제를 위한 추가 정보 조회 추가 ) >> ERPiU 주홍열 선임연구원 지원 받음
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeBgAcctSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeBgAcctLinkAcctSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        // 2020. 02. 27. 김상겸, 프로세스 변경 ( 상위 통제를 위한 추가 정보 조회 추가 ) >> ERPiU 주홍열 선임연구원 지원 받음
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeBgAcctLinkAcctSelect", params);
        return result;
    }

    // 회계계정연결 확인
    public Map<String, Object> checkBgAcctLinkAcct(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        Map<String, Object> resultMap = new HashMap<String, Object>();

        try {

          if(CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            resultMap = connector.Select(conVo, "ExUserCode.checkBgAcctLinkAcct", params);
          }else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            resultMap = connector.Select(conVo, "ExUserCode.checkBgAcctLinkAcct", params);
          }

        } catch (Exception e) {
          throw e;
        }

        return resultMap;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExCommonCodeBizplanSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "ExUserCode.ExCommonCodeBizplanSelect", params);

            result = (List<Map<String, Object>>)params.get("RC1");
            for (Map<String, Object> map : result) {
                map.put("bizplanCode", map.get("CD_BIZPLAN"));
                map.put("bizplanName", map.get("NM_BIZPLAN"));
            }
        } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
            result= connector.List(conVo, "ExUserCode.ExCommonCodeBizplanSelect", params);
        }

        return result;
    }

    public List<Map<String, Object>> ExCommonCodeBudgetSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeBudgetSelect", params);
        return result;
    }
    /* 하나투어 - 부서단위 조회 */
    public List<Map<String,Object>> ExCommonCodeBudDeptSelect(Map<String,Object> params, ConnectionVO conVo) throws Exception {
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

      List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeBudDeptgetSelect", params);
      return result;
    }

    public List<Map<String, Object>> ExCommonCodeCardSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        /* ERPiU 카드정보 조회 */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeCardSelect", params);
        /* 그룹웨어 카드정보 조회 */
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> resultBizboxA = list("ExUserCardListInfoSelect", params);
        /* ERP 데이터와 그룹웨어 데이터 조인 */
        for (Map<String, Object> erpCardData : result) {
            for (Map<String, Object> gwCardData : resultBizboxA) {
                if (CommonConvert.CommonGetStr(erpCardData.get("cardCode")).equals(CommonConvert.CommonGetStr(gwCardData.get("cardCode")))) {
                    if (CommonConvert.CommonGetStr(gwCardData.get("partnerCode")) != null && !CommonConvert.CommonGetStr(gwCardData.get("partnerCode")).equals(commonCode.EMPTYSTR)) {
                        erpCardData.put("partnerCode", CommonConvert.CommonGetStr(gwCardData.get("partnerCode")));
                        erpCardData.put("partnerName", CommonConvert.CommonGetStr(gwCardData.get("partnerName")));
                        break;
                    }
                }
            }
        }
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeCcSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeCcSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeEmpSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeEmpSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeDeptSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeDeptSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeEmpSelectOne(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeEmpSelectOne", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeErpAuthSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeErpAuthSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeNotaxSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeNotaxSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodePartnerSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodePartnerSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodePcSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodePcSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeProjectSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeProjectSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeVatTypeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeVatTypeSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExCommonCodeRegNoPartnerSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeRegNoPartnerSelect", params);
        return result;
    }

    // 환종정보 조회
    public List<Map<String, Object>> ExCommonCodeExchangeUnitSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExUserCode.ExCommonCodeExchangeUnitSelect", params);
        return result;
    }

    /* ERPiU 해당 계정과목이 접대비인지 확인 */
    public List<Map<String, Object>> ExCommonAcctReceptYN(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        /* parameters : erp_comp_seq, search_str, Adv_filter */
        List<Map<String, Object>> result = connector.List(conVo, "ExCommonAcctReceptYN", params);
        return result;
    }

    /* DAO - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    public ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        accSeq.setMap(connector.Select(conVo, "ExCommonAccSeqSelect", accSeq.getMap()));
        return accSeq;
    }

    /* DAO - ERPiU 예실대비현황 2.0 - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    public ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        accSeq.setMap(connector.Select(conVo, "ExCommonAccSeqYesilIuSelect", accSeq.getMap()));
        return accSeq;
    }
}
