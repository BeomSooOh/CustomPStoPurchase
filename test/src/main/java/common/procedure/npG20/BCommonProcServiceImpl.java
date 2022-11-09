package common.procedure.npG20;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.code.FNpUserCodeServiceADAO;
import expend.np.user.code.FNpUserCodeServiceUDAO;

@Service("BCommonProcService")
public class BCommonProcServiceImpl implements BCommonProcService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo;
	/* 변수정의 - DAO */
	@Resource(name = "BCommonProcG20DAO")
	private BCommonProcG20DAO dao;

	@Resource(name = "FNpUserCodeServiceADAO")
	private FNpUserCodeServiceADAO daoA;
	
	@Resource(name = "FNpUserCodeServiceUDAO")
	private FNpUserCodeServiceUDAO daoU;
	

	/* 
	 *	[G20] 프로시저 호출 
	 * */
	@Override
	public ResultVO getProcResult(Map<String, Object> params) throws Exception {
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
		return _getProcResult(params, conVo);
		
	}

	/* 
	 *	[G20] 프로시저 호출 
	 * */
	@Override
	public ResultVO getProcResult ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return _getProcResult(params, conVo);
	}
	
	/* iCUBE 거래처 등록 및 반환 */
	public Map<String, Object> setProcTrade(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		Map<String, Object> result = new HashMap<String, Object>();
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));

		/* 파라미터 정의 */
		params.put("erpEmpSeq", loginVo.getErpEmpCd());
		params.put("erpCompSeq", conVo.getErpCompSeq());
		
		/* 거래처 등록 및 조회 */
		result = dao.selectTrade(params, conVo);

		return result;
	}

	/* iCUBE 거래처 정보 조회 */
	public Map<String, Object> getProcTrade(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		Map<String, Object> result = new HashMap<String, Object>();
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));

		/* 파라미터 정의 */
		params.put("erpEmpSeq", loginVo.getErpEmpCd());
		params.put("erpCompSeq", conVo.getErpCompSeq());
		
		/* 거래처 등록 및 조회 */
		List<Map<String, Object>> resultList = dao.selectTradeInfo(params, conVo);
		
		if(resultList.size( ) == 0){
			return result;
		}else{
			result = resultList.get( 0 );
		}
		
		return result;
	}
	
	/* iCUBE 지급 거래처 정보 조회 (씨제이 나눔재단 커스터마이징)*/
	public Map<String, Object> getCustProcTrade(Map<String, Object> params) throws Exception {
		/* 변수정의 */
		Map<String, Object> result = new HashMap<String, Object>();
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));

		/* 파라미터 정의 */
		params.put("erpEmpSeq", loginVo.getErpEmpCd());
		params.put("erpCompSeq", conVo.getErpCompSeq());
		
		/* 거래처 등록 및 조회 */
		List<Map<String, Object>> resultList = dao.selectCustTradeInfo(params, conVo);
		
		if(resultList.size( ) == 0){
			return result;
		}else{
			result = resultList.get( 0 );
		}
		
		return result;
	}
	
	public ResultVO _getProcResult ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
 		ResultVO result = new ResultVO();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String codeType = "";
			if (params.get("procType") != null) {
				codeType = params.get("procType").toString().toUpperCase();
			} else {
				throw new Exception("호출 프로시저 타입을 알 수 없습니다.");
			}
			
			/* 2018. 05. 15 - 김상겸 */
			/* 사원검색의 경우 사원번호를 파라미터로 전달 시 사원선택의 범위가 제한되므로, codeType이 emp 인 경우는 별도 맵핑하지 않고 전달된 값을 그대로 사용한다. */
			if(codeType.equals("emp".toUpperCase())) {
				if(!params.containsKey("erpEmpSeq")) {
					/* 사원검색 필수 파라미터로, 값이 없는 경우 공백으로 생성한다. */
					params.put("erpEmpSeq", "");
				}
				params.put("erpCompSeq", conVo.getErpCompSeq());
			} else {
				params.put("erpEmpSeq", loginVo.getErpEmpCd());
				params.put("erpCompSeq", conVo.getErpCompSeq());
			}
			
			if (codeType.equals("gisuCloseCheck".toUpperCase())) {
				/* 기수 마감 정보 */
				result = dao.selectGisuCloseCheck(params, conVo);
				return result;
			} else if (codeType.equals("syscfg".toUpperCase())) {
				/* iCUBE 환경설정 */
				result = dao.selectSyscFg(params, conVo);
				return result;
			} else if (codeType.equals("emp".toUpperCase())) {
				/* 사원 */
				result = dao.selectEmpList(params, conVo);
				return result;
			} else if (codeType.equals("gisu".toUpperCase())) {
				/* 기수 */
				result = dao.selectGisuList(params, conVo);
				return result;
			} else if (codeType.equals("bank".toUpperCase())) {
				/* 금융기관 */
				result = dao.selectBankList(params, conVo);
				return result;
			} else if (codeType.equals("absdocuInfo".toUpperCase())) {
				result = dao.selectAbsdocuInfo(params, conVo);
				return result;
			} else if (codeType.equals("bottom".toUpperCase())) {
				result = dao.selectBottomList(params, conVo);
				return result;
			} else if (codeType.equals("bottom2".toUpperCase())) {
				result = dao.selectBottomList2(params, conVo);
				return result;
			} else if (codeType.equals("gisuInfo".toUpperCase())) {
				result = dao.selectGisuInfo(params, conVo);
				return result;
			} else if (codeType.equals("gisuForDate".toUpperCase())) {
				result = dao.selectGisuForDate(params, conVo);
				return result;
			} else if (codeType.equals("btr".toUpperCase())) {
				result = dao.selectBtrList(params, conVo);
				return result;
			} else if (codeType.equals("div".toUpperCase())) {
				result = dao.selectDivList(params, conVo);
				return result;
			} else if (codeType.equals("tr".toUpperCase()) || codeType.equals("btrtr".toUpperCase())) {
				result = dao.selectTrList(params, conVo);
				return result;
			} else if (codeType.equals("commonGisuInfo".toUpperCase())) {
				if(params.get("erpType").equals(commonCode.ICUBE)) {
					result = dao.selectCommonGisuInfo(params, conVo);	
				}
				else {
					result.setAaData(daoU.selectErpiUGisuInfo(params, conVo));
					for(Map<String,Object> gisuData : result.getAaData()) {
						if( Integer.valueOf(CommonConvert.NullToString(params.get("baseDate"))) <= Integer.valueOf(CommonConvert.NullToString(gisuData.get("DT_TO"))) ) {
							List<Map<String,Object>> gisuList = new ArrayList<Map<String,Object>>();
							Map<String,Object> gisuMap = new HashMap<String,Object>();
							gisuMap.put("gisuFromDate", gisuData.get("DT_FROM"));
							gisuMap.put("gisuToDate", gisuData.get("DT_TO"));
							gisuMap.put("erpGisu", 0);
							gisuList.add(gisuMap);
							result.setAaData(gisuList);
							break;
						}
					}
				}
				
				return result;
			} else if (codeType.equals("project".toUpperCase())) {
				/* 프로젝트 */
				result = dao.selectProjectList(params, conVo);
				return result;
			} else if (codeType.equals("project2".toUpperCase())) {
				/* 프로젝트 */
				result = dao.selectProjectList(params, conVo);
				return result;
			} else if (codeType.equals("dept".toUpperCase())) {
				/* 부서 */
				result = dao.selectDeptList(params, conVo);
				return result;
			} else if (codeType.equals("dept2".toUpperCase())) {
				/* 부서 */
				result = dao.selectDeptList(params, conVo);
				return result;
			} else if (codeType.equals("budget".toUpperCase())) {
				result = dao.selectBudgetInfo(params, conVo);
				return result;
			} else if (codeType.equals("cardSungin".toUpperCase())) {
				/* 카드 승인 내역 */
				result = dao.selectCardSunginList(params, conVo);
				return result;
			} else if (codeType.equals("erphpmeticlist".toUpperCase())) {
				/* 기타소득자 */
				result = dao.selectErpHpmeticList(params, conVo);
				return result;
			} else if (codeType.equals("erphincomeiclist".toUpperCase())) {
				/* 사업소득자 */
				result = dao.selectErpHincomeicList(params, conVo);
				return result;
			} else if (codeType.equals("budgetList".toUpperCase())) {
				if( !CommonConvert.NullToString( params.get("bottomSeq") ).isEmpty() ) {
					params.put("erpBottomSeq",params.get("bottomSeq") + "|");	
				}
				result = dao.selectBgtList(params, conVo);
				return result;
			} else if (codeType.equals("budgetName".toUpperCase())) {
				result = dao.selectBgtlabelList(params, conVo);
				return result;
			} else if (codeType.equals("income".toUpperCase())) {
				result = dao.selectIncomeList(params, conVo);
				return result;
			} else if (codeType.equals("card".toUpperCase())) {
				/* 카드 */
				params.put("compSeq", loginVo.getCompSeq());
				params.put("userSe", loginVo.getUserSe());
				params.put("empSeq", loginVo.getUniqId());
				params.put("deptSeq", loginVo.getOrgnztId( ));
				result = daoA.NpSelectCardInfoList(params);
				return result;
			} else if (codeType.equals("ctr".toUpperCase())) {
				/* 카드 거래처 */
				result = dao.selectCtrList(params, conVo);
				return result;
			} else if (codeType.equals( "yesil".toUpperCase( ) )){
				result = dao.selectYesil( params, conVo );
				for(int i=result.getAaData().size()-1;i>=0;i--) {
					if(result.getAaData().get(i).get("BGT_CD").equals("0000000000")) {
						result.getAaData().remove(i);
					}
				}
				return result;
			} else if (codeType.equals( "erpResAmt".toUpperCase( ) )){
				result = dao.selectERPResList( params, conVo );
				return result;
			} else if (codeType.equals( "tradeExists".toUpperCase( ) )){
				result = dao.selectTradeCodeExistsCheck( params, conVo );
				return result;
			} else if (codeType.equals( "tradeAutoTrSeq".toUpperCase( ) )){
				result = dao.selectTradeAutoTrSeq( params, conVo );
				return result;
			} else if (codeType.equals( "tradeInsert".toUpperCase( ) )){
				result = dao.insertTradeInfo( params, conVo );
				return result;
			} 
			throw new Exception("알 수 없는 프로시저 타입 : '" + codeType + "'");
		} catch (Exception ex) {
			result.setFail("프로시저 조회 실패", ex);
		}
		return result;
	}

	@Override
	public ResultVO getERPResListInfoSet ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		params.put("procType", "erpResAmt");
		result = this._getProcResult(params, conVo);
		
		List<Map<String, Object>> aaData = new ArrayList<>( );
		if(result.getResultCode( ).equals( commonCode.SUCCESS )){
			String erpKeyFilter = "";
			String erpCompSeq = "";
			for(Map<String, Object> item : result.getAaData( )){
				Map<String, Object> aData = new HashMap<String, Object>();
				aData.put( "erpCompSeq", nullToString(item.get( "CO_CD" ) ));
				aData.put( "erpKeyDispDt", nullToString(item.get( "DISP_DT" ) + "-" + nullToString(item.get( "DISP_SQ" ) ) ));
				aData.put( "erpKey", nullToString(item.get( "GISU_DT" ) + "-" + nullToString(item.get( "GISU_SQ" ) ) ));
				aData.put( "erpMgtName", nullToString(item.get( "MGT_NM" ) ));
				aData.put( "note", nullToString(item.get( "RMK_DC" ) ));			
				aData.put( "amt", nullToString(item.get( "UNIT_AM" ) ));				
				aData.put( "slipNum", nullToString(item.get( "ISU_DT" )) + "-" + nullToString(item.get( "ISU_SQ" ) ) );
				aData.put( "erpBudgetSeq", nullToString(item.get( "BGT_CD" ) ));
				aData.put( "erpBudgetName", nullToString(item.get( "BGT_NM" ) ));
				aaData.add( aData );
				
				erpKeyFilter += ", '" + nullToString(item.get( "GISU_DT" ) + "-" + nullToString(item.get( "GISU_SQ" ) ) ) + "'";
				erpCompSeq = nullToString(item.get( "CO_CD" ) );
			}
			erpKeyFilter = "(" + ( erpKeyFilter.length( ) == 0 ? "" : erpKeyFilter.substring( 1 )) + ")";
			Map<String, Object> aData = new HashMap<String, Object>();
			aData.put("erpDivSeq", CommonConvert.NullToString(params.get("erpDivSeq")).replace("|", "") );
			aData.put( "erpCompSeq", erpCompSeq );
			aData.put( "erpKeyFilter", erpKeyFilter );
			
			result.setAaData( aaData );
			result.setaData( aData );
		}else{
			result.setFail( "예산별 결의데이터 조회 실패" );
		}
		return result;
	}
	
	private String nullToString(Object o){
		if(o == null){
			return "";
		}else{
			return o.toString( );
		}
	}
}