package expend.np.user.res;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("FNpUserResServiceADAO")
public class FNpUserResServiceADAO extends EgovComAbstractDAO {

	/**
	 * 결의서 인터락 정보 생성 P : { !formSeq } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO GetExDocMake(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> temp = list("", params);
			result.setAaData(temp);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 최초 생성 P : { }
	 */
	public ResultVO insertResDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resDocSeq = (int) insert("NpUserResA.insertResDoc", params);
			if (resDocSeq > 0) {
				Map<String, Object> temp = new HashMap<String, Object>();
				temp.put("resDocSeq", resDocSeq);
				result.setaData(temp);
				result.setSuccess();
			}
			else {
				result.setFail("품의 문서가 저장되지 않았습니다.");
			}
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	/**
	 * 결의서 및 품의서 생성 시 데이터 조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO CheckDraftInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if ("".equals(params.get("consDocSeq")) || params.get("consDocSeq") == null) {
				result.setaData((Map<String, Object>) select("NpUserResA.CheckDraftInfo", params));
				result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectResBudgetInfo", params));
				result.setSuccess();
			} else {
				result.setaData((Map<String, Object>) select("NpUserConsA.CheckDraftInfo", params));
				result.setAaData((List<Map<String, Object>>) list("NpUserConsA.selectConsBudgetInfo", params));
				result.setSuccess();
			}
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	/**
	 * 결의문서 삭제 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResDoc", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의문서 갱신 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) update("NpUserResA.updateResDoc", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의문서 전자결재 정보갱신 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResDocEaInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if( params.get("docStatus").toString( ).equals( "999" ) 
					|| params.get("docStatus").toString( ).equals( "005" )
					|| params.get("docStatus").toString( ).equals( "007" )
					|| params.get("docStatus").toString( ).equals( "d" )
			){
				/* 카드 사용내역 / 매입전자 세금계산서 정보 롤백 */
				update("NpUserResA.updateResDocCardInfo", params);
				update("NpUserResA.updateResDocEtaxInfo", params);
			}
			int resultCnt = (int) update("NpUserResA.updateResDocEaInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의문서 정보 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectResDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectResDoc", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 정보 생성 P : { } return ResultVO with aaData
	 */
	public ResultVO insertResHead(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int consSeq = (int) insert("NpUserResA.insertResHead", params);
			if( CommonConvert.NullToString( params.get( "expendDate" ) ).length( ) != 8 ){
				params.put( "expendDate", CommonConvert.NullToString( params.get( "resDate" ) ) );
			}
			update("NpUserResA.updateResDoc", params);
			/* G20 일때, 원인행위 옵션 사용시 데이터 저장 */
			if (params.get("erpTypeCode").equals("iCUBE")) {
				if (params.get("causeDate") != null && params.get("causeEmpSeq") != null) {
					params.put("resSeq", consSeq);
					insert("NpUserResA.insertResCause", params);
				} 
			}
			/* ERPiU 일때, 원인행위 옵션 사용시 데이터 저장 */
			else if (params.get("erpTypeCode").equals("ERPiU")) {
				if (params.get("causeDate") != null) {
					params.put("resSeq", consSeq);
					insert("NpUserResA.insertResCause", params);
				}
			}
			if (consSeq > 0) {
				Map<String, Object> temp = new HashMap<String, Object>();
				temp.put("resSeq", consSeq);
				result.setaData(temp);
				result.setSuccess();
			}
			else {
				result.setFail("품의 문서가 저장되지 않았습니다.");
			}
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 정보 갱신 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResHead(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) update("NpUserResA.updateResHead", params);
			if( CommonConvert.NullToString( params.get( "expendDate" ) ).length( ) != 8 ){
				params.put( "expendDate", CommonConvert.NullToString( params.get( "resDate" ) ) );
			}
			update("NpUserResA.updateResDoc", params);
			/* G20 일때, 원인행위 옵션 사용시 데이터 저장 */
			if (params.get("erpTypeCode").equals("iCUBE")) {
				if (params.get("causeDate") != null && params.get("causeEmpSeq") != null) {
					if((int)update("NpUserResA.updateResCause", params) < 1){
						insert("NpUserResA.insertResCause", params);
					}
				}
			}
			/* ERPiU 일때, 원인행위 옵션 사용시 데이터 저장 */
			else if (params.get("erpTypeCode").equals("ERPiU")) {
				if (params.get("causeDate") != null) {
					if((int)update("NpUserResA.updateResCause", params) < 1){
						insert("NpUserResA.insertResCause", params);
					}
				}
			}
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
			ex.printStackTrace();
		}
		return result;
	}

	/**
	 * 각개 결의 정보 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectResHead(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectResHead", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 정보 삭제 - 단일 품의서 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResHead(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResHead", params);
			/* G20 일때, 원인행위 옵션 사용시 데이터 삭제 */
			if (params.get("erpTypeCode").equals("iCUBE")) {
				if (params.get("causeDate") != null && params.get("causeEmpSeq") != null) {
					insert("NpUserResA.deleteResCause", params);
				}
			}
			/* ERPiU 일때, 원인행위 옵션 사용시 데이터 삭제 */
			if (params.get("erpTypeCode").equals("iCUBE")) {
				if (params.get("causeDate") != null) {
					insert("NpUserResA.deleteResCause", params);
				}
			}
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 정보 삭제 - 문서 단위 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResHeadForDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResHeadForDoc", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 생성 P : { } return ResultVO with aaData
	 */
	public ResultVO insertResBudget(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int budgetSeq = (int) insert("NpUserResA.insertResBudget", params);
			if (budgetSeq > 0) {
				Map<String, Object> temp = new HashMap<String, Object>();
				temp.put("budgetSeq", budgetSeq);
				result.setaData(temp);
				result.setSuccess();
			}
			else {
				result.setFail("결의 문서가 저장되지 않았습니다.");
			}
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 갱신 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResBudget(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) update("NpUserResA.updateResBudget", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectResBudget(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectResBudget", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 삭제 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResBudget(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResBudget", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 삭제 - 문서 단위 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResBudgetForDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResBudgetForDoc", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산 정보 삭제 - 결의서 단위 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResBudgetForRes(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResBudgetForRes", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 거래처 정보 생성 P : { } return ResultVO with aaData
	 */
	public ResultVO insertResTrade(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			/* 매입전자세금계산서 추가 프로세스 */
			if (params.containsKey("interfaceType") && CommonConvert.CommonGetStr(params.get("interfaceType")).equals("etax")) {
				if (!params.get("issNo").equals("")) {
					/* t_ex_etax_aq_tmp 중복데이터 확인 */
					Map<String, Object> eTaxInfo = (Map<String, Object>) select("NpUserETaxA.ETaxSelect", params);

					if (eTaxInfo == null || (eTaxInfo.containsKey("syncId") && CommonConvert.CommonGetStr(eTaxInfo.get("syncId")).equals(""))) {
						/* t_ex_etax_aq_tmp 데이터 생성 */
						insert("NpUserETaxA.ETaxInsert", params);
						eTaxInfo = (Map<String, Object>) select("NpUserETaxA.ETaxSelect", params);
					}
					/* t_ex_etax_aq_tmp 데이터 수정 */
					params.put("syncId", eTaxInfo.get("syncId"));
					params.put("interfaceSeq", params.get("syncId"));
				}
			}

			int tradeSeq = (int) insert("NpUserResA.insertResTrade", params);
			if (tradeSeq > 0) {
				update("NpUserETaxA.ETaxEmpInfoUpdate", params);
				Map<String, Object> temp = new HashMap<String, Object>();
				temp.put("tradeSeq", tradeSeq);
				result.setaData(temp);
				result.setSuccess();
			}
			else {
				result.setFail("품의 문서가 저장되지 않았습니다.");
			}
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 거래처 정보 갱신 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResTrade(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) update("NpUserResA.updateResTrade", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 거래처 정보 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectResTrade(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectResTrade", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResTrade(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResTrade", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 예산 종속 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResTradeForBudget(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResTradeForBudget", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 품의서 종속 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResTradeForRes(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResTradeForRes", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 품의 거래처 정보 삭제 - 품의서 문서 종속 P : { } return ResultVO with aaData
	 */
	public ResultVO deleteResTradeForDoc(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			int resultCnt = (int) delete("NpUserResA.deleteResTradeForDoc", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 각개 결의 예산정보 최신화 P : { } return ResultVO with aaData
	 */
	public ResultVO updateResAmt(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateResBudgetAmt", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 문서 적용 [ DOC ] P : { }
	 */
	public ResultVO updateDocConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateDocConfferInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 문서 적용 [ HEAD ] P : { }
	 */
	public ResultVO updateHeadConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateHeadConfferInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 문서 적용 [ BUDGET ] P : { }
	 */
	public ResultVO updateBudgetConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateBudgetConfferInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 문서 적용 [ TRADE ] P : { }
	 */
	public ResultVO updateTradeConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateTradeConfferInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 롤백 진행 [ DOC ] P : { }
	 */
	public ResultVO rollbackDocConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			delete("NpUserResA.rollbackDocConfferInfo", params);
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 롤백 진행 [ HEAD ] P : { }
	 */
	public ResultVO rollbackHeadConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			delete("NpUserResA.rollbackHeadConfferInfo", params);
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 롤백 진행 [ BUDGET ] P : { }
	 */
	public ResultVO rollbackBudgetConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			delete("NpUserResA.rollbackBudgetConfferInfo", params);
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서 참조품의 롤백 진행 [ TRADE ] P : { }
	 */
	public ResultVO rollbackTradeConfferInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			delete("NpUserResA.rollbackTradeConfferInfo", params);
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 카드사용내역 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectCardDataList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if (params.get("searchCardInfo").toString().indexOf(",") > 0) {
				params.put("cardInfo", params.get("searchCardInfo").toString().split(","));
			}
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectCardDataList", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 작성중인 카드사용내역 조회 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectCardInfoIntoRes(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectCardInfoIntoRes", params));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 참조품의 결의서 예산인지 확인 P : { } return ResultVO with aaData
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectConfferBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if( CommonConvert.NullToString(  params.get( "erpBudgetSeq" ) ).equals( "" )){
				params.put( "erpBudgetSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBgacctSeq" ) ).equals( "" )){
				params.put( "erpBgacctSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "" )){
				params.put( "erpBizplanSeq", "-1" );
			}
			result.setaData((Map<String, Object>) select("NpUserResA.selectConfferBudgetInfo", params));

			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "-1" )){
				params.put( "erpBizplanSeq", "" );
			}
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	/**
	 * 결의서내 중복 예산코드 금액 정보조회
	 */
	@SuppressWarnings("unchecked")
	public ResultVO selectGroupBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();
		try {
			if( CommonConvert.NullToString(  params.get( "erpBudgetSeq" ) ).equals( "" )){
				params.put( "erpBudgetSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBgacctSeq" ) ).equals( "" )){
				params.put( "erpBgacctSeq", "-1" );
			}
			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "" )){
				params.put( "erpBizplanSeq", "-1" );
			}
			
			List<Map<String, Object>> aaData = (List<Map<String, Object>> )list("NpUserResA.selectGroupBudgetInfo", params);
			if(aaData.size( ) == 0){
				Map<String, Object> aData = new HashMap<>( );
				aData.put( "resDocSeq", "" );
				aData.put( "resSeq", "" );
				aData.put( "budgetAmt", "0" );
				aData.put( "budgetStdAmt", "0" );
				aData.put( "budgetTaxAmt", "0" );
				aaData.add( aData );
			}
			result.setAaData( aaData );
			
			if( CommonConvert.NullToString(  params.get( "erpBizplanSeq" ) ).equals( "-1" )){
				params.put( "erpBizplanSeq", "" );
			}
			
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	public List<Map<String, Object>> ETaxLinkSelect(Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

		try {
			result = (List<Map<String, Object>>) list("NpUserETaxA.ETaxLinkSelect", param);
		}
		catch (Exception e) {
			// TODO: handle exception
			result = null;
		}

		return result;
	}

	public void ETaxStatInfoUpdate(Map<String, Object> param) {
		update("NpUserETaxA.ETaxStatInfoUpdate", param);
	}

	public List<Map<String, Object>> CardLinkSelect(Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

		try {
			result = (List<Map<String, Object>>) list("NpUserCard.CardLinkSelect", param);
		}
		catch (Exception e) {
			// TODO: handle exception
			result = null;
		}

		return result;
	}
	
	public void CardStatInfoUpdate(Map<String, Object> param) {
		update("NpUserCard.CardStatInfoUpdate", param);
	}
	
	public ResultVO updateFavoritesStatus(Map<String, Object> param) {
		ResultVO result =  new ResultVO( );
		try {
			update("NpUserCard.updateFavoritesResStatus", param);
			result.setSuccess( );
		}
		catch ( Exception e ) {
			result.setFail( e.toString( ), e );
		}
		return result;
	}

	public ResultVO selectFavoritesList ( Map<String, Object> param ) {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>>) list("NpUserResA.selectFavoritesList", param));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;	
	}

	public ResultVO updateDocFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateDocFavoriteInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO updateHeadFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			int resSeq = (int) insert("NpUserResA.updateHeadFavoriteInfo", params);
			Map param = new HashMap<>();
			param.put("causeDate", params.get("causeDate"));
			param.put("signDate", params.get("signDate"));
			param.put("inspectDate", params.get("inspectDate"));
			param.put("payplanDate", params.get("payplanDate"));
			param.put("causeEmpSeq", params.get("causeEmpSeq"));
			param.put("causeEmpName", params.get("causeEmpName"));
			param.put("resSeq", Integer.toString(resSeq));
			insert("NpUserResA.updateCauseFavoriteInfo", param);
			result.setaData(param);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO selectBudgetFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>> )list("NpUserResA.selectResBudgetSeq", params));
			result.setSuccess();
		} 
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	public ResultVO selectTradeFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			result.setAaData((List<Map<String, Object>> )list("NpUserResA.selectResTradeSeq", params));
			result.setSuccess();
		} 
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
	
	public ResultVO updateBudgetFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			int budgetSeq = (int) insert("NpUserResA.updateBudgetFavoriteInfo", params);
			Map param = new HashMap<>();
			param.put("budgetSeq", Integer.toString(budgetSeq));
			result.setaData(param);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO updateTradeFavoriteInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			insert("NpUserResA.updateTradeFavoriteInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}

	public ResultVO deleteResItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserResA.deleteResItemSpec", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 정보가 삭제되지 않았습니다.", ex );
		}
		return result;	
	}
	
	public ResultVO deleteResAllItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int resultCnt = (int) delete( "NpUserResA.deleteResAllItemSpec", params );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 정보가 삭제되지 않았습니다.", ex );
		}
		return result;	
	}

	public ResultVO insertResItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			int consItemSeq = (int) insert( "NpUserResA.insertResItemSpec", params );
			if ( consItemSeq > 0 ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "물품명세 정보가 저장되지 않았습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "Data 질의 요청중 에러 발생", ex );
		}
		return result;
	}

	public ResultVO selectResItemSpec(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( (List<Map<String, Object>>) list( "NpUserResA.selectResItemSpec", params ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "물품명세 정보가 조회되지 않았습니다.", ex );
		}
		return result;
	}

	public ResultVO updateItemSpecConfferInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			update("NpUserResA.updateItemSpecConfferInfo", params);
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("Data 질의 요청중 에러 발생", ex);
		}
		return result;
	}
}