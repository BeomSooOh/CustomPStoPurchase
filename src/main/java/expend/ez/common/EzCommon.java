package expend.ez.common;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;


@Service ( "EzCommon" )
public class EzCommon {
	
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	public ConnectionVO EzCommonGetErpType(){
		ConnectionVO conVo = null;
		cmLog.CommonSetInfo("이지바로 공통코드 ERP타입 가져오기 진입(EzCommonGetErpType)");
		Map<String,Object>params = new HashMap<String,Object>();
		try{
            LoginVO loginVO = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
			
			if(loginVO != null){
			
				params.put(commonCode.COMPSEQ, loginVO.getCompSeq());
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			}
			else{
				cmLog.CommonSetInfo("이지바로 loginVO IS NULL");
			}
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
		}	
		return conVo;
	}
	
	public ConnectionVO EzCommonGetErpType(Map<String,Object>params){
		ConnectionVO conVo = null;
		cmLog.CommonSetInfo("이지바로 공통코드 ERP타입 가져오기 진입(EzCommonGetErpType)");
		try{
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );

		}catch(Exception ex){
			cmLog.CommonSetError( ex );
		}	
		return conVo;
	}
	
	public LoginVO EzCommonGetLoginVO(){
        return (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
	}

}
