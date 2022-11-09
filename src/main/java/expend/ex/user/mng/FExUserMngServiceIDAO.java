package expend.ex.user.mng;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExExpendMngVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExUserMngServiceIDAO" )
public class FExUserMngServiceIDAO extends EgovComAbstractDAO {

	/* 공통사용 */
	/* 공통사용 - 데이터베이스 연결 설정 */
	//	private boolean connect ( ConnectionVO conVo ) throws Exception {
	//		boolean result = false;
	//		try {
	//			// 환경 설정 파일의 경로를 문자열로 저장
	//			// 경로 수정 예정 신재호
	//			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/iCUBE/ex/sql-map-mybatis-iCUBE-config.xml";
	//			Properties props = new Properties( );
	//			props.put( "databaseType", conVo.getDatabaseType( ) );
	//			props.put( "driver", conVo.getDriver( ) );
	//			props.put( "url", conVo.getUrl( ) );
	//			props.put( "username", conVo.getUserId( ) );
	//			props.put( "password", conVo.getPassword( ) );
	//			props.put( "erpTypeCode", conVo.getErpTypeCode( ) );
	//			// 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
	//			Reader reader = Resources.getResourceAsReader( resource );
	//			// reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성
	//			if ( sqlSessionFactory == null ) {
	//				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
	//			}
	//			else {
	//				sqlSessionFactory = null;
	//				sqlSessionFactory = new SqlSessionFactoryBuilder( ).build( reader, props );
	//			}
	//			result = true;
	//		}
	//		catch ( Exception e ) {
	//			StringWriter sw = new StringWriter( );
	//			e.printStackTrace( new PrintWriter( sw ) );
	//			e.printStackTrace( );
	//			throw e;
	//		}
	//		return result;
	//	}
	private SqlSessionVO connect ( ConnectionVO conVo ) throws Exception {
	  ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
		String mapPath = "ex";
		if ( !MapUtil.hasKey( CommonErpConnect.connections, CommonConvert.CommonGetStr( conVo.getUrl( ) ) ) ) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO( conVo, mapPath );
			CommonErpConnect.connections.put( CommonConvert.CommonGetStr( conVo.getUrl( ) ), sqlSessionVo );
		}
		return (SqlSessionVO) CommonErpConnect.connections.get( CommonConvert.CommonGetStr( conVo.getUrl( ) ) );
	}

	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	public List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo); 
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo); 
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = session.selectList( "ExCodeMngListInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 사용자 정의 */
	public List<ExExpendMngVO> ExCodeMngDLMListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo); 
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo); 
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		List<Map<String, Object>> mngListMap = new ArrayList<Map<String, Object>>( );
		try {
			mngListMap = session.selectList( "ExCodeMngDLMListInfoSelect", mngVo );
			for ( Map<String, Object> map : mngListMap ) {
				ExExpendMngVO temp = new ExExpendMngVO( );
				temp.setCtdCode( (String) map.get( "MGMT_CD" ) );
				temp.setCtdName( (String) map.get( "MGMT_NM" ) );
				mngListVo.add( temp );
			}
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 관리내역 */
	public List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
	  ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo);
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);  
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = session.selectList( "ExCodeMngDListInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 연동 관리항목 하위코드 목록 조회 - 관리내역 */
	public List<ExExpendMngVO> ExCodeLinkMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
	  ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo); 
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo); 
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = session.selectList( "ExCodeLinkMngListInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	/* 공통코드 - iCUBE 사용자 정의 관리항목 연동 항목 조회 */
	public List<ExExpendMngVO> ExCutomMngRealInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
	  ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo); 
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo); 
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = session.selectList( "ExCutomMngRealInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	/* 공통코드 - 업무용승용차 관리내역 조회 - 관리내역 */
	public List<ExExpendMngVO> ExCodeLinkMngCarListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
	  ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo); 
      ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo); 
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = session.selectList( "ExCodeLinkMngCarListInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}
}