package expend.ex.user.mng;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
//import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;
import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExExpendMngVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FExUserMngServiceUDAO")
public class FExUserMngServiceUDAO extends EgovComAbstractDAO {

    /* 변수정의 */
    //private SqlSessionFactory sqlSessionFactory;

    // /* 공통사용 */
    // /* 공통사용 - 데이터베이스 연결 설정 */
    // private boolean connect ( ConnectionVO conVo ) throws Exception {
    // boolean result = false;
    // try {
    // // 환경 설정 파일의 경로를 문자열로 저장
    // // 경로 수정 예정 신재호
    // String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/ERPiU/ex/sql-map-mybatis-ERPiU-config.xml";
    // Properties props = new Properties( );
    // props.put( "databaseType", conVo.getDatabaseType( ) );
    // props.put( "driver", conVo.getDriver( ) );
    // props.put( "url", conVo.getUrl( ) );
    // props.put( "username", conVo.getUserId( ) );
    // props.put( "password", conVo.getPassword( ) );
    // props.put( "erpTypeCode", conVo.getErpTypeCode( ) );
    // // 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
    // Reader reader = Resources.getResourceAsReader( resource );
    // // reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성
    // if ( sqlSessionFactory == null ) {
    // sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
    // }
    // else {
    // sqlSessionFactory = null;
    // sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
    // }
    // result = true;
    // }
    // catch ( Exception e ) {
    // StringWriter sw = new StringWriter( );
    // e.printStackTrace( new PrintWriter( sw ) );
    // e.printStackTrace( );
    // throw e;
    // }
    // return result;
    // }
    private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
        String mapPath = "ex";
        if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
            SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
            CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
        }
        return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
    }

    /* 공통코드 */
    /* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
    public List<ExExpendMngVO> ExCodeMngListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 귀속사업장 */
    public List<ExExpendMngVO> ExCodeMngDA01ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA01ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 코스트센타 */
    public List<ExExpendMngVO> ExCodeMngDA02ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA02ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 부서 */
    public List<ExExpendMngVO> ExCodeMngDA03ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA03ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 사원 */
    public List<ExExpendMngVO> ExCodeMngDA04ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA04ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 프로젝트 */
    public List<ExExpendMngVO> ExCodeMngDA05ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA05ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 거래처 */
    public List<ExExpendMngVO> ExCodeMngDA06ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA06ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 예적금계좌 */
    public List<ExExpendMngVO> ExCodeMngDA07ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA07ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 신용카드 */
    public List<ExExpendMngVO> ExCodeMngDA08ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA08ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 금융기관 */
    public List<ExExpendMngVO> ExCodeMngDA09ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA09ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 품목 */
    public List<ExExpendMngVO> ExCodeMngDA10ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDA10ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 자산관리번호 */
    public List<ExExpendMngVO> ExCodeMngDB01ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDB01ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 자산처리구분 */
    public List<ExExpendMngVO> ExCodeMngDB11ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDB11ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 받을어음정리구분 */
    public List<ExExpendMngVO> ExCodeMngDB12ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDB12ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 환종 */
    public List<ExExpendMngVO> ExCodeMngDB24ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDB24ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 사업자등록번호 */
    public List<ExExpendMngVO> ExCodeMngDC01ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC01ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 관련계정 */
    public List<ExExpendMngVO> ExCodeMngDC03ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
                session.selectOne("ExCodeMngDC03ListInfoSelect", mngVo);

                for (Map<String, Object> map : mngVo.getResult()) {
                    ExExpendMngVO tmp = new ExExpendMngVO();
                    tmp.setCtdCode(String.valueOf(map.get("CD_ACCT")));
                    tmp.setCtdName(String.valueOf(map.get("NM_ACCT")));
                    mngListVo.add(tmp);
                }
            } else if (conVo.getDatabaseType().equals(commonCode.MSSQL)) {
                mngListVo = session.selectList("ExCodeMngDC03ListInfoSelect", mngVo);
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 세무구분 */
    public List<ExExpendMngVO> ExCodeMngDC14ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC14ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 거래처계좌번호 */
    public List<ExExpendMngVO> ExCodeMngDC15ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC15ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 불공제구분 */
    public List<ExExpendMngVO> ExCodeMngDC18ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC18ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 증빙구분 */
    public List<ExExpendMngVO> ExCodeMngDC20ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC20ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 지급조건 */
    public List<ExExpendMngVO> ExCodeMngDC28ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDC28ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 업무용차량 */
    public List<ExExpendMngVO> ExCodeMngDB54ListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDB54ListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }

    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 관리내역 */
    public List<ExExpendMngVO> ExCodeMngDListInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + mngVo.toString(), mngVo);

        SqlSession session = this.connect(conVo).getSqlSessionFactory().openSession();
        List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
        try {
            mngListVo = session.selectList("ExCodeMngDListInfoSelect", mngVo);
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            e.printStackTrace();
            session.rollback();
            session.close();
            throw e;
        } finally {
            session.close();
        }
        return mngListVo;
    }
}
