package common.vo.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExErpSendiCUBEVO {

	private final List<Map<String, Object>> originData;
	private final ArrayList<aData> dataList;
	private int length;
	private int index;
	private boolean isEmpty;
	public aData data;
	private String compSeq;
	private String expendSeq;

	public ExErpSendiCUBEVO ( List<Map<String, Object>> data ) {
		this.originData = data;
		this.dataList = new ArrayList<>( );
		//this.length = 0;
		this.index = -1;
		this.data = null;
		//this.isEmpty = true;
		for ( Map<String, Object> item : data ) {
			dataList.add( new aData( item ) );
			this.isEmpty = false;
			this.compSeq = item.get( "comp_seq" ).toString( );
			this.expendSeq = item.get( "expend_seq" ).toString( );
		}
		//this.length = dataList.size( );

		if( dataList.size() > 0 ) {
			this.length = dataList.size( );
		}else {
			this.length = 0;
			this.isEmpty = true;
		}
	}

	public List<Map<String, Object>> getOriginData ( ) {
		return this.originData;
	}

	public String getCompSeq ( ) {
		if ( !this.isEmpty ) {
			return this.compSeq;
		}
		return commonCode.EMPTYSTR;
	}

	public void initIndex ( ) {
		this.index = -1;
	}

	public String getExpendSeq ( ) {
		if ( !this.isEmpty ) {
			return this.expendSeq;
		}
		return commonCode.EMPTYSTR;
	}

	public boolean isEmpty ( ) {
		return this.isEmpty;
	}

	public int NextData ( ) {
		this.index++;
		if ( index >= this.length ) {
			return -1;
		}
		this.data = this.dataList.get( this.index );
		return index;
	}

	public class aData {

		private final String ISS_NO;
		private final String TRCD_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - A 타입 */
		private final String TRNM_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - B 타입 */
		private final String DEPTCD_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - C 타입 */
		private final String PJTCD_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - D 타입 */
		private final String CTNB_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - E 타입 */
		private final String FRDT_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - F 타입 */
		private final String TODT_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - G 타입 */
		private final String QT_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - H 타입 */
		private final String AM_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - I 타입 */
		private final String RT_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - J 타입 */
		private final String DEAL_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - K 타입 */
		private final String USER1_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - L - 사용자 정의 */
		private final String USER2_TY; /* 각 계정과목의 관리항목 설정에 따라 입력, 관리항목타입이 없는 경우에 타읍은 '0'으로 합니다. - M - 사용자 정의 */
		private final String TR_CD; /* A 타입 코드 / 부가세 계정인 경우 거래처코드 필수 입력 */
		private final String TR_NM; /* B 타입 명칭 / 부가세 계정인 경우 거래처명 필수 입력 */
		private final String CT_DEPT; /* C 타입 코드 */
		private final String DEPT_NM; /* C 타입 명칭 */
		private final String PJT_CD; /* D 타입 코드 / 부가세 계정인 경우 부가세사업장코드 필수 입력 */
		private final String PJT_NM; /* D 타입 명칭 / 부가세 계정인 경우 부가세사업장명 필수 입력 */
		private final String CT_NB; /* E 타입 코드 */
		private final String FR_DT; /* F 타입 코드 / 부가세 계정인 경우 > 세금계산서인 경우 세금계산서 발행일 필수 입력 */
		private final String TO_DT; /* G 타입 코드 */
		private final String CT_QT; /* H 타입 코드 */
		private final String CT_AM;
		private final String CT_RT;
		private final String CT_DEAL;
		private final String DEAL_NM;
		private final String CT_USER1;
		private final String USER1_NM;
		private final String CT_USER2;
		private final String USER2_NM;
		private final String EXCH_TY; /* 부가세 계정 수출인경우에만 입력 - 외화종류 */
		private final String EXCH_AM; /* 부가세 계정 수출인경우에만 입력 - 외화금액 */
		private final String PAYMENT; /* 받음어음계정이 파변인 경우에만 입력 - 지급은행지점명 */
		private final String ISU_NM;
		private final String ENDORS_NM;
		private final String BILL_FG1;
		private final String BILL_FG2;
		private final String DUMMY1;
		private final String DUMMY2;
		private final String DUMMY3;
		private final String INSERT_DT;
		private final String EX_FG;
		private final String TR_NMK;
		private final String DEPT_NMK;
		private final String PJT_NMK;
		private final String DEAL_NMK;
		private final String USER1_NMK;
		private final String USER2_NMK;
		private final String RMK_DCK;
		private final String ISU_DOC;
		private final String ISU_DOCK;
		private final String PRS_FG;
		private final String JEONJA_YN; /* 부가세 계정 입력 - 전자세금계산서 여부 / 0 : 부, 1 : 여 */
		private final String PAYMENT_PT;
		private final String DEAL_FG;
		private final String IN_DT;
		private final String CO_CD;
		private final String IN_DIV_CD;
		private final String LOGIC_CD;
		private final String ACCT_CD;
		private final String DRCR_FG;
		private final String ACCT_AM;
		private final String RMK_NB;
		private final String RMK_DC;
		private final String ATTR_CD;
		private String etax_yn;
		@SuppressWarnings ( "unused" )
		private String etax_send_yn;
		public String expendSeq;
		public String slipSeq;
		public String mngSeq;
		public String listSeq;
		public String expendDate;
		private final Map<String, Object> map;

		aData ( Map<String, Object> item ) {
			map = item;
			InitField( );
			this.expendSeq = item.get( "expend_seq" ).toString( );
			this.slipSeq = item.get( "slip_seq" ).toString( );
			this.mngSeq = item.get( "mng_seq" ).toString( );
			this.listSeq = item.get( "list_seq" ).toString( );
			this.expendDate = item.get( "expend_date" ).toString( );
			this.IN_DT = IN_DT( );
			this.CO_CD = CO_CD( );
			this.IN_DIV_CD = IN_DIV_CD( );
			this.LOGIC_CD = LOGIC_CD( );
			this.ACCT_CD = ACCT_CD( );
			this.DRCR_FG = DRCR_FG( );
			this.ACCT_AM = ACCT_AM( );
			this.RMK_NB = RMK_NB( );
			this.RMK_DC = RMK_DC( );
			this.ATTR_CD = ATTR_CD( );
			this.TRCD_TY = TRCD_TY( );
			this.TRNM_TY = TRNM_TY( );
			this.DEPTCD_TY = DEPTCD_TY( );
			this.PJTCD_TY = PJTCD_TY( );
			this.CTNB_TY = CTNB_TY( );
			this.FRDT_TY = FRDT_TY( );
			this.TODT_TY = TODT_TY( );
			this.QT_TY = QT_TY( );
			this.AM_TY = AM_TY( );
			this.RT_TY = RT_TY( );
			this.DEAL_TY = DEAL_TY( );
			this.USER1_TY = USER1_TY( );
			this.USER2_TY = USER2_TY( );
			this.TR_CD = TR_CD( );
			this.TR_NM = TR_NM( );
			this.CT_DEPT = CT_DEPT( );
			this.DEPT_NM = DEPT_NM( );
			this.PJT_CD = PJT_CD( );
			this.PJT_NM = PJT_NM( );
			this.CT_NB = CT_NB( );
			this.FR_DT = FR_DT( );
			this.TO_DT = TO_DT( );
			this.CT_QT = CT_QT( );
			this.CT_AM = CT_AM( );
			this.CT_RT = CT_RT( );
			this.CT_DEAL = CT_DEAL( );
			this.DEAL_NM = DEAL_NM( );
			this.CT_USER1 = CT_USER1( );
			this.USER1_NM = USER1_NM( );
			this.CT_USER2 = CT_USER2( );
			this.USER2_NM = USER2_NM( );
			this.EXCH_TY = EXCH_TY( );
			this.EXCH_AM = EXCH_AM( );
			this.PAYMENT = PAYMENT( );
			this.ISU_NM = ISU_NM( );
			this.ENDORS_NM = ENDORS_NM( );
			this.BILL_FG1 = BILL_FG1( );
			this.BILL_FG2 = BILL_FG2( );
			this.DUMMY1 = DUMMY1( );
			this.DUMMY2 = DUMMY2( );
			this.DUMMY3 = DUMMY3( );
			this.INSERT_DT = INSERT_DT( );
			this.EX_FG = EX_FG( );
			this.TR_NMK = TR_NMK( );
			this.DEPT_NMK = DEPT_NMK( );
			this.PJT_NMK = PJT_NMK( );
			this.DEAL_NMK = DEAL_NMK( );
			this.USER1_NMK = USER1_NMK( );
			this.USER2_NMK = USER2_NMK( );
			this.RMK_DCK = RMK_DCK( );
			this.ISU_DOC = ISU_DOC( );
			this.ISU_DOCK = ISU_DOCK( );
			this.PRS_FG = PRS_FG( );
			this.JEONJA_YN = JEONJA_YN( );
			this.PAYMENT_PT = PAYMENT_PT( );
			this.DEAL_FG = DEAL_FG( );
			this.ISS_NO = ISS_NO( );
		}

		public Map<String, Object> getMap ( ) {
			Map<String, Object> result = new HashMap<String, Object>( );
			result.put( commonCode.EXPENDSEQ, expendSeq );
			result.put( commonCode.SLIPSEQ, slipSeq );
			result.put( "expendDate", expendDate );
			result.put( commonCode.MNGSEQ, mngSeq );
			result.put( commonCode.LISTSEQ, listSeq );
			result.put( "IN_DT", IN_DT );
			result.put( "CO_CD", CO_CD );
			result.put( "IN_DIV_CD", IN_DIV_CD );
			result.put( "LOGIC_CD", LOGIC_CD );
			result.put( "ACCT_CD", ACCT_CD );
			result.put( "DRCR_FG", DRCR_FG );
			result.put( "ACCT_AM", ACCT_AM );
			result.put( "RMK_NB", RMK_NB );
			result.put( "RMK_DC", RMK_DC );
			result.put( "ATTR_CD", ATTR_CD );
			result.put( "TRCD_TY", TRCD_TY );
			result.put( "TRNM_TY", TRNM_TY );
			result.put( "DEPTCD_TY", DEPTCD_TY );
			result.put( "PJTCD_TY", PJTCD_TY );
			result.put( "CTNB_TY", CTNB_TY );
			result.put( "FRDT_TY", FRDT_TY );
			result.put( "TODT_TY", TODT_TY );
			result.put( "QT_TY", QT_TY );
			result.put( "AM_TY", AM_TY );
			result.put( "RT_TY", RT_TY );
			result.put( "DEAL_TY", DEAL_TY );
			result.put( "USER1_TY", USER1_TY );
			result.put( "USER2_TY", USER2_TY );
			result.put( "TR_CD", TR_CD );
			result.put( "TR_NM", TR_NM );
			result.put( "CT_DEPT", CT_DEPT );
			result.put( "DEPT_NM", DEPT_NM );
			result.put( "PJT_CD", PJT_CD );
			result.put( "PJT_NM", PJT_NM );
			result.put( "CT_NB", CT_NB );
			result.put( "FR_DT", FR_DT );
			result.put( "TO_DT", TO_DT );
			result.put( "CT_QT", CT_QT );
			result.put( "CT_AM", CT_AM );
			result.put( "CT_RT", CT_RT );
			result.put( "CT_DEAL", CT_DEAL );
			result.put( "DEAL_NM", DEAL_NM );
			result.put( "CT_USER1", CT_USER1 );
			result.put( "USER1_NM", USER1_NM );
			result.put( "CT_USER2", CT_USER2 );
			result.put( "USER2_NM", USER2_NM );
			result.put( "EXCH_TY", EXCH_TY );
			result.put( "EXCH_AM", EXCH_AM );
			result.put( "PAYMENT", PAYMENT );
			result.put( "ISU_NM", ISU_NM );
			result.put( "ENDORS_NM", ENDORS_NM );
			result.put( "BILL_FG1", BILL_FG1 );
			result.put( "BILL_FG2", BILL_FG2 );
			result.put( "DUMMY1", DUMMY1 );
			result.put( "DUMMY2", DUMMY2 );
			result.put( "DUMMY3", DUMMY3 );
			result.put( "INSERT_DT", INSERT_DT );
			result.put( "EX_FG", EX_FG );
			result.put( "TR_NMK", TR_NMK );
			result.put( "DEPT_NMK", DEPT_NMK );
			result.put( "PJT_NMK", PJT_NMK );
			result.put( "DEAL_NMK", DEAL_NMK );
			result.put( "USER1_NMK", USER1_NMK );
			result.put( "USER2_NMK", USER2_NMK );
			result.put( "RMK_DCK", RMK_DCK );
			result.put( "ISU_DOC", ISU_DOC );
			result.put( "ISU_DOCK", ISU_DOCK );
			result.put( "PRS_FG", PRS_FG );
			result.put( "JEONJA_YN", JEONJA_YN );
			result.put( "PAYMENT_PT", PAYMENT_PT );
			result.put( "DEAL_FG", DEAL_FG );
			result.put( "ISS_NO", ISS_NO );
			return result;
		}

		String ISS_NO ( ) {
			return this.iss_no;
		}

		String DEAL_FG ( ) {
			return commonCode.EMPTYSTR;
		}

		String PAYMENT_PT ( ) {
			return commonCode.EMPTYSTR;
		}

		String JEONJA_YN ( ) {
			/*
			 * iCUBE 전용
			 * 아래의 부가세 유형인 경우 전자세금계산서 여부 기본 "여" 로 설정.
			 * 아래 부가세들은 계산서와 관련된 부가세이므로 기본값을 "여"로 설정해준다.
			 * 작성일 : 2017. 05. 08
			 * 작성자 : 신재호
			 * 21 : 과세메입
			 * 22 : 영세매입
			 * 23 : 면세매입
			 * 24 : 매입불공제
			 * 25 : 수입
			 */
			if ( interface_type.equals( "etax" ) ) {
				return "1";
			}
			//			else if ( auth_vat_type_code.equals( "21" ) || auth_vat_type_code.equals( "22" ) || auth_vat_type_code.equals( "23" ) || auth_vat_type_code.equals( "24" ) || auth_vat_type_code.equals( "25" ) ) {
			//				return "1";
			//			}
			else if ( etax_yn.equals( commonCode.EMPTYYES ) ) {
				return "1";
			}
			else {
				return commonCode.EMPTYSEQ;
			}
		}

		String PRS_FG ( ) {
			return commonCode.EMPTYSTR;
		}

		String ISU_DOCK ( ) {
			return commonCode.EMPTYSTR;
		}

		String ISU_DOC ( ) {
			String noteOptionValue = CommonConvert.CommonGetStr(note_option_value);
			String isuDoc = "[" + doc_no.replaceAll( "'", "''" ) + "] " + doc_title.replaceAll( "'", "''" );

			//전표입력 화면의 품의내역 설정을 사용하는 경우(적요 설정 옵션)
			if(!(noteOptionValue.equals("") || noteOptionValue.equals("NONAME"))) {
				//문서번호
				if(noteOptionValue.indexOf("DOCNO") > -1) {
					noteOptionValue = noteOptionValue.replace("DOCNO", doc_no);
				}
				//문서제목
				if(noteOptionValue.indexOf("TITLE") > -1) {
					noteOptionValue = noteOptionValue.replace("TITLE", doc_title);
				}
				//양식명
				if(noteOptionValue.indexOf("FORMNM") > -1) {
					noteOptionValue = noteOptionValue.replace("FORMNM", form_nm);
				}

				isuDoc = noteOptionValue;
			}

			if ( isuDoc.length( ) > 100 ) {
				isuDoc = isuDoc.substring( 0, 100 );
			}

			return isuDoc;
		}

		String RMK_DCK ( ) {
			return commonCode.EMPTYSTR;
		}

		String USER2_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String USER1_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String DEAL_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String PJT_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String DEPT_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String TR_NMK ( ) {
			return commonCode.EMPTYSTR;
		}

		String EX_FG ( ) {
			return commonCode.EMPTYSEQ;
		}

		String INSERT_DT ( ) {
			return commonCode.EMPTYSTR;
		}

		String DUMMY3 ( ) {
			return commonCode.EMPTYSTR;
		}

		String DUMMY2 ( ) {
			return commonCode.EMPTYSTR;
		}

		String DUMMY1 ( ) {
			return commonCode.EMPTYSTR;
		}

		String BILL_FG2 ( ) {
			return commonCode.EMPTYSTR;
		}

		String BILL_FG1 ( ) {
			return commonCode.EMPTYSTR;
		}

		String ENDORS_NM ( ) {
			return commonCode.EMPTYSTR;
		}

		String ISU_NM ( ) {
			return commonCode.EMPTYSTR;
		}

		String PAYMENT ( ) {
			return commonCode.EMPTYSTR;
		}

		String EXCH_AM ( ) {
			return commonCode.EMPTYSEQ;
		}

		String EXCH_TY ( ) {
			return commonCode.EMPTYSTR;
		}

		String USER2_NM ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				/* return commonCode.EMPTYSTR; */
				return m_c_name;
			}
			else {
				return m_c_name;
			}
		}

		String CT_USER2 ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				/* return commonCode.EMPTYSTR; */
				return m_code;
			}
			else {
				return m_code;
			}
		}

		String USER1_NM ( ) {
			//  임헌용 보증 [2016-12-27 19:34]
			if ( drcr_gbn.equals( "VAT" ) && auth_vat_type_code.equals( "24" ) ) {
				return auth_va_type_name;
			}
			else if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSTR;
			}
			else {
				return l_c_name;
			}
		}

		String CT_USER1 ( ) {
			//  임헌용 보증 [2016-12-27 19:34]
			if ( drcr_gbn.equals( "VAT" ) ) {
				if ( (auth_vat_type_code.equals( "23" ) || auth_vat_type_code.equals( "24" ) || auth_vat_type_code.equals( "26" )) ) {
					return auth_va_type_code;
				}
				else {
					/* 사유구분이 입력되어야 하는 케이스 판단하여, 사유구분 예외처리 필요 */
					return "";
				}
			}
			else {
				return l_code;
			}
		}

		String DEAL_NM ( ) { // k_nm
			if ( drcr_gbn.equals( "VAT" ) ) {
				if ( k_c_name != null && !k_c_name.equals( commonCode.EMPTYSTR ) ) {
					return k_c_name;
				}
				return auth_vat_type_name;
			}
			else {
				return k_c_name;
			}
		}

		String CT_DEAL ( ) { // k_code
			if ( drcr_gbn.equals( "VAT" ) ) {
				if ( k_code != null && !k_code.equals( commonCode.EMPTYSTR ) ) {
					return k_code;
				}
				return auth_vat_type_code;
			}
			else {
				return k_code;
			}
		}

		String CT_RT ( ) { // j_cd
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return j_code;
			}
		}

		String CT_AM ( ) { // i_cd
			if ( drcr_gbn.equals( "VAT" ) ) {
				return sub_std_amt;
			}
			else {
				return i_code;
			}
		}

		String CT_QT ( ) {
			// 신재호 보증[2016-12-27 18:02]
			if ( drcr_gbn.equals( "VAT" ) && (auth_vat_type_code.equals( "24" )) ) {
				return this.sub_tax_amt;
			}
			else if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return h_code;
			}
		}

		String TO_DT ( ) { // g-cd
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSTR;
			}
			else {
				return g_code;
			}
		}

		String FR_DT ( ) { // f-cd
			if ( drcr_gbn.equals( "VAT" ) ) {
				return auth_date;
			}
			else {
				if (adv_expend_req_dt.equals("")) {
					return f_code;
				} else {
					if (f_ty.equals("F3")) {
						return adv_expend_req_dt;
					} else {
						return f_code;
					}
				}
			}
		}

		String CT_NB ( ) {
			if ( CommonConvert.CommonGetStr(drcr_gbn.toUpperCase( )).equals( "VAT" ) ) {
				/* 부가세인 경우 */
				/* 세무구분값이 카드 매입인 경우 카드코드 반환 */
				if ( auth_vat_type_code.equals( "27" ) ) {
					return map.get( "card_card_code" ).toString( );
				}
				/* 세무구분값이 현금영수증매입인 경우 현금영수증번호 반환 */
				else if ( auth_vat_type_code.equals( "28" ) ) {
					return e_code;
				}
				else {
					return commonCode.EMPTYSTR;
				}
			}
			else {
				/* 부가세가 아닌 경우 */
				return e_code;
			}
		}

		String PJT_NM ( ) { // d_nm
			if ( drcr_gbn.equals( "VAT" ) && interface_type.equals("etax") ) {
				return emp_erp_biz_name;
			}else if( drcr_gbn.equals( "VAT" ) && this.d_ty.equals("D5") && !interface_type.equals("etax")) {
			    return d_c_name;
			}else if(drcr_gbn.equals("VAT")) {
			    return emp_erp_biz_name;
			}
			else {
				return d_c_name;
			}
		}

		String PJT_CD ( ) { // d_cd
			if( drcr_gbn.equals( "VAT" ) && interface_type.equals("etax")) {
			  return emp_erp_biz_seq; 
    		}else if( drcr_gbn.equals( "VAT" ) && this.d_ty.equals("D5") && !interface_type.equals("etax")) {
    		  return d_code;
    		}else if( drcr_gbn.equals("VAT")) {
    		  return emp_erp_biz_seq;
    		}
    		else {
				return d_code;
			}
		}

		String DEPT_NM ( ) { // C_nm
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSTR;
			}
			else {
				return c_c_name;
			}
		}

		String CT_DEPT ( ) { // C_CD
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSTR;
			}
			else {
				return c_code;
			}
		}

		String TR_NM ( ) { // B_NM
			if ( drcr_gbn.equals( "VAT" ) ) {
				if ( this.b_ty.equals( "B1" ) ) {
					if ( !this.b_c_name.equals( "" ) ) {
						return cutPartnerName(b_c_name);
					}
				}
				return cutPartnerName(this.partner_partner_name);
			}
			else {
				return cutPartnerName(b_c_name);
			}
		}

		private String cutPartnerName(String name) {

			int iCubePartnerNameLength = 60;

			/**
			 * 거래처 글자수 제한만큼 자르기 ( UBA-13691 )
			 * 아이큐브는 거래처명을 60글자 크기 이기 때문에 소스상에서 60글자
			 * 만큼 자른다.
			 */
			if(name != null && name.length() > iCubePartnerNameLength) {
				name = name.substring(0, iCubePartnerNameLength - 1);
			}
			return name;
		}

		String TR_CD ( ) { // A_CD
			if ( drcr_gbn.equals( "VAT" ) ) {
				if ( this.a_ty.equals( "A1" ) ) {
					if ( !this.a_code.equals( "" ) ) {
						return a_code;
					}
				}
				return this.partner_partner_code;
			}
			else {
				return a_code;
			}
		}

		String USER2_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				/* return commonCode.EMPTYSEQ; */
				return m_ty;
			}
			else {
				return m_ty;
			}
		}

		String USER1_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				/* return commonCode.EMPTYSEQ; */
				return l_ty;
			}
			else {
				return l_ty;
			}
		}

		String DEAL_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "K1";
			}
			else {
				return k_ty;
			}
		}

		String RT_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return j_ty;
			}
		}

		String AM_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "I3";
			}
			else {
				return i_ty;
			}
		}

		String QT_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) && (auth_vat_type_code.equals( "24" )) ) {
				return "H3";
			}
			else if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return h_ty;
			}
		}

		String TODT_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return g_ty;
			}
		}

		String FRDT_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "F1";
			}
			else {
				return f_ty;
			}
		}

		String CTNB_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "EA";
			}
			else {
				return e_ty;
			}
		}

		String PJTCD_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "D5";
			}
			else {
				return d_ty;
			}
		}

		String DEPTCD_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return c_ty;
			}
		}

		String TRNM_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "B1";
			}
			else {
				return b_ty;
			}
		}

		String TRCD_TY ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "A1";
			}
			else {
				return a_ty;
			}
		}

		String ATTR_CD ( ) {
			if(auth_erp_auth_code.equals( "" )){
				return summary_erp_auth_code;
			}else{
				return auth_erp_auth_code;
			}
		}

		String RMK_DC ( ) {
			if ( note.length( ) > 80 ) {
				note = note.substring( 0, 80 );
			}
			return note;
		}

		String RMK_NB ( ) {
			return commonCode.EMPTYSEQ;
		}

		String ACCT_AM ( ) {
			if ( drcr_gbn.equals( "VAT" ) && (auth_vat_type_code.equals( "24" )) ) {
				return commonCode.EMPTYSEQ;
			}
			else {
				return amt;
			}
		}

		String DRCR_FG ( ) {
			if ( drcr_gbn.equals( "CR" ) ) {
				return "4";
			}
			else if ( drcr_gbn.equals( "DR" ) || drcr_gbn.equals( "VAT" ) ) {
				return "3";
			}
			//System.out.println( "대차 구분 미존재" );
			return commonCode.EMPTYSTR;
		}

		String ACCT_CD ( ) {
			return acct_code;
		}

		String LOGIC_CD ( ) {
			return "21";
		}

		String IN_DIV_CD ( ) {
			return writer_erp_biz_seq;
		}

		String CO_CD ( ) {
			return writer_erp_comp_seq;
		}

		String IN_DT ( ) {
			if ( !budget_use_yn.equals( "N" ) ) {
				return this.expendDate;
			}
			else {
				return adv_expend_dt;
			}
		}

		String getMapData ( Map<String, Object> map, String key ) {
			Object temp = map.get( key );
			return (temp == null) ? commonCode.EMPTYSTR : temp.toString( );
		}

		String writer_erp_comp_seq;
		String writer_erp_biz_seq;
		String acct_code;
		String drcr_gbn;
		String amt;
		String sub_tax_amt;
		String auth_vat_type_code;
		String note;
		String note_option_value;
		String auth_erp_auth_code;
		String summary_erp_auth_code;
		String ctd_code;
		String ctd_name;
		String partner_partner_code;
		String auth_va_type_code;
		String auth_va_type_name;
		String doc_title;
		String doc_no;
		String form_nm;
		String interface_type;
		String a_ty;
		String a_name;
		String b_ty;
		String b_name;
		String c_ty;
		String c_name;
		String d_ty;
		String d_name;
		String e_ty;
		String e_name;
		String f_ty;
		String f_name;
		String g_ty;
		String g_name;
		String h_ty;
		String h_name;
		String i_ty;
		String i_name;
		String j_ty;
		String j_name;
		String k_ty;
		String k_name;
		String l_ty;
		String l_name;
		String m_ty;
		String m_name;
		String a_code;
		String a_c_name;
		String b_code;
		String b_c_name;
		String c_code;
		String c_c_name;
		String d_code;
		String d_c_name;
		String e_code;
		String e_c_name;
		String f_code;
		String f_c_name;
		String g_code;
		String g_c_name;
		String h_code;
		String h_c_name;
		String i_code;
		String i_c_name;
		String j_code;
		String j_c_name;
		String k_code;
		String k_c_name;
		String l_code;
		String l_c_name;
		String m_code;
		String m_c_name;
		String iss_no;
		String auth_vat_type_name;
		String partner_partner_name;
		String emp_erp_biz_seq;
		String emp_erp_biz_name;
		String auth_date;
		String sub_std_amt;
		String budget_use_yn;
		String adv_expend_dt;
		String adv_expend_req_dt;

		int InitField ( ) {
			if ( map.get( "adv_expend_dt" ) == null ) {
				budget_use_yn = commonCode.EMPTYSEQ;
				//System.out.println( "Reference null...adv_expend_dt" );
			}
			else {
				adv_expend_dt = map.get( "adv_expend_dt" ).toString( );
			}
			if ( map.get( "adv_expend_req_dt" ) == null ) {
				adv_expend_req_dt = commonCode.EMPTYSTR;
			}
			else {
				adv_expend_req_dt = map.get( "adv_expend_req_dt" ).toString( );
			}
			if ( map.get( "budget_use_yn" ) == null ) {
				budget_use_yn = "N";
				//System.out.println( "Reference null...budget_use_yn" );
			}
			else {
				budget_use_yn = map.get( "budget_use_yn" ).toString( );
			}
			if ( map.get( "sub_std_amt" ) == null ) {
				sub_std_amt = commonCode.EMPTYSEQ;
				//System.out.println( "Reference null...sub_std_amt" );
			}
			else {
				sub_std_amt = map.get( "sub_std_amt" ).toString( );
			}
			if ( map.get( "auth_date" ) == null ) {
				auth_date = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_date" );
			}
			else {
				auth_date = map.get( "auth_date" ).toString( );
			}
			if ( map.get( "emp_erp_biz_name" ) == null ) {
				emp_erp_biz_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...emp_erp_biz_name" );
			}
			else {
				emp_erp_biz_name = map.get( "emp_erp_biz_name" ).toString( );
			}
			if ( map.get( "emp_erp_biz_seq" ) == null ) {
				emp_erp_biz_seq = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...emp_erp_biz_seq" );
			}
			else {
				emp_erp_biz_seq = map.get( "emp_erp_biz_seq" ).toString( );
			}
			if ( map.get( "partner_partner_name" ) == null ) {
				partner_partner_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...partner_partner_name" );
			}
			else {
				partner_partner_name = map.get( "partner_partner_name" ).toString( );
			}
			if ( map.get( "auth_vat_type_name" ) == null ) {
				auth_vat_type_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_vat_type_name" );
			}
			else {
				auth_vat_type_name = map.get( "auth_vat_type_name" ).toString( );
			}
			if ( map.get( "iss_no" ) == null ) {
				iss_no = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...iss_no" );
			}
			else {
				iss_no = map.get( "iss_no" ).toString( );
			}
			if ( map.get( "a_code" ) == null ) {
				a_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...a_code" );
			}
			else {
				a_code = map.get( "a_code" ).toString( );
			}
			if ( map.get( "a_c_name" ) == null ) {
				a_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...a_c_name" );
			}
			else {
				a_c_name = map.get( "a_c_name" ).toString( );
			}
			if ( map.get( "b_code" ) == null ) {
				b_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...b_code" );
			}
			else {
				b_code = map.get( "b_code" ).toString( );
			}
			if ( map.get( "b_c_name" ) == null ) {
				b_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...b_c_name" );
			}
			else {
				b_c_name = map.get( "b_c_name" ).toString( );
			}
			if ( map.get( "c_code" ) == null ) {
				c_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...c_code" );
			}
			else {
				c_code = map.get( "c_code" ).toString( );
			}
			if ( map.get( "c_c_name" ) == null ) {
				c_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...c_c_name" );
			}
			else {
				c_c_name = map.get( "c_c_name" ).toString( );
			}
			if ( map.get( "d_code" ) == null ) {
				d_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...d_code" );
			}
			else {
				d_code = map.get( "d_code" ).toString( );
			}
			if ( map.get( "d_c_name" ) == null ) {
				d_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...d_c_name" );
			}
			else {
				d_c_name = map.get( "d_c_name" ).toString( );
			}
			if ( map.get( "e_code" ) == null ) {
				e_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...e_code" );
			}
			else {
				e_code = map.get( "e_code" ).toString( );
			}
			if ( map.get( "e_c_name" ) == null ) {
				e_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...e_c_name" );
			}
			else {
				e_c_name = map.get( "e_c_name" ).toString( );
			}
			if ( map.get( "f_code" ) == null ) {
				f_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...f_code" );
			}
			else {
				f_code = map.get( "f_code" ).toString( );
			}
			if ( map.get( "f_c_name" ) == null ) {
				f_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...f_c_name" );
			}
			else {
				f_c_name = map.get( "f_c_name" ).toString( );
			}
			if ( map.get( "g_code" ) == null ) {
				g_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...g_code" );
			}
			else {
				g_code = map.get( "g_code" ).toString( );
			}
			if ( map.get( "g_c_name" ) == null ) {
				g_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...g_c_name" );
			}
			else {
				g_c_name = map.get( "g_c_name" ).toString( );
			}
			if ( map.get( "h_code" ) == null || CommonConvert.CommonGetStr(map.get( "h_code" )).equals( commonCode.EMPTYSTR ) ) {
				h_code = commonCode.EMPTYSEQ;
				//System.out.println( "Reference null...h_code" );
			}
			else {
				h_code = map.get( "h_code" ).toString( );
			}
			if ( map.get( "h_c_name" ) == null ) {
				h_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...h_c_name" );
			}
			else {
				h_c_name = map.get( "h_c_name" ).toString( );
			}
			if ( map.get( "i_code" ) == null || CommonConvert.CommonGetStr(map.get( "i_code" )).equals( commonCode.EMPTYSTR ) ) {
				i_code = commonCode.EMPTYSEQ;
				//System.out.println( "Reference null...i_code" );
			}
			else {
				i_code = map.get( "i_code" ).toString( );
			}
			if ( map.get( "i_c_name" ) == null ) {
				i_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...i_c_name" );
			}
			else {
				i_c_name = map.get( "i_c_name" ).toString( );
			}
			if ( map.get( "j_code" ) == null || CommonConvert.CommonGetStr(map.get( "j_code" )).equals( commonCode.EMPTYSTR ) ) {
				j_code = commonCode.EMPTYSEQ;
				//System.out.println( "Reference null...j_code" );
			}
			else {
				j_code = map.get( "j_code" ).toString( );
			}
			if ( map.get( "j_c_name" ) == null ) {
				j_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...j_c_name" );
			}
			else {
				j_c_name = map.get( "j_c_name" ).toString( );
			}
			if ( map.get( "k_code" ) == null ) {
				k_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...k_code" );
			}
			else {
				k_code = map.get( "k_code" ).toString( );
			}
			if ( map.get( "k_c_name" ) == null ) {
				k_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...k_c_name" );
			}
			else {
				k_c_name = map.get( "k_c_name" ).toString( );
			}
			if ( map.get( "l_code" ) == null ) {
				l_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...l_code" );
			}
			else {
				l_code = map.get( "l_code" ).toString( );
			}
			if ( map.get( "l_c_name" ) == null ) {
				l_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...l_c_name" );
			}
			else {
				l_c_name = map.get( "l_c_name" ).toString( );
			}
			if ( map.get( "m_code" ) == null ) {
				m_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...m_code" );
			}
			else {
				m_code = map.get( "m_code" ).toString( );
			}
			if ( map.get( "m_c_name" ) == null ) {
				m_c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...m_c_name" );
			}
			else {
				m_c_name = map.get( "m_c_name" ).toString( );
			}
			if ( map.get( "a_ty" ) == null ) {
				a_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...a_ty" );
			}
			else {
				a_ty = map.get( "a_ty" ).toString( );
			}
			if ( map.get( "a_name" ) == null ) {
				a_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...a_name" );
			}
			else {
				a_name = map.get( "a_name" ).toString( );
			}
			if ( map.get( "b_ty" ) == null ) {
				b_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...b_ty" );
			}
			else {
				b_ty = map.get( "b_ty" ).toString( );
			}
			if ( map.get( "b_name" ) == null ) {
				b_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...b_name" );
			}
			else {
				b_name = map.get( "b_name" ).toString( );
			}
			if ( map.get( "c_ty" ) == null ) {
				c_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...c_ty" );
			}
			else {
				c_ty = map.get( "c_ty" ).toString( );
			}
			if ( map.get( "c_name" ) == null ) {
				c_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...c_name" );
			}
			else {
				c_name = map.get( "c_name" ).toString( );
			}
			if ( map.get( "d_ty" ) == null ) {
				d_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...d_ty" );
			}
			else {
				d_ty = map.get( "d_ty" ).toString( );
			}
			if ( map.get( "d_name" ) == null ) {
				d_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...d_name" );
			}
			else {
				d_name = map.get( "d_name" ).toString( );
			}
			if ( map.get( "e_ty" ) == null ) {
				e_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...e_ty" );
			}
			else {
				e_ty = map.get( "e_ty" ).toString( );
			}
			if ( map.get( "e_name" ) == null ) {
				e_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...e_name" );
			}
			else {
				e_name = map.get( "e_name" ).toString( );
			}
			if ( map.get( "f_ty" ) == null ) {
				f_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...f_ty" );
			}
			else {
				f_ty = map.get( "f_ty" ).toString( );
			}
			if ( map.get( "f_name" ) == null ) {
				f_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...f_name" );
			}
			else {
				f_name = map.get( "f_name" ).toString( );
			}
			if ( map.get( "g_ty" ) == null ) {
				g_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...g_ty" );
			}
			else {
				g_ty = map.get( "g_ty" ).toString( );
			}
			if ( map.get( "g_name" ) == null ) {
				g_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...g_name" );
			}
			else {
				g_name = map.get( "g_name" ).toString( );
			}
			if ( map.get( "h_ty" ) == null ) {
				h_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...h_ty" );
			}
			else {
				h_ty = map.get( "h_ty" ).toString( );
			}
			if ( map.get( "h_name" ) == null ) {
				h_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...h_name" );
			}
			else {
				h_name = map.get( "h_name" ).toString( );
			}
			if ( map.get( "i_ty" ) == null ) {
				i_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...i_ty" );
			}
			else {
				i_ty = map.get( "i_ty" ).toString( );
			}
			if ( map.get( "i_name" ) == null ) {
				i_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...i_name" );
			}
			else {
				i_name = map.get( "i_name" ).toString( );
			}
			if ( map.get( "j_ty" ) == null ) {
				j_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...j_ty" );
			}
			else {
				j_ty = map.get( "j_ty" ).toString( );
			}
			if ( map.get( "j_name" ) == null ) {
				j_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...j_name" );
			}
			else {
				j_name = map.get( "j_name" ).toString( );
			}
			if ( map.get( "k_ty" ) == null ) {
				k_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...k_ty" );
			}
			else {
				k_ty = map.get( "k_ty" ).toString( );
			}
			if ( map.get( "k_name" ) == null ) {
				k_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...k_name" );
			}
			else {
				k_name = map.get( "k_name" ).toString( );
			}
			if ( map.get( "l_ty" ) == null ) {
				l_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...l_ty" );
			}
			else {
				l_ty = map.get( "l_ty" ).toString( );
			}
			if ( map.get( "l_name" ) == null ) {
				l_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...l_name" );
			}
			else {
				l_name = map.get( "l_name" ).toString( );
			}
			if ( map.get( "m_ty" ) == null ) {
				m_ty = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...m_ty" );
			}
			else {
				m_ty = map.get( "m_ty" ).toString( );
			}
			if ( map.get( "m_name" ) == null ) {
				m_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...m_name" );
			}
			else {
				m_name = map.get( "m_name" ).toString( );
			}
			if ( map.get( "interface_type" ) == null ) {
				interface_type = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...interface_type" );
			}
			else {
				interface_type = map.get( "interface_type" ).toString( );
			}
			if ( map.get( "doc_title" ) == null ) {
				doc_title = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...doc_title" );
			}
			else {
				doc_title = map.get( "doc_title" ).toString( );
			}
			if ( map.get( "doc_no" ) == null ) {
				doc_no = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...doc_no" );
			}
			else {
				doc_no = map.get( "doc_no" ).toString( );
			}
			if ( map.get( "form_nm" ) == null ) {
				form_nm = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...form_nm" );
			}
			else {
				form_nm = map.get( "form_nm" ).toString( );
			}
			if ( map.get( "auth_va_type_code" ) == null ) {
				auth_va_type_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_va_type_code" );
			}
			else {
				auth_va_type_code = map.get( "auth_va_type_code" ).toString( );
			}
			if ( map.get( "auth_va_type_name" ) == null ) {
				auth_va_type_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_va_type_name" );
			}
			else {
				auth_va_type_name = map.get( "auth_va_type_name" ).toString( );
			}
			if ( map.get( "partner_partner_code" ) == null ) {
				partner_partner_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...partner_partner_code" );
			}
			else {
				partner_partner_code = map.get( "partner_partner_code" ).toString( );
			}
			if ( map.get( "ctd_name" ) == null ) {
				ctd_name = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...ctd_name" );
			}
			else {
				ctd_name = map.get( "ctd_name" ).toString( );
			}
			if ( map.get( "ctd_code" ) == null ) {
				ctd_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...ctd_code" );
			}
			else {
				ctd_code = map.get( "ctd_code" ).toString( );
			}
			if ( map.get( "auth_erp_auth_code" ) == null ) {
				auth_erp_auth_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_erp_auth_code" );
			}
			else {
				auth_erp_auth_code = map.get( "auth_erp_auth_code" ).toString( );
			}
			if ( map.get( "summary_erp_auth_code" ) == null ) {
				summary_erp_auth_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...summary_erp_auth_code" );
			}
			else {
				summary_erp_auth_code = map.get( "summary_erp_auth_code" ).toString( );
			}
			if ( map.get( "note" ) == null ) {
				note = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...note" );
			}
			else {
				note = map.get( "note" ).toString( );
			}
			if ( map.get( "note_option_value" ) == null ) {
				note_option_value = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...note_option_value" );
			}
			else {
				note_option_value = map.get( "note_option_value" ).toString( );
			}
			if ( map.get( "auth_vat_type_code" ) == null ) {
				auth_vat_type_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...auth_vat_type_code" );
			}
			else {
				auth_vat_type_code = map.get( "auth_vat_type_code" ).toString( );
			}
			if ( map.get( "sub_tax_amt" ) == null ) {
				sub_tax_amt = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...sub_tax_amt" );
			}
			else {
				sub_tax_amt = map.get( "sub_tax_amt" ).toString( );
			}
			if ( map.get( "amt" ) == null ) {
				amt = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...amt" );
			}
			else {
				amt = map.get( "amt" ).toString( );
			}
			if ( map.get( "drcr_gbn" ) == null ) {
				drcr_gbn = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...drcr_gbn" );
			}
			else {
				drcr_gbn = map.get( "drcr_gbn" ).toString( ).toUpperCase( );
			}
			if ( map.get( "writer_erp_comp_seq" ) == null ) {
				writer_erp_comp_seq = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...writer_erp_comp_seq" );
			}
			else {
				writer_erp_comp_seq = map.get( "writer_erp_comp_seq" ).toString( );
			}
			if ( map.get( "writer_erp_biz_seq" ) == null ) {
				writer_erp_biz_seq = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...writer_erp_biz_seq" );
			}
			else {
				writer_erp_biz_seq = map.get( "writer_erp_biz_seq" ).toString( );
			}
			if ( map.get( "acct_code" ) == null ) {
				acct_code = commonCode.EMPTYSTR;
				//System.out.println( "Reference null...acct_code" );
			}
			else {
				acct_code = map.get( "acct_code" ).toString( );
			}
			if ( map.get( "etax_yn" ) == null ) {
				etax_yn = commonCode.EMPTYNO;
			}
			else {
				etax_yn = map.get( "etax_yn" ).toString( );
			}
			if ( map.get( "etax_send_yn" ) == null ) {
				etax_send_yn = commonCode.EMPTYNO;
			}
			else {
				etax_send_yn = map.get( "etax_send_yn" ).toString( );
			}
			return 0;
		}
	}
}
