package common.vo.form;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.swing.text.MaskFormatter;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;


public class InterlockNPHTMLVO {


	@Resource(name = "CommonLogger")
	private CommonLogger	cmLog;

	String htmlCode;
	public InterlockNPHTMLVO ( String html, String expendSeq, String groupSeq, String testMode ) throws NotFoundLoginSessionException {
		String back1 = expendSeq;
		String back12= groupSeq;
		String back3 = testMode;
		htmlCode = html;
	}

	/**
	 * 입력된 정보를 기준하여 반환 HTML코드를 준비 합니다.
	 */
	public ResultVO SetHtmlForm (Map<String, Object> headData, Map<String, Object> contentsData, Map<String, Object> footerData ){
		ResultVO result = new ResultVO( );
		String resultStr = "";
		Document doc = Jsoup.parse( this.htmlCode );

		/* 치환 영역 준비 */
		doc.select( ".projectTable" ).after( "<div id=\"div_projectTable\"></div>" );
		doc.select( ".budgetTable" ).after( "<div id=\"div_budgetTable\"></div>" );
		doc.select( ".tradeTable" ).after( "<div id=\"div_tradeTable\"></div>" );
		doc.select( ".tripProjectTable" ).after( "<div id=\"div_tripProjectTable\"></div>" );
		doc.select( ".tripBudgetTable" ).after( "<div id=\"div_tripBudgetTable\"></div>" );
		doc.select( ".tripTradeTable" ).after( "<div id=\"div_tripTradeTable\"></div>" );
		doc.select( ".itemTable" ).after( "<div id=\"div_itemTable\"></div>" );


		/* 기준테이블 정보 저장및 삭제 */
		Elements projectTable = doc.select( ".projectTable" );
		Elements budgetTable = doc.select( ".budgetTable" );
		Elements tradeTable = doc.select( ".tradeTable" );
		Elements tripProjectTable = doc.select( ".tripProjectTable" );
		Elements tripBudgetTable = doc.select( ".tripBudgetTable" );
		Elements tripTradeTable = doc.select( ".tripTradeTable" );
		Elements itemTable = doc.select( ".itemTable" );

		doc.select( ".projectTable" ).remove( );
		doc.select( ".budgetTable" ).remove( );
		doc.select( ".tradeTable" ).remove( );
		doc.select( ".tripProjectTable" ).remove( );
		doc.select( ".tripBudgetTable" ).remove( );
		doc.select( ".tripTradeTable" ).remove( );
		doc.select( ".itemTable" ).remove( );


		/* 기준 테이블 양식 정보 수정진행 */
		projectTable = getProcessedProjectTable(projectTable, (List<Map<String, Object>>)contentsData.get( "project" ));
		budgetTable = getProcessedBudgetTable(budgetTable, (List<Map<String, Object>>)contentsData.get( "budget" ));
		tradeTable = getProcessedTradeTable(tradeTable, (List<Map<String, Object>>)contentsData.get( "trade" ));
		tripProjectTable = getProcessedTripProjectTable(tripProjectTable, (List<Map<String, Object>>)contentsData.get( "tripProject" ));
		tripBudgetTable = getProcessedTripBudgetTable(tripBudgetTable, (List<Map<String, Object>>)contentsData.get( "tripBudget" ));
		tripTradeTable = getProcessedTripTradeTable(tripTradeTable, (List<Map<String, Object>>)contentsData.get( "tripTrade" ));
		itemTable = getProcessedItemTable(itemTable, (List<Map<String, Object>>)contentsData.get( "item" ));



		/* 기준테이블 입력 */
		doc.select( "#div_projectTable" ).after( projectTable.toString( ) );
		doc.select( "#div_budgetTable" ).after( budgetTable.toString( ) );
		doc.select( "#div_tradeTable" ).after( tradeTable.toString( ) );
		doc.select( "#div_tripProjectTable" ).after( tripProjectTable.toString( ) );
		doc.select( "#div_tripBudgetTable" ).after( tripBudgetTable.toString( ) );
		doc.select( "#div_tripTradeTable" ).after( tripTradeTable.toString( ) );
		doc.select( "#div_itemTable" ).after( itemTable.toString( ) );


		doc.select( "#div_projectTable" ).remove( );
		doc.select( "#div_budgetTable" ).remove( );
		doc.select( "#div_tradeTable" ).remove( );
		doc.select( "#div_tripProjectTable" ).remove( );
		doc.select( "#div_tripBudgetTable" ).remove( );
		doc.select( "#div_tripTradeTable" ).remove( );
		doc.select( "#div_itemTable" ).remove( );


		/* 헤더 / 푸터 데이터 처리 */
		headData.put( "totalTradeAmt", footerData.get( "totalTradeAmt" ) );
		headData.put( "totalStdAmt", footerData.get( "totalStdAmt" ) );
		headData.put( "totalVatAmt", footerData.get( "totalVatAmt" ) );

		headData.put( "HANtotalVatAmt", footerData.get( "HANtotalVatAmt" ) );
		headData.put( "HANtotalTradeAmt", footerData.get( "HANtotalTradeAmt" ) );
		headData.put( "HANtotalStdAmt", footerData.get( "HANtotalStdAmt" ) );
		headData.put( "HANtotalBudgetAmt", footerData.get( "HANtotalBudgetAmt" ) );

		headData.put( "totalBudgetAmt", footerData.get( "totalBudgetAmt" ) );
		headData.put( "totalBudgetStdAmt", footerData.get( "totalBudgetStdAmt" ) );
		headData.put( "totalBudgetVatAmt", footerData.get( "totalBudgetVatAmt" ) );
		resultStr = SetHeaderFormatInfo(doc.toString( ), headData);

		this.htmlCode = resultStr;
		result.setSuccess( );
		return result;
	}



