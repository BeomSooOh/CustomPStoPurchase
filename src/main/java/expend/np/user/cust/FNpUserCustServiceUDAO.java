package expend.np.user.cust;

import java.io.Reader;
//import java.util.HashMap;
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


@Repository ( "FNpUserCustServiceUDAO" )
public class FNpUserCustServiceUDAO extends EgovComAbstractDAO {

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
	 * [CUST001] ERPiU 회계단위-사업계획 연동 여부 확인
	 */
	public ResultVO CUST_UP_Z_DITERP_FI_BIZPLAN_CHK ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		params.put( "P_CD_COMPANY", params.get( "erpCompSeq" ).toString( ));
		params.put( "P_CD_BIZPLAN", params.get( "erpBizplanSeq" ).toString( ));
		params.put( "P_CD_PC", params.get( "erpPcSeq" ).toString( ));
		params.put( "O_RETURN", null);
		try {
			session.selectList( "npUserCustU.CUST_UP_Z_DITERP_FI_BIZPLAN_CHK", params );
			if(params.get( "O_RETURN" ) != null){
				params.put( "resultCode", params.get( "O_RETURN" ) );
				result.setaData( params );
				result.setSuccess( );
			}else{
				result.setFail( "예산정보 조회 실패 abgtCt: " + params.get( "abgtCd" ).toString( ) );
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