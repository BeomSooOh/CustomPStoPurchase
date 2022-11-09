package expend.ex.user.code;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMap;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ResultMap;
import org.apache.ibatis.mapping.ResultMapping;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.scripting.defaults.RawSqlSource;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.ibatis.common.resources.Resources;

import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.SqlSessionVO;
import common.vo.ex.ExCodeAcctVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeBudgetiCUBEVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExExpendMngVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserCodeServiceIDAO" )
public class FExUserCodeServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	private SqlSessionFactory sqlSessionFactory;

	/* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 */
	/* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
	public List<Map<String, Object>> ExUserEmpListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "FExUserCodeServiceIDAO.ExUserEmpListInfoSelect", params );
		return result;
	}

	/* 공통사용 */
	/* Connection */
	private SqlSessionVO CommonConnection ( ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
		String mapPath = "ex";
		if ( !MapUtil.hasKey( CommonErpConnect.connections, CommonConvert.CommonGetStr( conVo.getUrl( ) ) ) ) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO( conVo, mapPath );
			CommonErpConnect.connections.put( CommonConvert.CommonGetStr( conVo.getUrl( ) ), sqlSessionVo );
		}
		return (SqlSessionVO) CommonErpConnect.connections.get( CommonConvert.CommonGetStr( conVo.getUrl( ) ) );
	}

	/* 공통사용 - 커넥션 */
	private boolean DynamicCommonConnection ( ConnectionVO conVo ) throws Exception {

	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
		boolean result = false;
		try {
			// 환경 설정 파일의 경로를 문자열로 저장 / String resource = "sample/mybatis/sql/mybatis-config.xml";
			String resource = "egovframework/sqlmap/config/" + conVo.getDatabaseType( ) + "/iCUBE/ex/sql-map-mybatis-iCUBE-config.xml";
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

	/* 공통코드 */
	/* 공통코드 - 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			acctVo = session.selectOne( "ExCodeAcctInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctVo;
	}

	/* 공통코드 - 계정과목 목록 조회 */
	public List<ExCodeAcctVO> ExCodeAcctListInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		try {
			acctListVo = session.selectList( "ExCodeAcctListInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctListVo;
	}

	/* 공통코드 - 차변 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctDrInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			acctVo = session.selectOne( "ExCodeAcctDrInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctVo;
	}

	/* 공통코드 - 차변 계정과목 목록 조회 */
	public List<ExCodeAcctVO> ExCodeAcctDrListInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		try {
			acctListVo = session.selectList( "ExCodeAcctDrListInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctListVo;
	}

	/* 공통코드 - 대변 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctCrInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			acctVo = session.selectOne( "ExCodeAcctCrInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctVo;
	}

	/* 공통코드 - 대변 계정과목 목록 조회 */
	public List<ExCodeAcctVO> ExCodeAcctCrListInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		try {
			acctListVo = session.selectList( "ExCodeAcctCrListInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctListVo;
	}

	/* 공통코드 - 부가세 계정과목 조회 */
	public ExCodeAcctVO ExCodeAcctVatInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		ExCodeAcctVO acctListVo = new ExCodeAcctVO( );
		try {
			acctListVo = session.selectOne( "ExCodeAcctVatInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctListVo;
	}

	/* 공통코드 - 부가세 계정과목 목록 조회 */
	public List<ExCodeAcctVO> ExCodeAcctVatListInfoSelect ( ExCodeAcctVO acctVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + acctVo.toString(), acctVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAcctVO> acctListVo = new ArrayList<ExCodeAcctVO>( );
		try {
			acctListVo = session.selectList( "ExCodeAcctVatListInfoSelect", acctVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return acctListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- 증빙유형 ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 증빙유형 생성 */
	public Map<String, Object> setExCodeAuthInfoInsert ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
		Map<String, Object> result = new HashMap<String, Object>( );
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			int retVal = (int) session.insert( "setExCodeAuthInfoInsert", param );
			if ( retVal > 0 ) {
				result.put( "resultCode", retVal );
				result.put( "resultMessage", BizboxAMessage.getMessage( commonCode.EMPTYSTR, "생성되었습니다." ) );
				result.put( "resultError", commonCode.EMPTYSTR );
			}
			else {
				result.put( "resultCode", commonCode.EMPTYSEQ );
				result.put( "resultMessage", BizboxAMessage.getMessage( commonCode.EMPTYSTR, "생성에 실패하였습니다." ) );
				result.put( "resultError", commonCode.EMPTYSTR );
			}
			session.commit( );
		}
		catch ( Exception e ) {
			session.rollback( );
			throw e;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- 예산 ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 예산확인 */
	public ExCodeBudgetVO ExCodeBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + budgetVo.toString(), budgetVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		ExCodeBudgetiCUBEVO budgetiCUBEVo = new ExCodeBudgetiCUBEVO( );
		try {
			budgetiCUBEVo = session.selectOne( "ExCodeBudgetAmtInfoSelect", budgetVo );
			if ( budgetiCUBEVo != null ) {
				if ( budgetiCUBEVo.getCO_CD( ) != commonCode.EMPTYSTR ) {
					if ( !budgetiCUBEVo.getBUDGET_FG( ).equals( commonCode.EMPTYSTR ) ) {
						/* EXISTS BUDGET_FG : 통제 */
						budgetVo.setBudgetControlYN( commonCode.EMPTYYES );
					}
					else {
						/* NOT EXISTS BUDGET_FG : 미통제 */
						budgetVo.setBudgetControlYN( commonCode.EMPTYNO );
					}
					budgetVo.setBudgetType( budgetiCUBEVo.getBUDGET_FG( ) );
					budgetVo.setBudgetGbn( budgetiCUBEVo.getDATA_FG( ) );
					budgetVo.setBudYm( budgetiCUBEVo.getBUD_YM( ) );
					budgetVo.setBudgetActsum( budgetiCUBEVo.getBUDGET_AM( ) );
					budgetVo.setBudgetJsum( budgetiCUBEVo.getPLAN_AM( ) );
				}
				else {
					/* NOT EXISTS budgetiCUBEVo : 미편성 */
					budgetVo.setBudgetControlYN( "-" );
				}
			}
			else {
				budgetiCUBEVo = new ExCodeBudgetiCUBEVO( );
				/* NOT EXISTS BUDGET_FG : 미통제 */
				budgetVo.setBudgetControlYN( "-" );
				budgetVo.setBudgetActsum( commonCode.EMPTYSEQ );
				budgetVo.setBudgetJsum( commonCode.EMPTYSEQ );
			}
		}
		catch ( Exception e ) {
			throw e;
		}
		return budgetVo;
	}

	/* 공통코드 - 예산통제 구분 확인 */
	public ExCodeBudgetVO ExCodeBudgetTypeInfoSelect ( ExCodeBudgetVO budgetVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + budgetVo.toString(), budgetVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		Map<String, Object> temp = new HashMap<String, Object>( );
		temp = CommonConvert.CommonGetObjectToMap( budgetVo );
		try {
			temp = session.selectOne( "ExCodeBudgetTypeInfoSelect", temp );
			budgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject( temp, budgetVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		return budgetVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- card ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 카드 조회 */
	public ExCodeCardVO ExCodeCardInfoSelect ( ExCodeCardVO cardVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + cardVo.toString(), cardVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			String compSeq = cardVo.getCompSeq( );
			cardVo = session.selectOne( "ExCodeCardInfoSelect", cardVo );
			Map<String, Object> params = CommonConvert.CommonGetObjectToMap( cardVo );
			params.put( "compSeq", compSeq );
			/* 그룹웨어 카드정보 조회 */
			@SuppressWarnings ( "unchecked" )
			List<Map<String, Object>> resultBizboxA = (List<Map<String, Object>>) list( "ExUserCardListInfoSelect", params );
			/* ERP 데이터와 그룹웨어 데이터 조인 */
			for ( Map<String, Object> gwCardData : resultBizboxA ) {
				if ( cardVo.getCardCode( ).equals( gwCardData.get( "cardCode" ) ) ) {
					if ( gwCardData.get( "partnerCode" ) != null && !gwCardData.get( "partnerCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
						cardVo.setPartnerCode( gwCardData.get( "partnerCode" ).toString( ) );
						cardVo.setPartnerName( gwCardData.get( "partnerName" ).toString( ) );
						break;
					}
				}
			}
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return cardVo;
	}

	/* 공통코드 - 카드 목록 조회 */
	public List<ExCodeCardVO> ExCodeCardListInfoSelect ( ExCodeCardVO cardVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + cardVo.toString(), cardVo);
		/* parameters : erp_comp_seq, search_str, search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeCardVO> cardListVo = new ArrayList<ExCodeCardVO>( );
		try {
			cardListVo = session.selectList( "ExCodeCardListInfoSelect", cardVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return cardListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- mng ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 기타 - 동적쿼리 */
	@SuppressWarnings ( "unused" )
	public Map<String, Object> ExExpendMngDynamicQuerySelect ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {

	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
		DynamicCommonConnection( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = session.selectOne( this.DynamicQuerySelect( param, conVo, session ), param );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return result;

		/* parameter : queryKey, execQuery, commandType */
		/* 참고 : http://qmffjem09.tistory.com/entry/mybatis-%EB%8F%99%EC%A0%81%EC%9C%BC%EB%A1%9C-%EC%BF%BC%EB%A6%AC-%EC%85%8B%ED%8C%85%ED%95%98%EB%8A%94%EB%B0%A9%EB%B2%95 */
//		Map<String, Object> result = new HashMap<String, Object>( );
//		DynamicCommonConnection( conVo );
//		SqlSession session = sqlSessionFactory.openSession( );
//		try {
//			String queryKey = ((String) param.get( "queryKey" ) == null ? commonCode.EMPTYSTR : (String) param.get( "queryKey" ));
//			String execQuery = ((String) param.get( "execQuery" ) == null ? commonCode.EMPTYSTR : (String) param.get( "execQuery" ));
//			String commandType = ((String) param.get( "commandType" ) == null ? commonCode.EMPTYSTR : (String) param.get( "commandType" ));
//			Configuration configuration = session.getConfiguration( );
//			if ( queryKey.equals( commonCode.EMPTYSTR ) || execQuery.equals( commonCode.EMPTYSTR ) || commandType.equals( commonCode.EMPTYSTR ) ) {
//				throw new Exception( BizboxAMessage.getMessage( "TX000009295", "필수입력값이 누락되었습니다" ) );
//			}
//			if ( configuration.hasStatement( queryKey ) ) {
//				throw new Exception( BizboxAMessage.getMessage( "TX000016520", "queryKey 가 중복되었습니다" ) );
//			}
//			RawSqlSource sqlSource = new RawSqlSource( configuration, execQuery, java.util.Map.class );
//			MappedStatement.Builder statementBuilder = new MappedStatement.Builder( configuration, queryKey, sqlSource, SqlCommandType.SELECT );
//			statementBuilder.timeout( configuration.getDefaultStatementTimeout( ) );
//			List<ParameterMapping> parameterMappings = new ArrayList<ParameterMapping>( );
//			ParameterMap.Builder inlineParameterMapBuilder = new ParameterMap.Builder( configuration, statementBuilder.id( ) + "-Inline", java.util.Map.class, parameterMappings );
//			statementBuilder.parameterMap( inlineParameterMapBuilder.build( ) );
//			List<ResultMapping> resultMappings = new ArrayList<ResultMapping>( );
//			List<ResultMap> resultMaps = new ArrayList<ResultMap>( );
//			ResultMap.Builder resultMapBuilder = new ResultMap.Builder( configuration, statementBuilder.id( ) + "-Inline", java.util.Map.class, resultMappings );
//			resultMaps.add( resultMapBuilder.build( ) );
//			statementBuilder.resultMaps( resultMaps );
//			MappedStatement statement = statementBuilder.build( );
//			result = session.selectOne( queryKey, param );
//		}
//		catch ( Exception e ) {
//			throw e;
//		}
//		finally {
//			session.close( );
//		}
//		return result;
	}

	private String DynamicQuerySelect ( Map<String, Object> param, ConnectionVO conVo, SqlSession session ) throws Exception {
		synchronized(this) {
	        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
	        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + conVo.toString(), conVo);
			String queryKey = ((String) param.get( "queryKey" ) == null ? commonCode.EMPTYSTR : (String) param.get( "queryKey" ));
			String execQuery = ((String) param.get( "execQuery" ) == null ? commonCode.EMPTYSTR : (String) param.get( "execQuery" ));
			String commandType = ((String) param.get( "commandType" ) == null ? commonCode.EMPTYSTR : (String) param.get( "commandType" ));

			try {
				String keyAttribute = null;
				Iterator<String> itr = param.keySet( ).iterator( );
				while ( itr.hasNext( ) ) {
					keyAttribute = (String) itr.next( );
					execQuery = execQuery.replace( "${" + keyAttribute + "}", (String) param.get( keyAttribute ) );
					execQuery = execQuery.replace( "#{" + keyAttribute + "}", "'" + (String) param.get( keyAttribute ) + "'" );
				}
				Configuration configuration = session.getConfiguration( );
				if ( queryKey.equals( commonCode.EMPTYSTR ) || execQuery.equals( commonCode.EMPTYSTR ) || commandType.equals( commonCode.EMPTYSTR ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009295", "필수입력값이 누락되었습니다" ) );
				}
				if ( !(configuration.hasStatement( queryKey )) ) {
					RawSqlSource sqlSource = new RawSqlSource( configuration, execQuery, java.util.Map.class );
					MappedStatement.Builder statementBuilder = new MappedStatement.Builder( configuration, queryKey, sqlSource, SqlCommandType.SELECT );
					statementBuilder.timeout( configuration.getDefaultStatementTimeout( ) );
					List<ParameterMapping> parameterMappings = new ArrayList<ParameterMapping>( );
					ParameterMap.Builder inlineParameterMapBuilder = new ParameterMap.Builder( configuration, statementBuilder.id( ) + "-Inline", java.util.Map.class, parameterMappings );
					statementBuilder.parameterMap( inlineParameterMapBuilder.build( ) );
					List<ResultMapping> resultMappings = new ArrayList<ResultMapping>( );
					List<ResultMap> resultMaps = new ArrayList<ResultMap>( );
					ResultMap.Builder resultMapBuilder = new ResultMap.Builder( configuration, statementBuilder.id( ) + "-Inline", java.util.Map.class, resultMappings );
					resultMaps.add( resultMapBuilder.build( ) );
					statementBuilder.resultMaps( resultMaps );
					MappedStatement statement = statementBuilder.build( );
					configuration.addMappedStatement( statement );
				}
			}
			catch ( Exception e ) {
				throw e;
			}
			return queryKey;
		}
	}

	/* 공통코드 */
	/* 공통코드 - 관리항목 전체 목록 조회 */
	public List<ExCodeMngVO> ExExpendMngListInfoSelect ( ExCodeMngVO mngVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + mngVo.toString(), mngVo);
		/* parameter : erp_comp_seq, search_str */
		List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>( );
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			mngListVo = session.selectList( "ExExpendMngListInfoSelect", mngVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return mngListVo;
	}

	public List<ExExpendMngVO> getExMngList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
		List<ExExpendMngVO> list = null;
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			list = session.selectList( "getExMngList", param );
			session.close( );
		}
		catch ( Exception e ) {
			throw e;
		}
		finally {
			session.close( );
		}
		return list;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- org ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 사용자 조회 */
	public ExCodeOrgVO ExCodeEmpInfoSelect ( ExCodeOrgVO orgVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + orgVo.toString(), orgVo);
		/* parameters : search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			orgVo = session.selectOne( "ExCodeEmpInfoSelect", orgVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return orgVo;
	}

	/* 공통코드 - 사용자 목록 조회 */
	public List<ExCodeOrgVO> ExCodeEmpListInfoSelect ( ExCodeOrgVO orgVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + orgVo.toString(), orgVo);
		/* parameters : search_str */
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeOrgVO> orgListVo = new ArrayList<ExCodeOrgVO>( );
		try {
			orgListVo = session.selectList( "ExCodeEmpListInfoSelect", orgVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return orgListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- partner ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 거래처 조회 */
	public ExCodePartnerVO ExCodePartnerInfoSelect ( ExCodePartnerVO partnerVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + partnerVo.toString(), partnerVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			partnerVo = session.selectOne( "ExCodePartnerInfoSelect", partnerVo );
			if ( partnerVo == null ) {
				partnerVo = new ExCodePartnerVO( );
			}
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return partnerVo;
	}

	/* 공통코드 - iCUBE 미등록 거래처 추가 */
	public Map<String, Object> ExCodeUnRegisteredPartnerInfoInsert ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {


        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + param.toString(), param);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = session.selectOne( "ExCodeUnRegisteredPartnerInfoInsert", param );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return result;
	}

	/* 공통코드 - 거래처 목록 조회 */
	public List<ExCodePartnerVO> ExCodePartnerListInfoSelect ( ExCodePartnerVO partnerVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + partnerVo.toString(), partnerVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodePartnerVO> partnerListVo = new ArrayList<ExCodePartnerVO>( );
		try {
			partnerListVo = session.selectList( "ExCodePartnerListInfoSelect", partnerVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return partnerListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- project ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/* 공통코드 - 프로젝트 조회 */
	public ExCodeProjectVO ExCodeProjectInfoSelect ( ExCodeProjectVO projectVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + projectVo.toString(), projectVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			projectVo = session.selectOne( "ExCodeProjectInfoSelect", projectVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return projectVo;
	}

	/* 공통코드 - 프로젝트 목록 조회 */
	public List<ExCodeProjectVO> ExCodeProjectListInfoSelect ( ExCodeProjectVO projectVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + projectVo.toString(), projectVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeProjectVO> projectListVo = new ArrayList<ExCodeProjectVO>( );
		try {
			projectListVo = session.selectList( "ExCodeProjectInfoSelect", projectVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return projectListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* ---------------------------------- tax ----------------------------------- */
	/* ----------------------------------------------------------------------------- */
	/**
	 * @param vatTypeVo
	 * @return
	 */
	public ExCodeAuthVO ExCodeVatTypeInfoSelect ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + vatTypeVo.toString(), vatTypeVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			vatTypeVo = session.selectOne( "ExCodeVatTypeInfoSelect", vatTypeVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return vatTypeVo;
	}

	/**
	 * @param vatTypeVo
	 * @return
	 */
	@SuppressWarnings ( "unchecked" )
	public List<ExCodeAuthVO> ExCodeVatTypeListInfoSelect ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + vatTypeVo.toString(), vatTypeVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAuthVO> vatTeypListVo = new ArrayList<ExCodeAuthVO>( );
		try {
			vatTeypListVo = session.selectList( "ExCodeVatTypeListInfoSelect", vatTypeVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		vatTeypListVo = (List<ExCodeAuthVO>) list( "ExCodeVatTypeInfoSelect", vatTypeVo );
		return vatTeypListVo;
	}

	/**
	 * @param vatVo
	 * @return
	 */
	public List<ExCodeAuthVO> ExCodeVaTypeListInfoSelect ( ExCodeAuthVO vatVo, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + vatVo.toString(), vatVo);
		SqlSession session = this.CommonConnection( conVo ).getSqlSessionFactory( ).openSession( );
		List<ExCodeAuthVO> vatListVo = new ArrayList<ExCodeAuthVO>( );
		try {
			vatListVo = session.selectList( "ExCodeVaTypeListInfoSelect", vatVo );
		}
		catch ( Exception e ) {
			session.rollback( );
			session.close( );
			throw e;
		}
		finally {
			session.close( );
		}
		return vatListVo;
	}

	/* ----------------------------------------------------------------------------- */
	/* --------------------------------공통 팝업 조회 영역-------------------------- */
	/* ----------------------------------------------------------------------------- */
	public List<Map<String, Object>> ExCommonCodeAcctSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeAcctSelect", params );
		return result;
	}

	/* iCUBE 카드도움창 공통코드 조회 */
	public List<Map<String, Object>> ExCommonCodeCardSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */

	    // iCUBE 카드정보 조회
		List<Map<String, Object>> result = ExCommonCodeCardSelectForICUBE(params, conVo);

		/* 그룹웨어 카드정보 조회 */
		@SuppressWarnings ( "unchecked" )
		List<Map<String, Object>> resultBizboxA = (List<Map<String, Object>>) list( "ExUserCardListInfoSelect", params );
		/* ERP 데이터와 그룹웨어 데이터 조인 */
		for ( Map<String, Object> erpCardData : result ) {
			for ( Map<String, Object> gwCardData : resultBizboxA ) {
				if ( erpCardData.get( "cardCode" ).toString( ).equals( gwCardData.get( "cardCode" ) ) ) {
					if ( gwCardData.get( "partnerCode" ) != null && !gwCardData.get( "partnerCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
						erpCardData.put( "partnerCode", gwCardData.get( "partnerCode" ) );
						erpCardData.put( "partnerName", gwCardData.get( "partnerName" ) );
						break;
					}
				}
			}
		}
		return result;
	}

	/* iCUBE 카드정보 조회 */
	public List<Map<String, Object>> ExCommonCodeCardSelectForICUBE(Map<String, Object> params, ConnectionVO conVo){
		return connector.List(conVo, "ExUserCode.ExCommonCodeCardSelect", params);
	}

	public List<Map<String, Object>> ExCommonCodeEmpSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeEmpSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeDeptSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeDeptSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeEmpSelectOne ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {

        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeEmpSelectOne", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeErpAuthSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeErpAuthSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodePartnerSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
	    /* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodePartnerSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeProjectSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeProjectSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeVaSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeVaSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeVatTypeSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeVatTypeSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeRegNoPartnerSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeRegNoPartnerSelect", params );
		return result;
	}

	// 환종정보
	public List<Map<String, Object>> ExCommonCodeExchangeUnitSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, "ExUserCode.ExCommonCodeExchangeUnitSelect", params );
		return result;
	}
}
