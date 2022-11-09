package expend.ex.budget;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.ibm.icu.text.DecimalFormat;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.BudgetAmtOverException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.slip.BExUserSlipService;
import expend.ex.user.slip.FExUserSlipServiceADAO;


@Service ( "BExBudgetService" )
public class BExBudgetServiceImpl implements BExBudgetService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource ( name = "FExBudgetServiceI" )
	private FExBudgetServiceI iCubeBudgetService; /* iCUBE */
	@Resource ( name = "FExBudgetServiceU" )
	private FExBudgetServiceUImpl ERPiUBudgetService; /* ERPiU */
	@Resource ( name = "BExUserSlipService" )
	private BExUserSlipService slipService; /* 분개 목록 조회 */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService codeService;/* Code */
	@Resource ( name = "FExBudgetServiceI" )
	private FExBudgetServiceI exBudgetServiceI;
	@Resource ( name = "FExBudgetServiceADAO" ) /* Bizbox Alhpa */
	private FExBudgetServiceADAO exBudgetServiceADAO;
	@Resource ( name = "FExBudgetServiceUDAO" ) /* ERPiU */
	private FExBudgetServiceUDAO exBudgetServiceUDAO;
	@Resource ( name = "FExUserSlipServiceADAO" ) /* Slip */
	private FExUserSlipServiceADAO exUserSlipServiceADAO;

	//얘산사용여부 확인 params(erp_comp_seq, erpType, loginVo)
	//예산사용여부 및 예산단위 가져오기
	@Override
    @SuppressWarnings ( "unused" )
	public Map<String, Object> ExBudgetUseInfoSelect ( Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		//커넥션 연결
		params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
		/* 기본값 지정 - 연동 시스템 정보 처리 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		switch ( (String) params.get( "erpType" ) ) {
			case commonCode.ICUBE:
				result = iCubeBudgetService.ExBudgetUseInfoSelect( params, conVo );
				if ( CommonConvert.CommonGetStr(result.get( "useYN" )).equals( "1" ) ) {
					result.put( "budgetUse", commonCode.EMPTYYES );
					if ( CommonConvert.CommonGetStr(result.get( "budgetType" )).equals( commonCode.EMPTYSEQ ) ) {
						result.put( "budgetUnit", "D" );
					}
					else if ( CommonConvert.CommonGetStr(result.get( "budgetType" )).equals( "1" ) ) {
						result.put( "budgetUnit", "D" );
					}
					else if ( CommonConvert.CommonGetStr(result.get( "budgetType" )).equals( "2" ) ) {
						result.put( "budgetUnit", "P" );
					}
					else {
						throw new Exception( "아이큐브에서 설정한 예산단위가 없습니다." );
					}
				}
				else {
					result.put( "budgetUse", commonCode.EMPTYNO );
				}
				break;
			case commonCode.ERPIU:
				result.put( "budgetUse", commonCode.EMPTYNO );
				break;
			case commonCode.ETC:
				result.put( "budgetUse", commonCode.EMPTYNO );
				break;
			case commonCode.BIZBOXA:
				result.put( "budgetUse", commonCode.EMPTYNO );
				break;
			default:
				throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
		}
		return result;
	}

	//지출결의 예산금액 확인 함수
	@Override
    public ExCodeBudgetVO ExBudgetAmtInfoSelect ( Map<String, Object> params ) throws Exception {
		ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
		//커넥션 연결
		//		params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
		/* 기본값 지정 - 연동 시스템 정보 처리 */
//		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ), CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
		/* 공통 parameter */
		budgetVo.setErpCompSeq( (String) params.get( "erpCompSeq" ) );
		budgetVo.setAmt( (String) params.get( "amt" ) );
        budgetVo.setCompSeq((String) params.get("compSeq"));
		budgetVo.setBudgetCode( (String) params.get( "budgetCode" ) );
		budgetVo.setTpDrcr( (String) params.get( "drcrGbn" ) );
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.ICUBE:
				budgetVo.setBgacctCode( (String) params.get( "acctCode" ) );
				budgetVo.setBudYm( (String) params.get( "budgetYm" ) );
				budgetVo.setBudgetYm( (String) params.get( "budgetYm" ) );
				exBudgetServiceI.ExBudgetAmtInfoSelect( budgetVo, conVo );
				break;
			case commonCode.ERPIU:
				budgetVo.setBgacctCode( (String) params.get( "bgacctCode" ) );
				budgetVo.setBudgetYm( params.get( "budgetYm" ).toString( ) );
                if (params.get("bizplanCode") == null || CommonConvert.CommonGetStr(params.get("bizplanCode")).equals(commonCode.EMPTYSTR) || CommonConvert.CommonGetStr(params.get("bizplanCode")).equals(commonCode.EMPTYSEQ)) {
					budgetVo.setBizplanCode( "***" );
				}
				else {
					budgetVo.setBizplanCode( params.get( "bizplanCode" ).toString( ) );
				}
				budgetVo = ERPiUBudgetService.ExBudgetAmtInfoSelect( budgetVo, conVo );
				break;
			case commonCode.ETC:
				break;
			case commonCode.BIZBOXA:
				break;
			default:
				throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
		}
		return budgetVo;
	}

    @Override
    public ExCodeBudgetVO ExBudgetAmtInfoSelect3(Map<String, Object> params) throws Exception {

        ExCodeBudgetVO result = new ExCodeBudgetVO();
        ConnectionVO con = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));

        if (con.getErpTypeCode().equals(commonCode.ICUBE)) {
            // iCUBE의 경우에는 ExBudgetAmtInfoSelect3 프로세스에 해당되지 않습니다.
            // 기존 프로세스로 진행합니다.
            return this.ExBudgetAmtInfoSelect2(params);
        }

        if (params.get("cdBgLevel") == null || params.get("cdBgLevel").toString().equals("")) {
            // 예산통제레벨계정이 없는 경우입니다.
            // 기존 프로세스로 진행합니다.
            return this.ExBudgetAmtInfoSelect2(params);
        } else {
            ExCodeBudgetVO budgetParam = new ExCodeBudgetVO();

            if (con.getErpTypeCode().equals(commonCode.ERPIU)) {

                if (params.get("ynControl").toString().equals("Y")) {
                    budgetParam.setExpendSeq((params.get("expendSeq") != null ? params.get("expendSeq").toString() : 0).toString());
                    budgetParam.setListSeq((params.get("listSeq") != null ? params.get("listSeq").toString() : 0).toString());
                    budgetParam.setSlipSeq((params.get("slipSeq") != null ? params.get("slipSeq").toString() : 0).toString());

                    budgetParam.setErpCompSeq(params.get("erpCompSeq").toString());
                    budgetParam.setBudgetYm(params.get("budgetYm").toString());
                    budgetParam.setBudgetCode(params.get("budgetCode").toString());
                    budgetParam.setBizplanCode(params.get("bizplanCode").toString());

                    if (budgetParam.getBizplanCode() == null || budgetParam.getBizplanCode().equals("") || budgetParam.getBizplanCode().equals("0")) {
                        budgetParam.setBizplanCode("***");
                    }

                    budgetParam.setBgacctCode(params.get("bgacctCode").toString());
                    budgetParam.setCdBgLevel(params.get("cdBgLevel").toString()); // 예산통제레벨계정 ( ERPiU 연동 사용 )
                    budgetParam.setYnControl(params.get("ynControl").toString()); // 예산통제여부 ( N : 통제안함, Y : 통제 ) ( ERPiU 연동 사용 )
                    budgetParam.setTpControl(params.get("tpControl").toString()); // 예산통제기준 ( 1 : 예산단위통제, 2 : 예산계정통제 ) ( ERPiU 연동 사용 )

                    // 지출결의 작성하려는 금액
                    BigDecimal reqAmt = new BigDecimal(params.get("amt").toString().replaceAll(",", ""));

                    // 현재 작성중인 지출결의 문서의 금액정보 조회
                    BigDecimal expendAmt = BigDecimal.ZERO;
                    if (!budgetParam.getExpendSeq().equals("0") && !budgetParam.getExpendSeq().equals("")) {
                        Map<String, Object> expendParam = new HashMap<String, Object>();
                        expendParam.put("groupSeq", params.get("groupSeq"));
                        expendParam.put("expendSeq", params.get("expendSeq"));
                        expendParam.put("listSeq", params.get("listSeq"));
                        expendParam.put("isEdit", params.get("isEdit"));
                        expendParam.put("budgetCode", params.get("budgetCode"));
                        expendParam.put("bizplanCode", params.get("bizplanCode"));
                        expendParam.put("cdBgLevel", params.get("cdBgLevel"));
                        expendParam.put("budgetYm", params.get("budgetYm"));

                        Map<String, Object> expendAmtInfo = exBudgetServiceADAO.ExSameBudgetInfoSelectERPiU(expendParam);
                        expendAmtInfo = (expendAmtInfo == null ? new HashMap<String, Object>() : expendAmtInfo);

                        expendAmtInfo.put("amt", (expendAmtInfo.get("amt") == null ? "0" : expendAmtInfo.get("amt")));

                        expendAmt = new BigDecimal(expendAmtInfo.get("amt").toString());
                    }

                    /**
                     * <pre>
                     * # BigDecimal 사칙연산
                     * - 더하기 : add
                     * - 빼기 : subtract
                     * - 곱하기 : multiply
                     * - 나누기 : divide
                     * # BigDecimal 비교
                     * - BigDecimal 의 수치가 비교값 보다 작으면 -1
                     * - BigDecimal 의 수치가 비교값 보다 같으면 0
                     * - BigDecimal 의 수치가 비교값 보다 크면 1
                     * </pre>
                     */
                    // ERPiU 실행합금액 및 집행금액 조회
                    ExCodeBudgetVO erpBudget = ERPiUBudgetService.UP_FI_Z_BIZBOX_BUDGET_DATA(budgetParam, con);
                    BigDecimal budgetActsum = new BigDecimal(erpBudget.getBudgetActsum()); // 실행합금액
                    BigDecimal budgetJsum = new BigDecimal(erpBudget.getBudgetJsum()); // 집행금액

                    // 집행금액 계산 ( ERPiU 반환된 집행금액 + 현재 지출결의 작성 금액 )
                    // 반환 후 계산방법 : 실행합 - 집행금액 - 현재 작성 금액
                    budgetJsum = budgetJsum.add(expendAmt);

                    // BigDecimal remainAmt = BigDecimal.ZERO;
                    // remainAmt = budgetActsum.subtract(budgetJsum); // 실행합금액 - 집행금액
                    // remainAmt = remainAmt.subtract(expendAmt); // (실행합금액 - 집행금액) - 지출결의 작성된 금액
                    // remainAmt = remainAmt.subtract(reqAmt); // ((실행합금액 - 집행금액) - 지출결의 작성된 금액) - 신청 금액

                    if (erpBudget.getBudgetControlYN().equals("B")) {
                        result.setBudgetControlYN(erpBudget.getBudgetControlYN());
                    } else {
                        result.setBudgetControlYN(params.get("ynControl").toString()); // [반환] 예산통제여부
                    }
                    result.setBudgetActsum(String.valueOf(budgetActsum)); // [반환] 실행합금액
                    result.setBudgetJsum(String.valueOf(budgetJsum)); // [반환] 집행금액
                } else {
                    result.setBudgetControlYN("N");
                    result.setBudgetActsum("0");
                    result.setBudgetJsum("0");
                }
            }
        }

        return result;
    }

	//지출결의 예산금액 확인 함수
	@Override
    public ExCodeBudgetVO ExBudgetAmtInfoSelect2 ( Map<String, Object> params ) throws Exception {
		ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
		//커넥션 연결
		//		params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
		/* 기본값 지정 - 연동 시스템 정보 처리 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
		/* 공통 parameter */
		budgetVo.setErpCompSeq( (String) params.get( "erpCompSeq" ) );
		budgetVo.setAmt( (String) params.get( "amt" ) );
		budgetVo.setCompSeq( (String)params.get("compSeq") );
		budgetVo.setBudgetCode( (String) params.get( "budgetCode" ) );
		budgetVo.setTpDrcr( (String) params.get( "drcrGbn" ) );
		budgetVo.setGroupSeq(CommonConvert.CommonGetEmpVO( ).getGroupSeq( ) );

		if ( params.get( "expendSeq" ) != null ) {
			budgetVo.setExpendSeq( params.get( "expendSeq" ).toString( ) );
		}
		if ( params.get( "listSeq" ) != null ) {
			budgetVo.setListSeq( params.get( "listSeq" ).toString( ) );
		}
		if ( params.get( "slipSeq" ) != null ) {
			budgetVo.setSlipSeq( params.get( "slipSeq" ).toString( ) );
		}
		if ( params.get( "comeHistory" ) != null ) {
            budgetVo.setIsComeHistory(Boolean.parseBoolean(params.get("comeHistory").toString()));
		}
		switch ( conVo.getErpTypeCode( ) ) {
			case commonCode.ICUBE:
				budgetVo.setBgacctCode( (String) params.get( "acctCode" ) );
				budgetVo.setBudYm( (String) params.get( "budgetYm" ) );
				budgetVo.setBudgetYm( (String) params.get( "budgetYm" ) );
				exBudgetServiceI.ExBudgetAmtInfoSelect2( budgetVo, conVo );
				break;
			case commonCode.ERPIU:
				budgetVo.setBgacctCode( (String) params.get( "bgacctCode" ) );
				budgetVo.setBudgetYm( params.get( "budgetYm" ).toString( ) );
				if ( params.get( "bizplanCode" ) == null || CommonConvert.CommonGetStr(params.get( "bizplanCode" )).equals( commonCode.EMPTYSTR ) || CommonConvert.CommonGetStr(params.get( "bizplanCode" )).equals( commonCode.EMPTYSEQ ) ) {
					budgetVo.setBizplanCode( "***" );
				}
				else {
					budgetVo.setBizplanCode( params.get( "bizplanCode" ).toString( ) );
				}
				budgetVo = ERPiUBudgetService.ExBudgetAmtInfoSelect2( budgetVo, conVo );
				break;
			case commonCode.ETC:
				break;
			case commonCode.BIZBOXA:
				break;
			default:
				throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
		}
		return budgetVo;
	}

	//예산초과 에러 확인
	@Override
    public List<ExCommonResultVO> ExBudgetErrorInfoSelect ( ExExpendVO expendVo ) throws Exception {
		List<ExCommonResultVO> resultList = new ArrayList<ExCommonResultVO>( );
		List<ExCodeBudgetVO> exList = exBudgetServiceADAO.ExExpendUseBudgetInfoSelect( expendVo );
//		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( expendVo.getCompSeq( ) ) );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( expendVo.getGroupSeq( ) ), CommonConvert.CommonGetStr( expendVo.getCompSeq( ) ) );
		/* 전체 금액과 잔액 비교를 위한 변수 */
		List<ExCodeBudgetVO> amtSum = new ArrayList<ExCodeBudgetVO>( );
		Map<String, Object> useAmtSum = new HashMap<String, Object>( );
		try {
			for ( ExCodeBudgetVO item : exList ) {
				Map<String, Object> budgetParam = new HashMap<String, Object>( );
				/* 공통 사용 */
				budgetParam.put( "erpCompSeq", expendVo.getErpCompSeq( ) );
				budgetParam.put( "budgetCode", item.getBudgetCode( ) );
				budgetParam.put( "amt", item.getDracctAmt( ) );
				budgetParam.put( "budgetYm", item.getBudgetYm( ) );
				budgetParam.put( "setTpDrcr", "dr" );
				budgetParam.put( commonCode.COMPSEQ, expendVo.getCompSeq( ) );
				budgetParam.put( commonCode.GROUPSEQ, expendVo.getGroupSeq( ) );
				/* iCUBE 사용 */
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
					budgetParam.put( "acctCode", item.getBgacctCode( ) );
				}
				/* ERPiU사용 */
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
					budgetParam.put( "bgacctCode", item.getBgacctCode( ) );
					budgetParam.put( "bgacctName", item.getBgacctName( ) );
					budgetParam.put( "bizplanCode", item.getBizplanCode( ) );
					budgetParam.put( "bizplanName", item.getBizplanName( ) );
				}
				/* 이미 조회했던 예산인지 여부 */
				boolean isFlag = false;
				ExCodeBudgetVO resultBudget = new ExCodeBudgetVO();;
				for (ExCodeBudgetVO temp : amtSum) {
					String budgetYm1 = temp.getBudgetYm();
					String budgetYm2 = item.getBudgetYm();
					if ( budgetYm1.length() > 6 ) {
						budgetYm1 = budgetYm1.substring( 0, 6 );
					}
					if ( budgetYm2.length() > 6 ) {
						budgetYm2 = budgetYm2.substring( 0, 6 );
					}
					if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
						if (temp.getErpCompSeq().equals(item.getErpCompSeq())
								&& budgetYm1.equals(budgetYm2)
								&& temp.getBudgetCode().equals(item.getBudgetCode())
								&& temp.getBgacctCode().equals(item.getBgacctCode())) {
							resultBudget.setBudgetCode( temp.getBudgetCode( ) );
							resultBudget.setBudgetName( temp.getBudgetName( ) );
							resultBudget.setBizplanCode( temp.getBizplanCode( ) );
							resultBudget.setBizplanName( temp.getBizplanName( ) );
							resultBudget.setBgacctCode( temp.getBgacctCode( ) );
							resultBudget.setBgacctName( temp.getBgacctName( ) );
							resultBudget.setBudgetControlYN( temp.getBudgetControlYN( ) );
							resultBudget.setAmt( item.getAmt( ) );
							resultBudget.setBudgetJsum( temp.getBudgetJsum( ) );
							resultBudget.setBudgetActsum( temp.getBudgetActsum( ) );
							isFlag = true;
							break;
						}
					} else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
						String bizplanCode1 = temp.getBizplanCode();
						String bizplanCode2 = item.getBizplanCode();
						if (bizplanCode1 == null || bizplanCode1.equals(commonCode.EMPTYSTR) || bizplanCode1.equals(commonCode.EMPTYSEQ)) {
							bizplanCode1 = "***";
						}
						if (bizplanCode2 == null || bizplanCode2.equals(commonCode.EMPTYSTR) || bizplanCode2.equals(commonCode.EMPTYSEQ)) {
							bizplanCode2 = "***";
						}
						if (temp.getErpCompSeq().equals(item.getErpCompSeq())
								&& budgetYm1.equals(budgetYm2)
								&& temp.getBudgetCode().equals(item.getBudgetCode())
								&& temp.getBgacctCode().equals(item.getBgacctCode())
								&& bizplanCode1.equals(bizplanCode2)) {
							resultBudget.setBudgetCode( temp.getBudgetCode( ) );
							resultBudget.setBudgetName( temp.getBudgetName( ) );
							resultBudget.setBizplanCode( temp.getBizplanCode( ) );
							resultBudget.setBizplanName( temp.getBizplanName( ) );
							resultBudget.setBgacctCode( temp.getBgacctCode( ) );
							resultBudget.setBgacctName( temp.getBgacctName( ) );
							resultBudget.setBudgetControlYN( temp.getBudgetControlYN( ) );
							resultBudget.setAmt( item.getAmt( ) );
							resultBudget.setBudgetJsum( temp.getBudgetJsum( ) );
							resultBudget.setBudgetActsum( temp.getBudgetActsum( ) );
							isFlag = true;
							break;
						}
					}
				}
				if (!isFlag) {
					/* 금액 조회 */
					resultBudget = ExBudgetAmtInfoSelect(budgetParam);
				}
				/* 총금액이 초과인지 판별하기 위한 변수 */
				ExCodeBudgetVO tBudget = new ExCodeBudgetVO( );
				tBudget.setBudgetCode( resultBudget.getBudgetCode( ) );
				tBudget.setBudgetName( resultBudget.getBudgetName( ) );
				tBudget.setBizplanCode( resultBudget.getBizplanCode( ) );
				tBudget.setBizplanName( resultBudget.getBizplanName( ) );
				tBudget.setBgacctCode( resultBudget.getBgacctCode( ) );
				tBudget.setBgacctName( resultBudget.getBgacctName( ) );
				tBudget.setBudgetControlYN( resultBudget.getBudgetControlYN( ) );
				tBudget.setAmt( resultBudget.getAmt( ) );
				tBudget.setBudgetJsum( new BigDecimal( resultBudget.getBudgetJsum( ) ).toString( ) );
				tBudget.setBudgetActsum( new BigDecimal( resultBudget.getBudgetActsum( ) ).toString( ) );
				tBudget.setExpendSeq( item.getExpendSeq( ) );
				tBudget.setListSeq( item.getListSeq( ) );
				tBudget.setSlipSeq( item.getSlipSeq( ) );
				tBudget.setDracctAmt( item.getDracctAmt( ) );
				/* 중복체크를 위한 변수 */
				tBudget.setErpCompSeq( item.getErpCompSeq() );
				tBudget.setBudgetYm( item.getBudgetYm() );
				amtSum.add( tBudget );
				if ( useAmtSum.get( resultBudget.getBudgetCode( ) + "_" + resultBudget.getBizplanCode( ) + "_" + resultBudget.getBgacctCode( ) ) != null ) {
					String sumAmt = useAmtSum.get( resultBudget.getBudgetCode( ) + "_" + resultBudget.getBizplanCode( ) + "_" + resultBudget.getBgacctCode( ) ).toString( );
					BigDecimal sumAmtD = new BigDecimal( sumAmt );
					sumAmtD = sumAmtD.add( new BigDecimal( resultBudget.getAmt( ) ) );
					useAmtSum.put( resultBudget.getBudgetCode( ) + "_" + resultBudget.getBizplanCode( ) + "_" + resultBudget.getBgacctCode( ), sumAmtD.toString( ) );
				}
				else {
					useAmtSum.put( resultBudget.getBudgetCode( ) + "_" + resultBudget.getBizplanCode( ) + "_" + resultBudget.getBgacctCode( ), new BigDecimal( resultBudget.getAmt( ) ).toString( ) );
				}
			}
			/* 차변의 계정 별 예산을 합하여 예산 잔액과 비교한다.(ex:한개의 전표를 예산에 딱맞게 쓰고 복사 또는 새로 작성한 경우 정상적으로 생성되기 때문에 에러 표시) */
			for ( ExCodeBudgetVO temp : amtSum ) {
				/* 잔액 계산 변수 선언 */
				// 사용 합 금액은 위에서 계산한 합계 금액으로 사용한다.
				BigDecimal amt = new BigDecimal( useAmtSum.get( temp.getBudgetCode( ) + "_" + temp.getBizplanCode( ) + "_" + temp.getBgacctCode( ) ).toString( ) ); /* 해당 예산단위,사업계획,예산계정의 사용 합 금액(그룹웨어) */
				BigDecimal jsum = new BigDecimal( temp.getBudgetJsum( ) ); /* 실행금액(그룹웨어 제외) */
				BigDecimal actSum = new BigDecimal( temp.getBudgetActsum( ) ); /* 편성금액 */
				BigDecimal useAmt = jsum;
				// 결재중 수정인 경우 ERPiU는 예산이 ERP에 잡혀 있으므로 그룹웨어 금액을 더하지 않는다.
				if ( CommonConvert.CommonGetStr(expendVo.getExpendStatCode( )).equals( commonCode.EMPTYSTR ) || CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
					useAmt = jsum.add( amt ); /* 그룹웨어 + ERP 금액 */
				}
				BigDecimal totalAmt = actSum.subtract( useAmt ); /* 잔액 */
				BigDecimal zero = new BigDecimal( commonCode.EMPTYSEQ );
				ExCommonResultVO budgetVo = new ExCommonResultVO( );
				switch ( conVo.getErpTypeCode( ) ) {
					case commonCode.ICUBE:
						if ( totalAmt.compareTo( zero ) == -1 && CommonConvert.CommonGetStr(temp.getBudgetControlYN( )).equals( "Y" ) ) {
							budgetVo.setValidateStat( "false" );
							budgetVo.setError( "예산을 초과하였습니다.(초과금액 :" + totalAmt.toString( ) + ")" );
							budgetVo.setMessage( "예산사용불가" );
						}
						else if ( CommonConvert.CommonGetStr(temp.getBudgetControlYN( )).equals( "B" ) ) {
							budgetVo.setValidateStat( "false" );
							budgetVo.setError( "예산이 미편성되었습니다." );
							budgetVo.setMessage( "예산사용불가" );
						}
						else {
							budgetVo.setValidateStat( "true" );
							budgetVo.setError( "예산을 사용할 수 있습니다." );
							budgetVo.setMessage( "예산사용가능" );
						}
						budgetVo.setExpendSeq( temp.getExpendSeq( ) );
						budgetVo.setListSeq( temp.getListSeq( ) );
						budgetVo.setSlipSeq( temp.getSlipSeq( ) );
						budgetVo.setValidateCode( "budget" );
						resultList.add( budgetVo );
						break;
					case commonCode.ERPIU:
						/* ERPiU의 경우 그룹웨어 예산을 조회하지 않기 때문에 현재 체크하는 전표의 금액정보가 포함되어 있지 않다. */ // 위에서 budget 정보에 금액 추가해준다.
						//						amt = new BigDecimal( temp.getDracctAmt( ) );
						if ( totalAmt.compareTo( zero ) == -1 && CommonConvert.CommonGetStr(temp.getBudgetControlYN( )).equals( "Y" ) ) {
							budgetVo.setValidateStat( "false" );
							budgetVo.setError( "예산을 초과하였습니다.(초과금액 :" + totalAmt.toString( ) + ")" );
							budgetVo.setMessage( "예산사용불가" );
						}
						else {
							budgetVo.setValidateStat( "true" );
							budgetVo.setError( "예산을 사용할 수 있습니다." );
							budgetVo.setMessage( "예산사용가능" );
						}
						budgetVo.setExpendSeq( temp.getExpendSeq( ) );
						budgetVo.setListSeq( temp.getListSeq( ) );
						budgetVo.setSlipSeq( temp.getSlipSeq( ) );
						budgetVo.setExpendSeq( temp.getExpendSeq( ) );
						budgetVo.setValidateCode( "budget" );
						resultList.add( budgetVo );
						break;
					case commonCode.ETC:
						break;
					case commonCode.BIZBOXA:
						break;
					default:
						throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
				}
			}
		}
		catch ( Exception ex ) {
			//System.out.println( ex.getMessage( ) );
			cmLog.CommonSetInfo( "예산초과 에러 확인 : " + ex.getMessage( ) );
		}
		return resultList;
	}

	//예산초과 에러 확인 수정
	@Override
    @SuppressWarnings("unchecked")
    public List<ExCommonResultVO> ExBudgetErrorInfoSelect2(ExExpendVO expendVo) throws Exception {

        if (expendVo.getErpiuBudgetVer() != null && expendVo.getErpiuBudgetVer().equals("2.0")) {
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
            List<ExCommonResultVO> resultList = new ArrayList<ExCommonResultVO>();
            List<ExCodeBudgetVO> exList = exBudgetServiceADAO.ExExpendUseBudgetInfoSelect2(expendVo);
            Map<String, Object> budgetListInfo = new HashMap<String, Object>();

            /* 기본값 지정 - 연동 시스템 정보 처리 */
            ConnectionVO con = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(expendVo.getCompSeq()));

            try {
              for (ExCodeBudgetVO item : exList) {
                  item.setErpCompSeq(expendVo.getErpCompSeq());
                  item.setBudgetYm(expendVo.getExpendDate());

                  ExCodeBudgetVO erpBudget = ERPiUBudgetService.UP_FI_Z_BIZBOX_BUDGET_DATA(item, con);
                  BigDecimal budgetActsum = new BigDecimal(erpBudget.getBudgetActsum()); // 실행합금액
                  BigDecimal budgetJsum = new BigDecimal(erpBudget.getBudgetJsum()); // 집행금액

                  BigDecimal expendJsum = BigDecimal.ZERO;
                  if(expendVo.getExpendStatCode().equals("10")
                        || expendVo.getExpendStatCode().equals("20")
                        || expendVo.getExpendStatCode().equals("30")
                        || expendVo.getExpendStatCode().equals("40")
                        || expendVo.getExpendStatCode().equals("50")
                        || expendVo.getExpendStatCode().equals("60")
                        || expendVo.getExpendStatCode().equals("70")
                        || expendVo.getExpendStatCode().equals("80")
                        || expendVo.getExpendStatCode().equals("90")) {
                  expendJsum = BigDecimal.ZERO;
                  } else {
                     expendJsum = new BigDecimal(item.getAmt()); // 지출결의 작성 금액
                  }

                  ExCommonResultVO budgetVo = new ExCommonResultVO();
                    /**
                     * # BigDecimal 비교 - BigDecimal 의 수치가 비교값 보다 작으면 -1 - BigDecimal 의 수치가 비교값 보다 같으면 0 - BigDecimal 의 수치가 비교값 보다 크면 1
                     */
                    if (budgetActsum.subtract(budgetJsum.add(expendJsum)).compareTo(BigDecimal.ZERO) < 0) {

                        DecimalFormat decForm = new DecimalFormat("#,##0");
                        BigDecimal resultBudgetAmt = budgetActsum.subtract(budgetJsum.add(expendJsum));

                        // 예산 초과
                        budgetVo.setValidateStat("false");
                        budgetVo.setError("예산을 초과하였습니다.(초과금액 :" + decForm.format(resultBudgetAmt) + ")");
                        budgetVo.setMessage("예산사용불가");
                        budgetVo.setExpendSeq(item.getExpendSeq());
                        budgetVo.setListSeq(item.getListSeq());
                        budgetVo.setSlipSeq(item.getSlipSeq());
                        budgetVo.setValidateCode("budget");
                        resultList.add(budgetVo);
                    } else {
                        // 예산 미초과
                        budgetVo.setValidateStat("true");
                        budgetVo.setError("예산을 사용할 수 있습니다.");
                        budgetVo.setMessage("예산사용가능");
                        budgetVo.setExpendSeq(item.getExpendSeq());
                        budgetVo.setListSeq(item.getListSeq());
                        budgetVo.setSlipSeq(item.getSlipSeq());
                        budgetVo.setValidateCode("budget");
                        resultList.add(budgetVo);
                    }
                }
            } catch (Exception e) {
                //System.out.println(e.getMessage());
                cmLog.CommonSetInfo("예산초과 에러 확인 : " + e.getMessage());
            }

            return resultList;
        } else {
            List<ExCommonResultVO> resultList = new ArrayList<ExCommonResultVO>();
            List<ExCodeBudgetVO> exList = exBudgetServiceADAO.ExExpendUseBudgetInfoSelect(expendVo);
            Map<String, Object> budgetListInfo = new HashMap<String, Object>();
            List<Map<String, Object>> removeDuplicatBudget = new ArrayList<Map<String, Object>>();
            /* 기본값 지정 - 연동 시스템 정보 처리 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(expendVo.getCompSeq()));
            try {
                for (ExCodeBudgetVO item : exList) {
                    /* 변수 */
                    Map<String, Object> tBudget = new HashMap<String, Object>();
                    tBudget.put("compSeq", expendVo.getCompSeq());
                    tBudget.put("erpCompSeq", expendVo.getErpCompSeq());
                    tBudget.put("expendSeq", expendVo.getExpendSeq());
                    tBudget.put("acctCode", item.getBgacctCode());
                    tBudget.put("budgetCode", item.getBudgetCode());
                    tBudget.put("budgetName", item.getBudgetName());
                    tBudget.put("bizplanCode", item.getBizplanCode());
                    tBudget.put("bizplanName", item.getBizplanName());
                    tBudget.put("bgacctCode", item.getBgacctCode());
                    tBudget.put("bgacctName", item.getBgacctName());
                    tBudget.put("budgetGbn", item.getBudgetGbn());
                    tBudget.put("budgetYm", item.getBudgetYm());
                    tBudget.put("drcrGbn", item.getTpDrcr());
                    tBudget.put("amt", item.getDracctAmt());
                    tBudget.put("expendList", (item.getExpendSeq() + "_" + item.getListSeq() + "_" + item.getSlipSeq()));
                    tBudget.put("comeHistory", expendVo.getComeHistory());
                    /* 동일한 예산정보인지 확인 */
                    if (budgetListInfo.get(item.getBudgetCode() + "_" + item.getBizplanCode() + "_" + item.getBgacctCode()) != null) {
                        Map<String, Object> tempData = (Map<String, Object>) budgetListInfo.get(item.getBudgetCode() + "_" + item.getBizplanCode() + "_" + item.getBgacctCode());
                        /* 금액정보 추가 */
                        BigDecimal amt = new BigDecimal(tempData.get("amt").toString());
                        BigDecimal itemAmt = new BigDecimal(item.getDracctAmt());
                        /* 지출결의 정보 추가 */
                        String expendList = tempData.get("expendList").toString();
                        expendList = expendList + "|" + item.getExpendSeq() + "_" + item.getListSeq() + "_" + item.getSlipSeq();
                        tempData.put("amt", amt.add(itemAmt));
                        tempData.put("expendList", expendList);
                        continue;
                    } else {
                        budgetListInfo.put(item.getBudgetCode() + "_" + item.getBizplanCode() + "_" + item.getBgacctCode(), tBudget);
                        removeDuplicatBudget.add(tBudget);
                    }
                }
                for (Map<String, Object> tBudget : removeDuplicatBudget) {
                    /* 예산정보 조회 */
                    ExCodeBudgetVO tResult = new ExCodeBudgetVO();
                    Map<String, Object> tData = (Map<String, Object>) budgetListInfo.get(tBudget.get("budgetCode").toString() + "_" + tBudget.get("bizplanCode").toString() + "_" + tBudget.get("bgacctCode").toString());
                    /* 금액 */
                    tBudget.put("amt", tData.get("amt").toString());
                    tResult = ExBudgetAmtInfoSelect2(tBudget);
                    /* 지출결의 정보 저장 변수 */
                    String[] expendList = tData.get("expendList").toString().split("\\|");
                    /* 예산 초과 여부 확인 */
                    BigDecimal jsumAmt = new BigDecimal(tResult.getBudgetJsum()); /* 실행금액(그룹웨어 제외) */
                    BigDecimal actAmt = new BigDecimal(tResult.getBudgetActsum()); /* 편성금액 */
                    BigDecimal zero = new BigDecimal(commonCode.EMPTYSEQ);
                    BigDecimal subTract = new BigDecimal(commonCode.EMPTYSEQ);
                    subTract = actAmt.subtract(jsumAmt);
                    /* 0 : 정상, 1 : 예산초과, 2 : 예산미편성 */
                    String hasError = "0";
                    DecimalFormat decForm = new DecimalFormat("#,##0");
                    switch (conVo.getErpTypeCode()) {
                        case commonCode.ICUBE:
                            if (subTract.compareTo(zero) == -1 && CommonConvert.CommonGetStr(tResult.getBudgetControlYN()).equals("Y")) {
                                hasError = "1";
                            } else if (CommonConvert.CommonGetStr(tResult.getBudgetControlYN()).equals("B")) {
                                hasError = "2";
                            } else {
                                hasError = "0";
                            }
                            /* 동일 지출결의에 대하여 예산 초과 오류 표시 */
                            for (String expendInfo : expendList) {
                                ExCommonResultVO budgetVo = new ExCommonResultVO();
                                switch (hasError) {
                                    case "0":
                                        budgetVo.setValidateStat("true");
                                        budgetVo.setError("예산을 사용할 수 있습니다.");
                                        budgetVo.setMessage("예산사용가능");
                                        budgetVo.setExpendSeq(expendInfo.split("_")[0]);
                                        budgetVo.setListSeq(expendInfo.split("_")[1]);
                                        budgetVo.setSlipSeq(expendInfo.split("_")[2]);
                                        budgetVo.setValidateCode("budget");
                                        resultList.add(budgetVo);
                                        break;
                                    case "1":
                                        budgetVo.setValidateStat("false");
                                        budgetVo.setError("예산을 초과하였습니다.(초과금액 :" + decForm.format(subTract) + ")");
                                        budgetVo.setMessage("예산사용불가");
                                        budgetVo.setExpendSeq(expendInfo.split("_")[0]);
                                        budgetVo.setListSeq(expendInfo.split("_")[1]);
                                        budgetVo.setSlipSeq(expendInfo.split("_")[2]);
                                        budgetVo.setValidateCode("budget");
                                        resultList.add(budgetVo);
                                        break;
                                    case "2":
                                        budgetVo.setValidateStat("false");
                                        budgetVo.setError("예산이 미편성되었습니다.");
                                        budgetVo.setMessage("예산사용불가");
                                        budgetVo.setExpendSeq(expendInfo.split("_")[0]);
                                        budgetVo.setListSeq(expendInfo.split("_")[1]);
                                        budgetVo.setSlipSeq(expendInfo.split("_")[2]);
                                        budgetVo.setValidateCode("budget");
                                        resultList.add(budgetVo);
                                        break;
                                    default:
                                        break;
                                }
                            }
                            break;
                        case commonCode.ERPIU:
                            /* ERPiU의 경우 그룹웨어 예산을 조회하지 않기 때문에 현재 체크하는 전표의 금액정보가 포함되어 있지 않다. */ // 위에서 budget 정보에 금액 추가해준다.
                            // amt = new BigDecimal( temp.getDracctAmt( ) );
                            if (subTract.compareTo(zero) == -1 && CommonConvert.CommonGetStr(tResult.getBudgetControlYN()).equals("Y")) {
                                hasError = "1";
                            } else {
                                hasError = "0";
                            }
                            /* 동일 지출결의에 대하여 예산 초과 오류 표시 */
                            for (String expendInfo : expendList) {
                                ExCommonResultVO budgetVo = new ExCommonResultVO();
                                switch (hasError) {
                                    case "0":
                                        budgetVo.setValidateStat("true");
                                        budgetVo.setError("예산을 사용할 수 있습니다.");
                                        budgetVo.setMessage("예산사용가능");
                                        budgetVo.setExpendSeq(expendInfo.split("_")[0]);
                                        budgetVo.setListSeq(expendInfo.split("_")[1]);
                                        budgetVo.setSlipSeq(expendInfo.split("_")[2]);
                                        budgetVo.setValidateCode("budget");
                                        resultList.add(budgetVo);
                                        break;
                                    case "1":
                                        budgetVo.setValidateStat("false");
                                        budgetVo.setError("예산을 초과하였습니다.(초과금액 :" + decForm.format(subTract) + ")");
                                        budgetVo.setMessage("예산사용불가");
                                        budgetVo.setExpendSeq(expendInfo.split("_")[0]);
                                        budgetVo.setListSeq(expendInfo.split("_")[1]);
                                        budgetVo.setSlipSeq(expendInfo.split("_")[2]);
                                        budgetVo.setValidateCode("budget");
                                        resultList.add(budgetVo);
                                        break;
                                    default:
                                        break;
                                }
                            }
                            break;
                        case commonCode.ETC:
                            break;
                        case commonCode.BIZBOXA:
                            break;
                        default:
                            throw new Exception("연동시스템 구분이 정의되지 않았습니다.");
                    }
                }
            } catch (Exception ex) {
                //System.out.println(ex.getMessage());
                cmLog.CommonSetInfo("예산초과 에러 확인 : " + ex.getMessage());
            }
            return resultList;
        }
    }

	// 항목단위 입력 시 차/대변 금액 일치 여부 및 항목 과 분개 총 금액 일치 여부 확인
	@Override
    public List<ExCommonResultVO> ExExpendSlipAmtChkSelect ( Map<String, Object> params ) throws Exception {
		/* 변수 정의 */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		List<ExCommonResultVO> budgetListVo = new ArrayList<ExCommonResultVO>( );
		/* 금액 정보 */
		result = exBudgetServiceADAO.ExExpendSlipAmtChkSelect( params );
		if ( result != null && result.size( ) > 0 ) {
			for ( Map<String, Object> tResult : result ) {
				if ( CommonConvert.CommonGetStr(tResult.get( "sameDrCrAmt" )).equals( commonCode.EMPTYNO ) ) {
					ExCommonResultVO tBudgetVo = new ExCommonResultVO( );
					tBudgetVo.setValidateStat( "false" );
					tBudgetVo.setError( "차변 금액과 대변 금액이 다릅니다." );
					tBudgetVo.setExpendSeq( params.get( "expendSeq" ).toString( ) );
					tBudgetVo.setListSeq( tResult.get( "listSeq" ).toString( ) );
					tBudgetVo.setValidateCode( "amt" );
					budgetListVo.add( tBudgetVo );
				}
				if ( CommonConvert.CommonGetStr(tResult.get( "sameListSlipAmt" )).equals( commonCode.EMPTYNO ) ) {
					ExCommonResultVO tBudgetVo = new ExCommonResultVO( );
					tBudgetVo.setValidateStat( "false" );
					tBudgetVo.setError( "항목 금액과 분개 합계금액이 다릅니다." );
					tBudgetVo.setExpendSeq( params.get( "expendSeq" ).toString( ) );
					tBudgetVo.setListSeq( tResult.get( "listSeq" ).toString( ) );
					tBudgetVo.setValidateCode( "amt" );
					budgetListVo.add( tBudgetVo );
				}
			}
		}
		return budgetListVo;
	}

	// 분개단위 입력 시 차/대변 금액 일치 여부 확인
	@Override
    public List<ExCommonResultVO> ExExpendSlipAmtChkSelectSlipMode ( Map<String, Object> params ) throws Exception {
		/* 변수 정의 */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		List<ExCommonResultVO> budgetListVo = new ArrayList<ExCommonResultVO>( );
		/* 금액 정보 */
		result = exBudgetServiceADAO.ExExpendSlipAmtChkSelectSlipMode( params );
		if ( result != null && result.size( ) > 0 ) {
			for ( Map<String, Object> tResult : result ) {
				if ( CommonConvert.CommonGetStr(tResult.get( "sameDrCrAmt" )).equals( commonCode.EMPTYNO ) ) {
					ExCommonResultVO tBudgetVo = new ExCommonResultVO( );
					tBudgetVo.setValidateStat( "false" );
					tBudgetVo.setError( "차변 금액과 대변 금액이 다릅니다." );
					tBudgetVo.setExpendSeq( params.get( "expendSeq" ).toString( ) );
					tBudgetVo.setListSeq( tResult.get( "listSeq" ).toString( ) );
					tBudgetVo.setSlipSeq( tResult.get( "slipSeq" ).toString( ) );
					tBudgetVo.setValidateCode( "amt" );
					budgetListVo.add( tBudgetVo );
				}
			}
		}
		return budgetListVo;
	}

	//인터락 예산정보 가져오기
	@Override
    public Boolean ExInterlockUseBudgetInfoSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "ERPiU 예산체크 진입" );
		if ( params != null ) {
			cmLog.CommonSetInfo( "파라미터 : " + params );
		}
		Boolean budgetOver = false;
		Map<String, Object> compMap = new HashMap<String, Object>( );
		List<ExCommonResultVO> commonResult = new ArrayList<ExCommonResultVO>( );
		compMap = exBudgetServiceADAO.ExInterlockCompInfoSelect( params );
		cmLog.CommonSetInfo( "compMap 확인 : " + compMap.toString( ) );
		ExExpendVO expendVo = new ExExpendVO( );
		/* 예산사용 옵션인 경우에만 체크를 수행한다. */ /* 값이 없을 경우 NULL 에 대한 보완 처리 */
		if ( CommonConvert.CommonGetStr(compMap.get( "budgetYN" )).equals( commonCode.EMPTYYES ) ) {
			expendVo.setGroupSeq( CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ) );
			expendVo.setCompSeq( compMap.get( "compSeq" ).toString( ) );
			expendVo.setErpCompSeq( compMap.get( "erpCompSeq" ).toString( ) );
			expendVo.setExpendSeq( compMap.get( "expendSeq" ).toString( ) );
			expendVo.setDocSeq( compMap.get( "docSeq" ).toString( ) );
			switch ( compMap.get( "erpType" ).toString( ) ) {
				case commonCode.ICUBE:
					cmLog.CommonSetInfo( "iCUBE 확인" );
					commonResult = ExBudgetErrorInfoSelect( expendVo );
					for ( ExCommonResultVO item : commonResult ) {
						if ( CommonConvert.CommonGetStr( item.getValidateStat( ) ).equals( "false" ) ) {
							budgetOver = true;
							break;
						}
					}
					break;
				case commonCode.ERPIU:
					/* 예산 초과 확인 */
					cmLog.CommonSetInfo( "iU 확인" );
					commonResult = ExBudgetErrorInfoSelect( expendVo );
					for ( ExCommonResultVO item : commonResult ) {
						if ( CommonConvert.CommonGetStr( item.getValidateStat( ) ).equals( "false" ) ) {
							budgetOver = true;
							break;
						}
					}
					break;
				default:
					break;
			}
		}
		return budgetOver;
	}

	//ERPiU 예산넣기(임시데이터 생성)
	@Override
    public Boolean ExInterLockERPiURowInsert ( Map<String, Object> params ) throws Exception {
		Boolean insertYN = false;
		Map<String, Object> compMap = new HashMap<String, Object>( );
		/* 기본정보 가져오기 */
		compMap = exBudgetServiceADAO.ExInterlockCompInfoSelect( params );
		Map<String, Object> erpiUParam = new HashMap<String, Object>( );
		List<Map<String, Object>> resultData = new ArrayList<Map<String, Object>>( );
		erpiUParam.put( "expendSeq", compMap.get( "expendSeq" ) );
		erpiUParam.put( "groupSeq", params.get("groupSeq") );
		resultData = exBudgetServiceADAO.ExInterlockERPiUBudgetInfoSelect( erpiUParam );
		/* 커넥션 정보 생성 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ), CommonConvert.CommonGetStr( compMap.get( "compSeq" ) ) );
		if ( CommonConvert.CommonGetStr(compMap.get( "budgetYN" )).equals( commonCode.EMPTYYES ) ) {
			for ( Map<String, Object> item : resultData ) {
				/* 결재 상신 이후 항목 수정 시 수정한 항목만 진행되게 변경/ 상신 or 임시보관은 기존 로직대로 진행 */
				if ( params.get( "newListSeq" ) != null ) {
					if ( params.get( "newSlipSeq" ) == null ) { // 항목 추가 및 수정
						String newListSeq = params.get( "newListSeq" ).toString( );
						if ( !newListSeq.equals( item.get( "listSeq" ) ) ) {
							continue;
						}
					}
					else { // 분개 추가 및 수정
						String newListSeq = params.get( "newListSeq" ).toString( );
						String newSlipSeq = params.get( "newSlipSeq" ).toString( );
						if ( !newListSeq.equals( item.get( "listSeq" ) ) ) {
							continue;
						}
						else if ( !newSlipSeq.equals( item.get( "slipSeq" ) ) ) {
							continue;
						}
					}
				}
				/* row 생성 */
				ExCommonResultVO resultVo = new ExCommonResultVO( );
				resultVo = exBudgetServiceUDAO.ExExpendGmmsumOtherInfoInsert( item, conVo );
				if ( !CommonConvert.CommonGetStr(resultVo.getCode( )).equals( commonCode.SUCCESS ) ) {
					insertYN = false;
					break;
				}
				else {
					ExExpendSlipVO slipVo = new ExExpendSlipVO( );
					slipVo.setExpendSeq( (String) item.get( "expendSeq" ) );
					slipVo.setListSeq( (String) item.get( "listSeq" ) );
					slipVo.setSlipSeq( (String) item.get( "slipSeq" ) );
					slipVo.setRowId( (String) item.get( "rowId" ) );
					slipVo.setRowNo( (String) item.get( "rowNo" ) );
					slipVo.setGroupSeq( (String) item.get( "groupSeq" ) );
					ExCommonResultVO updateVo = new ExCommonResultVO( );
					/* 그룹웨어 row정보 업데이트 수행 */
					updateVo = exUserSlipServiceADAO.ExSlipBudgetInfoUpdate( slipVo );
					if ( !CommonConvert.CommonGetStr(updateVo.getCode( )).equals( commonCode.SUCCESS ) ) {
						insertYN = false;
					}
					insertYN = true;
				}
			}
		}
		else {
			insertYN = true;
		}
		return insertYN;
	}

	//ERPiU 예산삭제(임시데이터 삭제)
	@Override
    public Boolean ExInterLockERPiURowDelete ( Map<String, Object> params ) throws Exception {
		Boolean deleteYN = false;
		Map<String, Object> compMap = new HashMap<String, Object>( );
		List<Map<String, Object>> rowResultList = new ArrayList<Map<String, Object>>( );
		/* 기본정보 가져오기 */
		compMap = exBudgetServiceADAO.ExInterlockCompInfoSelect( params );
		/* 커넥션 정보 생성 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( compMap.get( "groupSeq" ) ), CommonConvert.CommonGetStr( compMap.get( "compSeq" ) ) );
		/* row 정보 가져오기 */
		Map<String, Object> erpiUParam = new HashMap<String, Object>( );
		erpiUParam.put( "expendSeq", compMap.get( "expendSeq" ) );
		erpiUParam.put( "groupSeq", compMap.get( "groupSeq" ) );
		rowResultList = exBudgetServiceADAO.ExInterlockERPiURowInfoSelect( erpiUParam );

		if ( CommonConvert.CommonGetStr(compMap.get( "budgetYN" )).equals( commonCode.EMPTYYES ) && rowResultList.size() != 0 ) {

			for ( Map<String, Object> item : rowResultList ) {
				/* 결재 상신 이후 항목 수정 시 수정한 항목만 진행되게 변경/ 상신 or 임시보관은 기존 로직대로 진행(아래 변수가 없으므로 기존과 동일하게 진행) */
				if ( (params.get( "newListSeq" ) != null || params.get( "newSlipSeq" ) != null) && params.get( "isEditList" ) != null ) {
					/*
					 * 지출결의 삭제 로직도 이 메소드 타기때문에 수정 여부 체크 진행.
					 * 수정인 경우 : 전체 항목 중 변경된 항목만 삭제 처리
					 * 삭제인 경우 : 선택한 항목들만 삭제 처리
					 */
					// 수정에서 들어온 경우 true, 삭제에서 들어온 경우 false
					boolean isEditList = Boolean.parseBoolean( params.get( "isEditList" ).toString( ) );
					if ( isEditList ) {
						if ( params.get( "newSlipSeq" ) == null ) { // 항목 변경 시 기존 항목 삭제
							String newListSeq = params.get( "newListSeq" ).toString( );
							if ( !newListSeq.equals( item.get( "listSeq" ) ) && isEditList ) {
								continue;
							}
						}
						else { // 분개 변경 시 기존 분개 삭제
							String newListSeq = params.get( "newListSeq" ).toString( );
							String newSlipSeq = params.get( "newSlipSeq" ).toString( );
							if ( !newListSeq.equals( item.get( "listSeq" ) ) ) {
								continue;
							}
							else if ( !newSlipSeq.equals( item.get( "slipSeq" ) ) ) {
								continue;
							}
						}
					}
					else {
						if ( params.get( "newListSeq" ) != null ) {/* 항목 삭제 */
							@SuppressWarnings ( "unchecked" )
							List<ExExpendListVO> newListSeq = (List<ExExpendListVO>) params.get( "newListSeq" );
							boolean isSameSeq = false;
							for ( ExExpendListVO tList : newListSeq ) {
								if ( CommonConvert.CommonGetStr(tList.getListSeq( )).equals( item.get( "listSeq" ) ) ) {
									isSameSeq = true;
									break;
								}
							}
							if ( !isSameSeq ) {
								continue;
							}
						}
						else if ( params.get( "newSlipSeq" ) != null ) {/* 분개 삭제 */
							@SuppressWarnings ( "unchecked" )
							List<ExExpendSlipVO> newSlipSeq = (List<ExExpendSlipVO>) params.get( "newSlipSeq" );
							boolean isSameSeq = false;
							for ( ExExpendSlipVO tSlip : newSlipSeq ) {
								if ( CommonConvert.CommonGetStr(tSlip.getListSeq( )).equals( item.get( "listSeq" ) ) && CommonConvert.CommonGetStr(tSlip.getSlipSeq( )).equals( item.get( "slipSeq" ) ) ) {
									isSameSeq = true;
									break;
								}
							}
							if ( !isSameSeq ) {
								continue;
							}
						}
					}
				}
				//삭제 시작
				ExCommonResultVO resultVo = new ExCommonResultVO( );
				resultVo = exBudgetServiceUDAO.ExExpendGmmsumOtherInfoDelete( item, conVo );
				if ( !CommonConvert.CommonGetStr(resultVo.getCode() ).equals( commonCode.SUCCESS ) ) {
					deleteYN = false;
					break;
				}
				else {
					ExExpendSlipVO slipVo = new ExExpendSlipVO( );
					slipVo.setExpendSeq( (String) item.get( "expendSeq" ) );
					slipVo.setListSeq( (String) item.get( "listSeq" ) );
					slipVo.setSlipSeq( (String) item.get( "slipSeq" ) );
					slipVo.setRowId( commonCode.EMPTYSTR );
					slipVo.setRowNo( commonCode.EMPTYSTR );
					slipVo.setGroupSeq( (String) item.get( "groupSeq" ) );
					ExCommonResultVO updateVo = new ExCommonResultVO( );
					/* 그룹웨어 row정보 업데이트 수행 */
					updateVo = exUserSlipServiceADAO.ExSlipBudgetInfoUpdate( slipVo );
					if ( !CommonConvert.CommonGetStr(updateVo.getCode( )).equals( commonCode.SUCCESS ) ) {
						deleteYN = false;
					}
					deleteYN = true;
				}
			}
		}
		else {
			deleteYN = true;
		}
		return deleteYN;
	}

    // 카드, 계산서 반영 시 예산 체크 로직(ERPiU 상위레벨 예산 체크 포함)
    @Override
    public ResultVO ExInterfaceBudgetInfoCheck2(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ResultVO result = new ResultVO();

        // cdBgLevel : 예산통제레벨계정 ( 실제 해당 계정으로 예산 금액을 집계한다. )
        // ynControl : 예산통제여부 ( N => 통제안함 / Y => 통제 )
        // tpControl : 예산통제기준 ( 1 => 예산단위통제 / 2 => 예산계정통제 )

        try {
            /**
             * 예산체크 로직 순서 1. 예산 통제 여부 판단 2. 예산 조회 ( ERP 및 그룹웨어 ) 3. 현재 작성중인 지출결의 예산 정보 조회 ( 결재중 수정이 아닌 경우만 해당 - 문서가 상신되지 않은 경우 ( 임시보관, 상신, 종결 수정 ) ) 4. 예산 잔액 계산
             */

            if (params.get("cdBgLevel") == null || params.get("cdBgLevel").toString().equals("")) {
                logger.error("ERPiU 예산편성이 잘못되었습니다. ERPiU 예산계정의 예산통제 레벨 설정을 확인해주세요. [" + params.toString() + "]");
                throw new Exception("ERPiU 예산편성이 잘못되었습니다. ( ERPiU 예산계정의 예산통제 레벨 설정을 확인해주세요. )");
            }

            if (params.get("ynControl") != null && params.get("ynControl").toString().equals("N")) {
                logger.info("예산미통제 계정입니다. 예산체크를 진행하지 않습니다. [" + params.toString() + "]");
                return result;
            }

            // iCUBE 사용은 고려되지 않습니다.
            // 해당 기능은 ERPiU 연동 전용 기능입니다.
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                // 변수정의
                boolean isApprovalEditMode = false;
                ExCodeBudgetVO budget = new ExCodeBudgetVO();
                Map<String, Object> budgetParam = new HashMap<String, Object>();
                ExCodeBudgetVO resultBudget = new ExCodeBudgetVO();

                budget.setBudgetCode(params.get("budgetCode").toString());
                budget.setBizplanCode((params.get("bizplanCode") == null ? "" : params.get("bizplanCode").toString()));
                budget.setBgacctCode(params.get("bgacctCode").toString());

                // 사업계획 예외처리
                if (budget.getBizplanCode().equals("") || budget.getBizplanCode().equals("0")) {
                    budget.setBizplanCode("***"); // 사업계획을 사용하지 않는 경우에는 ERPiU 에서 프로세스 처리를 위하여 "***" 처리한다.
                }

                // 금액조회
                budgetParam.put("erpCompSeq", params.get("erpCompSeq").toString()); // ERPiU 회사코드
                budgetParam.put("compSeq", params.get("compSeq").toString()); // GW 회사 시퀀
                budgetParam.put("tpDrcr", "1"); // 차대 구분
                budgetParam.put("amt", params.get("amt").toString()); // 금액

                budgetParam.put("budgetYm", params.get("budgetYm").toString()); // 예산년월
                budgetParam.put("budgetCode", params.get("budgetCode").toString()); // 예산단위 코드
                budgetParam.put("budgetName", params.get("budgetName").toString()); // 예산단위 명칭
                budgetParam.put("bizplanCode", params.get("bizplanCode").toString()); // 사업계획 코드
                budgetParam.put("bizplanName", params.get("bizplanName").toString()); // 사업계획 명칭
                budgetParam.put("bgacctCode", params.get("bgacctCode").toString()); // 예산계정 코드
                budgetParam.put("bgacctName", params.get("bgacctName").toString()); // 예산계정 명칭

                budgetParam.put("cdBgLevel", params.get("cdBgLevel").toString()); // 예산통제레벨계정
                budgetParam.put("ynControl", params.get("ynControl").toString()); // 예산통제여부
                budgetParam.put("tpControl", params.get("tpControl").toString()); // 예산통제기준

                // ERPiU 예산잔액 확인
                resultBudget = ExBudgetAmtInfoSelectERPiU(budgetParam);

                /* 결재중 수정 여부 확인 */
                if (params.get("isApprovalEditMode") != null) {
                    isApprovalEditMode = Boolean.parseBoolean(params.get("isApprovalEditMode").toString());
                }

                BigDecimal expendAmt = BigDecimal.ZERO;
                if (params.get("expendSeq") != null && !params.get("expendSeq").toString().equals("") && !params.get("expendSeq").toString().equals("0")) {

                    Map<String, Object> expendBudgetParam = new HashMap<String, Object>();
                    expendBudgetParam.put("groupSeq", CommonConvert.CommonGetEmpVO().getGroupSeq());
                    expendBudgetParam.put("expendSeq", params.get("expendSeq"));
                    expendBudgetParam.put("budgetCode", params.get("budgetCode"));
                    expendBudgetParam.put("bizplanCode", params.get("bizplanCode"));
                    expendBudgetParam.put("cdBgLevel", params.get("cdBgLevel"));
                    expendBudgetParam.put("budgetYm", params.get("budgetYm"));
                    Map<String, Object> expendAmtInfo = exBudgetServiceADAO.ExSameBudgetInfoSelectERPiU(expendBudgetParam);

                    expendAmtInfo = (expendAmtInfo == null ? new HashMap<String, Object>() : expendAmtInfo);
                    expendAmtInfo.put("amt", (expendAmtInfo.get("amt") == null ? "0" : expendAmtInfo.get("amt")));

                    expendAmt = new BigDecimal(expendAmtInfo.get("amt").toString());
                }

                // 예산초과 여부 점검
                BigDecimal amJsum = new BigDecimal(resultBudget.getBudgetJsum()); // 집행금액
                amJsum = amJsum.add(expendAmt); // 지출결의 작성금액 포함
                BigDecimal amActSum = new BigDecimal(resultBudget.getBudgetActsum()); // 실행합금액
                BigDecimal reqAmt = new BigDecimal(params.get("amt").toString()); // 작성금액

                /**
                 * <pre>
                 * # BigDecimal 사칙연산
                 * - 더하기 : add
                 * - 빼기 : subtract
                 * - 곱하기 : multiply
                 * - 나누기 : divide
                 * # BigDecimal 비교
                 * - BigDecimal 의 수치가 비교값 보다 작으면 -1
                 * - BigDecimal 의 수치가 비교값 보다 같으면 0
                 * - BigDecimal 의 수치가 비교값 보다 크면 1
                 * </pre>
                 */
                if(((amActSum.subtract(amJsum)).subtract(reqAmt)).compareTo(BigDecimal.ZERO) == -1) {
                    throw new BudgetAmtOverException( "예산을 초과하였습니다." );
                }
            } else {
                logger.error("ERPiU 전용 기능입니다. iCUBE는 이전 메서드 사용이 필요합니다. [ ExInterfaceBudgetInfoCheck ]");
                throw new Exception("ERPiU 전용 기능입니다.");
            }
        } catch (BudgetAmtOverException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        }

        return result;
    }

    private ExCodeBudgetVO ExBudgetAmtInfoSelectERPiU(Map<String, Object> params) throws Exception {
        ExCodeBudgetVO budget = new ExCodeBudgetVO();
        ConnectionVO con = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));

        try {
            if (con.getErpTypeCode().equals(commonCode.ERPIU)) {

                if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
                    throw new Exception("회사코드가 수신되지 않았습니다.");
                }
                if (params.get("budgetYm") == null || params.get("budgetYm").toString().equals("")) {
                    throw new Exception("예산년월이 수신되지 않았습니다.");
                }
                if (params.get("budgetCode") == null || params.get("budgetCode").toString().equals("")) {
                    throw new Exception("예산계정이 수신되지 않았습니다.");
                }
                if (params.get("bizplanCode") == null || params.get("bizplanCode").toString().equals("")) {
                    throw new Exception("사업계획이 수신되지 않았습니다.");
                }
                if (params.get("bgacctCode") == null || params.get("bgacctCode").toString().equals("")) {
                    throw new Exception("예산계정이 수신되지 않았습니다.");
                }
                if (params.get("cdBgLevel") == null || params.get("cdBgLevel").toString().equals("")) {
                    throw new Exception("예산통제레벨 계정 코드가 수신되지 않았습니다.");
                }
                if (params.get("ynControl") == null || params.get("ynControl").toString().equals("")) {
                    throw new Exception("예산통제여부가 수신되지 않았습니다.");
                }
                if (params.get("tpControl") == null || params.get("tpControl").toString().equals("")) {
                    throw new Exception("예산통제기준이 수신되지 않았습니다.");
                }

                budget.setErpCompSeq(params.get("erpCompSeq").toString()); // 회사코드 >> P_CD_COMPANY
                budget.setBudgetYm(params.get("budgetYm").toString() + "01"); // 예산년월 >> P_DT_ACCT
                budget.setBudgetCode(params.get("budgetCode").toString()); // 예산단위 코드 >> P_CD_BUDGET
                budget.setBizplanCode(params.get("bizplanCode").toString()); // 사업계획 코드 >> P_CD_BIZPLAN
                budget.setCdBgLevel(params.get("cdBgLevel").toString()); // 예산통제레벨 계정 코드 >> P_CD_BGLEVEL
                budget.setTpDrcr("1"); // 차대변(1:차변, 2:대변) >> P_TP_DRCR

                // ERPiU 예산잔액 확인
                // @P_CD_COMPANY, @P_CD_BUDGET, @P_CD_BIZPLAN, @P_CD_BGLEVEL, @P_TP_DRCR, @P_DT_ACCT, @P_AM_JSUM, @P_AM_ACTSUM
                // 회사코드, 예산단위, 사업계획, 예산진행통제계정코드, 차대변(1:차변, 2:대변), 회계일자(예:20130411), 집행금액, 실행합금액(편성금액)
                budget = ERPiUBudgetService.UP_FI_Z_BIZBOX_BUDGET_DATA(budget, con);
            } else {
                logger.error("ERPiU 전용 기능입니다. iCUBE는 이전 메서드 사용이 필요합니다. [ ExInterfaceBudgetInfoCheck ]");
                throw new Exception("ERPiU 전용 기능입니다.");
            }
        } catch (Exception e) {
            logger.error(e.getLocalizedMessage());
            throw e;
        }

        return budget;
    }

	// 카드,계산서 반영 시 예산 체크 로직
	@Override
    public ResultVO ExInterfaceBudgetInfoCheck ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			//			 예산 체크 로직 순서
			//			 1. 예산 조회(ERP 및 그룹웨어)
			//			 2. 현재 작성중인 지출결의 예산 정보 조회(결재중 수정이 아닌 경우)
			//			 3. 예산 잔액 계산
			/* 변수 정의 */
			boolean isApprovalEditMode = false;
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
			budgetVo.setBudgetCode( params.get( "budgetCode" ).toString( ) );
			budgetVo.setBgacctCode( params.get( "bgacctCode" ).toString( ) );
            budgetVo.setBizplanCode((params.get("bizplanCode") == null ? "***" : params.get("bizplanCode").toString()).toString());
			budgetVo.setDracctAmt( params.get( "amt" ).toString( ) );
			/* 금액 조회 */
			Map<String, Object> budgetParam = new HashMap<String, Object>( );
			/* 공통 사용 */
			budgetParam.put( "erpCompSeq", params.get( "erpCompSeq" ).toString( ) );
			budgetParam.put( "budgetCode", params.get( "budgetCode" ).toString( ) );
			budgetParam.put( "amt", params.get( "amt" ).toString( ) );
			budgetParam.put( "budgetYm", params.get( "budgetYm" ).toString( ) );
			budgetParam.put( "setTpDrcr", "dr" );
			budgetParam.put( "compSeq", params.get( "compSeq" ).toString( ) );
			/* iCUBE 사용 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				budgetParam.put( "acctCode", params.get( "acctCode" ).toString( ) );
			}
			/* ERPiU사용 */
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				budgetParam.put( "bgacctCode", params.get( "bgacctCode" ).toString( ) );
				budgetParam.put( "bgacctName", params.get( "bgacctName" ).toString( ) );
				budgetParam.put( "bizplanCode", params.get( "bizplanCode" ).toString( ) );
				budgetParam.put( "bizplanName", params.get( "bizplanName" ).toString( ) );
			}
			// ERP금액 및 그룹웨어 금액까지 더한 금액
			ExCodeBudgetVO resultBudget = ExBudgetAmtInfoSelect( budgetParam );
			/* 결재중 수정 여부 확인 */
			if ( params.get( "isApprovalEditMode" ) != null ) {
				isApprovalEditMode = Boolean.parseBoolean( params.get( "isApprovalEditMode" ).toString( ) );
			}
			/* 일반 지출결의 작성인 경우 현재 작성중인 지출결의의 금액까지 합해서 계산한다. */
			List<ExExpendSlipVO> slipList = new ArrayList<ExExpendSlipVO>( );
			Map<String, Object> useAmtSum = new HashMap<String, Object>( ); /* 지출결의 사용 금액 저장변수 */
			if ( !isApprovalEditMode ) {
				slipList = slipService.ExExpendSlipListSelect( params );/* 해당 지출결의 분개 정보 조회 */
			}
			for ( ExExpendSlipVO slipVo : slipList ) {
				ExCodeBudgetVO tBudget = new ExCodeBudgetVO( );
				if ( slipVo.getBudgetSeq( ) == 0 ) {
					continue;
				}
				tBudget.setSeq( slipVo.getBudgetSeq( ) );
				tBudget = codeService.ExExpendBudgetInfoSelect( tBudget );
				if ( useAmtSum.get( tBudget.getBudgetCode( ) + "_" + tBudget.getBizplanCode( ) + "_" + tBudget.getBgacctCode( ) ) != null ) {
					String sumAmt = useAmtSum.get( tBudget.getBudgetCode( ) + "_" + tBudget.getBizplanCode( ) + "_" + tBudget.getBgacctCode( ) ).toString( );
					BigDecimal sumAmtD = new BigDecimal( sumAmt );
					sumAmtD = sumAmtD.add( new BigDecimal( tBudget.getDracctAmt( ) ) );
					useAmtSum.put( tBudget.getBudgetCode( ) + "_" + tBudget.getBizplanCode( ) + "_" + tBudget.getBgacctCode( ), sumAmtD.toString( ) );
				}
				else {
					useAmtSum.put( tBudget.getBudgetCode( ) + "_" + tBudget.getBizplanCode( ) + "_" + tBudget.getBgacctCode( ), new BigDecimal( tBudget.getDracctAmt( ) ).toString( ) );
				}
			}
			// 사용 합 금액은 위에서 계산한 합계 금액으로 사용한다.
			BigDecimal amt = new BigDecimal( commonCode.EMPTYSEQ ); /* 해당 예산단위,사업계획,예산계정의 사용 합 금액(해당 지출결의 금액) */
			if ( useAmtSum.get( budgetVo.getBudgetCode( ) + "_" + budgetVo.getBizplanCode( ) + "_" + budgetVo.getBgacctCode( ) ) != null ) {
				amt = new BigDecimal( useAmtSum.get( budgetVo.getBudgetCode( ) + "_" + budgetVo.getBizplanCode( ) + "_" + budgetVo.getBgacctCode( ) ).toString( ) );
			}
			BigDecimal jsum = new BigDecimal( resultBudget.getBudgetJsum( ) ); /* 실행금액(지출결의 금액 제외) */
			BigDecimal nowAmt = new BigDecimal( budgetVo.getDracctAmt( ) );
			jsum = jsum.add( nowAmt ); // 현재 금액을 추가해준다.
			BigDecimal actSum = new BigDecimal( resultBudget.getBudgetActsum( ) ); /* 편성금액 */
			BigDecimal useAmt = jsum.add( amt ); /* 그룹웨어 + ERP 금액 */
			BigDecimal totalAmt = actSum.subtract( useAmt ); /* 잔액 */
			BigDecimal zero = new BigDecimal( commonCode.EMPTYSEQ );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ICUBE:
					if ( totalAmt.compareTo( zero ) == -1 && CommonConvert.CommonGetStr(resultBudget.getBudgetControlYN( )).equals( "Y" ) ) {
						throw new BudgetAmtOverException( "예산을 초과하였습니다." );
					}
					else if ( CommonConvert.CommonGetStr(resultBudget.getBudgetControlYN( )).equals( "B" ) ) {
						throw new BudgetAmtOverException( "예산이 미편성되었습니다." );
					}
					break;
				case commonCode.ERPIU:
					if ( totalAmt.compareTo( zero ) == -1 && CommonConvert.CommonGetStr(resultBudget.getBudgetControlYN( )).equals( "Y" ) ) {
						throw new BudgetAmtOverException( "예산을 초과하였습니다." );
					}
					break;
				case commonCode.ETC:
					break;
				case commonCode.BIZBOXA:
					break;
				default:
					throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
			}
		}
		catch ( BudgetAmtOverException e ) {
			throw e;
		}
		catch ( Exception e ) {
			throw e;
		}
		return result;
	}
}
