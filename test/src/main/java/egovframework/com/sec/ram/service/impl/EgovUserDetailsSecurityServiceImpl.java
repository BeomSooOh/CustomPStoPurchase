package egovframework.com.sec.ram.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import egovframework.com.cmm.service.EgovUserDetailsService;
import egovframework.com.sec.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.string.EgovObjectUtil;


@SuppressWarnings ( "deprecation" )
public class EgovUserDetailsSecurityServiceImpl extends AbstractServiceImpl implements EgovUserDetailsService {

	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 *
	 * @return Object - 사용자 ValueObject
	 */
	@Override
    public Object getAuthenticatedUser ( ) {
		return RequestContextHolder.getRequestAttributes( ).getAttribute( "loginVO", RequestAttributes.SCOPE_SESSION );
	}

	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 *
	 * @return Object - 사용자 ValueObject
	 */
	public void resetUserDetail ( ) {
		// do nothing
	}

	/**
	 * 인증된 사용자의 권한 정보를 가져온다. 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
	 *
	 * @return List - 사용자 권한정보 목록
	 */
	@Override
    public List<String> getAuthorities ( ) {
		List<String> listAuth = new ArrayList<String>( );
		SecurityContext context = SecurityContextHolder.getContext( );
		Authentication authentication = context.getAuthentication( );
		if ( EgovObjectUtil.isNull( authentication ) ) {
			// log.debug("## authentication object is null!!");
			return null;
		}
		GrantedAuthority[] authorities = authentication.getAuthorities( );
		for ( int i = 0; i < authorities.length; i++ ) {
			listAuth.add( authorities[i].getAuthority( ) );
			// log.debug("## EgovUserDetailsHelper.getAuthorities : Authority is " + authorities[i].getAuthority());
		}
		return listAuth;
	}

	/**
	 * 인증된 사용자 여부를 체크한다.
	 *
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
	 */
	@Override
    public Boolean isAuthenticated ( ) {

		Object o = getAuthenticatedUser();

		return o != null;

		//		SecurityContext context = SecurityContextHolder.getContext( );
		//		Authentication authentication = context.getAuthentication( );
		//		if ( EgovObjectUtil.isNull( authentication ) ) {
		//			// log.debug("## authentication object is null!!");
		//			return Boolean.FALSE;
		//		}
		//		String username = authentication.getName( );
		//		if ( username.equals( "roleAnonymous" ) ) {
		//			// log.debug("## username is " + username);
		//			return Boolean.FALSE;
		//		}
		//		Object principal = authentication.getPrincipal( );
		//		return Boolean.valueOf( !EgovObjectUtil.isNull( principal ) );
		//return getAuthenticatedUser( ) != null ? true : false;
	}

	@Override
	public void reSetAuthenticatedUser ( ) {
		SecurityContext context = SecurityContextHolder.getContext( );
		Authentication authentication = context.getAuthentication( );
		if ( EgovObjectUtil.isNull( authentication ) ) {
			// log.debug("## authentication object is null!!");
			return;
		}
		Object principal = authentication.getPrincipal( );
		if ( principal instanceof EgovUserDetails ) {
			// log.debug("## EgovUserDetailsHelper.getAuthenticatedUser : AuthenticatedUser is " + details.getUsername());
			EgovUserDetails details = (EgovUserDetails) principal;
			details.setEgovUserVO( null );
			context.setAuthentication( null );
		}
		return;
	}
}
