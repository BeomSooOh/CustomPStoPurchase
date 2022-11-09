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


public class InterlockHtmlVO {

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
	private int listRowCnt;
	private int listRowEq;
	private int slipRowCnt;
	private int slipRowEq;
	private int mngRowCnt;
	private int mngRowEq;
	private Map<String, Object> headData;
	private List<Map<String, Object>> contentsData;
	private Map<String, Object> footerData;
	private String listContents;
	private String slipContents;
	private String mngContents;
	private boolean isSetHtml;
	private final String expendSeq;
	private final String groupSeq;
	private final String testMode;
	LoginVO loginVo;

	public InterlockHtmlVO ( String html, String expendSeq, String groupSeq, String testMode ) throws NotFoundLoginSessionException {
		/* VO 리뉴얼 */
		this.html = html;
		this.txtHeader = "";
		this.txtFooter = "";
		this.tableHeader = "";
		this.tableFooter = "";
		this.tableContents = "";
		this.loopRowCnt = 0;
		this.loopRowEq = 0;
		this.resultContents = "";
		this.listContents = "";
		this.slipContents = "";
		this.mngContents = "";
		this.listRowEq = -1;
		this.slipRowEq = -1;
		this.mngRowEq = -1;
		this.listRowCnt = 0;
		this.slipRowCnt = 0;
		this.mngRowCnt = 0;
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
		this.txtHeader = this.html.split( "<tbody>" )[0];
		this.txtFooter = this.html.split( "</tbody>" )[1];
		Document doc = Jsoup.parse( html );
		Elements trs = doc.select( "tbody > tr" );
		/* 반복아이템 영역 확인 */
		for ( int i = 0; i < trs.size( ); i++ ) {
			if ( !trs.get( i ).select( ".listNum" ).toString( ).equals( "" ) ) {
				this.listRowEq = i;
				String rowspan = trs.get( i ).select( ".listNum" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.listRowCnt = CastStringToInt( rowspan );
			}
			if ( !trs.get( i ).select( ".slipNum" ).toString( ).equals( "" ) ) {
				this.slipRowEq = i;
				String rowspan = trs.get( i ).select( ".slipNum" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.slipRowCnt = CastStringToInt( rowspan );
			}
			if ( !trs.get( i ).select( ".mngNum" ).toString( ).equals( "" ) ) {
				this.mngRowEq = i;
				String rowspan = trs.get( i ).select( ".mngNum" ).attr( "rowspan" );
                rowspan = rowspan.equals("") ? "1" : rowspan;
				this.mngRowCnt = CastStringToInt( rowspan );
			}
		}
		/* table loop 영역 설정 */
		if ( this.listRowEq > -1 ) {
			this.loopRowEq = this.listRowEq;
			this.loopRowCnt = this.listRowCnt;
		}
		else if ( this.slipRowEq > -1 ) {
			this.loopRowEq = this.slipRowEq;
			this.loopRowCnt = this.slipRowCnt;
		}
		else if ( this.mngRowEq > -1 ) {
			this.loopRowEq = this.mngRowEq;
			this.loopRowCnt = this.mngRowCnt;
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
		List<Map<String, Object>> listList = this.contentsData;

		try {
			for ( int listSeq = listList.size( ) - 1; listSeq > -1; listSeq-- ) {
				Map<String, Object> list = listList.get( listSeq );
				ArrayList<HashMap<String, Object>> slipList = (ArrayList<HashMap<String, Object>>) list.get( "slip" );
				for ( int slipSeq = slipList.size( ) - 1; slipSeq > -1; slipSeq-- ) {
					Map<String, Object> slip = slipList.get( slipSeq );
					ArrayList<HashMap<String, Object>> mngList = (ArrayList<HashMap<String, Object>>) slip.get( "mng" );
					for ( int mngSeq = mngList.size( ) - 1; mngSeq > -1; mngSeq-- ) {
						Map<String, Object> mng = mngList.get( mngSeq );
						if ( doc.select( ".mngNum" ).size( ) > 0 ) {
							SetResultHtml( "mng", mngSeq, list, slip, mng );
						}
					}
					if ( doc.select( ".slipNum" ).size( ) > 0 ) {
						SetResultHtml( "slip", slipSeq, list, slip, null );
					}
					this.slipContents = this.mngContents + this.slipContents;
					this.mngContents = "";
				}
				SetResultHtml( "list", listSeq, list, null, null );
				this.listContents = this.slipContents + this.listContents;
				this.slipContents = "";
			}
			this.resultContents = listContents;
		}
		catch ( ValidException ex ) {
			//System.out.println( ex.getMessage( ) );
			result = ex.getResult( );
		}
		return result;
	}

	/* 아이템별 HTML 테이블 생성 / 데이터 파싱 */
	int rsList = 0;
	int rsSlip = 0;

	private void SetResultHtml ( String type, int idx, Map<String, Object> list, Map<String, Object> slip, Map<String, Object> mng ) throws ValidException {
		int listCopyRangeFrom = this.listRowEq - loopRowEq;
		int slipCopyRangeFrom = this.slipRowEq - loopRowEq;
		int mngCopyRangeFrom = this.mngRowEq - loopRowEq;

		int listCopyRangeTo = this.listRowCnt + listCopyRangeFrom - 1;
		int slipCopyRangeTo = this.slipRowCnt + slipCopyRangeFrom - 1;
		int mngCopyRangeTo = this.mngRowCnt + mngCopyRangeFrom - 1;
		String tag = "";
		Document doc = Jsoup.parse( this.txtHeader + this.tableContents + this.txtFooter );
		Elements trs = doc.select( "tr" );
		for ( int i = trs.size( ) - 1; i >= 0; i-- ) {
			if ( type == "mng" ) {
				/* 관리항목 일반 케이스 처리 */
				if ( (i >= mngCopyRangeFrom) && i <= mngCopyRangeTo ) {
					trs.select( ".slipNum" ).remove( );
					tag = trs.get( i ).toString( );
					this.mngContents = getTag( tag, list, slip, mng, "mng" ) + mngContents;
					rsSlip++;
					rsList++;
				}
			}
			else if ( type == "slip" ) {
				/* 로우스판 처리 */
				if ( i == slipCopyRangeFrom ) {
					int rowspan = (this.slipRowCnt - this.mngRowCnt) + rsSlip;
					doc.select( ".slipNum" ).attr( "rowspan", ("" + rowspan) );
					/* 특이케이스 아닌경우 */
					if ( slipCopyRangeFrom != mngCopyRangeFrom ) {
						rsSlip = 0;
					}
				}
				/* 상위코드와 래밸이 같은 경우 / 최상위 idx = 0 */
				if ( i == slipCopyRangeFrom && i == listCopyRangeFrom ) {
					trs.select( ".slipNum" ).prevAll( ).remove( );
				}
				/* 하위코드와 래벨이 같은경우 / 최상위 idx = 0 */
				if ( i == slipCopyRangeFrom && i == mngCopyRangeFrom ) {
					trs.select( ".slipNum" ).nextAll( ).remove( );
					rsList++;
					int rowspan = (this.slipRowCnt - this.mngRowCnt) + rsSlip + 1;
					doc.select( ".slipNum" ).attr( "rowspan", ("" + rowspan) );
					tag = trs.get( i ).toString( );
					this.mngContents = getTag( tag, list, slip, mng, "slip" ) + this.mngContents;
					rsSlip = 0;
				}
				/* 노멀 케이스 */
				if ( ((i >= slipCopyRangeFrom) && i <= slipCopyRangeTo) && (i < mngCopyRangeFrom || i > mngCopyRangeTo) ) {
					if ( idx != 0 ) {
						trs.select( ".listNum" ).remove( );
					}
					rsList++;
					tag = trs.get( i ).toString( );
					if ( (i > mngCopyRangeTo) && (mngCopyRangeTo > -1) ) {
						this.mngContents = this.mngContents + tag;
					}
					else {
						this.mngContents = getTag( tag, list, slip, mng, "slip" ) + this.mngContents;
					}
				}
			}
			else if ( type == "list" ) {
				/* 로우스판 처리 */
				if ( i == listCopyRangeFrom ) {
					int rowspan = (this.listRowCnt - this.slipRowCnt) + rsList;
					doc.select( ".listNum" ).attr( "rowspan", ("" + rowspan) );
					/* 특이케이스 아닌경우 */
					if ( listCopyRangeFrom != slipCopyRangeFrom ) {
						rsList = 0;
					}
				}
				/* 하위코드와 래벨이 같은 경우 / 최상위 idx = 0 */
				if ( i == listCopyRangeFrom && i == slipCopyRangeFrom ) {
					trs.select( ".listNum" ).nextAll( ).remove( );
					int rowspan = (this.listRowCnt - this.slipRowCnt) + rsList + 1;
					doc.select( ".listNum" ).attr( "rowspan", ("" + rowspan) );
					tag = trs.get( i ).toString( );
					this.slipContents = getTag( tag, list, slip, mng, "list" ) + this.slipContents;
					rsList = 0;
				}
				/* 노멀 케이스 */
				if ( ((i >= listCopyRangeFrom) && i <= listCopyRangeTo) && (i < slipCopyRangeFrom || i > slipCopyRangeTo) ) {
					if ( idx != 0 ) {
						trs.select( ".slipNum" ).remove( );
					}
					tag = trs.get( i ).toString( );
					if ( (i > slipCopyRangeTo) && (slipCopyRangeTo > -1) ) {
						this.slipContents = this.slipContents + tag;
					}
					else {
						this.slipContents = getTag( tag, list, slip, mng, "list" ) + this.slipContents;
					}
				}
			}
		}
	}

	/* 데이터 조합된 HTML코드 반환 */
	private String getTag ( String tag, Map<String, Object> list, Map<String, Object> slip, Map<String, Object> mng, String type ) throws ValidException {
		Map<String, Object> dataSet = new HashMap<>( );
		String idx = "";
		try {
			if ( type.equals( "list" ) ) {
				dataSet = list;
				idx = dataSet.get( "listNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_listNum_", idx );
			}
			else if ( type.equals( "slip" ) ) {
				dataSet = slip;
				idx = dataSet.get( "slipNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_slipNum_", idx );
				tag = tag.replaceAll( "_slipDrNum_", dataSet.get( "slipNum2" ).toString( ).replace( ".0", "" ) );
				tag = tag.replaceAll( "_slipCrNum_", dataSet.get( "slipNum2" ).toString( ).replace( ".0", "" ) );
			}
			else if ( type.equals( "mng" ) ) {
				dataSet = mng;
				idx = dataSet.get( "mngNum" ).toString( ).replace( ".0", "" );
				idx = String.valueOf( Integer.parseInt( idx ) );
				tag = tag.replaceAll( "_mngNum_", idx );
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
		// TODO: 코드 확장 추가
		switch ( keyword ) {
			/* 관리항목 팝업 */
			case "_mngPop_":
				if ( this.testMode.equals( "Y" ) ) {
					replaceValue = "<a href=\"#n\" class='print' >[상세]</a>";
				}
				else {
					replaceValue = "<a class='print' onclick=\"javascript:window.open('/exp/ApprovalSlipPop.do?expend_seq=" + this.expendSeq + "&amp;list_seq=" + dataSet.get( "listSeq" ) + "&amp;group_seq=" + this.groupSeq + "&amp;slip_seq=" + dataSet.get( "slipSeq" ) + "','','width=700, height=600')\" style='color:#3aa1f3;' href=\"#n\" >[상세]</a>";
				}
				break;
			case "_slipPop_":
				/* 분개정보 팝업 */
				if ( this.testMode.equals( "Y" ) ) {
					replaceValue = "<a href=\"#n\" class='print' >[상세]</a>";
				}
				else {
					replaceValue = "<a class='print' onclick=\"javascript:window.open('/exp/ApprovalListPop.do?expend_seq=" + this.expendSeq + "&amp;list_seq=" + dataSet.get( "listSeq" ) + "&amp;group_seq=" + this.groupSeq + "','','width=700, height=600')\" style='color:#3aa1f3;' href=\"#n\">[상세]</a>";
				}
				break;
			/* 카드정보 팝업 */
			case "_cardName_":
			case "_slipCardName_":
				if ( this.testMode.equals( "Y" ) ) {
					replaceValue = "<a href=\"#n\" class='print' >[상세]</a>";
				}
				else {
					if ( getDataForKey( dataSet, "_interfaceMId_" ).equals( "" ) || getDataForKey( dataSet, "_interfaceMId_" ).equals( "0" ) ) {
						replaceValue = getDataForKey( dataSet, keyword );
					}
					else if( getDataForKey( dataSet, "_interfaceType_" ).equals( "card" ) ){
                        replaceValue = "<a href=\"#n\" class='print' onclick=\"javascript:window.open('/exp/expend/ex/user/card/ExExpendCardDetailInfo.do?syncId=" + getDataForKey(dataSet, "_interfaceMId_") + "', '', 'width=450, height=470, resizable=yes')\" style='color:#3aa1f3;' >" + getDataForKey(dataSet, keyword) + "</a>";
					}
				}
				break;
			/* 세금계산서 팝업 - 상겸 */
			case "_etaxIssNo_":
			case "_etaxHometaxIssNo_":
				if ( this.testMode.equals( "Y" ) ) {
					replaceValue ="<a href=\"#n\" class='print' >[상세]</a>";
				}
				else {
					if ( getDataForKey( dataSet, "_interfaceMId_" ).equals( "" ) || getDataForKey( dataSet, "_etaxIssNo_" ).equals( "0" ) ) {
						replaceValue = getDataForKey( dataSet, keyword );
					}
					else if( getDataForKey( dataSet, "_interfaceType_" ).equals( "etax" ) ){
						replaceValue = "<a style='color:#3aa1f3;' class='print' href=\"#n\" onclick=\"javascript:if(navigator.userAgent.match(/Android|iPhone|iPad|iPod/i) == null) { window.open('/exp/expend/np/user/UserETaxDetailPop.do?syncId=" + getDataForKey( dataSet, "_etaxIssNo_" ) + "', '', 'width=920, height=588'); } else { return; }\">" + getDataForKey( dataSet, keyword ) + "</a>";
					}
				}
				break;
			/* 첨부파일 팝업 */
			case "_attach_":
			case "_slipAttach_":
				if ( this.testMode.equals( "Y" ) ) {
					replaceValue = "<a href=\"#n\" class='print' >[첨부파일]</a>";
				}
				else {
					List<Map<String, Object>> fileDetailInfo = new ArrayList<Map<String, Object>>( );
					try {
						fileDetailInfo = CommonConvert.CommonGetJSONToListMap( dataSet.get( "fileDetailInfo" ).toString( ) );
						if ( fileDetailInfo != null && fileDetailInfo.size( ) > 0 ) {
							for ( Map<String, Object> tData : fileDetailInfo ) {
								tData.put( "originalFileName", java.net.URLEncoder.encode( tData.get( "originalFileName" ).toString( ), "utf-8" ) );
							}
							/* http://jira.duzon.com:8080/browse/UBA-2535 */
							/* IP 변경 또는 도메인 변경시 기존 정보를 확인할 수 없는 문제점이 확인 됨 */
							/* 변경 전 소스 : replaceValue = "<a onclick=\"javascript:window.open((navigator.userAgent.match(/Android|iPhone|iPad|iPod/i) == null ?'http://" + dataSet.get( "compDomain" ) + "/exp/ApprovalAttachPop.do" + "?" + "expend_seq=" + this.expendSeq + "&list_seq=" + dataSet.get( "listSeq" ) + "&slip_seq=" + (dataSet.get( "slipSeq" ) == null ? "0" : dataSet.get( "slipSeq" )) + "&group_seq=" + this.groupSeq + "':'app://bizboxa/exp/ex/attachDetail?" + "&eaType=" + loginVo.getEaType( ) + "&fileData=" + CommonConvert.CommonGetListMapToJson( fileDetailInfo ).replaceAll( "\"", "&quot;" ) + "'),'',width=500, height=500)\" href='#n'>" + "[첨부파일]" + "</a> "; */
							replaceValue = "<a style='color:#3aa1f3;' class='print' onclick=\"javascript:window.open((navigator.userAgent.match(/Android|iPhone|iPad|iPod/i) == null ?'/exp/ApprovalAttachPop.do" + "?" + "expend_seq=" + this.expendSeq + "&list_seq=" + dataSet.get( "listSeq" ) + "&slip_seq=" + (dataSet.get( "slipSeq" ) == null ? "0" : dataSet.get( "slipSeq" )) + "&group_seq=" + this.groupSeq + "':'app://bizboxa/exp/ex/attachDetail?" + "&eaType=" + loginVo.getEaType( ) + "&fileData=" + CommonConvert.CommonGetListMapToJson( fileDetailInfo ).replaceAll( "\"", "&quot;" ) + "'),'',width=500, height=500)\" href='#n'>" + "[첨부파일]" + "</a> ";
						}
						else {
							replaceValue = "";
						}
					}
					catch ( Exception e ) {
						// TODO Auto-generated catch block
						replaceValue = "";
					}
				}
				break;
		    /* 코스트센타명 / 회계단위명 - 준성 */
			case "_expendEmpErpPcName_":
			case "_expendEmpErpCcName_":
			/* 금액 정보 */
			case "_slipCrAmt_":
			case "_slipDrAmt_":
			case "_listStdAmt_":
			case "_listSubStdAmt_":
			case "_listTaxAmt_":
			case "_listSubTaxAmt_":
			case "_listAmt_":
			case "_crAmt_":
			case "_vatAmt_":
			case "_subStdAmt_":
			case "_subTaxAmt_":
			case "_reqAmt_":
			case "_drAmt_":
			case "_amt_":
			case "_budgetActsum_":
			case "_budgetJsum_":
			case "_budgetRemainAmt_":
			case "_slipSubStdAmt_":
			case "_slipSubTaxAmt_":
			case "_cardRequestAmount_":
			case "_cardAmtAmount_":
			case "_cardVatAmount_":
				replaceValue = CastCurrencyFormat( replaceValue );
				break;
			/* 날짜 정보 변경 */
			case "_expendDate_":
			case "_expendReqDate_":
			case "_authDate_":
			case "_cardAuthDate_":
			case "_slipBudgetYm_":
			case "_slipAuthDate_":
			case "_slipCardAuthDate_":
			case "_budgetYm_":
				if ( replaceValue != null ) {
					if ( replaceValue.length( ) > 7 ) {
						replaceValue = replaceValue.substring( 0, 4 ) + "-" + replaceValue.substring( 4, 6 ) + "-" + replaceValue.substring( 6, 8 );
					}else if( replaceValue.length( ) == 6 ){
						replaceValue = replaceValue.substring( 0, 4 ) + "-" + replaceValue.substring( 4, 6 );
					}
				}
				break;
			/* 시간 정보 변경 */
			case "_cardAuthTime_":
			case "_slipCardAuthTime_":
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
			/* 특수문자 변경 */
			case "_projectName_":
			case "_budgetName_":
				if(replaceValue != null) {
					replaceValue = ConvertSpecialCharacter(replaceValue);
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
		drCount = doc.select( ".slipDrNum" ).size( );
		crCount = doc.select( ".slipCrNum" ).size( );
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
				List<Map<String, Object>> slipList = (List<Map<String, Object>>) this.contentsData.get( i ).get( "slip" );
				List<Map<String, Object>> newSlipList = new ArrayList<>( );
				for ( Map<String, Object> slip : slipList ) {
					if ( slip.get( "slipDrcrGbnCode" ).equals( dcFlag ) ) {
						newSlipList.add( slip );
					}
				}
				this.contentsData.get( i ).put( "slip", newSlipList );
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
		int listMax = listRowEq + listRowCnt;
		int listMin = listRowEq;
		int slipMax = slipRowEq + slipRowCnt;
		int slipMin = slipRowEq;
		int mngMax = mngRowEq + mngRowCnt;
		int mngMin = mngRowEq;
		/* 관리항목이 존재하는 경우. */
		if ( mngRowEq > -1 ) {
			if ( (slipRowEq > -1) && ((mngMin < slipMin) || (mngMax > slipMax)) ) {
				result.setResultName( "관리항목은 분개정보 안에 위치해야 합니다." );
				return result;
			}
		}
		/* 분개정보가 존재하는 경우 */
		if ( slipRowEq > -1 ) {
			if ( (listRowEq > -1) && ((slipMin < listMin) || (slipMax > listMax)) ) {
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
		if ( doc.select( ".listNum" ).size( ) > 1 ) {
			result.setResultName( " 항목 순번은 하나만 설정가능 합니다. " );
		}
		else if ( doc.select( ".slipNum" ).size( ) > 1 ) {
			result.setResultName( " 분개 순번은 하나만 설정가능 합니다. " );
		}
		else if ( doc.select( ".mngNum" ).size( ) > 1 ) {
			result.setResultName( " 관리항목 순번은 하나만 설정가능 합니다. " );
		}
		else {
			result.setResultCode( commonCode.SUCCESS );
		}
		return result;
	}

	/* 통화코드 변경 */
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
	private String ConvertSpecialCharacter(String value) {
		value = value.replaceAll("<", "&lt;");
		value = value.replaceAll(">", "&gt;");

		return value;
	}
}