	/**
	 * 입력된 정보를 기준하여 작성된 HTML코드를 반환합니다.
	 */
	public String GetResultHtml ( ) {
		return htmlCode;
	}


	/*******************************************
				private 메소드 영역
	*******************************************/
	/* 헤더 데이터 정보 치환 */
	private String SetHeaderFormatInfo(String base, Map<String, Object> data){
		String codes = base;
		return getReplacementCode(codes, data);
	}

	/* 푸터 데이터 정보 치환 */
	@SuppressWarnings("unused")
	private String SetFooterFormatInfo(String base, Map<String, Object> data){
		String codes = base;
		return getReplacementCode(codes, data);
	}

	/* 물품명세 테이블 조회 */
	private Elements getProcessedItemTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String itemTrs = "";
		if(base.select( ".itemBaseTr" ).size( ) == 0){
			return base;
		}

		Elements temp = base.select( ".itemBaseTr" ).clone( );
		for(int i = 0 ; i < temp.size( ); i ++){
			itemTrs += temp.get( i ).removeClass( "itemBaseTr" ).toString( );
		}

		for(int i = 0 ; i < data.size() ; i++){
			Map<String, Object> item = data.get( i );
			resultTrs += getReplacementCode(itemTrs.replace( "_itemNum_", "" + ( i + 1 ) ), item);
		}

		base.select( ".itemBaseTr" ).last( ).after( resultTrs );
		base.select( ".itemBaseTr").remove( );

