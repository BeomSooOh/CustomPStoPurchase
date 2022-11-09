package expend.np.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.trip.user.cons.FTripUserConsServiceADAO;
import expend.trip.user.res.FTripUserResServiceADAO;


@Service ( "FNpUserReportServiceA" )
public class FNpUserReportServiceAImpl implements FNpUserReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserReportServiceADAO" )
	private FNpUserReportServiceADAO dao;
	@Resource ( name = "FTripUserConsServiceADAO" )
	private FTripUserConsServiceADAO tripConsdao;
	@Resource ( name = "FTripUserResServiceADAO" )
	private FTripUserResServiceADAO tripResdao;


	@Override
	public ResultVO selectUserConsList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsListSelect( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 리스트 조회 실패", ex );
		}
		return result;
	}

	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.selectCardReport( params );
		return result;
	}

	@Override
	public ResultVO selectConsReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsReportSelect( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 리스트 조회 실패", ex );
		}
		return result;
	}

	/**
	 * 참조결의서 리스트 조회
	 */
	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectConsConfferResList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}

	/**
	 * 품의서 예산내역 조회
	 */
	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			ResultVO headResult = dao.selectConsBudgetListHead( params );
			ResultVO listResult = dao.selectConsBudgetList( params );
			if(CommonConvert.CommonGetStr(headResult.getResultCode( )).equals( commonCode.FAIL )){
				return headResult;
			}
			else if(CommonConvert.CommonGetStr(listResult.getResultCode( )).equals( commonCode.FAIL )){
				return listResult;
			}
			result.setaData( headResult.getaData( ) );
			result.setAaData( listResult.getAaData( ) );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 예산내역 조회 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsConfferStatusUpdate( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserConsConfferBudgetStatusUpdate( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의서 반환/취소 실패", ex );
		}
		return result;
	}


	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpUserResListSelect( params );
		}
		catch ( Exception ex ) {
			result.setFail( "결의서 리스트 조회 실패", ex );
		}
		return result;
	}

	/**
	 * 사용자 - 매입전자세금계산서 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> NPUserEtaxReportList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = dao.NPUserEtaxReportList( param );
		return result;
	}

	/* interlock 양식 헤더 정보 조회 */
	@Override
	public ResultVO selectHeadInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectHeadInterlock( params );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 헤더 정보 조회 실패", ex );
		}
		return result;
	}

	/* interlock 양식 합계 정보 조회 */
	@Override
	public ResultVO selectFooterInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectFooterInterlock( params );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 합계 정보 조회 실패", ex );
		}
		return result;
	}

	/* interlock 양식 컨텐츠 정보 조회 */
	@Override
	public ResultVO selectContentsInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			dao.selectProjectInterlock( params );
			dao.selectBudgetInterlock( params );
			dao.selectTradeInterlock( params );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 양식 정보 조회 실패", ex );
		}
		return result;
	}


	/* interlock  */
	@Override
	public ResultVO selectDContentsInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> dContents = new HashMap<String, Object>( );
			dContents.put( "project", dao.selectProjectInterlock( params ).getAaData( ) );
			dContents.put( "budget", dao.selectBudgetInterlock( params ).getAaData( ) );
			dContents.put( "trade", dao.selectTradeInterlock( params ).getAaData( ) );
			dContents.put( "item", dao.selectItemInterlock( params ).getAaData( ) );

			/* 출장복명 */
			if(params.containsKey("tripConsDocSeq") && params.get("tripConsDocSeq").toString().length() > 0) {
				dContents.put( "tripProject", tripConsdao.selectTripProjectInterlock( params ).getAaData( ) );
				dContents.put( "tripBudget", tripConsdao.selectTripBudgetInterlock( params ).getAaData( ) );
				dContents.put( "tripTrade", tripConsdao.selectTripTradeInterlock( params ).getAaData( ) );
			}
			if(params.containsKey("tripResDocSeq") && params.get("tripResDocSeq").toString().length() > 0) {
				dContents.put( "tripProject", tripResdao.selectTripProjectInterlock( params ).getAaData( ) );
				dContents.put( "tripBudget", tripResdao.selectTripBudgetInterlock( params ).getAaData( ) );
				dContents.put( "tripTrade", tripResdao.selectTripTradeInterlock( params ).getAaData( ) );
			}
			result.setSuccess( );
			result.setaData( dContents );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 양식 정보 조회 실패", ex );
		}
		return result;
	}

	/* interlock 양식 컨텐츠 정보 조회 */
	@Override
	public ResultVO selectCardTransHistoryList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectCardTransHistoryList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 양식 정보 조회 실패", ex );
		}
		return result;
	}

	/* 법인카드 승인내역 상세 현황 조회 */
	@Override
	public ResultVO NPUserCardDetailInfo ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NPUserCardDetailInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "문서 양식 정보 조회 실패", ex );
		}
		return result;

	}

	/* 매입전자 세금 계산서 승인내역 상세 현황 조회 */
	@Override
	public ResultVO NPUserETaxDetailInfo ( Map<String, Object> params, ConnectionVO conVo ) {
		ResultVO result = new ResultVO( );
		result.setFail( "매입전자 세금계산서는 자체 예산 사용 불가능." );
		return result;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/**
	 * 매입전자세금계산서 미사용 처리
	 *
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ResultVO SetETaxUseN(ResultVO param) throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());

		/* 필수 값 점검 ( issNo, issDt, trRegNb ) */
		if (!mapParam.containsKey("issNo") || CommonConvert.CommonGetStr(mapParam.get("issNo")).equals("")) {
			param.setFail("issNo is not exists..");
			return param;
		}
		if (!mapParam.containsKey("issDt") || CommonConvert.CommonGetStr(mapParam.get("issDt")).equals("")) {
			param.setFail("issDt is not exists..");
			return param;
		}
		if (!mapParam.containsKey("trRegNb") || CommonConvert.CommonGetStr(mapParam.get("trRegNb")).equals("")) {
			param.setFail("trRegNb is not exists..");
			return param;
		}

		try {
			ResultVO result = new ResultVO();
			/* 1. 연동정보 존재 확인 */
			result = dao.GetETaxExists(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			} else {
				/* 2. 데이터 생성 처리 */
				if (result.getaData() != null
						&& CommonConvert.CommonGetStr(result.getaData().get("syncId")).equals("")) {
					result = dao.SetETaxInsert(mapParam);

					if (result.getResultCode().equals(commonCode.FAIL)) {
						param.setFail(result.getResultName());
						return param;
					}
				}
			}

			/* 3. 상신여부 확인 */
			result = dao.GetETaxSendExists(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			}

			/* 4. 상태값 미사용 업데이트 처리 */
			result = dao.SetEtaxUseUpdateN(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			}

			param.setSuccess();
		} catch (Exception e) {
			param.setaData(new HashMap<String, Object>());
			param.setFail("매입전자세금계산서 미사용 처리 에러 발생", e);
		}
		return param;
	}

	/**
	 * 매입전자세금계산서 사용 처리
	 *
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public ResultVO SetETaxUseY(ResultVO param) throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());

		/* 필수 값 점검 ( issNo, issDt, trRegNb ) */
		if (!mapParam.containsKey("issNo") || CommonConvert.CommonGetStr(mapParam.get("issNo")).equals("")) {
			param.setFail("issNo is not exists..");
			return param;
		}
		if (!mapParam.containsKey("issDt") || CommonConvert.CommonGetStr(mapParam.get("issDt")).equals("")) {
			param.setFail("issDt is not exists..");
			return param;
		}
		if (!mapParam.containsKey("trRegNb") || CommonConvert.CommonGetStr(mapParam.get("trRegNb")).equals("")) {
			param.setFail("trRegNb is not exists..");
			return param;
		}

		try {
			ResultVO result = new ResultVO();
			/* 1. 연동정보 존재 확인 */
			result = dao.GetETaxExists(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			} else {
				/* 2. 데이터 생성 처리 */
				if (result.getaData() != null
						&& CommonConvert.CommonGetStr(result.getaData().get("syncId")).equals("")) {
					result = dao.SetETaxInsert(mapParam);

					if (result.getResultCode().equals(commonCode.FAIL)) {
						param.setFail(result.getResultName());
						return param;
					}
				}
			}

			/* 3. 상신여부 확인 */
			result = dao.GetETaxSendExists(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			}

			/* 4. 상태값 미사용 업데이트 처리 */
			result = dao.SetEtaxUseUpdateY(mapParam);
			if (result.getResultCode().equals(commonCode.FAIL)) {
				param.setFail(result.getResultName());
				return param;
			}

			param.setSuccess();
		} catch (Exception e) {
			param.setaData(new HashMap<String, Object>());
			param.setFail("매입전자세금계산서 사용 처리 에러 발생", e);
		}
		return param;
	}

	/**
	 * 매입전자세금계산서 이관 처리
	 *
	 * @param param
	 * @return ( compSeq, empSeq, empName, issNo, issDt, trRegNb, trName, reqAmt, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @throws Exception
	 */
	public ResultVO SetETaxTrans(ResultVO param) throws Exception{
		Map<String, Object> mapParam = new HashMap<String, Object>();
		mapParam = param.getParams();
		mapParam.put(commonCode.GROUPSEQ, param.getGroupSeq());
		mapParam.put(commonCode.COMPSEQ, param.getCompSeq());
		mapParam.put(commonCode.EMPSEQ, param.getEmpSeq());
		mapParam.put(commonCode.EMPNAME, param.getEmpName());

		/* 필수 값 점검 ( compSeq, empSeq, empName, issNo, issDt, trRegNb, trName, reqAmt, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey ) */
		if (!mapParam.containsKey("compSeq") || CommonConvert.CommonGetStr(mapParam.get("compSeq")).equals("")) {
			param.setFail("compSeq is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("empSeq") || CommonConvert.CommonGetStr(mapParam.get("empSeq")).equals("")) {
			param.setFail("empSeq is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("empName") || CommonConvert.CommonGetStr(mapParam.get("empName")).equals("")) {
			param.setFail("empName is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("issNo") || CommonConvert.CommonGetStr(mapParam.get("issNo")).equals("")) {
			param.setFail("issNo is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("issDt") || CommonConvert.CommonGetStr(mapParam.get("issDt")).equals("")) {
			param.setFail("issDt is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("trRegNb") || CommonConvert.CommonGetStr(mapParam.get("trRegNb")).equals("")) {
			param.setFail("trRegNb is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("trName") || CommonConvert.CommonGetStr(mapParam.get("trName")).equals("")) {
			param.setFail("trName is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("reqAmt") || CommonConvert.CommonGetStr(mapParam.get("reqAmt")).equals("")) {
			param.setFail("reqAmt is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("receiveEmpSeq") || CommonConvert.CommonGetStr(mapParam.get("receiveEmpSeq")).equals("")) {
			param.setFail("receiveEmpSeq is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("receiveEmpName") || CommonConvert.CommonGetStr(mapParam.get("receiveEmpName")).equals("")) {
			param.setFail("receiveEmpName is not exists..");
			return param;
		}
		else if (!mapParam.containsKey("receiveEmpSuperKey") || CommonConvert.CommonGetStr(mapParam.get("receiveEmpSuperKey")).equals("")) {
			param.setFail("receiveEmpSuperKey is not exists..");
			return param;
		}
		else {
			/* 1. 데이터 존재여부 확인 */
			ResultVO eTaxTransExists = new ResultVO();
			eTaxTransExists = dao.GetETaxTransSelect(mapParam);
			eTaxTransExists.setaData((eTaxTransExists.getaData() == null ? new HashMap<String, Object>() : eTaxTransExists.getaData()));

			if (eTaxTransExists.getaData().containsKey("eTaxTransSeq") && !(CommonConvert.CommonGetStr(eTaxTransExists.getaData().get("eTaxTransSeq")).equals(""))) {
				/* 2-1. 데이터 존재 : 업데이트 */
				mapParam.put("eTaxTransSeq", CommonConvert.CommonGetStr(eTaxTransExists.getaData().get("eTaxTransSeq")));
				eTaxTransExists = dao.SetETaxTransUpdate(mapParam);
				if (eTaxTransExists.getResultCode().equals(commonCode.SUCCESS)) {
					param.setSuccess();
				}
				else {
					param.setFail(eTaxTransExists.getResultName());
				}
			}
			else {
				/* 2-2. 데이터 미존재 : 생성 */
				eTaxTransExists = dao.SetETaxTransInsert(mapParam);
				if (eTaxTransExists.getResultCode().equals(commonCode.SUCCESS)) {
					param.setSuccess();
				}
				else {
					param.setFail(eTaxTransExists.getResultName());
				}
			}
		}


		return param;
	}

	@Override
	public ResultVO selectDocumentInterfaceInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO();
		try {
			result = dao.selectDocumentInterfaceInfo( params );
		} catch (Exception e) {
			result.setFail("외부 시스템 정보 조회 실패", e);
		}
		return result;
	}
}
