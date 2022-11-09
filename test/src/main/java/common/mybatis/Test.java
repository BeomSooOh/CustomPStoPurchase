package common.mybatis;

import java.util.List;
import java.util.Map;

public class Test {

	@SuppressWarnings("unchecked")
	public static boolean isArrayListEmpty(Object o) {
		/* http://stove99.tistory.com/73 */
		/* <if test="@common.mybatis.Test@isArrayListEmpty(eTaxSendList)"></if> */

		if (o == null) {
			return false;
		}
		else {
			if (o.getClass().getName().equals("java.util.ArrayList")) {
				if (((List<Map<String, Object>>) o).size() > 0) {
					return true;
				}
				else {
					return false;
				}
			}
			else {
				return false;
			}
		}
	}

	public static boolean isArrayListEmptyRevers(Object o) {
		/* http://stove99.tistory.com/73 */
		/* <if test="@common.mybatis.Test@isArrayListEmptyRevers(eTaxSendList)"></if> */

		if (o == null) {
			return true;
		}
		else {
			if (o.getClass().getName().equals("java.util.ArrayList")) {
				if (((List<Map<String, Object>>) o).size() > 0) {
					return false;
				}
				else {
					return true;
				}
			}
			else {
				return true;
			}
		}
	}
}