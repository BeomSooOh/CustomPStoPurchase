package expend.np.user.code;

import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import common.helper.exception.CheckErpVersionException;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpUserCodeServiceUDAO" )
public class FNpUserCodeServiceUDAO extends EgovComAbstractDAO {

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

	/* 테스트 DAO */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.TestCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [회계 단위]
	 * params : {
	 * !stdDate [ 기준일:yyyyMMdd ]
	 * , pcName [회계단위 검색 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonDivCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		List<Map<String, Object>> tempList = new ArrayList<>( );
		try {
			session.selectList( "npUserCodeU.selectCommonDivCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
			for(int i= 0; i < result.size( ) ; i++){
				Map<String, Object> item = result.get( i );
				if(item.get( "NM_PC" ).toString( ).indexOf( params.get( "pcName" ).toString( ) ) > -1){
					tempList.add( item );
				}
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw ex;
		}
		finally {
			session.close( );
		}
		return tempList;
	}

	/**
	 * 공통 양식 코드 조회 [부서 조회]
	 * params : {
	 * !stdDate [ 기준일:yyyyMMdd ]
	 * , deptName [부서 검색 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonDeptCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			if( !params.containsKey( "erpBizSeq" ) ){
				params.put( "erpBizSeq", "" ); 
			}
			if( !params.containsKey( "erpDeptSeq" ) ){
				params.put( "erpDeptSeq", "" ); 
			}
			if( !params.containsKey( "erpPcSeq" ) ){
				params.put( "erpPcSeq", "" ); 
			}
			if( !params.containsKey( "deptName" ) ){
				params.put( "deptName", "" ); 
			}
			if( !params.containsKey( "erpCompSeq" ) ){
				params.put( "erpCompSeq", "" ); 
			}
			if( !params.containsKey( "stdDate" ) ){
				params.put( "stdDate", "" ); 
			}
			if( !params.containsKey( "deptName" ) ){
				params.put( "deptName", "" ); 
			}
			session.selectList( "npUserCodeU.selectCommonDeptCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [부서 조회]
	 * params : {
	 * !stdDate [ 기준일:yyyyMMdd ]
	 * , deptName [부서 검색 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonDeptCode2 ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			if( !params.containsKey( "erpBizSeq" ) ){
				params.put( "erpBizSeq", "" ); 
			}
			if( !params.containsKey( "erpDeptSeq" ) ){
				params.put( "erpDeptSeq", "" ); 
			}
			if( !params.containsKey( "erpPcSeq" ) ){
				params.put( "erpPcSeq", "" ); 
			}
			if( !params.containsKey( "deptName" ) ){
				params.put( "deptName", "" ); 
			}
			if( !params.containsKey( "erpCompSeq" ) ){
				params.put( "erpCompSeq", "" ); 
			}
			if( !params.containsKey( "stdDate" ) ){
				Date nowDate = new Date( );
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				params.put( "stdDate", dateFormat.format( nowDate ) ); 
			}
			if( !params.containsKey( "deptName" ) ){
				params.put( "deptName", "" ); 
			}
			
			params.put( "result1", null );
			params.put( "result2", null );
			session.selectList( "npUserCodeU.selectCommonDeptCode2", params );
			result = (List<Map<String, Object>>) params.get( "result2" );
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
	
	/**
	 * 공통 양식 코드 조회 [사원 조회]
	 * params : {
	 * erpBizSeq [ERPiU 사업장 시퀀스]
	 * erpDeptSeq [ERPiU 부서 시퀀스]
	 * erpPcSeq [ERPiU 회계단위 시퀀스]
	 * empName [사원 검색 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonEmpCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "erpBizSeq" ) == null || params.get( "erpDeptSeq" ) == null || params.get( "erpPcSeq" ) == null ) {
				return result;
			}
			if ( params.get( "workType" ) != null && CommonConvert.CommonGetStr(params.get( "workType" )).equals( "" ) ) {
				params.remove( "workType" );
			}
			session.selectList( "npUserCodeU.selectCommonEmpCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [예산단위]
	 * params : {
	 * !stdYM [ 기준일:yyyyMM ]
	 * , bgtCodeName [예산 단위 검색 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBudgetCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "stdYM" ) == null ) {
				Date nowDate = new Date( );
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMM", Locale.getDefault() );
				params.put( "stdYM", dateFormat.format( nowDate ) );
			}
			// 예산단위 도움창 회계단위 필터링 여부 - 조잡한데 기능은 작동
			String erpDivSeq = "";
			if("".equals(params.get("erpDivSeq")) || params.get("erpDivSeq") == null ) {
				if("".equals(params.get("erpPcSeq")) || params.get("erpPcSeq") == null ) {
				} else {
					erpDivSeq = params.get("erpPcSeq").toString();
				}
			} else {
				erpDivSeq = params.get("erpDivSeq").toString();
			}
			
			params.put("erpDivSeq", "");
			params.put("erpPcSeq", "");
			if ("true".equals(params.get("YN_BGDEPTFILTER"))) {
				params.put("erpDivSeq", erpDivSeq);
				params.put("erpPcSeq", erpDivSeq);
			}
			session.selectList( "npUserCodeU.selectCommonBudgetCode", params );
			params.put("erpDivSeq", erpDivSeq);
			params.put("erpPcSeq", erpDivSeq);
			result = (List<Map<String, Object>>) params.get( "result" ); 
			
			/* 품의참조 결의서의 경우 품의서 예산단위로 필터링 */
			if(params.get( "advParam_erpBudgetSeqs" ) != null){
				List<Map<String, Object>> filterdList = new ArrayList<>( );
				String consBudgetSeq = params.get( "advParam_erpBudgetSeqs" ).toString( );				
				for(Map<String, Object> item : result){
					if( consBudgetSeq.indexOf( "|" + item.get( "CD_BUDGET" ).toString( ) + "|" ) > -1){
						filterdList.add( item );
					}
				}
				result = filterdList;
			}
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

	/**
	 * 공통 양식 코드 조회 [사업계획]
	 * params : {
	 * budgetSeq [예산 단위 검색 필터]
	 * ,useYNCondition [사용유무 검색 조건]
	 * ,isConnectedBudsget [연결사업계획 검색 조건]
	 * ,bizplanCloseMonth [사업계획종료년월 검색 조건]
	 * ,searchStr [검색어]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBizplanCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "bizplanCloseMonth" ) == null ) {
				Date nowDate = new Date( );
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMM", Locale.getDefault() );
				params.put( "bizplanCloseMonth", dateFormat.format( nowDate ) );
			}
			if ( params.get( "useYNCondition" ) == null ) {
				params.put( "useYNCondition", "Y" );
			}
			if ( params.get( "isConnectedBudget" ) == null ) {
				params.put( "isConnectedBudget", "Y" );
			}
			if ( params.get( commonCode.SEARCHSTR ) == null ) {
				params.put( commonCode.SEARCHSTR, commonCode.EMPTYSTR );
			}
			List<Map<String, Object>> tResult = new ArrayList<>( );
			// 사업계획 도움창 회계단위 필터링 여부 - 조잡하긴 한데 기능은 돌아감
			String erpDivSeq = "";
			if("".equals(params.get("erpDivSeq")) || params.get("erpDivSeq") == null ) {
				if("".equals(params.get("erpPcSeq")) || params.get("erpPcSeq") == null ) {
				} else {
					erpDivSeq = params.get("erpPcSeq").toString();
				}
			} else {
				erpDivSeq = params.get("erpDivSeq").toString();
			}
			
			params.put("erpDivSeq", "");
			params.put("erpPcSeq", "");
			if ("true".equals(params.get("YN_BIZPLANFILTER"))) {
				params.put("erpDivSeq", erpDivSeq);
				params.put("erpPcSeq", erpDivSeq);
			}
			session.selectList( "npUserCodeU.selectCommonBizplanCode", params );
			params.put("erpDivSeq", erpDivSeq);
			params.put("erpPcSeq", erpDivSeq);
			tResult = (List<Map<String, Object>>) params.get( "result" );
			/*
			 * 검색되서 리턴되지 않으므로 검색해서 리턴한다.
			 * 1. 사용여부 조건 확인
			 * 2. 사업계획 종료일 조건 확인
			 * 3. 연결 사업계획 조건 확인
			 */
			for ( Map<String, Object> tMap : tResult ) {
				String useYNCondition = params.get( "useYNCondition" ).toString( );
				if ( CommonConvert.CommonGetStr(params.get( "useYNCondition" )).equals( "A" ) ) {
					/* 사용여부 전체 조건인 경우 검색 결과의 사용여부값으로 옵션 설정 */
					useYNCondition = tMap.get( "YN_USE" ).toString( );
				}
				/* 사용어부 조건 확인 */
				if ( CommonConvert.CommonGetStr(tMap.get( "YN_USE" )).equals( useYNCondition ) ) {
					/* 사업계획 종료일 조건 확인 */
					if ( tMap.get( "YM_END" ) == null ) {
						/* 사업계획 종료일 설정이 안되어있기 때문에 결과에 추가 */
						/* 연결사업계획 조회조건 확인 */
						if ( CommonConvert.CommonGetStr(params.get( "isConnectedBudget" )).equals( commonCode.EMPTYYES ) ) {
							/* 연결사업계획만 조회 */
							if ( tMap.get( "CD_BUDGET" ) != null && CommonConvert.CommonGetStr(tMap.get( "CD_BUDGET" )).equals( CommonConvert.CommonGetStr(params.get( "erpBudgetSeq" )) ) ) {
								result.add( tMap );
							}
						}
						else {
							/* 전체 사업계획 조회 */
							result.add( tMap );
						}
					}
					else if ( Integer.parseInt( tMap.get( "YM_END" ).toString( ) ) >= Integer.parseInt( params.get( "bizplanCloseMonth" ).toString( ) ) ) {
						/* 사업계획 종료일(YM_END)<= 검색 사업계획 종료일 인경우 결과에 추가 */
						/* 연결사업계획 조회조건 확인 */
						if ( CommonConvert.CommonGetStr(params.get( "isConnectedBudget" )).equals( commonCode.EMPTYYES ) ) {
							/* 연결사업계획만 조회 */
							if ( tMap.get( "CD_BUDGET" ) != null && CommonConvert.CommonGetStr(tMap.get( "CD_BUDGET" )).equals( CommonConvert.CommonGetStr(params.get( "erpBudgetSeq" )) ) ) {
								result.add( tMap );
							}
						}
						else {
							/* 전체 사업계획 조회 */
							result.add( tMap );
						}
					}
				}
			}
			
			/* 품의참조 결의서의 경우 품의서 사업계획으로 필터링 */
			if(params.get( "advParam_erpBizplanSeqs" ) != null){
				List<Map<String, Object>> filterdList = new ArrayList<>( );
				String consBizplanSeq = params.get( "advParam_erpBizplanSeqs" ).toString( );				
				for(Map<String, Object> item : result){
					if( consBizplanSeq.indexOf( "|" + item.get( "CD_BIZPLAN" ).toString( ) + "|" ) > -1){
						filterdList.add( item );
					}
				}
				result = filterdList;
			}
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

	/**
	 * 공통 양식 코드 조회 [예산계정]
	 * params : {
	 * bgtYear [예산 년도 검색 픽터]
	 * ,budgetSeq [예산 단위 검색 필터]
	 * ,writeMonth [작성 년월 검색 필터]
	 * ,bizplanSeq [사업 계획 검색 필터]
	 * ,bgacctType [결의구분 검색조건]
	 * ,isConnectedBizplan [연결계정 검색조건]
	 * ,!searchStr [검색어]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBgacctCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "bgtYear" ) == null ) {
				Date nowDate = new Date( );
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy", Locale.getDefault() );
				params.put( "bgtYear", dateFormat.format( nowDate ) );
			}
			if ( params.get( "writeMonth" ) == null ) {
				Date nowDate = new Date( );
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMM", Locale.getDefault() );
				params.put( "writeMonth", dateFormat.format( nowDate ) );
			}
			if ( params.get( "bgacctType" ) == null ) {
				params.put( "bgacctType", commonCode.EMPTYSTR );
			}
			if ( params.get( "isConnectedBizplan" ) == null ) {
				params.put( "isConnectedBizplan", commonCode.EMPTYYES );
			}
			if ( params.get( commonCode.SEARCHSTR ) == null ) {
				params.put( commonCode.SEARCHSTR, commonCode.EMPTYSTR );
			}
			List<Map<String, Object>> tResult = new ArrayList<>( );
			session.selectList( "npUserCodeU.selectCommonBgacctCode", params );
			tResult = (List<Map<String, Object>>) params.get( "result" );
			
			if ( CommonConvert.NullToString(  params.get( "isConnectedBizplan" )  ).equals( "Y" )){
				/* 연결계정 정보 조회의 경우 */
				for ( Map<String, Object> tMap : tResult ) {
					String erpBudgetSeq = CommonConvert.NullToString( params.get( "erpBudgetSeq" ) );
					String erpBizplanSeq = CommonConvert.CommonGetStr( params.get( "erpBizplanSeq" ) );
					String tErpBudgetSeq = CommonConvert.NullToString( tMap.get( "CD_BUDGET" ) );
					String tErpBizplanSeq = CommonConvert.NullToString( tMap.get( "CD_BIZPLAN" ) );
					
					if(  erpBizplanSeq.equals( "" )  ){
						erpBizplanSeq = "***";
					}
					if( erpBudgetSeq.equals( tErpBudgetSeq ) && erpBizplanSeq.equals( tErpBizplanSeq ) ){
						/* 모든 조건 일치, Grid 리턴 준비 */
						tMap.put("NM_LEVEL", tMap.get( "H_NM_BGACCT" ));
						tMap.put("NM_LEVEL2", tMap.get( "HH_NM_BGACCT" ));
						tMap.put("NM_LEVEL3", tMap.get( "HHH_NM_BGACCT" ));
						result.add( tMap );
					}
				}
			} else {
				Map<String, Object> resultMap = new HashMap<String, Object>();
				for ( Map<String, Object> tMap : tResult ) {
					if( ! resultMap.containsKey( CommonConvert.NullToString( tMap.get( "CD_BGACCT" ) ) )){
						resultMap.put( CommonConvert.NullToString( tMap.get( "CD_BGACCT" ) ), tMap );
						tMap.put("NM_LEVEL", tMap.get( "H_NM_BGACCT" ));
						tMap.put("NM_LEVEL2", tMap.get( "HH_NM_BGACCT" ));
						tMap.put("NM_LEVEL3", tMap.get( "HHH_NM_BGACCT" ));
						result.add( tMap );
					}
				}
			}
			
			/* 품의참조 결의서의 경우 품의서 사업계획으로 필터링 */
			if(params.get( "advParam_erpBgacctSeqs" ) != null){
				List<Map<String, Object>> filterdList = new ArrayList<>( );
				String consBgacctSeq = params.get( "advParam_erpBgacctSeqs" ).toString( );				
				for(Map<String, Object> item : result){
					if( consBgacctSeq.indexOf( "|" + item.get( "CD_BGACCT" ).toString( ) + "|" ) > -1){
						filterdList.add( item );
					}
				}
				result = filterdList;
			}
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

	/**
	 * 공통 양식 코드 조회 [회계계정]
	 * params : {
	 * bgacctSeq [예산과목코드]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonFiacctCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( commonCode.SEARCHSTR ) == null ) {
				params.put( commonCode.SEARCHSTR, commonCode.EMPTYSTR );
			}
			if ( params.get( "isConectedBgacct" ) == null ) {
				params.put( "isConectedBgacct", commonCode.EMPTYYES );
			}
			List<Map<String, Object>> tResult = new ArrayList<>( );
			session.selectList( "npUserCodeU.selectCommonFiacctCode", params );
			tResult = (List<Map<String, Object>>) params.get( "result" );
			/* 검색되서 리턴되지 않으므로 검색해서 리턴한다. */
			if ( CommonConvert.CommonGetStr(params.get( "isConectedBgacct" )).equals( commonCode.EMPTYYES ) ) {
				for ( Map<String, Object> tMap : tResult ) {
					if ( tMap.get( "CD_BGACCT" ) != null && CommonConvert.CommonGetStr(tMap.get( "CD_BGACCT" )).equals( CommonConvert.CommonGetStr(params.get( "erpBgacctSeq" )) ) ) {
						/* 검색어 비교 */
						if ( CommonConvert.CommonGetStr(params.get( commonCode.SEARCHSTR )).equals( commonCode.EMPTYSTR ) ) {
							result.add( tMap );
						}
						else if ( tMap.get( "CD_ACCT" ).toString( ).indexOf( params.get( commonCode.SEARCHSTR ).toString( ) ) > -1 || tMap.get( "NM_ACCT" ).toString( ).indexOf( params.get( commonCode.SEARCHSTR ).toString( ) ) > -1 ) {
							result.add( tMap );
						}
					}
				}
			}
			else {
				result.addAll( tResult );
			}
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

	/**
	 * 공통 양식 코드 조회 [예산계정]
	 * params : {
	 * !bgtYear [ 예산년도:yyyy ]
	 * , bgtLevelName [예산 계획 검색 필터]
	 * , bgtAcct [예산 계정과목 : "1|3|" ]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBgtLevelCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonBgtLevelCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [예산계정 상세 정보]
	 * params : {
	 * bgtLevelCode [예산 단위 코드]
	 * , bizPlanCode [사업 계획 코드]
	 * , bgtAccCode [예산 계정 코드]
	 * , ? [차대 구분]
	 * , expendDate [회계일자:yyyyMMdd]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBgtInfoCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonBgtInfoCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [회계 계정 상세 정보]
	 * params : {
	 * bgtName [회계 계정 조회 필터]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBgtCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonBgtCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
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

	/**
	 * 공통 양식 코드 조회 [거래처 정보 조회]
	 * params : {
	 * trGbn [거래처 구분 : [ "001":"주요", "002":"금융", "003":"개인", "004":"신용", "005":"기타", "006":"외국어" ]]
	 * trType [거래처 분류 : [ "001":"매입", "002":"매출", "003":"통합", "004":"기타" ]]
	 * useYN [사용여부 : [ "":"전체", "Y":"사용", "N":"미사용" ]]
	 * trOpenGbn [휴폐업 구분 : [ "null":"전체", "001":"정산", "002":"휴업", "003":"폐업" ]]
	 * }
	 */
	public List<Map<String, Object>> selectCommonTrCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "trGbn" ) == null ) {
				params.put( "trGbn", commonCode.EMPTYSTR );
			}
			if ( params.get( "trType" ) == null ) {
				params.put( "trType", commonCode.EMPTYSTR );
			}
			if ( params.get( "useYN" ) == null ) {
				params.put( "useYN", commonCode.EMPTYYES );
			}
			if ( params.get( "trGroup" ) == null ) {
				params.put( "trGroup", commonCode.EMPTYSTR );
			}
			if ( params.get( "trGroup2" ) == null ) {
				params.put( "trGroup2", commonCode.EMPTYSTR );
			}
			if ( params.get( "trOpenGbn" ) != null && (CommonConvert.CommonGetStr(params.get( "trOpenGbn" )).equals( commonCode.EMPTYSTR ) || CommonConvert.CommonGetStr(params.get( "trOpenGbn" )).equals( "null" )) ) {
				params.remove( "trOpenGbn" );
			}
			result = session.selectList( "npUserCodeU.selectCommonTrCodeNotProcedure", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [거래처 확장 정보]
	 * params : {	
	 * 	erpCompSeq
	 * , trRegNb
	 * }
	 */
	public ResultVO selectCommonTrAdvCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			/* 검색조건 파라미터 없는경우 기본값으로 설정 */
			if ( params.get( "erpCompSeq" ) == null ) {
				throw new Exception (" [EXNP PARAM EXCEPTION] FNpUserCodeServiceUDAO.selectCommonTrAdvCode  erpCompSeq is null");	
			}
			if ( params.get( "trRegNb" ) == null ) {
				throw new Exception (" [EXNP PARAM EXCEPTION] FNpUserCodeServiceUDAO.selectCommonTrAdvCode  trRegNb is null");
			}
			List<Map< String, Object>> aaData = session.selectList( "npUserCodeU.selectCommonTrAdvCode", params );
			if( aaData.size( ) != 1 ){
				result.setFail( "거래처 단건 정보 조회 실패" );
				return result;
			}
			
			Map< String, Object> aData = new HashMap<>();
			Map< String, Object> aResult = aaData.get( 0 );
			
			aData.put( "trSeq", aResult.get( "CD_PARTNER" ) );
			aData.put( "businessNb", aResult.get( "NO_COMPANY" ) );
			aData.put( "depositor", aResult.get( "NM_DEPOSIT" ) );
			aData.put( "ceoName", aResult.get( "NM_CEO" ) );
			aData.put( "jiroSeq", aResult.get( "CD_BANK" ) );
			aData.put( "jiroName", aResult.get( "NM_BANK" ) );
			aData.put( "baNb", aResult.get( "NO_DEPOSIT" ) );
			aData.put( "depositNo", aResult.get( "CD_DEPOSITNO" ) );
			 
			result.setaData( aData );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	/**
	 * 공통 양식 코드 조회 [신용카드 정보 조회]
	 * params : {
	 * useYN [사용여부 : [ "":"전체", "Y":"사용", "N":"미사용" ]]
	 * cardGbn [ 신용카드 구분 : [ "":"전체", "1":"법인카드", "2":"개인카드", "3":"개인법인카드", "4":"(화물운전자복지카드) "] ]
	 * cardName [카드명 검색어]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonCardCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonCardCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [금융기관 코드 조회]
	 * params : {
	 * bankName [금융기관 검색어]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBankCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
//			session.selectList( "npUserCodeU.selectCommonBankCode", params );
			result = session.selectList( "npUserCodeU.selectCommonBankCodeNotProcedure", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [입출금 계좌]
	 * params : {
	 * !pcCode [ 회계단위 코드 : 1000 ]
	 * , btrName [ 입출금 계좌 필터 ]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonBtrCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeU.selectCommonBtrCode", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [기타 소득자 코드 조회]
	 * params : {
	 * stdDate [ 소득종료일 : yyyymmdd ]
	 * , trName [ 거래처 검색 필터 ]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonTrEtcCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonTrEtcCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [사업 소득자 코드 조회]
	 * params : {
	 * stdDate [ 소득종료일 : yyyymmdd ]
	 * , trName [ 거래처 검색 필터 ]
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonTrBusCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonTrBusCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [권한 부서 코드 조회]
	 * params : {
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonAuthDeptCode ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonAuthDeptCode", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [거래처 그룹 코드 조회]
	 * params : {
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonTrGroup ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonTrGroup", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [거래처 그룹2 코드 조회]
	 * params : {
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonTrGroup2 ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			session.selectList( "npUserCodeU.selectCommonTrGroup2", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 공통 양식 코드 조회 [소득 구분 코드 조회]
	 * params : {
	 * }
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> selectCommonIncomeGbn ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeU.selectCommonIncomeGbn", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	public List<Map<String, Object>> selectCommonNoTax ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeU.selectCommonNoTax", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}
	
	public List<Map<String, Object>> selectErpiUGisuInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeU.selectErpiUGisuInfo", params );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			throw new CheckErpVersionException( ex.getMessage( ) );
		}
		finally {
			session.close( );
		}
		return result;
	}

	public List<Map<String, Object>> selectCommonBizCode(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>( );
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			result = session.selectList( "npUserCodeU.selectCommonBizCode", params );
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
	

	public List<Map<String, Object>> selectErpiUDepositNo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		List<Map<String, Object>> result = null;
		connect( conVo );
		SqlSession session = sqlSessionFactory.openSession( );
		try {
			params.put( "result", null );
			session.selectList( "npUserCodeU.selectErpiUdepositNo", params );
			result = (List<Map<String, Object>>) params.get( "result" );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
		}
		finally {
			session.close( );
		}
		return result;
	}
}