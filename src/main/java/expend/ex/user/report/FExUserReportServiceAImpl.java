package expend.ex.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExReportCardVO;
import common.vo.common.ResultVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Service ( "FExUserReportServiceA" )
public class FExUserReportServiceAImpl implements FExUserReportService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserReportServiceADAO" )
	private FExUserReportServiceADAO userReportDAO;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* Common */
	/* Bizbox Alpha */
	/* Bizbox Alpha - 나의 지출결의 현황 */
	/* Bizbox Alpha - 나의 지출결의 현황 - 목록 조회 */
	public List<Map<String, Object>> ExUserExpendReportListInfoSelect ( Map<String, Object> params ) throws Exception {
		/* parameter : fromDate, toDate, reqDate, docNo, docTitle */
		cmLog.CommonSetInfo( "Call ExUserExpendReportListInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 필수 파라미터 점검 */
			/* 필수 파라미터 점검 - 회사 시퀀스 */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ );
			}
			/* 필수 파라미터 점검 - 결의(회계)일자 From */
			if ( CommonConvert.CommonGetStr( params.get( "searchFromDate" ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + "searchFromDate" );
			}
			/* 필수 파라미터 점검 - 결의(회계)일자 To */
			if ( CommonConvert.CommonGetStr( params.get( "searchToDate" ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + "searchToDate" );
			}
			/* 필수 파라미터 점검 - 지급요청일자, 문서번호, 문서제목은 선택 검색 */
			/* 사용자 입력 검색어로 오류 발생 문자열 치환 */
			params.put( "docNo", CommonConvert.CommonGetStr( params.get( "docNo" ) ).replace( "'", "''" ) );
			params.put( commonCode.DOCTITLE, CommonConvert.CommonGetStr( params.get( commonCode.DOCTITLE ) ).replace( "'", "''" ) );
			/* 데이터 조회 */
			result = userReportDAO.ExUserExpendReportListInfoSelect( params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Bizbox Alpha * /
	/* Bizbox Alpha - 나의 지출결의 현황 */
	/* Bizbox Alpha - 나의 지출결의 현황 - 목록 조회 푸딩버전 */
	public Map<String, Object> ExUserExpendReportListInfoNewSelect ( Map<String, Object> params ) throws Exception {
		/* parameter : fromDate, toDate, reqDate, docNo, docTitle */
		cmLog.CommonSetInfo( "Call ExUserExpendReportListInfoNewSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 필수 파라미터 점검 */
			/* 필수 파라미터 점검 - 회사 시퀀스 */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ );
			}
			/* 필수 파라미터 점검 - 결의(회계)일자 From */
			if ( CommonConvert.CommonGetStr( params.get( "searchFromDate" ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + "searchFromDate" );
			}
			/* 필수 파라미터 점검 - 결의(회계)일자 To */
			if ( CommonConvert.CommonGetStr( params.get( "searchToDate" ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + "searchToDate" );
			}
			/* 필수 파라미터 점검 - 지급요청일자, 문서번호, 문서제목은 선택 검색 */
			/* 사용자 입력 검색어로 오류 발생 문자열 치환 */
			params.put( "docNo", CommonConvert.CommonGetStr( params.get( "docNo" ) ).replace( "'", "''" ) );
			params.put( commonCode.DOCTITLE, CommonConvert.CommonGetStr( params.get( commonCode.DOCTITLE ) ).replace( "'", "''" ) );
			
			/* 데이터 조회 */
			result.put("aaData", userReportDAO.ExUserExpendReportListInfoSelect(params));
			result.put("aaDataTotalSize", userReportDAO.ExReportExpendUserListInfoTotalCountSelect(params));
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Bizbox Alpha - 나의 카드 사용 현황 */
	/* Bizbox Alpha - 나의 카드 사용 현황 - 목록 조회 */
	public Map<String, Object> ExUserCardReportListInfoSelect ( ExReportCardVO reportCardVO, PaginationInfo paginationInfo ) throws Exception {
		/*
		 * parameter : compSeq, bizSeq, deptSeq, fromDate, toDate, cardNum,
		 * mercName
		 */
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			/* 필수 파라미터 점검 */
			/* 필수 파라미터 점검 - 회사 시퀀스 */
			if ( reportCardVO.getCompSeq().equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ );
			}
			/* 필수 파라미터 점검 - 사용자 시퀀스 */
			if ( reportCardVO.getEmpSeq().equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.EMPSEQ );
			}
			/* 필수 파라미터 점검 - 승인일자 From */
			if ( reportCardVO.getFromDate().equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.FROMDATE );
			}
			/* 필수 파라미터 점검 - 승인일자 To */
			if ( reportCardVO.getToDate().equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "FExUserReportServiceA - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.TODATE );
			}
			/* 데이터 조회 */
			result = userReportDAO.ExUserCardReportListInfoSelect( reportCardVO, paginationInfo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	/* iCUBE */
	/* ERPiU */
	/* ETC */

	@Override
	public Map<String, Object> ExReportHeaderInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return userReportDAO.ExReportHeaderInterLockInfoSelect( params );
	}

	@Override
	public List<Map<String, Object>> ExReportContentsInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return userReportDAO.ExReportContentsInterLockInfoSelect( params );
	}

	@Override
	public Map<String, Object> ExReportFooterInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return userReportDAO.ExReportFooterInterLockInfoSelect( params );
	}
	
	@Override
	public List<Map<String, Object>> ExReportSubtotalInterLockInfoSelect ( Map<String, Object> params ) throws Exception {
		return userReportDAO.ExReportSubtotalInterLockInfoSelect( params );
	}

	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관처리 진행 */
	public ResultVO ExUserInterfaceTransfer ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		if ( userReportDAO.ExUserInterfaceTransfer( param ) ) {
			result.setSuccess( );
		}
		else {
			result.setFail( "이관 처리 실패" );
		}
		return result;
	}

	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관 취소 진행 */
	public ResultVO ExUserInterfaceTransferCancel ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		if ( userReportDAO.ExUserInterfaceTransferCancel( param ) ) {
			result.setSuccess( );
		}
		else {
			result.setFail( "이관 처리 실패" );
		}
		return result;
	}

	/* 세금계산서 현황 이관 내역 조회 */
	public List<Map<String, Object>> ExUserETaxTransferHistory ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = userReportDAO.ExUserETaxTransferHistory( param );
		return result;
	}

	/* 세금계산서 현황 이관 가능 여부 조회 */
	public List<Map<String, Object>> ExUserETaxTransferChkPossibility ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = userReportDAO.ExUserETaxTransferChkPossibility( param );
		return result;
	}

	/* 카드내역 현황 이관 가능 여부 조회 */
	public List<Map<String, Object>> ExUserCardTransferChkPossibility ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = userReportDAO.ExUserCardTransferChkPossibility( param );
		return result;
	}

	//
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExUserExpendSlipReportListInfoSelect(Map<String, Object> params) throws Exception {
      Map<String, Object> result = new HashMap<String, Object>();

      
      try {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(EgovStringUtil.zeroConvert(params.get("page")));
        paginationInfo.setPageSize(EgovStringUtil.zeroConvert(params.get("pageSize")));
        
       
        result.put("resultList", userReportDAO.ExUserExpendSlipReportLimitInfoSelect(params,paginationInfo));
        
      } catch (Exception e) {
        throw new Exception(e);
      }
      
      return result;
    }
}
