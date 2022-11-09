/**
 *
 */
package egovframework.com.cmm.service.impl;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;
import com.ibatis.sqlmap.client.SqlMapClient;
import bizbox.orgchart.service.vo.LoginVO;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.DefaultPaginationManager;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationManager;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationRenderer;


/**
 * EgovComAbstractDAO.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 23.
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 23.   서준식        최초 생성
 *      </pre>
 */
public abstract class EgovComAbstractDAO extends EgovAbstractDAO {

	@Override
    @Resource ( name = "egov.sqlMapClient" )
	public void setSuperSqlMapClient ( SqlMapClient sqlMapClient ) {
		super.setSuperSqlMapClient( sqlMapClient );
	}

	public String sqlSelectResultExcpetion ( Object result ) {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated( );
		String sqlSelectResult = "";
		if ( result == null ) {
			sqlSelectResult = "이 select sql은 결과값을 가져오지 않습니다.";
		}
		if ( !isAuthenticated ) {
			sqlSelectResult = "로그인 정보가 없습니다.";
		}
		return sqlSelectResult;
	}

	public Map<String, Object> listOfPaging ( HttpServletRequest request, String queryID, Map<String, Object> paramMap, PaginationInfo paginationInfo ) {
		return listOfPaging( request, queryID, "", paramMap, paginationInfo );
	}

	@SuppressWarnings ( { "rawtypes", "unchecked" } )
	public Map<String, Object> listOfPaging ( HttpServletRequest request, String queryID, String prefixName, Map<String, Object> paramMap, PaginationInfo paginationInfo ) {
		Map<String, Object> resultMap = new HashMap<String, Object>( );

		int startNum = paginationInfo.getFirstRecordIndex( ) + 1;
		int endNum = paginationInfo.getLastRecordIndex( );
		paramMap.put( "startNum", startNum );
		paramMap.put( "endNum", endNum );
		List list = this.list( queryID, paramMap );
		int totalCount = 0;
		if ( list != null && !list.isEmpty( ) ) {
			Map<String, Object> map = null;
			Object temp = null;
			temp = list.get( 0 );
			if ( temp == null ) {
				return null;
			}
			map = (Map<String, Object>) temp;
			temp = map.get( "TOTAL_COUNT" );
			if ( temp != null ) {
				totalCount = Integer.parseInt( temp.toString( ) );
			}
		}
		resultMap.put( prefixName + "list", list );
		ServletContext sc = request.getSession( ).getServletContext( );
		PaginationManager paginationManager = null;
		WebApplicationContext ctx = RequestContextUtils.getWebApplicationContext( request, sc );
		if ( ctx.containsBean( "paginationManager" ) ) {
			paginationManager = (PaginationManager) ctx.getBean( "paginationManager" );
		}
		else {
			//bean 정의가 없다면 DefaultPaginationManager를 사용. 빈설정이 없으면 기본 적인 페이징 리스트라도 보여주기 위함.
			paginationManager = new DefaultPaginationManager( );
		}
		paginationInfo.setTotalRecordCount( totalCount );
		int startCount = totalCount - ((paginationInfo.getCurrentPageNo( ) - 1) * paginationInfo.getPageSize( ));
		PaginationRenderer paginationRenderer = paginationManager.getRendererType( "image" );
		String naviHtml = paginationRenderer.renderPagination( paginationInfo, prefixName + "goPage" );
		resultMap.put( prefixName + "naviHtml", naviHtml );
		resultMap.put( prefixName + "startCount", startCount );
		resultMap.put( prefixName + "totalCount", totalCount );
		return resultMap;
	}

