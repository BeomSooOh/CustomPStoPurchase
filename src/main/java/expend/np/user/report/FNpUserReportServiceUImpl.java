package expend.np.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
//import common.vo.ex.ExCodeETaxVO;
import expend.np.user.etax.FNpUserETaxService;


@Service ( "FNpUserReportServiceU" )
public class FNpUserReportServiceUImpl implements FNpUserReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserReportServiceUDAO" )
	private FNpUserReportServiceUDAO dao;
	@Resource ( name = "FNpUserETaxServiceA" )
	private FNpUserETaxService servicesA;
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
	public List<Map<String, Object>> NPUserEtaxReportList ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> etaxList = new ArrayList<Map<String, Object>>( );
		/* 현재 작성중인 계산서 조회 */
		String usingId = "";
		for ( Map<String, Object> tMap : servicesA.selectWritingETaxList( param ).getAaData( ) ) {
			usingId += tMap.get( "issNo" ) + "','";
		}
		if ( !usingId.equals( "" ) ) {
			usingId = usingId.substring( 0, usingId.length( ) - 3 );
		}
		param.put( "notInsertIssNo", usingId );
		/* 세금계산서 권한 조회 */
		String trchargeEmail = "";
		String trregNb = "";
		Map<String, Object> authParam = new HashMap<String, Object>( );
		authParam.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
		authParam.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
		for ( Map<String, Object> tData : servicesA.selectGWEtaxAuth( authParam ) ) {
			if ( CommonConvert.CommonGetStr(tData.get( "authType" )).equals( "P" ) ) {
				trregNb += tData.get( "code" ).toString( ) + "','";
			}
			else {
				trchargeEmail += tData.get( "code" ).toString( ) + "','";
			}
		}
		if ( trregNb.length( ) > 3 ) {
			trregNb = trregNb.substring( 0, trregNb.length( ) - 3 );
		}
		else {
			trregNb = "";
		}
		if ( trchargeEmail.length( ) > 3 ) {
			trchargeEmail = trchargeEmail.substring( 0, trchargeEmail.length( ) - 3 );
		}
		else {
			trchargeEmail = "";
		}
		param.put( "trchargeEmail", trchargeEmail );
		param.put( "trregNb", trregNb );
		/* 이관 받은 세금계산서 정보 조회 */
		List<Map<String, Object>> gwTransferList = new ArrayList<Map<String, Object>>( );
		param.put( "searchFromDt", CommonConvert.CommonGetStr( param.get( "searchFromDt" ) ) );
		param.put( "searchToDt", CommonConvert.CommonGetStr( param.get( "searchToDt" ) ) );
		gwTransferList = servicesA.NpTransferETaxListSelect( param );
		if ( gwTransferList != null && !gwTransferList.isEmpty( ) ) {
			String transferIssNo = "";
			for ( Map<String, Object> tData : gwTransferList ) {
				transferIssNo += tData.get( "issNo" ).toString( ) + "','";
			}
			if ( transferIssNo.length( ) > 3 ) {
				transferIssNo = transferIssNo.substring( 0, transferIssNo.length( ) - 3 );
			}
			param.put( "transferIssNo", transferIssNo );
		}
		/* 자신의 Email 주소는 기본으로 검색 */
		param.put( "baseEmailAddr", CommonConvert.CommonGetEmpVO( ).getEmail( ) + "@" );
		param.put( commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpVO( ).getErpCoCd( ) );
		etaxList = dao.NPUserETaxListInfoSelectMap( param, conVo );
		return etaxList;
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
		ResultVO result = new ResultVO();
		try {
			List<Map<String, Object>> etaxResult = dao.selectETaxDetailInfo( params, conVo );
			if(etaxResult == null ){
				result.setFail( "DAO 오류 발생." );
				return result;
			}
			result.setSuccess( );
			result.setaData( etaxResult.get( 0 ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			result.setFail( "ERPiU 전자 세금계산서 조회에 실패 하였습니다.", e );
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

	@Override
	public ResultVO selectDocumentInterfaceInfo(Map<String, Object> params) {
		ResultVO result = new ResultVO( );
		return result;
	}
}
