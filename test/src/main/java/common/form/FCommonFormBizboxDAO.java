package common.form;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FCommonFormBizboxDAO")
public class FCommonFormBizboxDAO extends EgovComAbstractDAO {

    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog;

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonFormSendParam(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("CommonFormBizboxDAO.CommonFormSendParam", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonFormDataInfo(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonFormDataInfo", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonNPFormDataInfo(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        if (CommonConvert.CommonGetStr(params.get("eaType")).equals("eap")) {
            result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonNPEapFormDataInfo", params);
        } else {
            result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonNPEaFormDataInfo", params);
        }
        return result;
    }

    public int CommonFormInfoInsert(Map<String, Object> params) throws Exception {
        int result = update("CommonFormBizboxDAO.CommonFormInfoInsert", params);
        return result;
    }

    public int CommonNpFormInfoInsert(Map<String, Object> params) throws Exception {
        int result = update("CommonFormBizboxDAO.CommonNpFormInfoInsert", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonFormSampleInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = list("CommonFormBizboxDAO.CommonFormSampleInfoSelect", params);

        for (Map<String, Object> map : result) {
            if (result.get(result.indexOf(map)).get("sampleName") == null) {
                result.get(result.indexOf(map)).put("sampleName", "");
            }

            if (result.get(result.indexOf(map)).get("sampleContent") == null) {
                result.get(result.indexOf(map)).put("sampleContent", "");
            }
        }

        return result;
    }


    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonNPFormSampleInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = list("CommonFormBizboxDAO.CommonNPFormSampleInfoSelect", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonNpFormDetailInfo(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonNpFormDetailInfo", params);
        if (result == null) {
        	params.put("ErpType", CommonConvert.NullToString(params.get("processId")));
            insert("CommonFormBizboxDAO.CopyInterlock", params);
            result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonNpFormDetailInfo", params);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonFormDetailInfo(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonFormDetailInfo", params);
        if (result == null) {
            insert("CommonFormBizboxDAO.CopyFormDetailInfo", params);
            result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonFormDetailInfo", params);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonFormDefaultInfo(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        result = (Map<String, Object>) select("CommonFormBizboxDAO.CommonFormDefaultInfo", params);
        return result;
    }

    public int CopyFormDetailInfo(Map<String, Object> params) throws Exception {
        insert("CommonFormBizboxDAO.CopyFormDetailInfo", params);
        return 0;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonFormCodeInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("CommonFormBizboxDAO.CommonFormCodeInfoSelect", params);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonNPFormCodeInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("CommonFormBizboxDAO.CommonNPFormCodeInfoSelect", params);
        return result;
    }

    /* 전자결재 양식필수정보 접힘/펼침 기본 설정 조회 */


    /**
     * 전자결재 양식 옵션 정보 조회 - 접힘 / 펼칠 기본 설정 조회
     * 
     * @param params : groupSeq, compSeq
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> CommonPFormOptionInfoSelect_ea230(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) this.select("CommonFormBizboxDAO.CommonPFormOptionInfoSelect_ea230", params);
    }
    
    /* 전자결재 인터 정보 업데이트 - 비영리 */
    @SuppressWarnings("unchecked")
    public ResultVO CommonAInterlockUpdate(Map<String, Object> params) throws Exception {
    	ResultVO result = new ResultVO( );
    	try{
    		/* 전자결재 정보 조회 */
    		Map<String, Object> docInfo = ((List<Map<String, Object>>) this.list("CommonFormBizboxDAO.CommonAInterlockUpdate_docSelect", params)).get( 0 );
    		
    		if( ! CommonConvert.NullToString( docInfo.get( "docExist" )).equals( "1" ) ){
    			throw new Exception (" 전자결재 정보 확인 불가능. ");
    		}
    		params.put( "docSeq", CommonConvert.NullToString( docInfo.get( "docSeq" )) );
    		
    		/* inter양식 업데이트 */
    		this.update( "CommonFormBizboxDAO.CommonAInterlockUpdate", params );
    		
    		result.setSuccess( );
    	}catch(Exception ex){
    		result.setFail( " [ERROR] FCommonFormBizboxDAO.CommonPInterlockUpdate >> " +  ex.getLocalizedMessage( ) );
    	}
        return result;
    }
    
    /* 전자결재 인터 정보 업데이트 - 영리 */
    @SuppressWarnings("unchecked")
    public ResultVO CommonPInterlockUpdate(Map<String, Object> params) throws Exception {
    	ResultVO result = new ResultVO( );
    	try{
    		/* 전자결재 정보 조회 */
    		Map<String, Object> docInfo = ((List<Map<String, Object>>) this.list("CommonFormBizboxDAO.CommonPInterlockUpdate_docSelect", params)).get( 0 );
    		if( ! CommonConvert.NullToString( docInfo.get( "docExist" )).equals( "1" ) ){
    			throw new Exception (" 전자결재 정보 확인 불가능. ");
    		}
			params.put( "docSeq", CommonConvert.NullToString( docInfo.get( "docSeq" )) );
    		
    		/* inter양식 업데이트 */
    		this.update( "CommonFormBizboxDAO.CommonPInterlockUpdate", params );
    		
    		result.setSuccess( );
    	}catch(Exception ex){
    		result.setFail( " [ERROR] FCommonFormBizboxDAO.CommonPInterlockUpdate >> " + ex.getLocalizedMessage( ) );
    	}
        return result;
    }

	public ResultVO CopyInterlock(Map<String, Object> params) {
    	ResultVO result = new ResultVO( );
    	try{
    		insert("CommonFormBizboxDAO.CopyInterlock", params);
    		result.setSuccess( );
    	}catch(Exception ex){
    		ex.printStackTrace();
    		result.setFail( " [ERROR] FCommonFormBizboxDAO.CopyInterlock >> " + ex.toString() );
    	}
        return result;
	}
}