	@SuppressWarnings ( { "rawtypes", "unchecked" } )
	public Map<String, Object> listOfPaging2 ( Map<String, Object> paramMap, PaginationInfo paginationInfo, String queryID, String prefixName ) {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		int startNum = ((paginationInfo.getCurrentPageNo( ) - 1) * paginationInfo.getPageSize( )) + 1;
		int endNum = startNum + paginationInfo.getPageSize( ) - 1;
		paramMap.put( "startNum", startNum );
		paramMap.put( "endNum", endNum );
		int totalCount = 0;
		List list = null;//super.list(queryID, paramMap) ;
		if ( Globals.DB_TYPE.toLowerCase( ).equals( "mysql" ) || Globals.DB_TYPE.toLowerCase( ).equals( "mariadb" ) ) {
			startNum = ((paginationInfo.getCurrentPageNo( ) - 1) * paginationInfo.getPageSize( ));
			endNum = paginationInfo.getPageSize( );
			paramMap.put( "startNum", startNum );
			paramMap.put( "endNum", endNum );
			totalCount = EgovStringUtil.zeroConvert( this.select( queryID + "_TOTALCOUNT", paramMap ) + "" );
			if ( totalCount >= 0 ) {
				list = this.list( queryID, paramMap );
			}
		}
		else {
			list = this.list( queryID, paramMap );
		}
		if ( list != null && !list.isEmpty( ) ) {
			Map<String, Object> map = null;
			Object temp = null;
			temp = list.get( 0 );
			if ( temp == null ) {
				return null;
			}
			if ( !Globals.DB_TYPE.toUpperCase( ).equals( "MYSQL" ) && !Globals.DB_TYPE.toLowerCase( ).equals( "mariadb" ) ) {
				map = (Map<String, Object>) temp;
				temp = map.get( "TOTAL_COUNT" );
				if ( temp != null ) {
					totalCount = Integer.parseInt( temp.toString( ) );
				}
			}
		}
		paginationInfo.setTotalRecordCount( totalCount );
		resultMap.put( prefixName + "list", list );
		int startCount = totalCount - ((paginationInfo.getCurrentPageNo( ) - 1) * paginationInfo.getPageSize( ));
		resultMap.put( prefixName + "startCount", startCount );
		resultMap.put( prefixName + "totalCount", totalCount );
		return resultMap;
	}

	public Map<String, Object> listOfPaging2 ( Map<String, Object> paramMap, PaginationInfo paginationInfo, String queryID ) {
		return listOfPaging2( paramMap, paginationInfo, queryID, "" );
	}

	//	@SuppressWarnings ( { "unchecked", "deprecation", "rawtypes" } )
	//	public List list ( String queryId, Object parameterObject ) {
	//		return getSqlMapClientTemplate( ).queryForList( queryId, parameterObject );
	//	}
	@SuppressWarnings ( "unused" )
	public Map<String, Object> listForMobile ( String queryID, Map<String, Object> paramMap ) {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		@SuppressWarnings ( "rawtypes" )
		List list = this.list( queryID, paramMap );
		int totalCount = 0;
		if ( list != null && !list.isEmpty( ) ) {
			Map<String, Object> map = null;
			Object temp = null;
			temp = list.get( 0 );
			if ( temp == null ) {
				return null;
			}
		}
		resultMap.put( "list", list );
		return resultMap;
	}

	private String nullToString ( Object p ) {
		if ( p == null ) {
			return "null";
		}
		else {
			return p.toString( );
		}
	}

