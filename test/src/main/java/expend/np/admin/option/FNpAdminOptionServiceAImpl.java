package expend.np.admin.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundDataException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpAdminOptionServiceA" )
public class FNpAdminOptionServiceAImpl implements FNpAdminOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminOptionServiceADAO" )
	private FNpAdminOptionServiceADAO dao;

	/**
	 * ERP 환경설정 조회 - ERP전용 메서드.
	 */
	@Override
	public ResultVO selectERPOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		result.setFail( "ERP 전용 메소드 입니다." );
		return result;
	}

	/**
	 * GW 환경설정 조회
	 * 사용자 그룹웨어의 기본 설정들을 조회합니다.
	 * isNotEmpty formSeq -> 양식별 정보 조회
	 * isEmpty formSeq -> 전체 양식의 설정 조회
	 */
	@Override
	public ResultVO selectGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
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
		}
		catch ( Exception ex ) {
			result.setFail( "AP 서버 데이터 가공 실패", ex );
		}
		return result;
	}

	/**
	 * 공통옵션 [공통옵션 저장]
	 * params : {
	 * "formSeq" ["0"] - 문서번호
	 * , "optionGbn" ["common":공통, "cons":품의서, "res":결의서] - 옵션구분
	 * , "optionCode" ["001001"] - 옵션코드
	 * , "setValue" ["Y"] - 옵션 값
	 * , "setName" ["사용"] - 옵션 이름
	 * }
	 */
	@Override
	public ResultVO updateGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			if ( CommonConvert.CommonGetStr( CommonConvert.CommonGetStr(params.get( "formSeq" )) ).equals( "" ) ) {
				throw new NotFoundDataException( "formSeq" );
			}
			if ( CommonConvert.CommonGetStr( CommonConvert.CommonGetStr(params.get( "optionGbn" )) ).equals( "" ) ) {
				throw new NotFoundDataException( "optionGbn" );
			}
			if ( CommonConvert.CommonGetStr( CommonConvert.CommonGetStr(params.get( "optionCode" )) ).equals( "" ) ) {
				throw new NotFoundDataException( "optionCode" );
			}

			result = dao.NpGwCommonOptionUpdate( params );
		}
		catch ( NotFoundDataException ex ) {
			result.setFail( "필수 데이터가 존재하지 앖습니다. 찾을 수 없는 파라미터 : " + ex.getMessage( ), ex );
		}
		catch ( Exception ex ) {
			result.setFail( "AP 서버 데이터 가공 실패", ex );
		}
		return result;
	}
}
