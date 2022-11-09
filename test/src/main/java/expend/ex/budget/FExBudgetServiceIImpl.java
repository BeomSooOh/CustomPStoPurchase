package expend.ex.budget;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeBudgetVO;


@Service ( "FExBudgetServiceI" )
public class FExBudgetServiceIImpl implements FExBudgetServiceI {

	/* 변수정의 - Common */
	@Resource ( name = "FExBudgetServiceIDAO" )
	private FExBudgetServiceIDAO exBudgetDAO;
	@Resource ( name = "FExBudgetServiceADAO" )
	private FExBudgetServiceADAO exBudgetServiceADAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	//예산사용여부 및 예산단위 가져오기
	@Override
    public Map<String, Object> ExBudgetUseInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		return exBudgetDAO.ExBudgetUseInfoSelect( params, conVo );
	}

	/* 공통코드 */
	/* 공통코드 - ERPiCUBE + 그룹웨어 - 예산확인 */
	@Override
	public ExCodeBudgetVO ExBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExBudgetServiceI - ExBudgetAmtInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeBudgetVO budgetVo >> " + budgetVo.toString( ) );
		try {
			if ( budgetVo.getBudgetCode( ).indexOf( "|" ) < 0 ) {
				/* iCUBE 구분자 필수 입력 */
				budgetVo.setBudgetCode( budgetVo.getBudgetCode( ) + "|" );
			}
			if ( budgetVo.getBgacctCode( ).indexOf( "|" ) < 0 ) {
				/* iCUBE 구분자 필수 입력 */
				budgetVo.setBgacctCode( budgetVo.getBgacctCode( ) + "|" );
			}
			/* iCUBE 예산잔액 조회 */
			budgetVo = exBudgetDAO.ExBudgetAmtInfoSelect( budgetVo, conVo );
			/* 임시보관 문서, 진행중인 문서, 종결되었지만 미전송된 문서 결의 금액 조회 */
			ExCodeBudgetVO bizboxBudgetVo = new ExCodeBudgetVO( );
			bizboxBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
			bizboxBudgetVo.setBudgetName( budgetVo.getBudgetName( ) );
			bizboxBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
			bizboxBudgetVo.setBgacctName( budgetVo.getBgacctName( ) );
			bizboxBudgetVo.setBudgetType( budgetVo.getBudgetType( ) );
			bizboxBudgetVo.setBudYm( budgetVo.getBudYm( ) );
			bizboxBudgetVo.setGroupSeq( budgetVo.getGroupSeq( ) );
			if ( budgetVo.getBudgetYm( ).length( ) > 6 ) {
				bizboxBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ).substring( 0, 6 ) );
			}
			else {
				bizboxBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ) );
			}
			// bgacct_code, budget_code,
			bizboxBudgetVo.setBgacctCode( bizboxBudgetVo.getBgacctCode( ).replace( "|", commonCode.EMPTYSTR ) );
			bizboxBudgetVo.setBudgetCode( bizboxBudgetVo.getBudgetCode( ).replace( "|", commonCode.EMPTYSTR ) );
			/* 2019-10-22 그룹웨어 내 동일 회사 내에 작성되어진 지출결의서 조회를 위한 시퀀스 추가  */
			bizboxBudgetVo.setCompSeq(budgetVo.getCompSeq());
			bizboxBudgetVo = exBudgetServiceADAO.ExiCUBEBudgetAmtInfoSelect( bizboxBudgetVo );

			/* iCUBE 예산금액과 그룹웨어 결의금액 계산 */
			BigDecimal iCUBEJsum = new BigDecimal( budgetVo.getBudgetJsum( ) );
			BigDecimal gwJsum = new BigDecimal( bizboxBudgetVo.getBudgetJsum( ) );
			budgetVo.setBudgetJsum( iCUBEJsum.add( gwJsum ).toString( ) );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			cmLog.CommonSetInfo( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeBudgetVO budgetVo >> " + budgetVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExBudgetServiceI - ExBudgetAmtInfoSelect" );
		return budgetVo;
	}

	/* 공통코드 */
	/* 공통코드 - ERPiCUBE + 그룹웨어 - 예산확인 */
	@Override
	public ExCodeBudgetVO ExBudgetAmtInfoSelect2 ( ExCodeBudgetVO budgetVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExBudgetServiceI - ExBudgetAmtInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeBudgetVO budgetVo >> " + budgetVo.toString( ) );
		try {
			if ( budgetVo.getBudgetCode( ).indexOf( "|" ) < 0 ) {
				/* iCUBE 구분자 필수 입력 */
				budgetVo.setBudgetCode( budgetVo.getBudgetCode( ) + "|" );
			}
			if ( budgetVo.getBgacctCode( ).indexOf( "|" ) < 0 ) {
				/* iCUBE 구분자 필수 입력 */
				budgetVo.setBgacctCode( budgetVo.getBgacctCode( ) + "|" );
			}
			/* iCUBE 예산잔액 조회 */
			budgetVo = exBudgetDAO.ExBudgetAmtInfoSelect( budgetVo, conVo );
			/* 임시보관 문서, 진행중인 문서, 종결되었지만 미전송된 문서 결의 금액 조회 */
			ExCodeBudgetVO bizboxBudgetVo = new ExCodeBudgetVO( );
			bizboxBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
			bizboxBudgetVo.setBudgetName( budgetVo.getBudgetName( ) );
			bizboxBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
			bizboxBudgetVo.setBgacctName( budgetVo.getBgacctName( ) );
			bizboxBudgetVo.setBudgetType( budgetVo.getBudgetType( ) );
			bizboxBudgetVo.setBudYm( budgetVo.getBudYm( ) );
			bizboxBudgetVo.setGroupSeq( budgetVo.getGroupSeq( ) );
			if ( budgetVo.getBudgetYm( ).length( ) > 6 ) {
				bizboxBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ).substring( 0, 6 ) );
			}
			else {
				bizboxBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ) );
			}
			// bgacct_code, budget_code,
			bizboxBudgetVo.setBgacctCode( bizboxBudgetVo.getBgacctCode( ).replace( "|", commonCode.EMPTYSTR ) );
			bizboxBudgetVo.setBudgetCode( bizboxBudgetVo.getBudgetCode( ).replace( "|", commonCode.EMPTYSTR ) );
			/* 2019-10-22 그룹웨어 내 동일 회사 내에 작성되어진 지출결의서 조회를 위한 시퀀스 추가  */
			bizboxBudgetVo.setCompSeq(budgetVo.getCompSeq());
			bizboxBudgetVo = exBudgetServiceADAO.ExiCUBEBudgetAmtInfoSelect( bizboxBudgetVo );
			/* 현재 작성중인 분개 정보 중 동일한 예산정보의 금액을 더해준다.*/
			Map<String, Object> tResult = new HashMap<String, Object>( );
			tResult.put( "expendSeq", bizboxBudgetVo.getExpendSeq( ) );
			tResult.put( "budgetCode", bizboxBudgetVo.getBudgetCode( ) );
			tResult.put( "bizplanCode", bizboxBudgetVo.getBizplanCode( ) );
			tResult.put( "bgacctCode", bizboxBudgetVo.getBgacctCode( ) );
			tResult.put( "expendSeq", budgetVo.getExpendSeq( ) );
			tResult.put( "listSeq", budgetVo.getListSeq( ) );
			tResult.put( "slipSeq", budgetVo.getSlipSeq( ) );
			tResult.put( "groupSeq", budgetVo.getGroupSeq( ) );
			/* 현재 작성중인 지출결의 정보 중 동일한 예산정보의 총합계금액을 구한다. */
			tResult = exBudgetServiceADAO.ExSameBudgetInfoSelect( tResult );
			/* iCUBE 예산금액과 그룹웨어 결의금액 계산 */
			BigDecimal iCUBEJsum = new BigDecimal( budgetVo.getBudgetJsum( ) );
			BigDecimal gwJsum = new BigDecimal( bizboxBudgetVo.getBudgetJsum( ) );
			BigDecimal totalJsum = new BigDecimal( commonCode.EMPTYSEQ );
			totalJsum = iCUBEJsum.add( gwJsum );
			/* 결재 진행중 문서가 아니면 현재 작성중인 지결에서 동일한 예산정보의 금액들을 확인한다. */
            if ((tResult != null && tResult.get("isApproval") != null && CommonConvert.CommonGetStr(tResult.get("isApproval")).equals(commonCode.EMPTYNO)) || budgetVo.getIsComeHistory()) {
				BigDecimal gwTotalJsum = new BigDecimal( tResult.get( "totalBudgetAmt" ).toString( ) );
				totalJsum = totalJsum.add( gwTotalJsum );
			}

			budgetVo.setBudgetJsum( totalJsum.toString( ) );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			cmLog.CommonSetInfo( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeBudgetVO budgetVo >> " + budgetVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExBudgetServiceI - ExBudgetAmtInfoSelect" );
		return budgetVo;
	}

    @Override
    public ExCodeBudgetVO UP_FI_Z_BIZBOX_BUDGET_DATA(ExCodeBudgetVO budget, ConnectionVO con) throws Exception {
        // ERPiU 전용기능입니다.
        return null;
    }
}
