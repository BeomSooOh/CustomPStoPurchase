package expend.ex.user.list;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import cmm.helper.ConvertManager;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserListServiceADAO" )
public class FExUserListServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	/* 지출결의 - 지출결의 항목 그리드 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExListGridInfoSelect ( ExExpendListVO listVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExListGridInfoSelect", listVo );
		return result;
	}

	/* 지출결의 항목 생성 */
	public ExExpendListVO ExListInfoInsert ( ExExpendListVO listVo ) throws Exception {
		listVo.setListSeq( (String) insert( "ExListInfoInsert", listVo ) );
		return listVo;
	}

	/* 지출결의 항목 수정 */
	public ExCommonResultVO ExListInfoUpdate ( ExExpendListVO listVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExListInfoUpdate", listVo ) > 0 ) {
			resultVo.setCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( ConvertManager.ConverObjectToMap( listVo ) );
		}
		else {
			resultVo.setCode( CommonInterface.commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( ConvertManager.ConverObjectToMap( listVo ) );
		}
		return resultVo;
	}

	/* 지출결의 항목 삭제 */
	public ExCommonResultVO ExListInfoDelete ( ExExpendListVO listVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		delete( "ExListInfoDelete", listVo );
		resultVo.setCode( CommonInterface.commonCode.SUCCESS );
		resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		resultVo.setMap( ConvertManager.ConverObjectToMap( listVo ) );

//		if ( delete( "ExListInfoDelete", listVo ) > 0 ) {
//			resultVo.setCode( CommonInterface.commonCode.SUCCESS );
//			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
//			resultVo.setMap( ConvertManager.ConverObjectToMap( listVo ) );
//		}
//		else {
//			resultVo.setCode( CommonInterface.commonCode.FAIL );
//			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
//			resultVo.setMap( ConvertManager.ConverObjectToMap( listVo ) );
//		}
		return resultVo;
	}

	/* 지출결의 첨부파일 생성 */
	public void ExListAttachInfoInsert ( ExAttachVO attachVo ) {
		insert( "ExAttachInfoInsert", attachVo );
	}

	/* 지출결의 첨부파일 삭제 */
	public void ExListAttachInfoDelete ( Map<String, Object> attachMap ) {
		update( "ExAttachFileInfoDelete", attachMap );
		delete( "ExExpendListAttachListInfoDelete", attachMap );
	}

	/* 지출결의 기존 첨부파일 존재 확인 */
	public String ExListExistAttachInfoSelect ( ExAttachVO attachVo ) {
		String resultCount = CommonInterface.commonCode.EMPTYSTR;
		resultCount = (String) select( "ExExistAttachInfoSelect", attachVo );
		return resultCount;
	}

	/* 지출결의 첨부파일 아이디 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public List<String> ExListAttchFileIDInfoSelect ( Map<String, Object> params ) {
		List<String> fileIdList = new ArrayList<String>( );
		fileIdList = list( "ExAttachFileIDInfoSelect", params );
		return fileIdList;
	}

	/* 지출결의 기존 파일정보 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public List<ExAttachVO> ExListAttchInfoSelect ( Map<String, Object> parmas ) {
		List<ExAttachVO> atttachVoList = new ArrayList<ExAttachVO>( );
		atttachVoList = (List<ExAttachVO>) list( "ExAttchInfoSelect", parmas );
		return atttachVoList;
	}

	/* 지출결의 항목 정보 전체 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExListDetailInfoSelect ( Map<String, Object> parmas ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "ExListDetailInfoSelect", parmas );
		return result;
	}

	/* 지출결의 - 지출결의 분개단위 입력 시 항목 금액 수정 */
	public ExCommonResultVO ExListAmtEdit ( Map<String, Object> param ) throws Exception {
		ExCommonResultVO result = new ExCommonResultVO( );
		try {
			update( "ExExpendListAmtUpdate", param );
			result.setCode( commonCode.EMPTYYES );
		}
		catch ( Exception e ) {
			result.setCode( commonCode.EMPTYNO );
		}
		return result;
	}

	/* 지출결의 - 지출결의 항목 금액 정보 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExListAmtSelect ( ExExpendListVO listVo ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = (Map<String, Object>) select( "ExExpendListAmtSelect", listVo );
		}
		catch ( Exception e ) {
			// do nothing
		}
		return result;
	}

	/* 지출결의 - 지출결의 항목 리스트 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExExpendListVO> ExExpendListSelect ( Map<String, Object> param ) {
		List<ExExpendListVO> result = new ArrayList<ExExpendListVO>( );
		result = list( "ExExpendListSelect", param );
		return result;
	}

	/* 지출결의 - 지출결의 항목 첨부파일 삭제 */
	public ResultVO ExExpendListAttachDelete ( ResultVO param ) {
		ResultVO result = new ResultVO( );
		delete( "ExExpendListAttachDelete", param.getParams( ) );
		result.setResultCode( commonCode.EMPTYYES );
		return param;
	}

	/* 지출결의 - 해당 지출결의 항목 첨부파일 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendListAttachListInfoSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> fileIdList = new ArrayList<Map<String, Object>>( );
		fileIdList = list( "ExExpendListAttachListInfoSelect", param );
		return fileIdList;
	}

	/* 지출결의 - 해당 지출결의 항목 첨부파일 삭제 */
	public boolean ExExpendListAttachListInfoDelete ( Map<String, Object> param ) throws Exception {
		boolean isComplete = true;
		try {
			delete( "ExExpendListAttachListInfoDelete", param );
		}
		catch ( Exception e ) {
			isComplete = false;
		}
		return isComplete;
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExExpendListETaxInfoSelect ( Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "ExExpendListETaxInfoSelect", param );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExListInterfaceSelect ( Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "ExListInterfaceSelect", param );
		return result;
	}

	/* 항목정보 정렬순서 채번 */
	public int ExExpendListOrderInfoSelect (ExExpendListVO listVo) throws Exception {
		return (int)select("ExExpendListOrderInfoSelect", listVo);
	}
}