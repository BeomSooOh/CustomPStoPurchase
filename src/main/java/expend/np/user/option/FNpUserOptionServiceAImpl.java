package expend.np.user.option;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserOptionServiceA" )
public class FNpUserOptionServiceAImpl implements FNpUserOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserOptionServiceADAO" )
	private FNpUserOptionServiceADAO dao;

	@Override
	public Map<String, Object> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * ERP 환경설정 조회 - ERP전용 메서드.
	 */
	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "ERP 전용 메소드 입니다." );
		return result;
	}

	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		ResultVO returnData = new ResultVO( );
		/* DATA 복사등 데이터 가공 진행 해야 함. */
		try {
			result = dao.NpGwCommonOptionSelect( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				if ( result.getAaData( ).size( ) == 0 || CommonConvert.CommonGetStr(result.getAaData( ).get( 0 ).get( "optionMatch" )).equals( "0" )) {
					/* 데이터 복사 진행 */
					dao.NpGwCommonOptionInsert( params );
					/* 코드 데이터 재 조회 */
					result = dao.NpGwCommonOptionSelect( params );
					if ( (CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS )) && (result.getAaData( ).size( ) == 0) ) {
						throw new Exception( "비영리 양식코드 기초 데이터 확인이 필요합니다." );
					}
				}
			}

			/* 옵션 리스트에서 cust 데이터 분리 작업 진행 */
			ArrayList<Map<String, Object>> aaData = new ArrayList<>( );
			Map<String, Object> aData = new HashMap<>( );
			for(Map<String, Object> item : result.getAaData( )){
				if(CommonConvert.CommonGetStr(item.get( "optionProcessType" )).equals( "cust" )){
					aData = item;
				}else {
					aaData.add( item );
				}
			}
			returnData.setaData( aData);
			returnData.setAaData( aaData );
			returnData.setSuccess( );
		}
		catch ( Exception ex ) {
			returnData.setFail( "AP 서버 데이터 가공 실패", ex );
		}
		return returnData;
	}

	@Override
	public ResultVO selectBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new NotFoundLogicException( "iCUBE와 iU만 지원하는 메소드 입니다.", "BizboxA" );
	}

	/**
	 * GW 환경설정 조회
	 * 사용자 그룹웨어의 양식 정보들을 조회합니다.
	 */
	@Override
	public ResultVO selectEaFormInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		try {
			if ( loginVo.getEaType( ).equals( "ea" ) ) {
				result = dao.NpGwEaFormInfoSelect( params );
			}
			else if ( loginVo.getEaType( ).equals( "eap" ) ) {
				result = dao.NpGwEapFormInfoSelect( params );
			}
			else {
				throw new NotFoundLogicException( "전자결재 모듈 정보를 확인 불가합니다. [ea, eap]", "BizboxA" );
			}
		}
		catch ( NotFoundLogicException ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		catch ( Exception ex ) {
			result.setFail( "전자결재 양식정보 확인중 오류 발생.", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectAbgtInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		/* 자체예산 기능 개발에 추가 바람. */
		return null;
	}

	@Override
	public ResultVO selectVatCtrData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectBasicOption ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectBasicOption( params );
		} catch ( Exception ex ) {
			result.setFail( "품의 결의 기본옵션 조회 중 오류 발생.", ex );
		}
		return result;
	}


}
