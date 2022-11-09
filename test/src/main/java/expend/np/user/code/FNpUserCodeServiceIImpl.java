package expend.np.user.code;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.exception.CheckErpVersionException;
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundLogicException;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserCodeServiceI" )
public class FNpUserCodeServiceIImpl implements FNpUserCodeService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserCodeServiceIDAO" )
	private FNpUserCodeServiceIDAO dao;

	/* 변수정의 - Service */
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService g20Proc; /* G20 프로시저 호출 서비스 */

	@Override
	public ResultVO GetCommonCode ( Map<String, Object> params, ConnectionVO conVo ) {
		ResultVO result = new ResultVO( );
		try {

			Map<String, Object> param = new HashMap<String, Object>( );
			param = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) );
			param.put( "langKind", CommonConvert.CommonGetEmpVO( ).getLangCode( ) );
			param.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			param.put("procType", CommonConvert.CommonGetStr( params.get( "code" ) ).toLowerCase( ) );
			result = g20Proc.getProcResult( param );

//			if ( code.equals( "test" ) ) {
//				/* 코드 - 테스트 코드 */
//				result.setAaData( dao.npTest( param, conVo ) );
//			}
//			else if ( code.equals( "Biz" ) ) {
//				/* 예산 사업장, 전표 사업장 조회 */
//				result.setAaData( dao.selectCommonBizCode(param, conVo) );
//			}
//			else if ( code.equals( "Emp" ) ) {
//				/* 사원 정보 코드 조회 */
//				result.setAaData( dao.selectCommonEmpCode( param, conVo ) );
//			}
//			else if ( code.equals( "Cause" ) ) {
//				/* 원인행위자 코드 조회 */
//				result.setAaData( dao.selectCommonCauseCode( param, conVo ) );
//			}
//			else if ( code.equals( "Dept" ) ) {
//				/* 부서 코드 조회 */
//				result.setAaData( dao.selectCommonDeptCode( param, conVo ) );
//			}
//			else if ( code.equals( "Project" ) ) {
//				/* 프로젝트 코드 조회 */
//				result.setAaData( dao.selectCommonProjectCode( param, conVo ) );
//			}
//			else if ( code.equals( "Btr" ) ) {
//				/* 입출금 계좌 코드 조회 */
//				result.setAaData( dao.selectCommonBtrCode( param, conVo ) );
//			}
//			else if ( code.equals( "Bgt" ) ) {
//				/* 예산과목 코드 조회 */
//				result.setAaData( dao.selectCommonBgtCode( params, conVo ) );
//			}
//			else if ( code.equals( "BgtLabel" ) ) {
//				/* 예산과목 레벨 사용자 명칭 조회 */
//				result.setAaData( dao.selectCommonBgtLabelCode( param, conVo ) );
//			}
//			else if ( code.equals( "Tr" ) ) {
//				/* 거래처 코드 조회 */
//				result.setAaData( dao.selectCommonTrCode( param, conVo ) );
//			}
//			else if ( code.equals( "Bank" ) ) {
//				/* 금융기관 코드 조회 */
//				result.setAaData( dao.selectCommonBankCode( param, conVo ) );
//			}
//			else if ( code.equals( "Card" ) ) {
//				/* 법인카드 승인내역 조회 */
//				throw new NotFoundLogicException( "카드 승인내역 조회 미구현", "G20" );
//			}
//			else if ( code.equals( "TrEmp" ) ) {
//				/* 사원 거래처 코드 조회 */
//				result.setAaData( dao.selectCommonTrEmpCode( param, conVo ) );
//			}
//			else if ( code.equals( "TrEtc" ) ) {
//				/* 기타 소득자 코드 조회 */
//				result.setAaData( dao.selectCommonTrEtcCode( param, conVo ) );
//			}
//			else if ( code.equals( "TrBus" ) ) {
//				/* 사업 소득자 코드 조회 */
//				result.setAaData( dao.selectCommonTrBusCode( param, conVo ) );
//			}
//			else {
//				/* 찾을 수 없는 공통코드 오류 리턴 */
//				throw new Exception("");
//			}
			result.setSuccess( );
		}
		catch (NotFoundDataException ex){
			result.setFail( "데이터 타입이 누락되었습니다.", ex );
		}
		catch (CheckErpVersionException ex){
			result.setFail( "GW와 ERP버전이 호환되지 않습니다. 관리자에게 문의하세요.", ex );
		}
		catch ( Exception ex ) {
			result.setFail( "code 확인 불가능.", ex );
		}
		return result;
	}

	@Override
	public ResultVO UpdateInterfaceInfo(Map<String, Object> params){
		return null;
	}
}
