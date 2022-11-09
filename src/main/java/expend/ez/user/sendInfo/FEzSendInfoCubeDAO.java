package expend.ez.user.sendInfo;

import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;


import org.springframework.stereotype.Repository;


import common.helper.connection.CommonEzConnect;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import common.vo.common.ConnectionVO;


@Repository ( "FEzSendInfoCubeDAO" )
public class FEzSendInfoCubeDAO  extends EgovComAbstractDAO {
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	/* 변수정의 - class */
	CommonEzConnect connector = new CommonEzConnect( );

	public Map<String,Object> USP_ANZR100_INSERT_H(ConnectionVO conVo, Map<String,Object> params) throws Exception {
		cmLog.CommonSetInfo("+ [EZBARO] FEzSendInfoCubeDAO - USP_ANZR100_INSERT_H");
		cmLog.CommonSetInfo("! [EZBARO] AN_NRNDEXECREQ ExecReqVO >> " + params);

		try {
			if(params.get("PARTRATE").equals("")){
				params.put("PARTRATE", "0.00");
			}
			if(params.get("PAYBASEAMT").equals("")){
				params.put("PAYBASEAMT", "0.00");
			}
			if(params.get("RESOLAMT").equals("")){
				params.put("RESOLAMT", "0.00");
			}
			if(params.get("EXTTAX").equals("")){
				params.put("EXTTAX", "0.00");
			}
			if(params.get("ACCREGAMT").equals("")){
				params.put("ACCREGAMT", "0.00");
			}
			if(params.get("COURTAMT").equals("")){
				params.put("COURTAMT", "0.00");
			}
			if(params.get("CHARGE").equals("")){
				params.put("CHARGE", "0.00");
			}
			if(params.get("TRNSAMT").equals("")){
				params.put("TRNSAMT", "0.00");
			}
			if(params.get("GISU_SQ").equals("")){
				params.put("GISU_SQ", "0.00");
			}
			if(params.get("NDEP_AM").equals("")){
				params.put("NDEP_AM", "0.00");
			}
			if(params.get("INAD_AM").equals("")){
				params.put("INAD_AM", "0.00");
			}
			if(params.get("INTX_AM").equals("")){
				params.put("INTX_AM", "0.00");
			}
			if(params.get("RSTX_AM").equals("")){
				params.put("RSTX_AM", "0.00");
			}
			if(params.get("WD_AM").equals("")){
				params.put("WD_AM", "0.00");
			}
			if(params.get("BG_SQ").equals("")){
				params.put("BG_SQ", "0.00");
			}
			if(params.get("HIFE_AM").equals("")){
				params.put("HIFE_AM", "0.00");
			}
			if(params.get("NAPE_AM").equals("")){
				params.put("NAPE_AM", "0.00");
			}
			if(params.get("DDCT_AM").equals("")){
				params.put("DDCT_AM", "0.00");
			}
			if(params.get("NOIN_AM").equals("")){
				params.put("NOIN_AM", "0.00");
			}
			if(params.get("WD_AM2").equals("")){
				params.put("WD_AM2", "0.00");
			}
			if(params.get("HINCOME_SQ").equals("")){
				params.put("HINCOME_SQ", "0.00");
			}
			if(params.get("TASK_SQ").equals("")){
				params.put("TASK_SQ", "0.00");
			}

			/* null 값 주기 */
			Iterator<String> keys = params.keySet().iterator();
	        while( keys.hasNext() ){
	            String key = keys.next();
	            if(params.get(key).equals("")){
	            	params.put(key,null);
	            }
	        }
			connector.Update( conVo, "EziCUBESQL.USP_ANZR100_INSERT_H", params, "SP" );

		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return params;
	}

	public Map<String,Object> USP_ANZR100_INSERT_C(ConnectionVO conVo, Map<String,Object> params) throws Exception {
		cmLog.CommonSetInfo("+ [EZBARO] FEzSendInfoCubeDAO - USP_ANZR100_INSERT_C");
		cmLog.CommonSetInfo("! [EZBARO] AN_NRNDEXECREQ params >> " + params);

		try {
				connector.Update( conVo, "EziCUBESQL.USP_ANZR100_INSERT_C", params, "SP" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return params;
	}


	public Map<String,Object> USP_ANZR100_INSERT_D(ConnectionVO conVo, Map<String,Object> params) throws Exception {
		cmLog.CommonSetInfo("+ [EZBARO] FEzSendInfoCubeDAO - USP_ANZR100_INSERT_C");
		cmLog.CommonSetInfo("! [EZBARO] AN_NRNDEXECREQ params >> " + params);

		try {
				connector.Update( conVo, "EziCUBESQL.USP_ANZR100_INSERT_D", params, "SP" );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return params;
	}
}
