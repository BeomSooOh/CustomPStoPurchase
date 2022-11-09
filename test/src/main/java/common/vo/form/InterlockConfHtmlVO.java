package common.vo.form;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.text.MaskFormatter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import com.ibm.icu.math.BigDecimal;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.exception.ValidException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


public class InterlockConfHtmlVO {

	/* VO 리뉴얼 */
	private final String html;
	private String txtHeader;
	private String txtFooter;
	private String tableHeader;
	private String tableFooter;
	private String tableContents;
	private int loopRowEq;
	private int loopRowCnt;
	private String resultContents;
	private int projectRowCnt;
	private int projectRowEq;
	private int budgetRowCnt;
	private int budgetRowEq;
	private int tradeRowCnt;
	private int tradeRowEq;
	private Map<String, Object> headData;
	private List<Map<String, Object>> contentsData;
	private Map<String, Object> footerData;
	private String projectContents;
	private String budgetContents;
	private String tradeContents;
	private boolean isSetHtml;
	@SuppressWarnings("unused")
	private final String expendSeq;
	@SuppressWarnings("unused")
	private final String groupSeq;
	@SuppressWarnings("unused")
	private final String testMode;
	LoginVO loginVo;

	public InterlockConfHtmlVO ( String html, String expendSeq, String groupSeq, String testMode ) throws NotFoundLoginSessionException {
		/* VO 리뉴얼 */
		this.html = html.replace("tBody", "tbody");
		this.txtHeader = "";
		this.txtFooter = "";
		this.tableHeader = "";
		this.tableFooter = "";
		this.tableContents = "";
		this.loopRowCnt = 0;
		this.loopRowEq = 0;
		this.resultContents = "";
		this.projectContents = "";
		this.budgetContents = "";
		this.tradeContents = "";
		this.projectRowEq = -1;
		this.budgetRowEq = -1;
		this.tradeRowEq = -1;
		this.projectRowCnt = 0;
		this.budgetRowCnt = 0;
		this.tradeRowCnt = 0;
		this.expendSeq = expendSeq;
		this.groupSeq = groupSeq;
		this.isSetHtml = false;
		this.testMode = testMode;
		this.loginVo = CommonConvert.CommonGetEmpVO( );/* html code 용도에 맞게 분리 */
		InitHtmlCode( );
	}

