/**
  * @FileName : MapUtil.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package cmm.util;

import java.util.Iterator;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


/**
 *   * @FileName : MapUtil.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class MapUtil {

	public static boolean hasKey ( Map<String, Object> map, String key ) {
		String keyAttribute = null;
		Iterator<String> itr = map.keySet( ).iterator( );
		while ( itr.hasNext( ) ) {
			keyAttribute = (String) itr.next( );
			if ( keyAttribute.equals( key ) ) {
				return true;
			}
		}
		return false;
	}

	public static boolean hasValue ( Map<String, Object> map, String key ) {
		if ( !(CommonConvert.CommonGetStr( map.get( key ) ).equals( "" )) ) {
			return true;
		}
		return false;
	}

	public static boolean hasParameters ( Map<String, Object> map, String[] keys ) {
		/* ex) String[] keys = { "CO_CD", "Y", "LANG_KIND", "N" }; */
		for ( int i = 0; i < keys.length; i += 2 ) {
			if ( !MapUtil.hasKey( map, keys[i] ) ) {
				if ( keys[i].equals( "CO_CD" ) ) {
					/* iCUBE 회사코드인 경우 */
					if ( MapUtil.hasKey( map, commonCode.ERPCOMPSEQ ) ) {
						map.put( keys[i], map.get( commonCode.ERPCOMPSEQ ) );
					}
					else {
						return false;
					}
				}
				else if ( keys[i].equals( "P_CO_CD" ) ) {
					if ( MapUtil.hasKey( map, commonCode.ERPCOMPSEQ ) ) {
						map.put( keys[i], map.get( commonCode.ERPCOMPSEQ ) );
					}
					else {
						return false;
					}
				}
				else if ( keys[i].equals( "LANGKIND" ) ) {
					map.put( keys[i], "KOR" );
				}
				else {
					return false;
				}
			}
			if ( keys[i + 1].equals( commonCode.EMPTYYES ) ) {
				if ( !MapUtil.hasValue( map, keys[i] ) ) {
					return false;
				}
			}
		}
		return true;
	}
}