package expend.ex.budget;

import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeBudgetiCUBEVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExBudgetServiceIDAO" )
public class FExBudgetServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	//private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	//	private boolean connect ( ConnectionVO conVo ) throws Exception {
	//		boolean result = false;
	//		try {
	//			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/" + conVo.getErpTypeCode( ) + "/ex/sql-map-mybatis-iCUBE-config.xml";
	//			Properties props = new Properties( );
	//			props.put( "databaseType", conVo.getDatabaseType( ) );
	//			props.put( "driver", conVo.getDriver( ) );
	//			props.put( "url", conVo.getUrl( ) );
	//			props.put( "username", conVo.getUserId( ) );
	//			props.put( "password", conVo.getPassword( ) );
	//			props.put( "erpTypeCode", conVo.getErpTypeCode( ) );
	//			// 문자열로 된 경로의파일 내용을 읽을 수 있는 Reader 객체 생성
	//			Reader reader = Resources.getResourceAsReader( resource );
	//			// reader 객체의 내용을 가지고 SqlSessionFactory 객체 생성 / sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader, props);
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
	//			throw e;
	//		}
	//		return result;
	//	}
	private SqlSessionVO connect ( ConnectionVO conVo ) throws Exception {
		String mapPath = "ex";
		if ( !MapUtil.hasKey( CommonErpConnect.connections, CommonConvert.CommonGetStr( conVo.getUrl( ) ) ) ) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO( conVo, mapPath );
			CommonErpConnect.connections.put( CommonConvert.CommonGetStr( conVo.getUrl( ) ), sqlSessionVo );
		}
		return (SqlSessionVO) CommonErpConnect.connections.get( CommonConvert.CommonGetStr( conVo.getUrl( ) ) );
	}

	//예산사용 여부 가져오기
	public Map<String, Object> ExBudgetUseInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			resultMap = session.selectOne( "ExBudgetUseInfoSelect", params );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return resultMap;
	}

	/* 공통코드 - 예산확인 */
	@SuppressWarnings ( "unused" )
	public ExCodeBudgetVO ExBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo, ConnectionVO conVo ) throws Exception {
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		ExCodeBudgetiCUBEVO budgetiCUBEVo = new ExCodeBudgetiCUBEVO( );
		try {
			budgetiCUBEVo = session.selectOne( "ExiCUBEBudgetAmtInfoSelect", budgetVo );
			/* 예산 미통제 여부 확인 (2017-01-20 신재호 추가) */
			if ( budgetiCUBEVo == null ) {
				budgetVo.setBgacctCode( budgetVo.getBgacctCode( ).replace( "|", "" ) );
				@SuppressWarnings ( "unchecked" )
				Map<String, Object> isControlYN = (Map<String, Object>) session.selectOne( "ExiCUBEBudgetIsControlYN", budgetVo );
				/* 예산 미통제인 경우 */
				if ( isControlYN == null ) {
					budgetiCUBEVo = new ExCodeBudgetiCUBEVO( );
					budgetiCUBEVo.setCO_CD( budgetVo.getErpCompSeq( ) );
					budgetiCUBEVo.setBUDGET_FG( commonCode.EMPTYSTR );
				}
			}
			if ( budgetiCUBEVo != null ) {
				if ( budgetiCUBEVo.getCO_CD( ) != commonCode.EMPTYSTR ) {
					if ( !CommonConvert.CommonGetStr(budgetiCUBEVo.getBUDGET_FG() ).equals( commonCode.EMPTYSTR ) ) {
						/* EXISTS BUDGET_FG : 통제 */
						budgetVo.setBudgetControlYN( commonCode.EMPTYYES );
						budgetVo.setBudgetType( budgetiCUBEVo.getBUDGET_FG( ) ); //예산편성 타입 /D:부서 P:프로젝트
						budgetVo.setBudgetGbn( budgetiCUBEVo.getDATA_FG( ) );//사용 여부 / Y:사용
						budgetVo.setBudYm( budgetiCUBEVo.getBUD_YM( ) );//편성단위 (1Y, 1Q...)
						budgetVo.setBudgetActsum( budgetiCUBEVo.getBUDGET_AM( ) );//실행예산(편성예산포함)
						BigDecimal planAm = new BigDecimal( budgetiCUBEVo.getPLAN_AM( ) ); // ERP 실행예산금액
						BigDecimal acctAm = new BigDecimal( budgetiCUBEVo.getACCT_AM( ) );
						planAm = planAm.add( acctAm );
						budgetVo.setBudgetJsum( planAm.toString( ).replace( ".0000", "" ) ); //집행예정금액
					}
					else {
						/* NOT EXISTS BUDGET_FG : 미통제 */
						budgetVo.setBudgetControlYN( commonCode.EMPTYNO );
						budgetVo.setBudgetType( commonCode.EMPTYSTR ); //예산편성 타입 /D:부서 P:프로젝트
						budgetVo.setBudgetGbn( commonCode.EMPTYSTR );//사용 여부 / Y:사용
						budgetVo.setBudYm( commonCode.EMPTYSTR );//편성단위 (1Y, 1Q...)
						budgetVo.setBudgetActsum( commonCode.EMPTYSEQ );//실행예산(편성예산포함)
						budgetVo.setBudgetJsum( commonCode.EMPTYSEQ ); //집행예정금액
					}
					budgetVo.setErpCompSeq( budgetiCUBEVo.getCO_CD( ) ); //회사코드
				}
				else {
					/* NOT EXISTS budgetiCUBEVo : 미편성 */
					budgetVo.setBudgetControlYN( "B" );
				}
			}
			else {
				budgetiCUBEVo = new ExCodeBudgetiCUBEVO( );
				/* NOT EXISTS BUDGET_FG : 미편성 */
				budgetVo.setBudgetControlYN( "B" );
				budgetVo.setBudgetActsum( commonCode.EMPTYSEQ );
				budgetVo.setBudgetJsum( commonCode.EMPTYSEQ );
			}
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			e.printStackTrace( );
			session.rollback( );
			session.close( );
			throw e;
		}
		return budgetVo;
	}
}
