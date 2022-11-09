package expend.np.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.map.np.ETax;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpUserReportServiceADAO")
public class FNpUserReportServiceADAO extends EgovComAbstractDAO {

	/**
	 * 사용자 권한 품의서 정보 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserConsListSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData(list("NpUserReportA.NpUserConsListSelect", params));
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 나의 카드사용 현황 조회 selectCardReport P : { } return List<Map<String,
	 * Object>>
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCardReport(Map<String, Object> params) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			params.put(commonCode.COMPSEQ, loginVo.getCompSeq());
			if (loginVo.getEaType().equals("ea")) {
				if (params.get("searchCardInfo").toString().indexOf(",") > 0) {
					params.put("cardInfo", params.get("searchCardInfo").toString().split(","));
				}
				result = list("NpUserReportA.selectEACardReport", params);
			} else {
				result = list("NpUserReportA.selectEAPCardReport", params);
			}
		} catch (Exception ex) {
			result = new ArrayList<Map<String, Object>>();
		}
		return result;
	}

	/**
	 * 참조결의서 리스트 조회 updateConfferReturnYN P : { selectConsReport } return
	 * ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectConsConfferResList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			if (loginVo.getEaType().equals("ea")) {
				result.setAaData((List<Map<String, Object>>) list("NpUserReportA.selectConsConfferResListEA", params));
			} else if (loginVo.getEaType().equals("eap")) {
				result.setAaData((List<Map<String, Object>>) list("NpUserReportA.selectConsConfferResListEAP", params));
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 품의 현황 리스트 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserConsReportSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			if (loginVo.getEaType().equals("ea")) {
				result.setAaData(list("NpUserReportA.selectConsReportPageListEA", params));
			} else if (loginVo.getEaType().equals("eap")) {
				result.setAaData(list("NpUserReportA.selectConsReportPageListEAP", params));
			} else {
				throw new Exception("전자결재 구분을 확인할 수 없습니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 품의서 예산내역 헤더 정보 조회 updateConfferReturnYN P : { selectConsReport } return
	 * ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectConsBudgetListHead(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> dbResult = (List<Map<String, Object>>) list("NpUserReportA.consBudgetListHead",
					params);
			if (dbResult.size() != 1) {
				throw new Exception("헤더 조회 실패 / DB 조회 예측 오차");
			}
			result.setaData(dbResult.get(0));
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 품의서 예산내역 리스트 조회 updateConfferReturnYN P : { selectConsReport } return
	 * ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectConsBudgetList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserReportA.consBudgetList", params));
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 품의서 반환 / 취소 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserConsConfferStatusUpdate(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserReportA.updateConsConfferStatus", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 품의서 현황 - 품의서 반환 / 취소 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserConsConfferBudgetStatusUpdate(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserReportA.updateConsConfferBudgetStatus", params);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 결의서 현황 - 결의 현황 리스트 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO NpUserResListSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			if (loginVo.getEaType().equals("ea")) {
				result.setAaData(list("NpUserReportA.selectResReportPageListEA", params));
			} else if (loginVo.getEaType().equals("eap")) {
				result.setAaData(list("NpUserReportA.selectResReportPageListEAP", params));
			} else {
				throw new Exception("전자결재 구분을 확인할 수 없습니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 매입전자세금계산서 리스트 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> NPUserEtaxReportList(Map<String, Object> params) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			if (CommonConvert.CommonGetEmpVO().getEaType().equals("ea")) {
				result = list("NpUserReportA.NPUserEtaxEaReportList", params);
			} else {
				result = list("NpUserReportA.NPUserEtaxEapReportList", params);
			}
		} catch (Exception ex) {
			result = new ArrayList<Map<String, Object>>();
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 헤더 정보 조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectDocumentInterfaceInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("EXNPCON") > -1) {
				List<Map<String, Object>> queryResult = list("NpUserReportA.selectConsDocumentInterfaceInfo", params);
				Map<String, Object> consResult = new HashMap<>();
				if(queryResult.size() == 1) {
					consResult = queryResult.get(0);
					consResult.put("docSts", 0);
					result.setSuccess();
					result.setaData(consResult);
				}else {
					throw new Exception ("결의정보 조회에 실패하였습니다.");
				}
			} else if (params.get("processId").toString().indexOf("EXNPRES") > -1) {
				List<Map<String, Object>> queryResult = list("NpUserReportA.selectResDocumentInterfaceInfo", params);
				Map<String, Object> resResult = new HashMap<>();
				if(queryResult.size() == 1) {
					resResult = queryResult.get(0);
					resResult.put("docSts", 0);
					result.setSuccess();
					result.setaData(resResult);
				}else {
					throw new Exception ("결의정보 조회에 실패하였습니다.");
				}
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 헤더 정보 조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectHeadInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}

			if (params.get("processId").toString().indexOf("EXNPCON") > -1 || params.get("processId").toString().indexOf("TRIPCONS") > -1 ) {
				if(!params.containsKey("tripConsDocSeq")) {
					params.put("tripConsDocSeq", "");
				}
				result.setAaData(list("NpUserReportA.selectConsDocInfo", params));
			} else if (params.get("processId").toString().indexOf("EXNPRES") > -1 ||  params.get("processId").toString().indexOf("TRIPRES") > -1 ) {
				if(!params.containsKey("tripResDocSeq")) {
					params.put("tripResDocSeq", "");
				}
				result.setAaData(list("NpUserReportA.selectResDocInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 합계 정보 조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectFooterInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("EXNPCON") > -1 ||  params.get("processId").toString().indexOf("TRIPCONS") > -1 ) {
				result.setAaData(list("NpUserReportA.selectConsFooterInfo", params));
			} else if (params.get("processId").toString().indexOf("EXNPRES") > -1 ||  params.get("processId").toString().indexOf("TRIPRES") > -1 ) {
				result.setAaData(list("NpUserReportA.selectResFooterInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 프로젝트
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectProjectInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("EXNPCON") > -1) {
				result.setAaData(list("NpUserReportA.selectConsHeadInfo", params));
			} else if (params.get("processId").toString().indexOf("EXNPRES") > -1) {
				result.setAaData(list("NpUserReportA.selectResHeadInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 예산
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectBudgetInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("CON") > -1) {
				result.setAaData(list("NpUserReportA.selectConsBudgetInfo", params));
			} else if (params.get("processId").toString().indexOf("RES") > -1) {
				result.setAaData(list("NpUserReportA.selectResBudgetInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 사용자 - 인터락 양식 생성 - 컨텐츠 정보 조회 - 거래처
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectTradeInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("CON") > -1) {
				result.setAaData(list("NpUserReportA.selectConsTradeInfo", params));
			} else if (params.get("processId").toString().indexOf("RES") > -1) {
				result.setAaData(list("NpUserReportA.selectResTradeInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	public ResultVO selectItemInterlock(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			if (params.get("processId") == null) {
				throw new Exception("프로세스 아이디를 확인할 수 없습니다.");
			}
			if (params.get("processId").toString().indexOf("CON") > -1) {
				result.setAaData(list("NpUserReportA.selectConsItemInfo", params));
			} else if (params.get("processId").toString().indexOf("RES") > -1) {
				result.setAaData(list("NpUserReportA.selectResItemInfo", params));
			} else {
				throw new Exception("알 수 없는 프로세스 아이디입니다.");
			}
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}


	public ResultVO selectCardTransHistoryList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {

			result.setAaData(list("NpUserReportA.selectCardTransHistoryList", params));

			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/* 법인카드 사용내역 상세 정보 조회 */
	public ResultVO NPUserCardDetailInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = (List<Map<String, Object>>) list("NpUserReportA.NPUserCardDetailInfo",
					params);
			if (temp.size() == 0) {
				throw new Exception("확인 할 수 없는 법인카드 사용내역입니다.");
			}
			result.setaData(temp.get(0));
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */




	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 데이터 존재 여부 확인
	 *
	 * @param param
	 *            ( issNo, issDt )
	 * @return result.aData
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxExists(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = (Map<String, Object>) select(ETax.Map.EXISTS, param);

			if (resultMap == null) {
				resultMap = new HashMap<String, Object>();
			}
			result.setaData(resultMap);
			result.setSuccess();
		} catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 상신 데이터 존재 여부 확인
	 *
	 * @param param
	 *            ( issNo, issDt )
	 * @return result.aData
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxSendExists(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = (Map<String, Object>) select(ETax.Map.SENDEXISTS, param);

			if (resultMap == null) {
				resultMap = new HashMap<String, Object>();
			}
			result.setaData(resultMap);
			result.setSuccess();
		} catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 생성
	 *
	 * @param param
	 *            ( issNo, issDt, trRegNb, compSeq, note, empSeq )
	 * @return sync_id
	 * @throws Exception
	 */
	public ResultVO SetETaxInsert(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			insert(ETax.Map.INSERT, param);
			result.setaData(param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 이관 처리
	 *
	 * @param param
	 *            ( compSeq, issNo, issDt, trRegNb, trName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey, issNo, issDt )
	 * @return ( etax_trans_seq )
	 * @throws Exception
	 */
	public ResultVO SetETaxTransInsert(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			insert(ETax.Map.TRANSINSERT, param);
			result.setaData(param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setaData(new HashMap<String, Object>());
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}

		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 미사용 처리
	 *
	 * @param param
	 *            ( issNo, issDt, empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetEtaxUseUpdateN(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update(ETax.Map.USEUPDATEN, param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 사용 처리
	 *
	 * @param param
	 *            ( issNo, issDt, empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetEtaxUseUpdateY(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update(ETax.Map.USEUPDATEY, param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 상신 취소 처리
	 *
	 * @param param
	 *            ( issNo, issDt, empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetEtaxSendUpdateN(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update(ETax.Map.SENDUPDATEN, param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 연동 데이터 상신 처리
	 *
	 * @param param
	 *            ( issNo, issDt, empSeq )
	 * @return ResultVO.resultCode
	 * @throws Exception
	 */
	public ResultVO SetEtaxSendUpdateY(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update(ETax.Map.SENDUPDATEY, param);
			result.setSuccess();
		} catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 매입전자세금계산서 현황 및 기능 2차 구현 - 매입전자세금계산서 이관 항목 조회
	 *
	 * @param param
	 *            ( compSeq, issNo, issDt )
	 * @return (ResultVO.aData)
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetETaxTransSelect(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setaData((Map<String, Object>)select(ETax.Map.TRANSEXISTS, param));
			result.setSuccess();
		}
		catch (Exception e) {
			result.setFail("Data 질의 요청중 에러 발생", e);
		}
		return result;
	}

	public ResultVO SetETaxTransUpdate(Map<String, Object> param) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update(ETax.Map.TRANSUPDATE, param);
			result.setSuccess();
		}
		catch (Exception e) {
			result.setFail("Data 질의 요청중 에러 발생", e);
		}
		return result;
	}

}