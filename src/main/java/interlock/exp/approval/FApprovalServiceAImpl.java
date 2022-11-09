/**
  * @FileName : FApprovalServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.approval;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.np.NpOutInterfaceVO;
import expend.angu.user.angu.FAnguUserAnguServiceADAO;
import expend.angu.user.angu.FAnguUserAnguServiceIDAO;
import expend.ex.user.card.FExUserCardService;
import expend.ez.user.eaInfo.FEzEAInfo;
import expend.ez.user.erpUserInfo.BEzErpUserInfo;
import expend.np.admin.report.BNpAdminReportService;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.option.BNpUserOptionService;
import expend.np.user.res.BNpUserResService;
import neos.cmm.util.HttpJsonUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *   * @FileName : FApprovalServiceAImpl.java   * @Project : BizboxA_exp
 *   * @변경이력 :   * @프로그램 설명 : 비영리 전자결재 연동 프로세스   
 */
@Service("FApprovalServiceA")
public class FApprovalServiceAImpl implements FApprovalService {

	/* 변수정의 */
	/* 공통 */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo; /* 공통사용 정보 */
	/* 변수정의 - Service */
	@Resource(name = "FExUserCardServiceA")
	private FExUserCardService userCardService;
	/* 변수정의 - DAO */
	@Resource(name = "FApprovalServiceADAO")
	private FApprovalServiceADAO dao;
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
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService npOption;
	@Resource ( name = "BNpAdminReportService" )
	private BNpAdminReportService reportService;

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
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					break;
				case commonCode.EXI:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 매입전자세금계산서 연동 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 예산 체크 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					break;
				case commonCode.EXU:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 매입전자세금계산서 연동 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 예산 체크 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
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
				String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				/* 이지바로 결재상태 동기화 */
				if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
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
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					break;
				case commonCode.EXI:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 매입전자세금계산서 연동 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 예산 체크 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					break;
				case commonCode.EXU:
					/* 법인카드 상태값 연동 */
					result = ApprovalProcessSaveEx(params, commonCode.EMPTYYES);
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 매입전자세금계산서 연동 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
					}
					/* 예산 체크 */
					if (result.getResultCode().equals(commonCode.FAIL)) {
						return result;
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
				String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
				/* 이지바로 결재상태 동기화 */
				if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				}
				if (result.getResultCode().equals(commonCode.FAIL)) {
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
			if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
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
				if (gwResult == targetList.size()) {
					result = ApprovalProcessEzbaroStatusInfoUpdate(params);
				} else {
					result.setResultCode(commonCode.FAIL);
					result.setResultMessage("EzBaro ERP 상태값 업데이트 실패 : " + commonCode.PROCESSID);
					return result;
				}
			}
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
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					break;
				case commonCode.EXI:
					break;
				case commonCode.EXU:
					break;
				case commonCode.EZICUBE:
				case commonCode.EZERPIU:
					break;
				default :
					break;
				}
			}
			String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			/* 이지바로 결재상태 동기화 */
			if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
				result = ApprovalProcessEzbaroStatusInfoUpdate(params);
			}
			if (result.getResultCode().equals(commonCode.FAIL)) {
				return result;
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
				switch (CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID))) {
				case commonCode.EXA:
					break;
				case commonCode.EXI:
					break;
				case commonCode.EXU:
					break;
				case commonCode.EZICUBE:
				case commonCode.EZERPIU:
					break;
				default :
					break;
				}
			}
			String interProcessId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			/* 이지바로 결재상태 동기화 */
			if (interProcessId.equals(commonCode.EZICUBE) || interProcessId.equals(commonCode.EZERPIU)) {
				result = ApprovalProcessEzbaroStatusInfoUpdate(params);
			}
			if (result.getResultCode().equals(commonCode.FAIL)) {
				return result;
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
	/* 지출결의 연계 - 카드 사용내역 상태값 동기화 */
	private InterlockExpendVO ApprovalProcessSaveEx(Map<String, Object> params, String sendYN) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			String processId = CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID));
			String approKey = CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY));
			String expendSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
			Map<String, Object> cardUpdateParam = new HashMap<String, Object>();
			/* 필수값 확인 - compSeq */
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

	public ResultVO ApprovalSlipDetailInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.ApprovalSlipDetailInfoSelect(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ResultVO ApprovalMngDetailInfoSelect(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result = dao.ApprovalMngDetailInfoSelect(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO ApprovalSelectAttachInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO SelectApprovalAttachInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO SelectApprovalListInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO SelectApprovalSlipInfo(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/* ################################################## */
	/* 이지바로 연계 */
	/* ################################################## */
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

	/* ################################################## */
	/* 국고보조통합시스템 연계 */
	/* ################################################## */
	public InterlockExpendVO ApprovalProcessSaveAngu(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			@SuppressWarnings("unused")
			boolean chkParameter = true;
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
			/* 기본값 정의 - 인력정보 등록 */
			abdocuP = anguADao.AbdocuPS(params);
			for (Map<String, Object> map : abdocuP) {
				updateParams = new HashMap<String, Object>();
				updateParams.put("dSeq", CommonConvert.CommonGetSeq(map.get("dSeq")));
				updateParams.put("bSeq", CommonConvert.CommonGetSeq(map.get("bSeq")));
				updateParams.put("tSeq", CommonConvert.CommonGetSeq(map.get("tSeq")));
				updateParams.put("pSeq", CommonConvert.CommonGetSeq(map.get("pSeq")));
				updateParams.put("anbojoSeq", anbojoSeq);
				map.put("LANGKIND", "KOR");
				map.put("HIFE_AM", CommonConvert.CommonGetDouble(map.get("HIFE_AM")));
				map.put("NAPE_AM", CommonConvert.CommonGetDouble(map.get("NAPE_AM")));
				map.put("DDCT_AM", CommonConvert.CommonGetDouble(map.get("DDCT_AM")));
				map.put("NOIN_AM", CommonConvert.CommonGetDouble(map.get("NOIN_AM")));
				map.put("WD_AM2", CommonConvert.CommonGetDouble(map.get("WD_AM2")));
				map.put("MOSF_GISU_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_GISU_SQ")));
				map.put("MOSF_BG_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_BG_SQ")));
				map.put("MOSF_IN_SQ", CommonConvert.CommonGetSeq(map.get("MOSF_IN_SQ")));
				map.put("PRRT", CommonConvert.CommonGetSeq(map.get("PRRT")));
				map.put("PYMNT_AMOUNT", CommonConvert.CommonGetSeq(map.get("PYMNT_AMOUNT")));
				map.put("NDEP_AM", CommonConvert.CommonGetSeq(map.get("NDEP_AM")));
				map.put("INAD_AM", CommonConvert.CommonGetSeq(map.get("INAD_AM")));
				map.put("INTX_AM", CommonConvert.CommonGetSeq(map.get("INTX_AM")));
				map.put("RSTX_AM", CommonConvert.CommonGetSeq(map.get("RSTX_AM")));
				map.put("WD_AM", CommonConvert.CommonGetSeq(map.get("WD_AM")));
				map = anguIDao.AbdocuPI(map, conVo);
				updateParams.put("HNF_REGIST_SN", CommonConvert.CommonGetStr(map.get("HNF_REGIST_SN")));
				anguADao.AbdocuRegistSnU(updateParams);
			}
			/* iCUBE 상태값 조회 */
			updateParams = new HashMap<String, Object>();
			updateParams.put("gwState", "0");
			updateParams.put("anbojoSeq", CommonConvert.CommonGetStr(anbojoSeq));
			List<Map<String, Object>> syncList = anguADao.AbdocuSyncInfoS(updateParams);
			for (Map<String, Object> map : syncList) {
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

	public InterlockExpendVO ApprovalProcessEndAngu(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		InterlockExpendVO result = new InterlockExpendVO();
		try {
			/* 변수정의 */
			@SuppressWarnings("unused")
			boolean chkParameter = true;
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
			@SuppressWarnings("unused")
			boolean chkParameter = true;
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
			/* 반려처리 - 집행내역 조회 */
			/* 반려처리 - iCUBE 상태 값 판단 */
			/* 삭제 가능한 경우 삭제 처리 */
			/* 삭제 불가한 경우 오류 반환 */

			updateParams = new HashMap<String, Object>();
			updateParams.put("gwState", "1");
			updateParams.put("anbojoSeq", CommonConvert.CommonGetStr(anbojoSeq));
			List<Map<String, Object>> syncList = anguADao.AbdocuSyncInfoS(updateParams);
			for (Map<String, Object> map : syncList) {
				map.put("EXTER_FG", "-GW");
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

			/* 전자결재 종결 처리 */
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
			e.printStackTrace();
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

			outInterfaceVo.setDocSeq(CommonConvert.CommonGetStr(params.get(commonCode.DOCSEQ))); /* 문서아이디 */
			outInterfaceVo.setDocNo(CommonConvert.CommonGetStr(params.get(commonCode.DOCNO))); /* 문서번호 */

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

				interfaceParam.put("docSeq", CommonConvert.CommonGetStr(outInterfaceVo.getDocSeq()));
				interfaceParam.put("docNo", CommonConvert.CommonGetStr(outInterfaceVo.getDocNo()));

				interfaceParam.put("groupSeq", CommonConvert.CommonGetStr(outInterfaceVo.getGroupSeq()));
				interfaceParam.put("compSeq", CommonConvert.CommonGetStr(outInterfaceVo.getCompSeq()));
				interfaceParam.put("bizSeq", CommonConvert.CommonGetStr(outInterfaceVo.getBizSeq()));
				interfaceParam.put("deptSeq", CommonConvert.CommonGetStr(outInterfaceVo.getDeptSeq()));
				interfaceParam.put("empSeq", CommonConvert.CommonGetStr(outInterfaceVo.getEmpSeq()));

				outInterfaceVo.setInterfaceParam(interfaceParam.toString());
				OutInterfaceHisInsert(outInterfaceVo);

				JSONObject interfaceResult = new JSONObject();
				interfaceResult = JSONObject.fromObject(HttpJsonUtil.execute(commonCode.POST, CommonConvert.CommonGetStr(outInterfaceVo.getInterfaceUrl()), interfaceParam));
				outInterfaceVo.setInterfaceResult(interfaceResult.toString());
			}
		}
	}

	/* 품의서 2.0 / 결의서 2.0 외부 연동 - 품의서 외부 연동 정보 조회 */
	public NpOutInterfaceVO ConsOutInterfaceSelect(NpOutInterfaceVO params) throws Exception {
		NpOutInterfaceVO result = new NpOutInterfaceVO();
		result = dao.ConsOutInterfaceSelect(params);
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
			cmLog.CommonSetInfo( "               [EXNP-ADV] CALL dao.SelectAdvInterInfo");
			result = dao.SelectAdvInterInfo( params );
		}catch(Exception ex){
			cmLog.CommonSetInfo( "               [EXNP-ADV] throw Exception dao.SelectAdvInterInfo");
			cmLog.CommonSetError( ex );
		}
		return result;
	}

	@Override
	public InterlockExpendVO ApprovalProcessTripCons ( Map<String, Object> params ) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL ApprovalProcessTripCons params : "  + params.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNPTRIP");
			result = dao.TripConsDocInfoUpdate( params );
			if(!params.get( "consDocSeq" ).toString( ).equals( "0" )){
				result = dao.ConsDocInfoUpdate( params );
			}

			ResultVO apiInfo = dao.ConsDocAPIInfoSelect( params );
			if(apiInfo.getResultCode( ).equals( commonCode.SUCCESS )){
				if(apiInfo.getAaData( ).size( ) == 0){
					throw new Exception(" API연동 데이터가 조회되지 않았습니다. ");
				}
				cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API for trip cons approval , status : " + params.get( "docStatus" ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
				callAttendAPI( apiInfo );
				switch ( params.get( "docStatus" ).toString( ) ) {
					case "20":
	                case "002":
	                	/* 상신시점 캘린더 생성 API 호출 */
	                	cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL calendar API for trip cons approval , status : " + params.get( "docStatus" ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
						ResultVO calendarResult = callCalendarAPI( apiInfo );
						cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL update schm_seq for trip cons approval , status : " + calendarResult.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNP" );
						dao.updateConsSchInfo( calendarResult.getaData( ) );
						break;
					case "100":
	                case "007":
						/* 회수시 캘린더 삭제 API호출 */
						callCalendarDeleteAPI( apiInfo );
	                case "005" :
	                	/* 반려시 캘린더 삭제 API호출 */
						callCalendarDeleteAPI( apiInfo );
	                	break;
	                case "999":
	                case "d":
						/* 삭제시 캘린더 삭제 API호출 */
	                	callCalendarDeleteAPI( apiInfo );
						break;
	                case "90":
	                case "008":
	                	/* 종결 시점 처리 */
	                	break;
	                default :
						break;
				}
			}else{
				throw new Exception("API 연동 조회 중 오류 발생");
			}

		}catch(Exception ex){
			cmLog.CommonSetInfo( "               [EXNP-TRIP] throw Exception dao.ApprovalProcessTripCons");
			cmLog.CommonSetError( ex );
		}
		return result;
	}

	@Override
	public InterlockExpendVO ApprovalProcessTripRes ( Map<String, Object> params ) throws Exception {
		InterlockExpendVO result = new InterlockExpendVO();
		try{
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL ApprovalProcessTripRes PARAM : "  + params.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNPTRIP");
			result = dao.TripResDocInfoUpdate( params );
			if(!params.get( "resDocSeq" ).toString( ).equals( "0" )){
				result = dao.ResDocInfoUpdate( params );
			}

			ResultVO apiInfo = dao.ResDocAPIInfoSelect( params );
			if(apiInfo.getResultCode( ).equals( commonCode.SUCCESS )){
				if(apiInfo.getAaData( ).size( ) == 0){
					throw new Exception(" API연동 데이터가 조회되지 않았습니다. ");
				}
				cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API for trip res approval , status : " + params.get( "docStatus" ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNPTRIP" );
				/* 품의 참조 결의서의 경우 API 호출하지 않음. */


					if(CommonConvert.NullToString( apiInfo.getAaData( ).get( 0 ).get( "confferYN" ) ).equals( "N" )){
						/* 일정 정보 기본 호출 */
						callAttendAPI( apiInfo );
					}
					else {
						callAttendDelAPI(apiInfo);
						callAttendAPI(apiInfo);
					}
					switch ( params.get( "docStatus" ).toString( ) ) {
						case "20":
		                case "002":
		                	/* 상신시점 캘린더 생성 API 호출 */
							cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL calendar API for trip res approval , status : " + params.get( "docStatus" ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNPTRIP" );
							callCalendarDeleteAPI( apiInfo );
							ResultVO calendarResult = callCalendarAPI( apiInfo );
							cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL update schm_seq for trip res approval , status : " + calendarResult.toString( ),CommonConvert.NullToString(params.get("groupSeq")), "-", "EXNPTRIP" );
							dao.updateResSchInfo( calendarResult.getaData( ) );
							break;
						case "100":
		                case "007":
							/* 회수시 캘린더 삭제 API호출 */
							callCalendarDeleteAPI( apiInfo );
		                case "005" :
		                	/* 반려시 캘린더 삭제 API호출 */
							callCalendarDeleteAPI( apiInfo );
		                	break;
		                case "999":
		                case "d":
							/* 삭제시 캘린더 삭제 API호출 */
							callCalendarDeleteAPI( apiInfo );
							break;
		                case "90":
		                case "008":
		                	/* 종결 시점 처리 */

		                	/**
		        			 * 지출결의 자동 전송 진행
		        			 * 독립된 객체로 오류가 발생하여도 롤백하지 않음. */
		        			/* 1. 자동 전송 옵션 조회 */
		        			ResultVO optionResult = new ResultVO( );
		        			boolean autoSend = false;
		        			try{
		        				optionResult = npOption.selectBasicOptionSendType( params );
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


		                	break;
		                default :
							break;
					}

			}else{
				throw new Exception("API 연동 조회 중 오류 발생");
			}

		}catch(Exception ex){
			cmLog.CommonSetInfo( "               [EXNP-TRIP] throw Exception dao.ApprovalProcessTripRes");
			cmLog.CommonSetError( ex );
		}
		return result;
	}

	/** 일정 연동 API호출 */
	/** 일정 테이블 t_sc_sch
	 *  일정 사용자 테이블 t_sc_sch_user
	 *  user_type 10 : 참여자, 20 : 공개범위, 30 : 등록자, 40 : 부서일정일 경 부서
	 *  */
	private ResultVO callCalendarAPI(ResultVO param){
		cmLog.CommonSetInfo( " [EXNP-TRIP-DEBUG] START API CALL CALENDAR " );
		/* 기본 조회 데이터 확인 */
		List<Map<String, Object>> aaData = param.getAaData( );
		Map<String, Object> item = aaData.get( 0 );
		JSONObject apiParam = new JSONObject();

		/*--------------  headerParam  --------------*/
		JSONObject headerParam = new JSONObject();
		headerParam.put("pId", "");
		headerParam.put("groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		headerParam.put("tId", "");
		headerParam.put("empSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )));


		/*--------------  bodyParam - companyInfo --------------*/
		JSONObject companyParam = new JSONObject();
		companyParam.put("compSeq", CommonConvert.NullToString(item.get( "compSeq" )) );
		companyParam.put("bizSeq", "");
		companyParam.put("deptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		companyParam.put("emailAddr", "");
		companyParam.put("emailDomain", "");


		/*--------------  bodyParam - schUserList --------------*/
		JSONArray schUserList = new JSONArray( );
		for( Map<String, Object> scu : aaData ){
			JSONObject schUserItem = new JSONObject();
			schUserItem.put( "userType", "10");
			schUserItem.put( "orgType", "E");
			schUserItem.put( "compSeq", CommonConvert.NullToString( scu.get( "B_compSeq" ) ) );
			schUserItem.put( "orgSeq", CommonConvert.NullToString(scu.get( "B_empSeq" ) ) );
			schUserItem.put( "deptSeq", CommonConvert.NullToString(scu.get( "B_deptSeq" ) ) );
			schUserList.add( schUserItem );
		}

		/*--------------  bodyParam --------------*/
		JSONObject bodyParam = new JSONObject();
		bodyParam.put("companyInfo", companyParam);
		bodyParam.put("schUserList", schUserList);
		bodyParam.put("mcalSeq", CommonConvert.NullToString(item.get("C_mcalSeq")) );
		bodyParam.put("calType", CommonConvert.NullToString(item.get("C_calType")) );
		bodyParam.put("empSeq", CommonConvert.NullToString(item.get("reqEmpSeq")) );
		bodyParam.put("schViewer", CommonConvert.NullToString(item.get("C_schViewer")) );
		bodyParam.put("langCode", CommonConvert.NullToString(item.get("C_langCode")) );
		bodyParam.put("startDate",CommonConvert.NullToString(item.get("C_startDate")) );
		bodyParam.put("endDate",CommonConvert.NullToString(item.get("C_endDate")) );
		bodyParam.put("schTitle", CommonConvert.NullToString(item.get("C_schTitle")) );
		bodyParam.put("attDivCode", CommonConvert.NullToString(item.get("C_attDivCode")) );
		bodyParam.put("alldayYn", CommonConvert.NullToString(item.get("C_alldayYn")) );
		bodyParam.put("alarm_yn", CommonConvert.NullToString(item.get("C_alarm_yn")) );
		bodyParam.put("groupSeq", CommonConvert.NullToString(item.get("groupSeq")) );
		bodyParam.put("compSeq", CommonConvert.NullToString(item.get("compSeq")) );
		bodyParam.put("deptSeq", CommonConvert.NullToString(item.get("deptSeq")) );
		bodyParam.put("schPlace", CommonConvert.NullToString(item.get("C_schPlace")) ); // 일정장소

		/*--------------  set API param --------------*/
		apiParam.put("header", headerParam);
		apiParam.put("body", bodyParam);

		String scheduleUrl = item.get("requestDomain").toString( ) + "/schedule/MobileSchedule/InsertAttendSchedule";

		cmLog.CommonSetInfo( " [EXNP-TRIP-DEBUG] API CALL CALENDAR URL : " + scheduleUrl );
		cmLog.CommonSetInfo( " [EXNP-TRIP-DEBUG] API CALL CALENDAR PARAMETER : " + apiParam.toString( ) );
		JSONObject jsonResult = getPostJSON(scheduleUrl, apiParam.toString());

		ResultVO result = new ResultVO( );
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			resultMap.put( "schmSeq", jsonResult.getJSONObject( "result" ).get( "schmSeq" ).toString( ) );
			resultMap.put( "schSeq", jsonResult.getJSONObject( "result" ).get( "schSeq" ).toString( ) );
			resultMap.put( "tripConsDocSeq", item.get( "tripConsDocSeq" ) );
			resultMap.put( "tripResDocSeq", item.get( "tripResDocSeq" ) );
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP]  Calendar API JSON Result : " + jsonResult.toString( ),CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
			cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP]  Calendar API aData Result : " + resultMap.toString( ),CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
			result.setaData( resultMap );
			result.setSuccess( );
		}catch(Exception ex){
			result.setFail( "일정 API 호출 실패", ex );
			cmLog.CommonSetError( ex );
		}
		return result;
	}

	/** 일정 연동 API호출 */
	private ResultVO callCalendarDeleteAPI(ResultVO param){
		/* 기본 조회 데이터 확인 */
		List<Map<String, Object>> aaData = param.getAaData( );
		Map<String, Object> item = aaData.get( 0 );
		JSONObject apiParam = new JSONObject();

		/*--------------  headerParam  --------------*/
		JSONObject headerParam = new JSONObject();
		headerParam.put("pId", "");
		headerParam.put("groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		headerParam.put("tId", "");
		headerParam.put("empSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )));


		/*--------------  bodyParam - companyInfo --------------*/
		JSONObject companyParam = new JSONObject();
		companyParam.put("compSeq", CommonConvert.NullToString(item.get( "compSeq" )) );
		companyParam.put("bizSeq", "");
		companyParam.put("deptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		companyParam.put("emailAddr", "");
		companyParam.put("emailDomain", "");


		/*--------------  bodyParam - schUserList --------------*/
		JSONArray schUserList = new JSONArray( );
		for( Map<String, Object> scu : aaData ){
			JSONObject schUserItem = new JSONObject();
			schUserItem.put( "userType", "10");
			schUserItem.put( "orgType", "E");
			schUserItem.put( "compSeq", CommonConvert.NullToString( scu.get( "B_compSeq" ) ) );
			schUserItem.put( "orgSeq", CommonConvert.NullToString(scu.get( "B_empSeq" ) ) );
			schUserItem.put( "deptSeq", CommonConvert.NullToString(scu.get( "B_deptSeq" ) ) );
			schUserList.add( schUserItem );
		}

		/*--------------  bodyParam --------------*/
		JSONObject bodyParam = new JSONObject();
		bodyParam.put("empSeq", CommonConvert.NullToString(item.get("reqEmpSeq")) );
		if(CommonConvert.NullToString( param.getAaData( ).get( 0 ).get( "confferYN" ) ).equals( "Y" )){
			bodyParam.put("schmSeq", CommonConvert.NullToString(item.get("consC_schmSeq")) );
			bodyParam.put("schSeq", CommonConvert.NullToString(item.get("consC_schSeq")) );
		}
		else {
			bodyParam.put("schmSeq", CommonConvert.NullToString(item.get("C_schmSeq")) );
			bodyParam.put("schSeq", CommonConvert.NullToString(item.get("C_schSeq")) );
		}
		bodyParam.put("useYn", "N");
		bodyParam.put("companyInfo", companyParam);

		/*--------------  set API param --------------*/
		apiParam.put("header", headerParam);
		apiParam.put("body", bodyParam);

		String scheduleUrl = item.get("requestDomain").toString( ) + "/schedule/MobileSchedule/UpdateAttendScheduleYn";
		JSONObject jsonResult = getPostJSON(scheduleUrl, apiParam.toString());
		return null;
	}

	/** 인사/근태 연동 API호출 */
	private ResultVO callAttendAPI(ResultVO param){
		List<Map<String, Object>> aaData = param.getAaData( );
		JSONArray eaAttReqList = new JSONArray( );
		JSONObject parameter = new JSONObject();
		for( Map<String, Object> item : aaData ){
			JSONObject eaAttReqItem = new JSONObject();
			eaAttReqItem.put( "deptSeq", CommonConvert.NullToString( item.get( "B_deptSeq" ) ) );
			eaAttReqItem.put( "empSeq", CommonConvert.NullToString( item.get( "B_empSeq" ) ) );
			eaAttReqItem.put( "attDivCode", CommonConvert.NullToString( item.get( "B_attDivCode" ) ) );
			eaAttReqItem.put( "attDate", CommonConvert.NullToString( item.get( "B_attDate" ) ) );
			eaAttReqItem.put( "reqStartDt", CommonConvert.NullToString( item.get( "B_reqStartDt" ) ) );
			eaAttReqItem.put( "reqEndDt", CommonConvert.NullToString( item.get( "B_reqEndDt" ) ) );
			eaAttReqItem.put( "dayCnt", CommonConvert.NullToString( item.get( "B_dayCnt" ) ) );
			eaAttReqItem.put( "reqRemark", CommonConvert.NullToString( item.get( "reqTitle" ) ) );
			eaAttReqItem.put( "fieldOffice", CommonConvert.NullToString( item.get( "B_fieldOffice" ) ) );
			eaAttReqItem.put( "attTime", CommonConvert.NullToString( item.get( "B_attTime" ) ) );
			eaAttReqItem.put( "transport", CommonConvert.NullToString( item.get( "B_transport" ) ) );
			eaAttReqItem.put( "officialTripPurpose", CommonConvert.NullToString( item.get( "B_officialTripPurpose" ) ) );
			eaAttReqList.add( eaAttReqItem );
		}
		Map<String, Object> item = aaData.get( 0 );
		parameter.put( "compSeq",  CommonConvert.NullToString(item.get( "compSeq" )) );
		parameter.put( "groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		parameter.put( "reqDate", CommonConvert.NullToString(item.get( "reqDate" )) );
		parameter.put( "reqEmpSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )) );
		parameter.put( "approKey", CommonConvert.NullToString(item.get( "approKey" )) );
		parameter.put( "docSts", CommonConvert.NullToString(item.get( "docSts" )) );
		parameter.put( "reqEmpDeptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		parameter.put( "docId", CommonConvert.NullToString(item.get( "docSeq" )) );
		parameter.put( "reqTitle", CommonConvert.NullToString(item.get( "reqTitle" )) );
		parameter.put( "eaAttReqList", eaAttReqList );

		String scheduleUrl = item.get("requestDomain").toString( ) + "/attend/custom/api/attend/businessTripUpdateAtt";

		cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API URL : " + scheduleUrl + "  PARAMS : " + parameter.toString() ,CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
		JSONObject indiData = getPostJSON(scheduleUrl, parameter.toString());
		cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API RESULT : " + CommonConvert.NullToString( indiData ),CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
		if(indiData == null){
			cmLog.CommonSetError( new Exception(" [EXNP-TRIP] API CALL ATTEND URL >>> " + scheduleUrl + "\n  [EXNP-TRIP] API CALL ATTEND PARAM >>> " + parameter.toString() )  );
		}else{
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND URL >>> " + scheduleUrl );
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND PARAM >>> " + parameter.toString() );
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND RESULT >>> " + indiData.toString( ) );
		}
		return null;
	}

	/** 인사/근태 연동 API호출 */
	private ResultVO callAttendDelAPI(ResultVO param){
		List<Map<String, Object>> aaData = param.getAaData( );
		JSONArray eaAttReqList = new JSONArray( );
		JSONObject parameter = new JSONObject();
		for( Map<String, Object> item : aaData ){
			JSONObject eaAttReqItem = new JSONObject();
			eaAttReqItem.put( "deptSeq", CommonConvert.NullToString( item.get( "B_deptSeq" ) ) );
			eaAttReqItem.put( "empSeq", CommonConvert.NullToString( item.get( "B_empSeq" ) ) );
			eaAttReqItem.put( "attDivCode", CommonConvert.NullToString( item.get( "B_attDivCode" ) ) );
			eaAttReqItem.put( "attDate", CommonConvert.NullToString( item.get( "consB_attDate" ) ) );
			eaAttReqItem.put( "reqStartDt", CommonConvert.NullToString( item.get( "consB_reqStartDt" ) ) );
			eaAttReqItem.put( "reqEndDt", CommonConvert.NullToString( item.get( "consB_reqEndDt" ) ) );
			eaAttReqItem.put( "dayCnt", CommonConvert.NullToString( item.get( "consB_dayCnt" ) ) );
			eaAttReqItem.put( "reqRemark", CommonConvert.NullToString( item.get( "reqTitle" ) ) );
			eaAttReqItem.put( "fieldOffice", CommonConvert.NullToString( item.get( "B_fieldOffice" ) ) );
			eaAttReqItem.put( "attTime", CommonConvert.NullToString( item.get( "B_attTime" ) ) );
			eaAttReqItem.put( "transport", CommonConvert.NullToString( item.get( "B_transport" ) ) );
			eaAttReqItem.put( "officialTripPurpose", CommonConvert.NullToString( item.get( "B_officialTripPurpose" ) ) );
			eaAttReqList.add( eaAttReqItem );
		}
		Map<String, Object> item = aaData.get( 0 );
		parameter.put( "compSeq",  CommonConvert.NullToString(item.get( "compSeq" )) );
		parameter.put( "groupSeq", CommonConvert.NullToString(item.get( "groupSeq" )) );
		parameter.put( "reqDate", CommonConvert.NullToString(item.get( "reqDate" )) );
		parameter.put( "reqEmpSeq", CommonConvert.NullToString(item.get( "reqEmpSeq" )) );
		parameter.put( "approKey", CommonConvert.NullToString(item.get( "confferApproKey" )) );
		parameter.put( "docSts", "d" );
		parameter.put( "reqEmpDeptSeq", CommonConvert.NullToString(item.get( "deptSeq" )) );
		parameter.put( "docId", CommonConvert.NullToString(item.get( "docSeq" )) );
		parameter.put( "reqTitle", CommonConvert.NullToString(item.get( "reqTitle" )) );
		parameter.put( "eaAttReqList", eaAttReqList );

		String scheduleUrl = item.get("requestDomain").toString( ) + "/attend/custom/api/attend/businessTripUpdateAtt";

		cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API URL : " + scheduleUrl + "  PARAMS : " + parameter.toString() ,CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
		JSONObject indiData = getPostJSON(scheduleUrl, parameter.toString());
		cmLog.CommonSetInfoToDatabase( "               [EXNP-TRIP] CALL attend API RESULT : " + CommonConvert.NullToString( indiData ),CommonConvert.NullToString(item.get( "groupSeq" )), "-", "EXNPTRIP" );
		if(indiData == null){
			cmLog.CommonSetError( new Exception(" [EXNP-TRIP] API CALL ATTEND URL >>> " + scheduleUrl + "\n  [EXNP-TRIP] API CALL ATTEND PARAM >>> " + parameter.toString() )  );
		}else{
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND URL >>> " + scheduleUrl );
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND PARAM >>> " + parameter.toString() );
			cmLog.CommonSetInfo( " [EXNP-TRIP] API CALL ATTEND RESULT >>> " + indiData.toString( ) );
		}
		return null;
	}

	public static JSONObject getPostJSON(String url, String data) {
		StringBuilder sbBuf = new StringBuilder();
		HttpURLConnection con = null;
		BufferedReader brIn = null;
		OutputStreamWriter wr = null;
		String line = null;
		try {
			con = (HttpURLConnection) new URL(url).openConnection();
			con.setRequestMethod("POST");
			con.setConnectTimeout(5000);
			con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			con.setDoOutput(true);
			con.setDoInput(true);

			wr = new OutputStreamWriter(con.getOutputStream());
			wr.write(data);
			wr.flush();
			brIn = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			while ((line = brIn.readLine()) != null) {
				sbBuf.append(line);
			}
			// System.out.println(sbBuf);

			JSONObject rtn = JSONObject.fromObject(sbBuf.toString());

			sbBuf = null;

			return rtn;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				wr.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				brIn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				con.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public ResultVO SelectICubeCard_EXP ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result = dao.SelectICubeCard_EXP( params );
		}catch(Exception ex){
			ex.printStackTrace( );
			result.setFail( "throw ExcuteAdvInterICubeCard_EXP", ex );
		}
		return result;
	}

	@Override
	public ResultVO SelectICubeCard_NP ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result = dao.SelectICubeCard_NP( params );
		}catch(Exception ex){
			ex.printStackTrace( );
			result.setFail( "throw SelectICubeCard_NP", ex );
		}
		return result;
	}

	@Override
	public ResultVO SelectICubeCardKey ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			result = dao.SelectICubeCardKey( params );
		}catch(Exception ex){
			ex.printStackTrace( );
			result.setFail( "throw SelectICubeCard_NP", ex );
		}
		return result;
	}
}
