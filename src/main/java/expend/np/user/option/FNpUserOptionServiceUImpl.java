package expend.np.user.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.exception.NotFoundLogicException;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserOptionServiceU" )
public class FNpUserOptionServiceUImpl implements FNpUserOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserOptionServiceUDAO" )
	private FNpUserOptionServiceUDAO dao;
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;

	@Override
	public Map<String, Object> npTest ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			result = dao.selectERPOption( params, conVo );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			result.setFail( "AP 서버 데이터 가공 실패", ex );
		}
		return result;
	}

	/**
	 * GW 환경설정 조회 - GW전용 메서드.
	 */
	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "GW 전용 메소드 입니다." );
		return result;
	}

	/**
	 * ERPiU 사용자 정보 조회
	 */
	@Override
	public ResultVO selectBaseData ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectUserBaseInfo( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "사용자 기본 정보(ERP iU) 조회 도중 오류가 발생하였습니다." );
		}
		return result;
	}

	@Override
	public ResultVO selectEaFormInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		throw new NotFoundLogicException( "전자결재 정보 조회 기능으로 BizboxA전용 로직입니다.", commonCode.ERPIU );
	}

	@Override
	public ResultVO selectAbgtInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.selectAbgtInfo( params, conVo );
		}
		catch ( Exception ex ) {
			result.setFail( "예산계정 정보(ERP iU) 조회 도중 오류가 발생하였습니다." );
		}
		return result;
	}

	@Override
	public ResultVO selectVatCtrData(Map<String, Object> params, ConnectionVO conVo) throws Exception {
		ResultVO result = new ResultVO();
		try {
			/* 예산통제 부가세 부가세 포함여부 조회 */
			result.setaData(dao.selectERPCertainOption(params, conVo));
			result.setSuccess();
		}
		catch (Exception ex) {
			result.setFail("ERPiU 원인행위 부가세 예산 포함여부 데이터 조회에 실패하였습니다.", ex);
		}
		return result;
	}

	@Override
	public ResultVO selectBasicOption ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "GW 전용 기능입니다." );
		return result;
	}
}