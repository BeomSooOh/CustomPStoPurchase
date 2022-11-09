package expend.np.admin.report;

import java.io.Reader;
//import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpAdminReportServiceUDAO" )
public class FNpAdminReportServiceUDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private boolean connect ( ConnectionVO conVo ) throws Exception {
		boolean result = false;
		try {
			// 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/ERPiU/sql-map-mybatis-ERPiU-config.xml";
			Properties props = new Properties( );
			props.put( "databaseType", conVo.getDatabaseType( ) );
			props.put( "driver", conVo.getDriver( ) );
			props.put( "url", conVo.getUrl( ) );
			props.put( "username", conVo.getUserId( ) );
			props.put( "password", conVo.getPassword( ) );
			props.put( "erpTypeCode", conVo.getErpTypeCode( ) );
			// 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
			Reader reader = Resources.getResourceAsReader( resource );
			// reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
			if ( sqlSessionFactory == null ) {
				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
			}
			else {
				sqlSessionFactory = null;
				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
			}
			result = true;
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}

	/**
	 * test
	 * P : { }
	 * return List<Map<String, Object>> result
	 */
	public List<Map<String, Object>> test ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.TestCode", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 전송
	 * P : { }
	 * return List<Map<String, Object>> sendResDoc
	 */
	public List<Map<String, Object>> sendResDoc ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeI.TestCode", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * insertFiDocucause
	 */
	public int insertFiDocucause ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertFiDocucause", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * insertFiDocucause
	 */
	public int insertFiDocucause2 ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 0;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertFiDocucause2", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * insertFidocucausepay
	 */
	public int insertFidocucausepay ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertFidocucausepay", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}
	/**
	 * insertFiChinCome
	 */
	public int insertFichincome ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertFichincome", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 키 구하기
	 * P : { }
	 * return List<Map<String, Object>> sendResDoc
	 */
	public String selectERPResKey ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		String noCdocu = "";
		try {
			result = session.selectList( "npAdminReport.getERPResKey", params );
			if ( result.size( ) != 1 ) {
				throw new Exception( "원인행위 문서 키 조회는 단일건이 조회되어야 하지만 " + result.size( ) + "건이 조회되었습니다." );
			}
			else {
				if ( CommonConvert.CommonGetStr(result.get( 0 ).get( "NO_CDOCU" )).equals( "EMPTY" ) ) {
					noCdocu = params.get( "imperfectionKey" ).toString( ) + "00";
				}
				else {
					int advKey = Integer.parseInt( result.get( 0 ).get( "NO_CDOCU" ).toString( ).substring( 10, 15 ) );
					advKey++;
					noCdocu = params.get( "imperfectionKey" ).toString( ) + String.format( "%02d", advKey );
				}
			}
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return noCdocu;
	}
	/**
	 * 소득자 테이블 키 구하기
	 * P : { }
	 * return List<Map<String, Object>> sendResDoc
	 */
	public String selectERPResChinComeKey ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		String cdMng = "";
		try {
			result = session.selectList( "npAdminReport.getERPResChinComeKey", params );
			if ( result.size( ) != 1 ) {
				throw new Exception( "소득자 키 조회는 단일건이 조회되어야 하지만 " + result.size( ) + "건이 조회되었습니다." );
			}
			else {
				if ( CommonConvert.CommonGetStr(result.get( 0 ).get( "CD_MNG" )).equals( "EMPTY" ) ) {
					cdMng = params.get( "chincomeKey" ).toString() + "00000";
				}
				else {
					int advKey = Integer.parseInt( result.get( 0 ).get( "CD_MNG" ).toString( ).substring(5));
					advKey++;
					cdMng = params.get("chincomeKey").toString().substring(0, 6) + advKey;
				}
			}
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return cdMng;
	}

	/**
	 * 결의서 정보 조회
	 */
	public List<Map<String, Object>> selectFidocucause ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.List( conVo, "npAdminReport.selectFidocucause", params );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 전송 취소
	 */
	public ResultVO deleteFidocucause ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			connector.Delete( conVo, "npAdminReport.deleteFidocucause", params );
			connector.Delete( conVo, "npAdminReport.deleteFidocucausePay", params );
			connector.Delete( conVo, "npAdminReport.deleteFichincome", params );
			connector.Delete( conVo, "npAdminReport.deleteHincome", params );
			connector.Delete( conVo, "npAdminReport.deleteFiGoodState", params );
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 관리자 - 매입전자세금계산서 리스트 조회
	 */
	public List<Map<String, Object>> NPAdminETaxListInfoSelectMap ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>( );
		try {
			Map<String, Object> param = CommonConvert.CommonGetObjectToMap( etaxVo );
			etaxListVo = connector.List( conVo, "npAdminReport.NPAdminETaxListInfoSelectMap", param );
		}
		catch ( Exception e ) {
			throw e;
		}
		return etaxListVo;
	}

	/**
	 * 관리자 - 예실대비 현황 리스트 조회
	 */
	public ResultVO NPAdminYesilListSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		List<Map<String, Object>> erpTotalAmt = new ArrayList<Map<String, Object>>( );

		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			if ("".equals(params.get("erpBizplanSeq")) || params.get("erpBizplanSeq") == null) {
				params.put("bpErpBizplanSeq", "***");
			} 
			params.put( "result1", null );
			params.put( "result2", null );
			params.put( "result3", null );
			params.put( "result4", null );
			params.put( "result5", null );
			params.put( "result6", null );
			params.put( "result7", null );
			session.selectList( "npAdminReport.NPAdminYesilReportSelect", params );

			erpTotalAmt = connector.List( conVo, "npAdminReport.NPAdminYesilResApplyReportSelect", params );



			resultMap.put( "erpTotalAmt", erpTotalAmt );
			resultMap.put( "erpTotalAdvAmtList", params.get( "result6" ) );

			params.put( "result1", null );
			params.put( "result2", null );
			params.put( "result3", null );
			params.put( "result4", null );
			params.put( "result5", null );
			params.put( "result6", null );
			params.put( "result7", null );
			session.selectList( "npAdminReport.NPAdminYesilApplyReportSelect", params );

			resultMap.put( "openAmtList", params.get( "result4" ) );
			resultMap.put( "erpApplyAmt", params.get( "result5" ) );
			resultMap.put( "erpApplyAdvAmtList", params.get( "result6" ) );

			
			result.setaData( resultMap );
			result.setSuccess( );
		} catch ( Exception e ) {
			result.setFail( "예실대비 현황 예산 계정 정보 조회 실패" , e);
		} finally {
			session.close( );
		}
		return result;
	}


	public void insertFiGoodState(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertFiGoodState", params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace();
		}
		finally {
			session.close( );
		}

	}

	public int insertHincome(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = connector.Insert( conVo, "npAdminReport.insertHincome", params );
		}
		catch ( Exception ex ) {
			ex.printStackTrace();
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * ERP IU 전자결재 키 저장 신규 속성 존재 여부 조회
	 */
	public String selectERPColumns ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		String existColumn = "";

		try {
			result = session.selectList( "npAdminReport.getCheckERPColumns", params );

			existColumn = CommonConvert.NullToString(result.get(0).get("EXISTCOLUMN"));
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}

		return existColumn;
	}
}
