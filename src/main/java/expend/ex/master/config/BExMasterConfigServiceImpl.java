package expend.ex.master.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExConfigItemListVO;
import common.vo.ex.ExConfigItemVO;
import common.vo.ex.ExConfigOptionVO;
import common.vo.ex.ExOptionVO;
import common.vo.g20.ExCommonResultVO;


@Service ( "BExMasterConfigService" )
public class BExMasterConfigServiceImpl implements BExMasterConfigService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FExMasterConfigServiceA" )
	private FExMasterConfigService codeA; /* Bizbox Alpha */
	@Resource ( name = "FExMasterConfigServiceI" )
	private FExMasterConfigService codeI; /* ERP iCUBE */
	@Resource ( name = "FExMasterConfigServiceU" )
	private FExMasterConfigService codeU; /* ERP iU */
	@Resource ( name = "FExMasterConfigServiceE" )
	private FExMasterConfigService codeE; /* ERP ETC */
	/* 변수정의 - DAO */
	@Resource ( name = "FExMasterConfigServiceADAO" )
	private FExMasterConfigServiceADAO exMasterConfigServiceADAO; /* Bizbox Alpha */
	@Resource ( name = "FExMasterConfigServiceIDAO" )
	private FExMasterConfigServiceIDAO exMasterConfigServiceIDAO; /* ERP iCUBE */
	@Resource ( name = "FExMasterConfigServiceUDAO" )
	private FExMasterConfigServiceUDAO exMasterConfigServiceUDAO; /* ERP iU */
	@Resource ( name = "FExMasterConfigServiceEDAO" )
	private FExMasterConfigServiceEDAO exMasterConfigServiceEDAO; /* ERP ETC */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 지출결의 환경설정 */

	/* 지출결의 환경설정 - 옵션목록 조회 */
	/**
	 *   * @Method Name : ExConfigOptionListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션 목록 조회
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<ExConfigOptionVO> ExConfigOptionListInfoSelect ( ExConfigOptionVO configVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigOptionListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExConfigOptionVO configVo >> " + configVo.toString( ) );
		List<ExConfigOptionVO> configListVo = new ArrayList<ExConfigOptionVO>( );
		try {
			exMasterConfigServiceADAO.ExConfigOptionListInfoSelect( configVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExConfigOptionVO> configListVo >> " + configListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigOptionListInfoSelect" );
		return configListVo;
	}

	/* 지출결의 환경설정 */
	/* 지출결의 환경설정 - 옵션목록 조회 */
	/**
	 *   * @Method Name : ExConfigOptionItemsInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션목록 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<Map<String, Object>> ExConfigOptionItemsInfoSelect ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigOptionItemsInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExConfigOptionVO configVo >> " + param.toString( ) );
		ArrayList<Map<String, Object>> optionItems = new ArrayList<>( );
		try {
			optionItems = exMasterConfigServiceADAO.ExConfigOptionItemsSelect( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExConfigOptionVO> configListVo >> " + param.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigOptionItemsInfoSelect" );
		return optionItems;
	}

	/* 지출결의 환경설정 - 옵션 하위코드 조회 */
	/**
	 *   * @Method Name : ExConfigOptionCodeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션 하위코드 조회
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<ExCommonResultVO> ExConfigOptionCodeListInfoSelect ( ExConfigOptionVO configVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigOptionCodeListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExConfigOptionVO configVo >> " + configVo.toString( ) );
		List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>( );
		try {
			exMasterConfigServiceADAO.ExConfigOptionCodeListInfoSelect( configVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExCommonResultVO> resultListVo >> " + resultListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigOptionCodeListInfoSelect" );
		return resultListVo;
	}

	/* 지출결의 환경설정 - 옵션 수정 */
	/**
	 *   * @Method Name : ExConfigOptionInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션 수정
	 *   * @param configVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExConfigOptionInfoUpdate ( ExConfigOptionVO configVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigOptionInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExConfigOptionVO configVo >> " + configVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			exMasterConfigServiceADAO.ExConfigOptionInfoUpdate( configVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigOptionInfoUpdate" );
		return resultVo;
	}

	/* 지출결의 환경설정 - 전체옵션 가져오기 */
	/**
	 *   * @Method Name : ExOptionLoadSetting
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 전체옵션 가져오기
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<ExOptionVO> ExOptionLoadSetting ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExConfigLoadOption - ExConfigLoadOption" );
		cmLog.CommonSetInfo( "! [EX] ExConfigOptionVO configVo >> " + param.toString( ) );
		List<ExOptionVO> resultVo = new ArrayList<ExOptionVO>( );
		try {
			resultVo = exMasterConfigServiceADAO.ExOptionLoadSetting( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigLoadOption" );
		return resultVo;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExConfigOptionItemsInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public int ExConfigOptionItemsInfoUpdate ( Map<String, Object> param ) throws Exception {
		exMasterConfigServiceADAO.ExConfigOptionItemsUpdate( param );
		return 0;
	}

	/* 지출결의 환경설정 - 옵션 저장 */
	/**
	 *   * @Method Name : ExConfigExpendInsertItems
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션 저장
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public boolean ExConfigExpendInsertItems ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExConfigLoadOption - ExConfigExpendInsertItems" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> param >> " + param.toString( ) );
		boolean result = true;
		try {
			result = exMasterConfigServiceADAO.ExConfigExpendInsertItems( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigExpendInsertItems" );
		return result;
	}

	/* 지출결의 환경설정 - 옵션 삭제 */
	/**
	 *   * @Method Name : ExConfigExpendDeleteItems
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 환경설정 - 옵션 삭제
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public boolean ExConfigExpendDeleteItems ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExConfigLoadOption - ExConfigExpendDeleteItems" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object> param >> " + param.toString( ) );
		boolean result = true;
		try {
			result = exMasterConfigServiceADAO.ExConfigExpendDeleteItems( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigExpendDeleteItems" );
		return result;
	}

	/* 관리항목 설정 */
	/**
	 *   * @Method Name : ExConfigMngInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExConfigMngInfoInsert ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbn, mng_code, mng_name, use_gbn, ctd_code, ctd_name, cust_set, cust_set_target, create_seq, modify_seq */
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigMngInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExConfigMngInfoInsert( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigMngInfoInsert" );
		return resultVo;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 삭제 */
	/**
	 *   * @Method Name : ExConfigMngInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정 - 관리항목 설정 정보 삭제
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExConfigMngInfoDelete ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbn, mng_code */
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigMngInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExConfigMngInfoDelete( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigMngInfoDelete" );
		return resultVo;
	}

	/* 관리항목 설정 - 관리항목 설정 정보 삭제 후 생성 */
	/**
	 *   * @Method Name : ExConfigMngInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 관리항목 설정 - 관리항목 설정 정보 삭제 후 생성
	 *   * @param mngVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExConfigMngInfoUpdate ( ExCodeMngVO mngVo ) throws Exception {
		/* parameter : comp_seq, form_seq, drcr_gbn, mng_code, mng_name, use_gbn, ctd_code, ctd_name, cust_set, cust_set_target, create_seq, modify_seq */
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - ExConfigMngInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 관리항목 설정 정보 삭제 */
			resultVo = this.ExConfigMngInfoDelete( mngVo );
			if ( !CommonConvert.CommonGetStr(resultVo.getCode() ).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "관리항목 설정 정보 삭제 실패" );
			}
			/* 관리항목 설정 정보 생성 */
			resultVo = this.ExConfigMngInfoInsert( mngVo );
			if ( !CommonConvert.CommonGetStr(resultVo.getCode( )).equals( commonCode.SUCCESS ) ) {
				throw new Exception( "관리항목 설정 정보 생성 실패" );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - ExConfigMngInfoUpdate" );
		return resultVo;
	}

	/* 항목설정 */
	//회사 목록 조회
	/**
	 *   * @Method Name : GCompanyListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 회사 목록 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<ExCommonResultVO> GCompanyListS ( ExCommonResultVO param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - GCompanyListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		try {
			result = exMasterConfigServiceADAO.getCompanyList( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - GCompanyListS" );
		return result;
	}

	// 지출결의 양식 목록 조회
	/**
	 *   * @Method Name : GFormListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 양식 목록 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<ExCommonResultVO> GFormListS ( ExCommonResultVO param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - GFormListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>( );
		try {
			result = exMasterConfigServiceADAO.getFormList( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - GFormListS" );
		return result;
	}

	//항목조회
	/**
	 *   * @Method Name : GetItemListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExConfigItemListVO GetItemListS ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - GetItemListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		ExConfigItemListVO result = new ExConfigItemListVO( );
		//파라미터 변환(MAP -> VO)
		ExConfigItemVO tItemVO = new ExConfigItemVO( );
		tItemVO = (ExConfigItemVO) CommonConvert.CommonGetMapToObject( param, tItemVO );
		List<ExConfigItemVO> tTotal = new ArrayList<ExConfigItemVO>( );
		List<ExConfigItemVO> tBasic = new ArrayList<ExConfigItemVO>( );
		List<ExConfigItemVO> tSelect = new ArrayList<ExConfigItemVO>( );
		try {
			// 최초 조회시 기본값으로 조회한다.
			if ( exMasterConfigServiceADAO.getIsEmptyItemList( tItemVO ) == null ) {
				tTotal = exMasterConfigServiceADAO.getFirstItemList( tItemVO );
				for ( int i = 0; i < tTotal.size( ); i++ ) {
					if ( CommonConvert.CommonGetStr(tTotal.get( i ).getSelect_yn( )).equals( commonCode.EMPTYYES ) ) {
						tSelect.add( tTotal.get( i ) );
					}
					else {
						tBasic.add( tTotal.get( i ) );
					}
				}
				// 선택되지 않은 항목
				result.setConfigBasicItem( tBasic );
				// 선택된 항목
				result.setConfigSelectItem( tSelect );
			}
			else {
				tTotal = exMasterConfigServiceADAO.getItemList( tItemVO );
				for ( int i = 0; i < tTotal.size( ); i++ ) {
					if ( CommonConvert.CommonGetStr(tTotal.get( i ).getSelect_yn( )).equals( commonCode.EMPTYYES ) ) {
						tSelect.add( tTotal.get( i ) );
					}
					else {
						tBasic.add( tTotal.get( i ) );
					}
				}
				// 선택되지 않은 항목
				result.setConfigBasicItem( tBasic );
				// 선택된 항목
				result.setConfigSelectItem( tSelect );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExConfigItemListVO result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - GetItemListS" );
		return result;
	}

	// 항목 저장
	/**
	 *   * @Method Name : setItemList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 저장
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean setItemList ( ExConfigItemListVO param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - setItemList" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		try {
			/*
			 * 항목설정 저장 진행 순서
			 * 1. 해당 회사, form 정보로 조회
			 * 2. 만약 있는 경우 삭제 진행
			 * 3. 항목 정보 저장
			 */
			// 선택된 항목 작업 시작
			// 저장된 항목 있는지 확인
			boolean selectListisFirst = true;
			// comp_seq, form_seq, item_gbn 복사
			ExConfigItemVO tSelectItemVO = new ExConfigItemVO( );
			if ( param.getConfigSelectItem( ) != null && param.getConfigSelectItem( ).size( ) > 0 ) {
				tSelectItemVO.setComp_seq( param.getConfigSelectItem( ).get( 0 ).getComp_seq( ) );
				tSelectItemVO.setForm_seq( param.getConfigSelectItem( ).get( 0 ).getForm_seq( ) );
				tSelectItemVO.setItem_gbn( param.getConfigSelectItem( ).get( 0 ).getItem_gbn( ) );
			}
			// 존재 여부 확인
			if ( exMasterConfigServiceADAO.getIsEmptyItemList( tSelectItemVO ) != null ) {
				selectListisFirst = false;
			}
			// 존재 하는 경우 삭제 진행
			if ( !selectListisFirst ) {
				if ( !exMasterConfigServiceADAO.setItemListD( tSelectItemVO ) ) {
					return false;
				}
			}
			for ( int i = 0; i < param.getConfigSelectItem( ).size( ); i++ ) {
				// insert 진행 중 에러 발생시 항목 삭제
				param.getConfigSelectItem( ).get( i ).setComp_seq( tSelectItemVO.getComp_seq( ) );
				param.getConfigSelectItem( ).get( i ).setForm_seq( tSelectItemVO.getForm_seq( ) );
				param.getConfigSelectItem( ).get( i ).setItem_gbn( tSelectItemVO.getItem_gbn( ) );
				if ( !exMasterConfigServiceADAO.setItemListI( param.getConfigSelectItem( ).get( i ) ) ) {
					exMasterConfigServiceADAO.setItemListD( tSelectItemVO );
					return false;
				}
			}
			// 선택된 항목 작업 종료
			// 기본 항목 작업 시작
			// 상단에서 삭제 진행 하기때문에 진행 안함
			// comp_seq, form_seq, item_gbn 복사
			ExConfigItemVO tBasicItemVO = new ExConfigItemVO( );
			if ( param.getConfigBasicItem( ) != null && param.getConfigBasicItem( ).size( ) > 0 ) {
				tBasicItemVO.setComp_seq( param.getConfigBasicItem( ).get( 0 ).getComp_seq( ) );
				tBasicItemVO.setForm_seq( param.getConfigBasicItem( ).get( 0 ).getForm_seq( ) );
				tBasicItemVO.setItem_gbn( param.getConfigBasicItem( ).get( 0 ).getItem_gbn( ) );
			}
			for ( int i = 0; i < param.getConfigBasicItem( ).size( ); i++ ) {
				// insert 진행 중 에러 발생시 항목 삭제
				param.getConfigBasicItem( ).get( i ).setComp_seq( tBasicItemVO.getComp_seq( ) );
				param.getConfigBasicItem( ).get( i ).setForm_seq( tBasicItemVO.getForm_seq( ) );
				param.getConfigBasicItem( ).get( i ).setItem_gbn( tBasicItemVO.getItem_gbn( ) );
				if ( !exMasterConfigServiceADAO.setItemListI( param.getConfigBasicItem( ).get( i ) ) ) {
					exMasterConfigServiceADAO.setItemListD( tBasicItemVO );
					return false;
				}
			}
			// 기본 항목 작업 종료
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExConfigItemListVO result >> " + true );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - setItemList" );
		return true;
	}

	// 지출결의 양식 목록 조회
	public List<ExConfigItemVO> getExpendGridHeadInfoS ( ExConfigItemVO param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExMasterConfigServiceImpl - getItemListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		List<ExConfigItemVO> result = new ArrayList<ExConfigItemVO>( );
		try {
			result = exMasterConfigServiceADAO.getItemListS( param );
			if ( result == null || result.size( ) == 0 ) {
				param.setComp_seq( commonCode.EMPTYSEQ );
				param.setForm_seq( commonCode.EMPTYSEQ );
				result = exMasterConfigServiceADAO.getItemListS( param );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExConfigItemVO> result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExMasterConfigServiceImpl - getItemListS" );
		return result;
	}

	/* Biz - 공통코드 - 계정과목 생성 */
	/**
	 *   * @Method Name : ExCodeAcctInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 계정과목 생성
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAcctInfoInsert ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO acctVo >> " + parms.toString( ) );
		ResultVO result = new ResultVO( );
		try {
			result = exMasterConfigServiceADAO.ExCodeAcctInfoInsert( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO acctVo >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoInsert" );
		return result;
	}

	/* Biz - 공통코드 - 계정과목 수정 */
	/**
	 *   * @Method Name : ExCodeAcctInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 계정과목 수정
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAcctInfoUpdate ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO acctVo >> " + parms.toString( ) );
		ResultVO result = new ResultVO( );
		try {
			result = exMasterConfigServiceADAO.ExCodeAcctInfoUpdate( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoUpdate" );
		return result;
	}

	/* Biz - 공통코드 - 계정과목 삭제 */
	/**
	 *   * @Method Name : ExCodeAcctInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 게정과목 삭제
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAcctInfoDelete ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO acctVo >> " + parms.toString( ) );
		ResultVO result = new ResultVO( );
		try {
			result = exMasterConfigServiceADAO.ExCodeAcctInfoDelete( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAcctBizboxAService - ExCodeAcctInfoDelete" );
		return result;
	}

	/* Biz - 공통코드 - 증빙유형 */
	/* Biz - 공통코드 - 증빙유형 등록 */
	/**
	 *   * @Method Name : ExCodeAuthInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 증빙유형 등록
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAuthInfoInsert ( Map<String, Object> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO authVo >> " + parms.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeAuthInfoInsert( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO authVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoInsert" );
		return resultVo;
	}

	/* Biz - 공통코드 - 증빙유형 수정 */
	/**
	 *   * @Method Name : ExCodeAuthInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 증빙유형 수정
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAuthInfoUpdate ( Map<String, Object> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoUpdate" );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeAuthInfoUpdate( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoUpdate" );
		return resultVo;
	}

	/* Biz - 공통코드 - 증빙유형 삭제 */
	/**
	 *   * @Method Name : ExCodeAuthInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 증빙유형 삭제
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeAuthInfoDelete ( Map<String, Object> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO authVo >> " + parms.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeAuthInfoDelete( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeAuthBizboxAService - ExCodeAuthInfoDelete" );
		return resultVo;
	}

	/* Biz - 공통코드 - 표준적요 등록 */
	/**
	 *   * @Method Name : ExCodeSummaryInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 등록
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCodeSummaryVO ExCodeSummaryInfoInsert ( ExCodeSummaryVO summaryVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeSummaryVO summaryVo >> " + summaryVo.toString( ) );
		try {
			summaryVo = exMasterConfigServiceADAO.ExCodeSummaryInfoInsert( summaryVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeSummaryVO summaryVo >> " + summaryVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoInsert" );
		return summaryVo;
	}

	/* Biz - 공통코드 - 표준적요 수정 */
	/**
	 *   * @Method Name : ExCodeSummaryInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 수정
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCommonResultVO ExCodeSummaryInfoUpdate ( ExCodeSummaryVO summaryVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeSummaryVO summaryVo >> " + summaryVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeSummaryInfoUpdate( summaryVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoUpdate" );
		return resultVo;
	}

	/* Biz - 공통코드 - 표준적요 삭제 */
	/**
	 *   * @Method Name : ExCodeSummaryInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 표준적요 삭제
	 *   * @param summaryVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ExCommonResultVO ExCodeSummaryInfoDelete ( ExCodeSummaryVO summaryVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeSummaryVO summaryVo >> " + summaryVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeSummaryInfoDelete( summaryVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeSummaryBizboxAService - ExCodeSummaryInfoDelete" );
		return resultVo;
	}

	// 회사 목록 조회
	/**
	 *   * @Method Name : GCompanyListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 회사 목록 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> GCompanyListS ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExConfigSettingItemsServiceImpl - GCompanyListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = exMasterConfigServiceADAO.getCompanyList( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExConfigSettingItemsServiceImpl - GCompanyListS" );
		return result;
	}

	// 지출결의 양식 목록 조회
	/**
	 *   * @Method Name : GFormListS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 지출결의 양식 목록 조회
	 *   * @param param
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> GFormListS ( Map<String, Object> param ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExConfigSettingItemsServiceImpl - GFormListS" );
		cmLog.CommonSetInfo( "! [EX] param >> " + param.toString( ) );
		//리턴 변수
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = exMasterConfigServiceADAO.getFormList( param );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendVO result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExConfigSettingItemsServiceImpl - GFormListS" );
		return result;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param params
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeVatBizboxAService - ExCodeVatTypeListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + params.toString( ) );
		List<Map<String, Object>> vatTeypListVo = new ArrayList<Map<String, Object>>( );
		try {
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.BIZBOXA:
					/* ERP에서 가져오기 */
					vatTeypListVo = codeA.ExCodeVatTypeListInfoSelect( params, conVo );
					break;
				case commonCode.ERPIU:
					/* ERP에서 가져오기 */
					vatTeypListVo = codeU.ExCodeVatTypeListInfoSelect( params, conVo );
					break;
				case commonCode.ICUBE:
					vatTeypListVo = codeI.ExCodeVatTypeListInfoSelect( params, conVo );
					break;
				case commonCode.ETC:
					/* ERP에서 가져오기 */
					vatTeypListVo = codeE.ExCodeVatTypeListInfoSelect( params, conVo );
					break;
				default:
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExCodeAuthVO> vatTeypListVo >> " + vatTeypListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeVatBizboxAService - ExCodeVatTypeListInfoSelect" );
		return vatTeypListVo;
	}

	/* Biz - 공통코드 - 부가세 생성 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 부가세 생성
	 *   * @param vatTypeVo
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCodeAuthVO ExCodeVatTypeInfoInsert ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + vatTypeVo.toString( ) );
		try {
			vatTypeVo = exMasterConfigServiceADAO.ExCodeVatTypeInfoInsert( vatTypeVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + vatTypeVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoInsert" );
		return vatTypeVo;
	}

	/* Biz - 공통코드 - 부가세 수정 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 부가세 수정
	 *   * @param vatTypeVo
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExCodeVatTypeInfoUpdate ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + vatTypeVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeVatTypeInfoUpdate( vatTypeVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoUpdate" );
		return resultVo;
	}

	/* Biz - 공통코드 - 부가세 삭제 */
	/**
	 *   * @Method Name : ExCodeVatTypeInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - 부가세 삭제
	 *   * @param vatTypeVo
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ExCommonResultVO ExCodeVatTypeInfoDelete ( ExCodeAuthVO vatTypeVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + vatTypeVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exMasterConfigServiceADAO.ExCodeVatTypeInfoDelete( vatTypeVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeVatBizboxAService - ExCodeVatTypeInfoDelete" );
		return resultVo;
	}
}
