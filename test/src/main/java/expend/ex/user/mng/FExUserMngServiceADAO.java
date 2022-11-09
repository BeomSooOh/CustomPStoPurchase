package expend.ex.user.mng;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;

@Repository("FExUserMngServiceADAO")
public class FExUserMngServiceADAO extends EgovComAbstractDAO {

	/* 지출결의 */
	/* 지출결의 - 지출결의 항목 분개 관리항목 생성 */
	public ExExpendMngVO ExMngInfoInsert(ExExpendMngVO mngVo) throws Exception {
		/* 관리항목 생성은 반환값이 없음. 이미 아이디가 생성되어 파라미터로 전달 됨. */
		/* ERP 전송시 관리항목 순번을 맞추기 위해서, ERP 에서 정의된 상태로 생성 */
		insert("ExMngInfoInsert", mngVo);
		return mngVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 수정 */
	public ExCommonResultVO ExMngInfoUpdate(ExExpendMngVO mngVo) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO();

		if (update("ExMngInfoUpdate", mngVo) > 0) {
			resultVo.setCode(commonCode.SUCCESS);
			resultVo.setMessage(BizboxAMessage.getMessage("TX000009301","정상처리되었습니다"));
			resultVo.setMap(CommonConvert.CommonGetObjectToMap(mngVo));
		} else {
			resultVo.setCode(commonCode.FAIL);
			resultVo.setMessage(BizboxAMessage.getMessage("TX000009300","실패하였습니다"));
			resultVo.setMap(CommonConvert.CommonGetObjectToMap(mngVo));
		}

		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 조회 */
	public ExExpendMngVO ExMngInfoSelect(ExExpendMngVO mngVo) throws Exception {
		mngVo = (ExExpendMngVO) select("ExMngInfoSelect", mngVo);
		return mngVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	@SuppressWarnings("unchecked")
	public List<ExExpendMngVO> ExMngListInfoSelect(ExExpendMngVO mngVo) throws Exception {
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();
		mngListVo = (List<ExExpendMngVO>) list("ExMngListInfoSelect", mngVo);
		return mngListVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 삭제 */
	public ExCommonResultVO ExMngInfoDelete(ExExpendMngVO mngVo) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO();

		if (delete("ExMngInfoDelete", mngVo) > 0) {
			resultVo.setCode(commonCode.SUCCESS);
			resultVo.setMessage(BizboxAMessage.getMessage("TX000009301","정상처리되었습니다"));
			resultVo.setMap(CommonConvert.CommonGetObjectToMap(mngVo));
		} else {
			resultVo.setCode(commonCode.FAIL);
			resultVo.setMessage(BizboxAMessage.getMessage("TX000009300","실패하였습니다"));
			resultVo.setMap(CommonConvert.CommonGetObjectToMap(mngVo));
		}

		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 하위 내역 모두 삭제 */
	public ExCommonResultVO ExMngDInfoDelete(ExExpendMngVO mngVo) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO();
		delete("ExMngDInfoDelete", mngVo); /* 관리항목이 없는 경우도 있기에, 삭제 카운트를 확인하지 않는다. */
		resultVo.setCode(commonCode.SUCCESS);
		resultVo.setMessage(BizboxAMessage.getMessage("TX000009301","정상처리되었습니다"));
		resultVo.setMap(CommonConvert.CommonGetObjectToMap(mngVo));

		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> ExMngGridInfoSelect(ExExpendMngVO mngVo) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		result = (List<Map<String, Object>>) list("ExMngGridInfoSelect", mngVo);

		return result;
	}
	
	/* 지출결의 - 오류체크 - 관리항목 */
	@SuppressWarnings("unchecked")
	public List<ExCommonResultVO> ExMngErrorInfoSelect(ExExpendVO expendVo) throws Exception {
		List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>();
		resultListVo = (List<ExCommonResultVO>) list("ExExpendErrorMngInfoSelect", expendVo);
		return resultListVo;
	}
	
	
	
}