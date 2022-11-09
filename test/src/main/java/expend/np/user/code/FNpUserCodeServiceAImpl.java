package expend.np.user.code;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

//import org.omg.SecurityLevel2.TargetCredentials;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserCodeServiceA" )
public class FNpUserCodeServiceAImpl implements FNpUserCodeService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserCodeServiceADAO" )
	private FNpUserCodeServiceADAO dao;

	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	@Override
	public ResultVO GetCommonCode ( Map<String, Object> params, ConnectionVO conVo ) {
		ResultVO result = new ResultVO( );
		try {
			String code = "";
			if ( params.get( "code" ) != null ) {
				code = params.get( "code" ).toString( );
			}
			else {
				throw new Exception( "not found parameter 'code'" );
			}
			if ( code.equals( "Card" ) ) {
				/* 법인카드 승인내역 코드 조회 */
			}
			else {
				/* 찾을 수 없는 공통 코드 오류 반환 */
			}
			Map<String, Object> param = new HashMap<String, Object>( );
			param = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) );
		}
		catch ( Exception ex ) {
			result.setFail( "code 확인 불가능.", ex );
		}
		return result;
	}

	public ResultVO UpdateInterfaceInfo(Map<String, Object> params){
		ResultVO result = new ResultVO( );
		try {
			/* 필수 파라미터 체크 - consDocSeq */
			if( params.get("resDocSeq") == null || CommonConvert.CommonGetStr(params.get("resDocSeq")).equals( "" ) ){
				result.setFail( "resDocSeq가 누락되었습니다." );
			}
			/* 결의서에 외부시스템 정보 조회 */

			for(Map<String, Object> tInterfaceData : dao.SelectInterfaceInfoIntoRes( params ) ){
				tInterfaceData.put( "sendYN", params.get( "sendYN" ).toString( ) );
				tInterfaceData.put( "groupSeq", params.get( "groupSeq" ).toString( ) );
				if( CommonConvert.CommonGetStr(tInterfaceData.get("sendYN")).equals( "N" ) ){
					tInterfaceData.put( "resDocSeq", "" );
					tInterfaceData.put( "tradeSeq", "" );
				}

				result = dao.UpdateInterfaceInfo( tInterfaceData );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "code 확인 불가능.", ex );
		}
		return result;
	}
}
