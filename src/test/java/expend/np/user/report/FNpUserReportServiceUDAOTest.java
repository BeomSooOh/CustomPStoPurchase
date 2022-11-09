package expend.np.user.report;

import static org.junit.Assert.assertTrue;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * FNpUserReportServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-18.
 */
public class FNpUserReportServiceUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FNpUserReportServiceUDAOTest.class);
	
	private SqlSessionFactory sqlSessionFactory;
	SqlSession session;
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://103.8.100.106:3433;databasename=NEOE");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
		
		connect( conVo );
		
		session = sqlSessionFactory.openSession( );
	}
	
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
			throw e;
		}
		return result;
	}

	/**
	 * 사용자 - 매입전자세금계산서 상세 내역 조회
	 */
	@Test
	public void testSelectETaxDetailInfo() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("syncId", "TX2019038434839");
		param.put("erpCompSeq", "");
		param.put("tpTbTaxCompany", "N");
		
		List<Map<String, Object>> result = session.selectList( "npUserETaxU.selectETaxDetailInfo", param );
		
		logger.info("### total = {}", result.size());
		assertTrue(result.size() > 0);
	}

}