	/*******************************************************************************************************************
	 * 아래로 public 메서드 영역입니다.
	 *******************************************************************************************************************/
	/**
	 * 입력정보를 기준하여 HTML양식에 데이터를 채워넣습니다.
	 * return ResultVO
	 * resultCode : VALIDATION > 무결 검증 실패, resultName 확인.
	 * resultCode : SUCCESS > 양식 데이터 작성완료, GetResultHtml() 메서드 참조.
	 */
	public ResultVO SetHtmlForm ( Map<String, Object> headData, List<Map<String, Object>> contentsData, Map<String, Object> footerData ) throws Exception {
		/* 데이터 초기화 */
		this.headData = headData;
		this.contentsData = contentsData;
		this.footerData = footerData;
		/* 기본 변수 선언 */
		ResultVO result = new ResultVO( );
		ResultVO validationResult = new ResultVO( );
		Document doc = Jsoup.parse( this.html );
		/* [데이터 무결검증] 1. 반복 키워드 중복 파악 */
		validationResult = CheckValidationType1( doc );
		if ( !CommonConvert.CommonGetStr(validationResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
			return validationResult;
		}
		/* [데이터 무결검증] 2. 반복 키워드 위치 파악 */
		//validationResult = CheckValidationType2( doc );
		validationResult = CheckValidationType2( );
		if ( !CommonConvert.CommonGetStr(validationResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
			return validationResult;
		}
		/* [데이터 무결검증] 3. 단일 분개정보 파악및 컨텐츠 수정 */
		validationResult = CheckValidationType3( doc );
		if ( !CommonConvert.CommonGetStr(validationResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
			return validationResult;
		}
		/* [contents] 반복영역 데이터 구성 */
		ResultVO contentsResult = TransformContents( doc );
		if ( CommonConvert.CommonGetStr(contentsResult.getResultCode( )).equals( commonCode.FAIL ) ) {
			return contentsResult;
		}
		/* [header] 헤더영역 데이터 구성 */
		ResultVO headerResult = TransformHeader( );
		if (CommonConvert.CommonGetStr( headerResult.getResultCode( )).equals( commonCode.FAIL ) ) {
			return headerResult;
		}
		/* [footer] 푸터영역 테이터 구성 */
		ResultVO footerResult = TransformFooter( );
		if ( CommonConvert.CommonGetStr(footerResult.getResultCode( )).equals( commonCode.FAIL ) ) {
			return footerResult;
		}
		/* 결과 리턴 */
		result.setResultCode( commonCode.SUCCESS );
		this.isSetHtml = true;
		return result;
	}

	/**
	 * 입력된 정보를 기준하여 작성된 HTML코드를 반환합니다.
	 * ResultVO SetHtmlForm 메서드가 선행되어야 합니다.
	 * ResultVO SetHtmlForm 메서드가 동작에 실패하였다면 html코드를 반환받을 수 없습니다.
	 */
	public String GetResultHtml ( ) {
		if ( this.isSetHtml ) {
			return this.txtHeader + "<tBody>" + this.tableHeader + this.resultContents + this.tableFooter + "</tBody>" + this.txtFooter;
		}
		else {
			return "데이터 검증에 실패하였습니다.";
		}
	}

	/*******************************************************************************************************************
	 * 아래로 private 메서드 영역입니다.
	 *******************************************************************************************************************/
	/* HTML 코드 초기화 */
	private void InitHtmlCode ( ) {
		/* 텍스트 헤더, 푸터 설정 */
		//System.out.println(this.html.toString());
		this.txtHeader = this.html.split( "<tbody>" )[0];
		this.txtFooter = this.html.split( "</tbody>" )[1];
		Document doc = Jsoup.parse( html );
		Elements trs = doc.select( "tbody > tr" );
		/* 반복아이템 영역 확인 */
		for ( int i = 0; i < trs.size( ); i++ ) {
			if ( !trs.get( i ).select( ".projectBaseTd" ).toString( ).equals( "" ) ) {
				this.projectRowEq = i;
				String rowspan = trs.get( i ).select( ".projectBaseTd" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.projectRowCnt = CastStringToInt( rowspan );
			}
			if ( !trs.get( i ).select( ".budgetBaseTd" ).toString( ).equals( "" ) ) {
				this.budgetRowEq = i;
				String rowspan = trs.get( i ).select( ".budgetBaseTd" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.budgetRowCnt = CastStringToInt( rowspan );
			}
			if ( !trs.get( i ).select( ".tradeBaseTd" ).toString( ).equals( "" ) ) {
				this.tradeRowEq = i;
				String rowspan = trs.get( i ).select( ".tradeBaseTd" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.tradeRowCnt = CastStringToInt( rowspan );
			}
		}
		/* table loop 영역 설정 */
		if ( this.projectRowEq > -1 ) {
			this.loopRowEq = this.projectRowEq;
			this.loopRowCnt = this.projectRowCnt;
		}
		else if ( this.budgetRowEq > -1 ) {
			this.loopRowEq = this.budgetRowEq;
			this.loopRowCnt = this.budgetRowCnt;
		}
		else if ( this.tradeRowEq > -1 ) {
			this.loopRowEq = this.tradeRowEq;
			this.loopRowCnt = this.tradeRowCnt;
		}
		for ( int i = 0; i < trs.size( ); i++ ) {
			Element item = trs.get( i );
			if ( i < this.loopRowEq ) {
				this.tableHeader += item.toString( );
			}
			else if ( i > loopRowEq + loopRowCnt - 1 ) {
				this.tableFooter += item.toString( );
			}
			else {
				this.tableContents += item.toString( );
			}
		}
	}

	/* 헤더 정보 양식 변환 */
	private ResultVO TransformHeader ( ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( commonCode.SUCCESS );
		String regex = "\\_(.*?)\\_";
		Pattern p = Pattern.compile( regex );
		Matcher m = p.matcher( this.tableHeader );
		while ( m.find( ) ) {
			String replaceValue = getDataForKey( this.headData, m.group( ) );
			if(replaceValue.equals( "" )){
				replaceValue = getDataForKey( this.footerData, m.group( ) );
			}
			replaceValue = getReplaceValue( replaceValue, m.group( ), this.headData );
			this.tableHeader = this.tableHeader.replaceAll( m.group( ), replaceValue );
		}
		return result;
	}

	/* 푸터 정보 양식 변환 */
	private ResultVO TransformFooter ( ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( commonCode.SUCCESS );
		String regex = "\\_(.*?)\\_";
		Pattern p = Pattern.compile( regex );
		Matcher m = p.matcher( this.tableFooter );
		while ( m.find( ) ) {
			String replaceValue = getDataForKey( this.footerData, m.group( ) );
			if(replaceValue.equals( "" )){
				replaceValue = getDataForKey( this.headData, m.group( ) );
			}
			replaceValue = getReplaceValue( replaceValue, m.group( ), this.footerData );
			this.tableFooter = this.tableFooter.replaceAll( m.group( ), replaceValue );
		}
		return result;
	}

	/* 항목, 분개, 관리항목 반복에 따른 양식 변환 */
	@SuppressWarnings ( "unchecked" )
	private ResultVO TransformContents ( Document doc ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( commonCode.SUCCESS );
		List<Map<String, Object>> projectList = this.contentsData;

		try {
			for ( int projectSeq = projectList.size( ) - 1; projectSeq > -1; projectSeq-- ) {
				Map<String, Object> project = projectList.get( projectSeq );
				ArrayList<HashMap<String, Object>> budgetList = (ArrayList<HashMap<String, Object>>) project.get( "budgetList" );
				for ( int budgetSeq = budgetList.size( ) - 1; budgetSeq > -1; budgetSeq-- ) {
					Map<String, Object> budget = budgetList.get( budgetSeq );
					ArrayList<HashMap<String, Object>> tradeList = (ArrayList<HashMap<String, Object>>) budget.get( "tradeList" );
					for ( int tradeSeq = tradeList.size( ) - 1; tradeSeq > -1; tradeSeq-- ) {
						Map<String, Object> trade = tradeList.get( tradeSeq );
						if ( doc.select( ".tradeBaseTd" ).size( ) > 0 ) {
							SetResultHtml( "tradeList", tradeSeq, project, budget, trade );
						}
					}
					if ( doc.select( ".budgetBaseTd" ).size( ) > 0 ) {
						SetResultHtml( "budgetList", budgetSeq, project, budget, null );
					}
					this.budgetContents = this.tradeContents + this.budgetContents;
					this.tradeContents = "";
				}
				SetResultHtml( "projectList", projectSeq, project, null, null );
				this.projectContents = this.budgetContents + this.projectContents;
				this.budgetContents = "";
			}
			this.resultContents = projectContents;
		}
		catch ( ValidException ex ) {
			//System.out.println( ex.getMessage( ) );
			result = ex.getResult( );
		}
		return result;
	}

	/* 아이템별 HTML 테이블 생성 / 데이터 파싱 */
	int rsList = 0;
	int rsbudget = 0;

	private void SetResultHtml ( String type, int idx, Map<String, Object> project, Map<String, Object> budget, Map<String, Object> trade ) throws ValidException {
		int listCopyRangeFrom = this.projectRowEq - loopRowEq;
		int budgetCopyRangeFrom = this.budgetRowEq - loopRowEq;
		int tradeCopyRangeFrom = this.tradeRowEq - loopRowEq;

		int listCopyRangeTo = this.projectRowCnt + listCopyRangeFrom - 1;
		int budgetCopyRangeTo = this.budgetRowCnt + budgetCopyRangeFrom - 1;
		int tradeCopyRangeTo = this.tradeRowCnt + tradeCopyRangeFrom - 1;
		String tag = "";
		Document doc = Jsoup.parse( this.txtHeader + this.tableContents + this.txtFooter );
		Elements trs = doc.select( "tr" );
		for ( int i = trs.size( ) - 1; i >= 0; i-- ) {
			if ( type == "tradeList" ) {
				/* 관리항목 일반 케이스 처리 */
				if ( (i >= tradeCopyRangeFrom) && i <= tradeCopyRangeTo ) {
					trs.select( ".budgetBaseTd" ).remove( );
					tag = trs.get( i ).toString( );
					this.tradeContents = getTag( tag, project, budget, trade, "tradeList" ) + tradeContents;
					rsbudget++;
					rsList++;
				}
			}
			else if ( type == "budgetList" ) {
				/* 로우스판 처리 */
				if ( i == budgetCopyRangeFrom ) {
					int rowspan = (this.budgetRowCnt - this.tradeRowCnt) + rsbudget;
					doc.select( ".budgetBaseTd" ).attr( "rowspan", ("" + rowspan) );
					/* 특이케이스 아닌경우 */
					if ( budgetCopyRangeFrom != tradeCopyRangeFrom ) {
						rsbudget = 0;
					}
				}
				/* 상위코드와 래밸이 같은 경우 / 최상위 idx = 0 */
				if ( i == budgetCopyRangeFrom && i == listCopyRangeFrom ) {
					trs.select( ".budgetBaseTd" ).prevAll( ).remove( );
				}
				/* 하위코드와 래벨이 같은경우 / 최상위 idx = 0 */
				if ( i == budgetCopyRangeFrom && i == tradeCopyRangeFrom ) {
					trs.select( ".budgetBaseTd" ).nextAll( ).remove( );
					rsList++;
					int rowspan = (this.budgetRowCnt - this.tradeRowCnt) + rsbudget + 1;
					doc.select( ".budgetBaseTd" ).attr( "rowspan", ("" + rowspan) );
					tag = trs.get( i ).toString( );
					this.tradeContents = getTag( tag, project, budget, trade, "budgetList" ) + this.tradeContents;
					rsbudget = 0;
				}
				/* 노멀 케이스 */
				if ( ((i >= budgetCopyRangeFrom) && i <= budgetCopyRangeTo) && (i < tradeCopyRangeFrom || i > tradeCopyRangeTo) ) {
					if ( idx != 0 ) {
						trs.select( ".projectBaseTd" ).remove( );
					}
					rsList++;
					tag = trs.get( i ).toString( );
					if ( (i > tradeCopyRangeTo) && (tradeCopyRangeTo > -1) ) {
						this.tradeContents = this.tradeContents + tag;
					}
					else {
						this.tradeContents = getTag( tag, project, budget, trade, "budgetList" ) + this.tradeContents;
					}
				}
			}
			else if ( type == "projectList" ) {
				/* 로우스판 처리 */
				if ( i == listCopyRangeFrom ) {
					int rowspan = (this.projectRowCnt - this.budgetRowCnt) + rsList;
					doc.select( ".projectBaseTd" ).attr( "rowspan", ("" + rowspan) );
					/* 특이케이스 아닌경우 */
					if ( listCopyRangeFrom != budgetCopyRangeFrom ) {
						rsList = 0;
					}
				}
				/* 하위코드와 래벨이 같은 경우 / 최상위 idx = 0 */
				if ( i == listCopyRangeFrom && i == budgetCopyRangeFrom ) {
					trs.select( ".projectBaseTd" ).nextAll( ).remove( );
					int rowspan = (this.projectRowCnt - this.budgetRowCnt) + rsList + 1;
					doc.select( ".projectBaseTd" ).attr( "rowspan", ("" + rowspan) );
					tag = trs.get( i ).toString( );
					this.budgetContents = getTag( tag, project, budget, trade, "projectList" ) + this.budgetContents;
					rsList = 0;
				}
				/* 노멀 케이스 */
				if ( ((i >= listCopyRangeFrom) && i <= listCopyRangeTo) && (i < budgetCopyRangeFrom || i > budgetCopyRangeTo) ) {
					if ( idx != 0 ) {
						trs.select( ".budgetBaseTd" ).remove( );
					}
					tag = trs.get( i ).toString( );
					if ( (i > budgetCopyRangeTo) && (budgetCopyRangeTo > -1) ) {
						this.budgetContents = this.budgetContents + tag;
					}
					else {
						this.budgetContents = getTag( tag, project, budget, trade, "projectList" ) + this.budgetContents;
					}
				}
			}
		}
	}

	/* 데이터 조합된 HTML코드 반환 */
	private String getTag ( String tag, Map<String, Object> project, Map<String, Object> budget, Map<String, Object> trade, String type ) throws ValidException {
		Map<String, Object> dataSet = new HashMap<>( );
		String idx = "";
		try {
			if ( type.equals( "projectList" ) ) {
				dataSet = project;
				idx = dataSet.get( "projectNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_projectNum_", idx );
			}
			else if ( type.equals( "budgetList" ) ) {
				dataSet = budget;
				idx = dataSet.get( "budgetNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_budgetNum_", idx );
			}
			else if ( type.equals( "tradeList" ) ) {
				dataSet = trade;
				idx = dataSet.get( "tradeNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_tradeNum_", idx );
			}
		}
		catch ( Exception ex ) {
			throw new ValidException( "항목 시퀀스 정보를 찾을 수 없습니다." );
		}
		try {
			/* 기타 정보 처리 */
			String regex = "\\_(.*?)\\_";
			Pattern p = Pattern.compile( regex );
			Matcher m = p.matcher( tag );
			while ( m.find( ) ) {
				String replaceValue = getDataForKey( dataSet, m.group( ) );
				replaceValue = getReplaceValue( replaceValue, m.group( ), dataSet );
				tag = tag.replace( m.group( ), replaceValue );
			}
		}
		catch ( Exception ex ) {
			throw new ValidException( "2번 에러" );
		}
		return tag;
	}

	/* 키워드 종류에 따른 예외처리 */
	private String getReplaceValue ( String replaceValue, String keyword, Map<String, Object> dataSet ) {
		@SuppressWarnings("unused")
		Map<String, Object> backDataSet = dataSet;
			// TODO: 코드 확장 추가
		switch ( keyword ) {

			/* 카드 팝업 */
			case "_cardPop_" :
				if(!replaceValue.equals( "" )){
					replaceValue =
							" <a href=\"#n\" onclick=\"javascript:window.open('/exp/expend/np/user/UserCardDetailPop.do?syncId="
							+ replaceValue
							+ "', '', 'width=432, height=489')\">"
							+ "[+]" + "</a>";
				}
				break;
			/* 세금계산서 팝업 */
			case "_eTaxPop_":
				if(!replaceValue.equals( "" )){
					replaceValue =
							" <a href=\"#n\" onclick=\"javascript:window.open('/exp/expend/np/user/UserETaxDetailPop.do?syncId="
							+ replaceValue
							+ "', '', 'width=920, height=588')\">"
							+ "[+]" + "</a>";
				}
				break;
			/* 금액 정보 변경 */
			case "_stdAmt_" :
			case "_vatAmt_" :
			case "_taxAmt_" :
			case "_amt_" :
			case "_confferResBudgetAmt_" :
			case "_confferConsBudgetAmt_" :
			case "_confferBalanceAmt_" :
			case "_confferConsAmt_" :
			case "_confferResAmt_" :
			case "_confferResultAmt_" :
			case "_nonSendResAmt_" :
			case "_tryAmt_" :
			case "_tryStdAmt_" :
			case "_tryVatAmt_" :
			case "_resultAmt_" :
			case "_kefConsLeftAmt_" :
			case "_kefResultAmt_":
			case "_totalResAmt_" :
			case "_erpiULeftAmt_" :
			case "_gwConsResAmt_" :
			case "_gwApplyAmt_" :
			case "_erpOpenAmt_" :
			case "_erpLeftAmt_" :
			case "_erpApplyResAmt_" :
			case "_erpApplyAmt_" :
			case "_erpResAmt_" :
			case "_applyAmt_" :
			case "_leftAmt_" :
			case "_budgetAmt_" :
			case "_tradeStdAmt_" :
			case "_tradeVatAmt_" :
			case "_totalTradeAmt_" :
			case "_totalStdAmt_" :
			case "_totalVatAmt_" :
			case "_resApplyAmt_" :
			case "_totalTradeAmt_ " :
			case "_tradeAmt_" :
			case "_totalBudgetAmt_" :
			case "_consAmt_" :
			case "_resAmt_" :
			case "_resStdAmt_" :
			case "_resTaxAmt_" :
			case "_gwBalanceAmt_" :
			case "_amtClass1Amt_":
			case "_amtClass2Amt_":
			case "_amtClass3Amt_":
			case "_amtClass4Amt_":
			case "_amtClass5Amt_":
			case "_amtClass6Amt_":
			case "_maxAmt1_":
			case "_maxAmt2_":
			case "_maxAmt3_":
			case "_maxAmt4_":
			case "_maxAmt5_":
			case "_maxAmt6_":
			case "_totalClass1Amt_":
			case "_totalClass2Amt_":
			case "_totalClass3Amt_":
			case "_totalClass4Amt_":
			case "_totalClass5Amt_":
			case "_totalClass6Amt_":
			case "_totalAmtClassSum_":

				if ( replaceValue != null ) {
					if(replaceValue.equals( "" )){
						replaceValue = "0";
					}
					replaceValue = replaceValue.replace( ",", "" );
					DecimalFormat df = new DecimalFormat("#,###.###");
					replaceValue = df.format( Double.parseDouble( replaceValue ) );
				}
				break;

			/* 시간 정보 변경 */
			case "_cardAuthTime_":
				if ( replaceValue != null ) {
					if ( replaceValue.length( ) > 5 ) {
						replaceValue = replaceValue.substring( 0, 2 ) + ":" + replaceValue.substring( 2, 4 ) + ":" + replaceValue.substring( 4, 6 );
					}
				}
				break;
			/* 사업자 등록 번호 변경 */
			case "_partnerNo_":
				if(replaceValue.length( ) == 10){
					try{
						MaskFormatter f = new MaskFormatter( "###-##-#####" );
						f.setValueContainsLiteralCharacters( false );
						replaceValue = f.valueToString( replaceValue );
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
				break;
			/* 카드 번호  */
			case "_cardCardNum_" :
				if(replaceValue.length( ) == 16){
					try{
						MaskFormatter f = new MaskFormatter( "####-####-####-####" );
						f.setValueContainsLiteralCharacters( false );
						replaceValue = f.valueToString( replaceValue );
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
				break;
			/* 날짜 정보 변경 */
			case "_expendDate_":
			case "_expendResDate_":
			case "_resDate_" :
			case "_consDate_" :
			case "_expendReqDate_":
			case "_createDate_":
			case "_tripToDate_":
			case "_tripFromDate_":
				replaceValue = replaceValue.replace( "-", "" );
				if ( replaceValue != null ) {
					if ( replaceValue.length( ) > 7 ) {
						replaceValue = replaceValue.substring( 0, 4 ) + "-" + replaceValue.substring( 4, 6 ) + "-" + replaceValue.substring( 6, 8 );
					}else if( replaceValue.length( ) == 6 ){
						replaceValue = replaceValue.substring( 0, 4 ) + "-" + replaceValue.substring( 4, 6 );
					}
				}
				break;
			default:
				break;
		}

		return replaceValue;
	}

	/* 데이타 셋에서 정보 조회 */
	private String getDataForKey ( Map<String, Object> dataSet, String key ) {
		key = key.substring( 1, key.length( ) - 1 );
		Object tmp = dataSet.get( key );
		if ( tmp == null ) {
			return "";
		}
		return tmp.toString( );
	}

	/* Type 3. 데이터 검증 분개정보 검증 */
	@SuppressWarnings ( "unchecked" )
	private ResultVO CheckValidationType3 ( Document doc ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( "VALIDATION" );
		int drCount = 0;
		int crCount = 0;
		drCount = doc.select( ".budgetDrNum" ).size( );
		crCount = doc.select( ".budgetCrNum" ).size( );
		/* 차/대 노출 코드에 따른 분개정보 보정 */
		if ( drCount + crCount > 0 ) {
			String dcFlag = "";
			if ( crCount == 1 ) {
				dcFlag = "cr";
			}
			else {
				dcFlag = "dr";
			}
			for ( int i = 0; i < this.contentsData.size( ); i++ ) {
				List<Map<String, Object>> budgetList = (List<Map<String, Object>>) this.contentsData.get( i ).get( "budgetList" );
				List<Map<String, Object>> newbudgetList = new ArrayList<>( );
				for ( Map<String, Object> budget : budgetList ) {
					if ( budget.get( "budgetDrcrGbnCode" ).equals( dcFlag ) ) {
						newbudgetList.add( budget );
					}
				}
				this.contentsData.get( i ).put( "budgetList", newbudgetList );
			}
		}
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	/* Type 2. 데이터 검증 반복키워드 위치 검증 */
	//private ResultVO CheckValidationType2 ( Document doc ) {
	private ResultVO CheckValidationType2 ( ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( "VALIDATION" );
		int listMax = projectRowEq + projectRowCnt;
		int listMin = projectRowEq;
		int budgetMax = budgetRowEq + budgetRowCnt;
		int budgetMin = budgetRowEq;
		int tradeMax = tradeRowEq + tradeRowCnt;
		int tradeMin = tradeRowEq;
		/* 관리항목이 존재하는 경우. */
		if ( tradeRowEq > -1 ) {
			if ( (budgetRowEq > -1) && ((tradeMin < budgetMin) || (tradeMax > budgetMax)) ) {
				result.setResultName( "관리항목은 분개정보 안에 위치해야 합니다." );
				return result;
			}
		}
		/* 분개정보가 존재하는 경우 */
		if ( budgetRowEq > -1 ) {
			if ( (projectRowEq > -1) && ((budgetMin < listMin) || (budgetMax > listMax)) ) {
				result.setResultName( "관리항목은 항목정보 안에 위치해야 합니다." );
				return result;
			}
		}
		result.setResultCode( commonCode.SUCCESS );
		return result;
	}

	/* Type 1. 데이터 검증 반복키워드 중복 검증 */
	private ResultVO CheckValidationType1 ( Document doc ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( "VALIDATION" );
		if ( doc.select( ".projectBaseTd" ).size( ) > 1 ) {
			result.setResultName( " 항목 순번은 하나만 설정가능 합니다. " );
		}
		else if ( doc.select( ".budgetBaseTd" ).size( ) > 1 ) {
			result.setResultName( " 분개 순번은 하나만 설정가능 합니다. " );
		}
		else if ( doc.select( ".tradeBaseTd" ).size( ) > 1 ) {
			result.setResultName( " 관리항목 순번은 하나만 설정가능 합니다. " );
		}
		else {
			result.setResultCode( commonCode.SUCCESS );
		}
		return result;
	}

	/* 통화코드 변경 */
	@SuppressWarnings("unused")
	private String CastCurrencyFormat ( String data ) {
		if ( data == null ) {
			data = "";
		}
		try {
			BigDecimal bdData = new BigDecimal( data );
			DecimalFormat df = new DecimalFormat( "#,##0" );
			data = df.format( bdData );
		}
		catch ( Exception ex ) {
			return data;
		}
		return data;
	}

	/* 인트 형변환, 예외처리. */
	private int CastStringToInt ( String value ) {
		if ( value == null ) {
			value = "0";
		}
		if ( value.equals( "" ) ) {
			value = "0";
		}
		int result = 0;
		try {
			result = Integer.parseInt( value );
		}
		catch ( Exception ex ) {
			result = 0;
		}
		return result;
	}

	/* 특수문자 변환처리 */
	@SuppressWarnings("unused")
	private String ConvertSpecialCharacter(String value) {
		value = value.replaceAll("<", "&lt;");
		value = value.replaceAll(">", "&gt;");

		return value;
	}
}
