/**
  * @FileName : FApprovalServicePImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExpendVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.np.NpOutInterfaceVO;
import expend.angu.user.angu.FAnguUserAnguServiceADAO;
import expend.angu.user.angu.FAnguUserAnguServiceIDAO;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.admin.report.BExAdminReportService;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.card.FExUserCardService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.etax.FExUserEtaxService;
import expend.ex.user.expend.FExUserService;
import expend.ez.user.eaInfo.FEzEAInfo;
import expend.ez.user.erpUserInfo.BEzErpUserInfo;
import expend.np.admin.report.BNpAdminReportService;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.option.BNpUserOptionService;
import expend.np.user.res.BNpUserResService;
import neos.cmm.util.HttpJsonUtil;
import net.sf.json.JSONObject;

/**
 *   * @FileName : FApprovalServicePImpl.java   * @Project : BizboxA_exp
 *   * @변경이력 :   * @프로그램 설명 : 영리 전자결재 연동 프로세스   
 */
@Service("FApprovalServiceP")
public class FApprovalServicePImpl implements FApprovalService {

	/* 변수정의 */
	/* 공통 */
	@Resource(name = "CommonLogger")
	private CommonLogger cmLog; /* Log 관리 */
	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo; /* 공통사용 정보 */
	/* 변수정의 - Service */
	@Resource(name = "FExUserCardServiceA")
	private FExUserCardService userCardService; /* 카드 처리 클래스 */
	@Resource(name = "FExUserEtaxServiceAImpl")
	private FExUserEtaxService userETaxService; /* 매입전자세금계산서 처리 클래스 */
	@Resource(name = "BExUserCodeService")
	private BExUserCodeService codeService;/* Code */
	/* 변수정의 - DAO */
	@Resource(name = "FApprovalServicePDAO")
	private FApprovalServicePDAO dao;
	@Resource(name = "BExBudgetService") /* 예산 서비스 */
	private BExBudgetService budgetService;
	/* 이지바로 서비스 */
	@Resource(name = "BEzErpUserInfo")
	private BEzErpUserInfo ezbaroSerivce;
	@Resource(name = "FEzEAInfo")
	private FEzEAInfo ezInfo;
	/* 국고보조 집행등록 */
	@Resource(name = "FAnguUserAnguServiceADAO")
	private FAnguUserAnguServiceADAO anguADao; /* 국고보조 집행등록 */
	@Resource(name = "FAnguUserAnguServiceIDAO")
	private FAnguUserAnguServiceIDAO anguIDao; /* 국고보조 집행등록 */
	/* 품의/결의 2.0 */
	@Resource(name = "BNpUserConsService")
	private BNpUserConsService npCons; /* 품의서 */
	@Resource(name = "BNpUserResService")
	private BNpUserResService npRes; /* 결의서 */
	@Resource(name = "BNpUserCodeService")
	private BNpUserCodeService npCode; /* 결의서 공통코드 */
	@Resource(name="BExAdminReportService")
	private BExAdminReportService adminReportService; /* 회계(관리자) - 지출결의 관리 */
	@Resource ( name = "BExAdminConfigService" )
	private BExAdminConfigService configService; /* 환경설정 서비스 */
	@Resource(name="FExUserServiceA")
	private FExUserService userServiceA; /* 사용자 - 지출결의 조회 */
	@Resource ( name = "BNpAdminReportService" )
	private BNpAdminReportService reportService;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService npOption;

