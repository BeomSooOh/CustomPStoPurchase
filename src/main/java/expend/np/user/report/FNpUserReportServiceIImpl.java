package expend.np.user.report;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserReportServiceI" )
public class FNpUserReportServiceIImpl implements FNpUserReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserReportServiceIDAO" )
	private FNpUserReportServiceIDAO dao;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;

	@Override
	public ResultVO selectUserConsList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		return result;
	}

	@Override
	public List<Map<String, Object>> selectCardReport ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	@Override
	public ResultVO selectConsReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	@Override
	public ResultVO selectResReport ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	/**
	 * 사용자 - 매입전자세금계산서 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> NPUserEtaxReportList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* interlock 양식 헤더 정보 조회 */
	@Override
	public ResultVO selectHeadInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	/* interlock 양식 합계 정보 조회 */
	@Override
	public ResultVO selectFooterInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	/* interlock 양식 컨텐츠 정보 조회 */
	@Override
	public ResultVO selectContentsInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	/* interlock 양식 컨텐츠 정보 조회 */
	@Override
	public ResultVO selectDContentsInterlock ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	@Override
	public ResultVO updateConfferStatus ( Map<String, Object> params ) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectCardTransHistoryList ( Map<String, Object> params ) {
		ResultVO result = new ResultVO( );
		return result;
	}

	@Override
	public ResultVO NPUserCardDetailInfo ( Map<String, Object> params ) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO NPUserETaxDetailInfo ( Map<String, Object> params, ConnectionVO conVo ) {
		cmLog.CommonSetInfo( "Call ExUserEmpListInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			ResultVO daoResult = dao.selectETaxDetailInfo( params, conVo );
			if(daoResult .getResultCode( ).equals( commonCode.FAIL )){
				return daoResult;
			}else{
				result = daoResult;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			result.setFail( "iCUBE 전자 세금계산서 조회에 실패 하였습니다.", e );
		}
		return result;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	public ResultVO SetETaxUseN(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	public ResultVO SetETaxUseY(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 이관 처리
	 *
	 * @param param
	 * @return ( []eTaxTransList, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey )
	 * @throws Exception
	 */
	public ResultVO SetETaxTrans(ResultVO param) throws Exception{
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 이관 목록 조회
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	public ResultVO GetETaxTransList(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	/**
	 * 매입전자세금계산서 수신 목록 조회
	 *
	 * @param param
	 *            ( issDateFrom, issDateTo, compSeq, empSeq )
	 * @return ( compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey )
	 * @throws Exception
	 */
	public ResultVO GetETaxReceiveList(ResultVO param) throws Exception {
		param.setFail("Bizbox Alpha 전용 기능입니다.");
		return param;
	}

	@Override
	public ResultVO selectDocumentInterfaceInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		return result;
	}

}
