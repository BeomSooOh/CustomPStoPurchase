package expend.ex.user.slip;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import expend.ex.user.etax.FExUserEtaxServiceIDAO;
import main.web.BizboxAMessage;


@Repository ( "FExUserSlipServiceADAO" )
public class FExUserSlipServiceADAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	@Resource ( name = "FExUserEtaxServiceIDAO" )
	private FExUserEtaxServiceIDAO daoI;

	/* 지출결의 */
	/* 지출결의 - 지출결의 항목 분개 생성 */
	public ExExpendSlipVO ExSlipInfoInsert ( ExExpendSlipVO slipVo ) throws Exception {
		slipVo.setSlipSeq( (String) insert( "ExSlipInfoInsert", slipVo ) );
		return slipVo;
	}

	/* 지출결의 - 지출결의 항목 재분개 생성 */
	public ExExpendSlipVO ExSlipInfoReInsert ( ExExpendSlipVO slipVo ) throws Exception {
		String tempSlipSeq = slipVo.getSlipSeq( );
		slipVo.setSlipSeq( (String) insert( "ExSlipInfoReInsert", slipVo ) );

		try {
			slipVo.setSlipSeq(CommonConvert.CommonGetStr(Integer.parseInt(slipVo.getSlipSeq( ))));
		}catch(NumberFormatException  e) {
			slipVo.setSlipSeq(tempSlipSeq);
		}

		return slipVo;
	}

	/* 지출결의 - 지출결의 항목 분개 수정 */
	public ExCommonResultVO ExSlipInfoUpdate ( ExExpendSlipVO slipVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExSlipInfoUpdate", slipVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 삭제 */
	public ExCommonResultVO ExSlipInfoDelete ( ExExpendSlipVO slipVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExSlipInfoDelete", slipVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 하위 내역 모두 삭제 */
	public ExCommonResultVO ExSlipDInfoDelete ( ExExpendSlipVO slipVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExSlipDInfoDelete", slipVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExSlipGridInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExSlipGridInfoSelect", slipVo );
		return result;
	}

	/* 지출결의 - 지출결의 항목 분개 조회 */
	public ExExpendSlipVO ExSlipInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		slipVo = (ExExpendSlipVO) select( "ExSlipInfoSelect", slipVo );
		return slipVo;
	}

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExExpendSlipVO> ExSlipListInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		slipListVo = (List<ExExpendSlipVO>) list( "ExSlipListInfoSelect", slipVo );

		return slipListVo;
	}

	/* 예산 */
	/* 예산 - 지출결의 임시예산 등록 연동 */
	public ExCommonResultVO ExSlipBudgetInfoUpdate ( ExExpendSlipVO slipVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExSlipBudgetInfoUpdate", slipVo ) > 0 ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		else {
			resultVo.setCode( commonCode.FAIL );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			resultVo.setMap( CommonConvert.CommonGetObjectToMap( slipVo ) );
		}
		return resultVo;
	}

	/* 인터페이스 */
	/* 인터페이스 - 법인카드 사용내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExExpendSlipVO> ExInterfaceCardListInfoSelect ( ExExpendVO expendVo ) throws Exception {
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		slipListVo = (List<ExExpendSlipVO>) list( "ExInterfaceCardListInfoSelect", expendVo );
		if ( slipListVo == null ) {
			slipListVo = new ArrayList<ExExpendSlipVO>( );
		}
		return slipListVo;
	}

	/* 인터페이스 - 매입전자세금계산서 사용내역 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<ExExpendSlipVO> ExInterfaceETaxListInfoSelect ( ExExpendVO expendVo ) throws Exception {
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		slipListVo = (List<ExExpendSlipVO>) list( "ExInterfaceETaxListInfoSelect", expendVo );
		if ( slipListVo == null ) {
			slipListVo = new ArrayList<ExExpendSlipVO>( );
		}
		return slipListVo;
	}

	/* 지출결의 첨부파일 생성 */
	public void ExSlipAttachInfoInsert ( ExAttachVO attachVo ) {
		insert( "ExAttachInfoInsert", attachVo );
	}

	/* 지출결의 기존 첨부파일 존재 확인 */
	public String ExSlipExistAttachInfoSelect ( ExAttachVO attachVo ) {
		String resultCount = CommonInterface.commonCode.EMPTYSTR;
		resultCount = (String) select( "ExExistAttachInfoSelect", attachVo );
		return resultCount;
	}

	/* 지출결의 첨부파일 아이디 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public List<String> ExSlipAttchFileIDInfoSelect ( Map<String, Object> params ) {
		List<String> fileIdList = new ArrayList<String>( );
		fileIdList = list( "ExAttachFileIDInfoSelect", params );
		return fileIdList;
	}

	/* 지출결의 기존 파일정보 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public List<ExAttachVO> ExSlipAttchInfoSelect ( Map<String, Object> parmas ) {
		List<ExAttachVO> atttachVoList = new ArrayList<ExAttachVO>( );
		atttachVoList = (List<ExAttachVO>) list( "ExAttchInfoSelect", parmas );
		return atttachVoList;
	}

	/* 지출결의 첨부파일 삭제 */
	public void ExLSlipAttachInfoDelete ( Map<String, Object> attachMap ) {
		update( "ExAttachFileInfoDelete", attachMap );
		delete( "ExExpendSlipAttachListInfoDelete", attachMap );
	}

	@SuppressWarnings ( "unchecked" )
	public List<ExExpendSlipVO> ExExpendSlipListSelect ( Map<String, Object> param ) {
		List<ExExpendSlipVO> slipList = new ArrayList<ExExpendSlipVO>( );
		slipList = list( "ExExpendSlipListSelect", param );
		return slipList;
	}

	/* 지출결의 종결문서 수정 시 카드 사용 내역 전송 여부 수정 */
	public ResultVO ExInterfaceCardInfoUpdate ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "ExInterfaceCardInfoUpdate", param );
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "연동정보 갱신에 실패하였습니다." );
		}
		return result;
	}

	/* 지출결의 종결문서 수정 시 매입전자세금계산서 사용 내역 전송 여부 수정 */
	public ResultVO ExInterfaceETaxInfoUpdate ( Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			update( "ExInterfaceETaxInfoUpdate", param );
			/* iCUBE인 경우 세금계산서  */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				if ( CommonConvert.CommonGetStr( param.get( "sendYN" ) ).equals( "N" ) ) {
					ResultVO resultVo = new ResultVO( );
					Map<String, Object> erpMap = new HashMap<String, Object>( );
					erpMap.put( "getFg", "0" );
					erpMap.put( "approState", "4" );
					erpMap.put( "erpCompSeq", param.get( "erpCompSeq" ).toString( ) );
					erpMap.put( "erpBizSeq", param.get( "erpBizSeq" ).toString( ) );
					erpMap.put( "issNo", param.get("issNo").toString( ) );
					erpMap.put( "issDt", param.get("issDt").toString( ) );
					erpMap.put( "docNo", "" );
					/* 추후 보완 예정 */
					erpMap.put( "issNo", param.get( "issNo" ).toString( ) );
					resultVo.setParams( erpMap );
					daoI.ExETaxInfoUpdate( resultVo, conVo );
				}
			}
			result.setResultCode( commonCode.SUCCESS );
		}
		catch ( Exception e ) {
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "연동정보 갱신에 실패하였습니다." );
		}
		return result;
	}

	/* 지출결의 - 해당 지출결의 분개 첨부파일 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendSlipAttachListInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = list( "ExExpendSlipAttachListInfoSelect", param );
		}
		catch ( Exception e ) {
			result = new ArrayList<Map<String, Object>>( );
		}
		return result;
	}

	/* 지출결의 - 해당 지출결의 분개 첨부파일 조회 */
	public boolean ExExpendSliptAttachListInfoDelete ( Map<String, Object> param ) throws Exception {
		boolean result = true;
		try {
			delete( "ExExpendSlipAttachListInfoDelete", param );
		}
		catch ( Exception e ) {
			result = false;
		}
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExExpendSlipETaxInfoSelect ( Map<String, Object> param) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "ExExpendSlipETaxInfoSelect", param );
		return result;
	}
}