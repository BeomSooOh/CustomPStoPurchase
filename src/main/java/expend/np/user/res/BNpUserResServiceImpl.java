package expend.np.user.res;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import java.util.regex.Pattern;

import javax.annotation.Resource;

//import org.junit.Assert;
import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.option.BNpUserOptionService;
//import neos.cmm.encrypt.AESEncryptor;
//import neos.cmm.util.code.CommonCode;


@Service ( "BNpUserResService" )
public class BNpUserResServiceImpl implements BNpUserResService {

	@Resource ( name = "FNpUserResServiceA" )
	private FNpUserResService resA;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption;
	@Resource ( name = "BNpUserBudgetService" )
	private BNpUserBudgetService serviceBudget;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService serviceCommonProc;
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService userServiceOption; /* Expend Service */
	@Resource(name = "BNpUserCodeService")
	private BNpUserCodeService		codeService;
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource(name = "CommonLogger")
	private final CommonLogger cmLog	= new CommonLogger();

	public Map<String, Object> setAdvParams ( Map<String, Object> params ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		if ( loginVo == null ) {
			throw new NotFoundLoginSessionException( "login 정보를 찾을 수 없습니다." );
		}
		params.put( "empSeq", loginVo.getUniqId( ) );
		params.put( "empName", CommonConvert.CommonGetStr( loginVo.getEmpname( ) ) );
		if ( params.get( "empName" ) == null || params.get( "empName" ).toString( ).equals( "" ) ) {
			params.put( "empName", loginVo.getName( ) );
		}
		params.put( "compSeq", loginVo.getCompSeq( ) );
		params.put( "compName", loginVo.getOrganNm( ) );
		params.put( "deptSeq", loginVo.getOrgnztId());
		params.put( "deptName", loginVo.getDeptname( ) );
		if ( params.get( "deptName" ) == null || params.get( "deptName" ).toString( ).equals( "" ) ) {
			params.put( "deptName", loginVo.getOrgnztNm( ) );
		}
		if(CommonConvert.NullToString( params.get( "erpCompSeq" ) ).equals( commonCode.EMPTYSTR ) ){
			params.put( "erpCompSeq", loginVo.getErpCoCd( ) );	
		}
		params.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
		return params;
	}

