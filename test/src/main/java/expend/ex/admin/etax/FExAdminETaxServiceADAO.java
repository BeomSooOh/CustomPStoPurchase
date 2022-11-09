package expend.ex.admin.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExCodeETaxAuthVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FExAdminETaxServiceADAO")
public class FExAdminETaxServiceADAO extends EgovComAbstractDAO {

	/* 세금계산서 권한 설정 페이지 - 권한 리스트 조회 */
	@SuppressWarnings("unchecked")
	public ResultVO ExAdminETaxAuthListSelect(ResultVO param) throws Exception {
		try {
			param.setAaData(this.list("AdminETaxAuthListSelect", param.getParams()));
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 추가 */
	public ResultVO ExAdminETaxAuthInsert(ResultVO param) throws Exception {
		try {
			int index = Integer.parseInt(insert("AdminETaxAuthInsert", param.getParams()).toString());
			Map<String, Object> aData = new HashMap<String, Object>();
			aData.put("etaxSeq", index);
			param.setaData(aData);
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 삭제 */
	public ResultVO ExAdminETaxAuthDelete(ResultVO param) throws Exception {
		try {
			delete("AdminETaxAuthDelete", param.getParams());
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 수정 */
	public ResultVO ExAdminETaxAuthUpdate(ResultVO param) throws Exception {
		try {
			update("AdminETaxAuthUpdate", param.getParams());
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> ExAdminETaxAuthPublicSelect(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		result = this.list("AdminETaxAuthPulicSelect", param);
		
		return result;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 추가 */
	public ResultVO ExAdminETaxAuthPublicInsert(ResultVO param) throws Exception {
		try {
			insert("AdminETaxAuthPulicInsert", param.getParams());
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 삭제 */
	public ResultVO ExAdminETaxAuthPublicDelete(ResultVO param) throws Exception {
		try {
			delete("AdminETaxAuthPulicDelete", param.getParams());
		} catch (Exception e) {
			param.setResultCode(commonCode.EMPTYNO);
		}
		return param;
	}

	/* 회계>지출결의설정>전자세금계산서설정>신규개발 ( 2018-04-24 김상겸 ) */
	public ResultVO ExAdminETaxAuthAllListSelect(ResultVO param) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		param.setAaData(this.list("AdminETaxAuthAllListSelect", (Map<String, Object>)param.getParams()));
		return param;
	}
	
	/* 세금계산서 권한 설정 페이지 - 사업자등록번호 또는 이메일 중복체크 */
	public ResultVO ExETaxAuthCodeDuplicationCheckSelect(ExCodeETaxAuthVO eTaxAuthVO) throws Exception {
		ResultVO result = new ResultVO();
		result.setaData((Map<String, Object>)select("AdminETaxAuthCodeDuplicationCheckSelect", eTaxAuthVO));
		
		return result;
	}
}