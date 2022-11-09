package expend.ez.user.sendInfo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ez.common.EzCommon;


@Service ( "FEzSendInfoCUBE" )
public class FEzSendInfoCUBEImpl implements FEzSendInfoCUBE {

	@Resource ( name = "FEzSendInfoCubeDAO" )
	private FEzSendInfoCubeDAO ISendDAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	@Resource (name = "EzCommon")
	private EzCommon ezCmm; /* 이지바로 ERP 연결 관리 */

	@Override
	public Map<String,Object> EzHReqInsert(Map<String,Object> params, ConnectionVO conVo)throws Exception{
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			LoginVO loginVo = ezCmm.EzCommonGetLoginVO();
			/* 기본값 지정 */
			params.put("GW_ID", loginVo.getUniqId());
			params.put("GW_STATE", "0");
			params.put("LANGKIND", "KOR");
			resultMap = ISendDAO.USP_ANZR100_INSERT_H(conVo, params);

		} catch (Exception e) {
			cmLog.CommonSetError(e);
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> EzHReqDetailInsert(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			params.put("LANGKIND", "KOR");

			if(params.get("REGSEQ").equals("")){
				params.put("REGSEQ", "0.00");
			}
			if(params.get("UNITCOST").equals("")){
				params.put("UNITCOST", "0.00");
			}
			if(params.get("SUPCOST").equals("")){
				params.put("SUPCOST", "0.00");
			}
			if(params.get("EXTTAX").equals("")){
				params.put("EXTTAX", "0.00");
			}
			if(params.get("TOTPURCHAMT").equals("")){
				params.put("TOTPURCHAMT", "0.00");
			}
			if(params.get("GISU_SQ").equals("")){
				params.put("GISU_SQ", "0.00");
			}
			if(params.get("PAYAMT").equals("")){
				params.put("PAYAMT", "0.00");
			}

			/* null 값 주기 */
			Iterator<String> keys = params.keySet().iterator();
	        while( keys.hasNext() ){
	            String key = keys.next();
	            if(params.get(key).equals("")){
	            	params.put(key,null);
	            }
	        }

	        String strCheju = EgovStringUtil.isNullToString(params.get("cheju"));

	        String[] arrCheju = strCheju.split("_");

	        if(arrCheju.length == 2){
	        	String spType = "";
	        	switch(arrCheju[1]){
		        	case  "C1":
		        	case  "C3":
		        	case  "C4":
		        	case  "C5":
		        		spType = "D";
		        		break;
		        	case  "C2":
		        	case  "C6":
		        	case  "C7":
		        	case  "C8":
		        	case  "C9":
		        	case  "C10":
		        		spType = "C";
		        		break;
	        		default :
	        			throw new NotFoundLoginSessionException( "체주유형 매칭 실패" );
	        	}

	        	//String spType = EgovStringUtil.isNullToString(params.get("spType"));

				/* 거래처 타입에 따른 분기 */
				if(spType.equals("C")){
					LoginVO loginVo = ezCmm.EzCommonGetLoginVO();
					params.put("GW_ID", loginVo.getUniqId());
					params.put("GW_STATE", "");
					params.put("LANGKIND", "KOR");
					resultMap = ISendDAO.USP_ANZR100_INSERT_C(conVo, params);

				}else if(spType.equals("D")){
					LoginVO loginVo = ezCmm.EzCommonGetLoginVO();
					params.put("GW_ID", loginVo.getUniqId());
					params.put("GW_STATE", "");
					params.put("LANGKIND", "KOR");
					resultMap = ISendDAO.USP_ANZR100_INSERT_D(conVo, params);
				}
	        }



		} catch (Exception e) {
			cmLog.CommonSetError(e);
			e.printStackTrace();
		}
		return resultMap;
	}

}
