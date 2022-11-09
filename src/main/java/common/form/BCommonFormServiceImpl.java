package common.form;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.form.InterlockConfHtmlVO;
import common.vo.form.InterlockHtmlVO;
import common.vo.form.InterlockNPHTMLVO;
import common.vo.form.InterlockSubtotalHtmlVO;
import common.vo.np.NpOutInterfaceVO;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.report.BExUserReportService;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.report.BNpUserReportService;
import expend.np.user.res.BNpUserResService;
import interlock.exp.approval.FApprovalService;
import interlock.exp.approval.FApprovalServiceADAO;
import neos.cmm.util.HttpJsonUtil;
import net.sf.json.JSONObject;

@Service("BCommonFormService")
public class BCommonFormServiceImpl implements BCommonFormService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource(name = "FApprovalServiceP")
	private FApprovalService eapService;
	@Resource(name = "BExUserReportService")
	private BExUserReportService userReportService;
	@Resource(name = "BExUserCodeService")
	private BExUserCodeService codeService;
	@Resource(name = "BNpUserConsService")
	private BNpUserConsService consService;
	@Resource(name = "BNpUserResService")
	private BNpUserResService resService;
	/* 변수정의 - DAO */
	@Resource(name = "FCommonFormBizboxDAO")
	private FCommonFormBizboxDAO dao;
	/* 변수정의 - Common */
	@Resource(name = "CommonLogger")
	private CommonLogger cmLog;
	@Resource(name = "BNpUserReportService")
	private BNpUserReportService userNPReportService;
	@Resource(name = "BNpUserBudgetService")
	private BNpUserBudgetService npBudgetService;
	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo;
	@Resource(name = "FApprovalServiceADAO")
	private FApprovalServiceADAO eaDao;

	/**
	 * 소속 회사의 지출결의 양식 목록조회
	 */
	@Override
	public ResultVO CommonFormSendParam(Map<String, Object> params) throws Exception {
		ResultVO resultVo = new ResultVO();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
			result = dao.CommonFormSendParam(params);
			resultVo.setAaData(result);
			resultVo.setResultCode(commonCode.SUCCESS);
			resultVo.setResultName(commonCode.SUCCESS);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			resultVo.setResultCode(commonCode.FAIL);
			resultVo.setResultName(e.getMessage());
		}
		return resultVo;
	}

	/**
	 * 양식 상세정보 호출 sample { needSample? sample codes.. } formInfo { 양식 명칭등 데이터.. }
	 * formCode [code1 : {코드 정보}, code2 : {코드 정보} ... ] form { 본문 html code. }
	 */
	@Override
	public ResultVO CommonFormDataInfo(Map<String, Object> params) throws Exception {
		ResultVO resultVo = new ResultVO();
		Map<String, Object> result = new HashMap<String, Object>();
		String step = "";
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("empSeq", loginVo.getUniqId());
		params.put("compSeq", loginVo.getCompSeq());
		try {
			params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
			String needSample = "Y";
			step = "Access to parameter needSample.";
			if (params.get("needSample") != null) {
				needSample = params.get("needSample").toString();
			}
			/* 1. HTML sample codes. */
			if (needSample.equals("Y")) {
				result.put("samples", dao.CommonFormSampleInfoSelect(params));
			}
			step = "Success / find sample codes";
			/* 2. 양식 기본 정보 조회 */
			result.put("formInfo", dao.CommonFormDataInfo(params));
			step = "Success / find common info";
			/* 3. 양식 아이템 코드 정보 조회 */
			if (needSample.equals("Y")) {
				result.put("formCode", dao.CommonFormCodeInfoSelect(params));
				step = "Success / find common code";
			}
			/* 4. 본문 양식 정보 조회 */
			result.put("form", dao.CommonFormDetailInfo(params));
			step = "Success / find form";
			resultVo.setResultCode(commonCode.SUCCESS);
			resultVo.setaData(result);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			resultVo.setResultCode(step);
			resultVo.setResultName(e.toString());
		}
		return resultVo;
	}

	/**
	 * 비영리 양식 상세정보 호출 sample { needSample? sample codes.. } formInfo { 양식 명칭등 데이터..
	 * } formCode [code1 : {코드 정보}, code2 : {코드 정보} ... ] form { 본문 html code. }
	 */
	@Override
	public ResultVO CommonNPFormDataInfo(Map<String, Object> params) throws Exception {
		ResultVO resultVo = new ResultVO();
		Map<String, Object> result = new HashMap<String, Object>();
		String step = "";
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		params.put("empSeq", loginVo.getUniqId());
		params.put("compSeq", loginVo.getCompSeq());
		params.put("groupSeq", loginVo.getGroupSeq());
		try {
			params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
			String needSample = "Y";
			step = "Access to parameter needSample.";
			if (params.get("needSample") != null) {
				needSample = params.get("needSample").toString();
			}
			/* 1. HTML sample codes. */
			if (needSample.equals("Y")) {
				result.put("samples", dao.CommonNPFormSampleInfoSelect(params));
			}
			step = "Success / find sample codes";
			/* 2. 양식 기본 정보 조회 */
			result.put("formInfo", dao.CommonNPFormDataInfo(params).get("formContent"));
			step = "Success / find common info";
			/* 3. 양식 아이템 코드 정보 조회 */
			if (needSample.equals("Y")) {
				result.put("formCode", dao.CommonNPFormCodeInfoSelect(params));
				step = "Success / find common code";
			}
			/* 4. 본문 양식 정보 조회 */
			result.put("form", dao.CommonNpFormDetailInfo(params).get("formContent"));
			step = "Success / find form";
			resultVo.setResultCode(commonCode.SUCCESS);
			resultVo.setaData(result);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			resultVo.setResultCode("step : " + step);
			resultVo.setResultName(e.toString());
		}
		return resultVo;
	}

	/* 양식 저장 */
	@Override
	public int CommonFormSave(Map<String, Object> params) throws Exception {
		int result = 0;
		/* 기존값 지정 - 사용자 정보 처리 */
		try {
			params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
			result = dao.CommonFormInfoInsert(params);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/* 양식 저장 */
	@Override
	public int CommonNpFormSave(Map<String, Object> params) throws Exception {
		int result = 0;
		/* 기존값 지정 - 사용자 정보 처리 */
		try {
			params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
			result = dao.CommonNpFormInfoInsert(params);
		} catch (Exception e) {
			cmLog.CommonSetError(e);
			throw e;
		}
		return result;
	}

	/**
	 * 지출결의 인터락 양식 만들기 params { html : 양식설정 테스트 모드의 경우 사용. testYN : [, Y] }
	 */
	@SuppressWarnings("unchecked")
	@Override
	public ResultVO NPDocMaker(Map<String, Object> params) throws Exception {
		/* 결과 객체 ResultVO */
		ResultVO result = new ResultVO();
		/* interlock HTML 결과 저장 */
		String html = "";
		/* 사용자 login 정보 조회 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		/* 인터락 정보 테스트 모드 */
		String testMode = "N";
		ConnectionVO conVo = cmInfo
				.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
		/**
		 * 품의/결의서 헤더 정보 [Map<String, Object>]
		 */
		Map<String, Object> headData = new HashMap<String, Object>();
		/**
		 * 품의/결의서 합계 정보 [Map<String, Object>]
		 */
		Map<String, Object> footerData = new HashMap<String, Object>();
		/**
		 * 품의/결의서 본문 데이터 정보 constents [ / 메인 컨텐츠 컨테이너 project [ / 프로젝트(품의/결의) 리스트 budget
		 * [ / 예산 정보 리스트 (기본 복수 예산 지원) trade [ / 거래처 리스트 ] ] ] ]
		 */
		Map<String, Object> contentsData = new HashMap<>();
		/*******************************************************************
		 * inserlock 양식정보 [비영리] 생성 시작
		 *******************************************************************/
		/** 1. 양식정보 검증 **/
		html = params.get("html").toString();
		/** [+] 외부 연동 양식 선처리 진행 **/
		if (html.contains("_ADV_INTER_GROUPSEQ_")) {
			try {
				/* 1. 테스트 모드의 경우 2차 연동 무시 */
				if ((params.get("testYN") != null) && (params.get("testYN").toString().equals("Y"))) {
					html.replaceAll("_ADV_INTER_GROUPSEQ_", "테스트 모드는 지원하지 않습니다.");
				}
				/* 2. 품의/결의서 2차 연동 시스템 정보 조회 */
				ResultVO interfaceVo = userNPReportService.ExReportAdvInterLockInfoSelect(params);
				Map<String, Object> outProcessParam = new HashMap<>();
				if (!CommonConvert.CommonGetStr(interfaceVo.getResultCode()).equals(commonCode.SUCCESS)) {
					throw new Exception("외부 시스템 연동 조회에 실패하였습니다.");
				}
				/*
				 * 3. 파라미터 객체화 파라미터 정보 outProcessInterfaceId /
				 * t_exnp_doc.out_process_interface_id outProcessInterfaceMId /
				 * t_exnp_doc.out_process_interface_m_id outProcessInterfaceDId /
				 * t_exnp_doc.out_process_interface_d_id consDocSeq / t_exnp_doc.cons_doc_seq
				 * resDocSeq / t_exnp_doc.res_doc_seq docSts / 0 (고정 값)
				 */
				outProcessParam = interfaceVo.getaData();
				if (!CommonConvert.CommonGetStr(outProcessParam.get("outProcessInterfaceId"))
						.equals(commonCode.EMPTYSTR)) {
					/* 4. 외부 시스템 양식 호출 */
					NpOutInterfaceVO outInterfaceVo = new NpOutInterfaceVO();
					NpOutInterfaceVO p = new NpOutInterfaceVO();
					String resultCode = "";
					String resultMessage = "";
					String resultContent = "";
					if (params.get("processId").toString().indexOf("EXNPCON") > -1) {
						p.setConsDocSeq(outProcessParam.get("consDocSeq").toString());
						outInterfaceVo = eaDao.ConsOutInterfaceSelect(p);
					} else if (params.get("processId").toString().indexOf("EXNPRES") > -1) {
						p.setResDocSeq(outProcessParam.get("resDocSeq").toString());
						outInterfaceVo = eaDao.ResOutInterfaceSelect(p);
					}
					if (!CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(outInterfaceVo.getInterfaceCallForm()))
							.equals("")) {
						JSONObject interfaceParam = new JSONObject();
						interfaceParam = CommonConvert.CommonGetMapToJSONObj(outProcessParam);
						JSONObject interfaceResult = new JSONObject();
						interfaceResult = JSONObject.fromObject(HttpJsonUtil.execute(commonCode.POST,
								CommonConvert.CommonGetStr(outInterfaceVo.getInterfaceCallForm()), interfaceParam));
						/* 5. 2차 외부 시스템 연동 모듈 호출 결과 */
						resultCode = CommonConvert.CommonGetStr(interfaceResult.get("resultCode"));
						resultMessage = CommonConvert.CommonGetStr(interfaceResult.get("resultMessage"));
						resultContent = CommonConvert.CommonGetStr(interfaceResult.get("resultContent"));
						if (resultCode.equals(commonCode.FAIL)) {
							throw new Exception(resultMessage);
						}
					}
					/* 6. 조회된 양식코드 치환 */
					html = html.replaceAll("_ADV_INTER_GROUPSEQ_", resultContent);
				} else {
					/* 외부 시스템 연동 문서가 아닌 경우 */
					html = html.replaceAll("_ADV_INTER_GROUPSEQ_", commonCode.EMPTYSTR);
				}

			} catch (Exception ex) {
				throw new Exception(
						"[ERROR] throw Exception When Calling adv inter system. MESSAGE : " + ex.getMessage());
			}
		}

		/** 2. 테스트 모드 확인 **/
		if ((params.get("testYN") != null) && (params.get("testYN").toString().equals("Y"))) {
			/* 3-1. 비영리 양식 테스트 데이터 조회 */
			headData = GetNPHeadSampleData();
			footerData = GetNPFooterSampleData();
			contentsData = GetNPContentsSampleData();
			testMode = "Y";
		} else {
			/* 3-2. 양식에 들어갈 실제 데이터 조회 */
			ResultVO headResultVO = userNPReportService.ExReportHeaderInterLockInfoSelect(params);
			ResultVO footerResultVO = userNPReportService.ExReportFooterInterLockInfoSelect(params);
			ResultVO contentsResultVO = new ResultVO();
			if (0 == 1) {
				/* 통합 결의서 구조 [ 미개발 ] */
				contentsResultVO = userNPReportService.ExReportContentsInterLockInfoSelect(params);
			} else if (1 == 1) {
				/* 분할 결의서 구조 - 1차 지원 분할 결의서 구조 */
				contentsResultVO = userNPReportService.ExReportDContentsInterLockInfoSelect(params);
			}
			/* 헤더 정보 검증 */
			if ((CommonConvert.CommonGetStr(headResultVO.getResultCode()).equals(commonCode.SUCCESS))
					&& (headResultVO.getAaData().size() == 1)) {
				headData = headResultVO.getAaData().get(0);
				headData.put("erpTypeCode", conVo.getErpTypeCode());
				/* 품의 예산정보 조회 */
				Map<String, Object> hConsBudget = npBudgetService.selectConsBudgetBalance(headData).getaData();
				/* 결의 예산정보 조회 */
				Map<String, Object> hResBudget = npBudgetService.selectResUseAmt(headData).getaData();
				/**
				 * [ 품의서 ] 기준 코드 / 비영리 스타일 1번 예산
				 */
				/* 예산별 품의 잔액 */
				double consAmt = objectToDouble(hConsBudget.get("balanceAmt"));
				/**
				 * [ 결의서 ] 기준 코드 / 비영리 스타일 1번 예산
				 */
				/* 미전송 결의액 */
				double resAmt = objectToDouble(hResBudget.get("resBudgetAmt"));
				double resStdAmt = objectToDouble(hResBudget.get("resBudgetStdAmt"));
				double resTaxAmt = objectToDouble(hResBudget.get("resBudgetTaxAmt"));
				resStdAmt = resAmt - resTaxAmt;
				/**
				 * [ 상신문서 ] 현재 문서[품의/결의 공통] / 비영리 스타일 1번 예산
				 */
				/* ERP 예산 편성금액 */
				double erpOpenAmt = objectToDouble(headData.get("erpOpenAmt"));
				/* ERP 집행 금액 */
				double erpApplyAmt = objectToDouble(headData.get("erpApplyAmt"));
				/* ERP 결의 금액 */
				double erpResAmt = objectToDouble(headData.get("erpResAmt"));
				/* 금회상신 금액 */
				double tryAmt = objectToDouble(headData.get("budgetAmt"));
				/**
				 * [ 로직 선 보정 ] 로직이 필요한 금액/코드
				 */
				// [ 부가세 미포함 옵션 결의 ] 공급대가 = 공급가액 처리
				if (headData.get("ctlFgCode") != null
						&& CommonConvert.CommonGetStr(headData.get("ctlFgCode")).equals("0")) {
					tryAmt = objectToDouble(headData.get("budgetStdAmt"));
					resAmt = objectToDouble(hResBudget.get("resBudgetStdAmt"));
				}
				/**
				 * [ 금액 수식 ] 수식이 필요한 금액/코드
				 */
				/* GW 집행금액 [미전송 결의액 + 품의잔액] */
				double gwConsResAmt = consAmt + resAmt;
				/* 결의 기집행액 */
				double erpApplyResAmt = resAmt + erpApplyAmt;
				/* ERP 예산을 뺀 집행액 */
				double gwApplyAmt = erpApplyResAmt - erpResAmt;
				/* 기집행액 [ERP기집행액 + 품의잔액 + 미전송 결의액] */
				double applyAmt = erpApplyAmt + consAmt + resAmt;
				/* 결과 금액 [ERP 편성금액 - 기집행액 - 금회집행] */
				double resultAmt = erpOpenAmt - applyAmt - tryAmt;
				/* ERP 예산잔액 [ERP 편성금액 - ERP 기집행액] */
				double erpLeftAmt = erpOpenAmt - erpApplyAmt;
				/* 예산잔액 [ERP편성금액 - 기집행액] */
				double leftAmt = erpOpenAmt - applyAmt;
				/* iU미결액 총합계 [ 미전송 결의액(세금 제외) + ERP결의액(승인/미승인 포함)] */
				double totalResAmt = resAmt + erpResAmt;
				/* iU예산잔액 [ERP 편성금액 - 품의잔액 - 미전송결의액 - ERP결의액(전표제외)] */
				double erpiULeftAmt = erpOpenAmt - consAmt - resAmt - erpResAmt;
				/* 경총 지원 코드 결의 종결액 [책정예산 - 집행액 - 미결액 - 금회 집행액] */
				double kefResultAmt = erpOpenAmt - erpApplyAmt - totalResAmt - tryAmt;
				/* 경총 지원 코드 품의 종결액[ ERP 예산잔액 - 금회 집행액 ] */
				double kefConsLeftAmt = erpOpenAmt - erpApplyAmt - tryAmt;
				/**
				 * [ 로직 후 보정 ] 로직이 필요한 금액/코드
				 */
				// [ 참조품의 결의서 ] 품의잔액 - 상신금액
				if (headData.get("confferDocSeq") != null
						&& !CommonConvert.CommonGetStr(headData.get("confferDocSeq")).equals("")) {
					applyAmt = applyAmt - tryAmt;
					leftAmt = erpOpenAmt - applyAmt;
					resultAmt = erpOpenAmt - applyAmt - tryAmt;
				}
				/* [숫자] 양식 코드 삽입 */
				headData.put("erpApplyResAmt", erpApplyResAmt);
				headData.put("consAmt", consAmt);
				headData.put("resAmt", resAmt);
				headData.put("erpOpenAmt", erpOpenAmt);
				headData.put("erpApplyAmt", erpApplyAmt);
				headData.put("erpResAmt", erpResAmt);
				headData.put("gwApplyAmt", gwApplyAmt);
				headData.put("gwConsResAmt", gwConsResAmt);
				headData.put("tryAmt", tryAmt);
				headData.put("applyAmt", applyAmt);
				headData.put("resultAmt", resultAmt);
				headData.put("erpLeftAmt", erpLeftAmt);
				headData.put("leftAmt", leftAmt);
				headData.put("totalResAmt", totalResAmt);
				headData.put("erpiULeftAmt", erpiULeftAmt);
				headData.put("kefResultAmt", kefResultAmt);
				headData.put("resStdAmt", resStdAmt);
				headData.put("resTaxAmt", resTaxAmt);
				headData.put("kefConsLeftAmt", kefConsLeftAmt);
				/* [한글] 양식 코드 삽입 */
				headData.put("HANerpApplyResAmt", numToHangle(erpApplyResAmt));
				headData.put("HANconsAmt", numToHangle(consAmt));
				headData.put("HANresAmt", numToHangle(resAmt));
				headData.put("HANresStdAmt", numToHangle(resStdAmt));
				headData.put("HANresTaxAmt", numToHangle(resTaxAmt));
				headData.put("HANerpOpenAmt", numToHangle(erpOpenAmt));
				headData.put("HANerpApplyAmt", numToHangle(erpApplyAmt));
				headData.put("HANerpResAmt", numToHangle(erpResAmt));
				headData.put("HANgwApplyAmt", numToHangle(gwApplyAmt));
				headData.put("HANgwConsResAmt", numToHangle(gwConsResAmt));
				headData.put("HANtryAmt", numToHangle(tryAmt));
				headData.put("HANapplyAmt", numToHangle(applyAmt));
				headData.put("HANresultAmt", numToHangle(resultAmt));
				headData.put("HANerpLeftAmt", numToHangle(erpLeftAmt));
				headData.put("HANleftAmt", numToHangle(leftAmt));
				headData.put("HANtotalResAmt", numToHangle(totalResAmt));
				headData.put("HANerpiULeftAmt", numToHangle(erpiULeftAmt));
				headData.put("HANkefResultAmt", numToHangle(kefResultAmt));
				headResultVO.setaData(headData);
			} else {
				return headResultVO;
			}
			/* 합계 금액 정리 */
			if (CommonConvert.CommonGetStr(footerResultVO.getResultCode()).equals(commonCode.SUCCESS)) {
				Map<String, Object> total = footerResultVO.getAaData().get(0);
				double totalTradeAmt = objectToDouble(total.get("totalTradeAmt"));
				double totalVatAmt = objectToDouble(total.get("totalVatAmt"));
				double totalStdAmt = objectToDouble(total.get("totalStdAmt"));
				double totalBudgetAmt = objectToDouble(total.get("totalBudgetAmt"));
				total.put("HANtotalTradeAmt", numToHangle(totalTradeAmt));
				total.put("HANtotalVatAmt", numToHangle(totalVatAmt));
				total.put("HANtotalStdAmt", numToHangle(totalStdAmt));
				total.put("HANtotalBudgetAmt", numToHangle(totalBudgetAmt));
				footerData = total;
			} else {
				return footerResultVO;
			}
			/* 본문 금액정보 정리 */
			if (CommonConvert.CommonGetStr(contentsResultVO.getResultCode()).equals(commonCode.SUCCESS)) {
				contentsData = contentsResultVO.getaData();
				List<Map<String, Object>> hList = (List<Map<String, Object>>) contentsData.get("project");

				for (int i = 0; i < hList.size(); i++) {
					Map<String, Object> item = hList.get(i);
					item.put("erpTypeCode", conVo.getErpTypeCode());
					item.put("erpBudgetSeq", item.get("budgetCode").toString());
					/* 품의 예산 정보조회 */
					Map<String, Object> cConsBudget = npBudgetService.selectConsBudgetBalance(item).getaData();
					/* 결의 예산 정보조회 */
					Map<String, Object> cResBudget = npBudgetService.selectResUseAmt(item).getaData();
					/* 참조품의서 정보조회 */
					Map<String, Object> cConfferBudget = new HashMap<>();
					if (item.get("confferBudgetSeq") != null
							&& !CommonConvert.CommonGetStr(item.get("confferBudgetSeq")).equals("")) {
						cConfferBudget = npBudgetService.selectConfferBudgetBalanceAmt(item).getaData();
					}
					/**
					 * [ 품의서 ] 기준 코드
					 */
					/* 예산별 품의 잔액 */
					double consAmt = objectToDouble(cConsBudget.get("balanceAmt"));
					/**
					 * [ 결의서 ] 기준 코드
					 */
					/* 미전송 결의액 */
					double resAmt = objectToDouble(cResBudget.get("resBudgetAmt"));
					/**
					 * [ 참조 품의서 ] 기준코드
					 */
					/* 참조품의서 품의잔액 / 참조품의 결의서의 경우 */
					double confferConsAmt = objectToDouble(cConfferBudget.get("consAmt"));
					double confferResAmt = objectToDouble(cConfferBudget.get("resAmt"));
					double confferBalanceAmt = objectToDouble(cConfferBudget.get("balanceAmt"));
					/**
					 * [ ERP ] ERP 기준 코드
					 */
					/* ERP 예산 편성금액 */
					double erpOpenAmt = objectToDouble(item.get("erpOpenAmt"));
					/* ERP 결의액 */
					double erpApplyAmt = objectToDouble(item.get("erpApplyAmt"));
					/* ERP 결의액 */
					double erpResAmt = objectToDouble(item.get("erpResAmt"));
					/**
					 * [ 상신문서 ] 현재 문서[품의/결의 공통]
					 */
					/* 현재 문서[품의/결의] 금회상신 */
					double tryAmt = objectToDouble(item.get("budgetAmt"));
					double tryStdAmt = objectToDouble(item.get("stdAmt"));
					double tryVatAmt = objectToDouble(item.get("taxAmt"));
					/**
					 * [ 로직 선 보정 ] 로직이 필요한 금액/코드
					 */
					// [ 부가세 미포함 옵션 결의 ] 공급대가 = 공급가액 처리
					if (item.get("ctlFgCode") != null
							&& CommonConvert.CommonGetStr(item.get("ctlFgCode")).equals("0")) {
						tryAmt = objectToDouble(item.get("stdAmt"));
					}
					/**
					 * [ 금액 수식 ] 수식이 필요한 금액/코드
					 */
					/* 결의 기집행액 */
					double erpApplyResAmt = resAmt + erpApplyAmt;
					/* GW 집행금액 [미전송 결의액 + 품의잔액] */
					double gwConsResAmt = consAmt + resAmt;
					/* 기집행액 [ ERP 결의금액 + 품의금액 + 미전송 결의금액 ] */
					double applyAmt = erpApplyAmt + consAmt + resAmt;
					/* ERP 예산을 뺀 집행액 */
					double gwApplyAmt = applyAmt - erpResAmt;
					/* 예산 잔액 [ ERP 편성금액 - *기집행액 ] */
					double leftAmt = erpOpenAmt - applyAmt;
					/* 최종 예산 잔액 [ ERP 편성금액 - *기집행액 - 금회상신 ] */
					double resultAmt = erpOpenAmt - applyAmt - tryAmt;
					/* 결의 예산 [ ERP집행금액 + 미전송 결의액 ] */
					double resApplyAmt = erpApplyAmt + resAmt;
					/* ERP 잔여 금액 [ ERP 예산 편성금 - ERP 결의액 ] */
					double erpLeftAmt = erpOpenAmt - erpApplyAmt;
					/* 참조 품의서 품의잔액 [ 품의잔액 - 금회상신] */
					double confferResultAmt = 0;
					/* iU미결액 총합계 [품의잔액 + 미전송 결의액 + ERP결의액(승인/미승인 포함)] */
					double totalResAmt = consAmt + resAmt + erpResAmt;
					/* iU예산잔액 [ERP 편성금액 - 품의잔액 - 미전송결의액 - ERP결의액(전표제외)] */
					double erpiULeftAmt = erpOpenAmt - consAmt - resAmt - erpResAmt;
					/* 경총 지원 코드 [책정예산 - 집행액 - 미결액] */
					double kefResultAmt = erpOpenAmt - erpApplyAmt - totalResAmt;
					/**
					 * [ 로직 ] 로직이 필요한 금액/코드
					 */
					// [ 참조품의 결의서 ] 품의잔액 - 상신금액
					if (item.get("confferBudgetSeq") != null
							&& !CommonConvert.CommonGetStr(item.get("confferBudgetSeq")).equals("")) {
						confferResultAmt = confferBalanceAmt - tryAmt;
						applyAmt = applyAmt - tryAmt;
						leftAmt = erpOpenAmt - applyAmt;
						resultAmt = erpOpenAmt - applyAmt - tryAmt;
					}
					/* [ 숫자 ] 양식 코드 삽입 */
					item.put("consAmt", consAmt);
					item.put("resAmt", resAmt);
					item.put("resApplyAmt", resApplyAmt);
					item.put("erpOpenAmt", erpOpenAmt);
					item.put("erpApplyAmt", erpApplyAmt);
					item.put("erpResAmt", erpResAmt);
					item.put("gwApplyAmt", gwApplyAmt);
					item.put("gwConsResAmt", gwConsResAmt);
					item.put("erpLeftAmt", erpLeftAmt);
					item.put("tryAmt", tryAmt);
					item.put("tryStdAmt", tryStdAmt);
					item.put("tryVatAmt", tryVatAmt);
					item.put("confferConsAmt", confferConsAmt);
					item.put("confferResAmt", confferResAmt);
					item.put("confferBalanceAmt", confferBalanceAmt);
					item.put("confferResultAmt", confferResultAmt);
					item.put("applyAmt", applyAmt);
					item.put("leftAmt", leftAmt);
					item.put("resultAmt", resultAmt);
					item.put("totalResAmt", totalResAmt);
					item.put("erpiULeftAmt", erpiULeftAmt);
					item.put("kefResultAmt", kefResultAmt);
					item.put("erpApplyResAmt", erpApplyResAmt);
					/* [ 한글 ] 양식 코드 삽입 */
					item.put("HANconsAmt", numToHangle(consAmt));
					item.put("HANresAmt", numToHangle(resAmt));
					item.put("HANresApplyAmt", numToHangle(resApplyAmt));
					item.put("HANerpOpenAmt", numToHangle(erpOpenAmt));
					item.put("HANerpApplyAmt", numToHangle(erpApplyAmt));
					item.put("HANerpResAmt", numToHangle(erpResAmt));
					item.put("HANgwApplyAmt", numToHangle(gwApplyAmt));
					item.put("HANgwConsResAmt", numToHangle(gwConsResAmt));
					item.put("HANerpLeftAmt", numToHangle(erpLeftAmt));
					item.put("HANtryAmt", numToHangle(tryAmt));
					item.put("HANtryStdAmt", numToHangle(tryStdAmt));
					item.put("HANtryVatAmt", numToHangle(tryVatAmt));
					item.put("HANconfferConsAmt", numToHangle(confferConsAmt));
					item.put("HANconfferResAmt", numToHangle(confferResAmt));
					item.put("HANconfferBalanceAmt", numToHangle(confferBalanceAmt));
					item.put("HANconfferResultAmt", numToHangle(confferResultAmt));
					item.put("HANapplyAmt", numToHangle(applyAmt));
					item.put("HANleftAmt", numToHangle(leftAmt));
					item.put("HANresultAmt", numToHangle(resultAmt));
					item.put("HANtotalResAmt", numToHangle(totalResAmt));
					item.put("HANerpiULeftAmt", numToHangle(erpiULeftAmt));
					item.put("HANkefResultAmt", numToHangle(kefResultAmt));
					item.put("HANerpApplyResAmt", numToHangle(erpApplyResAmt));
					/**
					 * [ 통계 ] 기준코드
					 */
					double totalBudgetAmt = objectToDouble(item.get("totalBudgetAmt"));
					item.put("HANtotalBudgetAmt", numToHangle(totalBudgetAmt));
				}

				List<Map<String, Object>> bList = (List<Map<String, Object>>) contentsData.get("budget");
				Map<String, Double> stackTryAmt = new HashMap<>();
				for (int i = 0; i < bList.size(); i++) {
					Map<String, Object> item = bList.get(i);
					item.put("erpTypeCode", conVo.getErpTypeCode());
					item.put("erpBudgetSeq", item.get("budgetCode").toString());
					/* 품의 예산 정보조회 */
					Map<String, Object> cConsBudget = npBudgetService.selectConsBudgetBalance(item).getaData();
					/* 결의 예산 정보조회 */
					Map<String, Object> cResBudget = npBudgetService.selectResUseAmt(item).getaData();
					/* 참조품의서 정보조회 */
					Map<String, Object> cConfferBudget = new HashMap<>();
					if (item.get("confferBudgetSeq") != null
							&& !CommonConvert.CommonGetStr(item.get("confferBudgetSeq")).equals("")) {
						cConfferBudget = npBudgetService.selectConfferBudgetBalanceAmt(item).getaData();
					}
					/**
					 * [ 품의서 ] 기준 코드
					 */
					/* 예산별 품의 잔액 */
					double consAmt = objectToDouble(cConsBudget.get("balanceAmt"));
					/**
					 * [ 결의서 ] 기준 코드
					 */
					/* 미전송 결의액 */
					double resAmt = objectToDouble(cResBudget.get("resBudgetAmt"));
					/**
					 * [ 참조 품의서 ] 기준코드
					 */
					/* 참조품의서 품의잔액 / 참조품의 결의서의 경우 */
					double confferConsAmt = objectToDouble(cConfferBudget.get("consAmt"));
					double confferResAmt = objectToDouble(cConfferBudget.get("resAmt"));
					double confferBalanceAmt = objectToDouble(cConfferBudget.get("balanceAmt"));
					/**
					 * [ ERP ] ERP 기준 코드
					 */
					/* ERP 예산 편성금액 */
					double erpOpenAmt = objectToDouble(item.get("erpOpenAmt"));
					/* ERP 결의액 */
					double erpApplyAmt = objectToDouble(item.get("erpApplyAmt"));
					/* ERP 결의액 */
					double erpResAmt = objectToDouble(item.get("erpResAmt"));
					/**
					 * [ 상신문서 ] 현재 문서[품의/결의 공통]
					 */
					/* 현재 문서[품의/결의] 금회상신 */
					double tryAmt = objectToDouble(item.get("budgetAmt"));
					double tryStdAmt = objectToDouble(item.get("stdAmt"));
					double tryVatAmt = objectToDouble(item.get("taxAmt"));

					/**
					 * [ 로직 선 보정 ] 로직이 필요한 금액/코드
					 */
					// [ 부가세 미포함 옵션 결의 ] 공급대가 = 공급가액 처리
					if (item.get("ctlFgCode") != null
							&& CommonConvert.CommonGetStr(item.get("ctlFgCode")).equals("0")) {
						tryAmt = objectToDouble(item.get("stdAmt"));
					}

					/**
					 * [ 로직 선 보정 ] 이전 단계 예산 상신 금액
					 */
					double preTryAmt = this.GetStackTryAmt(item, stackTryAmt);
					this.SetStackTryAmt(item, tryAmt, stackTryAmt);

					/**
					 * [ 금액 수식 ] 수식이 필요한 금액/코드
					 */
					/* 결의 기집행액 */
					double erpApplyResAmt = resAmt + erpApplyAmt;
					/* GW 집행금액 [미전송 결의액 + 품의잔액] */
					double gwConsResAmt = consAmt + resAmt;
					/* 기집행액 [ ERP 결의금액 + 품의금액 + 미전송 결의금액 ] */
					double applyAmt = erpApplyAmt + consAmt + resAmt;
					double applyTryAmt = erpApplyAmt + consAmt + resAmt - tryAmt;
					/* ERP 예산을 뺀 집행액 */
					double gwApplyAmt = applyAmt - erpResAmt;
					/* 예산 잔액 [ ERP 편성금액 - *기집행액 ] */
					double leftAmt = erpOpenAmt - applyAmt;
					/* 최종 예산 잔액 [ ERP 편성금액 - *기집행액 - 금회상신 ] */
					double resultAmt = erpOpenAmt - applyAmt - tryAmt;
					/* 결의 예산 [ ERP집행금액 + 미전송 결의액 ] */
					double resApplyAmt = erpApplyAmt + resAmt;
					/* ERP 잔여 금액 [ ERP 예산 편성금 - ERP 결의액 ] */
					double erpLeftAmt = erpOpenAmt - erpApplyAmt;
					/* 참조 품의서 품의잔액 [ 품의잔액 - 금회상신] */
					double confferResultAmt = 0;
					/* iU미결액 총합계 [품의잔액 + 미전송 결의액 + ERP결의액(승인/미승인 포함)] */
					double totalResAmt = consAmt + resAmt + erpResAmt;
					/* iU예산잔액 [ERP 편성금액 - 품의잔액 - 미전송결의액 - ERP결의액(전표제외)] */
					double erpiULeftAmt = erpOpenAmt - consAmt - resAmt - erpResAmt;
					/* 경총 지원 코드 [책정예산 - 집행액 - 미결액] */
					double kefResultAmt = erpOpenAmt - erpApplyAmt - totalResAmt;

					/* 동일예산 순차 차감 양식코드 - 참조 결의액 */
					double stackConfferResAmt = confferResAmt + preTryAmt;
					/* 동일예산 순차 차감 양식코드 - 품의 잔액 */
					double stackConfferBalanceAmt = confferBalanceAmt - preTryAmt;
					/* 동일예산 순차 차감 양식코드 - 기집행액 */
					double stackApplyAmt = erpApplyAmt + consAmt + resAmt + preTryAmt;
					/* 동일예산 순차 차감 양식코드 - 예산잔액 */
					double stackResultAmt = resultAmt - preTryAmt;
					double stackConfferResultAmt = 0;

					/**
					 * [ 로직 ] 로직이 필요한 금액/코드
					 */
					// [ 복수 동일예산항목 결의서 선입력 금액 포함 ] 결의액 += 선입력 결의액

					// [ 참조품의 결의서 ] 품의잔액 - 상신금액
					if (item.get("confferBudgetSeq") != null
							&& !CommonConvert.CommonGetStr(item.get("confferBudgetSeq")).equals("")) {
						confferResultAmt = confferBalanceAmt - tryAmt;
						stackConfferResultAmt = confferBalanceAmt - tryAmt - preTryAmt;
						consAmt = consAmt - tryAmt;
						applyAmt = applyAmt - tryAmt;
						leftAmt = erpOpenAmt - applyAmt;
						resultAmt = erpOpenAmt - applyAmt - tryAmt;
						stackApplyAmt = applyAmt - tryAmt - preTryAmt;
					}
					/* [ 숫자 ] 양식 코드 삽입 */
					item.put("consAmt", consAmt);
					item.put("resAmt", resAmt);
					item.put("resApplyAmt", resApplyAmt);
					item.put("erpOpenAmt", erpOpenAmt);
					item.put("erpApplyAmt", erpApplyAmt);
					item.put("erpResAmt", erpResAmt);
					item.put("gwApplyAmt", gwApplyAmt);
					item.put("gwConsResAmt", gwConsResAmt);
					item.put("erpLeftAmt", erpLeftAmt);
					item.put("tryAmt", tryAmt);
					item.put("tryStdAmt", tryStdAmt);
					item.put("tryVatAmt", tryVatAmt);
					item.put("confferConsAmt", confferConsAmt);
					item.put("confferResAmt", confferResAmt);
					item.put("confferBalanceAmt", confferBalanceAmt);
					item.put("confferResultAmt", confferResultAmt);
					item.put("applyAmt", applyAmt);
					item.put("leftAmt", leftAmt);
					item.put("resultAmt", resultAmt);
					item.put("totalResAmt", totalResAmt);
					item.put("erpiULeftAmt", erpiULeftAmt);
					item.put("kefResultAmt", kefResultAmt);
					item.put("erpApplyResAmt", erpApplyResAmt);
					item.put("stackApplyAmt", stackApplyAmt);
					item.put("stackConfferBalanceAmt", stackConfferBalanceAmt);
					item.put("stackConfferResAmt", stackConfferResAmt);
					item.put("stackResultAmt", stackResultAmt);
					item.put("applyTryAmt", applyTryAmt);
					item.put("stackConfferResultAmt", stackConfferResultAmt);

					/* [ 한글 ] 양식 코드 삽입 */
					item.put("HANconsAmt", numToHangle(consAmt));
					item.put("HANresAmt", numToHangle(resAmt));
					item.put("HANresApplyAmt", numToHangle(resApplyAmt));
					item.put("HANerpOpenAmt", numToHangle(erpOpenAmt));
					item.put("HANerpApplyAmt", numToHangle(erpApplyAmt));
					item.put("HANerpResAmt", numToHangle(erpResAmt));
					item.put("HANgwApplyAmt", numToHangle(gwApplyAmt));
					item.put("HANgwConsResAmt", numToHangle(gwConsResAmt));
					item.put("HANerpLeftAmt", numToHangle(erpLeftAmt));
					item.put("HANtryAmt", numToHangle(tryAmt));
					item.put("HANtryStdAmt", numToHangle(tryStdAmt));
					item.put("HANtryVatAmt", numToHangle(tryVatAmt));
					item.put("HANconfferConsAmt", numToHangle(confferConsAmt));
					item.put("HANconfferResAmt", numToHangle(confferResAmt));
					item.put("HANconfferBalanceAmt", numToHangle(confferBalanceAmt));
					item.put("HANconfferResultAmt", numToHangle(confferResultAmt));
					item.put("HANapplyAmt", numToHangle(applyAmt));
					item.put("HANleftAmt", numToHangle(leftAmt));
					item.put("HANresultAmt", numToHangle(resultAmt));
					item.put("HANtotalResAmt", numToHangle(totalResAmt));
					item.put("HANerpiULeftAmt", numToHangle(erpiULeftAmt));
					item.put("HANkefResultAmt", numToHangle(kefResultAmt));
					item.put("HANerpApplyResAmt", numToHangle(erpApplyResAmt));

					item.put("HANstackApplyAmt", numToHangle(stackApplyAmt));
					item.put("HANstackConfferBalanceAmt", numToHangle(stackConfferBalanceAmt));
					item.put("HANstackConfferResAmt", numToHangle(stackConfferResAmt));
					item.put("HANstackResultAmt", numToHangle(stackResultAmt));
					item.put("HANapplyTryAmt", numToHangle(applyTryAmt));
					item.put("HANstackConfferResultAmt", numToHangle(stackConfferResultAmt));

				}
			} else {
				return contentsResultVO;
			}
			testMode = "N";
		}

		Map<String, Object> confOpt = new HashMap<>();
		if (CommonConvert.NullToString(params.get("ErpType")).contains("TRIP")) {
			confOpt.put("confOpt", "0");
		} else {
			confOpt.put("confOpt", dao.CommonNpFormDetailInfo(params).get("confYn"));
		}

		/* 통합양식 테스트 */
		if (confOpt.get("confOpt").equals("1")) {

			/* contentsData 보정 */
			List<Map<String, Object>> projectList = (List<Map<String, Object>>) contentsData.get("project");
			List<Map<String, Object>> budgetList = (List<Map<String, Object>>) contentsData.get("budget");
			List<Map<String, Object>> tradeList = (List<Map<String, Object>>) contentsData.get("trade");

			int pNum = 1;
			for (Map<String, Object> projectItem : projectList) {
				projectItem.put("projectNum", pNum++);
				List<Map<String, Object>> budgetFilteredList = getBudgetListForResSeq(budgetList,
						CommonConvert.NullToString(projectItem.get("resSeq")));
				for (Map<String, Object> budgetItem : budgetFilteredList) {
					budgetItem.put("tradeList", getTradeListForBudgetSeq(tradeList,
							CommonConvert.NullToString(budgetItem.get("budgetSeq"))));
				}
				projectItem.put("budgetList", budgetFilteredList);
			}

			InterlockConfHtmlVO htmlVo = new InterlockConfHtmlVO(html, params.get("exDocSeq").toString(),
					loginVo.getGroupSeq(), testMode);
			ResultVO htmlResult = htmlVo.SetHtmlForm(headData, projectList, footerData);
			if (!CommonConvert.CommonGetStr(htmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
				return htmlResult;
			}

			/** 5. 결과 반환 **/
			params.put("html", htmlVo.GetResultHtml());
			result.setaData(params);
			result.setResultCode(commonCode.SUCCESS);
			result.setResultName(commonCode.SUCCESS);
		} else {
			InterlockNPHTMLVO htmlVo = new InterlockNPHTMLVO(html, params.get("exDocSeq").toString(),
					loginVo.getGroupSeq(), testMode);
			ResultVO htmlResult = htmlVo.SetHtmlForm(headData, contentsData, footerData);
			if (!CommonConvert.CommonGetStr(htmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
				return htmlResult;
			}

			/** 5. 결과 반환 **/
			params.put("html", htmlVo.GetResultHtml());
			result.setaData(params);
			result.setResultCode(commonCode.SUCCESS);
			result.setResultName(commonCode.SUCCESS);
		}

		/** 4. 양식 생성 **/
//        Map<String,Object> confOpt = new HashMap<>();
//        confOpt.put("confOpt", dao.CommonNpFormDetailInfo(params).get("confYn"));
//        if(confOpt.get("confOpt").equals("0")) {
//        	InterlockNPHTMLVO htmlVo = new InterlockNPHTMLVO(html, params.get("exDocSeq").toString(), loginVo.getGroupSeq(), testMode);
//            ResultVO htmlResult = htmlVo.SetHtmlForm(headData, contentsData, footerData);
//            if (!CommonConvert.CommonGetStr(htmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
//                return htmlResult;
//            }
//
//            /** 5. 결과 반환 **/
//            params.put("html", htmlVo.GetResultHtml());
//            result.setaData(params);
//            result.setResultCode(commonCode.SUCCESS);
//            result.setResultName(commonCode.SUCCESS);
//        }
//        else {
//        	InterlockConfHtmlVO htmlVo = new InterlockConfHtmlVO(html, params.get("exDocSeq").toString(), loginVo.getGroupSeq(), testMode);
////            ResultVO htmlResult = htmlVo.SetHtmlForm(headData, contentsData, footerData);
////            if (!CommonConvert.CommonGetStr(htmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
////                return htmlResult;
////            }
////
////            /** 5. 결과 반환 **/
////            params.put("html", htmlVo.GetResultHtml());
////            result.setaData(params);
////            result.setResultCode(commonCode.SUCCESS);
////            result.setResultName(commonCode.SUCCESS);
//        }

		return result;
	}

	private List<Map<String, Object>> getBudgetListForResSeq(List<Map<String, Object>> params, String resSeq) {
		List<Map<String, Object>> returnList = new ArrayList<>();
		int bIndex = 1;
		for (Map<String, Object> item : params) {
			if (CommonConvert.NullToString(item.get("resSeq")).equals(resSeq)) {
				item.put("budgetNum", bIndex++);
				returnList.add(item);
			} else {
				bIndex = 1;
			}
		}
		return returnList;
	}

	private List<Map<String, Object>> getTradeListForBudgetSeq(List<Map<String, Object>> params, String budgetSeq) {
		List<Map<String, Object>> returnList = new ArrayList<>();
		int tIndex = 1;
		for (Map<String, Object> item : params) {
			if (CommonConvert.NullToString(item.get("budgetSeq")).equals(budgetSeq)) {
				item.put("tradeNum", tIndex++);
				returnList.add(item);
			} else {
				tIndex = 1;
			}
		}
		return returnList;
	}

	private String numToHangle(double val) {
		String money = "" + ((long) val);
		String[] han1 = { "", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구" };
		String[] han2 = { "", "십", "백", "천" };
		String[] han3 = { "", "만", "억", "조", "경" };
		int checkHan = 0;
		StringBuffer result = new StringBuffer();
		int len = money.length();
		for (int i = len - 1; i >= 0; i--) {
			try {
				result.append(han1[Integer.parseInt(money.substring(len - i - 1, len - i))]);
				if (Integer.parseInt(money.substring(len - i - 1, len - i)) > 0) {
					result.append(han2[i % 4]);
				}
				if (i % 4 == 0) {
					result.append(han3[i / 4]);
				}
			} catch (Exception ex) {
				result.append("");
			}
		}
		StringBuffer obj = new StringBuffer();
		obj.append("");
		if (result.equals(obj)) {
			return "영";
		}
		return result.toString().replace("억만", "억");
	}

	private double objectToDouble(Object o) {
		if (o == null) {
			return 0;
		}
		double returnVal = 0;
		try {
			returnVal = Double.parseDouble(o.toString());
		} catch (Exception ex) {
			returnVal = 0;
		}
		return returnVal;
	}

	/**
	 * 지출결의 인터락 양식 만들기 params { html : 양식설정 테스트 모드의 경우 사용. testYN : [, Y] }
	 */
	@Override
	public ResultVO DocMaker(Map<String, Object> params) throws Exception {
		/* 기본 변수 정의 */
		ResultVO result = new ResultVO();
		String html = "";
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		/* html == null ? 인터락모드 양식 조회 : 테스트모드 파라미터 사용 */
		if (params.get("html") == null) {
			params.put("empSeq", loginVo.getUniqId());
			params.put("compSeq", loginVo.getCompSeq());
			params.put("groupSeq", loginVo.getGroupSeq());
			/* 양식 정보 조회 */
			Map<String, Object> formData = dao.CommonFormDetailInfo(params);
			/* 양식 정보 검증 */
			if (formData.get("formContent") != null) {
				html = (String) formData.get("formContent");
			} else {
				/* 기초 데이터 조회 */
				formData = dao.CommonFormDefaultInfo(params);
				/* 양식 정보 검증 */
				if (formData.get("formContent") != null) {
					html = (String) formData.get("formContent");
				} else {
					throw new Exception("기초데이터 조회에 실패하였습니다.");
				}
			}
		} else {
			html = params.get("html").toString();
		}
		/* 헤더 컨텐츠 데이터 조회 */
		Map<String, Object> headData = new HashMap<String, Object>();
		Map<String, Object> footerData = new HashMap<String, Object>();
		List<Map<String, Object>> contentsData = new ArrayList<>();
		List<Map<String, Object>> subtotalData = new ArrayList<>();
		String testMode = "";
		if (params.get("testYN") != null && CommonConvert.CommonGetStr(params.get("testYN")).equals("Y")) {
			headData = GetHeadSampleData();
			footerData = GetFooterSampleData();
			contentsData = GetContentsSampleData();
			testMode = "Y";
		} else {
			headData = userReportService.ExReportHeaderInterLockInfoSelect(params);
			footerData = userReportService.ExReportFooterInterLockInfoSelect(params);
			contentsData = codeService.ExpendInfoSelect(params);
			subtotalData = userReportService.ExReportSubtotalInterLockInfoSelect(params);
			testMode = "N";
		}

		// 기존 html과 소계 html 나누기(기본양식)
		Document basicHtml = Jsoup.parse(html);
		Elements tables = basicHtml.select("table");

		String listHtml = CommonConvert.CommonGetStr(tables.get(0));
		String subtotalHtml = "";
		String totalHtml = "";

		// 소계양식이 있을때
		if (tables.size() > 1) {
			subtotalHtml = CommonConvert.CommonGetStr(tables.get(1));

		}

		/* HTML 변환 */
		InterlockHtmlVO htmlVo = new InterlockHtmlVO(listHtml, params.get("expendSeq").toString(),
				loginVo.getGroupSeq(), testMode);
		ResultVO htmlResult = htmlVo.SetHtmlForm(headData, contentsData, footerData);
		if (!CommonConvert.CommonGetStr(htmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
			return htmlResult;
		}

		totalHtml = htmlVo.GetResultHtml();

		// 소계양식이 있을때
		if (!"".equals(subtotalHtml)) {
			// 소계 html 변환
			InterlockSubtotalHtmlVO subtotalHtmlVo = new InterlockSubtotalHtmlVO(subtotalHtml);
			ResultVO subtotalHtmlResult = subtotalHtmlVo.SetHtmlForm(subtotalData);
			if (!CommonConvert.CommonGetStr(subtotalHtmlResult.getResultCode()).equals(commonCode.SUCCESS)) {
				return subtotalHtmlResult;
			}

			// 기존 html과 소계 html과 합치기
			totalHtml = mergeHtml(htmlVo.GetResultHtml(), subtotalHtmlVo.GetResultHtml());
		}

		/* 리턴 */
		params.put("html", totalHtml);
		result.setaData(params);
		result.setResultCode(commonCode.SUCCESS);
		result.setResultName(commonCode.SUCCESS);
		return result;
	}

	// 기존 html과 소계 html과 합치기(치환 후 양식)
	private String mergeHtml(String targetHtml, String additionalHtml) {
		Document doc = Jsoup.parse(targetHtml);

		Elements tables = doc.getAllElements();

		for (Element elem : tables) {
			if (elem.is("body")) {
				elem.append(additionalHtml);
			}
		}

		return doc.toString();
	}

	private void SetStackTryAmt(Map<String, Object> item, double tryAmt, Map<String, Double> stackTryAmt) {
		boolean isERPiU = false;
		if (item.get("erpFiacctSeq") != null) {
			if (!CommonConvert.CommonGetStr(item.get("erpFiacctSeq")).equals("")) {
				isERPiU = true;
			}
		}
		double preTryAmt = 0;
		String key = "";
		if (isERPiU) {
			key = item.get("erpFiacctSeq").toString();
		} else {
			key = item.get("erpBudgetSeq").toString();
		}
		preTryAmt = Double.parseDouble(stackTryAmt.get(key) == null ? "0" : stackTryAmt.get(key).toString());
		preTryAmt += tryAmt;
		stackTryAmt.put(key, preTryAmt);
	}

	private double GetStackTryAmt(Map<String, Object> item, Map<String, Double> stackTryAmt) {
		boolean isERPiU = false;
		if (item.get("erpFiacctSeq") != null) {
			if (!CommonConvert.CommonGetStr(item.get("erpFiacctSeq").toString()).equals("")) {
				isERPiU = true;
			}
		}
		double preTryAmt = 0;
		String key = "";
		if (isERPiU) {
			key = item.get("erpFiacctSeq").toString();
		} else {
			key = item.get("erpBudgetSeq").toString();
		}
		preTryAmt = Double.parseDouble(stackTryAmt.get(key) == null ? "0" : stackTryAmt.get(key).toString());
		return preTryAmt;
	}

	/* [샘플 / 영리] 양식설정/헤더 샘플 */
	private HashMap<String, Object> GetHeadSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		result.put("expendDate", "20170101");
		result.put("expendReqDate", "20170101");
		return result;
	}

	/* [샘플 / 영리] 양식설정/푸터 샘플 */
	private HashMap<String, Object> GetFooterSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		result.put("subStdAmt", "5000.00");
		result.put("subTaxAmt", "500.00");
		result.put("amt", "5500.00");
		result.put("vatAmt", "500.00");
		result.put("crAmt", "5500.00");
		result.put("drAmt", "5500.00");
		result.put("reqAmt", "5500.00");
		return result;
	}

	/* [샘플 / 영리] 양식설정/컨텐츠 샘플 */
	private List<Map<String, Object>> GetContentsSampleData() throws Exception {
		return GetLists();
	}

	/* [영리] 샘플데이터 통제 */
	@Override
	public HashMap<String, Object> GetSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		Map<String, Object> headData = new HashMap<String, Object>();
		/* Map<String, Object> footerData = new HashMap<String, Object>( ); */
		/* List<Map<String, Object>> contentsData = new ArrayList<>( ); */
		result.put("", headData);
		return result;
	}

	/* [샘플 / 비영리] 양식설정/헤더 샘플 */
	private HashMap<String, Object> GetNPHeadSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		// TODO: 샘플데이터 체워 넣어야 함.
		result.put("erpPcName", "1000");
		result.put("erpDeptName", "개발1팀");
		result.put("erpEmpName", "김더존");
		result.put("erpEmpSeq", "1001");
		result.put("pTest", "프로젝트 테스트 밸류");
		return result;
	}

	/* [샘플 / 비영리] 양식설정/푸터 샘플 */
	private HashMap<String, Object> GetNPFooterSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		// TODO: 샘플데이터 체워 넣어야 함.
		result.put("subStdAmt", "5000.00");
		return result;
	}

	/* [샘플 / 비영리] 양식설정/컨텐츠 샘플 */
	private Map<String, Object> GetNPContentsSampleData() throws Exception {
		HashMap<String, Object> result = new HashMap<>();
		// TODO: 샘플데이터 체워 넣어야 함.
		result.put("project", GetNPProjectSampleList());
		result.put("budget", GetNPBudgetSampleList());
		result.put("trade", GetNPTradeSampleList());
		return result;
	}

	private List<Map<String, Object>> GetNPProjectSampleList() {
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> t = new HashMap<>();
		Map<String, Object> t2 = new HashMap<>();
		t.put("resDocSeq", "1");
		t.put("resSeq", "1");
		t.put("docSeq", "1");
		t.put("docNote", "적요] 식비 결재 상신건 ");
		t.put("expendDate", "20180101");
		t.put("compName'", "더존비즈온");
		t.put("deptName", "개발1팀");
		t.put("empName", "홍길동");
		t.put("expendResDate", "20180101");
		t.put("projectCode", "P0001");
		t.put("projectName", "BizbxAlpha 개발");
		t.put("docuFgName", "지출결의서");
		t.put("note", "야식비 청구 건");
		t.put("erpCompCode", "1000");
		t.put("erpCompName", "더존비즈온");
		t.put("erpPcCode", "C0001");
		t.put("erpPcName", "개발예산");
		t.put("erpDivSeq", "D0001");
		t.put("erpDivName", "개발1팀");
		result.add(t);
		t2.put("resDocSeq", "1");
		t2.put("resSeq", "2");
		t2.put("docSeq", "2");
		t2.put("docNote", "적요] 식비 결재 상신건 ");
		t2.put("expendDate", "20180101");
		t2.put("compName'", "더존비즈온");
		t2.put("deptName", "개발1팀");
		t2.put("empName", "홍길동");
		t2.put("expendResDate", "20180101");
		t2.put("projectCode", "P0002");
		t2.put("projectName", "BizbxAlpha 유지보수");
		t2.put("docuFgName", "지출결의서");
		t2.put("note", "간식비 청구 건");
		t2.put("erpCompCode", "1000");
		t2.put("erpCompName", "더존비즈온");
		t2.put("erpPcCode", "C0001");
		t2.put("erpPcName", "개발예산");
		t2.put("erpDivSeq", "D0001");
		t2.put("erpDivName", "개발1팀");
		result.add(t2);
		return result;
	}

	private List<Map<String, Object>> GetNPBudgetSampleList() {
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> t = new HashMap<>();
		t.put("resDocSeq", "1");
		t.put("resSeq", "1");
		t.put("budgetSeq", "1");
		t.put("budgetCode", "B000100");
		t.put("budgetName", "야식비");
		t.put("bizplanCode", "Z0001");
		t.put("bizplanName", "사업계획");
		t.put("budget1Name", "복지비");
		t.put("budget2Name", "식대");
		t.put("budget3Name", "추가 식대");
		t.put("budget4Name", "야식비");
		t.put("stdAmt", "4546");
		t.put("taxAmt", "454");
		t.put("amt", "5000");
		t.put("bgacctCode", "ZA0001");
		t.put("bgacctName", "개발1팀");
		t.put("setFgName", "현금");
		t.put("vatFgName", "과세");
		t.put("trFgName", "거래처");
		t.put("ctlFgName", "");
		t.put("erpDivName", "UC개발부");
		t.put("budgetNote", "분식집 사용분");
		result.add(t);
		Map<String, Object> t2 = new HashMap<>();
		t2.put("resDocSeq", "1");
		t2.put("resSeq", "1");
		t2.put("budgetSeq", "2");
		t2.put("budgetCode", "B000100");
		t2.put("budgetName", "야식비");
		t2.put("bizplanCode", "Z0001");
		t2.put("bizplanName", "사업계획");
		t2.put("budget1Name", "복지비");
		t2.put("budget2Name", "식대");
		t2.put("budget3Name", "추가 식대");
		t2.put("budget4Name", "야식비");
		t2.put("stdAmt", "7200");
		t2.put("taxAmt", "800");
		t2.put("amt", "8000");
		t2.put("bgacctCode", "ZA0001");
		t2.put("bgacctName", "개발1팀");
		t2.put("setFgName", "카드");
		t2.put("vatFgName", "과세");
		t2.put("trFgName", "거래처");
		t2.put("ctlFgName", "");
		t2.put("erpDivName", "UC개발부");
		t2.put("budgetNote", "편의점 사용분");
		result.add(t2);
		return result;
	}

	private List<Map<String, Object>> GetNPTradeSampleList() {
		List<Map<String, Object>> result = new ArrayList<>();
		Map<String, Object> t = new HashMap<>();
		t.put("resDocSeq", "1");
		t.put("resSeq", "1");
		t.put("budgetSeq", "1");
		t.put("tradeSeq", "1");
		t.put("itemName", "떡볶이");
		t.put("itemCnt", "1");
		t.put("tradeEmpName", "홍길동");
		t.put("tradeName", "강촌 분식");
		t.put("ceoName", "임꺽정");
		t.put("tradeUnitAmt", "2000");
		t.put("tradeStdAmt", "1800");
		t.put("tradeVatAmt", "200");
		t.put("jiroName", "9876543210");
		t.put("bankNum", "");
		t.put("bankName", "");
		t.put("depositor", "");
		t.put("tradeNote", "야식사용분");
		result.add(t);
		Map<String, Object> t2 = new HashMap<>();
		t2.put("resDocSeq", "1");
		t2.put("resSeq", "1");
		t2.put("budgetSeq", "1");
		t2.put("tradeSeq", "2");
		t2.put("itemName", "순대");
		t2.put("itemCnt", "1");
		t2.put("tradeEmpName", "홍길동");
		t2.put("tradeName", "강촌 분식");
		t2.put("ceoName", "임꺽정");
		t2.put("tradeUnitAmt", "3000");
		t2.put("tradeStdAmt", "2700");
		t2.put("tradeVatAmt", "300");
		t2.put("jiroName", "9876543210");
		t2.put("bankNum", "");
		t2.put("bankName", "");
		t2.put("depositor", "");
		t2.put("tradeNote", "야식사용분");
		result.add(t2);
		Map<String, Object> t3 = new HashMap<>();
		t3.put("resDocSeq", "1");
		t3.put("resSeq", "1");
		t3.put("budgetSeq", "2");
		t3.put("tradeSeq", "3");
		t3.put("itemName", "컵라면");
		t3.put("itemCnt", "3");
		t3.put("tradeEmpName", "호국이");
		t3.put("tradeName", "더존 편의점");
		t3.put("ceoName", "주성덕");
		t3.put("tradeUnitAmt", "1000");
		t3.put("tradeStdAmt", "2700");
		t3.put("tradeVatAmt", "300");
		t3.put("jiroName", "0123456789");
		t3.put("bankNum", "001");
		t3.put("bankName", "한국은행");
		t3.put("depositor", "주성덕");
		t3.put("tradeNote", "컵라면 3인분");
		result.add(t3);
		return result;
	}

	private List<Map<String, Object>> GetLists() {
		List<Map<String, Object>> lists = new ArrayList<>();
		HashMap<String, Object> list = new HashMap<>();
		list.put("listNum", "1");
		list.put("expendSeq", "0");
		list.put("listSeq", "1");
		list.put("summaryCode", "02");
		list.put("summaryName", "출장여비");
		list.put("drAcctCode", "1000");
		list.put("drAcctName", "복리후생비_식대");
		list.put("authName", "과세매입");
		list.put("authDate", "20170101");
		list.put("writeName", "김더존");
		list.put("empName", "김더존");
		list.put("empDeptName", "관리부");
		list.put("budgetCode", "");
		list.put("budgetName", "");
		list.put("budgetName", "");
		list.put("budgetYm", "");
		list.put("bizplanCode", "");
		list.put("bizplanName", "");
		list.put("bgacctCode", "");
		list.put("bgacctName", "");
		list.put("projectCode", "00001");
		list.put("projectName", "$/신규 프로젝트");
		list.put("partnerCode", "00003");
		list.put("partnerName", "한국상사");
		list.put("partnerNo", "0123456789");
		list.put("ceoName", "홍길동");
		list.put("cardName", "현대카드(매입)");
		list.put("cardNum", "0123-4567-8901-2345");
		list.put("cardCode", "9900");
		list.put("authDate", "20170101");
		list.put("note", "한국상사 구입");
		list.put("listStdAmt", "5000.00");
		list.put("listTaxAmt", "500.00");
		list.put("listAmt", "5500.00");
		list.put("listSubStdAmt", "5000.00");
		list.put("listSubTaxAmt", "500.00");
		list.put("erpCcCode", "");
		list.put("erpCcName", "");
		list.put("erpPcCode", "");
		list.put("erpPcName", "");
		list.put("empErpBizCode", "사업장코드");
		list.put("empErpBizName", "사업장명칭");
		list.put("cardAuthDate", "20170101");
		list.put("cardAuthTime", "120030");
		list.put("etaxIssNo", "110");
		list.put("cardRequestAmount", "5500");
		list.put("cardAmtAmount", "5000");
		list.put("cardVatAmount", "500");
		list.put("budgetRemainAmt", "100000");
		list.put("slip", GetSlips());
		lists.add(list);
		return lists;
	}

	private List<Map<String, Object>> GetSlips() {
		List<Map<String, Object>> slips = new ArrayList<>();
		HashMap<String, Object> slip1 = new HashMap<>();
		HashMap<String, Object> slip2 = new HashMap<>();
		HashMap<String, Object> slip3 = new HashMap<>();
		slip1.put("slipNum", "1");
		slip1.put("slipNum2", "1");
		slip1.put("slipPartnerName", "한국상사(주)");
		slip1.put("slipAcctName", "복리후생비_식대");
		slip1.put("slipDrcrGbn", "차변");
		slip1.put("slipDrcrGbnCode", "dr");
		slip1.put("slipCrAmt", "0.00");
		slip1.put("slipEmpName", "김더존");
		slip1.put("slipDrAmt", "5000.00");
		slip1.put("slipCardName", "현대카드(매입)");
		slip1.put("slipProjectName", "신규 프로젝트");
		slip1.put("mng", GetMngs());
		slips.add(slip1);
		slip2.put("slipNum", "2");
		slip2.put("slipNum2", "2");
		slip2.put("slipPartnerName", "한국상사(주)");
		slip2.put("slipAcctName", "부가세대급금");
		slip2.put("slipDrcrGbn", "차변");
		slip2.put("slipDrcrGbnCode", "dr");
		slip2.put("slipCrAmt", "0.00");
		slip2.put("slipEmpName", "김더존");
		slip2.put("slipDrAmt", "500.00");
		slip2.put("slipCardName", "현대카드(매입)");
		slip2.put("slipProjectName", "신규 프로젝트");
		slip2.put("mng", GetMngs());
		slips.add(slip2);
		slip3.put("slipNum", "3");
		slip3.put("slipNum2", "1");
		slip3.put("slipPartnerName", "현대카드(매입)");
		slip3.put("slipAcctName", "미지급금");
		slip3.put("slipDrcrGbn", "대변");
		slip3.put("slipDrcrGbnCode", "cr");
		slip3.put("slipCrAmt", "5500.00");
		slip3.put("slipEmpName", "김더존");
		slip3.put("slipDrAmt", "0.00");
		slip3.put("slipCardName", "현대카드(매입)");
		slip3.put("slipProjectName", "신규 프로젝트");
		slip3.put("mng", GetMngs());
		slips.add(slip3);
		return slips;
	}

	private List<Map<String, Object>> GetMngs() {
		List<Map<String, Object>> mngs = new ArrayList<>();
		HashMap<String, Object> mng1 = new HashMap<>();
		HashMap<String, Object> mng2 = new HashMap<>();
		HashMap<String, Object> mng3 = new HashMap<>();
		HashMap<String, Object> mng4 = new HashMap<>();
		HashMap<String, Object> mng5 = new HashMap<>();
		HashMap<String, Object> mng6 = new HashMap<>();
		HashMap<String, Object> mng7 = new HashMap<>();
		mng1.put("mngNum", "1");
		mng1.put("ctdCode", "00003");
		mng1.put("ctdName", "한국상사");
		mng1.put("mngCode", "A1");
		mng1.put("mngName", "거래처");
		mngs.add(mng1);
		mng2.put("mngNum", "2");
		mng2.put("ctdCode", "00003");
		mng2.put("ctdName", "한국상사");
		mng2.put("mngCode", "B1");
		mng2.put("mngName", "거래처명");
		mngs.add(mng2);
		mng3.put("mngNum", "3");
		mng3.put("ctdCode", "1300");
		mng3.put("ctdName", "관리부");
		mng3.put("mngCode", "C1");
		mng3.put("mngName", "사용부서");
		mngs.add(mng3);
		mng4.put("mngNum", "4");
		mng4.put("ctdCode", "0002");
		mng4.put("ctdName", "신규 프로젝트");
		mng4.put("mngCode", "D1");
		mng4.put("mngName", "프로젝트");
		mngs.add(mng4);
		mng5.put("mngNum", "5");
		mng5.put("ctdCode", "0");
		mng5.put("ctdName", "-");
		mng5.put("mngCode", "H3");
		mng5.put("mngName", "불공제세액");
		mngs.add(mng5);
		mng6.put("mngNum", "6");
		mng6.put("ctdCode", "00003");
		mng6.put("ctdName", "한국상사");
		mng6.put("mngCode", "A1");
		mng6.put("mngName", "거래처연동");
		mngs.add(mng6);
		mng7.put("mngNum", "7");
		mng7.put("ctdCode", "");
		mng7.put("ctdName", "");
		mng7.put("mngCode", "M1");
		mng7.put("mngName", "사용자설정항목");
		mngs.add(mng7);
		return mngs;
	}

	/* 외부연동프로세스 한글 양식 생성 */
	@Override
	public ResultVO NpDocMake(Map<String, Object> params) throws Exception {
		/* 변수 정의 */
		ResultVO result = new ResultVO();
		Map<String, Object> htmlInfo = new LinkedHashMap<String, Object>();
		String approKey = params.get(commonCode.APPROKEY).toString();
		String processId = params.get(commonCode.PROCESSID).toString();
		/* 기본 영리 설정 */
		String tdHeadStyle = "align=\"center\" style=\"background-color:rgb(231, 230, 230);text-align:center;font-family:돋움;font-size:10pt;line-height:1.2;\"";
		String tdbodyStyle = "align=\"center\" style=\"text-align:center;line-height:1.2;font-family:돋움;font-size:10pt;\"";
		// boolean isEa = (CommonConvert.CommonGetStr(params.get("eaType")).equals("ea")
		// ? true : false);
		boolean isEa;
		if (CommonConvert.CommonGetStr(params.get("eaType")).equals("ea")) {
			isEa = true;
		} else {
			isEa = false;
		}

		if (isEa) {
			tdHeadStyle = "valign=\"middle\" bgcolor=\"#e5e5e5\" style=\"border-left:solid #000000 1.1pt;border-right:solid #000000 1.1pt;border-top:solid #000000 1.1pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\"";
			tdbodyStyle = "valign=\"middle\" style=\"border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt;\"";
		}
		/* 초기값 설정 */
		htmlInfo.put("html", "");
		/* 양식 정보 조회 */
		/* 데이터 조회 및 HTML 가공 - 임시 */
		List<Map<String, Object>> basicInfo = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> headInfo = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> budgetInfo = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> tradeInfo = new ArrayList<Map<String, Object>>();
		if (processId.indexOf("EXNPCON") > -1) { /* 품의서 정보 조회 */
			params.put(commonCode.CONSDOCSEQ, approKey.split(processId + "_NP_")[1]);
			basicInfo = consService.selectConsDoc(params).getAaData();
			headInfo = consService.selectConsHead(params).getAaData();
			budgetInfo = consService.selectConsBudget(params).getAaData();
			tradeInfo = consService.selectConsTrade(params).getAaData();
		} else if (processId.indexOf("EXNPRES") > -1) { /* 결의서 정보 조회 */
			params.put(commonCode.RESDOCSEQ, approKey.split(processId + "_NP_")[1]);
			basicInfo = resService.selectResDoc(params).getAaData();
			headInfo = resService.selectResHead(params).getAaData();
			budgetInfo = resService.selectResBudget(params).getAaData();
			tradeInfo = resService.selectResTrade(params).getAaData();
		}
		/* resDocHtml 결의서 양식 코드 적용 */
		String resDocHtml = "";
		/* 1번 테이블 */
		resDocHtml = "";
		resDocHtml += " <table style=\"border-collapse:collapse;border:none;width:100%table-layout:fixed\" cellspacing=\"0\" cellpadding=\"0\" border=\"1\">";
		resDocHtml += " 	<tbody>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:80;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">문서번호</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"5\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("docNo")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:80;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">회계연도</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"7\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("erpExpendYear")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:80;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">회계구분</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("null")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:80;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">품의부서</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"5\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("deptName")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:80;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">사업계획</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"7\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(budgetInfo.get(0).get("erpBizplanName")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:80;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">품의일자</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(headInfo.get(0).get("consDate")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:80;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">금&nbsp;&nbsp;&nbsp; 액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"16\" style=\"width:348;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"> <span>일금  원정 ("
				+ CommonConvert.ReturnIntComma(CommonConvert.CommonGetSeq(basicInfo.get(0).get("docAmt")))
				+ ")</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:80;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">품의일자</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:134;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("null")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:80;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">제&nbsp;&nbsp;&nbsp; 목</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"24\" style=\"width:562;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(basicInfo.get(0).get("null")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:80;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">적&nbsp;&nbsp;&nbsp; 요</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"24\" style=\"width:562;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:double #000000 1.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
				+ CommonConvert.CommonGetStr(headInfo.get(0).get("consNote")) + "</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		/* 2번 테이블 */
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"26\" style=\"width:643;height:32;border-left:solid #000000 1.1pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;;letter-spacing:50%;font-weight:&quot;bold&quot;\">예산과목</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td style=\"width:25;height:25;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">순번</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:69;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">사업계획명</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:69;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">예산계정</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:69;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">예산세목</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:69;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">예산총액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:65;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">기집행액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:72;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">승인대기액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:72;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">금회집행액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:65;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">예산잔액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td style=\"width:69;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">결재수단</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		/* 2번 테이블 본문 */
		int budgetSeq = 0;
		for (Map<String, Object> tBudget : budgetInfo) {
			budgetSeq++;
			resDocHtml += " 	<tr>";
			resDocHtml += " 		<td style=\"width:25;height:28;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ budgetSeq + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"2\" style=\"width:69;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tBudget.get("erpBizplanName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"2\" style=\"width:69;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle16\" style=\"line-height:160%;background-color:#ffffff;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tBudget.get("erpBgacctName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:69;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle16\" style=\"line-height:160%;background-color:#ffffff;\"><span style=\"font-size:9.7pt;font-family:&quot;HY중고딕&quot;;letter-spacing:-11%;line-height:160%\">"
					+ CommonConvert.CommonGetStr(tBudget.get("erpFiacctName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"4\" style=\"width:69;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetSeq(tBudget.get("null")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:65;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetSeq(tBudget.get("null")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"4\" style=\"width:72;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetSeq(tBudget.get("null")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:72;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.ReturnIntComma(CommonConvert.CommonGetSeq(tBudget.get("budgetAmt")))
					+ "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:65;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetSeq(tBudget.get("null")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td style=\"width:69;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;;letter-spacing:-13%\">"
					+ CommonConvert.CommonGetStr(tBudget.get("setFgName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 	</tr>";
		}
		/* 3번 테이블 */
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"26\" style=\"width:643;height:32;border-left:solid #000000 1.1pt;border-right:solid #000000 1.1pt;border-top:double #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;;letter-spacing:50%;font-weight:&quot;bold&quot;\">세부명세</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td rowspan=\"2\" style=\"width:25;height:49;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;line-height:110%;\"><span style=\"font-family:&quot;HY중고딕&quot;\">순번</span></p>																												   ";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">거래처명</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">예금주</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">은행명</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">계좌번호</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">금액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"4\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">공급가액</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"3\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">부가세</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 			<td colspan=\"2\" style=\"width:77;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">	";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">거래일자</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		resDocHtml += " 		<tr>";
		resDocHtml += " 			<td colspan=\"25\" style=\"width:617;height:25;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\" bgcolor=\"#e5e5e5\">";
		resDocHtml += " 				<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">적요</span></p>";
		resDocHtml += " 			</td>";
		resDocHtml += " 		</tr>";
		/* 3번 테이블 본문 */
		int trSeq = 0;
		for (Map<String, Object> tTrade : tradeInfo) {
			trSeq++;
			resDocHtml += " 	<tr>";
			resDocHtml += " 		<td rowspan=\"2\" style=\"width:25;height:57;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ trSeq + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tTrade.get("trName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"2\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tTrade.get("depositor")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"4\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tTrade.get("btrName")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"4\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tTrade.get("baNb")) + "</span></p>";
			resDocHtml += " 		</td>";
			int totalAmt = 0;
			String totalAmtStr = "";
			totalAmt = Integer.parseInt(CommonConvert.CommonGetSeq(tTrade.get("tradeStdAmt")))
					+ Integer.parseInt(CommonConvert.CommonGetSeq(tTrade.get("tradeVatAmt")));
			totalAmtStr = Integer.toString(totalAmt);
			resDocHtml += " 		<td colspan=\"3\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.ReturnIntComma(totalAmtStr) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"4\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.ReturnIntComma(CommonConvert.CommonGetSeq(tTrade.get("tradeStdAmt")))
					+ "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"3\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:right;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.ReturnIntComma(CommonConvert.CommonGetSeq(tTrade.get("tradeVatAmt")))
					+ "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 		<td colspan=\"2\" style=\"width:77;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.ReturnDateFormat(tTrade.get("regDate")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 	</tr>";
			resDocHtml += " 	<tr>";
			resDocHtml += " 		<td colspan=\"25\" style=\"width:617;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt\" valign=\"middle\">";
			resDocHtml += " 			<p class=\"HStyle0\" style=\"text-align:center;\"><span style=\"font-family:&quot;HY중고딕&quot;\">"
					+ CommonConvert.CommonGetStr(tTrade.get("tradeNote")) + "</span></p>";
			resDocHtml += " 		</td>";
			resDocHtml += " 	</tr>";
		}
		resDocHtml += " 	</tbody>";
		resDocHtml += " </table>";
		htmlInfo.put("html", resDocHtml);
		result.setaData(htmlInfo);
		return result;
	}

	@Override
	public String NpInterlockCodeQuery(Map<String, Object> params) throws Exception {
		JedisClient jedis = CloudConnetInfo.getJedisClient();

		List<Map<String, String>> jedisConnectionList = jedis.getCustInfoList();

		String consDocSeq = CommonConvert.CommonGetStr(params.get("consDocSeq"));

		String tripConsDocSeq = CommonConvert.CommonGetStr(params.get("tripConsDocSeq"));
		String tripResDocSeq = CommonConvert.CommonGetStr(params.get("tripResDocSeq"));
		String gisuFromDate = CommonConvert.CommonGetStr(params.get("gisuFromDate"));
		String gisuToDate = CommonConvert.CommonGetStr(params.get("gisuToDate"));
		String resDocSeq = CommonConvert.CommonGetStr(params.get("resDocSeq"));
		String query = "";

		String processId = CommonConvert.CommonGetStr(params.get("processId"));
		String approKey = CommonConvert.CommonGetStr(params.get("approKey"));
		String formSeq = CommonConvert.CommonGetStr(params.get("formSeq"));
		String formGb = CommonConvert.CommonGetStr(params.get("form_gb"));
		String formType = CommonConvert.CommonGetStr(params.get("formType"));
		String moduleType = "I";
		if (processId.length() == 8) {
			moduleType = "" + processId.charAt(7);
		}
		if (formType.equals("CONS") || formType.equals("TRIPCONS")) {
			/* 품의서 양식코드 조회 쿼리 */
			query = "";
			query += " /* BCommonFormServiceImpl.java - NpInterlockCodeQuery */																																												";
			query += " /* 외부시스템 연동 - 비영리 회계 2.0 품의서 양식 코드 조회 */																																										";
			query += " SELECT																																																								";
			query += " '1'						AS 'isEXNP'																																																	";
			query += " , head.cons_seq		AS resConsSeq																																																	";
			query += " , budget.cons_seq	AS budgetConsSeq																																																";
			query += " , budget.budget_seq	AS budgetBudgetSeq																																																";
			query += " 		, IFNULL(item.item_name,'')						AS AI_ITEM_NAME							";
			query += " 		, IFNULL(item.item_size,'')						AS AI_ITEM_SIZE							";
			query += "		, IFNULL(item.item_unit,'')			AS AI_ITEM_UNIT 																																													";
			query += "		, IFNULL(item.item_cnt,'')			AS AI_ITEM_CNT																																											";
			query += "		, IFNULL(item.unit_amt,'')			AS AI_UNIT_AMT																									";
			query += "		, IFNULL(item.item_amt,'')			AS AI_ITEM_AMT																									";
			query += "	    , IFNULL(item.item_note,'')  AS AI_ITEM_NOTE																																											";
			query += " 		, ''						AS A_DOCU_FG_NM																																																";
			query += " 		, IFNULL(head.docu_fg_code,'')						AS A_DOCU_FG_CD							";
			query += " 		, IFNULL(head.docu_fg_name,'')						AS A_DOCU_FG_NAME							";
			query += " , IFNULL(head.cons_note,'')			AS A_NOTE																																														";
			query += " , IFNULL(head.erp_comp_seq,'')			AS A_ERP_CO_CD																																												";
			query += " , IFNULL(LEFT(head.create_date,10 ),'')  AS A_CREATE_DT																																												";
			query += " , IFNULL(CONCAT(SUBSTRING(cons_date,1,4),'-',SUBSTRING(cons_date,5,2),'-',SUBSTRING(cons_date,7,2)),'')			AS A_GISU_DT																										";
			query += " , IFNULL(CONCAT(SUBSTRING(cons_date,1,4),'.',SUBSTRING(cons_date,5,2),'.',SUBSTRING(cons_date,7,2)),'')			AS A_DOT_GISU_DT																										";
			query += " , IFNULL(head.erp_emp_seq,'')			AS A_ERP_EMP_CD																																												";
			query += " , IFNULL(head.erp_emp_name,'')			AS A_ERP_EMP_NM																																												";
			query += " , IFNULL(head.erp_div_seq,'')			AS A_ERP_DIV_CD																																												";
			query += " , IFNULL(head.erp_div_name,'')			AS A_ERP_DIV_NM																																												";
			query += " , IFNULL(head.pjtFromDt,'')			AS A_PJT_FROM_DT																										";
			query += " , IFNULL(head.pjtToDt,'')			AS A_PJT_TO_DT																										";
			query += " , IFNULL(head.erp_pc_seq,'')			AS A_ERP_PC_CD																																													";
			query += " , IFNULL(head.erp_pc_name,'')			AS A_ERP_PC_NM																																												";
			query += " , IFNULL(head.erp_dept_seq,'')			AS A_ERP_DEPT_CD																																											";
			query += " , IFNULL(head.erp_dept_name,'')			AS A_ERP_DEPT_NM																																											";
			query += " , IFNULL(head.erp_gisu,'')			AS A_ERP_GISU																																													";
			query += " , IFNULL(head.erp_gisu_from_date,'')		AS A_ERP_GISU_START_DT																																										";
			query += " , IFNULL(head.erp_gisu_to_date ,'')		AS A_ERP_GISU_END_DT																																										";
			query += " , IFNULL(head.erp_year,'')			AS A_ERP_YEAR																																													";
			query += " , IFNULL(head.mgt_seq,'')			AS A_MGT_CD																																														";
			query += " , IFNULL(head.mgt_name,'')			AS A_MGT_NM																																														";
			query += " , IFNULL(head.btr_seq,'')			AS A_BTR_CD																																														";
			query += " , IFNULL(head.btr_name,'')			AS A_BTR_NM																																														";
			query += " , IFNULL(head.btr_nb,'')			AS A_BTR_NB																																															";
			query += " , IFNULL(head.bottom_seq,'')			AS A_BOTTOM_CD																																													";
			query += " , IFNULL(head.bottom_name,'')			AS A_BOTTOM_NM																																												";
			query += " , IFNULL(budget.head_cons_date ,'')		AS AB_GISU_DT																																												";
			query += " , IFNULL(CONCAT(SUBSTRING(budget.head_cons_date,1,4),'.',SUBSTRING(budget.head_cons_date,5,2),'.',SUBSTRING(budget.head_cons_date,7,2)),'')			AS AB_DOT_GISU_DT																";
			query += " , IFNULL(CONCAT(SUBSTRING(budget.head_cons_date,1,4),'-',SUBSTRING(budget.head_cons_date,5,2),'-',SUBSTRING(budget.head_cons_date,7,2)),'')			AS AB_HYPHEN_GISU_DT															";
			query += " , IFNULL(budget.erp_budget_seq ,'')		AS AB_BGT_CD																																												";
			query += " , IFNULL(budget.erp_budget_name,'')		AS AB_BGT_NM																																												";
			query += " , IFNULL(budget.mgt_seq ,'')		AS AB_MGT_CD																																														";
			query += " , IFNULL(budget.mgt_name,'')		AS AB_MGT_NM																																														";
			query += " , IFNULL(budget.erp_pc_seq,'')		AS AB_ERP_PC_CD																																													";
			query += " , IFNULL(budget.erp_pc_name,'')		AS AB_ERP_PC_NM																																														";
			query += " , IFNULL(budget.erp_bgt1_seq  ,'')		AS AB_BGT_CD_A																																												";
			query += " , IFNULL(budget.erp_bgt1_name ,'')		AS AB_BGT_NM_A																																												";
			query += " , IFNULL(budget.erp_bgt2_seq  ,'')		AS AB_BGT_CD_B																																												";
			query += " , IFNULL(budget.erp_bgt2_name ,'')		AS AB_BGT_NM_B																																												";
			query += " , IFNULL(budget.erp_bgt3_seq  ,'')		AS AB_BGT_CD_C																																												";
			query += " , IFNULL(budget.erp_bgt3_name ,'')		AS AB_BGT_NM_C																																												";
			query += " , IFNULL(budget.erp_bgt4_seq  ,'')		AS AB_BGT_CD_D																																												";
			query += " , IFNULL(budget.erp_bgt4_name ,'')		AS AB_BGT_NM_D																																												";
			query += " , IFNULL(budget.erp_level01_seq  ,'')	AS AB_BGT_LEVEL_CD_A																																										";
			query += " , IFNULL(budget.erp_level01_name  ,'')	AS AB_BGT_LEVEL_NM_A																																										";
			query += " , IFNULL(budget.erp_level02_seq  ,'')	AS AB_BGT_LEVEL_CD_B																																										";
			query += " , IFNULL(budget.erp_level02_name  ,'')	AS AB_BGT_LEVEL_NM_B																																										";
			query += " , IFNULL(budget.erp_level03_seq  ,'')	AS AB_BGT_LEVEL_CD_C																																										";
			query += " , IFNULL(budget.erp_level03_name  ,'')	AS AB_BGT_LEVEL_NM_C																																										";
			query += " , IFNULL(budget.erp_level04_seq  ,'')	AS AB_BGT_LEVEL_CD_D																																										";
			query += " , IFNULL(budget.erp_level04_name  ,'')	AS AB_BGT_LEVEL_NM_D																																										";
			query += " , IFNULL(budget.erp_level05_seq  ,'')	AS AB_BGT_LEVEL_CD_E																																										";
			query += " , IFNULL(budget.erp_level05_name  ,'')	AS AB_BGT_LEVEL_NM_E																																										";
			query += " , IFNULL(budget.erp_level06_seq  ,'')	AS AB_BGT_LEVEL_CD_F																																										";
			query += " , IFNULL(budget.erp_level06_name  ,'')	AS AB_BGT_LEVEL_NM_F																																										";

			query += " , IFNULL(budget.erp_div_seq ,'')		AS AB_ERP_DIV_CD																																												";
			query += " , IFNULL(budget.erp_div_name,'')		AS AB_DIV_NM																																													";
			query += " , IFNULL(budget.budget_note	,'')		AS AB_NOTE																																													";
			query += " , IFNULL(budget.budget_amt 	,'')		AS AB_APPLY_AM																																												";
			query += " , IFNULL( CASE WHEN ctl_fg_code = '0' THEN budget.budget_std_amt ELSE budget.budget_amt END, '') AS AB_APPLY_NON_VAT_AM																												";
			query += " , IFNULL((																																																							";
			query += " 	SELECT SUM(budget_amt) 																																																				";
			query += " 	FROM $DB_NEOS$t_exnp_consbudget 																																																				";
			query += " 	WHERE cons_doc_seq = '#consDocSeq#'																																																	";
			query += " 	GROUP BY cons_doc_seq 																																																				";
			query += " ) ,'')						AS AB_TOTAL_APPLY_AM																																													";
			query += " , IFNULL(budget.erp_open_amt,'')		AS AB_OPEN_AM																																													";
			query += " , IFNULL(budget.erp_apply_amt,'')		AS AB_ERP_APPLY_AM																																											";
			query += " , IFNULL(budget.erp_left_amt ,'')		AS AB_LEFT_AM																																												";
			query += " , IFNULL(budget.erp_bizplan_name ,'')		AS AB_BIZPLAN_NM																																										";
			query += " , IFNULL(budget.erp_fiacct_name ,'')		AS AB_FIACCT_NM																																												";
			query += " , IFNULL(budget.erp_bgacct_name ,'')		AS AB_BGACCT_NM																																												";
			query += " , IFNULL(budget.erp_fiacct_seq ,'')		AS AB_FIACCT_CD																																												";
			query += " , IFNULL(budget.erp_bizplan_seq ,'')		AS AB_BIZPLAN_CD																																											";
			query += " , IFNULL(budget.erp_bgacct_seq ,'')		AS AB_BGACCT_CD																																												";
			query += " , ''						AS AB_ACCEPT_AM																																																";
			query += " , ''						AS AB_REFFER_AM																																																";
			query += " , ''						AS AB_GW_APPLY_AM																																															";
			query += " , ''						AS AB_GW_LEFT_AM																																															";
			query += " , ''						AS AB_TOTAL_RESULT_AM																																														";
			query += " , ''						AS AB_TOTAL_NON_VAT_AM																																														";
			query += " , ''						AS AB_TOTAL_USE_AM																																															";
			query += " , ''						AS AB_TOTAL_CONS_BALANCE_AM																																													";
			query += " , IFNULL((																																																							";
			query += " 	SELECT																																																								";
			query += " 		(																																																								";
			query += " 			CASE consB.conffer_budget_return_yn WHEN 'Y' THEN 0																																											";
			query += " 			ELSE SUM( IFNULL(consB.budget_amt, 0 )) 		- SUM( IFNULL(resB.budget_amt, 0 ))																																			";
			query += " 			END																																																							";
			query += " 		)	AS 'balanceAmt'																																																				";
			query += " 	FROM	(																																																							";
			query += " 		SELECT	*																																																						";
			query += " 		FROM 	$DB_NEOS$t_exnp_consdoc																																																		";
			query += " 		WHERE 	conffer_return_yn != 'Y'																																																";
			query += " 		 AND	doc_status IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																																		";
			query += " 	)	consD																																																							";
			query += " 	INNER JOIN 	(																																																						";
			query += " 		SELECT	*																																																						";
			query += " 		FROM	$DB_NEOS$t_exnp_conshead																																																	";
			query += " 	)	consH																																																							";
			query += " 	 ON	consD.cons_doc_seq = consH.cons_doc_seq																																															";
			query += " 	INNER JOIN	(																																																						";
			query += " 		SELECT	*																																																						";
			query += " 		FROM	$DB_NEOS$t_exnp_consbudget																																																	";
			query += " 		WHERE	conffer_budget_return_yn = 'N'																																															";
			query += " 	)	consB																																																							";
			query += " 	 ON		consD.cons_doc_seq	= consB.cons_doc_seq																																													";
			query += " 	 AND	consH.cons_seq		= consB.cons_seq																																														";
			query += " 																																																										";
			query += " 	LEFT JOIN	(																																																						";
			query += " 		SELECT																																																							";
			query += " 			rb.conffer_doc_seq																																																			";
			query += " 			, rb.conffer_seq																																																			";
			query += " 			, rb.conffer_budget_seq																																																		";
			query += " 			, rb.erp_budget_seq																																																			";
			query += " 			, IFNULL(rb.erp_bgacct_seq, '')	AS erp_bgacct_seq																																											";
			query += " 			, SUM( rb.budget_std_amt ) 	AS budget_std_amt																																												";
			query += " 			, SUM( rb.budget_tax_amt )AS budget_tax_amt																																													";
			query += "              ,SUM(( CASE ctl_fg_code WHEN '0' THEN ( CASE IFNULL(budget_std_amt, 0) WHEN '0' THEN budget_amt ELSE budget_std_amt END ) ELSE budget_amt END ))	AS budget_amt                                                       ";
			query += " 		FROM	$DB_NEOS$t_exnp_resbudget rb																																																";
			query += " 		 INNER JOIN $DB_NEOS$t_exnp_resdoc rd																																																";
			query += " 		 ON 	rd.res_doc_seq = rb.res_doc_seq																																															";
			query += " 		  AND	IFNULL(rd.doc_status, '008') IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																													";
			query += " 		  AND	rd.doc_seq IS NOT NULL																																																	";
			query += " 		WHERE	IFNULL(rb.conffer_doc_seq, '') != ''																																													";
			query += " 		GROUP	BY rb.conffer_doc_seq, rb.conffer_seq, rb.conffer_budget_seq, rb.erp_budget_seq																																			";
			if (processId.equals("EXNPCONU")) {
				query += " 	 , rb.erp_bgacct_seq 																																																			";
			}
			query += " 		HAVING 	budget_amt != 0																																																			";
			query += " 	) resB																																																								";
			query += " 	 ON 	consB.cons_doc_seq = resB.conffer_doc_seq																																													";
			query += " 	 AND	consB.cons_seq = resB.conffer_seq																																															";
			query += " 	 AND	consB.budget_seq = resB.conffer_budget_seq																																													";
			query += " 	WHERE	consD.erp_gisu = budget.erp_gisu																																															";
			query += " 	 AND	consH.mgt_seq = budget.mgt_seq																																																";
			query += " 	 AND	consB.budget_seq != budget.budget_seq																																													";
			query += " 	 AND 	consB.erp_budget_seq = budget.erp_budget_seq																																												";
			query += " 	 AND 	IFNULL(consh.bottom_seq,'') = IFNULL(budget.bottom_seq,'')																																												";
			if (processId.equals("EXNPCONU")) {
				query += " 	 AND 	ifnull(consB.erp_bizplan_seq,'') = ifnull(budget.erp_bizplan_seq,'')																																											";
				query += " 	 AND 	ifnull(consB.erp_bgacct_seq,'') = ifnull(budget.erp_bgacct_seq,'')																																											";
				query += " 	 AND 	consH.cons_date >= '#gisuFromDate#' AND consH.cons_date <= '#gisuToDate#'																																											";
			}
			query += " 	 AND 	consD.erp_comp_seq = budget.erp_comp_seq																																											";
			query += " 	 AND 	consD.erp_div_seq = budget.head_erp_div_seq																																											";
			query += " 	GROUP BY  consB.erp_budget_seq																																																		";
			query += " ), '')	AS AB_CONS_BALANCE_AM																																																		";
			query += " , IFNULL((																																																							";
			query += " 	SELECT																																																								";
			query += " 		SUM( ( CASE IFNULL(ctl_fg_code, '1')																																																";
			query += " 					WHEN '0'	THEN 	( CASE IFNULL(budget_std_amt, 0) WHEN '0' THEN IFNULL(budget_amt, 0) ELSE IFNULL(budget_std_amt, 0) END )																																										";
			query += " 					ELSE		IFNULL(budget_amt, 0)	/* emptyStr or '1' */																																							";
			query += " 				END)																																																					";
			query += " 		)	AS 'resBudgetAmt'																																																			";
			query += " 	FROM	(																																																							";
			query += " 		SELECT	*																																																						";
			query += " 		FROM 	$DB_NEOS$t_exnp_resdoc																																																		";
			query += " 		WHERE 	erp_send_yn != 'Y'																																																		";
			query += " 		AND		IFNULL(doc_status, '008') IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																														";
			query += " 		AND		doc_seq IS NOT NULL																																																		";
			query += " 	)	resD																																																							";
			query += " 	INNER JOIN	(																																																						";
			query += " 		SELECT	*																																																						";
			query += " 		FROM	$DB_NEOS$t_exnp_reshead																																																		";
			query += " 	)	resH																																																							";
			query += " 	 ON	resD.res_doc_seq = resH.res_doc_seq																																																";
			query += " 	INNER JOIN	(																																																						";
			query += " 		SELECT	*																																																						";
			query += " 		FROM	$DB_NEOS$t_exnp_resbudget																																																	";
			query += " 																																																										";
			query += " 	)	resB																																																							";
			query += " 	 ON	resD.res_doc_seq = resB.res_doc_seq																																																";
			query += " 	 AND	resH.res_seq = resB.res_seq																																																	";
			query += " 																																																										";
			query += " 	WHERE	resH.mgt_seq = budget.mgt_seq																																																";
			query += " 	 AND	resD.erp_gisu = budget.erp_gisu																																																";
			query += " 	 AND 	resB.erp_budget_seq = budget.erp_budget_seq																																													";
			query += " 	 AND 	IFNULL(resh.bottom_seq,'') = IFNULL(budget.bottom_seq,'')																																													";
			if (processId.equals("EXNPCONI")) {
				query += " 	 AND    resD.erp_div_seq = budget.head_erp_div_seq																																													";
			}
			if (processId.equals("EXNPCONU")) {
				query += " 	 AND 	ifnull(resB.erp_bizplan_seq,'') = ifnull(budget.erp_bizplan_seq,'')																																											";
				query += " 	 AND 	ifnull(resB.erp_bgacct_seq,'') = ifnull(budget.erp_bgacct_seq,'')																																												";
				query += " 	 AND 	resH.res_date >= '#gisuFromDate#' AND resH.res_date <= '#gisuToDate#'																																												";
			}
			query += " 	 AND    resD.erp_comp_seq = budget.erp_comp_seq																																													";
			query += " 	GROUP BY  resB.erp_budget_seq																																																		";
			query += " ), '')	AS AB_NON_SEND_RES_AM																																																		";

			query += " , IFNULL( tdoc.comp_name, '' )					AS T_COMP_NAME																						";
			query += " , IFNULL( tdoc.dept_name, '' )					AS T_DEPT_NAME																						";
			query += " , IFNULL( tdoc.emp_name, '' )					AS T_EMP_NAME																						";
			query += " , (	CASE	IFNULL( tattend.domestic_code, '' ) 																									";
			query += " 	WHEN '0' THEN '국내' 																																";
			query += " 	WHEN '1' THEN '해외'  																															    ";
			query += " 	ELSE '' 																																			";
			query += " END																																					";
			query += " )												AS TA_DOMESTIC_CODE																					";
			query += " , IFNULL(SUBSTRING(tattend.trip_from_date,1,10), '') 	AS TA_TRIP_FROM_DATE																";
			query += " , IFNULL(SUBSTRING(tattend.trip_from_date,12,5), '') 	AS TA_TRIP_FROM_TIME																";
			query += " , IFNULL(SUBSTRING(tattend.trip_to_date,1,10), '') 		AS TA_TRIP_TO_DATE																	";
			query += " , IFNULL(SUBSTRING(tattend.trip_to_date,12,5), '') 		AS TA_TRIP_TO_TIME																	";
			query += " , IFNULL( tattend.calendar_name, '' )							AS TA_CALENDAR_NAME																	";
			query += " , IFNULL( tattend.location_name, '' )							AS TA_LOCATION_NAME																	";
			query += " , IFNULL( tattend.location_adv, '' )								AS TA_LOCATION_ADV																	";
			query += " , IFNULL( tattend.transport_name, '' )							AS TA_TRANSPORT_NAME																";
			query += " , IFNULL( tattend.purpose, '' )									AS TA_PURPOSE																		";
			query += " , (	CASE	IFNULL( tattend.trip_expense_code, '' ) 																								";
			query += " 	WHEN '0' THEN '대상' 																																";
			query += " 	WHEN '1' THEN '비대상'  																															";
			query += " 	ELSE '' 																																			";
			query += " END																																					";
			query += " )			  													AS TA_TRIP_EXPENSE_CODE																";
			query += " , IFNULL( ttraveler.comp_name, '' )								AS TT_COMP_NAME																		";
			query += " , IFNULL( ttraveler.dept_name, '' )								AS TT_DEPT_NAME																		";
			query += " , IFNULL( ttraveler.emp_name, '' )								AS TT_EMP_NAME																		";
			query += " , IFNULL( ttraveler.duty_name, '' )								AS TT_DUTY_NAME																		";
			query += " , IFNULL( ttraveler.duty_group_name_kr, '' )								AS TT_DUTY_GROUP_NAME																		";
			query += " , IFNULL( ttraveler.duty_group_name_en, '' )								AS TT_DUTY_GROUP_NAME_EN																		";
			query += " , IFNULL(texpense.amtClass1Name,'')								AS TE_AMTCLASS1_NAME																";
			query += " , IFNULL(texpense.amtClass1Amt,'')								AS TE_AMTCLASS1_AMT																	";
			query += " , CASE IFNULL(texpense.amtClass1DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS1_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass1HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS1_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass2Name,'')																			AS TE_AMTCLASS2_NAME					";
			query += " , IFNULL(texpense.amtClass2Amt,'')																			AS TE_AMTCLASS2_AMT						";
			query += " , CASE IFNULL(texpense.amtClass2DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS2_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass2HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS2_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass3Name,'')																			AS TE_AMTCLASS3_NAME					";
			query += " , IFNULL(texpense.amtClass3Amt,'')																			AS TE_AMTCLASS3_AMT						";
			query += " , CASE IFNULL(texpense.amtClass3DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS3_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass3HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS3_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass4Name,'')																			AS TE_AMTCLASS4_NAME					";
			query += " , IFNULL(texpense.amtClass4Amt,'')																			AS TE_AMTCLASS4_AMT						";
			query += " , CASE IFNULL(texpense.amtClass4DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS4_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass4HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS4_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass5Name,'')																			AS TE_AMTCLASS5_NAME					";
			query += " , IFNULL(texpense.amtClass5Amt,'')																			AS TE_AMTCLASS5_AMT						";
			query += " , CASE IFNULL(texpense.amtClass5DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS5_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass5HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS5_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass6Name,'')																			AS TE_AMTCLASS6_NAME					";
			query += " , IFNULL(texpense.amtClass6Amt,'')																			AS TE_AMTCLASS6_AMT						";
			query += " , CASE IFNULL(texpense.amtClass6DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS6_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass6HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS6_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClassSum, '')																			AS TE_AMT								";

			query += " FROM   (SELECT seq																																																					";
			query += " 	FROM   $DB_NEOS$t_exnp_code_seq) base																																																	";
			query += " LEFT JOIN (SELECT head.*																																																				";
			query += " 	  FROM   (SELECT @hrn := @hrn + 1 AS seq,																																															";
			query += " 			 head.*																																																						";
			query += " 		  FROM   $DB_NEOS$t_exnp_conshead head,																																																";
			query += " 			 (SELECT @hrn := 0) temp																																																	";
			query += " 		  WHERE  cons_doc_seq = '#consDocSeq#') head																																													";
			query += " 		 INNER JOIN $DB_NEOS$t_exnp_consdoc doc																																																";
			query += " 			 ON head.cons_doc_seq = doc.cons_doc_seq) head																																												";
			query += "       ON base.seq = head.seq																																																			";
			query += " LEFT JOIN (																																																							";
			query += " 	SELECT 	@trn := @trn + 1 AS seq																																																		";
			query += " 		, budget.*																																																						";
			query += " 		, budgetHead.cons_date		AS head_cons_date																																																			";
			query += " 		, budgetHead.erp_comp_seq																																																						";
			query += " 		, budgetHead.erp_gisu																																																			";
			query += " 		, budgetHead.mgt_seq																																																			";
			query += " 		, budgetHead.mgt_name																																																			";
			query += " 		, budgetHead.bottom_seq																																																			";
			query += " 		, budgetHead.erp_pc_seq																																																			";
			query += " 		, budgetHead.erp_pc_name																																																			";
			query += " 		, budgetHead.erp_div_seq AS head_erp_div_seq																																																			";
			query += " 	  FROM   (SELECT @trn := 0) temp, $DB_NEOS$t_exnp_consbudget budget																																										";
			query += " 	  INNER JOIN $DB_NEOS$t_exnp_conshead budgetHead																																														";
			query += " 	   ON	budget.cons_seq = budgetHead.cons_seq																																														";
			query += " 	  WHERE  budget.cons_doc_seq = '#consDocSeq#'																																														";
			query += " ) budget																																																								";
			query += " ON base.seq = budget.seq																																																				";
			/* 물품명세 양식코드 영역 */
			query += "	LEFT JOIN (																																																							";
			query += "	SELECT																																																								";
			query += "		@tdrn := @tdrn + 1 AS seq																																																		";
			query += "		, item.*																																																						";
			query += "	FROM	$DB_NEOS$t_exnp_consitem item, (SELECT @tdrn := 0) temp																																											";
			query += "	WHERE	cons_doc_seq = '#consDocSeq#'																																																	";
			query += "	)	item																																																				";
			query += "	ON	base.seq = item.seq																																																				";
			/* 출장복명 2.0 양식코드 영역 */
			query += " LEFT JOIN (																																																							";
			query += " SELECT																																																								";
			query += " 	@tdrn := @tdrn + 1 AS seq																																																			";
			query += " 	, tdoc.*																																																							";
			query += " FROM	$DB_NEOS$t_exnp_trip_cons_doc tdoc, (SELECT @tdrn := 0) temp																																												";
			query += " WHERE	trip_cons_doc_seq = '#tripConsDocSeq#'																																																	";
			query += " )	tdoc																																																							";
			query += " ON	base.seq = tdoc.seq																																																				";
			query += " LEFT JOIN (																																																							";
			query += " SELECT																																																								";
			query += " 	@tarn := @tarn + 1 AS seq																																																			";
			query += " 	, tattend.*																																																							";
			query += " FROM	$DB_NEOS$t_exnp_trip_cons_attend tattend, (SELECT @tarn := 0) temp																																										";
			query += " WHERE	trip_cons_doc_seq = '#tripConsDocSeq#'																																																	";
			query += " )	tattend																																																							";
			query += " ON	base.seq = tattend.seq																																																			";
			query += " LEFT JOIN (																																																							";
			query += " SELECT																																																								";
			query += " 	@ttrn := @ttrn + 1 AS seq																																																			";
			query += " 	, ttraveler.*																																																						";
			query += " 	, duty_group_name_kr																																																						";
			query += " 	, duty_group_name_en																																																						";
			query += " FROM	$DB_NEOS$t_exnp_trip_cons_traveler ttraveler																																									";
			query += " INNER JOIN $DB_NEOS$t_exnp_trip_set_dutygroup dutyGroup																																									";
			query += " ON	dutyGroup.duty_group_seq = ttraveler.duty_group_seq, (SELECT @ttrn := 0) temp																																		";
			query += " WHERE	trip_cons_doc_seq = '#tripConsDocSeq#'																																																	";
			query += " )	ttraveler																																																						";
			query += " ON	base.seq = ttraveler.seq																																																		";
			query += " LEFT JOIN (																																																						";
			query += " 	SELECT	@tern := @tern + 1 AS seq																																																";
			query += " 		, expense.*																																																					";
			query += " 	FROM	(																																																						";
			query += " 		SELECT																																																						";
			query += " 			trip_cons_doc_seq AS tripConsDocSeq																																														";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_class_code ELSE '0'  END) 			AS amtClass1Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_class_name ELSE '일비'  END) 		AS amtClass1Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass1Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass1Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass1DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='1' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass1HoldCode																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_class_code ELSE '1'  END) 			AS amtClass2Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_class_name ELSE '식비'  END) 		AS amtClass2Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass2Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass2Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass2DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='2' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass2HoldCode																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_class_code ELSE '2'  END) 			AS amtClass3Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_class_name ELSE '숙빅비'  END) 	AS amtClass3Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass3Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass3Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass3DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='3' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass3HoldCode																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_class_code ELSE '3'  END) 			AS amtClass4Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_class_name ELSE '운임비'  END) 	AS amtClass4Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass4Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass4Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass4DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='4' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass4HoldCode																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_class_code ELSE '4'  END) 			AS amtClass5Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_class_name ELSE '기타여비'  END) 	AS amtClass5Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass5Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass5Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass5DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='5' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass5HoldCode																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_class_code ELSE '5'  END) 			AS amtClass6Code																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_class_name ELSE '기타여비2'  END) 	AS amtClass6Name																										";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass6Amt																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass6Seq																											";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.domestic_code ELSE '0' END) 			AS amtClass6DomesticCode																								";
			query += " 			, MAX( CASE WHEN expense.amt_class_code='6' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass6HoldCode																										";
			query += " 			, SUM(expense_amt) 																AS amtClassSum																															";
			query += " 			, expense.comp_seq				AS compSeq																																												";
			query += " 			, expense.comp_name				AS compName																																												";
			query += " 			, expense.emp_seq				AS empSeq																																												";
			query += " 			, expense.emp_name				AS empName																																												";
			query += " 			, expense.duty_item_seq 		AS dutyItemSeq																																											";
			query += " 			, expense.duty_group_seq 		AS dutyGroupSeq																																											";
			query += "          ,(SELECT duty_group_name_kr FROM $DB_NEOS$t_exnp_trip_set_dutygroup dg WHERE dg.duty_group_seq = expense.duty_group_seq) AS dutyGroupName                                                                                        ";
			query += " 			, expense.transport_seq			AS transportSeq																																											";
			query += " 			, expense.location_seq			AS locationSeq																																											";
			query += " 			, expense.duty_name				AS dutyName																																												";
			query += " 		FROM	 $DB_NEOS$t_exnp_trip_cons_expense expense																																													";
			query += " 		LEFT JOIN $DB_NEOS$t_exnp_trip_set_amt amt																																															";
			query += " 		ON	amt.amt_seq = expense.amt_seq																																															";
			query += " 		WHERE	trip_cons_doc_seq = '#tripConsDocSeq#'																																															";
			query += " 		AND	emp_seq IS NOT NULL																																																		";
			query += " 		GROUP BY emp_seq,trip_cons_doc_seq,expense.comp_seq,expense.comp_name,expense.emp_name,expense.duty_item_seq,expense.duty_group_seq,expense.transport_seq,expense.location_seq,expense.duty_name							";
			query += " 	)	expense, (SELECT @tern := 0) temp																																															";
			query += " )	texpense																																																						";
			query += " ON	texpense.empSeq = ttraveler.emp_seq																																																";

			query = query.replace("#consDocSeq#", consDocSeq);
			query = query.replace("#tripConsDocSeq#", tripConsDocSeq);
			query = query.replace("#gisuFromDate#", gisuFromDate);
			query = query.replace("#gisuToDate#", gisuToDate);

			if (!jedis.getBuildType().equals("build")) {
				String cloudDBNEOS = "";
				for (int i = 0; i < jedisConnectionList.size(); i++) {
					cmLog.CommonSetInfoToDatabase("cloudDBNEOSfor문진입" + jedisConnectionList.get(i).toString(), "",
							"EXNP");
					if (jedisConnectionList.get(i).get("GROUP_SEQ").equals(params.get("groupSeq"))) {
						cloudDBNEOS = jedisConnectionList.get(i).get("DB_NEOS");

					}
				}
				query = query.replace("$DB_NEOS$", cloudDBNEOS.concat("."));
			} else {
				query = query.replace("$DB_NEOS$", "");
			}

			cmLog.CommonSetInfo("품의서 한글양식 코드 조회 쿼리 생성");
			cmLog.CommonSetInfo(query);
		} else if (formType.equals("RES") || formType.equals("TRIPRES")) {
			/* 결의서 양식 코드 조회 쿼리 */
			query = "";
			query += "	/* 결의서 양식 코드 조회 쿼리 */																																																	";
			query += "	/* BCommonFormServiceImpl.java - NpInterlockCodeQuery */																																											";
			query += "	/* 외부시스템 연동 - 비영리 회계 2.0 결의서 양식 코드 조회 */																																										";
			query += "		SELECT																																																							";
			query += "		'1'						AS 'isEXNP'																																																";
			query += "		, head.res_seq		AS resResSeq																																																";
			query += "		, CASE	IFNULL(budget.res_seq, '-1') WHEN '-1'																																													";
			query += "				THEN ''																																																					";
			query += "				ELSE																																																					";
			query += "					CONCAT((																																																			";
			query += "						CASE 	WHEN @PARTION = budget.res_seq THEN @HRANK																																								";
			query += "								ELSE @HRANK := @HRANK + 1																																												";
			query += "						END																																																				";
			query += "						), '-', ( CASE 	WHEN @PARTION = budget.res_seq THEN @BRANK := @BRANK + 1																																		";
			query += "										ELSE @BRANK := 1																																												";
			query += "										END ) )																																															";
			query += "		END AS budgetSeqForRes																																																			";
			query += "		, @PARTION := budget.res_seq	AS budgetResSeq																																													";
			query += "		, budget.budget_seq				AS budgetBudgetSeq																																												";
			query += "		, budget.conffer_budget_seq		AS budgetConfferBudgetSeq																																										";
			query += "		, trade.res_seq		AS tradeResSeq																																																";
			query += "		, trade.budget_seq	AS tradeBudgetSeq																																															";
			query += "		, trade.trade_seq	AS tradeTradeSeq																																															";
			query += "		, '1'						AS A_DOCU_FG_NM																																														";
			query += " 		, IFNULL(head.docu_fg_code,'')						AS A_DOCU_FG_CD							";
			query += " 		, IFNULL(head.docu_fg_name,'')						AS A_DOCU_FG_NAME							";
			query += "		, IFNULL(head.res_note,'')			AS A_NOTE 																																													";
			query += "		, IFNULL(head.erp_comp_seq,'')			AS A_ERP_CO_CD																																											";
			query += "		, IFNULL(CONCAT(SUBSTRING(res_date,1,4),'-',SUBSTRING(res_date,5,2),'-',SUBSTRING(res_date,7,2)),'')			AS A_GISU_DT																									";
			query += "		, IFNULL(CONCAT(SUBSTRING(res_date,1,4),'.',SUBSTRING(res_date,5,2),'.',SUBSTRING(res_date,7,2)),'')			AS A_DOT_GISU_DT																									";
			query += "	    , IFNULL(LEFT(head.create_date,10 ),'')  AS A_CREATE_DT																																											";
			query += " 		, IFNULL(item.item_name,'')						AS AI_ITEM_NAME							";
			query += " 		, IFNULL(item.item_size,'')						AS AI_ITEM_SIZE							";
			query += "		, IFNULL(item.item_unit,'')			AS AI_ITEM_UNIT 																																													";
			query += "		, IFNULL(item.item_cnt,'')			AS AI_ITEM_CNT																																											";
			query += "		, IFNULL(item.unit_amt,'')			AS AI_UNIT_AMT																									";
			query += "		, IFNULL(item.item_amt,'')			AS AI_ITEM_AMT																									";
			query += "	    , IFNULL(item.item_note,'')  AS AI_ITEM_NOTE																																											";
			query += "		, IFNULL(head.erp_emp_seq,'')			AS A_ERP_EMP_CD																																											";
			query += "		, IFNULL(head.erp_emp_name,'')			AS A_ERP_EMP_NM																																											";
			query += "		, IFNULL(head.erp_div_seq,'')			AS A_ERP_DIV_CD																																											";
			query += "		, IFNULL(head.erp_div_name,'')			AS A_ERP_DIV_NM																																											";
			query += " , IFNULL(head.pjtFromDt,'')			AS A_PJT_FROM_DT																										";
			query += " , IFNULL(head.pjtToDt,'')			AS A_PJT_TO_DT																										";
			query += "		, IFNULL(head.erp_pc_seq,'')			AS A_ERP_PC_CD																																											";
			query += "		, IFNULL(head.erp_pc_name,'')			AS A_ERP_PC_NM																																											";
			query += "		, IFNULL(head.erp_dept_seq,'')			AS A_ERP_DEPT_CD																																										";
			query += "		, IFNULL(head.erp_dept_name,'')			AS A_ERP_DEPT_NM																																										";
			query += "		, IFNULL(head.erp_gisu,'')			AS A_ERP_GISU																																												";
			query += "		, IFNULL(head.erp_gisu_from_date,'')		AS A_ERP_GISU_START_DT																																								";
			query += "		, IFNULL(head.erp_gisu_to_date,'')		AS A_ERP_GISU_END_DT																																									";
			query += "		, IFNULL(head.erp_year,'')			AS A_ERP_YEAR																																												";
			query += "		, IFNULL(head.mgt_seq,'')			AS A_MGT_CD																																													";
			query += "		, IFNULL(head.mgt_name,'')			AS A_MGT_NM																																													";
			query += "		, IFNULL(head.btr_seq,'')			AS A_BTR_CD																																													";
			query += "		, IFNULL(head.btr_name,'')			AS A_BTR_NM																																													";
			query += "		, IFNULL(head.btr_nb,'')			AS A_BTR_NB																																													";
			query += "		, CASE head.cause_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.cause_date,1,4),'-',SUBSTRING(head.cause_date,5,2),'-',SUBSTRING(head.cause_date,7,2)),'')) end		AS A_CAUSE_DT																				";
			query += "		, CASE head.sign_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.sign_date,1,4),'-',SUBSTRING(head.sign_date,5,2),'-',SUBSTRING(head.sign_date,7,2)),'')) end			AS A_CAUSE_SIGN_DT																				";
			query += "		, CASE head.inspect_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.inspect_date,1,4),'-',SUBSTRING(head.inspect_date,5,2),'-',SUBSTRING(head.inspect_date,7,2)),'')) end			AS A_CAUSE_CHECK_DT																		";
			query += "		, CASE head.payplan_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.payplan_date,1,4),'-',SUBSTRING(head.payplan_date,5,2),'-',SUBSTRING(head.payplan_date,7,2)),'')) end			AS A_CAUSE_PAYPLAN_DT																		";
			query += "		, CASE head.cause_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.cause_date,1,4),'.',SUBSTRING(head.cause_date,5,2),'.',SUBSTRING(head.cause_date,7,2)),'')) end			AS A_CAUSE_DOT_DT																				";
			query += "		, CASE head.sign_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.sign_date,1,4),'.',SUBSTRING(head.sign_date,5,2),'.',SUBSTRING(head.sign_date,7,2)),'')) end			AS A_CAUSE_SIGN_DOT_DT																				";
			query += "		, CASE head.inspect_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.inspect_date,1,4),'.',SUBSTRING(head.inspect_date,5,2),'.',SUBSTRING(head.inspect_date,7,2)),'')) end			AS A_CAUSE_CHECK_DOT_DT																		";
			query += "		, CASE head.payplan_date WHEN '' then '' else (IFNULL(CONCAT(SUBSTRING(head.payplan_date,1,4),'.',SUBSTRING(head.payplan_date,5,2),'.',SUBSTRING(head.payplan_date,7,2)),'')) end			AS A_CAUSE_PAYPLAN_DOT_DT																		";
			query += "		, IFNULL(head.cause_emp_seq,'')			AS A_CAUSE_EMP_CD																																										";
			query += "		, IFNULL(head.cause_emp_name,'')		AS A_CAUSE_EMP_NM																																										";
			query += " , IFNULL(head.bottom_seq,'')			AS A_BOTTOM_CD																																													";
			query += " , IFNULL(head.bottom_name,'')			AS A_BOTTOM_NM																																												";
			query += " , IFNULL((SELECT SUBSTRING(expend_date,1,10) FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_DATE																													";
			query += " , IFNULL((SELECT (IFNULL(CONCAT(SUBSTRING(expend_date,1,4),'.',SUBSTRING(expend_date,6,2),'.',SUBSTRING(expend_date,9,2)),'')) FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_DOT_DATE																													";
			query += " , IFNULL((SELECT (IFNULL(CONCAT(SUBSTRING(c_riregdate,1,4),'-',SUBSTRING(c_riregdate,5,2),'-',SUBSTRING(c_riregdate,7,2)),'')) FROM $DB_NEOS$t_exnp_consdoc doc INNER JOIN $DB_NEOS$a_recordinfo record ON doc.doc_seq = record.c_dikeycode WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_END_DATE																													";
			query += " , IFNULL((SELECT SUBSTRING(create_date,1,10) FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_DRAFT_DATE																													";
			query += " , IFNULL((SELECT doc_no FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_NM																													";
			query += " , IFNULL((SELECT emp_name FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_EMP_NM																													";
			query += " , IFNULL((SELECT dept_name FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq),'')			AS A_CONFFER_DEPT_NM																													";
			if (CommonConvert.CommonGetStr(params.get("eaType")).equals("ea")) {
				query += " , IFNULL((SELECT c_dititle FROM $DB_NEOS$a_docinfo WHERE c_dikeycode = (SELECT doc_seq FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq) ),'')			AS A_CONFFER_TITLE																													";
			} else {
				query += " , IFNULL((SELECT doc_title FROM $DB_NEOS$teag_appdoc WHERE doc_seq = (SELECT doc_seq FROM $DB_NEOS$t_exnp_consdoc WHERE cons_doc_seq = head.conffer_doc_seq) ),'')			AS A_CONFFER_TITLE																													";
			}
			query += " , IFNULL(head.conffer_doc_seq,'')															AS A_CONFFER_CD																															";
			query += " 		, IFNULL(budget.head_res_date ,'')		AS AB_GISU_DT																																											";
			query += " 		, IFNULL(CONCAT(SUBSTRING(budget.head_res_date,1,4),'.',SUBSTRING(budget.head_res_date,5,2),'.',SUBSTRING(budget.head_res_date,7,2)),'')			AS AB_DOT_GISU_DT															";
			query += " 		, IFNULL(CONCAT(SUBSTRING(budget.head_res_date,1,4),'-',SUBSTRING(budget.head_res_date,5,2),'-',SUBSTRING(budget.head_res_date,7,2)),'')			AS AB_HYPHEN_GISU_DT															";
			query += " 		, IFNULL(budget.erp_budget_seq ,'')		AS AB_BGT_CD																																											";
			query += " 		, IFNULL(budget.erp_budget_name,'')		AS AB_BGT_NM																																											";
			query += " 		, IFNULL(budget.mgt_seq ,'')		AS AB_MGT_CD																																												";
			query += " 		, IFNULL(budget.mgt_name,'')		AS AB_MGT_NM																																												";
			query += " 		, IFNULL(budget.erp_bgt1_seq  ,'')		AS AB_BGT_CD_A																																											";
			query += " 		, IFNULL(budget.erp_bgt1_name ,'')		AS AB_BGT_NM_A																																											";
			query += " 		, IFNULL(budget.erp_bgt2_seq  ,'')		AS AB_BGT_CD_B																																											";
			query += "		, IFNULL(budget.erp_bgt2_name ,'')		AS AB_BGT_NM_B																																											";
			query += " 		, IFNULL(budget.erp_bgt3_seq  ,'')		AS AB_BGT_CD_C																																											";
			query += " 		, IFNULL(budget.erp_bgt3_name ,'')		AS AB_BGT_NM_C																																											";
			query += " 		, IFNULL(budget.erp_bgt4_seq  ,'')		AS AB_BGT_CD_D																																											";
			query += " 		, IFNULL(budget.erp_bgt4_name ,'')		AS AB_BGT_NM_D																																											";
			query += " 		, IFNULL(budget.erp_level01_seq  ,'')	AS AB_BGT_LEVEL_CD_A																																									";
			query += " 		, IFNULL(budget.erp_level01_name  ,'')	AS AB_BGT_LEVEL_NM_A																																									";
			query += " 		, IFNULL(budget.erp_level02_seq  ,'')	AS AB_BGT_LEVEL_CD_B																																									";
			query += "		, IFNULL(budget.erp_level02_name  ,'')	AS AB_BGT_LEVEL_NM_B																																									";
			query += "		, IFNULL(budget.erp_level03_seq  ,'')	AS AB_BGT_LEVEL_CD_C																																									";
			query += " 		, IFNULL(budget.erp_level03_name  ,'')	AS AB_BGT_LEVEL_NM_C																																									";
			query += " 		, IFNULL(budget.erp_level04_seq  ,'')	AS AB_BGT_LEVEL_CD_D																																									";
			query += " 		, IFNULL(budget.erp_level04_name  ,'')	AS AB_BGT_LEVEL_NM_D																																									";
			query += " 		, IFNULL(budget.erp_level05_seq  ,'')	AS AB_BGT_LEVEL_CD_E																																									";
			query += " 		, IFNULL(budget.erp_level05_name  ,'')	AS AB_BGT_LEVEL_NM_E																																									";
			query += " 		, IFNULL(budget.erp_level06_seq  ,'')	AS AB_BGT_LEVEL_CD_F																																									";
			query += " 		, IFNULL(budget.erp_level06_name  ,'')	AS AB_BGT_LEVEL_NM_F																																									";
			query += " 		, IFNULL(budget.erp_pc_seq,'')		AS AB_ERP_PC_CD																																														";
			query += " 		, IFNULL(budget.erp_pc_name,'')		AS AB_ERP_PC_NM																																														";
			query += "		, IFNULL(budget.erp_div_seq,'')			AS AB_ERP_DIV_CD																																										";
			query += "		, IFNULL(budget.erp_div_name,'')		AS AB_DIV_NM																																											";
			query += "		, IFNULL(budget.budget_note,'')			AS AB_NOTE																																												";
			query += "		, IFNULL(budget.budget_amt,'')			AS AB_APPLY_AM																																											";
			query += "		, IFNULL( CASE WHEN ctl_fg_code = '0' THEN budget.budget_std_amt ELSE budget.budget_amt END, '') AS AB_APPLY_NON_VAT_AM																											";
			query += "		, IFNULL(budget.budget_amt - budget_tax_amt,'')AS AB_SUP_AM			                                          																													";
			query += "		, IFNULL(budget.budget_tax_amt,'')		AS AB_VAT_AM																																											";
			query += " 		, IFNULL(budget.erp_bizplan_name ,'')		AS AB_BIZPLAN_NM																																									";
			query += " 		, IFNULL(budget.erp_fiacct_name ,'')		AS AB_FIACCT_NM																																										";
			query += " 		, IFNULL(budget.erp_bgacct_name ,'')		AS AB_BGACCT_NM																																										";
			query += " 		, IFNULL(budget.erp_bizplan_seq ,'')		AS AB_BIZPLAN_CD																																									";
			query += " 		, IFNULL(budget.erp_fiacct_seq ,'')		AS AB_FIACCT_CD																																											";
			query += " 		, IFNULL(budget.erp_bgacct_seq ,'')		AS AB_BGACCT_CD																																											";
			query += "		, IFNULL(trade.etc_required_amt,'')		AS AB_NDEP_AM				                                          																													";
			query += "		, IFNULL(trade.etc_income_amt,'')		AS AB_INAD_AM																																											";
			query += "		, IFNULL(trade.etc_income_vat_amt,'')		AS AB_INTX_AM																																										";
			query += "		, IFNULL(trade.etc_resident_vat_amt,'')	AS AB_RSTX_AM				                                          																													";
			query += "		, ''						AS AB_WD_AM																																															";
			query += "		, IFNULL(budget.set_fg_name,'')			AS AB_SET_TYPE_NM																																										";
			query += "		, IFNULL(budget.vat_fg_name,'')			AS AB_VAT_TYPE_NM																																										";
			query += "		, IFNULL(budget.tr_fg_name,'')			AS AB_TR_TYPE_NM																																										";
			query += "		, IFNULL(budget.erp_open_amt,'')		AS AB_OPEN_AM																																											";
			query += "		, IFNULL(budget.erp_apply_amt,'')		AS AB_ERP_APPLY_AM																																										";
			query += "		, IFNULL(budget.erp_left_amt,'')		AS AB_LEFT_AM																																											";
			query += "		, ''						AS AB_ACCEPT_AM																																														";
			query += "		, ''						AS AB_REFFER_AM																																														";
			query += "		, ''						AS AB_GW_APPLY_AM																																													";
			query += "		, ''						AS AB_GW_LEFT_AM																																													";
			query += "		, ''						AS AB_CONS_AM																																														";
			query += "		, ''						AS AB_CONS_USE_AM																																													";
			query += "		, IFNULL(trade.seq,'')			    AS AT_TR_SEQ																																												";
			query += "		, IFNULL(trade.tr_seq,'')			AS AT_TR_CD																																													";
			query += "		, IFNULL(trade.tr_name,'')			AS AT_TR_NM																																													";
			query += "		, IFNULL(trade.tr_addr,'')			AS AT_TR_ADDR																																												";
			query += "		, IFNULL(trade.ceo_name,'')			AS AT_CEO_NM																																												";
			query += "		, IFNULL(trade.merc_tel,'')			AS AT_TEL_NUM																																												";
			query += "		, IFNULL(trade.business_nb,'')			AS AT_REG_NB																																											";
			query += "		, IFNULL(trade.pay_tr_name,'')			AS AT_PAY_TR_NM																																											";
			query += "		, IFNULL(trade.pay_tr_seq,'')			AS AT_PAY_TR_CD																																											";
			query += "		,  CASE business_nb WHEN '' THEN '' ELSE CONCAT(SUBSTR(business_nb,1,3),'-',SUBSTR(business_nb,4,2),'-',SUBSTR(business_nb,6,10)) END 			AS AT_REG_NB_HYPHEN																																											";
			query += "		, IFNULL(trade.merc_addr,'')			AS AT_ADDR																																												";
			query += "		, ''						AS AT_TR_FG_NM																																														";
			query += "		, IFNULL(trade.trade_note,'')			AS AT_NOTE																																												";
			query += "		, IFNULL(trade.budget_note,'')			AS AT_BUDGET_NOTE																																												";
			query += "		, IFNULL(trade.trade_amt,'')			AS AT_UNIT_AM																																											";
			query += "		, IFNULL(trade.trade_std_amt,'')		AS AT_SUP_AM																																											";
			query += "		, IFNULL(trade.trade_vat_amt,'')		AS AT_VAT_AM																																											";
			query += "		, IFNULL(trade.jiro_seq,'')			AS AT_JIRO_CD																																												";
			query += "		, IFNULL(trade.jiro_name,'')			AS AT_JIRO_NM																																											";
			query += "		, IFNULL(trade.ba_nb,'')			AS AT_ACCOUNT_NB																																											";
			query += "		, IFNULL(trade.depositor,'')			AS AT_DEPOSITOR																																											";
			query += "		, IFNULL(trade.btr_seq,'')			AS AT_BTR_CD																																												";
			query += "		, IFNULL(trade.btr_name,'')			AS AT_BTR_NM																																												";
			query += "		, ( CASE interface_type WHEN 'card' THEN ctr_seq ELSE '' END ) AS AT_CARD_TR_CD																																					";
			query += "		, ( CASE interface_type WHEN 'card' THEN ctr_name ELSE '' END ) AS AT_CARD_TR_NM																																				";
			query += "		, ctr_seq						    AS AT_CTR_CD                                					     																														";
			query += "		, ctr_name							AS AT_CTR_NM                              																																					";
			query += "		, IFNULL(trade.etc_belong_year,'')		AS AT_ETC_RVRS_YEAR																																										";
			query += "		, IFNULL(trade.etc_belong_month,'')		AS AT_ETC_RVRS_YM																																										";
			query += "		, IFNULL(trade.etc_belong_date,'')		AS AT_ETC_RVRS_IU_BELONG_DATE																																										";
			query += "		, IFNULL(LEFT(trade.etc_belong_yearmonth,4),'')		AS AT_ETC_RVRS_IU_YEAR																																										";
			query += "		, IFNULL(RIGHT(trade.etc_belong_yearmonth,2),'')		AS AT_ETC_RVRS_IU_MONTH																																										";
			query += "		, IFNULL(trade.etc_required_rate,'')		AS AT_ETC_REQUIRE_RATE			                                       	  																													";
			query += "		, IFNULL(trade.etc_required_amt,'')		AS AT_ETC_NDEP_AM			                                       	  																													";
			query += "		, IFNULL(trade.etc_income_amt,'')		AS AT_ETC_INAD_AM																																										";
			query += "		, IFNULL(trade.etc_income_vat_amt,'')		AS AT_ETC_INTX_AM																																									";
			query += "		, IFNULL(trade.etc_resident_vat_amt,'')	AS AT_ETC_RSTX_AM			                                        																													";
			query += "		, IFNULL(trade.etc_employment_amt,'')	AS AT_ETC_EMPLOYMENT_AM			                                        																													";
			query += "		, IFNULL(trade.salary_amt,'')	AS AT_SALARY_AMT			                                        																													";
			query += "		, IFNULL(trade.salary_std_amt,'')	AS AT_SALARY_STD_AMT			                                        																													";
			query += "		, IFNULL(trade.salary_income_vat_amt,'')	AS AT_SALARY_INCOME_VAT_AMT			                                        																													";
			query += "		, IFNULL(trade.salary_resident_vat_amt,'')	AS AT_SALARY_RESIDENT_VAT_AMT			                                        																													";
			query += "		, IFNULL(trade.salary_etc_amt,'')	AS AT_SALARY_ETC_AMT			                                        																													";
			query += "		, IFNULL(trade.salary_belong_month,'')		AS AT_SALARY_MONTH																																										";
			query += "		, IFNULL(trade.salary_belong_year,'')		AS AT_SALARY_YEAR																																										";
			query += "		, ''						AS AT_ETC_DIV_CD																																													";
			query += "		, IFNULL(trade.etc_income_name,'')		AS AT_ETC_FG_NM																																											";
			query += "		, ''						AS AT_WD_AM																																															";
			query += "		, IFNULL(trade.auth_date,'')			AS AT_CARD_DATE																																											";
			query += "		, IFNULL(trade.auth_num	,'')			AS AT_CARD_S																																											";
			query += "      ,(SELECT CASE WHEN (SELECT set_value FROM $DB_NEOS$t_exnp_option WHERE option_gbn = '1' AND option_code = '1' AND comp_seq = 'NP_OPTION_G20' LIMIT 1 ) = '1'                                                                                                                                                                                    ";
			query += "               THEN                                                                                                                                                                                     ";
			query += "			( CASE                                                                                                                                                                                  ";
			query += "			   WHEN LENGTH(card_num) > 16 THEN IFNULL(card_num, '')                                                                                                                                                                                     ";
			query += "			   ELSE IFNULL(CONCAT(SUBSTRING(card_num, 1, 4), '-', SUBSTRING(card_num, 5, 4), '-', SUBSTRING(card_num, 9, 4), '-', SUBSTRING(card_num, 13, 4)), '')                                                                                                                                                                                  ";
			query += "			 END )                                                                                                                                                                                  ";
			query += "                 ELSE                                                                                                                                                                                 ";
			query += "			( CASE                                                                                                                                                                                  ";
			query += "			   WHEN LENGTH(card_num) > 16 THEN IFNULL(CONCAT(SUBSTRING(card_num,1,5),'****-****-',SUBSTRING(card_num, 16,4) ), '')                                                                                                                                                                                  ";
			query += "			   ELSE IFNULL(CONCAT(SUBSTRING(card_num, 1, 4), '-', '****' , '-', '****' , '-', SUBSTRING(card_num, 13, 4)), '')                                                                                                                                                                                  ";
			query += "			 END )                                                                                                                                                                                  ";
			query += "                 END                                                                                                                                                                                  ";
			query += "        FROM   $DB_NEOS$t_ex_card card                                                                                                                                                                                    ";
			query += "        LEFT JOIN  $DB_NEOS$t_exnp_resdoc doc on doc.comp_seq = card.comp_seq                                                                                                                                                                                   ";
			query += "        WHERE  card_code = trade.ctr_seq                                                                                                                                                                                ";
			query += "        AND  	 doc.res_doc_seq = '#resDocSeq#'                                                                                                                                                                           ";
			query += "        LIMIT  1)                                                                                                    AS AT_CARD_NUM                                                                                                                                                                                   ";
			query += "		, (SELECT IFNULL(CONCAT(SUBSTRING(card_num, 1, 4), '-', SUBSTRING(card_num, 5, 4), '-', SUBSTRING(card_num, 9, 4), '-', SUBSTRING(card_num, 13, 4)), '') FROM $DB_NEOS$t_ex_card card LEFT JOIN $DB_NEOS$t_exnp_resdoc doc on doc.comp_seq = card.comp_seq WHERE card_code = trade.ctr_seq AND doc.res_doc_seq = '#resDocSeq#' LIMIT 1) AS AT_CARD_NUM2	";
			query += "		, (CASE WHEN trade.interface_type = 'card' THEN 'c' ELSE trade.ba_nb END) AS AT_CARD_BANK_NUM	";
			query += "		, (SELECT CASE WHEN IFNULL(auth_time,'000000') = '000000' THEN '' ELSE CONCAT(SUBSTRING(auth_time,'1','2'),':',SUBSTRING(auth_time,'3','2'),':',SUBSTRING(auth_time,'5','2')) END FROM   $DB_NEOS$t_ex_card card WHERE  card_code = trade.ctr_seq LIMIT 1 ) AS AT_CARD_TIME	";
			query += "		, CASE WHEN trade.interface_type = 'card' THEN IFNULL(trade.tr_name,'') ELSE '' END AS at_card_tr_name	";
			query += "		, CASE WHEN trade.interface_type = 'card' THEN IFNULL(trade.trade_amt,'0') ELSE '0' END  AS at_card_tr_am	";
			query += "		, CASE WHEN trade.interface_type = 'card' THEN IFNULL(trade.trade_std_amt,'0') ELSE '0' END AS at_card_tr_std_am 	";
			query += "		, CASE WHEN trade.interface_type = 'card' THEN IFNULL(trade.trade_vat_amt,'0') ELSE '0' END AS at_card_tr_vat_am	";
			query += "		, IFNULL(trade.iss_no,'')			AS AT_ISS_CD																																												";
			query += "		, IFNULL(trade.set_fg_name,'')						AS AT_SET_TYPE_NM																																													";
			query += "		, IFNULL(trade.vat_fg_name,'')						AS AT_VAT_TYPE_NM																																													";
			query += "		, IFNULL(trade.tr_fg_name,'')						AS AT_TR_TYPE_NM																																													";
			query += "		, ''						AS  AT_WHTX_AMse																																														";
			query += "		, ''						AS  AT_FRTX_AM																																														";
			query += "		, trade.reg_date			AS	AT_TAX_DATE																																														";
			query += "		, IFNULL(trade.erp_budget_seq, '')	AS AT_BGT_CD																																												";
			query += "		, IFNULL(trade.erp_budget_name, '')	AS AT_BGT_NM																			                      																								";
			query += "      , Ifnull(trade.erp_bgt1_name, '')     AT_BGT_NM_A                                                                                                                                                                        ";
			query += "      , Ifnull(trade.erp_bgt2_name, '')     AT_BGT_NM_B                                                                                                                                                                      ";
			query += "      , Ifnull(trade.erp_bgt3_name, '')     AT_BGT_NM_C                                                                                                                                                                      ";
			query += "      , Ifnull(trade.erp_bgt4_name, '')     AT_BGT_NM_D                                                                                                                                                                      ";
			query += "		, IFNULL(trade.erp_bizplan_seq, '')	AS AT_BIZPLAN_CD																																	";
			query += "		, IFNULL(trade.erp_bizplan_name, '')	AS AT_BIZPLAN_NM																																												";
			query += "		, IFNULL(trade.erp_bizplan_seq, '')	AS AT_BIZPLAN_CD																																												";
			query += "		, IFNULL(trade.erp_bgacct_name, '')	AS AT_BGACCT_NM																																												";
			query += "		, IFNULL(trade.erp_bgacct_seq, '')	AS AT_BGACCT_CD																																												";
			query += "		, IFNULL(trade.erp_fiacct_name, '')	AS AT_FIACCT_NM																																												";
			query += "		, IFNULL(trade.erp_fiacct_seq, '')	AS AT_FIACCT_CD																																												";
			query += "		, IFNULL(trade.mgt_seq, '')	AS AT_PJT_CD																																														";
			query += "		, IFNULL(trade.mgt_name, '')	AS AT_PJT_NM																																													";
			query += "		, IFNULL(trade.pjt_btr_name, '')	AS AT_PJT_BTR_NM																																													";
			query += "		, IFNULL(trade.pjt_btr_nb, '')	AS AT_PJT_BTR_NB																																													";
			query += "		, IFNULL((																																																						";
			query += "		SELECT																																																							";
			query += "			(																																																							";
			query += "				CASE consB.conffer_budget_return_yn WHEN 'Y' THEN 0																																										";
			query += "				ELSE SUM( IFNULL(consB.budget_amt, 0 )) 		- SUM( IFNULL(resB.budget_amt, 0 ))																																		";
			query += "				END																																																						";
			query += "			)	AS 'balanceAmt'																																																			";
			query += "		FROM	(																																																						";
			query += "			SELECT	*																																																					";
			query += "			FROM 	$DB_NEOS$t_exnp_consdoc																																																	";
			query += "			WHERE 	conffer_return_yn != 'Y'																																															";
			query += "			 AND	doc_status IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																																	";
			query += "		)	consD																																																						";
			query += "		INNER JOIN 	(																																																					";
			query += "			SELECT	*																																																					";
			query += "			FROM	$DB_NEOS$t_exnp_conshead																																																";
			query += "		)	consH																																																						";
			query += "		 ON	consD.cons_doc_seq = consH.cons_doc_seq																																														";
			query += "		INNER JOIN	(																																																					";
			query += "			SELECT	*																																																					";
			query += "			FROM	$DB_NEOS$t_exnp_consbudget																																																";
			query += "			WHERE	conffer_budget_return_yn = 'N'																																														";
			query += "		)	consB																																																						";
			query += "		 ON		consD.cons_doc_seq	= consB.cons_doc_seq																																												";
			query += "		 AND	consH.cons_seq		= consB.cons_seq																																													";
			query += "																																																										";
			query += "		LEFT JOIN	(																																																					";
			query += "			SELECT																																																						";
			query += "				rb.conffer_doc_seq																																																		";
			query += "				, rb.conffer_seq																																																		";
			query += "				, rb.conffer_budget_seq																																																	";
			query += "				, rb.erp_budget_seq																																																		";
			query += "				, IFNULL(rb.erp_bgacct_seq, '')	AS erp_bgacct_seq																																										";
			query += "				, SUM( rb.budget_std_amt ) 	AS budget_std_amt																																											";
			query += "				, SUM( rb.budget_tax_amt )AS budget_tax_amt																																												";
			query += "              ,SUM(( CASE ctl_fg_code WHEN '0' THEN ( CASE IFNULL(budget_std_amt, 0) WHEN '0' THEN budget_amt ELSE budget_std_amt END ) ELSE budget_amt END ))	AS budget_amt                                                       ";
			query += "			FROM	$DB_NEOS$t_exnp_resbudget rb																																															";
			query += "			 INNER JOIN $DB_NEOS$t_exnp_resdoc rd																																															";
			query += "			 ON 	rd.res_doc_seq = rb.res_doc_seq																																														";
			query += "			  AND	IFNULL(rd.doc_status, '008') IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																												";
			query += "			  AND	rd.doc_seq IS NOT NULL																																																";
			query += "			WHERE	IFNULL(rb.conffer_doc_seq, '') != ''																																												";
			query += "			 AND   rd.doc_seq != IFNULL((SELECT doc_seq FROM $DB_NEOS$t_exnp_resdoc tResDoc WHERE tResDoc.res_doc_seq = '#resDocSeq#'), '')																										";
			query += "			GROUP	BY rb.conffer_doc_seq, rb.conffer_seq, rb.conffer_budget_seq, rb.erp_budget_seq	 																																	";
			if (processId.equals("EXNPRESU")) {
				query += "					, rb.erp_bgacct_seq    																																															";
			}
			query += "			HAVING 	budget_amt != 0																																																		";
			query += "		) resB																																																							";
			query += "		 ON 	consB.cons_doc_seq = resB.conffer_doc_seq																																												";
			query += "		 AND	consB.cons_seq = resB.conffer_seq																																														";
			query += "		 AND	consB.budget_seq = resB.conffer_budget_seq																																												";
			query += "		WHERE	consD.erp_gisu = budget.erp_gisu																																														";
			query += "		 AND	consH.mgt_seq = budget.mgt_seq																																															";
			query += "		 AND	consB.budget_seq != budget.budget_seq																																													";
			query += "		 AND 	consB.erp_budget_seq = budget.erp_budget_seq																																											";
			query += "		 AND 	IFNULL(consh.bottom_seq,'') = IFNULL(budget.bottom_seq,'')																																											";
			if (processId.equals("EXNPRESU")) {
				query += " 	 AND 	ifnull(consB.erp_bizplan_seq,'') = ifnull(budget.erp_bizplan_seq,'')														   																													";
				query += " 	 AND 	ifnull(consB.erp_bgacct_seq,'') = ifnull(budget.erp_bgacct_seq,'')																																											";
				query += " 	 AND 	consH.cons_date >= '#gisuFromDate#' AND consH.cons_date <= '#gisuToDate#'																																												";
			}
			query += " 	 AND 	consD.erp_comp_seq = budget.erp_comp_seq																																											";
			query += "		GROUP BY  consB.erp_budget_seq																																																	";
			query += "	), '')	AS AB_CONS_BALANCE_AM																																																		";
			query += " , IFNULL((																																																							";
			query += " 		SELECT	IFNULL(MAX(budget_amt),'')																																																";
			query += " 		FROM	$DB_NEOS$t_exnp_consbudget													   																																					";
			query += " 		WHERE	budget_seq = b_conffer_budget_seq									   																																					";
			query += " 	), '') 	AS		AB_CONFFER_BUDGET_AM												   																																				";
			query += " , IFNULL((																		   																																					";
			query += " 		SELECT	IFNULL(SUM(budget_amt),'')																																																";
			query += " 		FROM	$DB_NEOS$t_exnp_resbudget resbudget											   																																					";
			query += " 		INNER JOIN $DB_NEOS$t_exnp_resdoc resdoc											   																																						";
			query += " 		 ON	resbudget.res_doc_seq = resdoc.res_doc_seq								   																																					";
			query += " 		WHERE	conffer_budget_seq = b_conffer_budget_seq       					   																																					";
			query += "  	 AND	IFNULL(resdoc.doc_status, '008') IN ( '001', '002', '003', '004', '006',	   																																			";
			query += "                                         			  '008', '009', '20', '30', '90' )																																					";
			query += "  	 AND 	resdoc.doc_seq IS NOT NULL											   																																					";
			query += "  	  AND	resbudget.res_doc_seq != b_filter_doc_seq							   																																					";
			query += " 		GROUP BY	conffer_budget_seq												   																																					";
			query += " ), '')	AS		AB_CONFFER_USE_AM                                                      																																				";
			query += "	, IFNULL((																																																							";
			query += "		SELECT																																																							";
			query += "			SUM( (CASE IFNULL(ctl_fg_code, '1')																																															";
			query += "						WHEN '0'	THEN 	( CASE IFNULL(budget_std_amt, 0) WHEN '0' THEN IFNULL(budget_amt, 0) ELSE IFNULL(budget_std_amt, 0) END )																																									";
			query += "						ELSE		IFNULL(budget_amt, 0)	/* emptyStr or '1' */																																						";
			query += "					END)																																																				";
			query += "			)	AS 'resBudgetAmt'																																																		";
			query += "		FROM	(																																																						";
			query += "			SELECT	*																																																					";
			query += "			FROM 	$DB_NEOS$t_exnp_resdoc																																																	";
			query += "			WHERE 	erp_send_yn != 'Y'																																																	";
			query += "			AND		IFNULL(doc_status, '008') IN ( '001', '002', '003', '004', '006', '008', '009', '20', '30', '90' )																													";
			query += "			AND		doc_seq IS NOT NULL																																																	";
			query += "		)	resD																																																						";
			query += "		INNER JOIN	(																																																					";
			query += "			SELECT	*																																																					";
			query += "			FROM	$DB_NEOS$t_exnp_reshead																																																	";
			query += "		)	resH																																																						";
			query += "		 ON	resD.res_doc_seq = resH.res_doc_seq																																															";
			query += "		INNER JOIN	(																																																					";
			query += "			SELECT	*																																																					";
			query += "			FROM	$DB_NEOS$t_exnp_resbudget																																																";
			query += "																																																										";
			query += "		)	resB																																																						";
			query += "		 ON	resD.res_doc_seq = resB.res_doc_seq																																															";
			query += "		 AND	resH.res_seq = resB.res_seq																																																";
			query += "																																																										";
			query += "		WHERE	resH.mgt_seq = budget.mgt_seq																																															";
			query += "		 AND	resD.erp_gisu = budget.erp_gisu																																															";
			query += "		 AND	resB.res_doc_seq != budget.res_doc_seq																																													";
			query += "		 AND 	resB.erp_budget_seq = budget.erp_budget_seq																																												";
			query += "		 AND 	IFNULL(resh.bottom_seq,'') = IFNULL(budget.bottom_seq,'')																																												";
			if (processId.equals("EXNPRESI")) {
				query += " 	 AND    resD.erp_div_seq = budget.head_erp_div_seq																																													";
			}
			if (processId.equals("EXNPRESU")) {
				query += " 	 AND 	ifnull(resB.erp_bizplan_seq,'') = ifnull(budget.erp_bizplan_seq,'')																																											";
				query += " 	 AND 	ifnull(resB.erp_bgacct_seq,'') = ifnull(budget.erp_bgacct_seq,'')																																												";
				query += " 	 AND 	resH.res_date >= '#gisuFromDate#' AND resH.res_date <= '#gisuToDate#'																																												";
			}
			query += " 	 AND    resD.erp_comp_seq = budget.erp_comp_seq																																													";
			query += "		GROUP BY  resB.erp_budget_seq																																																	";
			query += "	), '')	AS AB_NON_SEND_RES_AM																																																		";
			query += " , IFNULL( tdoc.comp_name, '' )					AS T_COMP_NAME																						";
			query += " , IFNULL( tdoc.dept_name, '' )					AS T_DEPT_NAME																						";
			query += " , IFNULL( tdoc.emp_name, '' )					AS T_EMP_NAME																						";
			query += " , (	CASE	IFNULL( tattend.domestic_code, '' ) 																									";
			query += " 	WHEN '0' THEN '국내' 																																";
			query += " 	WHEN '1' THEN '해외'  																															    ";
			query += " 	ELSE '' 																																			";
			query += " END																																					";
			query += " )												AS TA_DOMESTIC_CODE																					";
			query += " , IFNULL(SUBSTRING(tattend.trip_from_date,1,10), '') 	AS TA_TRIP_FROM_DATE																";
			query += " , IFNULL(SUBSTRING(tattend.trip_from_date,12,5), '') 	AS TA_TRIP_FROM_TIME																";
			query += " , IFNULL(SUBSTRING(tattend.trip_to_date,1,10), '') 		AS TA_TRIP_TO_DATE																	";
			query += " , IFNULL(SUBSTRING(tattend.trip_to_date,12,5), '') 		AS TA_TRIP_TO_TIME																	";
			query += " , IFNULL( tattend.calendar_name, '' )							AS TA_CALENDAR_NAME																	";
			query += " , IFNULL( tattend.location_name, '' )							AS TA_LOCATION_NAME																	";
			query += " , IFNULL( tattend.location_adv, '' )								AS TA_LOCATION_ADV																	";
			query += " , IFNULL( tattend.transport_name, '' )							AS TA_TRANSPORT_NAME																";
			query += " , IFNULL( tattend.purpose, '' )									AS TA_PURPOSE																		";
			query += " , (	CASE	IFNULL( tattend.trip_expense_code, '' ) 																								";
			query += " 	WHEN '0' THEN '대상' 																																";
			query += " 	WHEN '1' THEN '비대상'  																															";
			query += " 	ELSE '' 																																			";
			query += " END																																					";
			query += " )			  													AS TA_TRIP_EXPENSE_CODE																";
			query += " , IFNULL( ttraveler.comp_name, '' )								AS TT_COMP_NAME																		";
			query += " , IFNULL( ttraveler.dept_name, '' )								AS TT_DEPT_NAME																		";
			query += " , IFNULL( ttraveler.emp_name, '' )								AS TT_EMP_NAME																		";
			query += " , IFNULL( ttraveler.duty_name, '' )								AS TT_DUTY_NAME																		";
			query += " , IFNULL( ttraveler.duty_group_name_kr, '' )								AS TT_DUTY_GROUP_NAME																		";
			query += " , IFNULL( ttraveler.duty_group_name_en, '' )								AS TT_DUTY_GROUP_NAME_EN																		";
			query += " , IFNULL(texpense.amtClass1Name,'')								AS TE_AMTCLASS1_NAME																";
			query += " , IFNULL(texpense.amtClass1Amt,'')								AS TE_AMTCLASS1_AMT																	";
			query += " , CASE IFNULL(texpense.amtClass1DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS1_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass1HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS1_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass2Name,'')																			AS TE_AMTCLASS2_NAME					";
			query += " , IFNULL(texpense.amtClass2Amt,'')																			AS TE_AMTCLASS2_AMT						";
			query += " , CASE IFNULL(texpense.amtClass2DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS2_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass2HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS2_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass3Name,'')																			AS TE_AMTCLASS3_NAME					";
			query += " , IFNULL(texpense.amtClass3Amt,'')																			AS TE_AMTCLASS3_AMT						";
			query += " , CASE IFNULL(texpense.amtClass3DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS3_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass3HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS3_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass4Name,'')																			AS TE_AMTCLASS4_NAME					";
			query += " , IFNULL(texpense.amtClass4Amt,'')																			AS TE_AMTCLASS4_AMT						";
			query += " , CASE IFNULL(texpense.amtClass4DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS4_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass4HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS4_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass5Name,'')																			AS TE_AMTCLASS5_NAME					";
			query += " , IFNULL(texpense.amtClass5Amt,'')																			AS TE_AMTCLASS5_AMT						";
			query += " , CASE IFNULL(texpense.amtClass5DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS5_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass5HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS5_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClass6Name,'')																			AS TE_AMTCLASS6_NAME					";
			query += " , IFNULL(texpense.amtClass6Amt,'')																			AS TE_AMTCLASS6_AMT						";
			query += " , CASE IFNULL(texpense.amtClass6DomesticCode,'') WHEN '0' THEN '국내' WHEN '1' THEN '해외' ELSE '' END		AS TE_AMTCLASS6_DOMESTIC_CODE			";
			query += " , CASE IFNULL(texpense.amtClass6HoldCode,'') WHEN '0' THEN '고정금액' WHEN '1' THEN '실비적용' ELSE '' END	AS TE_AMTCLASS6_HOLD_CODE				";
			query += " , IFNULL(texpense.amtClassSum, '')																			AS TE_AMT								";
			query += "	FROM	(																																																							";
			query += "		SELECT	seq																																																						";
			query += "		FROM	$DB_NEOS$T_EXNP_CODE_SEQ																																																			";
			query += "	)	base																																																							";
			query += "	LEFT JOIN	(																																																						";
			query += "		SELECT	head.*,																																																					";
			query += "			cause_date,																																																					";
			query += "			sign_date,																																																					";
			query += "			inspect_date,																																																				";
			query += "			payplan_date,																																																				";
			query += "			cause_emp_seq,																																																				";
			query += "			cause_emp_name,																																																				";
			query += "		    doc_seq																																																				";
			query += "		FROM	(																																																						";
			query += "			SELECT																																																						";
			query += "				@hrn:=@hrn+1 AS seq																																																		";
			query += "				, head.*																																																				";
			query += "			FROM	$DB_NEOS$t_exnp_reshead head																																											";
			query += "			INNER JOIN ( SELECT res_seq FROM $DB_NEOS$t_exnp_restrade GROUP BY res_seq) trade																																											";
			query += "			ON head.res_seq = trade.res_seq																																											";
			query += "			,(SELECT @hrn := 0) temp																																											";
			query += "			WHERE	res_doc_seq = '#resDocSeq#'																																															";
			query += "		)	head																																																						";
			query += "		LEFT JOIN 	$DB_NEOS$t_exnp_cause cause																																																	";
			query += "		ON	head.res_seq = cause.res_seq																																																";
			query += "		INNER JOIN 	$DB_NEOS$t_exnp_resdoc doc																																																	";
			query += "		ON	head.res_doc_seq = doc.res_doc_seq																																															";
			query += "	)	head																																																							";
			query += "	ON	base.seq = head.seq																																																				";
			query += "	LEFT JOIN	(																																																						";
			query += "		SELECT																																																								";
			query += "			@trn:=@trn+1 AS seq																																																				";
			query += "			, budget.*																																																						";
			query += "			, budgetHead.res_date	   AS head_res_date																																																			";
			query += " 			, budgetHead.erp_comp_seq																																																						";
			query += "			, budgetHead.erp_gisu																																																			";
			query += "			, budgetHead.mgt_seq																																																			";
			query += "			, budgetHead.mgt_name																																																			";
			query += "			, budgetHead.bottom_seq																																																			";
			query += "			, budget.conffer_budget_seq AS b_conffer_budget_seq																																												";
			query += "			, budget.res_doc_seq 		AS b_filter_doc_seq																																													";
			query += " 			, budgetHead.erp_pc_seq																																																			";
			query += " 			, budgetHead.erp_pc_name																																																			";
			query += " 			, budgetHead.erp_div_seq AS head_erp_div_seq																																																			";
			query += "		FROM	(SELECT @trn:=0) temp, $DB_NEOS$t_exnp_resbudget budget																																												";
			query += "		INNER JOIN ( SELECT budget_seq FROM $DB_NEOS$t_exnp_restrade GROUP BY budget_seq) trade																																											";
			query += "		ON budget.budget_seq = trade.budget_seq																																											";
			query += "		INNER JOIN $DB_NEOS$t_exnp_reshead budgetHead																																															";
			query += "	   	ON	budget.res_seq = budgetHead.res_seq																																															";
			query += "		WHERE	budget.res_doc_seq = '#resDocSeq#'																																															";
			query += "		)	budget																																																							";
			query += "	ON	base.seq = budget.seq																																																			";
			query += "	LEFT JOIN	(																																																						";
			query += "		SELECT																																																							";
			query += "			@brn:=@brn+1 AS seq																																																			";
			query += "			, trade.*																																																					";
			query += "			, merc_tel																																																					";
			query += "			, card_num																																																					";
			query += "			, iss_no																																																					";
			query += "			, merc_addr																																																					";
			query += "			, merc_name																																																					";
			query += "			, auth_date																																																					";
			query += "			, auth_time																																																					";
			query += "			, auth_num																																																					";
			query += "			, comp_seq																																																					";
			query += "			, erp_budget_seq																																																			";
			query += "			, erp_budget_name																																																			";
			query += "			, head.mgt_seq																																																				";
			query += "			, head.mgt_name 																																																				";
			query += "			, head.btr_name	AS pjt_btr_name																																																			";
			query += "			, head.btr_nb	AS pjt_btr_nb																																																			";
			query += "			, budget.set_fg_name																																																				";
			query += "			, budget.vat_fg_name																																																				";
			query += "			, budget.tr_fg_name																																																				";
			query += "			, budget.erp_bizplan_name																																																				";
			query += "			, budget.erp_bizplan_seq																																																				";
			query += "			, budget.erp_bgacct_name																																																				";
			query += "			, budget.erp_bgacct_seq																																																				";
			query += "			, budget.erp_fiacct_name																																																				";
			query += "			, budget.erp_fiacct_seq																																																				";
			query += "			, budget.budget_note																																																				";
			query += "          , budget.erp_bgt1_name                                                                       ";
			query += "          , budget.erp_bgt2_name                                                                           ";
			query += "          , budget.erp_bgt3_name                                                                             ";
			query += "          , budget.erp_bgt4_name                                                                             ";
			query += "		FROM	$DB_NEOS$t_exnp_restrade trade 																																																	";
			query += "		INNER JOIN (SELECT @brn:=0) temp																																																";
			query += "		ON 	1 = 1																																																						";
			query += "		LEFT JOIN $DB_NEOS$t_ex_card_aq_tmp card																																																	";
			query += "		ON 	card.sync_id = trade.interface_seq																																															";
			query += "		 AND trade.interface_type = 'card'																																															";
			query += "		LEFT JOIN $DB_NEOS$t_ex_etax_aq_tmp etax																																																	";
			query += "		ON	etax.sync_id = trade.interface_seq																																															";
			query += "		 AND trade.interface_type = 'etax'																																															";
			query += "		INNER JOIN $DB_NEOS$t_exnp_resbudget budget																																																";
			query += "		ON trade.budget_seq = budget.budget_seq																																															";
			query += "		INNER JOIN $DB_NEOS$t_exnp_reshead head																																																	";
			query += "		ON trade.res_seq = head.res_seq																																																	";
			query += "		WHERE	trade.res_doc_seq = '#resDocSeq#'																																														";
			query += "	)	trade																																																							";
			query += "	ON	base.seq = trade.seq																																																			";
			query += "	LEFT JOIN (																																																							";
			query += "	SELECT																																																								";
			query += "		@tdrn := @tdrn + 1 AS seq																																																		";
			query += "		, item.*																																																						";
			query += "	FROM	$DB_NEOS$t_exnp_resitem item, (SELECT @tdrn := 0) temp																																											";
			query += "	WHERE	res_doc_seq = '#resDocSeq#'																																																	";
			query += "	)	item																																																				";
			query += "	ON	base.seq = item.seq																																																				";
			query += "	LEFT JOIN (																																																							";
			query += "	SELECT																																																								";
			query += "		@tdrn := @tdrn + 1 AS seq																																																		";
			query += "		, tdoc.*																																																						";
			query += "	FROM	$DB_NEOS$t_exnp_trip_res_doc tdoc, (SELECT @tdrn := 0) temp																																											";
			query += "	WHERE	trip_res_doc_seq = '#tripResDocSeq#'																																																	";
			query += "	)	tdoc																																																							";
			query += "	ON	base.seq = tdoc.seq																																																				";
			query += "	LEFT JOIN (																																																							";
			query += "	SELECT																																																								";
			query += "		@tarn := @tarn + 1 AS seq																																																		";
			query += "		, tattend.*																																																						";
			query += "	FROM	$DB_NEOS$t_exnp_trip_res_attend tattend, (SELECT @tarn := 0) temp																																									";
			query += "	WHERE	trip_res_doc_seq = '#tripResDocSeq#'																																																	";
			query += "	)	tattend																																																							";
			query += "	ON	base.seq = tattend.seq																																																			";
			query += "	LEFT JOIN (																																																							";
			query += "	SELECT																																																								";
			query += " 	@ttrn := @ttrn + 1 AS seq																																																			";
			query += " 	, ttraveler.*																																																						";
			query += " 	, duty_group_name_kr																																																						";
			query += " 	, duty_group_name_en																																																						";
			query += " FROM	$DB_NEOS$t_exnp_trip_res_traveler ttraveler																																									";
			query += " INNER JOIN $DB_NEOS$t_exnp_trip_set_dutygroup dutyGroup																																									";
			query += " ON	dutyGroup.duty_group_seq = ttraveler.duty_group_seq, (SELECT @ttrn := 0) temp																																		";
			query += " WHERE	trip_res_doc_seq = '#tripResDocSeq#'																																																	";
			query += "	)	ttraveler																																																						";
			query += "	ON	base.seq = ttraveler.seq																																																		";
			query += "	LEFT JOIN (																																																							";
			query += "		SELECT	@tern := @tern + 1 AS seq																																																";
			query += "			, expense.*																																																					";
			query += "		FROM	(																																																						";
			query += "			SELECT																																																						";
			query += "				trip_res_doc_seq AS tripResDocSeq																																														";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_class_code ELSE '0'  END) 			AS amtClass1Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_class_name ELSE '일비'  END) 		AS amtClass1Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass1Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass1Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass1DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass1HoldCode																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_class_code ELSE '1'  END) 			AS amtClass2Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_class_name ELSE '식비'  END) 		AS amtClass2Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass2Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass2Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='2' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass2DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='1' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass2HoldCode																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_class_code ELSE '2'  END) 			AS amtClass3Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_class_name ELSE '숙빅비'  END) 	AS amtClass3Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass3Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass3Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass3DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='3' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass3HoldCode																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_class_code ELSE '3'  END) 			AS amtClass4Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_class_name ELSE '운임비'  END) 	AS amtClass4Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass4Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass4Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass4DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='4' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass4HoldCode																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_class_code ELSE '4'  END) 			AS amtClass5Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_class_name ELSE '기타여비'  END) 	AS amtClass5Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass5Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass5Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN expense.domestic_code ELSE '0'  END) 			AS amtClass5DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='5' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass5HoldCode																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_class_code ELSE '5'  END) 			AS amtClass6Code																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_class_name ELSE '기타여비2'  END) 	AS amtClass6Name																										";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.expense_amt ELSE '0'  END) 			AS amtClass6Amt																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.amt_seq ELSE '0'  END) 				AS amtClass6Seq																											";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN expense.domestic_code ELSE '0' END) 			AS amtClass6DomesticCode																								";
			query += "				, MAX( CASE WHEN expense.amt_class_code='6' THEN amt.amt_hold_code ELSE '0'  END) 			AS amtClass6HoldCode																										";
			query += "				, SUM(expense_amt) 																AS amtClassSum																															";
			query += "				, expense.comp_seq				AS compSeq																																												";
			query += "				, expense.comp_name				AS compName																																												";
			query += "				, expense.emp_seq				AS empSeq																																												";
			query += "				, expense.emp_name				AS empName																																												";
			query += "				, expense.duty_item_seq 		AS dutyItemSeq																																											";
			query += "		   	    ,(SELECT duty_group_name_kr FROM $DB_NEOS$t_exnp_trip_set_dutygroup dg WHERE dg.duty_group_seq = expense.duty_group_seq) AS dutyGroupName                                                                                        ";
			query += "				, expense.transport_seq			AS transportSeq																																											";
			query += "				, expense.location_seq			AS locationSeq																																											";
			query += "				, expense.duty_name				AS dutyName																																												";
			query += "			FROM	 $DB_NEOS$t_exnp_trip_res_expense expense																																													";
			query += "			LEFT JOIN $DB_NEOS$t_exnp_trip_set_amt amt																																															";
			query += "			ON	amt.amt_seq = expense.amt_seq																																															";
			query += "			WHERE	trip_res_doc_seq = '#tripResDocSeq#'																																															";
			query += "			AND	emp_seq IS NOT NULL																																																		";
			query += "			GROUP BY emp_seq,trip_res_doc_seq,expense.comp_seq,expense.comp_name,expense.emp_name,expense.duty_item_seq,expense.duty_group_seq,expense.transport_seq,expense.location_seq,expense.duty_name								";
			query += "		)	expense, (SELECT @tern := 0) temp																																															";
			query += "	)	texpense																																																						";
			query += "	ON	texpense.empSeq = ttraveler.emp_seq																																																		";
			query = query.replace("#resDocSeq#", resDocSeq);
			query = query.replace("#tripResDocSeq#", tripResDocSeq);
			query = query.replace("#gisuFromDate#", gisuFromDate);
			query = query.replace("#gisuToDate#", gisuToDate);
			if (!jedis.getBuildType().equals("build")) {
				String cloudDBNEOS = "";
				for (int i = 0; i < jedisConnectionList.size(); i++) {
					cmLog.CommonSetInfoToDatabase("cloudDBNEOSfor문진입" + jedisConnectionList.get(i).toString(), "",
							"EXNP");
					cmLog.CommonSetInfoToDatabase("cloudDBNEOSfor문진입" + params.get("groupSeq").toString(), "", "EXNP");

					if (jedisConnectionList.get(i).get("GROUP_SEQ").equals(params.get("groupSeq"))) {
						cmLog.CommonSetInfoToDatabase("cloudDBNEOSfor문진입" + cloudDBNEOS, "", "EXNP");
						cloudDBNEOS = jedisConnectionList.get(i).get("DB_NEOS");
					}
				}
				query = query.replace("$DB_NEOS$", cloudDBNEOS.concat("."));
			} else {
				query = query.replace("$DB_NEOS$", "");
			}

			cmLog.CommonSetInfo("결의서 한글양식 코드 조회 쿼리 생성");
			cmLog.CommonSetInfo(query);
		} else {
			query = "";
		}

		return query;
	}

	@Override
	public Map<String, Object> CommonPFormOptionInfoSelect_ea230() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("groupSeq", CommonConvert.CommonGetEmpVO().getGroupSeq());
		params.put("compSeq", CommonConvert.CommonGetEmpVO().getCompSeq());

		return dao.CommonPFormOptionInfoSelect_ea230(params);
	}

	public ResultVO CommonAInterlockUpdate(Map<String, Object> params) throws Exception {
		return dao.CommonAInterlockUpdate(params);
	}

	public ResultVO CommonPInterlockUpdate(Map<String, Object> params) throws Exception {
		return dao.CommonPInterlockUpdate(params);
	}

	@Override
	public ResultVO CopyInterlock(Map<String, Object> params) throws Exception {
		params.put("groupSeq", CommonConvert.CommonGetEmpVO().getGroupSeq());
		params.put("compSeq", CommonConvert.CommonGetEmpVO().getCompSeq());

		return dao.CopyInterlock(params);
	}
}
