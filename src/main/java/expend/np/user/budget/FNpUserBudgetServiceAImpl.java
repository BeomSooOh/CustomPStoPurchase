package expend.np.user.budget;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.MapUtil;
import common.vo.common.CommonInterface.commonCode;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.code.FNpUserCodeServiceUDAO;


@Service ( "FNpUserBudgetServiceA" )
public class FNpUserBudgetServiceAImpl implements FNpUserBudgetService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserBudgetServiceADAO" )
	private FNpUserBudgetServiceADAO daoA;
	@Resource ( name = "FNpUserCodeServiceUDAO" )
	private FNpUserCodeServiceUDAO dao;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Override
	public ResultVO selectERPBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new Exception( "예산 조회 기능으로 ERP전용 기능입니다." );
	}

	/**
	 * 품의서 잔액 조회
	 */
	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				ResultVO gisuResult = new ResultVO();
				gisuResult.setAaData(dao.selectErpiUGisuInfo(params, conVo));
				int date = 0;

				if(params.get("resDate")!=null||params.get("consDate")!=null) {
					if(params.get("resDate")!=null) {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("resDate")));
					} else {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("consDate")));
					}
					for(int i=0;i<gisuResult.getAaData().size() ;i++) {
						Map<String, Object> gisuData = gisuResult.getAaData().get(i);
						if( date <= Integer.valueOf(CommonConvert.NullToString(gisuData.get("DT_TO"))) ) {
							params.put("gisuFromDate", gisuData.get("DT_FROM"));
							params.put("gisuToDate", gisuData.get("DT_TO"));
							break;
						}
					}
				}
			}

			result = daoA.selectConsBudgetBalance( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의서 잔액 조회
	 */
	@Override
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				ResultVO gisuResult = new ResultVO();
				gisuResult.setAaData(dao.selectErpiUGisuInfo(params, conVo));
				int date = 0;

				if(params.get("resDate")!=null||params.get("consDate")!=null) {
					if(params.get("resDate")!=null) {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("resDate")));
					} else {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("consDate")));
					}
					for(int i=0;i<gisuResult.getAaData().size() ;i++) {
						Map<String, Object> gisuData = gisuResult.getAaData().get(i);
						if( date <= Integer.valueOf(CommonConvert.NullToString(gisuData.get("DT_TO"))) ) {
							params.put("gisuFromDate", gisuData.get("DT_FROM"));
							params.put("gisuToDate", gisuData.get("DT_TO"));
							break;
						}
					}
				}
			}

			result = daoA.selectConsBudgetBalance( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 예산별 미전송 결의액 조회
	 */
	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				ResultVO gisuResult = new ResultVO();
				gisuResult.setAaData(dao.selectErpiUGisuInfo(params, conVo));
				int date = 0;
				if(params.get("resDate")!=null||params.get("consDate")!=null) {
					if(params.get("resDate")!=null) {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("resDate")));
					} else {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("consDate")));
					}
					for(int i=0;i<gisuResult.getAaData().size() ;i++) {
						Map<String, Object> gisuData = gisuResult.getAaData().get(i);
						if( date <= Integer.valueOf(CommonConvert.NullToString(gisuData.get("DT_TO"))) ) {
							params.put("gisuFromDate", gisuData.get("DT_FROM"));
							params.put("gisuToDate", gisuData.get("DT_TO"));
							break;
						}
					}
				}
			}

			result = daoA.selectResUseAmt( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 예산별 미전송 결의액 조회
	 */
	@Override
	public ResultVO selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {

			if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				ResultVO gisuResult = new ResultVO();
				gisuResult.setAaData(dao.selectErpiUGisuInfo(params, conVo));
				int date = 0;
				if(params.get("resDate")!=null||params.get("consDate")!=null) {
					if(params.get("resDate")!=null) {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("resDate")));
					} else {
						date = Integer.valueOf(CommonConvert.NullToString(params.get("consDate")));
					}
					for(int i=0;i<gisuResult.getAaData().size() ;i++) {
						Map<String, Object> gisuData = gisuResult.getAaData().get(i);
						if( date <= Integer.valueOf(CommonConvert.NullToString(gisuData.get("DT_TO"))) ) {
							params.put("gisuFromDate", gisuData.get("DT_FROM"));
							params.put("gisuToDate", gisuData.get("DT_TO"));
							break;
						}
					}
				}
			}

			result = daoA.selectResUseAmt( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의서 잔액 조회 [예실대비 현황]
	 */
	@Override
	public ResultVO selectConsBudgetBalanceForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = daoA.selectConsBudgetBalanceForYesil( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 예산별 미전송 결의액 조회 [예실대비 현황]
	 */
	@Override
	public ResultVO selectResUseAmtForYesil ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = daoA.selectResUseAmtForYesil( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 품의서 품의액 조회
	 */
	@Override
	public ResultVO selectConsAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "consDocSeq", "Y", "consSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = daoA.selectConsAmt( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 결의서 결의액 조회
	 */
	@Override
	public ResultVO selectResAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "resDocSeq", "Y", "resSeq", "N" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = daoA.selectResAmt( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectTryAmt ( Map<String, Object> params ) throws Exception {

		ResultVO result = new ResultVO( );
		try {
			if ( params.get( "consDocSeq" ) != null ) {
				result = daoA.selectConsTryAmt( params );
			}
			else if ( params.get( "resDocSeq" ) != null ) {
				result = daoA.selectResTryAmt( params );
			}
			else {
				result.setFail( "문서키(doc seq)가 누락되었음." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산 사용금 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( ( params.get( "consDocSeq" ) != null ) && ( !params.get( "consDocSeq" ).equals( "-1" ) )  ) {
				result = daoA.selectConsTryAmt( params, conVo );
			}
			else if ( ( params.get( "resDocSeq" ) != null ) && ( !params.get( "resDocSeq" ).equals( "-1" ) ) ) {
				result = daoA.selectResTryAmt( params, conVo );
			}
			else {
				Map tryAmt = new HashMap<String,Object>( );
				tryAmt.put( "tryAmt", "0" );
				result.setaData( tryAmt );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산 사용금 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferTryAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( ( params.get( "resDocSeq" ) != null ) && ( !params.get( "resDocSeq" ).equals( "-1" ) ) ) {
				result = daoA.selectConfferTryAmt( params, conVo );
			}
			else {
				Map tryAmt = new HashMap<String,Object>( );
				tryAmt.put( "tryAmt", "0" );
				result.setaData( tryAmt );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산 사용금 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferTryAmt ( Map<String, Object> params ) throws Exception {

		ResultVO result = new ResultVO( );
		try {

			if ( params.get( "resDocSeq" ) != null ) {
				result = daoA.selectConfferTryAmt( params );
			}
			else {
				result.setFail( "문서키(doc seq)가 누락되었음." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산 사용금 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferBudgetBalanceAmt ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String[] key = { "confferDocSeq", "Y", "confferSeq", "Y", "confferBudgetSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다." );
			}
			else {
				result = daoA.selectConfferBudgetBalanceAmt( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = daoA.selectConfferBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConfferBudgetInfo(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = daoA.updateConfferBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "품의 거래처 업데이트에 실패하였습니다.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectItemAmt(Map<String, Object> params, ConnectionVO conVo) {
		ResultVO result = new ResultVO( );
		try {
			if ( ( params.get( "consDocSeq" ) != null ) && ( !params.get( "consDocSeq" ).equals( "-1" ) )  ) {
				result = daoA.selectConsItemAmt( params, conVo );
			}
			else if ( ( params.get( "resDocSeq" ) != null ) && ( !params.get( "resDocSeq" ).equals( "-1" ) ) ) {
				result = daoA.selectResItemAmt( params, conVo );
			}
			else {
				Map itemAmt = new HashMap<String,Object>( );
				itemAmt.put( "itemAmt", "0" );
				result.setaData( itemAmt );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "예산 사용금 조회에 실패하였습니다.", ex );
		}
		return result;
	}


}
