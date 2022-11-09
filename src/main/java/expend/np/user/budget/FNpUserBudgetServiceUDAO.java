package expend.np.user.budget;

import java.io.Reader;
//import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import common.helper.connection.CommonExConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserBudgetServiceUDAO" )
public class FNpUserBudgetServiceUDAO extends EgovComAbstractDAO {

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
	 * ERP 잔여 예산 조회
	 */
	public ResultVO selectBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		params.put( "P_AM_JSUM", null);
		params.put( "P_AM_JSUMCAUSE", null);
		params.put( "P_AM_ACTSUM", null);
		params.put( "P_YN_CONTROL", null);

		try {
			session.selectList( "npUserBudgetU.selectAbgtBalance", params );
			if(params.get( "P_AM_JSUM" ) != null){
				result.setaData( params );
				result.setSuccess( );
			}else{
				result.setFail( "예산정보 조회 실패 abgtCt: " + params.get( "abgtCd" ).toString( ) );
				// throw new Exception("예산정보 조회 실패 abgtCt: " + params.get( "abgtCd" ).toString( ));
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "ERP 설정 데이터 조회 실패", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}
}