package common.vo.form;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.ibm.icu.math.BigDecimal;

import common.form.FCommonFormBizboxDAO;
import common.helper.convert.CommonConvert;
import common.helper.exception.ValidException;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.TestCase;
import expend.ex.user.report.FExUserReportServiceADAO;

/**
 * InterlockSubtotalHtmlVOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-09-25.
 */
public class InterlockSubtotalHtmlVOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(InterlockSubtotalHtmlVOTest.class);

	@Resource(name = "FCommonFormBizboxDAO")
    private FCommonFormBizboxDAO dao;
	
	@Autowired
	private FExUserReportServiceADAO userReportDAO;
	
	private String html;
	private String txtHeader;
	private String txtFooter;
	private String tableHeader;
	private String tableFooter;
	private String tableContents;
	private int loopRowEq;
	private String resultContents;
	private int listRowEq;
	private List<Map<String, Object>> contentsData;
	private Map<String, Object> footerData;
	private String listContents;
	private boolean isSetHtml;
	
	//테스트용 변수
	Map<String, Object> dataSet;
	String resultHtml = "";
	
	@Before
	public void setupAdditional() {
		// html 치환용 테스트 데이터
		dataSet = new HashMap<>();
		
		dataSet.put("subtotalListNum", "1");
		dataSet.put("subtotalDrAcctCode", "54900");
		dataSet.put("subtotalDrAcctName", "복리후생비");
		dataSet.put("subtotalListStdAmt", "17820.00");
		dataSet.put("subtotalListTaxAmt", "180.00");
		dataSet.put("subtotalListAmt", "18000.00");
	}
	
	@Test
	public void 치환할_양식_데이터_조회() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("formSeq", "52");
		params.put("compSeq", "1241");
		
		Map<String, Object> result = dao.CommonFormDetailInfo(params);
		assertNotNull(result.get("formSeq"));
		
		this.html = result.get("formContent").toString();
	}
	
	@Test
	public void 기존양식과_소계양식_분리_테스트() throws Exception {
		치환할_양식_데이터_조회();
		
		Document doc = Jsoup.parse( html );
		Elements tables = doc.select("#subtotalList");
		
		logger.info("### subtotalTables = {}", tables.get(0));
		
		this.html = CommonConvert.CommonGetStr(tables.get(0));
	}
	
	@Test
	public void testInitHtmlCode() throws Exception {
		기존양식과_소계양식_분리_테스트();
		
		this.txtHeader = "";
		this.txtFooter = "";
		this.tableHeader = "";
		this.tableFooter = "";
		this.tableContents = "";
		this.loopRowEq = 0;
		this.resultContents = "";
		this.listContents = "";
		this.listRowEq = -1;
		this.isSetHtml = false;
		
		InitHtmlCode();
		
		logger.info("### InitHtmlCode = " + this.tableHeader + this.tableContents + this.tableFooter);
	}
	
	/* HTML 코드 초기화 */
	private void InitHtmlCode ( ) {
		/* 텍스트 헤더, 푸터 설정 */
		this.txtHeader = this.html.split( "<tbody>" )[0];
		this.txtFooter = this.html.split( "</tbody>" )[1];
		Document doc = Jsoup.parse( html );
		Elements trs = doc.select( "tbody > tr" );
		
		/* 반복아이템 영역 확인 */
		for ( int i = 0; i < trs.size( ); i++ ) {
			if ( !trs.get( i ).select( ".subtotalListNum" ).toString( ).equals( "" ) ) {
				this.listRowEq = i;
			}
		}
		
		/* table loop 영역 설정 */
		if ( this.listRowEq > -1 ) {
			this.loopRowEq = this.listRowEq;
		}
		
		for ( int i = 0; i < trs.size( ); i++ ) {
			Element item = trs.get( i );
			if ( i < this.loopRowEq ) {
				this.tableHeader += item.toString( );
			}
			else if ( i > loopRowEq ) {
				this.tableFooter += item.toString( );
			}
			else {
				this.tableContents += item.toString( );
			}
		}
	}
	
	@Test
	public void testSetHtmlForm() throws Exception {
		// 양식 초기화
		testInitHtmlCode();
				
		소계양식_데이터_조회();
		
		ResultVO result = SetHtmlForm(this.contentsData);
		
		assertEquals(commonCode.SUCCESS, result.getResultCode());
		
		logger.info("### resultContents = {}", this.resultContents);
		logger.info("### tableFooter = {}", this.tableFooter);
	}
	
	/**
	 * 입력정보를 기준하여 HTML양식에 데이터를 채워넣습니다.
	 * return ResultVO
	 * resultCode : VALIDATION > 무결 검증 실패, resultName 확인.
	 * resultCode : SUCCESS > 양식 데이터 작성완료, GetResultHtml() 메서드 참조.
	 */
	public ResultVO SetHtmlForm ( List<Map<String, Object>> contentsData ) throws Exception {
		/* 데이터 초기화 */
		this.contentsData = contentsData;
		/* 기본 변수 선언 */
		ResultVO result = new ResultVO( );
		ResultVO validationResult = new ResultVO( );
		Document doc = Jsoup.parse( this.html );
		/* [데이터 무결검증] 1. 반복 키워드 중복 파악 */
		validationResult = CheckValidationType1( doc );
		if ( !CommonConvert.CommonGetStr(validationResult.getResultCode( )).equals( commonCode.SUCCESS ) ) {
			return validationResult;
		}
		/* [contents] 반복영역 데이터 구성 */
		ResultVO contentsResult = TransformContents();
		if ( CommonConvert.CommonGetStr(contentsResult.getResultCode( )).equals( commonCode.FAIL ) ) {
			return contentsResult;
		}
		/* [footer] 푸터영역 테이터 구성 */
		ResultVO footerResult = TransformFooter();
		if ( CommonConvert.CommonGetStr(footerResult.getResultCode( )).equals( commonCode.FAIL ) ) {
			return footerResult;
		}
		/* 결과 리턴 */
		result.setResultCode( commonCode.SUCCESS );
		this.isSetHtml = true;
		return result;
	}
	
	/* Type 1. 데이터 검증 반복키워드 중복 검증 */
	private ResultVO CheckValidationType1 ( Document doc ) {
		ResultVO result = new ResultVO( );
		result.setResultCode( "VALIDATION" );
		if ( doc.select( ".subtotalListNum" ).size( ) > 1 ) {
			result.setResultName( " 소계항목 순번은 하나만 설정가능 합니다. " );
		}
		else {
			result.setResultCode( commonCode.SUCCESS );
		}
		return result;
	}
	
	@Test
	public void 소계양식_데이터_조회() throws Exception {
		Map<String, Object> params = new HashMap<>();
		
		params.put("expendSeq", "992");
		
		List<Map<String, Object>> result = userReportDAO.ExReportSubtotalInterLockInfoSelect( params );
		assertTrue(result.size() > 0);
		
		this.contentsData = result;
	}
	
	@Test
	public void testTransformContents() throws Exception {
		// 양식 초기화
		testInitHtmlCode();
				
		소계양식_데이터_조회();
		
		TransformContents();
		
		logger.info("### resultContents = {}", this.resultContents);
		logger.info("### footerData = {}", this.footerData);
	}
	
	/* 항목, 분개, 관리항목 반복에 따른 양식 변환 */
	private ResultVO TransformContents () {
		ResultVO result = new ResultVO( );
		result.setResultCode( commonCode.SUCCESS );
		List<Map<String, Object>> subtotalList = this.contentsData;

		try {
			double subtotalListStdAmtSum = 0;
			double subtotalListTaxAmtSum = 0;
			double subtotalListAmtSum = 0;
			
			for ( int listSeq = subtotalList.size( ) - 1; listSeq > -1; listSeq-- ) {
				Map<String, Object> list = subtotalList.get( listSeq );
				SetResultHtml( list );
				
				// 소계금액 합계
				subtotalListStdAmtSum += Double.parseDouble(CommonConvert.CommonGetSeq(subtotalList.get( listSeq ).get("subtotalListStdAmt")));
				subtotalListTaxAmtSum += Double.parseDouble(CommonConvert.CommonGetSeq(subtotalList.get( listSeq ).get("subtotalListTaxAmt")));
				subtotalListAmtSum += Double.parseDouble(CommonConvert.CommonGetSeq(subtotalList.get( listSeq ).get("subtotalListAmt")));
			}
			
			this.resultContents = listContents;
			
			this.footerData = new HashMap<>();
			this.footerData.put("subtotalListStdAmtSum", subtotalListStdAmtSum);
			this.footerData.put("subtotalListTaxAmtSum", subtotalListTaxAmtSum);
			this.footerData.put("subtotalListAmtSum", subtotalListAmtSum);
		}
		catch ( ValidException ex ) {
			ExpInfo.InfoLog(ex.getMessage());
			result = ex.getResult( );
		}
		return result;
	}
	
	@Test
	public void testSetResultHtml() throws Exception {
		// 양식 초기화
		testInitHtmlCode();
		
		logger.info("### tableContents = {}", this.tableContents);
		
		// 양식에 데이터 치환
		SetResultHtml(dataSet);
		
		logger.info("### listContents = {}", this.listContents);
	}
	
	/* 아이템별 HTML 테이블 생성 / 데이터 파싱 */
	private void SetResultHtml ( Map<String, Object> data ) throws ValidException {
		String tag = "";
		Document doc = Jsoup.parse( this.txtHeader + this.tableContents + this.txtFooter );
		Elements trs = doc.select( "tr" );
		for ( int i = trs.size( ) - 1; i >= 0; i-- ) {
			/* 노멀 케이스 */
			tag = trs.get( i ).toString( );
			this.listContents = getTag( tag, data ) + this.listContents;
		}
	}
	
	@Test
	public void testGetTag() throws ValidException {
		String subtotalListNum = getTag("_subtotalListNum_", dataSet);
		String subtotalDrAcctCode = getTag("_subtotalDrAcctCode_", dataSet);
		String subtotalDrAcctName = getTag("_subtotalDrAcctName_", dataSet);
		String subtotalListStdAmt = getTag("_subtotalListStdAmt_", dataSet);
		String subtotalListTaxAmt = getTag("_subtotalListTaxAmt_", dataSet);
		String subtotalListAmt = getTag("_subtotalListAmt_", dataSet);
		
		logger.info("### subtotalListNum = {}", subtotalListNum);
		logger.info("### subtotalDrAcctCode = {}", subtotalDrAcctCode);
		logger.info("### subtotalDrAcctName = {}", subtotalDrAcctName);
		logger.info("### subtotalListStdAmt = {}", subtotalListStdAmt);
		logger.info("### subtotalListTaxAmt = {}", subtotalListTaxAmt);
		logger.info("### subtotalListAmt = {}", subtotalListAmt);
	}
	
	/* 데이터 조합된 HTML코드 반환 */
	private String getTag ( String tag, Map<String, Object> data ) throws ValidException {
		try {
			/* 기타 정보 처리 */
			String regex = "\\_(.*?)\\_";
			Pattern p = Pattern.compile( regex );
			Matcher m = p.matcher( tag );
			while ( m.find( ) ) {
				String replaceValue = getDataForKey( data, m.group( ) );
				replaceValue = getReplaceValue( replaceValue, m.group( ) );
				tag = tag.replace( m.group( ), replaceValue );
			}
		}
		catch ( Exception ex ) {
			throw new ValidException( "html 변환도중 에러가 발생하였습니다." );
		}
		return tag;
	}
	
	@Test
	public void testTransformFooter() throws Exception {
		// 양식 초기화
		testInitHtmlCode();
				
		소계양식_데이터_조회();
		
		// 소계 content 내용 치환
		TransformContents();
		
		// 소계 footer 내용 치환
		TransformFooter();
		
		logger.info("### tableFooter = {}", this.tableFooter);
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
			replaceValue = getReplaceValue( replaceValue, m.group( ) );
			this.tableFooter = this.tableFooter.replaceAll( m.group( ), replaceValue );
		}
		return result;
	}
	
	@Test
	public void testGetDataForKey() {
		String result = getDataForKey(dataSet, "_subtotalListStdAmt_");
		
		logger.info("### result = {}", result);
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
	
	@Test
	public void testGetReplaceValue() {
		String result = getReplaceValue("17820.00", "_subtotalListStdAmt_");
		
		logger.info("### result = {}", result);
	}
	
	/* 키워드 종류에 따른 예외처리 */
	private String getReplaceValue ( String replaceValue, String keyword ) {
		// TODO: 코드 확장 추가
		switch ( keyword ) {
			/* 순번정보 */
			case "_subtotalListNum_":
				replaceValue = replaceValue.replace( ".0", "" );
				break;
			/* 금액 정보 */
			case "_subtotalListStdAmt_":
			case "_subtotalListTaxAmt_":
			case "_subtotalListAmt_":
			case "_subtotalListStdAmtSum_":
			case "_subtotalListTaxAmtSum_":
			case "_subtotalListAmtSum_":
				replaceValue = CastCurrencyFormat( replaceValue );
				break;
		}
		return replaceValue;
	}
	
	/* 통화코드 변경 */
	private String CastCurrencyFormat ( String data ) {
		if ( data == null ) {
			data = "";
		}
		try {
			BigDecimal bdData = new BigDecimal( data );
			DecimalFormat df = new DecimalFormat( "#,##0" );
			data = df.format( bdData ).toString( );
		}
		catch ( Exception ex ) {
			return data;
		}
		return data;
	}
	
	@Test
	public void 통합_테스트() throws Exception {
		// 양식 초기화
		testInitHtmlCode();
				
		소계양식_데이터_조회();
		
		ResultVO result = SetHtmlForm(this.contentsData);
		
		assertEquals(commonCode.SUCCESS, result.getResultCode());
		
		this.resultHtml = GetResultHtml();
		logger.info("### GetResultHtml = {}", resultHtml);
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
	
	@Test
	public void 기존_html과_소계_html_합치기() throws Exception {
		통합_테스트();
		
		String testHtml = "<table><tbody><tr><td></td></tr></tbody></table>";
		logger.info("### testHtml = {}", testHtml);
		
		Document doc = Jsoup.parse( testHtml );
		Elements tables = doc.getAllElements();
		
		for(Element elem : tables) {
			if(elem.is("body")) {
				elem.append(this.resultHtml);
			}
		}
		
		logger.info("### doc = {}", doc);
	}

}
