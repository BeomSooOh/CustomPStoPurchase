package expend.np.user.option;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserOptionServiceIDAO" )
public class FNpUserOptionServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
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
			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/iCUBE/np/sql-map-mybatis-iCUBE-config.xml";
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
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* 테스트 DAO */
	public Map<String, Object> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		cmLog.CommonSetInfo( "+ [EX] FNpUserOptionServiceIDAO - npTest" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> params >> " + params );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			List<Map<String, Object>> result = session.selectList( "npUserOptionI.NpTestQuery", params );
			params = result.get( 0 );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		cmLog.CommonSetInfo( "! [EX] return params >> " + params.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FNpUserOptionServiceIDAO - npTest" );
		return params;
	}

	/**
	 * ERP 환경설정 데이터 조회
	 * P : { erpCompSeq }
	 * return ResultVO with aaData
	 */
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FNpUserOptionServiceIDAO - selectERPOption" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> params >> " + params.toString( ) );
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			List<Map<String, Object>> aaData = session.selectList( "npUserOptionI.optionSelect", params );
			result.setAaData( aaData );
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "ERP 설정 데이터 조회 실패", ex );
		}
		finally {
			session.close( );
		}
		cmLog.CommonSetInfo( "! [EX] return ResultVO >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FNpUserOptionServiceIDAO - selectERPOption" );
		return result;
	}

	/**
	 * 특정 ERP 옵션 정보 조회
	 * params ex : Map{ "erpCompSeq" : "7070", "moduleCode" : "4", "ctrCode" : "16" }
	 * - erpCompSeq : 기본 conVo 사용
	 *
	 */
	public Map<String, Object> selectERPCertainOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
		params.put( "moduleCode", CommonConvert.NullToString( params.get( "moduleCode" ) ) );
		params.put( "ctrCode", CommonConvert.NullToString( params.get( "ctrCode" ) ) );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = session.selectList( "npUserOptionI.certainOptionSelect", params );
			if ( result.size( ) != 1 ) {
				return new HashMap<String, Object>( );
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		return result.get( 0 );
	}

	/**
	 * G20프로젝트 타입 조회
	 * params ex : Map{ "erpCompSeq" : "7070", "moduleCode" : "4", "ctrCode" : "16" }
	 * - erpCompSeq : 기본 conVo 사용
	 *
	 */
	public Map<String, Object> selectG20ProjectType ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = session.selectList( "npUserOptionI.projectTypeSelect", params );
			if ( result.size( ) != 1 ) {
				return new HashMap<String, Object>( );
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		return result.get( 0 );
	}

	/**
	 * ERP iCUBE G20 사용자 기본 정보 조회 [ 사용자 기본정보, 추가.. ]
	 * params {
	 * }
	 */
	public List<Map<String, Object>> selectBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* iCUBE G20 결의부서 및 작성자의 상위 종속 조건 반영여부 조회 */
			Map<String, Object> erpParam = new HashMap<>( );
			Map<String, Object> erpResult = new HashMap<>( );
			erpParam.put( "moduleCode", "4" );
			erpParam.put( "ctrCode", "16" );
			String erp416 = this.selectERPCertainOption( erpParam, conVo ).get( "USE_YN" ).toString( );
			params.put( "erp_4_16", erp416 );
			if ( erp416.equals( "1" ) ) {
				erpResult = (Map<String, Object>) (session.selectList( "npUserOptionI.selectBaseDataUserInfoType1", params ).get( 0 ));
			}
			else {
				erpResult = (Map<String, Object>) (session.selectList( "npUserOptionI.selectBaseDataUserInfoType2", params ).get( 0 ));
			}
			result.add( erpResult );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		return result;
	}

}