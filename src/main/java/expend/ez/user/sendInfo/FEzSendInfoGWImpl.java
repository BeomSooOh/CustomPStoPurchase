package expend.ez.user.sendInfo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.logger.CommonLogger;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ez.common.EzCommon;


@Service ( "FEzSendInfoGW" )
public class FEzSendInfoGWImpl implements FEzSendInfoGW {

	@Resource ( name = "FEzSendInfoGWDAO" )
	private FEzSendInfoGWDAO GWSaveDAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "EzCommon" )
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */

	@Override
	public Map<String, Object> EzMasterInfoInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO( );
			map.put( "compSeq", loginVo.getCompSeq( ) );
			map.put( "erpCompSeq", loginVo.getErpCoCd( ) );
			map.put( "empSeq", loginVo.getUniqId( ) );
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzMasterInfoInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzErpMasterInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO( );
			/* 기본값 지정 */
			map.put( "GW_ID", loginVo.getUniqId( ) );
			map.put( "GW_STATE", "" );
			map.put( "LANGKIND", "KOR" );
			if ( map.get( "PARTRATE" ).equals( "" ) ) {
				map.put( "PARTRATE", "0.00" );
			}
			if ( map.get( "PAYBASEAMT" ).equals( "" ) ) {
				map.put( "PAYBASEAMT", "0.00" );
			}
			if ( map.get( "RESOLAMT" ).equals( "" ) ) {
				map.put( "RESOLAMT", "0.00" );
			}
			if ( map.get( "EXTTAX" ).equals( "" ) ) {
				map.put( "EXTTAX", "0.00" );
			}
			if ( map.get( "ACCREGAMT" ).equals( "" ) ) {
				map.put( "ACCREGAMT", "0.00" );
			}
			if ( map.get( "COURTAMT" ).equals( "" ) ) {
				map.put( "COURTAMT", "0.00" );
			}
			if ( map.get( "CHARGE" ).equals( "" ) ) {
				map.put( "CHARGE", "0.00" );
			}
			if ( map.get( "TRNSAMT" ).equals( "" ) ) {
				map.put( "TRNSAMT", "0.00" );
			}
			if ( map.get( "GISU_SQ" ).equals( "" ) ) {
				map.put( "GISU_SQ", "0.00" );
			}
			if ( map.get( "NDEP_AM" ).equals( "" ) ) {
				map.put( "NDEP_AM", "0.00" );
			}
			if ( map.get( "INAD_AM" ).equals( "" ) ) {
				map.put( "INAD_AM", "0.00" );
			}
			if ( map.get( "INTX_AM" ).equals( "" ) ) {
				map.put( "INTX_AM", "0.00" );
			}
			if ( map.get( "RSTX_AM" ).equals( "" ) ) {
				map.put( "RSTX_AM", "0.00" );
			}
			if ( map.get( "WD_AM" ).equals( "" ) ) {
				map.put( "WD_AM", "0.00" );
			}
			if ( map.get( "BG_SQ" ).equals( "" ) ) {
				map.put( "BG_SQ", "0.00" );
			}
			if ( map.get( "HIFE_AM" ).equals( "" ) ) {
				map.put( "HIFE_AM", "0.00" );
			}
			if ( map.get( "NAPE_AM" ).equals( "" ) ) {
				map.put( "NAPE_AM", "0.00" );
			}
			if ( map.get( "DDCT_AM" ).equals( "" ) ) {
				map.put( "DDCT_AM", "0.00" );
			}
			if ( map.get( "NOIN_AM" ).equals( "" ) ) {
				map.put( "NOIN_AM", "0.00" );
			}
			if ( map.get( "WD_AM2" ).equals( "" ) ) {
				map.put( "WD_AM2", "0.00" );
			}
			if ( map.get( "HINCOME_SQ" ).equals( "" ) ) {
				map.put( "HINCOME_SQ", "0.00" );
			}
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzErpMasterInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzErpSlaveInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO( );
			/* 기본값 지정 */
			map.put( "GW_ID", loginVo.getUniqId( ) );
			map.put( "GW_STATE", "" );
			map.put( "LANGKIND", "KOR" );
			if ( map.get( "UNITCOST" ).equals( "" ) ) {
				map.put( "UNITCOST", "0.00" );
			}
			if ( map.get( "SUPCOST" ).equals( "" ) ) {
				map.put( "SUPCOST", "0.00" );
			}
			if ( map.get( "EXTTAX" ).equals( "" ) ) {
				map.put( "EXTTAX", "0.00" );
			}
			if ( map.get( "TOTPURCHAMT" ).equals( "" ) ) {
				map.put( "TOTPURCHAMT", "0.00" );
			}
			if ( map.get( "GISU_SQ" ).equals( "" ) ) {
				map.put( "GISU_SQ", "0.00" );
			}
			if ( map.get( "PAYAMT" ).equals( "" ) ) {
				map.put( "PAYAMT", "0.00" );
			}
			if ( EgovStringUtil.isNullToString( map.get( "ITEMNAME" ) ).equals( "" ) ) {
				map.put( "ITEMNAME", "" );
			}
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzErpSlaveInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzGwParamsInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			@SuppressWarnings ( "unused" )
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO( );
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzGwParamsInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzGwMasterInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzGwMasterInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzGwSlaveInsert ( Map<String, Object> map ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			/* null 값 주기 */
			Iterator<String> keys = map.keySet( ).iterator( );
			while ( keys.hasNext( ) ) {
				String key = keys.next( );
				if ( map.get( key ).equals( "" ) ) {
					map.put( key, null );
				}
			}
			resultMap = GWSaveDAO.EzGwSlaveInsert( map );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			e.printStackTrace( );
		}
		return resultMap;
	}
}