		return base;
	}
	

	/* 프로젝트 테이블 조회 */
	private Elements getProcessedProjectTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String projectTrs = "";
		if(base.select( ".projectBaseTr" ).size( ) == 0){
			return base;
		}

		Elements temp = base.select( ".projectBaseTr" ).clone( );
		for(int i = 0 ; i < temp.size( ); i ++){
			projectTrs += temp.get( i ).removeClass( "projectBaseTr" ).toString( );
		}

		for(int i = 0 ; i < data.size() ; i++){
			Map<String, Object> item = data.get( i );
			resultTrs += getReplacementCode(projectTrs.replace( "_projectNum_", "" + ( i + 1 ) ), item);
		}

		base.select( ".projectBaseTr" ).last( ).after( resultTrs );
		base.select( ".projectBaseTr").remove( );

		return base;
	}

	/* 예산 테이블 조회 */
	private Elements getProcessedBudgetTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String budgetTrs = "";

		if(base.select( ".budgetBaseTr" ).size( ) == 0){
			return base;
		}

		Elements temp = base.select( ".budgetBaseTr" ).clone( );
		for(int i = 0 ; i < temp.size( ); i ++){
			budgetTrs += temp.get( i ).removeClass( "budgetBaseTr" ).toString( );
		}

		String seqKey = data.get(0).get("resSeq") == null ? "consSeq" : "resSeq";

		String tempResSeq = data.get(0).get(seqKey).toString();
		Boolean isMultiResDoc = false;
		for(int i = 0 ; i < data.size() ; i++){
			if(!tempResSeq.equals(data.get(i).get(seqKey).toString())) {
				isMultiResDoc = true;
			}
		}
		int index = 1;
		int j = 1;
		for(int i = 0 ; i < data.size() ; i++){
			Map<String, Object> item = data.get( i );

			if(!isMultiResDoc) {
				resultTrs += getReplacementCode(budgetTrs.replace( "_budgetNum_", ""+(i+1) ), item);
			}
			else {
				if(!tempResSeq.equals(item.get(seqKey).toString())) {
					index = 1;
					j++;
					tempResSeq = item.get(seqKey).toString();
				}
				resultTrs += getReplacementCode(budgetTrs.replace( "_budgetNum_", ""+ j + "-" + index++ ), item);
			}
		}

		base.select( ".budgetBaseTr" ).last( ).after( resultTrs );
		base.select( ".budgetBaseTr").remove( );

		return base;
	}

	/* 거래처 테이블 조회 */
	private Elements getProcessedTradeTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String tradeTrs = "";
		if(base.select( ".tradeBaseTr" ).size( ) == 0){
			return base;
		}
		if(data.size()!=0) {

			/*	[1] INTERLOCK HTML 보정 클래스 제거 */
			Elements temp = base.select( ".tradeBaseTr" ).clone( );
			for(int i = 0 ; i < temp.size( ); i ++){
				tradeTrs += temp.get( i ).removeClass( "tradeBaseTr" ).toString( );
			}

			/*	[2] 거래처 데이터 무결 검증 확인 */
			if(data.size( ) == 0){
				cmLog.CommonSetErrorToDatabase( new Exception("[EXNP - InterlockNPHTMLVO.getProcessedTradeTable] 거래처 무결 검증 오류 DATA : " + data.toString( )), "", "", "EXNP");
				return null;
			}

			/*	[3] 거래처 정보 순번 보정 */
			TempDoc tempResMap = new TempDoc();
			String keyName = data.get(0).get("resSeq") == null ? "consSeq" : "resSeq";
			tempResMap.setHeadSeq( CommonConvert.NullToString( data.get(0).get( keyName ) ), "1" );
			tempResMap.setBudgetSeq( CommonConvert.NullToString( data.get(0).get( "budgetSeq" ) ), "1" );
			Boolean isMultiResDoc = false;
			for(int i = 1 ; i < data.size() ; i++){
				String preHeadKey = CommonConvert.NullToString( data.get(i - 1).get(keyName) );
				String thisHeadKey = CommonConvert.NullToString( data.get(i).get(keyName) );

				if( !preHeadKey.equals( thisHeadKey ) ){
					isMultiResDoc = true;
					break;
				}
			}

			int headIndex = 1;
			int budgetIndex = 1;
			for(int i = 0 ; i < data.size() ; i++){
				Map<String, Object> item = data.get( i );

				if(!isMultiResDoc) {
					resultTrs += getReplacementCode(tradeTrs.replace( "_tradeNum_", ""+(i+1) ), item);
				} else {
					if( tempResMap.getHeadSeq().containsKey( item.get(keyName).toString() )) {
						if(!tempResMap.getBudgetSeq().containsKey(item.get("budgetSeq").toString())) {
							budgetIndex = budgetIndex + 1;
							tempResMap.setBudgetSeq( CommonConvert.NullToString( item.get( "budgetSeq" ) ), ""+budgetIndex );
						}else {
							tempResMap.setBudgetSeq( CommonConvert.NullToString( item.get( "budgetSeq" ) ), ""+budgetIndex );
						}

						String headIndexPrint = tempResMap.getHeadSeq().get( CommonConvert.NullToString( item.get( keyName ) ) );
						String budgetIndexPrint = tempResMap.getBudgetSeq().get( CommonConvert.NullToString( item.get( "budgetSeq" ) ) );
						resultTrs += getReplacementCode(tradeTrs.replace( "_tradeNum_", ""+ headIndexPrint + "-" + budgetIndexPrint ), item);
					}
					else {
						headIndex = headIndex + 1;
						budgetIndex = 1;
						tempResMap.setHeadSeq(CommonConvert.NullToString( item.get( keyName ) ), ""+headIndex);
						tempResMap.setBudgetSeq(CommonConvert.NullToString( item.get( "budgetSeq" ) ), ""+budgetIndex);
						String headIndexPrint = tempResMap.getHeadSeq().get(( CommonConvert.NullToString( item.get( keyName ))));
						String budgetIndexPrint = tempResMap.getBudgetSeq().get( CommonConvert.NullToString( item.get( "budgetSeq" ) ) );
						resultTrs += getReplacementCode(tradeTrs.replace( "_tradeNum_", ""+ headIndexPrint + "-" + budgetIndexPrint ), item);

					}
				}
			}

			if(base.select( ".tradeBaseTr" ).size( ) == 0){
				return base;
			}

			base.select( ".tradeBaseTr" ).last( ).after( resultTrs );
			base.select( ".tradeBaseTr").remove( );
		}
		return base;
	}

	/* getProcessedTradeTable 거래처 테이블 trade_num 생성을 위한 이너 클래스 */
	class TempDoc {
		private final HashMap <String, String> headSeq = new HashMap<>();
		private final HashMap <String, String> budgetSeq = new HashMap<>();

		public void setHeadSeq(String headSeq , String index) {
			this.headSeq.put(headSeq, index);
		}

		public HashMap<String, String> getHeadSeq() {
			return this.headSeq;
		}

		public void setBudgetSeq(String budgetSeq , String index) {
			this.budgetSeq.put(budgetSeq, index);
		}

		public HashMap<String, String> getBudgetSeq() {
			return this.budgetSeq;
		}
	}

	/* 출자복명 출장내역 테이블 조회 */
	private Elements getProcessedTripProjectTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String projectTrs = "";
		if(base.select( ".tripProjectBaseTr" ).size( ) == 0){
			return base;
		}

		Elements temp = base.select( ".tripProjectBaseTr" ).clone( );
		for(int i = 0 ; i < temp.size( ); i ++){
			projectTrs += temp.get( i ).removeClass( "tripProjectBaseTr" ).toString( );
		}

		for(int i = 0 ; i < data.size() ; i++){
			Map<String, Object> item = data.get( i );
			resultTrs += getReplacementCode(projectTrs.replace( "_tripProjectNum_", "" + ( i + 1 ) ), item);
		}

		base.select( ".tripProjectBaseTr" ).last( ).after( resultTrs );
		base.select( ".tripProjectBaseTr").remove( );

		return base;
	}

	/* 출장복명 품의내역 테이블 조회 */
	private Elements getProcessedTripBudgetTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String budgetTrs = "";

		if(base.select( ".tripBudgetBaseTr" ).size( ) == 0){
			return base;
		}

		Elements temp = base.select( ".tripBudgetBaseTr" ).clone( );
		for(int i = 0 ; i < temp.size( ); i ++){
			budgetTrs += temp.get( i ).removeClass( "tripBudgetBaseTr" ).toString( );
		}

		for(int i = 0 ; i < data.size() ; i++){
			Map<String, Object> item = data.get( i );

			resultTrs += getReplacementCode(budgetTrs.replace( "_tripBudgetNum_", ""+(i+1) ), item);
		}

		base.select( ".tripBudgetBaseTr" ).last( ).after( resultTrs );
		base.select( ".tripBudgetBaseTr").remove( );

		return base;
	}

	/* 출장복명 경비내역 테이블 조회 */
	private Elements getProcessedTripTradeTable( Elements base, List<Map<String, Object>> data ){
		String resultTrs = "";
		String tradeTrs = "";
		if(base.select( ".tripTradeBaseTr" ).size( ) == 0){
			return base;
		}
		if(data.size()!=0) {
			Elements temp = base.select( ".tripTradeBaseTr" ).clone( );
			for(int i = 0 ; i < temp.size( ); i ++){
				tradeTrs += temp.get( i ).removeClass( "tripTradeBaseTr" ).toString( );
			}

			for(int i = 0 ; i < data.size() ; i++){
				//System.out.println( data.toString( ) );
				Map<String, Object> item = data.get( i );
				resultTrs += getReplacementCode(tradeTrs.replace( "_tripTradeNum_", ""+(i+1) ), item);
			}

			if(base.select( ".tripTradeBaseTr" ).size( ) == 0){
				return base;
			}

			base.select( ".tripTradeBaseTr" ).last( ).after( resultTrs );
			base.select( ".tripTradeBaseTr").remove( );
		}
		return base;
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

	/* 양식 ROW REPLACE */
	private String getReplacementCode(String code, Map<String, Object> params){
		String returnCode = code;

		String regex = "\\_[a-zA-Z0-9]+\\_";
		Pattern p = Pattern.compile( regex );
		Matcher m = p.matcher( code );

		while ( m.find( ) ) {
			String replaceValue = getDataForKey( params, m.group( ) );
			//replaceValue = getReplaceValue( replaceValue, m.group( ), params );
			replaceValue = getReplaceValue( replaceValue, m.group( ) );
			try{
				returnCode = returnCode.replaceAll( m.group( ), replaceValue.replaceAll("\\\\", " \\\\\\\\ ") );
			}
			catch( Exception ex){
				//System.out.println( replaceValue );
			}
		}
		return returnCode;
	}

	/* 키워드 종류에 따른 예외처리 */
	//private String getReplaceValue ( String replaceValue, String keyword, Map<String, Object> dataSet ) {
	private String getReplaceValue ( String replaceValue, String keyword ) {
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
			case "_etcRequiredAmt_" :
			case "_etcSchoolAmt_" :
			case "_etcIncomeAmt_" :
			case "_etcIncomeVatAmt_" :
			case "_etcResidentVatAmt_" :
			case "_etcEmploymentAmt_" :
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
			case "_stackConfferBalanceAmt_":
			case "_stackConfferResAmt_":
			case "_stackResultAmt_":
			case "_stackApplyAmt_":
			case "_applyTryAmt_":
			case "_stackConfferResultAmt_":
			case "_unitAmt_" :
			case "_itemAmt_" :

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
						MaskFormatter f = new MaskFormatter( "****-****-****-****" );
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
			default :
				break;
		}
		return replaceValue;
	}
}










