package expend.np.admin.option;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpAdminOptionServiceU" )
public class FNpAdminOptionServiceUImpl implements FNpAdminOptionService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpAdminOptionServiceUDAO" )
	private FNpAdminOptionServiceUDAO dao;

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
				if ( result.getAaData( ).size( ) == 0 ) {
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
	 * GW 환경설정 변경
	 * 사용자 그룹웨어의 기본 설정들을 변경합니다.
	 */
	@Override
	public ResultVO updateGWOption ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = dao.NpGwCommonOptionUpdate( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				if ( result.getAaData( ).size( ) == 0 ) {
					
					/* 코드 데이터 재 조회 */
					result = dao.NpGwCommonOptionUpdate( params );
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
}