	@Override
	public ResultVO insertResDoc ( Map<String, Object> params ) throws Exception {
		/* 결의 문서 최초 생성 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.insertResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResConfferInfo ( Map<String, Object> params ) throws Exception {
		/* 결의 문서 참조 품의 반영 */
		ResultVO result = new ResultVO( );
		try {
			/* 참조품의 데이터 이관 */
			params = this.setAdvParams( params );
			result = resA.updateResConfferInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = this.selectResAllInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO insertResHead ( Map<String, Object> params ) throws Exception {
		/* 결의서 생성 */
		ResultVO result = new ResultVO( );
		try {
			
			/*  iCUBE의 경우 기수 마감 정보 조회  */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
				/* 결의서 예산 마감 여부 상태 확인 */
				params.put( "procType", "gisuCloseCheck" );
				result = serviceCommonProc.getProcResult( params, conVo );
				if(result.getResultCode( ).equals( commonCode.FAIL )){
					return result;
				}else{
					if(result.getAaData( ).size( ) != 0){
						if(CommonConvert.NullToString( result.getAaData( ).get( 0 ).get( "closeYn" ) ).equals( "1" )){
							result.setResultName( "기수가 마감되어 결의서를 작성할 수 없습니다." );
							result.setResultCode( "GISU_CLOSE" );
							return result;
						}
					}
				}
			}
			
			/* 결의서 생성 */
			params = this.setAdvParams( params );
			result = resA.insertResHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO insertResBudget ( Map<String, Object> params ) throws Exception {
		/* 결의예산 생성 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			String reqAmt = params.get( "budgetAmt" ).toString( );
			/*
			 * 참조품의 정보 없는 경우 결의 추가 예산인지 판단필요.
			 * 참조품의 결의서의 경우 파라미터 정보 보정
			 * 일반 결의서 예산추가의 경우 해당 없음.
			 */
			if ( params.get( "confferSeq" ) == null || CommonConvert.CommonGetStr(params.get( "confferSeq" )).equals("")) {
				/* 이전예산 정보 조회 */
				ResultVO confferInfoResult = resA.selectConfferBudgetInfo( params );
				Map<String, Object> confferInfoMap = confferInfoResult.getaData( );
				if ( (confferInfoMap != null) && (confferInfoMap.get( "isConffer" ) != null) && (confferInfoMap.get( "isConffer" ) != "N") ) {
					params.put( "confferDocSeq", confferInfoMap.get( "confferDocSeq" ).toString( ) );
					params.put( "confferSeq", confferInfoMap.get( "confferSeq" ).toString( ) );
					params.put( "confferBudgetSeq", confferInfoMap.get( "confferBudgetSeq" ).toString( ) );
				}
			}
			double resDocAllAmt = 0;
			ResultVO groupbudgetInfo = resA.selectGroupBudgetInfo( params );
			if(!groupbudgetInfo.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception( groupbudgetInfo.getErrorCode( ) );
			}
			String confferConsAmt =  this.nullToDouble(params.get( "confferBalanceAmt" ));
			if(params.get( "ctlFgCode" ).equals( "1" )){
				reqAmt = params.get( "budgetAmt" ).toString( );
				String budgetAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetAmt );
				params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetAmt ) );
			}else {
				reqAmt = params.get( "budgetStdAmt" ).toString( );
				String budgetStdAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetStdAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetStdAmt );
				params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetStdAmt ) );
			}
			params.put( "resDocAllAmt", resDocAllAmt );
			params.put( "amt", reqAmt );
			
			/* !!!! 예산 생성 가능 여부 확인 */
			ResultVO bgtResult = this.selectResBudgetBalance( params );
			if ( bgtResult.getResultName( ).equals( commonCode.CANBGT ) ) {
				/* 예산 생성 */
				result = resA.insertResBudget( params );
			}
			else {
				result.setaData( bgtResult.getaData( ) );
				result.setResultCode( commonCode.EXCEED );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConfferBudgetInfo ( Map<String, Object> params ) throws Exception {
		/* 결의문서 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectConfferBudgetInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO insertResTrade ( Map<String, Object> params ) throws Exception {
		/* 결의 거래처 생성 */
		ResultVO result = new ResultVO( );
		Map<String, Object> tradeInfo = null;
		try {
			
			/* 채주 정보 특수문자 컨버팅 */
			String tBtrName = CommonConvert.NullToString( params.get( "btrName" ) ).replace( "'", "`" );
			String tCeoName = CommonConvert.NullToString( params.get( "ceoName" ) ).replace( "'", "`" );
			String tDepositor = CommonConvert.NullToString( params.get( "depositor" ) ).replace( "'", "`" );
			String tTrName = CommonConvert.NullToString( params.get( "trName" ) ).replace( "'", "`" );
			params.put( "btrName",  tBtrName);
			params.put( "ceoName",  tCeoName);
			params.put( "depositor",  tDepositor);
			params.put( "trName", tTrName);
			
			// 자기 자신을 제외한 품의잔액 조회
			params = this.setAdvParams( params );
			String reqAmt = "0";
			double resDocAllAmt = 0;
			ResultVO groupbudgetInfo = resA.selectGroupBudgetInfo( params );
			if(!groupbudgetInfo.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception( groupbudgetInfo.getErrorCode( ) );
			}
			
			String confferConsAmt =  this.nullToDouble(params.get( "confferBalanceAmt" ));
			if(params.get( "ctlFgCode" ).equals( "1" )){
				reqAmt = params.get( "tradeAmt" ).toString( );
				String budgetAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetAmt ); 
				//params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetAmt ) );
			}else {
				reqAmt = params.get( "tradeStdAmt" ).toString( );
				String budgetStdAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetStdAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetStdAmt );
				//params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetStdAmt ) );
			}
			params.put( "resDocAllAmt", resDocAllAmt );
			
			if(params.get("confferDocSeq")==null || params.get("confferDocSeq").equals("")) {
				params.put( "amt", resDocAllAmt + Double.parseDouble(reqAmt) );
			}
			else {
				params.put( "amt", reqAmt );		
			}
			
			ResultVO bgtResult = this.selectResBudgetBalance( params );
			if ( bgtResult.getResultName( ).equals( commonCode.CANBGT ) ) {
				/* iCUBE 거래처 자동생성 프로세스 적용 */
				/* Step1. iCUBE를 연동하여 사용하는 가? */
				LoginVO loginVo = CommonConvert.CommonGetEmpVO();
				ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
				if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
					/* Step2. 결제수단이 전달되었는가? [ setFgCode ] */
					/* - 결제수단에 별도로 조건을 두지 않는다. */
					/* - 카드 내역이든 일반이든, 세금계산서든 상관하지 않는다 ( 기타도 프로세스 수행이 가능해진다. ) */
					if (params.containsKey("setFgCode") && !(CommonConvert.CommonGetStr(params.get("setFgCode")).equals(""))) {
						/* Step3. 거래처 코드가 존재하지 않는가? [ trSeq ] */
						/* - 거래처 코드가 존재하는 경우 거래처를 생성할 필요가 없으므로 거래처 코드가 존재하지 않는지 점검한다. */
						if (params.containsKey("trSeq") && CommonConvert.CommonGetStr(params.get("trSeq")).equals("")) {
							/* Step4. 사업자 등록번호가 존재하는가? [ businessNb ] */
							/* - 사업자 등록번호가 존재해야지만 거래처 생성이 가능하므로, 사업자 등록번호가 없는 경우에는 거래처 생성 프로세스를 수행하지 않는다. */
							if (params.containsKey("businessNb") && !(CommonConvert.CommonGetStr(params.get("businessNb")).equals(""))) {
								
								/* Step5-1 iCUBE G20 연동 고객이면서 거래처 연동 옵션이 켜져 있는 경우 
								 * ERPiU serviceOption.selectBasicOptionCreateTr 서비스 조회시 무조건 사용으로 반환
								 * */
								ResultVO createTrOptionResult = serviceOption.selectBasicOptionCreateTr(params, conVo);
								if(  CommonConvert.NullToString( createTrOptionResult.getaData( ).get( "value" ) ).equals( "0" ) ){
									Map<String, Object> tradeParam = new HashMap<String, Object>( );
									tradeParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
									tradeParam.put( "trName", (params.containsKey( "trName" ) ? CommonConvert.CommonGetStr( params.get( "trName" ) ) : "") );
									tradeParam.put( "trRegNb", (params.containsKey( "businessNb" ) ? CommonConvert.CommonGetStr( params.get( "businessNb" ) ) : "") );
									tradeParam.put( "ceoName", (params.containsKey( "ceoName" ) ? CommonConvert.CommonGetStr( params.get( "ceoName" ) ) : "") );
									tradeParam.put( "tel", "" );
									tradeParam.put( "zip", "" );
									tradeParam.put( "addr1", "" );
									tradeParam.put( "addr2", "" );
									tradeParam.put("payTrSeq", CommonConvert.NullToString(params.get("payTrSeq")));
									tradeInfo = serviceCommonProc.setProcTrade( tradeParam );
									
									if (tradeInfo.containsKey("trSeq")) {
										if (CommonConvert.CommonGetStr(tradeInfo.get("trSeq")).equals("")) {
											tradeInfo = null;
										}
									}
									else {
										tradeInfo = null;
									}
								} else {
									/* Step5 iCUBE G20 연동 고객이면서 거래처 연동 옵션이 미사용 경우 
									 * */
									Map<String, Object> tradeParam = new HashMap<String, Object>( );
									tradeParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
									tradeParam.put( "trRegNb", (params.containsKey( "businessNb" ) ? CommonConvert.CommonGetStr( params.get( "businessNb" ) ) : "") );
									tradeParam.put("payTrSeq", CommonConvert.NullToString(params.get("payTrSeq")));
									tradeInfo = serviceCommonProc.getProcTrade( tradeParam ); 
									if ( ( tradeInfo != null ) && tradeInfo.containsKey("trSeq")) {
										if (CommonConvert.CommonGetStr(tradeInfo.get("trSeq")).equals("")) {
											tradeInfo = null;
										}
									}
									else {
										if(!CommonConvert.NullToString(params.get("payTrSeq")).equals("")) {
											tradeInfo = serviceCommonProc.getCustProcTrade( tradeParam );	
										}
										else {
											tradeInfo = null;	
										}
									}
								}
							}
						}
					}
				} else if (conVo.getErpTypeCode().equals(commonCode.ERPIU)){
					/* - 거래처 코드가 존재하는 경우 거래처 추가조회를 할 필요가 없으므로 거래처 코드가 존재하지 않는지 점검한다. */
					if (params.containsKey("trSeq") && CommonConvert.CommonGetStr(params.get("trSeq")).equals("")) {
						/* Step4. 사업자 등록번호가 존재하는가? [ businessNb ] */
						/* - 사업자 등록번호가 존재해야지만 거래처 생성이 가능하므로, 사업자 등록번호가 없는 경우에는 거래처 추가조회 프로세스를 수행하지 않는다. */
						if (params.containsKey("businessNb") && !(CommonConvert.CommonGetStr(params.get("businessNb")).equals(""))) {
							/* ERPiU 거래처 정보 자동 조회 기능 추가 */
							Map<String, Object> tradeParam = new HashMap<String, Object>( );
							tradeParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
							tradeParam.put( "trRegNb", (params.containsKey( "businessNb" ) ? CommonConvert.CommonGetStr( params.get( "businessNb" ) ) : "") );
							ResultVO tradeAdvResult = codeService.GetTradeAdvInfo(tradeParam);
							if(!tradeAdvResult.getResultCode( ).equals( commonCode.SUCCESS )){
								tradeInfo = null;
							}else{
								tradeInfo = tradeAdvResult.getaData( );
							}
						}
					}
				}
				if ( tradeInfo != null ) {
					/* 신규 생성된 거래처 또는 조회된 거래처 정보 반영 */
					params.put( "trSeq", CommonConvert.CommonGetStr( tradeInfo.get( "trSeq" ) ) );
					params.put( "trFgCode", CommonConvert.CommonGetStr( tradeInfo.get( "trFgCode" ) ) );
					params.put( "trFgName", CommonConvert.CommonGetStr( tradeInfo.get( "trFgName" ) ) );
					params.put( "businessNb", CommonConvert.CommonGetStr( tradeInfo.get( "businessNb" ) ) );
					params.put( "ceoName", CommonConvert.CommonGetStr( tradeInfo.get( "ceoName" ) ) );
					params.put( "depositno", CommonConvert.CommonGetStr( tradeInfo.get( "depositNo" ) ) );
					params.put( "addr", CommonConvert.CommonGetStr( tradeInfo.get( "addr" ) ) );

					if( CommonConvert.CommonGetStr( params.get( "ctrSeq" ) ).equals( "" )) {
						params.put( "ctrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "jiroSeq" ) ) );
					}else if(CommonConvert.CommonGetStr( params.get( "ctrName" ) ).equals( "" )) {
						params.put( "ctrName", CommonConvert.CommonGetStr( tradeInfo.get( "jiroName" ) ) );
					}
					
					if(!CommonConvert.NullToString(params.get("payTrSeq")).equals("")) {
						params.put( "btrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBtrSeq" ) ) );
						params.put( "btrName", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBtrName" ) ) );
						params.put( "baNb", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBaNb" ) ) );
						params.put( "depositor", CommonConvert.CommonGetStr( tradeInfo.get( "payTrDepositor" ) ) );

					}
					else {
						params.put( "btrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "jiroSeq" ) ) );
						params.put( "btrName", CommonConvert.CommonGetStr( tradeInfo.get( "jiroName" ) ) );
						params.put( "baNb", CommonConvert.CommonGetStr( tradeInfo.get( "baNb" ) ) );
						params.put( "depositor", CommonConvert.CommonGetStr( tradeInfo.get( "depositor" ) ) );							
					}
					
					
					/* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
					if ( CommonConvert.CommonGetStr( params.get( "interfaceType" ) ).equals( "" ) ) {
						params.put( "ctrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "trSeq" ) ) );
						params.put( "ctrName", (params.containsKey( "trName" ) ? CommonConvert.CommonGetStr( params.get( "trName" ) ) : "") );
					}
					
				} else {
					if(CommonConvert.CommonGetStr(params.get("trSeq")).equals("-1")){
						params.put("trSeq", "");
					}
				}
				
				/* 거래처 생성 직전 데이터 최종 벨리데이션 */
				if( !CommonConvert.NullToString( params.get( "setFgCode" ) ).equals( "4" )  ){
					/* 결제 수단 - 신용카드가 아닌경우 카드 거래처 모두 초기화 */
					params.put( "ctrSeq", "" );
					params.put( "ctrName", "" );
				} else if( CommonConvert.NullToString( params.get( "ctrName" ) ).equals( "" ) ){
					params.put( "ctrSeq", "" );
				}
				
				/* 거래처 생성 */
				result = resA.insertResTrade( params );
				if ( tradeInfo != null ) {
					/* 신규 생성된 거래처 또는 조회된 거래처 정보 반영 */
					result.getaData( ).put( "trSeq", CommonConvert.CommonGetStr( tradeInfo.get( "trSeq" ) ) );
					result.getaData( ).put( "ctrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "trSeq" ) ) );
					result.getaData( ).put( "ctrName", (params.containsKey( "trName" ) ? CommonConvert.CommonGetStr( params.get( "trName" ) ) : "") );
					result.getaData( ).put( "trFgCode", CommonConvert.CommonGetStr( tradeInfo.get( "trFgCode" ) ) );
					result.getaData( ).put( "trFgName", CommonConvert.CommonGetStr( tradeInfo.get( "trFgName" ) ) );
					result.getaData( ).put( "businessNb", CommonConvert.CommonGetStr( tradeInfo.get( "businessNb" ) ) );
					result.getaData( ).put( "depositor", CommonConvert.CommonGetStr( tradeInfo.get( "depositor" ) ) );
					result.getaData( ).put( "ceoName", CommonConvert.CommonGetStr( tradeInfo.get( "ceoName" ) ) );
					result.getaData( ).put( "jiroSeq", CommonConvert.CommonGetStr( tradeInfo.get( "jiroSeq" ) ) );
					result.getaData( ).put( "jiroName", CommonConvert.CommonGetStr( tradeInfo.get( "jiroName" ) ) );
					result.getaData( ).put( "baNb", CommonConvert.CommonGetStr( tradeInfo.get( "baNb" ) ) );
					result.getaData( ).put( "btrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "jiroSeq" ) ) );
					result.getaData( ).put( "btrName", CommonConvert.CommonGetStr( tradeInfo.get( "jiroName" ) ) );
					result.getaData( ).put( "nTr", "Y" );
					
					if(!CommonConvert.NullToString(params.get("payTrSeq")).equals("")) {
						result.getaData( ).put( "depositor", CommonConvert.CommonGetStr( tradeInfo.get( "payTrDepositor" ) ) );
						result.getaData( ).put( "baNb", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBaNb" ) ) );
						result.getaData( ).put( "btrSeq", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBtrSeq" ) ) );
						result.getaData( ).put( "btrName", CommonConvert.CommonGetStr( tradeInfo.get( "payTrBtrName" ) ) );
					}
				}
			}
			else {
				result.setaData( bgtResult.getaData( ) );
				result.setResultCode( commonCode.EXCEED );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
			ex.printStackTrace();
		}
		return result;
	}

	@Override
	public ResultVO updateResDoc ( Map<String, Object> params ) throws Exception {
		/* 결의문서 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.updateResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResDocEaInfo ( Map<String, Object> params ) throws Exception {
		/* 품의문서 전자결재 정보 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			// params = this.setAdvParams( params );
			result = resA.updateResDocEaInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.updateResHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.updateResBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			
			/* 채주 정보 특수문자 컨버팅 */
			String tBtrName = CommonConvert.NullToString( params.get( "btrName" ) ).replace( "'", "`" );
			String tCeoName = CommonConvert.NullToString( params.get( "ceoName" ) ).replace( "'", "`" );
			String tDepositor = CommonConvert.NullToString( params.get( "depositor" ) ).replace( "'", "`" );
			String tTrName = CommonConvert.NullToString( params.get( "trName" ) ).replace( "'", "`" );
			params.put( "btrName",  tBtrName);
			params.put( "ceoName",  tCeoName);
			params.put( "depositor",  tDepositor);
			params.put( "trName", tTrName);
			
			params = this.setAdvParams( params );
			String reqAmt = "0";
			if(params.get( "ctlFgCode" ).equals( "1" )){
				reqAmt = params.get( "tradeAmt" ).toString( );
			}else {
				reqAmt = params.get( "tradeStdAmt" ).toString( );
			}
			if(params.get( "beforeTradeAmt" ) == null){
				params.put( "beforeTradeAmt", params.get( "budgetAmt" ) );
			}
			double resDocAllAmt = 0;
			
			
			ResultVO groupbudgetInfo = resA.selectGroupBudgetInfo( params );
			if(!groupbudgetInfo.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception( groupbudgetInfo.getErrorCode( ) );
			}
			String confferConsAmt =  this.nullToDouble(params.get( "confferBalanceAmt" ));
			if(params.get( "ctlFgCode" ).equals( "1" )){
				reqAmt = params.get( "tradeAmt" ).toString( );
				String budgetAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetAmt ); 
				//params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetAmt ) );
			}else {
				reqAmt = params.get( "tradeStdAmt" ).toString( );
				String budgetStdAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetStdAmt" ).toString( ).replace( ",", "" );
				resDocAllAmt = Double.parseDouble( budgetStdAmt );
				//params.put( "confferResultBalanceAmt", Double.parseDouble( confferConsAmt ) - Double.parseDouble( budgetStdAmt ) );
			}
			params.put( "resDocAllAmt", resDocAllAmt );
			
			if(params.get("confferDocSeq")==null || params.get("confferDocSeq").equals("")) {
				params.put( "amt", resDocAllAmt + Double.parseDouble(reqAmt) );
			}
			else {
				params.put( "amt", reqAmt );		
			}
			
			ResultVO bgtResult = this.selectResBudgetBalance( params );
			
			if ( bgtResult.getResultName( ).equals( commonCode.CANBGT ) ) {
				
				/* 거래처 생성 직전 데이터 최종 벨리데이션 */
				if( !CommonConvert.NullToString( params.get( "setFgCode" ) ).equals( "4" )  ){
					/* 결제 수단 - 신용카드가 아닌경우 카드 거래처 모두 초기화 */
					params.put( "ctrSeq", "" );
					params.put( "ctrName", "" );
				} else if( CommonConvert.NullToString( params.get( "ctrName" ) ).equals( "" ) ){
					params.put( "ctrSeq", "" );
				}
				/* 거래처 생성 */
				result = resA.updateResTrade( params );
				if(bgtResult.getaData( ).get( "resultAmt" ) != null){
					double balanceAmt = (double)( bgtResult.getaData( ).get( "resultAmt" ) );
					result.getaData( ).put( "balanceAmt", balanceAmt );
				}
			}
			else {
				result.setaData( bgtResult.getaData( ) );
				result.setResultCode( commonCode.EXCEED );
			}
		}
		catch ( Exception ex ) {
			ex.printStackTrace( );
			result.setFail( "", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO CheckDraftInfo ( Map<String, Object> params ) throws Exception {
		/* 품의서 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.CheckDraftInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "임시저장 체크 실패", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO deleteResDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.deleteResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}
	
	@Override
	public ResultVO deleteResHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.deleteResHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteResBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.deleteResBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteResTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.deleteResTrade( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectResDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectResHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectResBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectResTrade( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	/**
	 * ERP 그룹웨어 통합 예산 잔액 조회
	 */
	@Override
	public ResultVO selectResBudgetBalance ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "	[ ** CALL : selectResBudgetBalance ]" );
		cmLog.CommonSetInfo( "	[ params ]" + params.toString( ) );
		/*
		 * 지역 변수 선언
		 */
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		/*
		 * 파라미터 기본값 설정
		 */
		double tryAmt = 0;
		if ( params.get( "amt" ) != null && !CommonConvert.CommonGetStr(params.get( "amt" )).equals("")) {
			try {
				tryAmt = Double.parseDouble( params.get( "amt" ).toString( ).replace( ",", "" ) );
			}
			catch ( Exception ex ) {
				tryAmt = 0;
			}
		}
		params = this.setAdvParams( params );
		params.put( "erpTypeCode", conVo.getErpTypeCode( ) );
		String confferDocSeq = params.get( "confferDocSeq" ) == null ? "" : params.get( "confferDocSeq" ).toString( );
		if ( confferDocSeq.equals( "" ) ) {
			/* 참조품의 정보 없으면 DB가서 조회 */
			ResultVO confferTest = resA.selectConfferBudgetInfo( params );
			if ( confferTest.getResultCode( ).equals( commonCode.SUCCESS ) ) {
				/* 참조품의 결의서의 경우 */
				if ( confferTest.getaData( ) != null ) {
					confferDocSeq = confferTest.getaData( ).get( "confferDocSeq" ).toString( );
				}
				else {
					confferDocSeq = "";
				}
			}
		}
		try {
			if ( !confferDocSeq.equals( "" ) ) {
				/* 현재 저장되어 있는 채주에 대하여 수정전 값 확인 */
				double prevTradeAmt = 0;
				/* 품의 잔액이 오버되지는 않았는지 확인 */
				String strConnferResultBalanceAmt = params.get( "confferResultBalanceAmt" ) == null ? "0" : params.get( "confferResultBalanceAmt" ).toString( );
				double resultAmt = Double.parseDouble( strConnferResultBalanceAmt );
				/* 참조품의 결의서의 경우 예산추가시 예산체크 진행하지 않음. */
				String budgetSeq = params.get( "budgetSeq" ) == null ? "" : params.get( "budgetSeq" ).toString( );
				if ( budgetSeq.equals( "" ) ) {
					result.setResultName( commonCode.CANBGT );
					return result;
				}
				/* 품의서 예산추가 가능여부 확인을 위해 tryAmt 정보 변경 */
				String strResDocAllAmt = params.get( "resDocAllAmt" ) == null ? "0" : params.get( "resDocAllAmt" ).toString( );
				strResDocAllAmt = strResDocAllAmt.equals( "" ) ? "0" : strResDocAllAmt;
				/* 신규 생성이면 기존값 체크안함, 거래처 수정의 경우 체크 진행 */
				String tradeSeq = params.get( "tradeSeq" ) == null ? "" : params.get( "tradeSeq" ).toString( );
				if ( !tradeSeq.equals( "" ) ) {
					List<Map<String, Object>> resTradeResult = resA.selectResTrade( params ).getAaData( );
					if ( resTradeResult.size( ) == 1 ) {
						prevTradeAmt = Double.parseDouble( resTradeResult.get( 0 ).get( "tradeAmt" ).toString( ) );
					}
				}
				/* 채주 유형 금액 변경할때 예산통제 불가능. 화면에서 amt 값이 넘어오지 않음. */
				if ( resultAmt >= ( tryAmt - prevTradeAmt) ) {
					result.setResultName( commonCode.CANBGT );
				}
				else {
					cmLog.CommonSetInfo( "	[ resultAmt : " + resultAmt + "    tryAmt : " + tryAmt + "    prevTradeAmt : " + prevTradeAmt );
					result.setFail( "참조품의 잔액 초과" );
				}
			}
			else {
				/** 일반 결의서 예산 통제 로직 진행 */
				/*
				 * 예산 통제 여부 확인
				 */
				result = serviceOption.selectAbgtinfo( params, null );
				Map<String, Object> ctlBudget = result.getaData( );
				if ( ctlBudget.get( "ctlBudget" ) != null && ctlBudget.get( "ctlBudget" ).toString( ).equals( commonCode.CANBGT ) ) {
					/* commonCode.CANBGT => 예산통제 미적용 Falg */
					result.setResultName( commonCode.CANBGT );
					return result;
				} else if (params.get("docuFgCode").toString().equals("6")){
					/*여입결의서의 경우 예산 통제 미적용*/
					result.setResultName( commonCode.CANBGT );
					return result;
				} else {
					result.setResultName( "" );
				}
				/*
				 * 예산 편성과, 집행금 조회
				 */
				ResultVO erpBudgetTemp = serviceBudget.selectERPBudgetBalance( params, conVo );
				if ( erpBudgetTemp.getResultCode( ).equals( commonCode.SUCCESS ) ) {
					/*
					 * 예산 공용 데이터 [budget]
					 * applyAm=0 결의 액
					 * , resAm=0 전표 승인 액
					 * , openAm=0 예산 배정 액
					 * , balanceAm=-728 잔여 예산
					 * , ctlYN=Y 예산 통제 여부
					 */
					Map<String, Object> erpBudget = erpBudgetTemp.getaData( );
					/*
					 * 품의 집행금 조회
					 */
					ResultVO consBalanceTemp = serviceBudget.selectConsBudgetBalance( params, conVo );
					if ( consBalanceTemp.getResultCode( ).equals( commonCode.FAIL ) ) {
						throw new Exception( consBalanceTemp.getResultName( ) );
					}
					/*
					 * 품의서 사용 금액 조회
					 * 품의액 : consStdAmt, consTaxAmt, consAmt
					 * 결의액 : resStdAmt, resTaxAmt, resAmt
					 * 잔 액 : balanceStdAmt, balanceTaxAmt, balanceAmt
					 * 기 타 : consAbgtCd, resAbgtCd (같은 데이터)
					 */
					Map<String, Object> consBalance = consBalanceTemp.getaData( );
					/*
					 * 미전송 결의 집행금 조회
					 */
					ResultVO reUseTemp = serviceBudget.selectResUseAmt( params, conVo );
					if ( reUseTemp.getResultCode( ).equals( commonCode.FAIL ) ) {
						throw new Exception( consBalanceTemp.getResultName( ) );
					}
					/*
					 * 품의서 사용 금액 조회
					 * 결의액 : resStdAmt, resTaxAmt, resAmt
					 */
					Map<String, Object> resUse = reUseTemp.getaData( );
					/*
					 * 예산 잔액 검증
					 */
					double budgetAmt = Double.parseDouble( erpBudget.get( "balanceAmt" ).toString( ) );
					double consAmt = Double.parseDouble( consBalance.get( "balanceAmt" ).toString( ) );
					double resAmt = Double.parseDouble( resUse.get( "resBudgetAmt" ).toString( ) );
					double resultAmt = budgetAmt - (consAmt + resAmt);
					Map<String, Object> resultMap = new HashMap<String, Object>( );
					resultMap.put( "budgetAmt", resultAmt );
					resultMap.put( "resultAmt", resultAmt - tryAmt );
					result.setaData( resultMap );
					if ( resultAmt >= tryAmt ) {
						result.setResultName( commonCode.CANBGT );
					} else if (params.get("docuFgCode").toString().equals("6")) {
						result.setResultName( commonCode.CANBGT );
					} else {
						result.setFail( "예산 잔액 초과" );
						cmLog.CommonSetInfo( "	[ resultAmt : " + resultAmt + "    tryAmt : " + tryAmt  );
					}
				}
				else {
					result.setFail( "기 집행액 조회에 실패하였습니다." );
				}
			}
		}
		catch ( Exception ex ) {
			cmLog.CommonSetInfo( "	[ error : " + ex.toString( )  );
			result.setFail( "예산 잔액 조회 실패", ex );
		}
		return result;
	}

	/**
	 * 결의서 정보 전체 조회
	 * params{
	 * !resDocSeq
	 * }
	 * return aData{
	 * resDocInfo : [{ }]
	 * , resHeadInfo : [{ }]
	 * , budgetInfo : [{ }]
	 * , tradeInfo : [{ }]
	 * }
	 */
	@Override
	public ResultVO selectResAllInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		params = this.setAdvParams( params );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		List<Map<String, Object>> resDocInfo = new ArrayList<>( );
		List<Map<String, Object>> resHeadInfo = new ArrayList<>( );
		List<Map<String, Object>> budgetInfo = new ArrayList<>( );
		List<Map<String, Object>> tradeInfo = new ArrayList<>( );
		Map<String, Object> aData = new HashMap<>( );
		try {
			/*
			 * 필수값 체크 결의문서 아이디 - resDocSeq
			 */
			String[] key = { "resDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다. - resDocSeq" );
			}
			/*
			 * 결의문서 정보 조회
			 */
			ResultVO resDocResult = this.selectResDoc( params );
			if ( !CommonConvert.CommonGetStr(resDocResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의문서 정보 조회에 실패하였습니다." );
			}
			ResultVO resHeadResult = this.selectResHead( params );
			if ( !CommonConvert.CommonGetStr(resHeadResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의 정보 조회에 실패하였습니다." );
			}
			ResultVO budgetResult = this.selectResBudget( params );
			if ( !CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의서 예산 정보 조회에 실패하였습니다." );
			}
			ResultVO tradeResult = this.selectResTrade( params );
			if ( !CommonConvert.CommonGetStr(tradeResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결서 거래처 정보 조회에 실패하였습니다." );
			}
			/*
			 * 데이터 반환 가공 aaData to aData
			 */
			resDocInfo = resDocResult.getAaData( );
			resHeadInfo = resHeadResult.getAaData( );
			budgetInfo = budgetResult.getAaData( );
			tradeInfo = tradeResult.getAaData( );
			/*
			 * 조회 데이터 리턴
			 */
			aData.put( "resDocInfo", resDocInfo );
			aData.put( "resHeadInfo", resHeadInfo );
			aData.put( "budgetInfo", budgetInfo );
			aData.put( "tradeInfo", tradeInfo );
			aData.put( "loginCompInfo", loginVo.getCompSeq() );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			/*
			 * 정상적인 에러 로직 진행을 위하여 전체 데이터 공백 리턴
			 */
			aData.put( "resDocInfo", new ArrayList<>( ) );
			aData.put( "resHeadInfo", new ArrayList<>( ) );
			aData.put( "budgetInfo", new ArrayList<>( ) );
			aData.put( "tradeInfo", new ArrayList<>( ) );
			result.setFail( "결의 정보 조회에 실패하였습니다.", ex );
		}
		finally {
			/*
			 * 데이터 반환 준비
			 */
			result.setaData( aData );
		}
		return result;
	}

	/**
	 * 카드사용내역 조회
	 */
	@Override
	public ResultVO selectCardDataList ( Map<String, Object> params ) throws Exception {
		/* 카드사용내역 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = resA.selectCardDataList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	/**
	 * 전자결재 이전단계 결의서 결의정보 조회
	 */
	@Override
	public ResultVO selectResApprovalBefore ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		Map<String, Object> aData = new HashMap<>( );
		try {
			params = this.setAdvParams( params );
			result = this.selectResAllInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "결의 정보 조회에 실패하였습니다.", ex );
		}
		return result;
	}
	
	private String nullToDouble(Object o){
		if(o == null){
			return "0";
		}else if(o.toString( ).equals( "" )){
			return "0";
		}else{
			return o.toString( );
		}
	}

	/**
	 * 	결의서 즐겨찾기 상태 정보 업데이트
	 */
	@Override
	public ResultVO updateFavoritesStatus ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = resA.updateFavoritesStatus( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR updateFavoritesStatus", ex );
		}
		return result;
	}

	/**
	 * 	결의서 즐겨찾기 결의서 목록 가져오기
	 */
	@Override
	public ResultVO selectFavoritesList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = resA.selectFavoritesList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR selectFavoritesList", ex );
		}
		return result;
	}

	/**
	 * 	결의서 즐겨찾기 결의서 삭제
	 */
	@Override
	public ResultVO deleteFavoritesList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			String pResDocSeqs = CommonConvert.NullToString( params.get( "checkedData" ) );
			if (pResDocSeqs.equals( "" )){
				throw new Exception("선택된 결의서 없음");
			}
			String[] resDocSeqs = pResDocSeqs.split( "," ); 
			for(int i=0; i < resDocSeqs.length; i++ ){
				params.put( "resDocSeq", resDocSeqs[i] );
				params.put( "favoritesStatus", "N" );
				result = resA.updateFavoritesStatus( params );
				if(result.getResultCode( ).equals( commonCode.FAIL )){
					return result;
				}
			}
		}
		catch ( Exception ex ) {
			result.setFail( "즐겨찾기 삭제 중 오류 발생", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateResFavoriteInfo(Map<String, Object> params) throws Exception {
		/* 결의 문서 즐겨찾기 반영 */
		ResultVO result = new ResultVO( );
		try {
			/* 즐겨찾기 데이터 이관 */
			params = this.setAdvParams( params );
			result = resA.updateResFavoriteInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = this.selectResAllInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO insertResItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = resA.insertResItemSpec( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR insertResItemSpec", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectResItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = resA.selectResItemSpec( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR selectResItemSpec", ex );
		}
		return result;
	}


}
