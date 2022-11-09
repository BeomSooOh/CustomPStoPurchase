

package common.helper.connection;

import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import com.ibatis.common.resources.Resources;
import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExCodeETaxVO;


public class CommonErpConnect {

    /* 변수정의 */
    /* 변수정의 - 로그 */
    private final org.apache.logging.log4j.Logger LOG = LogManager.getLogger(this.getClass());
    public static HashMap<String, Object> connections = new HashMap<String, Object>();
    private SqlSessionFactory sqlSessionFactory;

    /* Connection */
    private SqlSessionVO CommonConnection(ConnectionVO conVo, String mapPath) throws Exception {
        return this.CommonConnection(conVo, mapPath, "");
    }

    private SqlSessionVO CommonConnection(ConnectionVO conVo, String mapPath, String type) throws Exception {
        String stype = type;

    	// 기존 유지.
        if (!MapUtil.hasKey(connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
            LOG.info("! [CommonConnection] Create - SqlSessionVO >> " + CommonConvert.CommonGetStr(conVo.getUrl()));
            SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
            connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
        }

        return (SqlSessionVO) connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));

        /* 2019-09-20 / 김상겸 : 커넥션 동적 생성으로 변경 */
        // SqlSessionVO sqlSession = null;
        //
        // if (type != null && type.equals("send")) {
        // if (!MapUtil.hasKey(connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
        // sqlSession = new SqlSessionVO(conVo, mapPath);
        // connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSession);
        // }
        //
        // return (SqlSessionVO) connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
        // } else {
        // sqlSession = new SqlSessionVO(conVo, mapPath);
        //
        // return sqlSession;
        // }
    }

    /* Dynamic Connection */
    private boolean DynamicCommonConnection(ConnectionVO conVo) throws Exception {
        boolean result = false;
        try {
            // 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
            String resource = "egovframework/sqlmap/config/" + CommonConvert.CommonGetStr(conVo.getDatabaseType()) + "/" + CommonConvert.CommonGetStr(conVo.getErpTypeCode()) + "/sql-map-mybatis-" + CommonConvert.CommonGetStr(conVo.getErpTypeCode()) + "-config.xml";
            Properties props = new Properties();
            props.put("databaseType", conVo.getDatabaseType());
            props.put("driver", conVo.getDriver());
            props.put("url", conVo.getUrl());
            props.put("username", conVo.getUserId());
            props.put("password", conVo.getPassword());
            props.put("erpTypeCode", conVo.getErpTypeCode());
            // 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
            Reader reader = Resources.getResourceAsReader(resource);
            // reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new
            // SqlSessionFactoryBuilder().build(reader, props);
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

    /* ################################################## */
    /* static connection */
    /* SqlSessionFactory */
    /* SqlSessionFactory - Select */
    public Map<String, Object> Select(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = session.selectOne(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - OutputSelect */
    public void OutputSelect(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        try {
            session.selectList(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
    }

    /* SqlSessionFactory - List */
    public List<Map<String, Object>> List(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            result = session.selectList(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - List */
    public List<ExCodeETaxVO> ETaxList(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        List<ExCodeETaxVO> result = new ArrayList<ExCodeETaxVO>();
        try {
            result = session.selectList(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Insert */
    public int Insert(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        return this.Insert(conVo, mapPath, queryId, params, "");
    }

    public int Insert(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params, String type) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath, type).getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(queryId, params);
            if (result > 0) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Insert */
    public int Insert(ConnectionVO conVo, String mapPath, String queryId, Object params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(queryId, params);
            if (result > 0) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Update */
    public int Update(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(queryId, params);
            if (result > 0) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Update */
    public int ErpDocUpdate(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(queryId, params);
            session.commit();
            result = 1;
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();

            result = 0;

            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Update 스토어 프로시져 */
    public int Update(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params, String storedProcedure) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        int result = 0;
        String stp = storedProcedure;
        try {
            result = session.update(queryId, params);
            session.commit();
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* SqlSessionFactory - Delete */
    public int Delete(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        SqlSession session = this.CommonConnection(conVo, mapPath).getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.delete(queryId, params);
            if (result > 0) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
    /* ################################################## */

    /* ################################################## */
    /* synamic connection */
    /* synamic connection - select */
    public Map<String, Object> DynamicSelect(ConnectionVO conVo, String queryId, Map<String, Object> params) throws Exception {
        this.DynamicCommonConnection(conVo);
        SqlSession session = sqlSessionFactory.openSession();
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = session.selectOne(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

    /* synamic connection - list */
    public List<Map<String, Object>> DynamicList(ConnectionVO conVo, String queryId, Map<String, Object> params) throws Exception {
        this.DynamicCommonConnection(conVo);
        SqlSession session = sqlSessionFactory.openSession();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            result = session.selectList(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }


    /* oracle_yesil connection - list */
    /* [ERPiU - oracle] 예실대비현황 조회시, 필수 프로시저 호출! 하나의 세션에 2개의 프로시저 호출 */
    public List<Map<String, Object>> yesilList_oracle(ConnectionVO conVo, String mapPath, String queryId, Map<String, Object> params) throws Exception {
        String mPath = mapPath;

    	this.DynamicCommonConnection(conVo);
        SqlSession session = sqlSessionFactory.openSession();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            session.selectOne("AdminiUYesil2.beforeExAdminYesil2InfoSelect_oracle", params);
            result = session.selectList(queryId, params);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            LOG.error("! [EXP] ERROR - " + exceptionAsStrting);
            e.printStackTrace();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }



    /* ################################################## */
}
