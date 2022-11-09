package expend.ex.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExCommonResultVO;
import expend.ex.user.code.BExUserCodeService;


@Service ( "BExUserEtaxService" )
public class BExUserEtaxServiceImpl implements BExUserEtaxService {

	/* 변수정의 - Service */
	@Resource ( name = "FExUserEtaxServiceAImpl" )
	private FExUserEtaxServiceAImpl codeA; /* Bizbox Alpha */
	@Resource ( name = "FExUserEtaxServiceIImpl" )
	private FExUserEtaxServiceIImpl codeI; /* ERP iCUBE */
	@Resource ( name = "FExUserEtaxServiceUImpl" )
	private FExUserEtaxServiceUImpl codeU; /* ERP iU */
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService commonCodeA;

	@Resource ( name = "FExUserEtaxServiceADAO" )
	private FExUserEtaxServiceADAO dao;

	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	@Override
	public List<ExCodeETaxVO> ExETaxListInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		List<ExCodeETaxVO> result = new ArrayList<ExCodeETaxVO>( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
				result = codeA.ExETaxListInfoSelect( etaxVo, conVo );
				// A 미사용
				break;
			case commonCode.ERPIU:
			        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
				result = codeU.ExETaxListInfoSelect( etaxVo, conVo );
				break;
			case commonCode.ICUBE:
				result = codeI.ExETaxListInfoSelect( etaxVo, conVo );
				break;
			default :
				break;
		}
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 조회 */
	@Override
    public ExCodeETaxVO ExETaxDetailInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		ExCodeETaxVO result = new ExCodeETaxVO( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
				result = codeA.ExETaxDetailInfoSelect( etaxVo, conVo );
				// A 미사용
				break;
			case commonCode.ERPIU:
				result = codeU.ExETaxDetailInfoSelect( etaxVo, conVo );
				break;
			case commonCode.ICUBE:
				result = codeI.ExETaxDetailInfoSelect( etaxVo, conVo );
				break;
			default :
				break;
		}
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
	@Override
    public ResultVO ExExpendETaxInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		ResultVO result = new ResultVO( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
				result = codeA.ExExpendETaxInfoMapUpdate( param, conVo, loginVo );
				// A 미사용
				break;
			case commonCode.ERPIU:
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
				result = codeU.ExExpendETaxInfoMapUpdate( param, conVo, loginVo );
				break;
			case commonCode.ICUBE:
				result = codeI.ExExpendETaxInfoMapUpdate( param, conVo, loginVo );
				break;
			default :
				break;
		}
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 항목 분개 처리 */
	@Override
	public ExCommonResultVO ExETaxInfoMake ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		ExCommonResultVO result = new ExCommonResultVO( );
		// Bizbox A 만 사용
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
			case commonCode.ERPIU:
			case commonCode.ICUBE:
				result = codeA.ExETaxInfoMake( param, conVo, loginVo );
				// Bizbox A만 사용
				break;
			default :
				break;
		}
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 상태값 수정 */
	@Override
	public ResultVO ExExpendETaxInfoUpdate ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
			case commonCode.ERPIU:
			case commonCode.ICUBE:
				result = codeA.ExExpendETaxInfoUpdate( etaxVo );
				// Bizbox A만 사용
				break;
			default :
				break;
		}
		return result;
	}

	/* 매입전자세금계산서 - 세금계산서 현황 리스트 조회 */
	@Override
    public ResultVO ExUserTtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> erpList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> gwList = new ArrayList<Map<String, Object>>( );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.BIZBOXA:
				erpList = codeA.ExUserTtaxReportList( param, conVo );
				break;
			case commonCode.ERPIU:
				erpList = codeU.ExUserTtaxReportList( param, conVo );
				break;
			case commonCode.ICUBE:
				/* iCUBE 사업장 정보 조회 후 파라미터에 추가*/ 
				Map<String, Object> tParam = new HashMap<String, Object>( );
				ResultVO tResult = new ResultVO( );
				tParam.put( commonCode.CODETYPE, commonCode.EMP );
				tParam.put( "searchStr", CommonConvert.CommonGetEmpVO( ).getErpEmpCd( ) );
				tResult = commonCodeA.ExCommonCodeInfoSelect( tParam );
				if ( tResult == null || tResult.getAaData( ) == null || tResult.getAaData( ).isEmpty( ) || CommonConvert.CommonGetStr( tResult.getAaData( ).get( 0 ).get( "erpBizSeq" ) ).equals( "" ) ) {
					param.setFail( "ERP 사번을 확인해주세요" );
					return param;
				}
				Map<String, Object> tEtaxParam = new LinkedHashMap<String, Object>( );
				tEtaxParam = CommonConvert.CommonSetMapCopy( param.getParams( ), tEtaxParam );
				//tEtaxParam.put( "bizplanCode", tResult.getAaData( ).get( 0 ).get( "erpBizSeq" ).toString( ) + "|" );
				tEtaxParam.put( "bizplanCode", "" );
				param.setParams( tEtaxParam );
				erpList = codeI.ExUserTtaxReportList( param, conVo );
				break;
			default :
				break;
		}
		/* 그룹웨어 데이터 조회 */
		if ( param.getParams( ).get( commonCode.COMPSEQ ) == null || param.getParams( ).get( commonCode.COMPSEQ ).equals( commonCode.COMPSEQ ) ) {
			Map<String, Object> tParam = param.getParams( );
			tParam.put( commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			param.setParams( tParam );
		}
		Map<String, Object> aData = new HashMap<String, Object>( );
		aData.put( "dataLength", erpList.size( ) );
		param.setaData( aData );
		/* 그룹웨어 세금계산서 정보 조회 */
		gwList = codeA.ExUserETaxExpendInfoSelect( param.getParams( ) );
		erpList.addAll( gwList );
		param.setAaData( erpList );
		return param;
	}

	/* 매입전자세금계산서 - 세금계산서 상세 정보 조회 */
	@Override
    public Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = codeA.ExExpendEtaxGWInfoSelect( param );
		return result;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 내역 지출결의 정보 초기화 */
	@Override
    public ExCommonResultVO ExExpendETaxInfoMapReset(Map<String, Object> param) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO();
		try {
			for (Map<String, Object> map : ConvertManager
					.ConvertJsonToListMap((String) param.get("target"))) {
				map = CommonConvert.CommonSetMapCopy(map, CommonConvert.CommonGetEmpInfo());
				dao.ExExpendETaxInfoMapReset(map);
			}
		} catch (Exception e) {
			resultVo.setCommonCode(commonCode.FAIL);
			resultVo.setCommonName("매입전자세금계산서 사용내역 초기화 오류");
		}
		return resultVo;
	}
}
