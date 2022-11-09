package expend.np.user.report;

import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringWriter;
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

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserReportServiceUDAO" )
public class FNpUserReportServiceUDAO extends EgovComAbstractDAO {
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
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
			throw e;
		}
		return result;
	}
	
	/**
	 * 사용자 - 매입전자세금계산서 리스트 조회
	 */	
	public List<Map<String, Object>> NPUserETaxListInfoSelectMap ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> etaxListVo = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			etaxListVo = session.selectList( "npUserETaxU.selectETaxListMap", param );
		}
		catch ( Exception ex ) {
			throw ex;
		}
		finally {
			session.close( );
		}
		return etaxListVo;
	}
	
	
	/**
	 * 사용자 - 매입전자세금계산서 상세 내역 조회
	 */	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectETaxDetailInfo ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FNpUserReportServiceUDAO - selectETaxDetailInfo" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> params >> " + param );
		List<Map<String, Object>> etaxListVo = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 
			 * tpTbTaxCompany = Y THEN FI_TB_TAXDOWN2
			 * tpTbTaxCompany = N THEN FI_TB_TAXDOWN
			 *  */
			Map<String, Object> tpTbTaxCompany = new HashMap<String, Object>();
			tpTbTaxCompany = (Map<String, Object>) session.selectOne("npUserETaxU.GetETaxListOption", param);
			param.put("tpTbTaxCompany", CommonConvert.CommonGetStr(tpTbTaxCompany.get("tpTbTaxCompany")));
			
			etaxListVo = session.selectList( "npUserETaxU.selectETaxDetailInfo", param );
		}
		catch ( Exception ex ) {
			StringWriter sw = new StringWriter();
			ex.printStackTrace(new PrintWriter(sw));
			ex.printStackTrace();
			etaxListVo = null;
			throw ex;
		}
		finally {
			session.close( );
		}
		cmLog.CommonSetInfo( "! [EX] return params >> " + param.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FNpUserReportServiceUDAO - selectETaxDetailInfo" );		
		return etaxListVo;
	}
}
