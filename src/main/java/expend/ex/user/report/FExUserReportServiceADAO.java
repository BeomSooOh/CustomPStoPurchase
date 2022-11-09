package expend.ex.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExReportCardVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Repository ( "FExUserReportServiceADAO" )
public class FExUserReportServiceADAO extends EgovComAbstractDAO {

	/* Bizbox Alpha */
	/* Bizbox Alpha - 나의 지출결의 현황 */
	/* Bizbox Alpha - 나의 지출결의 현황 - 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserExpendReportListInfoSelect ( Map<String, Object> params ) {
		return (List<Map<String, Object>>) list( "ExReportExpendUserListInfoSelect", params );
	}

	/* Bizbox Alpha - 나의 지출결의 현황 */
	/* Bizbox Alpha - 나의 지출결의 현황 - 목록 조회 - 전체 COUNT */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExReportExpendUserListInfoTotalCountSelect ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ExReportExpendUserListInfoSelect_TotalCount", params );
	}

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 - 목록 조회 이준성 totalCount */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExUserExpendSlipReportTotalCountSelect (Map<String, Object> params) {
      return (Map<String, Object>) select("ExUserSlipReportA.ExReportSlipExpendListed_TOTALCOUNT", params);
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 - 목록 조회 이준성 Limit */
    public Map<String, Object> ExUserExpendSlipReportLimitInfoSelect (Map<String, Object> params, PaginationInfo paginationInfo) {
        return listOfPaging2(params, paginationInfo, "ExUserSlipReportA.ExReportSlipExpendListed");
    }

	/* Bizbox Alpha - 나의 카드 사용 현황 */
	/* Bizbox Alpha - 나의 카드 사용 현황 - 목록 조회 */
	public Map<String, Object> ExUserCardReportListInfoSelect ( ExReportCardVO reportCardVO, PaginationInfo paginationInfo ) {
		Map<String, Object> params = new HashMap<String, Object>();
		params = CommonConvert.CommonSetMapCopy(CommonConvert.ConverObjectToMap(reportCardVO), params);

		return listOfPaging2( params, paginationInfo, "ExUserReportA.ExUserCardReportListInfoSelect" );
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExReportHeaderInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return (Map<String, Object>) select( "ExReportHeaderInterLockInfoSelect", params );
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExReportContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return (List<Map<String, Object>>) list( "ExReportContentsInterLockInfoSelect", params );
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExReportFooterInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return (Map<String, Object>) select( "ExReportFooterInterLockInfoSelect", params );
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExReportSubtotalInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return (List<Map<String, Object>>) list( "ExReportSubtotalInterLockInfoSelect", params );
	}

	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관처리 진행 */
	@SuppressWarnings ( "unchecked" )
	public boolean ExUserInterfaceTransfer ( Map<String, Object> param ) throws Exception {
		boolean result = true;
		/* 세금계산서인 경우 세금계산서 테이블에 데이터 없을 경우 insert 진행해준다 */
		if (CommonConvert.CommonGetStr(param.get( "interfaceType" )).equals( "etax" ) ) {
			List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>( );
			temp = this.list( "ExUserInterfaceSelect", param );
			if ( temp == null || temp.isEmpty( ) ) {
				param.put( "issDt", param.get( "issDt" ).toString( ).replace( "-", "" ) );
				param.put( "trregNb", param.get( "trregNb" ).toString( ).replace( "-", "" ) );
				this.insert( "ExUserETaxInsert", param );
			}
		}
		List<Map<String, Object>> receiveInfo = new ArrayList<Map<String, Object>>( );
		receiveInfo = CommonConvert.CommonGetJSONToListMap( param.get( "receiveInfo" ).toString( ) );
		for ( int i = 0; i < receiveInfo.size( ); i++ ) {
			Map<String, Object> tParam = new LinkedHashMap<String, Object>( );
			tParam = CommonConvert.CommonSetMapCopy( param, tParam );
			if ( CommonConvert.CommonGetEmpVO( ).getUserSe( ).equals( "ADMIN" ) ) {
				tParam.put( "transferSeq", "ADMIN" );
				tParam.put( "transferName", "관리자" );
			}
			else {
				tParam.put( "transferSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
				tParam.put( "transferName", CommonConvert.CommonGetEmpVO( ).getName( ) );
			}
			tParam.put( "receiveSeq", receiveInfo.get( i ).get( "empSeq" ).toString( ) );
			tParam.put( "receiveName", receiveInfo.get( i ).get( "empName" ).toString( ) );
			tParam.put( "supperKey", receiveInfo.get( i ).get( "superKey" ).toString( ) );
			/* 카드/세금계산서 이관내역 insert */
			if ( CommonConvert.CommonGetStr(param.get( "interfaceType" )).equals( "etax" ) ) {
				tParam.put( "issDt", tParam.get( "issDt" ).toString( ).replace( "-", "" ) );
				tParam.put( "partnerNo", tParam.get( "trregNb" ).toString( ) );
				tParam.put( "partnerName", tParam.get( "trNm" ).toString( ) );
				this.insert( "ExUserETaxTransfer", tParam );
				tParam.put( "interfaceKey", tParam.get( "issNo" ).toString( ) );
			}
			else {
				tParam.put( "cardNum", tParam.get( "cardNum" ).toString( ) );
				tParam.put( "authNum", tParam.get( "authNum" ).toString( ) );
				tParam.put( "authDate", tParam.get( "authDate" ).toString( ) );
				tParam.put( "authTime", tParam.get( "authTime" ).toString( ) );
				tParam.put( "partnerNo", tParam.get( "mercSaupNo" ).toString( ) );
				tParam.put( "partnerName", tParam.get( "mercName" ).toString( ) );
				this.insert( "ExUserCardTransfer", tParam );
				tParam.put( "interfaceKey", tParam.get( "authNum" ).toString( ) );
			}
			tParam.put( "transferCancelYN", "N" );
			/* 이력을 남기기 위해 log insert */
			this.insert( "ExUserInterfaceLogInsert", tParam );
		}
		return result;
	}

	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관 취소 진행 */
	public boolean ExUserInterfaceTransferCancel ( Map<String, Object> param ) throws Exception {
		boolean result = true;
		/* 관리자 이관 취소의 경우에는 transferSeq 가 ADMIN으로 들어간다. */
		String userSe = CommonConvert.CommonGetEmpVO( ).getUserSe( );
		param.put( "userSe", userSe );
		if ( userSe.equals( commonCode.ADMIN ) ) {
			param.put( "transferSeq", "ADMIN" );
			param.put( "transferName", "관리자" );
		}
		/* 카드/세금계산서 이관내역 insert */
		if ( CommonConvert.CommonGetStr(param.get( "interfaceType" )).equals( "etax" ) ) {
			 if(param.containsKey("issNo") && !CommonConvert.CommonGetStr(param.get("issNo")).equals("")) {
				 this.delete( "ExUserETaxTransferCancel2", param );
			 } else {
				 this.delete( "ExUserETaxTransferCancel", param );
				 param.put( "interfaceKey", param.get( "issNo" ).toString( ) );
			 }
		}
		else {
			this.delete( "ExUserCardTransferCancelUpdate", param );
		}
		param.put( "transferCancelYN", "Y" );
		/* 이력을 남기기 위해 log insert */
		// this.insert( "ExUserInterfaceLogInsert", param );
		return result;
	}

	/* 세금계산서 현황 이관 내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserETaxTransferHistory ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		/* 관리자 이관 취소의 경우에는 transferSeq 가 ADMIN으로 들어간다. */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		String userSe = loginVo.getUserSe( );
		param.put( "userSe", userSe );
		if ( userSe.equals( commonCode.ADMIN ) ) {
			param.put( "empSeq", "ADMIN" );
		}
		if ( CommonConvert.CommonGetStr( param.get( "fiEaType" ) ).equals( "ea" ) ) { /* 비영리 세금계산서 이력관리 조회 */
			if ( loginVo.getEaType( ).equals( "ea" ) ) { /* 비영리 중에서 비영리 전자결재 연동인 경우 */
				result = this.list( "NpUserEaETaxTransferHistory", param );
			}
			else { /* 비영리 중에서 영리 전자결재 연동인 경우 */
				result = this.list( "NpUserEapETaxTransferHistory", param );
			}
		}
		else { /* 영리 세금계산서 이력관리 조회 */
			result = this.list( "ExUserETaxTransferHistory", param );
		}
		return result;
	}

	/* 세금계산서 현황 이관 가능 여부 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserETaxTransferChkPossibility ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = this.list( "ExUserETaxTransferChkPossibility", param );
		return result;
	}

	/* 카드내역 현황 이관 가능 여부 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserCardTransferChkPossibility ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = this.list( "ExUserCardTransferChkPossibility", param );
		return result;
	}
}