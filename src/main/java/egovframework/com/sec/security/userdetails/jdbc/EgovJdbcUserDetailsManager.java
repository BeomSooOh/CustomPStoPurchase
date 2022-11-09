package egovframework.com.sec.security.userdetails.jdbc;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContextException;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UsernameNotFoundException;
import org.springframework.security.userdetails.hierarchicalroles.RoleHierarchy;
import org.springframework.security.userdetails.jdbc.JdbcUserDetailsManager;

import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.sec.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.string.EgovObjectUtil;


/**
 * JdbcUserDetailsManager 클래스 재정의
 *
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon    최초 생성
 *
 *      </pre>
 *
 *      branch
 */
public class EgovJdbcUserDetailsManager extends JdbcUserDetailsManager {

	private EgovUserDetails userDetails = null;
	private EgovUsersByUsernameMapping usersByUsernameMapping;
	private AuthoritiesByUsernameMapping authoritiesByUsernameMapping;
	private String mapClass;
	private RoleHierarchy roleHierarchy = null;
	private String usersByUsernameQueryOracle;
	private String authoritiesByUsernameQueryOracle;
	private String cdCompany;

	/**
	 * 사용자 테이블의 쿼리 조회 컬럼과 세션에서 사용할 사용자 VO와 메핑 할 클래스를 지정한다.
	 *
	 * @param mapClass
	 *            String
	 */
	public void setMapClass ( String mapClass ) {
		this.mapClass = mapClass;
	}

