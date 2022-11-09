/**
  * @FileName : FAdvInterServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.adv;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

/**
 *   * @FileName : FAdvInterServiceIImpl.java   * @Project : BizboxA_exp
 *   * @변경이력 :   * @프로그램 설명 : 비영리 전자결재 연동 프로세스   
 */
@Service("FAdvInterServiceI")
public class FAdvInterServiceIImpl implements FAdvInterService {
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	/* 변수정의 - DAO */
	@Resource(name = "FAdvInterServiceADAO")
	private FAdvInterServiceADAO aDao;
	@Resource(name = "FAdvInterServiceIDAO")
	private FAdvInterServiceIDAO iDao;
	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo; /* 공통사용 정보 */

	@Override
	public String advMethod001 ( Map<String, Object> params ) throws Exception {
		String resultCode = "Y";

		if( CommonConvert.NullToString( params.get( "processId" ) ).equals( "EXNPRESI" ) ){
			/* 법인카드 승인내역 건 조회 */
			cmLog.CommonSetInfo( "               [EXNP-ADV] CALL CARD TR INFO");
			List<Map<String, Object>> result = aDao.SelectResCMSCardTradeInfo( params );
			ConnectionVO conVo = new ConnectionVO( );
			if(result.size( ) > 0){
				 conVo = cmInfo.CommonGetConnectionInfo(
						CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
						CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ))
				);
			}
			String sConVo = new ObjectMapper().writeValueAsString( conVo );
			String docStatus = CommonConvert.NullToString( params.get( "docStatus" ) );
			cmLog.CommonSetInfo( "               [EXNP-ADV] CALL HAN ASEAN CUST. result.size : " + result.size( ));
			cmLog.CommonSetInfo( "               [EXNP-ADV ] conVo : " + sConVo);
			cmLog.CommonSetInfo( "               [EXNP-ADV ] docStatus : " + docStatus);
			for(int i =0; i < result.size( ); i++){
				Map<String, Object> item = result.get( i );
				switch ( docStatus ) {
					case "0":
					case "10":
					case "20":
					case "002":
					case "90":
					case "008":
					case "100":
						iDao.set_WCMS_ERP_VCRD03( item, conVo );
						break;
					case "007":
					case "999":
					case "d":
						iDao.rollback_WCMS_ERP_VCRD03( item, conVo );
						break;
					default: break;
				}
			}
		}
		return resultCode;
	}

	@Override
	public ResultVO UpdateICubeCardGwState ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "               [EXNP-ADV] CALL UpdateICubeCardGwState");
		ResultVO result = new ResultVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(
			CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
			CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ))
		);
		try{
			if( CommonConvert.NullToString( params.get( "issDt" ) ).equals( "" ) ){
				throw new Exception ("issDt 확인 실패");
			} else if( CommonConvert.NullToString( params.get( "issSq" ) ).equals( "" ) ){
				throw new Exception ("issSq 확인 실패");
			} else if( CommonConvert.NullToString( params.get( "erpCompSeq" ) ).equals( "" ) ){
				throw new Exception ("erpCompSeq 확인 실패");
			}

			if(CommonConvert.NullToString( params.get( "gwState" ) ).equals( "" )){
				params.put( "docSeq", "" );
			}

			result = iDao.UpdateICubeCardGwState ( params, conVo );
		} catch(Exception ex){
			result.setFail( "UpdateICubeCardGwState 서비스 오류 발생", ex );
		}
		return result;
	}
}
