package expend.trip.admin.option;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FTripAdminOptionServiceADAO")
public class FTripAdminOptionServiceADAO extends EgovComAbstractDAO {
	/**
	 * 출장복명 출장지 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO TripLocationOptionSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {

			List<Map<String, Object>> temp = list("TripAdminOptionA.TripLocationOptionSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public ResultVO TripTransPortOptionSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("TripAdminOptionA.TripTransPortOptionSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	/**
	 * 출장복명 직책그룹 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO TripPositionGroupOptionSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("TripAdminOptionA.TripPositionGroupOptionSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 출장복명 직책선택 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO TripPositionGroupItemOptionSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("TripAdminOptionA.TripPositionGroupItemOptionSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO TripTransPortOptionInsert(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			insert("TripAdminOptionA.TripTransPortOptionInsert", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripTransPortOptionUpdate(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			update("TripAdminOptionA.TripTransPortOptionUpdate", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripTransPortOptionDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			ArrayList<Map<String, Object>> temp = (ArrayList<Map<String, Object>>) list("TripAdminOptionA.TripExistChecktransportSelect", params);
			result.setAaData(temp);
			if (CommonConvert.NullToString(result.getAaData().get(0).get("existCount")).equals("0")) {
				delete("TripAdminOptionA.TripTransPortOptionDelete", params);
				result.setSuccess();
			}else{
				result.setResultCode( "EXSIST_AMT" );
				result.setResultName( "출장비단가설정 메뉴에서 해당 조건이 반영된 출장비단가를 먼저 삭제하시기 바랍니다." );
			}
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripLocationOptionInsert(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			insert("TripAdminOptionA.TripLocationOptionInsert", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripLocationOptionUpdate(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			update("TripAdminOptionA.TripLocationOptionUpdate", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripLocationOptionDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			ArrayList<Map<String, Object>> temp = (ArrayList<Map<String, Object>>) list("TripAdminOptionA.TripExistCheckLocationSelect", params);
			result.setAaData(temp);
			if (CommonConvert.NullToString(result.getAaData().get(0).get("existCount")).equals("0")) {
				delete("TripAdminOptionA.TripLocationOptionDelete", params);
				result.setSuccess();
			}else{
				result.setResultCode( "EXSIST_AMT" );
				result.setResultName( "출장비단가설정 메뉴에서 해당 조건이 반영된 출장비단가를 먼저 삭제하시기 바랍니다." );
			}
			
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripConsReportSelect(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("TripAdminOptionA.TripConsReportSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripAmtOptionSelect(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("TripAdminOptionA.TripAmtOptionSelect", params);
			result.setAaData(temp);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO TripAmtOptionInsert(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			ArrayList<Map<String, Object>> temp = (ArrayList<Map<String, Object>>) list("TripAdminOptionA.TripExistCheckAmtSelect", params);
			result.setAaData(temp);
			if (CommonConvert.NullToString(result.getAaData().get(0).get("existCount")).equals("0")) {
				insert("TripAdminOptionA.TripAmtOptionInsert", params);
				result.setSuccess();
			} else {
				result.setResultCode( "EXSIST_AMT" );
				result.setResultName( "단가 설정 되어있는 항목입니다." );
			}
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripAmtOptionUpdate(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			ArrayList<Map<String, Object>> temp = (ArrayList<Map<String, Object>>) list("TripAdminOptionA.TripExistCheckAmtSelect", params);
			result.setAaData(temp);
			if (CommonConvert.NullToString(result.getAaData().get(0).get("existCount")).equals("0")) {
				update("TripAdminOptionA.TripAmtOptionUpdate", params);
				result.setSuccess();
			} else {
				result.setResultCode( "EXSIST_AMT" );
				result.setResultName( "단가 설정 되어있는 항목입니다." );
			}
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripAmtOptionDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			delete("TripAdminOptionA.TripAmtOptionDelete", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public ResultVO TripPositionGroupOptionDelete(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			ArrayList<Map<String, Object>> temp = (ArrayList<Map<String, Object>>) list("TripAdminOptionA.TripExistCheckPositionGroupSelect", params);
			result.setAaData(temp);
			if (CommonConvert.NullToString(result.getAaData().get(0).get("existCount")).equals("0")) {
				delete("TripAdminOptionA.TripPositionGroupItemOptionDelete", params);
				delete("TripAdminOptionA.TripPositionGroupOptionDelete", params);
				result.setSuccess();
			} else {
				result.setResultCode( "EXSIST_AMT" );
				result.setResultName( "단가 설정 되어있는 항목입니다." );
			}

		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripPositionGroupOptionInsert(Map<String, Object> params) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			int dutyGroupSeq = (int) insert("TripAdminOptionA.TripPositionGroupOptionInsert", params);
			params.put("dutyGroupSeq", dutyGroupSeq);
			update("TripAdminOptionA.TripPositionGroupItemOptionInsert", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	public ResultVO TripPositionGroupOptionUpdate ( Map<String, Object> params ) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		try {
			update("TripAdminOptionA.TripPositionGroupOptionUpdate", params);
			delete("TripAdminOptionA.TripPositionGroupOptionDelete", params);
			if(params.get("newInsertDutyCode")!=null) {
				update("TripAdminOptionA.TripPositionGroupItemOptionInsert", params);	
			}
			
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

}