	/* 전자결재 본문 조회 */
	@Override
	public String ApprovalContentInfoSelect(String docSeq) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put(commonCode.DOCSEQ, docSeq);
		return dao.ApprovalContentInfoSelect(params);
	}

	@Override
	public Map<String, Object> CardAqSendYnUpdate(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/* ################################################## */
	/* [회계API] 보관 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ApprovalProcessSave(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		/* 최초 상신/보관 여부 */
		boolean isFirst = false;
		/* 실패했는지 여부 */
		boolean isFailed = false;
		/* iU Row 추가 여부 */
		boolean isERPiURowInsert = false;
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - processId */
			if (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.PROCESSID);
				chkParameter = false;
			}
			if (chkParameter) {
				/* 최초 보관시에만 상태값 및 예산정보 업데이트 진행 */
				String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
				String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
				if (params.get("expendSeq") == null) {
					params.put("expendSeq", expendSeq);
				}
				Map<String, Object> defaultData = codeService.ExUserExpendDocStsSelect(params);
				if (CommonConvert.CommonGetStr(defaultData.get("expendStatCode")).equals(commonCode.EMPTYSTR)
						|| CommonConvert.CommonGetStr(defaultData.get("expendStatCode")).equals(commonCode.EMPTYSEQ)) {
					/* 최초 상신/보관 */
					isFirst = true;
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessExCard(params, commonCode.EMPTYYES);
					/* 법인카드 상태값 동기화 확인 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						isFailed = true;
					}
					if (!isFailed) {
						/* 매입전자세금계산서 상태값 연동 */
						params.put("isApprovalEnd", false);
						result = ApprovalProcessExETax(params, commonCode.EMPTYYES);
						/* 매입전자세금계산서 상태값 동기화 확인 */
						if (result.getResultCode().equals(commonCode.FAIL)) {
							isFailed = true;
						}
					}
					if (!isFailed) {
						switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
						case commonCode.EXA:
							break;
						case commonCode.EXI:
							/* 예산 체크 */
							if (budgetService.ExInterlockUseBudgetInfoSelect(params)) {
								result.setResultCode(commonCode.FAIL);
								result.setResultMessage("예산초과 : " + commonCode.PROCESSID);
								isFailed = true;
							}
							break;
						case commonCode.EXU:
							/* 예산 체크 */
							cmLog.CommonSetInfo("ERPiU 예산체크 진입 전");
							if (budgetService.ExInterlockUseBudgetInfoSelect(params)) {
								cmLog.CommonSetInfo("ERPiU 예산체크 완료 후");
								result.setResultCode(commonCode.FAIL);
								result.setResultMessage("예산초과 : " + commonCode.PROCESSID);
								isFailed = true;
							} else {
								cmLog.CommonSetInfo("ERPiU 예산체크 구문 종결");
								/* Row 정보 생성 */
								cmLog.CommonSetInfo("ERPiU Row");
								if (!budgetService.ExInterLockERPiURowInsert(params)) {
									result.setResultCode(commonCode.FAIL);
									result.setResultMessage("ERPiU Row정보 생성 실패 : " + commonCode.PROCESSID);
									isFailed = true;
								} else {
									isERPiURowInsert = true;
								}
							}
							break;
						case commonCode.EZICUBE:
						case commonCode.EZERPIU:
							break;
						case commonCode.ANGUI:
						case commonCode.ANGUU:
							result = ApprovalProcessSaveAngu(params);
							break;
						default :
							break;
						}
					}
				}
				if (!isFailed) {
					String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
					/* 지출결의 결재 상태 동기화 */
					if (interProcessId.equals(commonCode.EXI) || interProcessId.equals(commonCode.EXU)
							|| interProcessId.equals(commonCode.EXA)) {
						result = ApprovalProcessExStatusInfoUpdate(params);
					}
					/* 이지바로 결재상태 동기화 */
					else if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
						result = ApprovalProcessEzbaroStatusInfoUpdate(params);
					}
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
					/* 최초 상신/보관 */
					if (isFirst) {
						cmLog.CommonSetInfo("최초 상신/보관 실패로 상태 값 원상복구");
						/* 최초 상신/보관일시 ERP iU Row 정보 삭제 */
						if (isERPiURowInsert) {
							try {
								budgetService.ExInterLockERPiURowDelete(params);
							} catch (Exception e) {
								cmLog.CommonSetError(e);
							}
						}
						/* 최초 상신/보관일시 카드 상태값 원상복구 */
						try {
							ApprovalProcessExCard(params, commonCode.EMPTYNO);
						} catch (Exception e) {
							cmLog.CommonSetError(e);
						}
						/* 최초 상신/보관일시 세금계산서 상태값 원상복구 */
						try {
							ApprovalProcessExETax(params, commonCode.EMPTYNO);
						} catch (Exception e) {
							cmLog.CommonSetError(e);
						}
					}
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EX -보관 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* ################################################## */
	/* [회계API] 상신 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ApprovalProcessApproval(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		/* 최초 상신/보관 여부 */
		boolean isFirst = false;
		/* 실패했는지 여부 */
		boolean isFailed = false;
		/* iU Row 추가 여부 */
		boolean isERPiURowInsert = false;
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - processId */
			if (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.PROCESSID);
				chkParameter = false;
			}
			if (chkParameter) {
				/* 최초 보관시에만 상태값 및 예산정보 업데이트 진행 */
				String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				String approKey = CommonConvert.CommonGetSeq(params.get(commonCode.APPROKEY));
				if (params.get(commonCode.EXPENDSEQ) == null) {
					params.put(commonCode.EXPENDSEQ, approKey.replace(processId + "_EX_", commonCode.EMPTYSTR));
				}
				Map<String, Object> defaultData = codeService.ExUserExpendDocStsSelect(params);
				if (CommonConvert.CommonGetStr(defaultData.get("expendStatCode")).equals(commonCode.EMPTYSTR)
						|| CommonConvert.CommonGetStr(defaultData.get("expendStatCode")).equals(commonCode.EMPTYSEQ)) {
					/* 최초 상신/보관 */
					isFirst = true;
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessExCard(params, commonCode.EMPTYYES);
					/* 법인카드 상태값 동기화 확인 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						isFailed = true;
					}
					if (!isFailed) {
						/* 매입전자세금계산서 상태값 연동 */
						params.put("isApprovalEnd", false);
						result = ApprovalProcessExETax(params, commonCode.EMPTYYES);
						/* 매입전자세금계산서 상태값 동기화 확인 */
						if (result.getResultCode().equals(commonCode.FAIL)) {
							isFailed = true;
						}
					}
					if (!isFailed) {
						switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
						case commonCode.EXA:
							break;
						case commonCode.EXI:
							/* 예산 체크 */
							if (budgetService.ExInterlockUseBudgetInfoSelect(params)) {
								result.setResultCode(commonCode.FAIL);
								result.setResultMessage("예산초과 : " + commonCode.PROCESSID);
								isFailed = true;
							}
							break;
						case commonCode.EXU:
							/* 예산 체크 */
							if (budgetService.ExInterlockUseBudgetInfoSelect(params)) {
								result.setResultCode(commonCode.FAIL);
								result.setResultMessage("예산초과 : " + commonCode.PROCESSID);
								isFailed = true;
							} else {
								/* Row 정보 생성 */
								if (!budgetService.ExInterLockERPiURowInsert(params)) {
									result.setResultCode(commonCode.FAIL);
									result.setResultMessage("ERPiU Row정보 생성 실패 : " + commonCode.PROCESSID);
									isFailed = true;
								} else {
									isERPiURowInsert = true;
								}
							}
							break;
						case commonCode.EZICUBE:
						case commonCode.EZERPIU:
							break;
						default :
							break;
						}
					}
				}
				if (!isFailed) {
					String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
					/* 지출결의 결재 상태 동기화 */
					if (interProcessId.equals(commonCode.EXI) || interProcessId.equals(commonCode.EXU)
							|| interProcessId.equals(commonCode.EXA)) {
						result = ApprovalProcessExStatusInfoUpdate(params);
					}
					/* 이지바로 결재상태 동기화 */
					else if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
						result = ApprovalProcessEzbaroStatusInfoUpdate(params);
					}
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
					/* 최초 상신/보관 */
					if (isFirst) {
						cmLog.CommonSetInfo("최초 상신/보관 실패로 상태 값 원상복구");
						/* 최초 상신/보관일시 ERP iU Row 정보 삭제 */
						if (isERPiURowInsert) {
							try {
								budgetService.ExInterLockERPiURowDelete(params);
							} catch (Exception e) {
								cmLog.CommonSetError(e);
							}
						}
						/* 최초 상신/보관일시 카드 상태값 원상복구 */
						try {
							ApprovalProcessExCard(params, commonCode.EMPTYNO);
						} catch (Exception e) {
							cmLog.CommonSetError(e);
						}
						/* 최초 상신/보관일시 세금계산서 상태값 원상복구 */
						try {
							ApprovalProcessExETax(params, commonCode.EMPTYNO);
						} catch (Exception e) {
							cmLog.CommonSetError(e);
						}
					}
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EX -상신 프로세스 오류 발생 : " + e.getMessage());
		}
		return result;
	}

	/* ################################################## */
	/* [회계API] 종결 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ApprovalProcessEnd(Map<String, Object> params) throws Exception {
		/* 아무런 프로세스 없음. */
		InterlockExpendVO result = new InterlockExpendVO();
		cmLog.CommonSetInfo("ApprovalProcessEnd :" + params);
		try {
			String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			cmLog.CommonSetInfo("interProcessId :" + interProcessId);
			/* 매입전자 세금계산서 상태값 업데이트 */
			/* 매입전자세금계산서 상태값 연동 */
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetSeq(params.get(commonCode.APPROKEY));
			params.put(commonCode.EXPENDSEQ, approKey.replace(processId + "_EX_", commonCode.EMPTYSTR));
			params.put("isApprovalEnd", true);
			/* 매입전자세금계산서 상태값 동기화 확인 */
			result = ApprovalProcessExETax(params, commonCode.EMPTYYES);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				return result;
			}
			/* 지출결의 결재 상태 동기화 */
			if (interProcessId.equals(commonCode.EXI) || interProcessId.equals(commonCode.EXU)
					|| interProcessId.equals(commonCode.EXA)) {
				cmLog.CommonSetInfo("지출결의 :" + interProcessId);
				result = ApprovalProcessExStatusInfoUpdate(params);
			}
			/* 이지바로 결재상태 동기화 */
			else if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
				cmLog.CommonSetInfo("이지바로 :" + interProcessId);
				int gwResult = 0;
				/* 업데이트 대상 가져오기 */
				List<Map<String, Object>> targetList = new ArrayList<Map<String, Object>>();
				// targetList
				targetList = ezInfo.EzErpPrimaryKeyListSelect(params);
				for (Map<String, Object> map : targetList) {
					/* 이지바로 GW_STATE 상태값 업데이트 */
					map.put("compSeq", params.get("compSeq"));
					int returnValue = ezbaroSerivce.EzErpGWStateUpdate(map);
					gwResult = gwResult + returnValue;
				}
				// gwResult = ezIcubService.EzEndApproval( params );
				if (gwResult == targetList.size()) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				} else {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage("EzBaro ERP 상태값 업데이트 실패 : " + commonCode.PROCESSID);
					return result;
				}
			}

			if (result.getResultCode().equals(commonCode.FAIL)) {
				return result;
			}

			/* 지출결의서 ERP 전송기능 - 전송 중 오류가 발생하여도 결과는 SUCCESS 리턴 */
			result = ApprovalProcessExpendListInfoSend(params);
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EX -종결 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* ################################################## */
	/* [회계API] 반려 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ApprovalProcessReturn(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - processId */
			if (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.PROCESSID);
				chkParameter = false;
			}
			if (chkParameter) {
				String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				String approKey = CommonConvert.CommonGetSeq(params.get(commonCode.APPROKEY));
				params.put(commonCode.EXPENDSEQ, approKey.replace(processId + "_EX_", commonCode.EMPTYSTR));
				/* 법인카드 상태값 연동 */
				result = ApprovalProcessExCard(params, commonCode.EMPTYNO);
				/* 법인카드 상태값 동기화 확인 */
				if (result.getResultCode().equals(commonCode.FAIL)) {
					return result;
				}
				/* 매입전자세금계산서 상태값 연동 */
				params.put("isApprovalEnd", false);
				result = ApprovalProcessExETax(params, commonCode.EMPTYNO);
				/* 매입전자세금계산서 상태값 동기화 확인 */
				if (result.getResultCode().equals(commonCode.FAIL)) {
					return result;
				}
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					break;
				case commonCode.EXI:
					break;
				case commonCode.EXU:
					/* Row 정보 삭제 */
					if (!budgetService.ExInterLockERPiURowDelete(params)) {
						result.setResultCode(commonCode.FAIL);
						result.setResultMessage("ERPiU Row정보 삭제 실패");
						return result;
					}
					break;
				case commonCode.EZICUBE:
				case commonCode.EZERPIU:
					break;
				default :
					break;
				}
				String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				/* 지출결의 결재 상태 동기화 */
				if (interProcessId.equals(commonCode.EXI) || interProcessId.equals(commonCode.EXU)
						|| interProcessId.equals(commonCode.EXA)) {
					result = ApprovalProcessExStatusInfoUpdate(params);
				}
				/* 이지바로 결재상태 동기화 */
				else if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EX -반려 프로세스 오류 발생 : " + e.getMessage());
		}
		return result;
	}

	/* ################################################## */
	/* [회계API] 삭제 */
	/* ################################################## */
	@Override
	public InterlockExpendVO ApprovalProcessDelete(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String oldExpendState = CommonConvert.CommonGetStr(ApprovalProcessExStatusInfoSelect(params));
			/* 필수값 확인 - processId */
			if (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.PROCESSID);
				chkParameter = false;
			}
			if (chkParameter) {
				String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				String approKey = CommonConvert.CommonGetSeq(params.get(commonCode.APPROKEY));
				params.put(commonCode.EXPENDSEQ, approKey.replace(processId + "_EX_", commonCode.EMPTYSTR));
				/* 반려에서 삭제가 아닌 경우 */
				if (!oldExpendState.equals("100")) {
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessExCard(params, commonCode.EMPTYNO);
					/* 법인카드 상태값 동기화 확인 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 매입전자세금계산서 상태값 연동 */
					params.put("isApprovalEnd", false);
					result = ApprovalProcessExETax(params, commonCode.EMPTYNO);
					/* 매입전자세금계산서 상태값 동기화 확인 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
				}
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					break;
				case commonCode.EXI:
					break;
				case commonCode.EXU:
					/* 반려에서 삭제가 아닌 경우 *//* Row 정보 삭제 */
					if (!oldExpendState.equals("100")) {
						if (!budgetService.ExInterLockERPiURowDelete(params)) {
							result.setResultCode(commonCode.FAIL);
							result.setResultMessage("ERPiU Row정보 삭제 실패 : " + commonCode.PROCESSID);
							return result;
						}
					}
					break;
				case commonCode.EZICUBE:
				case commonCode.EZERPIU:
					break;
				default :
					break;
				}
				String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				/* 지출결의 결재 상태 동기화 */
				if (interProcessId.equals(commonCode.EXI) || interProcessId.equals(commonCode.EXU)
						|| interProcessId.equals(commonCode.EXA)) {
					result = ApprovalProcessExStatusInfoUpdate(params);
				}
				/* 이지바로 결재상태 동기화 */
				else if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EX -삭제 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* ################################################## */
	/* 지출결의 연계 */
	/* ################################################## */
	/* 지출결의 연계 - 이전 상태값 조회 */
	private String ApprovalProcessExStatusInfoSelect(Map<String, Object> params) throws Exception {
		String result = commonCode.EMPTYSTR;
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			/* 필수값 확인 - expendSeq */
			if (CommonConvert.CommonGetStr(expendSeq).equals(commonCode.EMPTYSTR)) {
				result = commonCode.EMPTYSTR;
				chkParameter = false;
			}
			if (chkParameter) {
				params.put(commonCode.EXPENDSEQ, expendSeq);
				result = dao.ApprovalProcessExStatusInfoSelect(params);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* 지출결의 연계 - 상태값 업데이트 */
	private InterlockExpendVO ApprovalProcessExStatusInfoUpdate(Map<String, Object> params) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			/* 필수값 확인 - expendSeq */
			if (CommonConvert.CommonGetStr(expendSeq).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : approKey = " + commonCode.APPROKEY + ".replace( "
						+ commonCode.PROCESSID + " + \"_EX_\", \"\" ) ");
				chkParameter = false;
			}
			/* 필수값 확인 - docSts */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSTS)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSTS);
				chkParameter = false;
			}
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)
					&& CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSEQ)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			if (chkParameter) {
				params.put(commonCode.EXPENDSEQ, expendSeq);
				result = dao.ApprovalProcessExStatusInfoUpdate(params);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* 지출결의 연계 - 카드 사용내역 상태값 동기화 */
	private InterlockExpendVO ApprovalProcessExCard(Map<String, Object> params, String sendYN) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			Map<String, Object> cardUpdateParam = new HashMap<String, Object>();
			/* 필수값 확인 - expendSeq */
			if (CommonConvert.CommonGetStr(expendSeq).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : approKey = " + commonCode.APPROKEY + ".replace( "
						+ commonCode.PROCESSID + " + \"_EX_\", \"\" ) ");
				chkParameter = false;
			}
			/* 필수값 확인 - sendYN */
			if (!(CommonConvert.CommonGetStr(sendYN).equals(commonCode.EMPTYYES))
					&& !(CommonConvert.CommonGetStr(sendYN).equals(commonCode.EMPTYNO))) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : sendYN");
				chkParameter = false;
			}
			/* 파라미터 정의 */
			cardUpdateParam.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
			cardUpdateParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
			cardUpdateParam.put(commonCode.EXPENDSEQ, CommonConvert.CommonGetStr(expendSeq));
			cardUpdateParam.put("sendYN", sendYN);
			/* 카드 사용내역 상태값 동기화 */
			if (chkParameter) {
				result = userCardService.ExUserCardStateListInfoUpdate(cardUpdateParam);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* 지출결의 연계 - 매입전자세금계산서 상태값 동기화 */
	private InterlockExpendVO ApprovalProcessExETax(Map<String, Object> params, String sendYN) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			Map<String, Object> etaxUpdateParam = new HashMap<String, Object>();
			/* 필수값 확인 - expendSeq */
			if (CommonConvert.CommonGetStr(expendSeq).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.EXPENDSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - sendYN */
			if (!(CommonConvert.CommonGetStr(sendYN).equals(commonCode.EMPTYYES))
					&& !(CommonConvert.CommonGetStr(sendYN).equals(commonCode.EMPTYNO))) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누라 : sendYN");
				chkParameter = false;
			}
			/* 파라미터 정의 */
			etaxUpdateParam.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
			etaxUpdateParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
			etaxUpdateParam.put(commonCode.EXPENDSEQ, CommonConvert.CommonGetStr(expendSeq));
			etaxUpdateParam.put("sendYN", sendYN);
			etaxUpdateParam.put("isApprovalEnd", Boolean.parseBoolean(params.get("isApprovalEnd").toString()));
			/* 매입전자세금계산서 상태값 동기화 */
			if (chkParameter) {
				result = userETaxService.ExUserETaxStateListInfoUpdate(etaxUpdateParam);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* 이지바로 연계 - 상태값 업데이트 */
	private InterlockExpendVO ApprovalProcessEzbaroStatusInfoUpdate(Map<String, Object> params) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String seq = approKey.replace(processId + "_", commonCode.EMPTYSTR);
			/* 필수값 확인 - expendSeq */
			if (CommonConvert.CommonGetStr(seq).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : approKey = " + commonCode.APPROKEY + ".replace( "
						+ commonCode.PROCESSID + " + \"_\", \"\" ) ");
				chkParameter = false;
			}
			/* 필수값 확인 - docSts */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSTS)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSTS);
				chkParameter = false;
			}
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)
					&& CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSEQ)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			if (chkParameter) {
				params.put(commonCode.SEQ, seq);
				if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSTS)).equals("90")) {
					result = dao.ApprovalEndProcessEzbaroStatusInfoUpdate(params);
				} else {
					result = dao.ApprovalProcessEzbaroStatusInfoUpdate(params);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	/* 지출결의서 ERP 전송기능 */
	private InterlockExpendVO ApprovalProcessExpendListInfoSend(Map<String, Object> params) {
		InterlockExpendVO result = new InterlockExpendVO();
		Map<String, Object> optionParam = new HashMap<>();

		String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
		String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
		String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
		String useSw = "";
		String advExpendDt = "";

		try {
			if(processId.equals(commonCode.EXU)) {
				useSw = commonCode.ERPIU;
			} else if(processId.equals(commonCode.EXI)) {
				useSw = commonCode.ICUBE;
			} else {
				useSw = commonCode.BIZBOXA;
			}

			/* 전자결재에서 겸직 회사 결재도 가능하기 때문에 docId로 해당 문서의 compSeq(co_id)를 구해옴 */
			String compSeq;
			try {
				Map<String, Object> docParam = new HashMap<>();
				docParam.put("groupSeq", CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
				docParam.put("docSeq", CommonConvert.CommonGetStr(params.get(commonCode.DOCID)));
				compSeq = userServiceA.ExDocCompSeqInfoSelect(docParam);

				if (compSeq == null || compSeq.isEmpty()) {
					compSeq = CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ));
				}
			} catch (Exception e) {
				compSeq = CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ));
			}

			optionParam.put("groupSeq", CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
			optionParam.put( "compSeq", compSeq);
			optionParam.put( "formSeq", CommonConvert.CommonGetStr(params.get("formId")) );
			optionParam.put( "useSw", useSw );
			optionParam.put( "optionCode", "003403" ); //종결시 자동전송 옵션

			ResultVO expendOption = configService.ExAdminConfigOptionSelect( optionParam );

			//해당 지출결의서 양식에 대해 환경설정이 저장되지 않은 경우
			if(expendOption.getAaData().size() == 0) {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("해당 지출결의서 양식의 환경설정이 저장되지 않았습니다.");

				return result;
			}

			ExpendVO expendVo = new ExpendVO();

			expendVo.setGroupSeq(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
			expendVo.setExpendSeq(expendSeq);

			//지출결의서 내용조회
			ExpendVO expendResult = userServiceA.ExUserExpendInfoSelect(expendVo);

			if(expendResult == null) {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("지출결의서가 존재하지 않습니다.");

				return result;
			} else {
				advExpendDt = expendResult.getExpendDate(); // 예산 미사용의 경우 이값 사용
			}

			Map<String, Object> sendParam = new HashMap<String, Object>();

			sendParam.put("groupSeq", CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)));
			sendParam.put("expendSeq", expendSeq);
			sendParam.put("autoSendYN", commonCode.EMPTYYES);
			sendParam.put("advExpendDt", advExpendDt);

			//전자결재 종결시 지출결의서 자동전송이 "사용"일 경우만 지출결의서 전송
			if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( commonCode.EMPTYYES ) ) {
				ResultVO sendResult = adminReportService.ExReportExpendSendListInfoSend(sendParam);

				//지출결의서 전송 성공시
				if(sendResult.getResultCode().equals(commonCode.SUCCESS)) {
					result.setResultCode(sendResult.getResultCode());
					result.setResultMessage(sendResult.getResultName());
				} else {
				//지출결의서 전송 실패시 전자결재 종결 프로세스에 영향을 주지 않기 위해 그냥 성공으로 리턴
					result.setResultCode(commonCode.SUCCESS);
					result.setResultMessage("ApprovalProcessExpendListInfoSend 전송실패 : " + sendResult.getResultName());
				}
			} else {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("지출결의서 자동전송 옵션이 미사용입니다.");
			}
		} catch(Exception e) {
			//지출결의서 전송 도중 오류가 발생하여도 종결 프로세스에 영향을 주지 않기 위해 그냥 성공으로 리턴
			result.setResultCode(commonCode.SUCCESS);
			result.setResultMessage("지출결의서 자동전송 중 오류발생가 발생하였습니다.");
			cmLog.CommonSetError(e);
		}

		return result;
	}

	@Override
	public ResultVO ApprovalSlipDetailInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			// result = dao.ApprovalSlipDetailInfoSelect( params );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO ApprovalMngDetailInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			// result = dao.ApprovalMngDetailInfoSelect( params );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO ApprovalSelectAttachInfo(Map<String, Object> params) throws Exception {
		/* 첨부 파일 정보 조회 */
		ResultVO result = dao.ApprovalSelectAttachInfo(params);
		if (result.getResultCode() == commonCode.SUCCESS) {
			ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) result.getAaData();
			String listIds = "";
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> item = list.get(i);
				listIds += "⊙" + item.get("listSeq").toString();
			}
			result.setResultName(listIds);
		} else {
			result.setResultName(commonCode.EMPTYSTR);
			result.setResultCode(commonCode.FAIL);
		}
		return result;
	}

	@Override
	public ResultVO SelectApprovalAttachInfo(Map<String, Object> params) throws Exception {
		return dao.SelectApprovalAttachInfo(params);
	}

	@Override
	public ResultVO SelectApprovalListInfo(Map<String, Object> params) throws Exception {
		return dao.SelectApprovalListInfo(params);
	}

	@Override
	public ResultVO SelectApprovalSlipInfo(Map<String, Object> params) throws Exception {
		return dao.SelectApprovalSlipInfo(params);
	}

	/* ################################################## */
	/* 국고보조통합시스템 연계 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessSaveAngu(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO();
			String processId = commonCode.EMPTYSTR;
			String approKey = commonCode.EMPTYSTR;
			String anbojoSeq = commonCode.EMPTYSTR;
			Map<String, Object> updateParams = new HashMap<String, Object>();
			List<Map<String, Object>> abdocu = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> abdocuB = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> abdocuT = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> abdocuP = new ArrayList<Map<String, Object>>();
			/* 기본값 정의 */
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
					CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
			processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			anbojoSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			if (CommonConvert.CommonGetStr(params.get("anbojoSeq")).equals(commonCode.EMPTYSTR)) {
				params.put("anbojoSeq", anbojoSeq);
			}
			/* 기본값 정의 - 결의집행 조회 */
			abdocu = anguADao.AbdocuS(params);
			for (Map<String, Object> map : abdocu) {
				updateParams = new HashMap<String, Object>();
				updateParams.put("dSeq", CommonConvert.CommonGetSeq(map.get("dSeq")));
				updateParams.put("anbojoSeq", anbojoSeq);
				map = anguIDao.AbdocuI(map, conVo);
				updateParams.put("MOSF_GISU_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_GISU_SQ")));
				anguADao.AbdocuGisuSqU(updateParams);
			}
			/* 기본값 정의 - 비목정보 조회 */
			abdocuB = anguADao.AbdocuBS(params);
			for (Map<String, Object> map : abdocuB) {
				updateParams = new HashMap<String, Object>();
				updateParams.put("dSeq", CommonConvert.CommonGetSeq(map.get("dSeq")));
				updateParams.put("bSeq", CommonConvert.CommonGetSeq(map.get("bSeq")));
				updateParams.put("anbojoSeq", anbojoSeq);
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				map = anguIDao.AbdocuBI(map, conVo);
				updateParams.put("MOSF_BG_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_BG_SQ")));
				anguADao.AbdocuBgSqU(updateParams);
			}
			/* 기본값 정의 - 재원정보 조회 */
			abdocuT = anguADao.AbdocuTS(params);
			for (Map<String, Object> map : abdocuT) {
				updateParams = new HashMap<String, Object>();
				updateParams.put("dSeq", CommonConvert.CommonGetSeq(map.get("dSeq")));
				updateParams.put("bSeq", CommonConvert.CommonGetSeq(map.get("bSeq")));
				updateParams.put("tSeq", CommonConvert.CommonGetSeq(map.get("tSeq")));
				updateParams.put("anbojoSeq", anbojoSeq);
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				map.put("MOSF_BG_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_BG_SQ")));
				map.put("SPLPC", CommonConvert.CommonGetDouble(map.get("SPLPC")));
				map.put("VAT", CommonConvert.CommonGetDouble(map.get("VAT")));
				map.put("SUM_AMOUNT", CommonConvert.CommonGetDouble(map.get("SUM_AMOUNT")));
				map = anguIDao.AbdocuTI(map, conVo);
				updateParams.put("MOSF_LN_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_LN_SQ")));
				anguADao.AbdocuInSqU(updateParams);
			}
			/* 기본값 정의 - 인력정보 조회 */
			abdocuP = anguADao.AbdocuPS(params);
			for (Map<String, Object> map : abdocuP) {
				updateParams = new HashMap<String, Object>();
				updateParams.put("dSeq", CommonConvert.CommonGetSeq(map.get("dSeq")));
				updateParams.put("bSeq", CommonConvert.CommonGetSeq(map.get("bSeq")));
				updateParams.put("tSeq", CommonConvert.CommonGetSeq(map.get("tSeq")));
				updateParams.put("pSeq", CommonConvert.CommonGetSeq(map.get("pSeq")));
				updateParams.put("anbojoSeq", anbojoSeq);
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				map.put("MOSF_BG_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_BG_SQ")));
				map.put("MOSF_LN_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_LN_SQ")));
				map.put("PRRT", CommonConvert.CommonGetDouble(map.get("PRRT")));
				map.put("PYMNT_AMOUNT", CommonConvert.CommonGetDouble(map.get("PYMNT_AMOUNT")));
				map.put("NDEP_AM", CommonConvert.CommonGetDouble(map.get("NDEP_AM")));
				map.put("INAD_AM", CommonConvert.CommonGetDouble(map.get("INAD_AM")));
				map.put("INTX_AM", CommonConvert.CommonGetDouble(map.get("INTX_AM")));
				map.put("RSTX_AM", CommonConvert.CommonGetDouble(map.get("RSTX_AM")));
				map.put("WD_AM", CommonConvert.CommonGetDouble(map.get("WD_AM")));
				map.put("HIFE_AM", CommonConvert.CommonGetDouble(map.get("HIFE_AM")));
				map.put("NAPE_AM", CommonConvert.CommonGetDouble(map.get("NAPE_AM")));
				map.put("DDCT_AM", CommonConvert.CommonGetDouble(map.get("DDCT_AM")));
				map.put("NOIN_AM", CommonConvert.CommonGetDouble(map.get("NOIN_AM")));
				map.put("WD_AM2", CommonConvert.CommonGetDouble(map.get("WD_AM2")));
				map.put("ETCRATE", CommonConvert.CommonGetDouble(map.get("ETCRATE")));
				map = anguIDao.AbdocuPI(map, conVo);
				updateParams.put("HNF_REGIST_SN", CommonConvert.CommonGetSeq(map.get("HNF_REGIST_SN")));
				anguADao.AbdocuRegistSnU(updateParams);
			}
			/* iCUBE 상태값 조회 */
			updateParams = new HashMap<String, Object>();
			updateParams.put("gwState", "0");
			updateParams.put("anbojoSeq", CommonConvert.CommonGetStr(anbojoSeq));
			List<Map<String, Object>> syncList = anguADao.AbdocuSyncInfoS(updateParams);
			for (Map<String, Object> map : syncList) {
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				anguIDao.AbdocuSyncInfoU(map, conVo);
			}
			/* 반환값 정의 */
			result.setResultCode(commonCode.SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			// rollback 수행
			/* iCUBE 재원내역 삭제 */
			/* iCUBE 비목내역 삭제 */
			/* iCUBE 결의 + 증빙내역 삭제 */
			/* 결의 + 증빙내역 복원 */
			/* 비목내역 복원 */
			/* 재원내역 복원 */
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage(e.getMessage());
		}
		return result;
	}

	/* 종결 */
	public InterlockExpendVO ApprovalProcessEndAngu(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO();
			String processId = commonCode.EMPTYSTR;
			String approKey = commonCode.EMPTYSTR;
			String anbojoSeq = commonCode.EMPTYSTR;
			Map<String, Object> updateParams = new HashMap<String, Object>();
			/* 기본값 정의 */
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
					CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
			processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			anbojoSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			if (CommonConvert.CommonGetStr(params.get("anbojoSeq")).equals(commonCode.EMPTYSTR)) {
				params.put("anbojoSeq", anbojoSeq);
			}
			/* 반려처리 */
			updateParams = new HashMap<String, Object>();
			updateParams.put("gwState", "1");
			updateParams.put("anbojoSeq", CommonConvert.CommonGetStr(anbojoSeq));
			List<Map<String, Object>> syncList = anguADao.AbdocuSyncInfoS(updateParams);
			for (Map<String, Object> map : syncList) {
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				anguIDao.AbdocuSyncInfoU(map, conVo);
			}
			/* 반환값 정의 */
			result.setResultCode(commonCode.SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			// rollback 수행
			/* iCUBE 재원내역 삭제 */
			/* iCUBE 비목내역 삭제 */
			/* iCUBE 결의 + 증빙내역 삭제 */
			/* 결의 + 증빙내역 복원 */
			/* 비목내역 복원 */
			/* 재원내역 복원 */
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage(e.getMessage());
		}
		return result;
	}

	/* 반려 */
	public InterlockExpendVO ApprovalProcessReturnAngu(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO();
			String processId = commonCode.EMPTYSTR;
			String approKey = commonCode.EMPTYSTR;
			String anbojoSeq = commonCode.EMPTYSTR;
			Map<String, Object> updateParams = new HashMap<String, Object>();
			/* 기본값 정의 */
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
					CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
			processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			anbojoSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			if (CommonConvert.CommonGetStr(params.get("anbojoSeq")).equals(commonCode.EMPTYSTR)) {
				params.put("anbojoSeq", anbojoSeq);
			}
			/* 반려처리 */
			updateParams = new HashMap<String, Object>();
			updateParams.put("gwState", "1");
			updateParams.put("anbojoSeq", CommonConvert.CommonGetStr(anbojoSeq));
			List<Map<String, Object>> syncList = anguADao.AbdocuSyncInfoS(updateParams);
			for (Map<String, Object> map : syncList) {
				map.put("EXTER_FG", "-GW");
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetDouble(map.get("MOSF_GISU_SQ")));
				anguIDao.AbdocuSyncInfoU(map, conVo);
			}
			/* 반환값 정의 */
			result.setResultCode(commonCode.SUCCESS);
		} catch (Exception e) {
			// TODO: handle exception
			// rollback 수행
			/* iCUBE 재원내역 삭제 */
			/* iCUBE 비목내역 삭제 */
			/* iCUBE 결의 + 증빙내역 삭제 */
			/* 결의 + 증빙내역 복원 */
			/* 비목내역 복원 */
			/* 재원내역 복원 */
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage(e.getMessage());
		}
		return result;
	}

	/* 품의서 상신 */
	public InterlockExpendVO ApprovalProcessSaveCons(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npCons.updateConsDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 품의서 종결 */
	public InterlockExpendVO ApprovalProcessEndCons(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault() );
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npCons.updateConsDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 품의서 반려 */
	public InterlockExpendVO ApprovalProcessReturnCons(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npCons.updateConsDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 품의서 삭제 */
	public InterlockExpendVO ApprovalProcessDeleteCons(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npCons.updateConsDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 결의서 상신 */
	public InterlockExpendVO ApprovalProcessSaveRes(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npRes.updateResDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				} else {
					params.put("sendYN", "Y");
					npCode.UpdateInterfaceInfo(params);
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 결의서 종결 */
	public InterlockExpendVO ApprovalProcessEndRes(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npRes.updateResDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				}
			}
			
			/** 
			 * 지출결의 자동 전송 진행
			 * 독립된 객체로 오류가 발생하여도 롤백하지 않음. */
			/* 1. 자동 전송 옵션 조회 */
			ResultVO optionResult = new ResultVO( );
			boolean autoSend = false;
			try{
				cmLog.CommonSetInfoToDatabase( "[INFO] #EXNP#  #. ================ AUTO SEND SELECT OPT START ==================] " + params.toString( ) ,CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
				optionResult = npOption.selectBasicOptionSendType( params );
				cmLog.CommonSetInfoToDatabase( "[INFO] #EXNP#  #. ================ AUTO SEND SELECT OPT END ==================] " + optionResult.getaData( ).get( "value" ).toString( ) ,CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
				if(optionResult.getaData( ).get( "value" ) == null){
					optionResult.setFail( "aData 누락" );	
				}
			}catch(Exception ex){
				cmLog.CommonSetInfoToDatabase( "[   [ERROR] #EXNP# @Service FApprovalServiceAImpl] " + ex.getMessage( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
				optionResult.setFail( ex.toString( ) );
			}
			/* 2. 옵션 코드 확인 / 오류 발생시 무시 */
			if(optionResult.getResultCode( ).equals( commonCode.SUCCESS )){
				if(optionResult.getaData( ).get( "value" ).toString( ).equals( "1" )){
					autoSend = true;
				}
			}

			/*3.  자동 전송  */
			if( autoSend ){
				try{
					cmLog.CommonSetInfoToDatabase( "[INFO] #EXNP#  #. ================ AUTO SEND CREATE CONNECTION VO ==================] " + params.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
					ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(
							CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)),
							CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ))
					);
					cmLog.CommonSetInfoToDatabase( "[INFO] #EXNP#  #. ================ AUTO SEND COMPLETE CONNECTION VO ==================] " + params.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
					
					/* 지출결의 전송 진행 */
					ResultVO sendResult = reportService.insertResSend( params, conVo );
				}catch(Exception ex){
					cmLog.CommonSetInfoToDatabase( "[   [ERROR] #EXNP# @Service FApprovalServiceAImpl] " + ex.getMessage( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
					ex.printStackTrace();
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 결의서 반려 */
	public InterlockExpendVO ApprovalProcessReturnRes(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npRes.updateResDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				} else {
					params.put("sendYN", "N");
					npCode.UpdateInterfaceInfo(params);
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 결의서 삭제 */
	public InterlockExpendVO ApprovalProcessDeleteRes(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - docSeq */
			if (CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ)).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + commonCode.DOCSEQ);
				chkParameter = false;
			}
			/* 필수값 확인 - docStatus */
			if (CommonConvert.CommonGetStr(params.get("docStatus")).equals(commonCode.EMPTYSTR)) {
				result.setResultCode(commonCode.FAIL);
				result.setResultMessage("parameter 누락 : " + "docStatus");
				chkParameter = false;
			}
			/* 필수값 확인 - expendDt */
			if (CommonConvert.CommonGetStr(params.get(commonCode.EXPENDDT)).equals(commonCode.EMPTYSTR)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
				Date nowDate = new Date();
				params.put(commonCode.EXPENDDT, sdf.format(nowDate));
			}
			if (chkParameter) {
				ResultVO daoResult = new ResultVO();
				daoResult = npRes.updateResDocEaInfo(params);
				if (daoResult.getResultCode().equals(commonCode.FAIL)) {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage(daoResult.getResultName());
					return result;
				} else {
					params.put("sendYN", "N");
					npCode.UpdateInterfaceInfo(params);
				}
			}
		} catch (Exception e) {
			result.setResultCode(commonCode.FAIL);
			result.setResultMessage("EXNP -상신 프로세스 오류 발생 : " + commonCode.PROCESSID);
		}
		return result;
	}

	/* 결재문서 정보 조회 */
	public ResultVO ApprovalInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setaData(dao.ApprovalInfoSelect(params));
			result.setResultCode(commonCode.SUCCESS);
		} catch (Exception e) {
			result.setFail(e.getMessage());
		}
		return result;
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 */
	/* 품의서 2.0 / 결의서 2.0 외부 연동 - API 호출 */
	public void NpOutInterface(Map<String, Object> params) throws Exception {
		if (params != null) {
			NpOutInterfaceVO outInterfaceVo = new NpOutInterfaceVO();
			outInterfaceVo.setGroupSeq(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ))); /* 그룹 시퀀스 */
			outInterfaceVo.setCompSeq(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ))); /* 회사 시퀀스 */
			outInterfaceVo.setBizSeq(CommonConvert.CommonGetStr(params.get(commonCode.BIZSEQ))); /* 사업장 시퀀스 */
			outInterfaceVo.setDeptSeq(CommonConvert.CommonGetStr(params.get(commonCode.DEPTSEQ))); /* 부서 시퀀스 */
			outInterfaceVo.setEmpSeq(CommonConvert.CommonGetStr(params.get(commonCode.EMPSEQ))); /* 사원 시퀀스 */

			if(params.containsKey(commonCode.CONSDOCSEQ)){
				/* 품의서 2.0 */
				outInterfaceVo.setConsDocSeq(CommonConvert.CommonGetStr(params.get(commonCode.CONSDOCSEQ))); /* 품의서 문서 시퀀스 */
				outInterfaceVo = ConsOutInterfaceSelect(outInterfaceVo); /* interface 정보 조회 */
			} else if(params.containsKey(commonCode.RESDOCSEQ)){
				/* 결의서 2.0 */
				outInterfaceVo.setResDocSeq(CommonConvert.CommonGetStr(params.get(commonCode.RESDOCSEQ))); /* 결의서 문서 시퀀스 */
				outInterfaceVo = ResOutInterfaceSelect(outInterfaceVo); /* interface 정보 조회 */
			}

			outInterfaceVo.setInterfaceType(CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))); /* 전자결재 프로세스 아이디 */
			outInterfaceVo.setApprovalStatusCode(CommonConvert.CommonGetStr(params.get(commonCode.DOCSTS))); /* 전자결재 문서 상태 */

			switch (outInterfaceVo.getApprovalStatusCode()) {
			case "10":
				outInterfaceVo.setInterfaceUrl(outInterfaceVo.getInterfaceCallSave()); /* 보관, 상신취소 */
				break;
			case "20":
			case "002":
				outInterfaceVo.setInterfaceUrl(outInterfaceVo.getInterfaceCallApproval()); /* 상신 */
				break;
			case "90":
			case "008":
				outInterfaceVo.setInterfaceUrl(outInterfaceVo.getInterfaceCallEnd()); /* 종결 */
				break;
			case "100":
			case "007":
				outInterfaceVo.setInterfaceUrl(outInterfaceVo.getInterfaceCallReturn()); /* 반려 */
				break;
			case "999":
			case "d":
				outInterfaceVo.setInterfaceUrl(outInterfaceVo.getInterfaceCallDelete()); /* 삭제 */
				break;
			default :
				break;
			}

			if(!(outInterfaceVo.getInterfaceUrl().equals(""))){
				JSONObject interfaceParam = new JSONObject();
				interfaceParam.put("outProcessInterfaceId", CommonConvert.CommonGetStr(outInterfaceVo.getInterfaceId()));
				interfaceParam.put("outProcessInterfaceMId", CommonConvert.CommonGetStr(outInterfaceVo.getOutProcessInterfaceMId()));
				interfaceParam.put("outProcessInterfaceDId", CommonConvert.CommonGetStr(outInterfaceVo.getOutProcessInterfaceDId()));
				interfaceParam.put("consDocSeq", CommonConvert.CommonGetStr(outInterfaceVo.getConsDocSeq()));
				interfaceParam.put("resDocSeq", CommonConvert.CommonGetStr(outInterfaceVo.getResDocSeq()));
				interfaceParam.put("docSts", CommonConvert.CommonGetStr(outInterfaceVo.getApprovalStatusCode()));

				interfaceParam.put("groupSeq", CommonConvert.CommonGetStr(outInterfaceVo.getGroupSeq()));
				interfaceParam.put("compSeq", CommonConvert.CommonGetStr(outInterfaceVo.getCompSeq()));
				interfaceParam.put("bizSeq", CommonConvert.CommonGetStr(outInterfaceVo.getBizSeq()));
				interfaceParam.put("deptSeq", CommonConvert.CommonGetStr(outInterfaceVo.getDeptSeq()));
				interfaceParam.put("empSeq", CommonConvert.CommonGetStr(outInterfaceVo.getEmpSeq()));

				outInterfaceVo.setInterfaceParam(interfaceParam.toString());

				JSONObject interfaceResult = new JSONObject();
				interfaceResult = JSONObject.fromObject(HttpJsonUtil.execute(commonCode.POST, CommonConvert.CommonGetStr(outInterfaceVo.getInterfaceUrl()), interfaceParam));
				outInterfaceVo.setInterfaceResult(interfaceResult.toString());

				OutInterfaceHisInsert(outInterfaceVo);
			}
		}
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 품의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ConsOutInterfaceSelect(NpOutInterfaceVO params) throws Exception {
		NpOutInterfaceVO result = new NpOutInterfaceVO();
		result = dao.ConsOutInterfaceSelect(params);

		params.setInterfaceId(result.getInterfaceId());
		params.setIframeUrl(result.getIframeUrl());
		params.setIframeHeight(result.getIframeHeight());
		params.setInterfaceCallSave(result.getInterfaceCallSave());
		params.setInterfaceCallApproval(result.getInterfaceCallApproval());
		params.setInterfaceCallReturn(result.getInterfaceCallReturn());
		params.setInterfaceCallEnd(result.getInterfaceCallEnd());
		params.setInterfaceCallDelete(result.getInterfaceCallDelete());
		params.setLicence(result.getLicence());
		params.setOutProcessInterfaceMId(result.getOutProcessInterfaceMId());
		params.setOutProcessInterfaceDId(result.getOutProcessInterfaceDId());

		return params;
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 결의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ResOutInterfaceSelect(NpOutInterfaceVO params) throws Exception {
		NpOutInterfaceVO result = new NpOutInterfaceVO();
		result = dao.ResOutInterfaceSelect(params);
		if(result == null){ result = new NpOutInterfaceVO(); }

		params.setInterfaceId(result.getInterfaceId());
		params.setIframeUrl(result.getIframeUrl());
		params.setIframeHeight(result.getIframeHeight());
		params.setInterfaceCallSave(result.getInterfaceCallSave());
		params.setInterfaceCallApproval(result.getInterfaceCallApproval());
		params.setInterfaceCallReturn(result.getInterfaceCallReturn());
		params.setInterfaceCallEnd(result.getInterfaceCallEnd());
		params.setInterfaceCallDelete(result.getInterfaceCallDelete());
		params.setLicence(result.getLicence());
		params.setOutProcessInterfaceMId(result.getOutProcessInterfaceMId());
		params.setOutProcessInterfaceDId(result.getOutProcessInterfaceDId());

		return params;
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 호출 이력 기록 */
	public void OutInterfaceHisInsert(NpOutInterfaceVO params) throws Exception {
		dao.OutInterfaceHisInsert(params);
	}

	@Override
	public String SelectAdvInterInfoCount ( Map<String, Object> params ) throws Exception {
		String result = "N";
		try{
			result = dao.SelectAdvInterInfoCount( params ).get( "advUseYn" ).toString( );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
			return "N";
		}
		return result;
	}

	@Override
	public Map<String, Object> SelectAdvInterInfo ( Map<String, Object> params ) throws Exception {
		Map<String, Object> result =  new HashMap<String, Object>();
		try{
			result = dao.SelectAdvInterInfo( params );
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
		}
		return result;
	}

	@Override
	public InterlockExpendVO ApprovalProcessTripCons ( Map<String, Object> params ) throws Exception {
		try{
			// do nothing
		}catch(Exception ex){
			cmLog.CommonSetError( ex );
		}
		return null;
	}

	@Override
	public InterlockExpendVO ApprovalProcessTripRes ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO SelectICubeCard_EXP ( Map<String, Object> params ) throws Exception {
		// 미사용, FApprovalServiceAImpl 에서 전자결재 구분 없이 일괄처리 진행
		return null;
	}

	@Override
	public ResultVO SelectICubeCard_NP ( Map<String, Object> params ) throws Exception {
		// 미사용, FApprovalServiceAImpl 에서 전자결재 구분 없이 일괄처리 진행
		return null;
	}

	@Override
	public ResultVO SelectICubeCardKey ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}