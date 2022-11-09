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


@Repository ( "FNpUserOptionServiceUDAO" )
public class FNpUserOptionServiceUDAO extends EgovComAbstractDAO {
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
			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/ERPiU/np/sql-map-mybatis-ERPiU-config.xml";
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

	/**
	 *	ERP iU 사용자 기본정보 조회
	 */
	public ResultVO selectUserBaseInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			List<Map<String, Object>> baseData = session.selectList( "npUserOptionU.selectUserBaseInfo", params );
			List<Map<String, Object>> tempList = new ArrayList<>( );
			for(Map<String, Object> item : baseData){
				Map<String, Object> temp = new HashMap<>( );
				temp.put( "depositName", item.get( "DEPOSITNAME" ) );
				temp.put( "depositName2", item.get( "DEPOSITNAME2" ) );
				temp.put( "erpBizName", item.get( "ERPBIZNAME" ) );
				temp.put( "erpBizSeq", item.get( "ERPBIZSEQ" ) );
				temp.put( "erpCcName", item.get( "ERPCCNAME" ) );
				temp.put( "erpCcSeq", item.get( "ERPCCSEQ" ) );
				temp.put( "erpCompName", item.get( "ERPCOMPNAME" ) );
				temp.put( "erpCompSeq", item.get( "ERPCOMPSEQ" ) );
				temp.put( "erpDeptName", item.get( "ERPDEPTNAME" ) );
				temp.put( "erpDeptSeq", item.get( "ERPDEPTSEQ" ) );
				temp.put( "erpEmpName", item.get( "ERPEMPNAME" ) );
				temp.put( "erpEmpSeq", item.get( "ERPEMPSEQ" ) );
				temp.put( "erpPcName", item.get( "ERPPCNAME" ) );
				temp.put( "erpPcSeq", item.get( "ERPPCSEQ" ) );
				tempList.add( temp );
			}
			result.setAaData( tempList );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "ERPiU 사용자 데이터 질의 응답에 실패하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 *	ERP iU 예산 계정 정보 조회
	 *	params { !erpCompSeq, !abgtCd }
	 *	return { !ctlBudget['Y', 'N'] }
	 */
	public ResultVO selectAbgtInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			List<Map<String, Object>> bgtInfo = session.selectList( "npUserOptionU.selectAbgtInfo", params );
			if(bgtInfo.size( ) == 1){
				Map<String, Object> tempMap = new HashMap<>( );
				tempMap.put( "ctlBudget", CommonConvert.CommonGetStr(bgtInfo.get( 0 ).get( "TPBUNIT" )).equals( "4" ) ?  "N" : commonCode.CANBGT );
				tempMap.put( "tpBgacct", bgtInfo.get( 0 ).get( "TPBGACCT" ).toString( ) );
				tempMap.put( "tpBmsg", bgtInfo.get( 0 ).get( "TPBMSG" ).toString( ) );
				result.setaData( tempMap );
			}else {
				throw new Exception(" 예산계정 정보 조회 실패 abgtCd(CD_BGACCT) :" + params.get( "abgtCd" ).toString( ) );
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "ERPiU 사용자 데이터 질의 응답에 실패하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	public Map<String, Object> selectERPCertainOption(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
		connect(conVo);
		SqlSession session = sqlSessionFactory.openSession();
		Map<String, Object> result = new HashMap<String, Object>();

		try {
			// >> erpCompSeq
			// << erpCompSeq, tpEnv, USE_YN, nmText
			result = session.selectOne("npUserOptionU.certainOptionSelect", params);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			throw ex;
		}
		finally {
			session.close();
		}

		return result;
	}

	/**
	 * ERP 환경설정 데이터 조회
	 * P : { erpCompSeq }
	 * return ResultVO with aaData
	 */
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FNpUserOptionServiceUDAO - selectERPOption" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> params >> " + params.toString( ) );
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			params.put("erpCompSeq", conVo.getErpCompSeq());
			List<Map<String, Object>> aaData = session.selectList( "npUserOptionU.optionSelect", params );
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
		cmLog.CommonSetInfo( "- [EX] FNpUserOptionServiceUDAO - selectERPOption" );
		return result;
	}
}