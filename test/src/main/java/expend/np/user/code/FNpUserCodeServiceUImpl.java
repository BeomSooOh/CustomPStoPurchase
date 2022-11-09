package expend.np.user.code;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FNpUserCodeServiceU" )
public class FNpUserCodeServiceUImpl implements FNpUserCodeService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FNpUserCodeServiceUDAO" )
	private FNpUserCodeServiceUDAO dao;

	@Resource ( name = "FNpUserCodeServiceADAO" )
	private FNpUserCodeServiceADAO daoA;

	@Override
	public ResultVO GetCommonCode ( Map<String, Object> params, ConnectionVO conVo ) {
		ResultVO result = new ResultVO( );
		try {
			String code = "";
			if ( params.get( "code" ) != null ) {
				code = params.get( "code" ).toString( );
			}
			else {
				throw new Exception( "not found parameter 'code'" );
			}
			Map<String, Object> param = new HashMap<String, Object>( );
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			param = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) );
			param.put( "langKind", CommonConvert.CommonGetEmpVO( ).getLangCode( ) );
			param.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			param.put( "erpEmpSeq", CommonConvert.CommonGetEmpVO( ).getErpEmpCd( ));
//			param.put( "erpBizSeq", CommonConvert.CommonGetEmpVO( ).getErpBizCd( ));
//			param.put( "erpDeptSeq", CommonConvert.CommonGetEmpVO( ).getErpDeptCd( ));

			/* 코드 - 테스트 코드 */
			if ( code.equals( "test" ) ) {
				result.setAaData( dao.npTest( param, conVo ) );
			}
			else if ( code.equals( "authdept" ) ) {
				/* 권한 부서 조회 */
				result.setAaData( dao.selectCommonAuthDeptCode( param, conVo ) );
			}
			else if ( code.equals( "div" ) ) {
				result.setAaData( dao.selectCommonDivCode( param, conVo ) );
			}
			else if ( code.equals( "biz" ) ) {
				result.setAaData( dao.selectCommonBizCode( param, conVo ) );
			}
			else if ( code.equals( "dept" ) ) {
				/* 부서 정보 코드 조회 */
				result.setAaData( dao.selectCommonDeptCode( param, conVo ) );
			}
			else if ( code.equals( "emp" ) ) {
				/* 사원 정보 코드 조회 */
				result.setAaData( dao.selectCommonEmpCode( param, conVo ) );
			}
			else if ( code.equals( "project" ) ) {
				/* 프로젝트 코드 조회 */
			}
			else if ( code.equals( "btr" ) ) {
				/* 입출금 계좌 코드 조회 */
				result.setAaData( dao.selectCommonBtrCode( param, conVo ) );
			}
			else if ( code.equals( "budget" ) ) {
				/* 예산단위 코드 조회 */
				result.setAaData( dao.selectCommonBudgetCode( param, conVo ) );
			}
			else if ( code.equals( "bizplan" ) ) {
				/* 사업계획 코드 조회 */
				result.setAaData( dao.selectCommonBizplanCode( param, conVo ) );
			}
			else if ( code.equals( "bgacct" ) ) {
				/* 예산계정 코드 조회 */
				result.setAaData( dao.selectCommonBgacctCode( param, conVo ) );
			}
			else if ( code.equals( "bgacct2" ) ) {
				/* 예산계정 코드 조회 - ERPiU 예실대비 현황 전용*/
				param.put( "bgacctType", "A" );
				param.put( "grFg", "1|2" );
				result.setAaData( dao.selectCommonBgacctCode( param, conVo ) );
			}
			else if ( code.equals( "fiacct" ) ) {
				/* 회계계정 코드 조회 */
				result.setAaData( dao.selectCommonFiacctCode( param, conVo ) );
			}
			else if ( code.equals( "bgtlevel" ) ) {
				/* 예산단계 코드 조회 */
				result.setAaData( dao.selectCommonBgtLevelCode( param, conVo ) );
			}
			else if ( code.equals( "bgtinfo" ) ) {
				/* 예산과목 코드 상세정보 조회 */
				result.setAaData( dao.selectCommonBgtInfoCode( param, conVo ) );
			}
			else if ( code.equals( "div" ) ) {
				/* 예산과목 코드 조회  */
				// result.setAaData( dao.selectCommonBgtCode( param, conVo ) );
			}
			else if ( code.equals( "bgtlabel" ) ) {
				/* 예산과목 레벨 사용자 명칭 조회 */
			}
			else if ( code.equals( "tr" ) ) {
				/* 거래처 코드 조회 */
				result.setAaData( dao.selectCommonTrCode( param, conVo ) );
			}
			else if ( code.equals( "trAdv" ) ) {
				/* 거래처 추가정보 조회 */
				result = dao.selectCommonTrAdvCode( param, conVo ) ;
			}
			else if ( code.equals( "bank" ) ) {
				/* 금융기관 코드 조회 */
				result.setAaData( dao.selectCommonBankCode( param, conVo ) );
			}
			else if ( code.equals( "card" ) ) {
				/* 신용카드 코드 조회 */
				params.put( "compSeq", loginVo.getCompSeq( ) );
				params.put( "userSe", loginVo.getUserSe( ) );
				params.put( "empSeq", loginVo.getUniqId( ) );
				params.put( "deptSeq", loginVo.getOrgnztId( ) );
				result = daoA.NpSelectCardInfoList( params );
				//result.setAaData( dao.selectCommonCardCode( param, conVo ) );
			}
			else if ( code.equals( "cardnum" ) ) {
				/* 신용카드 코드 조회 */
				params.put( "compSeq", loginVo.getCompSeq( ) );
				params.put( "userSe", loginVo.getUserSe( ) );
				params.put( "empSeq", loginVo.getUniqId( ) );
				params.put( "deptSeq", loginVo.getOrgnztId( ) );
				result = daoA.NpSelectCardInfoList( params );
				//result.setAaData( dao.selectCommonCardCode( param, conVo ) );
			}
			else if ( code.equals( "tremp" ) ) {
				/* 사원 거래처 코드 조회 */
			}
			else if ( code.equals( "tretc" ) ) {
				/* 기타 소득자 코드 조회 */
				result.setAaData( dao.selectCommonTrEtcCode( param, conVo ) );
			}
			else if ( code.equals( "trbus" ) ) {
				/* 사업 소득자 코드 조회 */
				result.setAaData( dao.selectCommonTrBusCode( param, conVo ) );
			}
			else if ( code.equals( "trgroup" ) ) {
				/* 거래처 그룹 코드 조회 */
				result.setAaData( dao.selectCommonTrGroup( param, conVo ) );
			}
			else if ( code.equals( "trgroup2" ) ) {
				/* 거래처 그룹2 코드 조회 */
				result.setAaData( dao.selectCommonTrGroup2( param, conVo ) );
			}
			else if ( code.equals( "incomegbn" ) ) {
				/* 소득구분 코드 조회 */
				result.setAaData( dao.selectCommonIncomeGbn( param, conVo ) );
			}
			else if ( code.equals( "notax" ) ) {
				/* 소득구분 코드 조회 */
				result.setAaData( dao.selectCommonNoTax( param, conVo ) );
			}
			else if ( code.equals( "dept2" ) ){
				/* 부서 정보 코드 조회 - 예실대비 현황 용*/
				result.setAaData( dao.selectCommonDeptCode2( param, conVo ) );
			}
			else if (code.equals( "gisu" ) ){
				/* iU 회계 기수 정보 조회 */
				result.setAaData( dao.selectErpiUGisuInfo( param, conVo ) );
			}
			else if (code.equals( "banb" ) ){
				/* iU 회계 기수 정보 조회 */
				result.setAaData( dao.selectErpiUDepositNo( param, conVo ) );
			}
			else {
				/* 찾을 수 없는 공통코드 오류 리턴 */
			}
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