	/**
	 * Role Hierarchy를 지원한다. (org.springframework.security.userdetails.hierarchicalroles.RoleHierarchyImpl)
	 *
	 * @param roleHierarchy
	 *            RoleHierarchy
	 */
	public void setRoleHierarchy ( RoleHierarchy roleHierarchy ) {
		this.roleHierarchy = roleHierarchy;
	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.security.userdetails.jdbc.JdbcUserDetailsManager#initDao()
	 */
	@Override
	protected void initDao ( ) throws ApplicationContextException {
		super.initDao( );
		try {
			initMappingSqlQueries( );
		}
		catch ( ClassNotFoundException e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.ClassNotFoundException : " + e.toString( ), e );
		}
		catch ( NoSuchMethodException e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.NoSuchMethodException : " + e.toString( ), e );
		}
		catch ( InstantiationException e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.InstantiationException : " + e.toString( ), e );
		}
		catch ( IllegalAccessException e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.IllegalAccessException : " + e.toString( ), e );
		}
		catch ( InvocationTargetException e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.InvocationTargetException : " + e.toString( ), e );
		}
		catch ( Exception e ) {
			logger.error( "EgovJdbcUserDetailsManager.initDao.Exception : " + e.toString( ), e );
		}
	}

	/**
	 * jdbc-user-service의 usersByUsernameQuery 사용자조회 쿼리와 authoritiesByUsernameQuery 권한조회 쿼리를 이용하여 정보를 저장한다.
	 */
	private void initMappingSqlQueries ( ) throws InvocationTargetException, IllegalAccessException, InstantiationException, NoSuchMethodException, ClassNotFoundException, Exception {
		//현재 사이트 정보를 DB에서 읽어와서 셋팅한다.
		setCdCompany( );
		//금투 코드 : 10014
		//임시로 개발서버 코드 : 10000
		//if(this.cdCompany.equals("10014") || this.cdCompany.equals("10000")){
		if ( Globals.DB_TYPE.toUpperCase( ).equals( "ORACLE" ) ) {
			//KOFIA
			setUsersByUsernameQuery( getUsersByUsernameQueryOracle( ) );
			setAuthoritiesByUsernameQuery( getAuthoritiesByUsernameQueryOracle( ) );
		}
		else {
			//OTHER
			setUsersByUsernameQuery( getUsersByUsernameQuery( ) );
			setAuthoritiesByUsernameQuery( getAuthoritiesByUsernameQuery( ) );
		}
		//System.out.println("############################ getDataSource() : " + getDataSource());
		authoritiesByUsernameMapping = new AuthoritiesByUsernameMapping( getDataSource( ) );
		//System.out.println( "## EgovJdbcUserDetailsManager query : " + getUsersByUsernameQuery( ) );
		Class<?> clazz = EgovObjectUtil.loadClass( this.mapClass );
		Constructor<?> constructor = null;
		Object[] params = null;
		//if(  cdCompany.equals("10014")  || cdCompany.equals("10000")){
		if ( cdCompany.equals( "Y" ) ) {
			constructor = clazz.getConstructor( new Class[] { DataSource.class, String.class } );
			params = new Object[] { getDataSource( ), getUsersByUsernameQuery( ) };
		}
		else {
			constructor = clazz.getConstructor( new Class[] { DataSource.class, String.class, String.class } );
			params = new Object[] { getDataSource( ), getUsersByUsernameQuery( ), cdCompany };
		}
		this.usersByUsernameMapping = (EgovUsersByUsernameMapping) constructor.newInstance( params );
	}

	private void setCdCompany ( ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		this.cdCompany = "N";
		try {
			conn = getDataSource( ).getConnection( );
			//pstmt = conn.prepareStatement("SELECT CODE_NM FROM COMTCCMMNDETAILCODE WHERE CODE_ID = 'S_CMP' AND CODE = 'SITE_CODE' AND USE_AT = 'Y'");
			pstmt = conn.prepareStatement( "SELECT CODE_NM FROM COMTCCMMNDETAILCODE WHERE CODE_ID = 'NEW' AND CODE = 'AUTHOR' AND USE_AT = 'Y'" );
			rs = pstmt.executeQuery( );
			while ( rs.next( ) ) {
				String cdCompany = rs.getString( 1 );
				this.cdCompany = cdCompany;
			}
		}
		catch ( SQLException e ) {
			logger.error( e.getMessage( ) );
		}
		finally {
			if ( conn != null ) {
				try {
					rs.close( );
				}
				catch ( Exception e ) {
					logger.error(e);
				}
				finally {
					rs = null;
				}
				try {
					pstmt.close( );
				}
				catch ( Exception e ) {
					logger.error(e);
				}
				finally {
					pstmt = null;
				}
				try {
					conn.close( );
				}
				catch ( Exception e ) {
					logger.error(e);
				}
				finally {
					conn = null;
				}
			}
		}
	}

	/**
	 * JdbcDaoImpl 클래스의 loadUsersByUsername 메소드 재정의 사용자명(또는 ID)로 EgovUserDetails의 정보를 조회하여 리스트 형식으로 저장한다.
	 */
	@SuppressWarnings ( "unchecked" )
	@Override
	protected List<String> loadUsersByUsername ( String username ) {
		//System.out.println( "################loadUsersByUsername()_start##########################" );
		//		System.out.println("username : " + username);
		List<String> list = null;
		list = usersByUsernameMapping.execute( username );
		//System.out.println( "################loadUsersByUsername()_end##########################" );
		return list;
	}

	/**
	 * JdbcDaoImpl 클래스의 loadUsersByUsername 메소드 재정의 사용자명(또는 ID)로 EgovUserDetails의 정보를 조회한다.
	 *
	 * @param username
	 *            String
	 * @return EgovUserDetails
	 * @throws UsernameNotFoundException
	 * @throws DataAccessException
	 */
	@SuppressWarnings ( { "rawtypes", "unchecked" } )
	@Override
	public EgovUserDetails loadUserByUsername ( String username ) throws UsernameNotFoundException, DataAccessException {
		List<?> users = loadUsersByUsername( username );
		if ( users.size( ) == 0 ) {
			throw new UsernameNotFoundException( messages.getMessage( "JdbcDaoImpl.notFound", new Object[] { username }, "Username {0} not found" ), username );
		}
		Object obj = users.get( 0 );
		this.userDetails = (EgovUserDetails) obj;
		Set<String> dbAuthsSet = new HashSet<String>( );
		LoginVO egovUserVO = (LoginVO) userDetails.getEgovUserVO( );
		//if (enableAuthorities) {
		//if(  cdCompany.equals("10014")  || cdCompany.equals("10000")){
		List authList = null;
		if ( cdCompany.equals( "Y" ) ) {
			authList = authoritiesByUsernameMapping.execute( this.userDetails.getUsername( ) );
		}
		else {
			authList = authoritiesByUsernameMapping.execute( this.userDetails.getUsername( ), egovUserVO.getOrgnztId( ) );
		}
		if ( authList != null ) {
			dbAuthsSet.addAll( authList );
		}
		//}
		//        System.out.println("######## authList : " + authList);
		List<String> dbAuths = new ArrayList<String>( dbAuthsSet );
		addCustomAuthorities( this.userDetails.getUsername( ), dbAuths );
		if ( dbAuths.size( ) == 0 ) {
			throw new UsernameNotFoundException( messages.getMessage( "EgovJdbcUserDetailsManager.noAuthority", new Object[] { username }, "User {0} has no GrantedAuthority" ), username );
		}
		GrantedAuthority[] arrayAuths = (GrantedAuthority[]) dbAuths.toArray( new GrantedAuthority[dbAuths.size( )] );
		// RoleHierarchyImpl 에서 저장한 Role Hierarchy 정보가 저장된다.
		GrantedAuthority[] authorities = roleHierarchy.getReachableGrantedAuthorities( arrayAuths );
		// JdbcDaoImpl 클래스의 createUserDetails 메소드 재정의
		return new EgovUserDetails( this.userDetails.getUsername( ), this.userDetails.getPassword( ), this.userDetails.isEnabled( ), true, true, true, authorities, this.userDetails.getEgovUserVO( ) );
	}

	/**
	 * 인증된 사용자 이름으로 사용자정보(EgovUserDetails)를 가져온다.
	 *
	 * @return EgovUserDetails
	 * @throws UsernameNotFoundException
	 * @throws DataAccessException
	 */
	public EgovUserDetails getAuthenticatedUser ( ) throws UsernameNotFoundException, DataAccessException {
		//System.out.println( "################getAuthenticatedUser()##########################" );
		return loadUserByUsername( SecurityContextHolder.getContext( ).getAuthentication( ).getName( ) );
	}

	public void setUsersByUsernameQueryOracle ( String usersByUsernameQueryOracle ) {
		this.usersByUsernameQueryOracle = usersByUsernameQueryOracle;
	}

	public String getUsersByUsernameQueryOracle ( ) {
		return this.usersByUsernameQueryOracle;
	}

	public void setAuthoritiesByUsernameQueryOracle ( String authoritiesByUsernameQueryOracle ) {
		this.authoritiesByUsernameQueryOracle = authoritiesByUsernameQueryOracle;
	}

	public String getAuthoritiesByUsernameQueryOracle ( ) {
		return this.authoritiesByUsernameQueryOracle;
	}

	@SuppressWarnings ( "rawtypes" )
	private class AuthoritiesByUsernameMapping extends MappingSqlQuery {

		protected AuthoritiesByUsernameMapping ( DataSource ds ) {
			//super(ds, authoritiesByUsernameQuery);
			super( ds, getAuthoritiesByUsernameQuery( ) );
			declareParameter( new SqlParameter( Types.VARCHAR ) );
			//if( !cdCompany.equals("10014") && !cdCompany.equals("10000")){
			if ( cdCompany.equals( "N" ) ) {
				declareParameter( new SqlParameter( Types.VARCHAR ) );
			}
			compile( );
		}

		protected Object mapRow ( ResultSet rs, int rownum ) throws SQLException {
			@SuppressWarnings("unused")
			int backRownum = rownum;
			String roleName = rs.getString( 1 );
			GrantedAuthorityImpl authority = new GrantedAuthorityImpl( roleName );
			return authority;
		}
	}
}