	@Override
    @SuppressWarnings ( { "unchecked", "rawtypes" } )
	public List list ( String queryId, Object p ) {
		// logger.debug( "[forCloud_exp] [LOG]	List list ( String queryId, Object p ) 메소드를 시작합니다." );
		String paramType = "";
		try {
			paramType = this.getParameterType( p );
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "typeNULL" ) ) {
				// log 파리미터 형식을 확인할 수 없습니다. 파라미터 형식 확인 요망
				logger.debug( "[forCloud_exp] [ERROR]	list queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	파라미터 타입을 알 수 없습니다. 파라미터 점검 필요." );
			}
		}
		/* 기본 변수 정의 영역 */
		Object queryParam = null;
		String groupSeq = "";
		Map<String, Object> databaseName = new HashMap<String, Object>( );
		EgovMap egovResult = new EgovMap( );
		boolean errorLogic = false;
		try {
			if ( paramType.equals( "String" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Integer" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Vo" ) || paramType.equals( "HashMap" ) ) {
				/*
				 * [ Vo, HashMap ] 사용의 경우
				 */
				Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					result = neosObject.getMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
					}

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					result.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					result.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					result.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	list queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(Vo -> Map, HashMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = result;
			}
			else if ( paramType.equals( "EgovMap" ) ) {
				/*
				 * [ EgovMap ] 사용의 경우
				 */
				// Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					egovResult = neosObject.getEgovMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					egovResult.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					egovResult.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					egovResult.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	list queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(EgovMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = egovResult;
			}
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "stringOrInteger" ) ) {
				errorLogic = true;
				logger.debug( "[forCloud_exp] [ERROR]	list queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 타입 에러 발생, parameter로 Integer 사용 불가능. " );
			}
		}
		String logMessage = errorLogic ? "[forCloud_exp] [LOG MESSAGE]	에러가 발생하였지만 기본값으로 쿼리를 실행합니다." : "[forCloud_exp] [LOG MESSAGE]	이 쿼리는 정상적으로 실행되었습니다.";
		// logger.debug( "[forCloud_exp] [LOG]	실행 쿼리 list queryId :	" + queryId + "	parma :	" + nullToString( p ) );
		// logger.debug( logMessage );
		return super.list( queryId, queryParam );
	}

	@Override
	public Object select ( String queryId ) {
		logger.debug( "[forCloud_exp] [ERROR]	queryId :	" + queryId );
		logger.debug( "[forCloud_exp] [ERROR MESSAGE]	이 메소드[Object select( String queryId )]는 지원하지 않습니다." );
		// Map<String, Object> databaseName = new HashMap<String, Object>( );
		/* Exception 추가 */
		return super.select( queryId );
	}

	@Override
	public Object select ( String queryId, Object p ) {
		// logger.debug( "[forCloud_exp] [LOG]	Object select ( String queryId, Object p ) 메소드를 시작합니다." );
		String paramType = "";
		try {
			paramType = this.getParameterType( p );
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "typeNULL" ) ) {
				// log 파리미터 형식을 확인할 수 없습니다. 파라미터 형식 확인 요망
				logger.debug( "[forCloud_exp] [ERROR]	select queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	파라미터 타입을 알 수 없습니다. 파라미터 점검 필요." );
			}
		}
		/* 기본 변수 정의 영역 */
		Object queryParam = null;
		String groupSeq = "";
		Map<String, Object> databaseName = new HashMap<String, Object>( );
		EgovMap egovResult = new EgovMap( );
		boolean errorLogic = false;
		try {
			if ( paramType.equals( "String" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Integer" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Vo" ) || paramType.equals( "HashMap" ) ) {
				/*
				 * [ Vo, HashMap ] 사용의 경우
				 */
				Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					result = neosObject.getMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					    ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					result.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					result.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					result.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	select queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(Vo -> Map, HashMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = result;
			}
			else if ( paramType.equals( "EgovMap" ) ) {
				/*
				 * [ EgovMap ] 사용의 경우
				 */
				// Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					egovResult = neosObject.getEgovMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					egovResult.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					egovResult.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					egovResult.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	select queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(EgovMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = egovResult;
			}
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "stringOrInteger" ) ) {
				errorLogic = true;
				logger.debug( "[forCloud_exp] [ERROR]	select queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 타입 에러 발생, parameter로 Integer 사용 불가능. " );
			}
		}
		String logMessage = errorLogic ? "[forCloud_exp] [LOG MESSAGE]	에러가 발생하였지만 기본값으로 쿼리를 실행합니다." : "[forCloud_exp] [LOG MESSAGE]	이 쿼리는 정상적으로 실행되었습니다.";
		// logger.debug( "[forCloud_exp] [LOG]	실행 쿼리 select queryId :	" + queryId + "	parma :	" + nullToString( p ) );
		// logger.debug( logMessage );
		return super.select( queryId, queryParam );
	}

	@Override
	public int update ( String queryId, Object p ) {
		// logger.debug( "[forCloud_exp] [LOG]	int update ( String queryId, Object p ) 메소드를 시작합니다." );
		String paramType = "";
		try {
			paramType = this.getParameterType( p );
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "typeNULL" ) ) {
				// log 파리미터 형식을 확인할 수 없습니다. 파라미터 형식 확인 요망
				logger.debug( "[forCloud_exp] [ERROR]	update queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	파라미터 타입을 알 수 없습니다. 파라미터 점검 필요." );
			}
		}
		/* 기본 변수 정의 영역 */
		Object queryParam = null;
		String groupSeq = "";
		Map<String, Object> databaseName = new HashMap<String, Object>( );
		EgovMap egovResult = new EgovMap( );
		boolean errorLogic = false;
		try {
			if ( paramType.equals( "String" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Integer" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Vo" ) || paramType.equals( "HashMap" ) ) {
				/*
				 * [ Vo, HashMap ] 사용의 경우
				 */
				Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					result = neosObject.getMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					result.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					result.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					result.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(Vo -> Map, HashMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = result;
			}
			else if ( paramType.equals( "EgovMap" ) ) {
				/*
				 * [ EgovMap ] 사용의 경우
				 */
				// Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					egovResult = neosObject.getEgovMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					egovResult.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					egovResult.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					egovResult.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	update queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(EgovMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = egovResult;
			}
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "stringOrInteger" ) ) {
				errorLogic = true;
				logger.debug( "[forCloud_exp] [ERROR]	update queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 타입 에러 발생, parameter로 Integer 사용 불가능. " );
			}
		}
		String logMessage = errorLogic ? "[forCloud_exp] [LOG MESSAGE]	에러가 발생하였지만 기본값으로 쿼리를 실행합니다." : "[forCloud_exp] [LOG MESSAGE]	이 쿼리는 정상적으로 실행되었습니다.";
		// logger.debug( "[forCloud_exp] [LOG]	실행 쿼리 update queryId :	" + queryId + "	parma :	" + nullToString( p ) );
		// logger.debug( logMessage );
		return super.update( queryId, queryParam );
	}

	@Override
	public int update ( String queryId ) {
		// logger.debug( "[forCloud_exp] [ERROR]	queryId :	" + queryId );
		// logger.debug( "[forCloud_exp] [ERROR MESSAGE]	이 메소드[int update( String queryId )]는 지원하지 않습니다." );
		return super.update( queryId );
	}

	@Override
	public Object insert ( String queryId ) {
		// logger.debug( "[forCloud_exp] [ERROR]	queryId :	" + queryId );
		// logger.debug( "[forCloud_exp] [ERROR MESSAGE]	이 메소드[insert update( String queryId )]는 지원하지 않습니다." );
		return super.insert( queryId );
	}

	@Override
	public Object insert ( String queryId, Object p ) {
		// logger.debug( "[forCloud_exp] [LOG]	Object insert ( String queryId, Object p ) 메소드를 시작합니다." );
		String paramType = "";
		try {
			paramType = this.getParameterType( p );
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "typeNULL" ) ) {
				// log 파리미터 형식을 확인할 수 없습니다. 파라미터 형식 확인 요망
				logger.debug( "[forCloud_exp] [ERROR]	insert queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	파라미터 타입을 알 수 없습니다. 파라미터 점검 필요." );
			}
		}
		/* 기본 변수 정의 영역 */
		Object queryParam = null;
		String groupSeq = "";
		Map<String, Object> databaseName = new HashMap<String, Object>( );
		EgovMap egovResult = new EgovMap( );
		boolean errorLogic = false;
		try {
			if ( paramType.equals( "String" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Integer" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Vo" ) || paramType.equals( "HashMap" ) ) {
				/*
				 * [ Vo, HashMap ] 사용의 경우
				 */
				Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					result = neosObject.getMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					result.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					result.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					result.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	insert queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(Vo -> Map, HashMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = result;
			}
			else if ( paramType.equals( "EgovMap" ) ) {
				/*
				 * [ EgovMap ] 사용의 경우
				 */
				// Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					egovResult = neosObject.getEgovMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					egovResult.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					egovResult.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					egovResult.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	insert queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(EgovMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = egovResult;
			}
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "stringOrInteger" ) ) {
				errorLogic = true;
				logger.debug( "[forCloud_exp] [ERROR]	insert queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 타입 에러 발생, parameter로 Integer 사용 불가능. " );
			}
		}
		String logMessage = errorLogic ? "[forCloud_exp] [LOG MESSAGE]	에러가 발생하였지만 기본값으로 쿼리를 실행합니다." : "[forCloud_exp] [LOG MESSAGE]	이 쿼리는 정상적으로 실행되었습니다.";
		// logger.debug( "[forCloud_exp] [LOG]	실행 쿼리 insert queryId :	" + queryId + "	parma :	" + nullToString( p ) );
		// logger.debug( logMessage );
		return super.insert( queryId, queryParam );
	}

	@Override
	public int delete ( String queryId ) {
		logger.debug( "[forCloud_exp] [ERROR]	delete :	" + queryId );
		logger.debug( "[forCloud_exp] [ERROR MESSAGE]	이 메소드[insert update( String queryId )]는 지원하지 않습니다." );
		return super.delete( queryId );
	}

	@Override
	public int delete ( String queryId, Object p ) {
		// logger.debug( "[forCloud_exp] [LOG]	int delete ( String queryId, Object p ) 메소드를 시작합니다." );
		String paramType = "";
		try {
			paramType = this.getParameterType( p );
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "typeNULL" ) ) {
				// log 파리미터 형식을 확인할 수 없습니다. 파라미터 형식 확인 요망
				logger.debug( "[forCloud_exp] [ERROR]	delete queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	파라미터 타입을 알 수 없습니다. 파라미터 점검 필요." );
			}
		}
		/* 기본 변수 정의 영역 */
		Object queryParam = null;
		String groupSeq = "";
		Map<String, Object> databaseName = new HashMap<String, Object>( );
		EgovMap egovResult = new EgovMap( );
		boolean errorLogic = false;
		try {
			if ( paramType.equals( "String" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Integer" ) ) {
				throw new Exception( "stringOrInteger" );
			}
			else if ( paramType.equals( "Vo" ) || paramType.equals( "HashMap" ) ) {
				/*
				 * [ Vo, HashMap ] 사용의 경우
				 */
				Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					result = neosObject.getMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					result.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					result.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					result.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	delete queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(Vo -> Map, HashMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = result;
			}
			else if ( paramType.equals( "EgovMap" ) ) {
				/*
				 * [ EgovMap ] 사용의 경우
				 */
				// Map<String, Object> result = new HashMap<String, Object>( );
				try {
					NeosObject neosObject = getGroupSeqForParam( p );
					egovResult = neosObject.getEgovMap( );
					groupSeq = neosObject.getGroupSeq( );

					if(groupSeq == null || groupSeq.equals("")) {
					  ExpInfo.InfoLog("not exists groupSeq - " + queryId);
                                            throw new Exception("not exists groupSeq - " + queryId);
                                        }

					databaseName = CloudConnetInfo.getParamMap( groupSeq );
					egovResult.put( "DB_NEOS", databaseName.get( "DB_NEOS" ) );
					egovResult.put( "DB_MOBILE", databaseName.get( "DB_MOBILE" ) );
					egovResult.put( "DB_EDMS", databaseName.get( "DB_EDMS" ) );
				}
				catch ( Exception e ) {
					errorLogic = true;
					logger.debug( "[forCloud_exp] [ERROR]	delete queryId :	" + queryId + "	parma :	" + nullToString( p ) );
					logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 자동 변환(EgovMap -> Map)도중 에러 발생, " + e.getMessage( ) );
				}
				queryParam = egovResult;
			}
		}
		catch ( Exception ex ) {
			if ( ex.getMessage( ).equals( "stringOrInteger" ) ) {
				errorLogic = true;
				logger.debug( "[forCloud_exp] [ERROR]	delete queryId :	" + queryId + "	parma :	" + nullToString( p ) );
				logger.debug( "[forCloud_exp] [ERROR MESSAGE]	클라우드 파라미터 타입 에러 발생, parameter로 Integer 사용 불가능. " );
			}
		}
		String logMessage = errorLogic ? "[forCloud_exp] [LOG MESSAGE]	에러가 발생하였지만 기본값으로 쿼리를 실행합니다." : "[forCloud_exp] [LOG MESSAGE]	이 쿼리는 정상적으로 실행되었습니다.";
		// logger.debug( "[forCloud_exp] [LOG]	실행 쿼리 delete queryId :	" + queryId + "	parma :	" + nullToString( p ) );
		// logger.debug( logMessage );
		return super.delete( queryId, queryParam );
	}

	/**
	 * 파라미터 타입 호출
	 */
	private String getParameterType ( Object p ) {
		if ( p == null ) {
			return "typeNull";
		}
		else if ( p.getClass( ).getName( ).equals( "java.util.HashMap" ) || p.getClass( ).getName( ).equals( "java.util.Map" ) || p.getClass( ).getName( ).equals( "java.util.LinkedHashMap" ) ) {
			return "HashMap";
		}
		else if ( p.getClass( ).getName( ).equals( "java.lang.String" ) ) {
			return "String";
		}
		else if ( p.getClass( ).getName( ).equals( "java.lang.Integer" ) ) {
			return "Integer";
		}
		else if ( p.getClass( ).getName( ).equals( "egovframework.rte.psl.dataaccess.util.EgovMap" ) ) {
			return "EgovMap";
		}
		else if ( p.getClass( ).getName( ).equals( "" ) ) {
			return "typeNull";
		}
		else {
			return "Vo";
		}
	}

	/**
	 * groupSeq 공통 호출 함수
	 */
	@SuppressWarnings ( "unchecked" )
	private NeosObject getGroupSeqForParam ( Object p ) {
		NeosObject result = new NeosObject( );
		try {
            // LoginVO loginVO = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
			/* Batch 실행 시 LoginVo가 없는데 위 소스를 사용하는경우 ERROR 로그 계속 출력됨. */
			LoginVO loginVO = CommonConvert.CommonGetEmpVO( );
			if ( !isNullOrEmpty( loginVO ) ) {
				/* loginVo에서 groupSeq 호출 */
				result.setGroupSeq( loginVO.getGroupSeq( ) );
				// logger.debug( "[forCloud_exp] [LOG]	사용자 로그인 세션을 확인하였습니다. 로그인 세션 사용이 가능합니다." );
			}
			if ( p.getClass( ).getName( ).equals( "java.util.Map" ) || p.getClass( ).getName( ).equals( "java.util.HashMap" ) || p.getClass( ).getName( ).equals( "java.util.LinkedHashMap" ) ) {
				if ( result.getGroupSeq( ).equals( "" ) ) {
					Map<String, Object> map = (Map<String, Object>) p;
					result.setGroupSeq( getGroupSeqForMap( map ) );
				}
				/* Map에서 groupSeq 호출 */
				Map<String, Object> map = (Map<String, Object>) p;
				result.setMap( map );
				// logger.debug( "[forCloud_exp] [LOG]	Map 객체를 사용하여 groupSeq를 조회합니다." );
			}
			else if ( p.getClass( ).getName( ).equals( "egovframework.rte.psl.dataaccess.util.EgovMap" ) ) {
				/* egovMap에서 group */
				EgovMap egovMap = (EgovMap) p;
				result.setParamType( "egovMap" );
				result.setEgovMap( egovMap );
				result.setGroupSeq( getGroupSeqForEgovMap( egovMap ) );
				// logger.debug( "[forCloud_exp] [LOG]	EgovMap 객체를 사용하여 groupSeq를 조회합니다." );
			}
			else {
				/* VO에서 groupSeq 호출 */
				if ( result.getGroupSeq( ).equals( "" ) ) {
					result.setGroupSeq( getGroupSeqForVO( p ) );
				}
				// logger.debug( "[forCloud_exp] [LOG]	Vo 객체를 사용하여 groupSeq를 조회합니다." );
				result.setMap( objectToMap( p ) );
			}
		}
		catch ( Exception e ) {
			try{
				if ( p.getClass( ).getName( ).equals( "java.util.Map" ) || p.getClass( ).getName( ).equals( "java.util.HashMap" ) || p.getClass( ).getName( ).equals( "java.util.LinkedHashMap" ) ) {
					if ( result.getGroupSeq( ).equals( "" ) ) {
						Map<String, Object> map = (Map<String, Object>) p;
						result.setGroupSeq( getGroupSeqForMap( map ) );
					}
					/* Map에서 groupSeq 호출 */
					Map<String, Object> map = (Map<String, Object>) p;
					result.setMap( map );
					// logger.debug( "[forCloud_exp] [LOG]	Map 객체를 사용하여 groupSeq를 조회합니다." );
				}
				else if ( p.getClass( ).getName( ).equals( "egovframework.rte.psl.dataaccess.util.EgovMap" ) ) {
					/* egovMap에서 group */
					EgovMap egovMap = (EgovMap) p;
					result.setParamType( "egovMap" );
					result.setEgovMap( egovMap );
					result.setGroupSeq( getGroupSeqForEgovMap( egovMap ) );
					// logger.debug( "[forCloud_exp] [LOG]	EgovMap 객체를 사용하여 groupSeq를 조회합니다." );
				}
				else {
					/* VO에서 groupSeq 호출 */
					if ( result.getGroupSeq( ).equals( "" ) ) {
						result.setGroupSeq( getGroupSeqForVO( p ) );
					}
					// logger.debug( "[forCloud_exp] [LOG]	Vo 객체를 사용하여 groupSeq를 조회합니다." );
					result.setMap( objectToMap( p ) );
				}
			}catch( Exception e2 ){
				result.setGroupSeq( "" );
				result.setMap( new HashMap<String, Object>( ) );
				logger.debug( "[forCloud_exp] [SYSTEM ERROR]	파라미터에서 groupSeq를 조회하는 도중 오류가 발생하였습니다." );
				logger.debug( "[forCloud_exp] [SYSTEM ERROR MESSAGE]	" + e2.getMessage( ) );
			}
		}
		return result;
	}

	/**
	 * VO를 map으로 형변환
	 */
	private Map<String, Object> objectToMap ( Object p ) {
		Map<String, Object> result = new HashMap<>( );
		try {
			/* 필드 찾기 */
			Field[] field = p.getClass( ).getDeclaredFields( );
			for ( Field item : field ) {
				item.setAccessible( true );
				String itemText = item.get( p ) == null ? "" : item.get( p ).toString( );
				result.put( item.getName( ), itemText );
			}
		}
		catch ( Exception e ) {
			logger.debug( "[forCloud_exp] [SYSTEM ERROR]	Vo를 Map으로 변환하는도중 오류가 발생하였습니다." );
			logger.debug( "[forCloud_exp] [SYSTEM ERROR MESSAGE]	" + e.getMessage( ) );
			result = new HashMap<>( );
		}
		return result;
	}

	/**
	 * VO에서 그룹시퀀스 찾기
	 */
	private String getGroupSeqForVO ( Object param ) {
		String groupSeq = "";
		if ( param == null ) {
			// logger.debug( "[forCloud_exp] [LOG ]	수신처의 Vo가 NULL입니다. : " );
			return groupSeq;
		}
		try {
			/* 필드 찾기 */
			Field[] field = param.getClass( ).getDeclaredFields( );
			for ( Field item : field ) {
				item.setAccessible( true );
				if ( item.getName( ).toUpperCase( ).equals( "GROUPSEQ" ) ) {
					groupSeq = item.get( param ).toString( );
				}
				else if ( item.getName( ).toUpperCase( ).equals( "GROUP_SEQ" ) ) {
					if ( groupSeq.equals( "" ) ) {
						groupSeq = item.get( param ).toString( );
					}
				}
			}
			if ( !groupSeq.equals( "" ) ) {
				return groupSeq;
			}
		}
		catch ( Exception e ) {
			logger.debug( "[forCloud_exp] [ERROR]	Vo에서 groupSeq를 확인하지 못하였습니다. groupSeq 필드 확인 필요. Vo 이름 : " + param.getClass( ).getName( ) );
			logger.debug( "[forCloud_exp] [ERROR MESSAGE]	" + e.getMessage( ) );
			groupSeq = "";
		}
		return groupSeq;
	}

	/**
	 * egovMap에서 그룹시퀀스 찾기
	 */
	private String getGroupSeqForEgovMap ( EgovMap param ) {
		String groupSeq = "";
		try {
			if ( param.get( "groupSeq" ) != null ) {
				groupSeq = param.get( "groupSeq" ).toString( );
			}
			else if ( param.get( "GROUP_SEQ" ) != null ) {
				groupSeq = param.get( "GROUP_SEQ" ).toString( );
			}
			else if ( param.get( "group_seq" ) != null ) {
				groupSeq = param.get( "group_seq" ).toString( );
			}
			else if ( param.get( "groupseq" ) != null ) {
				groupSeq = param.get( "groupseq" ).toString( );
			}
			else {
				groupSeq = "";
			}
		}
		catch ( Exception e ) {
			logger.debug( "[forCloud_exp] [ERROR]	EgovMap에서 groupSeq를 확인하지 못하습니다. groupSeq 필드 확인 필요." );
			logger.debug( "[forCloud_exp] [ERROR MESSAGE]	" + e.getMessage( ) );
			groupSeq = "";
		}
		return groupSeq;
	}

	/**
	 * 맵에서 그룹시퀀스 찾기
	 */
	private String getGroupSeqForMap ( Map<String, Object> map ) {
		String groupSeq = "";
		if(map.containsKey("groupSeq")){
			groupSeq = map.get("groupSeq") + "";
		}
		else if(map.containsKey("GROUP_SEQ")){
			groupSeq = map.get("GROUP_SEQ") + "";
		}
		else if(map.containsKey("group_seq")){
			groupSeq = map.get("group_seq") + "";
		}
		else if(map.containsKey("groupseq")){
			groupSeq = map.get("groupseq") + "";
		} else {
			groupSeq = "";
		}

		if ( groupSeq.equals( "" ) ) {
			logger.debug( "[forCloud_exp] [ERROR]	Map에서 groupSeq를 확인하지 못하습니다. groupSeq 필드 확인 필요." );
		}
		return groupSeq;
	}

	/**
	 * loginVO 생성 가능한지 검증
	 * 생성 실패 : true
	 * 생성 성공 : false
	 */
	private boolean isNullOrEmpty ( LoginVO loginVO ) {
		if ( loginVO == null ) {
			return true;
		}
		else {
			if ( loginVO.getGroupSeq( ) == null || loginVO.getGroupSeq( ).equals( "" ) ) {
				return true;
			}
			else {
				return false;
			}
		}
	}

	private class NeosObject {

		Map<String, Object> map;
		EgovMap egovMap;
		String groupSeq;
		@SuppressWarnings ( "unused" )
		String paramType;

		NeosObject ( ) {
			groupSeq = "";
			paramType = "";
			map = new HashMap<String, Object>( );
		}

		public String getGroupSeq ( ) {
			return this.groupSeq;
		}

		public void setGroupSeq ( String groupSeq ) {
			this.groupSeq = groupSeq;
		}

		public Map<String, Object> getMap ( ) {
			return this.map;
		}

		public void setEgovMap ( EgovMap egovMap ) {
			this.egovMap = egovMap;
		}

		public EgovMap getEgovMap ( ) {
			return this.egovMap;
		}

		public void setMap ( Map<String, Object> map ) {
			this.map = map;
		}

		@SuppressWarnings ( "unused" )
		public String getParamType ( ) {
			return this.groupSeq;
		}

		public void setParamType ( String paramType ) {
			this.paramType = paramType;
		}
	}
}
