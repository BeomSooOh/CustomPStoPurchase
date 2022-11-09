package expend.np.user.cons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.option.BNpUserOptionService;


@Service ( "BNpUserConsService" )
public class BNpUserConsServiceImpl implements BNpUserConsService {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "FNpUserConsServiceA" )
	private FNpUserConsService consA; /* Bizbox Alpha */
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "BNpUserBudgetService" )
	private BNpUserBudgetService serviceBudget; /* Expend Service */
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService npOption;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService serviceCommonProc;

	public Map<String, Object> setAdvParams ( Map<String, Object> params ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		if ( loginVo == null ) {
			throw new NotFoundLoginSessionException( "login 정보를 찾을 수 없습니다." );
		}
		params.put( "empSeq", loginVo.getUniqId( ) );
		params.put( "empName", loginVo.getEmpname( ) );
		if ( params.get( "empName" ) == null || CommonConvert.CommonGetStr(params.get( "empName" )).equals( "" ) ) {
			params.put( "empName", loginVo.getName( ) );
		}
		params.put( "compSeq", loginVo.getCompSeq( ) );
		params.put( "compName", loginVo.getOrganNm( ) );
		params.put( "deptSeq", loginVo.getOrgnztId( ) );
		params.put( "deptName", loginVo.getDeptname( ) );
		if ( params.get( "deptName" ) == null || CommonConvert.CommonGetStr(params.get( "deptName" )).equals( "" ) ) {
			params.put( "deptName", loginVo.getOrgnztNm( ) );
		}

		if(CommonConvert.NullToString( params.get( "erpCompSeq" ) ).equals( commonCode.EMPTYSTR ) ){
			params.put( "erpCompSeq", loginVo.getErpCoCd( ) );
		}
		params.put( "erpEmpSeq", loginVo.getErpEmpCd( ) );
		return params;
	}

	public ResultVO GetExDocMake ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		/* [예외 검증] ERP 연결정보 조회 */
		LoginVO loginVo = new LoginVO( );
		try {
			loginVo = CommonConvert.CommonGetEmpVO( );
		}
		catch ( NotFoundLoginSessionException e ) {
			result.setFail( "로그인 세션 검색 실패" );
			return result;
		}
		result = consA.GetExDocMake( params );
		return result;
	}

	@Override
	public ResultVO insertConsDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 생성 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.insertConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO insertConsHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 생성 */
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
							result.setResultName( "기수가 마감되어 품의서를 작성할 수 없습니다." );
							result.setResultCode( "GISU_CLOSE" );
							return result;
						}
					}
				}
			}

			/* 품의서 입력 */
			params = this.setAdvParams( params );
			result = consA.insertConsHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO insertConsBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 생성 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			String reqAmt = params.get( "budgetAmt" ).toString( );
			/* !!!! 예산 생성 가능 여부 확인 */
			ResultVO bgtResult = this.selectConsBudgetBalance( params );
			if ( bgtResult.getResultName( ).equals( commonCode.CANBGT ) ) {
				/* 예산 생성 */
				result = consA.insertConsBudget( params );
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
	public ResultVO insertConsTrade ( Map<String, Object> params ) throws Exception {
		/* 품의 거래처 생성 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.insertConsTrade( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.updateConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsDocEaInfo ( Map<String, Object> params ) throws Exception {
		/* 품의문서 전자결재 정보 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			//			params = this.setAdvParams( params );
			result = consA.updateConsDocEaInfo( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.updateConsHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			String reqAmt = params.get( "budgetAmt" ).toString( );
			/* !!!! 예산 갱신 가능 여부 확인 */
			ResultVO bgtResult = this.selectConsBudgetBalance( params );
			if ( bgtResult.getResultName( ).equals( commonCode.CANBGT ) ) {
				/* 예산 갱신 */
				result = consA.updateConsBudget( params );
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
	public ResultVO updateConsTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 업데이트 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.updateConsTrade( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteConsDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.deleteConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteConsHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.deleteConsHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteConsBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.deleteConsBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO deleteConsTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 삭제 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.deleteConsTrade( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsDoc ( Map<String, Object> params ) throws Exception {
		/* 품의문서 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsHead ( Map<String, Object> params ) throws Exception {
		/* 품의서 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectConsHead( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsBudget ( Map<String, Object> params ) throws Exception {
		/* 품의예산 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectConsBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsTrade ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectConsTrade( params );
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
	public ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception {
		/*
		 * 지역변수 설정
		 */
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		/*
		 * 파라미터 기본값 설정
		 */
		double tryAmt = 0;
		if ( params.get( "budgetAmt" ) != null ) {
			try {
				tryAmt = Double.parseDouble( params.get( "budgetAmt" ).toString( ).replace( ",", "" ) );
			}
			catch ( Exception ex ) {
				tryAmt = 0;
			}
		}
		params = this.setAdvParams( params );
		params.put( "erpTypeCode", conVo.getErpTypeCode( ) );
		try {
			/*
			 * 예산 통제 여부 확인
			 */
			result = serviceOption.selectAbgtinfo( params, null );
			Map<String, Object> ctlBudget = result.getaData( );
			if ( CommonConvert.CommonGetStr(ctlBudget.get( "ctlBudget" )).equals( commonCode.CANBGT ) ) {
				/* commonCode.CANBGT => 예산통제 미적용 Falg */
				result.setResultName( commonCode.CANBGT );
				return result;
			}
			/*
			 * 예산 편성과, 집행금 조회
			 */
			ResultVO erpBudgetTemp = new ResultVO( );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				erpBudgetTemp = serviceBudget.selectERPBudgetBalance( params, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				erpBudgetTemp = result;
				erpBudgetTemp.setaData( result.getAaData( ).get( 0 ) );
			}
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
				/* 품의 집행금 조회 */
				ResultVO consBalanceTemp = new ResultVO( );
				consBalanceTemp = serviceBudget.selectConsBudgetBalance( params );
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
				/* 미전송 결의 집행금 조회 */
				ResultVO reUseTemp = serviceBudget.selectResUseAmt( params );
				if ( reUseTemp.getResultCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( consBalanceTemp.getResultName( ) );
				}
				/*
				 * 품의서 사용 금액 조회
				 * 결의액 : resStdAmt, resTaxAmt, resAmt
				 */
				Map<String, Object> resUse = reUseTemp.getaData( );

				/*
				 * 품의문서 내 동일 예산 사용 금액 조회
				 *
				 */
				ResultVO groupbudgetInfo = consA.selectGroupBudgetInfo(params);
				if(!groupbudgetInfo.getResultCode( ).equals( commonCode.SUCCESS )){
					throw new Exception( groupbudgetInfo.getErrorCode( ) );
				}
				String budgetAmt = groupbudgetInfo.getAaData( ).get( 0 ).get( "budgetAmt" ).toString( ).replace( ",", "" );
				double resDocAllAmt = Double.parseDouble( budgetAmt );
				/*
				 * 예산 잔액 검증
				 */
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
					double budgetBalnaceAmt = Double.parseDouble( erpBudget.get( "balanceAmt" ).toString( ) );
					double consAmt = Double.parseDouble( consBalance.get( "balanceAmt" ).toString( ) );
					double resAmt = Double.parseDouble( resUse.get( "resBudgetAmt" ).toString( ) );
					double resultAmt = budgetBalnaceAmt - (consAmt + resAmt);
					Map<String, Object> resultMap = new HashMap<String, Object>( );
					resultMap.put( "budgetAmt", resultAmt );
					resultMap.put( "resultAmt", resultAmt - tryAmt  );
					result.setaData( resultMap );
					if ( resultAmt - resDocAllAmt >= tryAmt ) {
						result.setResultName( commonCode.CANBGT );
					}
					else {
						result.setResultName( commonCode.FAIL );
					}
				}
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
					double budgetBalnaceAmt = Double.parseDouble( erpBudget.get( "leftAmt" ).toString( ) );
					double consAmt = Double.parseDouble( consBalance.get( "balanceAmt" ).toString( ) );
					double resAmt = Double.parseDouble( resUse.get( "resBudgetAmt" ).toString( ) );
					double resultAmt = budgetBalnaceAmt - (consAmt + resAmt);
					double openAmt = Double.parseDouble( erpBudget.get( "openAmt" ).toString( ) );
					double applyAmt = Double.parseDouble( erpBudget.get( "applyAmt" ).toString( ) );
					Map<String, Object> resultMap = new HashMap<String, Object>( );
					resultMap.put( "budgetAmt", budgetBalnaceAmt );
					resultMap.put( "resultAmt", resultAmt - tryAmt );
					resultMap.put( "openAmt", openAmt );
					resultMap.put( "applyAmt", applyAmt );
					resultMap.put( "tryAmt", tryAmt );
					result.setaData( resultMap );
					if ( (resultAmt - resDocAllAmt) >= tryAmt ) {
						result.setResultName( commonCode.CANBGT );
					}
					else {
						result.setResultName( commonCode.FAIL );
					}
				}
			}
			else {
				result.setFail( "기 집행액 조회에 실패하였습니다." );
			}
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	/**
	 * 권한 품의서 리스트 조 회
	 */
	@Override
	public ResultVO selectRefferConsList ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 조회 */
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "deptSeq", loginVo.getOrgnztId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "groupSeq", loginVo.getGroupSeq() );
			params = this.setAdvParams( params );
			result = consA.selectRefferConsList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	/**
	 * 품의서 예산정보 상세 조회
	 */
	@Override
	public ResultVO selectConsDetailBudget ( Map<String, Object> params ) throws Exception {
		/* 품의거래처 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectConsDetailBudget( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}


	/**
	 * 전자결재 이전단계 품의서 품의정보 조회
	 */
	@Override
	public ResultVO selectConsApprovalBefore ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		Map<String, Object> aData = new HashMap<>( );
		try{
			params = this.setAdvParams( params );
			result = this.selectConsAllInfo(params);
		}catch(Exception ex) {
			result.setFail( "결의 정보 조회에 실패하였습니다.", ex );
		}
		return result;
	}


	/**
	 * 품의서 정보 전체 조회
	 * params{
	 * !consDocSeq
	 * }
	 * return aData{
	 * consDocInfo : [{ }]
	 * , consHeadInfo : [{ }]
	 * , budgetInfo : [{ }]
	 * , tradeInfo : [{ }]
	 * }
	 */
	@Override
	public ResultVO selectConsAllInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		params = this.setAdvParams( params );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		List<Map<String, Object>> consDocInfo = new ArrayList<>( );
		List<Map<String, Object>> consHeadInfo = new ArrayList<>( );
		List<Map<String, Object>> budgetInfo = new ArrayList<>( );
		List<Map<String, Object>> tradeInfo = new ArrayList<>( );
		Map<String, Object> aData = new HashMap<>( );
		try {
			/*
			 * 필수값 체크 결의문서 아이디 - resDocSeq
			 */
			String[] key = { "consDocSeq", "Y" };
			if ( !MapUtil.hasParameters( params, key ) ) {
				result.setFail( "필수 값이 누락되었습니다. - resDocSeq" );
			}
			/*
			 * 결의문서 정보 조회
			 */
			ResultVO consDocResult = this.selectConsDoc( params );
			if ( !CommonConvert.CommonGetStr(consDocResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의문서 정보 조회에 실패하였습니다." );
			}
			ResultVO consHeadResult = this.selectConsHead( params );
			if ( !CommonConvert.CommonGetStr(consHeadResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의 정보 조회에 실패하였습니다." );
			}
			ResultVO budgetResult = this.selectConsBudget( params );
			if ( !CommonConvert.CommonGetStr(budgetResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결의서 예산 정보 조회에 실패하였습니다." );
			}
			ResultVO tradeResult = this.selectConsTrade( params );
			if ( !CommonConvert.CommonGetStr(tradeResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "결서 거래처 정보 조회에 실패하였습니다." );
			}
			/*
			 * 데이터 반환 가공 aaData to aData
			 */
			consDocInfo = consDocResult.getAaData( );
			consHeadInfo = consHeadResult.getAaData( );
			budgetInfo = budgetResult.getAaData( );
			tradeInfo = tradeResult.getAaData( );
			/*
			 * 조회 데이터 리턴
			 */
			aData.put( "consDocInfo", consDocInfo );
			aData.put( "consHeadInfo", consHeadInfo );
			aData.put( "budgetInfo", budgetInfo );
			aData.put( "tradeInfo", tradeInfo );
			aData.put( "loginCompInfo", loginVo.getCompSeq() );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			/*
			 * 정상적인 에러 로직 진행을 위하여 전체 데이터 공백 리턴
			 */
			aData.put( "consDocInfo", new ArrayList<>( ) );
			aData.put( "consHeadInfo", new ArrayList<>( ) );
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
	 * 품의서 키를 통한 참조품의서 예산 정보 조회
	 * params{
	 * !consDocSeq
	 * }
	 */
	@Override
	public ResultVO selectConfferConsBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		Map<String, Object> aData = new HashMap<>( );
		try{
			params = this.setAdvParams( params );
			result = consA.selectConfferConsBudgetInfo( params );
		}catch(Exception ex) {
			result.setFail( "품의 예산 정보 조회에 실패하였습니다.", ex );
		}
		return result;
	}

	/**
	 * 	품의서 즐겨찾기 상태 정보 업데이트
	 */
	@Override
	public ResultVO updateFavoritesStatus(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = consA.updateFavoritesStatus( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR updateFavoritesStatus", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectFavoritesList(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = consA.selectFavoritesList( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR selectFavoritesList", ex );
		}
		return result;
	}

	@Override
	public ResultVO updateConsFavoriteInfo(Map<String, Object> params) throws Exception {
		/* 결의 문서 즐겨찾기 반영 */
		ResultVO result = new ResultVO( );
		try {
			/* 즐겨찾기 데이터 이관 */
			params = this.setAdvParams( params );
			result = consA.updateConsFavoriteInfo( params );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = this.selectConsAllInfo( params );
			}
		}
		catch ( Exception ex ) {
			result.setFail( ex.getMessage( ), ex );
		}
		return result;
	}

	@Override
	public ResultVO insertConsItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = consA.insertConsItemSpec( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR insertConsItemSpec", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsItemSpec(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			result = consA.selectConsItemSpec( params );
		}
		catch ( Exception ex ) {
			result.setFail( "Function Logic ERROR selectConsItemSpec", ex );
		}
		return result;
	}

	@Override
	public ResultVO selecTripConsDoc(Map<String, Object> params) throws Exception {
		/* 출장품의문서 조회 */
		ResultVO result = new ResultVO( );
		try {
			params = this.setAdvParams( params );
			result = consA.selectTripConsDoc( params );
		}
		catch ( Exception ex ) {
			result.setFail( "", ex );
		}
		return result;
	}

	@Override
	public ResultVO selectConsInCustom(Map<String, Object> params) throws Exception { // TODO: 백상휘 수정.
		return consA.selectConsInCustom(params);
	}
}
