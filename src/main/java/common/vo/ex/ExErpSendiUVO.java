package common.vo.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExErpSendiUVO {

	private final List<Map<String, Object>> originData;
	private final ArrayList<aData> dataList;
	private int length;
	private int index;
	private boolean isEmpty;
	public aData data;
	private String compSeq;
	private String expendSeq;
	private String listSeq;
	private boolean isVatChange;
	private String vatCode;

	public ExErpSendiUVO ( List<Map<String, Object>> data ) {
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
			/* 관리항목에서 세무구분 변경시 동일 항목의 분개정보 수정 */
			if ( CommonConvert.CommonGetStr(item.get( "cd_mng1" )).equals( "C14" )
					&& !CommonConvert.CommonGetStr(item.get( "cd_mngd1" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd1" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng2" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd2" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd2" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng3" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd3" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd3" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng4" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd4" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd4" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng5" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd5" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd5" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng6" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd6" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd6" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng7" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd7" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd7" ).toString( );
			}
			else if ( CommonConvert.CommonGetStr(item.get( "cd_mng8" )).equals( "C14" ) && !CommonConvert.CommonGetStr(item.get( "cd_mngd8" )).equals( CommonConvert.CommonGetStr(item.get( "auth_vat_type_code" )) ) ) {
				listSeq = item.get( "list_seq" ).toString( );
				isVatChange = true;
				vatCode = item.get( "cd_mngd8" ).toString( );
			}
		}
		if ( isVatChange ) {
			for ( aData tData : dataList ) {
				if ( expendSeq.equals( tData.expend_seq ) && listSeq.equals( tData.list_seq ) ) {
					tData.TP_TAX = vatCode;
				}
			}
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

	public String getExpendDate ( ) {
		if ( !this.isEmpty ) {
			return this.dataList.get( 0 ).DT_ACCT;
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

	public String getListSeq() {
		if(!this.isEmpty){
			return this.listSeq;
		}

		return commonCode.EMPTYSTR;
	}

	public void setListSeq(String listSeq) {
		this.listSeq = listSeq;
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

		//		private String ROW_ID;	// key 정보는 impl단에서 신규 생성 됨.
		//		private String ROW_NO;
		//		private String CD_COMPANY;
		//		private String NO_DOLINE;
		//		private String NO_DOCU;
		//		private String CD_COMPANY;
		private final String NO_TAX;
		@SuppressWarnings("unused")
		private final String CD_PC;

		/* 회계단위 전송 변경 - 2018.06.20.김상겸. */
		/* 회계단위는 사용자가 선택한 회계단위가 전송되도록 처리 ( t_ex_expend.emp_seq 에 연결된 사용자 정보의 회계단위로 고정 전송 ) */
		private final String ORG_ERP_PC_CD;
		@SuppressWarnings("unused")
		private final String ORG_ERP_PC_NAME;

		private final String CD_WDEPT;
		@SuppressWarnings ( "unused" )
		private String NO_DOCU;
		@SuppressWarnings ( "unused" )
		private String NO_DOLINE;
		private final String ID_WRITE;
		private final String CD_DOCU;
		private final String DT_ACCT;
		private final String ST_DOCU;
		private final String TP_DRCR;
		private final String CD_ACCT;
		private final String AMT;
		private final String CD_PARTNER;
		private final String DT_START;
		private final String DT_END;
		private final String AM_TAXSTD;
		private final String AM_ADDTAX;
		public String TP_TAX;
		private final String NO_COMPANY;
		private final String NM_NOTE;
		private final String CD_BIZAREA;
		private final String CD_DEPT;
		private final String CD_CC;
		private final String CD_PJT;
		private final String CD_FUND;
		private final String CD_BUDGET;
		private final String NO_CASH;
		private final String ST_MUTUAL;
		private final String CD_CARD;
		private final String NO_DEPOSIT;
		private final String CD_BANK;
		private final String UCD_MNG1;
		private final String UCD_MNG2;
		private final String UCD_MNG3;
		private final String UCD_MNG4;
		private final String UCD_MNG5;
		private final String CD_EMPLOY;
		private final String CD_MNG;
		private final String NO_BDOCU;
		private final String NO_BDOLINE;
		private final String TP_DOCU;
		private final String NO_ACCT;
		private final String TP_TRADE;
		private final String CD_EXCH;
		private final String RT_EXCH;
		private final String CD_TRADE;
		private final String NO_CHECK2;
		private final String NO_CHECK3;
		private final String NO_CHECK4;
		private final String TP_CROSS;
		private final String ERP_CD;
		private final String AM_EX;
		private final String NO_TO;
		private final String DT_SHIPPING;
		private final String TP_GUBUN;
		private final String NO_INVOICE;
		private final String NO_ITEM;
		private final String MD_TAX1;
		private final String NM_ITEM1;
		private final String NM_SIZE1;
		private final String QT_TAX1;
		private final String AM_PRC1;
		private final String AM_SUPPLY1;
		private final String AM_TAX1;
		private final String NM_NOTE1;
		private final String CD_BIZPLAN;
		private final String CD_BGACCT;
		private final String CD_MNGD1;
		private final String NM_MNGD1;
		private final String CD_MNGD2;
		private final String NM_MNGD2;
		private final String CD_MNGD3;
		private final String NM_MNGD3;
		private final String CD_MNGD4;
		private final String NM_MNGD4;
		private final String CD_MNGD5;
		private final String NM_MNGD5;
		private final String CD_MNGD6;
		private final String NM_MNGD6;
		private final String CD_MNGD7;
		private final String NM_MNGD7;
		private final String CD_MNGD8;
		private final String NM_MNGD8;
		private final String YN_ISS;
		private final String TP_BILL;
		private final String ST_TAX;
		private final String MD_TAX2;
		private final String NM_ITEM2;
		private final String NM_SIZE2;
		private final String QT_TAX2;
		private final String AM_PRC2;
		private final String AM_SUPPLY2;
		private final String AM_TAX2;
		private final String NM_NOTE2;
		private final String MD_TAX3;
		private final String NM_ITEM3;
		private final String NM_SIZE3;
		private final String QT_TAX3;
		private final String AM_PRC3;
		private final String AM_SUPPLY3;
		private final String AM_TAX3;
		private final String NM_NOTE3;
		private final String MD_TAX4;
		private final String NM_ITEM4;
		private final String NM_SIZE4;
		private final String QT_TAX4;
		private final String AM_PRC4;
		private final String AM_SUPPLY4;
		private final String AM_TAX4;
		private final String NM_NOTE4;
		private final String FINAL_STATUS;
		private final String NO_BILL;
		private final String NO_ISS;
		private final String NO_ASSET;
		private final String TP_RECORD;
		private final String TP_ETCACCT;
		private final String SELL_DAM_NM;
		private final String SELL_DAM_EMAIL;
		private final String SELL_DAM_MOBIL;
		private final String ST_GWARE;
		private final String NM_PUMM;
		private final String JEONJASEND15_YN;
		private final String DT_WRITE;
		private final String NM_PTR;
		private final String EX_HP;
		private final String EX_EMIL;
		private final String NM_PARTNER;
		private String ETAX_YN;
		private String ETAX_SEND_YN;
		/* 접대비 부표 */
		private final String FEE_SEQ;
		//@SuppressWarnings ( "unused" )
		//private String FEE_CD_COMPANY = "";
		private final String FEE_CD_PC;
		private final String FEE_CD_ACCT;
		private final String FEE_CD_DEPT;
		private final String FEE_CD_EMP;
		private final String FEE_DT_START;
		private final String FEE_TP_RECEPT;
		private final String FEE_RECEPT_GU;
		private final String FEE_CD_CARD;
		private final String FEE_NO_COMPANY;
		private final String FEE_NM_CEO;
		private final String FEE_NO_RES;
		private final String FEE_NO_RES1;
		private final String FEE_NM_CEO1;
		private final String FEE_NO_COMPANY1;
		private final String FEE_NM_ADRESS;
		private final String FEE_USE_AREA;
		private final String FEE_USE_COST;
		private final String FEE_AM_MATIRIAL;
		private final String FEE_AM_SERVICE;
		private final String FEE_NM_NOTE;
		private final String FEE_RECEPT_GU10;
		private final String FEE_NM_NOTE1;
		private final String FEE_ST_DOCU;
		private final String FEE_CD_PARTNER;
		private final String FEE_CD_PARTNER1;
		private final String FEE_NM_RECEPT;
		private final String FEE_NM_RECEPT1;
		private final String FEE_TP_RECEPTION;
		private final String FEE_TP_COMPANY;

		private final String CD_BIZCAR;
		private final String TP_EVIDENCE; //ERP 증빙

		private final Map<String, Object> map;

		aData ( Map<String, Object> item ) {
			
			map = item;
			InitField( );
			this.NO_TAX = NO_TAX( );
			this.CD_PC = CD_PC( );

			this.ORG_ERP_PC_CD = ORG_ERP_PC_CD();
			this.ORG_ERP_PC_NAME = ORG_ERP_PC_NAME();

			this.CD_WDEPT = CD_WDEPT( );
			this.ID_WRITE = ID_WRITE( );
			this.CD_DOCU = CD_DOCU( );
			this.DT_ACCT = DT_ACCT( );
			this.ST_DOCU = ST_DOCU( );
			this.TP_DRCR = TP_DRCR( );
			this.CD_ACCT = CD_ACCT( );
			this.AMT = AMT( );
			this.CD_PARTNER = CD_PARTNER( );
			this.DT_START = DT_START( );
			this.DT_END = DT_END( );
			this.AM_TAXSTD = AM_TAXSTD( );
			this.AM_ADDTAX = AM_ADDTAX( );
			this.TP_TAX = TP_TAX( );
			this.NO_COMPANY = NO_COMPANY( );
			this.NM_NOTE = NM_NOTE( );
			this.CD_BIZAREA = CD_BIZAREA( );
			this.CD_DEPT = CD_DEPT( );
			this.CD_CC = CD_CC( );
			this.CD_PJT = CD_PJT( );
			this.CD_FUND = CD_FUND( );
			this.CD_BUDGET = CD_BUDGET( );
			this.NO_CASH = NO_CASH( );
			this.ST_MUTUAL = ST_MUTUAL( );
			this.CD_CARD = CD_CARD( );
			this.NO_DEPOSIT = NO_DEPOSIT( );
			this.CD_BANK = CD_BANK( );
			this.UCD_MNG1 = UCD_MNG1( );
			this.UCD_MNG2 = UCD_MNG2( );
			this.UCD_MNG3 = UCD_MNG3( );
			this.UCD_MNG4 = UCD_MNG4( );
			this.UCD_MNG5 = UCD_MNG5( );
			this.CD_EMPLOY = CD_EMPLOY( );
			this.CD_MNG = CD_MNG( );
			this.NO_BDOCU = NO_BDOCU( );
			this.NO_BDOLINE = NO_BDOLINE( );
			this.TP_DOCU = TP_DOCU( );
			this.NO_ACCT = NO_ACCT( );
			this.TP_TRADE = TP_TRADE( );
			this.CD_EXCH = CD_EXCH( );
			this.RT_EXCH = RT_EXCH( );
			this.CD_TRADE = CD_TRADE( );
			this.NO_CHECK2 = NO_CHECK2( );
			this.NO_CHECK3 = NO_CHECK3( );
			this.NO_CHECK4 = NO_CHECK4( );
			this.TP_CROSS = TP_CROSS( );
			this.ERP_CD = ERP_CD( );
			this.AM_EX = AM_EX( );
			this.NO_TO = NO_TO( );
			this.DT_SHIPPING = DT_SHIPPING( );
			this.TP_GUBUN = TP_GUBUN( );
			this.NO_INVOICE = NO_INVOICE( );
			this.NO_ITEM = NO_ITEM( );
			this.MD_TAX1 = MD_TAX1( );
			this.NM_ITEM1 = NM_ITEM1( );
			this.NM_SIZE1 = NM_SIZE1( );
			this.QT_TAX1 = QT_TAX1( );
			this.AM_PRC1 = AM_PRC1( );
			this.AM_SUPPLY1 = AM_SUPPLY1( );
			this.AM_TAX1 = AM_TAX1( );
			this.NM_NOTE1 = NM_NOTE1( );
			this.CD_BIZPLAN = CD_BIZPLAN( );
			this.CD_BGACCT = CD_BGACCT( );
			this.CD_MNGD1 = CD_MNGD1( );
			this.NM_MNGD1 = NM_MNGD1( );
			this.CD_MNGD2 = CD_MNGD2( );
			this.NM_MNGD2 = NM_MNGD2( );
			this.CD_MNGD3 = CD_MNGD3( );
			this.NM_MNGD3 = NM_MNGD3( );
			this.CD_MNGD4 = CD_MNGD4( );
			this.NM_MNGD4 = NM_MNGD4( );
			this.CD_MNGD5 = CD_MNGD5( );
			this.NM_MNGD5 = NM_MNGD5( );
			this.CD_MNGD6 = CD_MNGD6( );
			this.NM_MNGD6 = NM_MNGD6( );
			this.CD_MNGD7 = CD_MNGD7( );
			this.NM_MNGD7 = NM_MNGD7( );
			this.CD_MNGD8 = CD_MNGD8( );
			this.NM_MNGD8 = NM_MNGD8( );
			this.YN_ISS = YN_ISS( );
			this.TP_BILL = TP_BILL( );
			this.ST_TAX = ST_TAX( );
			this.MD_TAX2 = MD_TAX2( );
			this.NM_ITEM2 = NM_ITEM2( );
			this.NM_SIZE2 = NM_SIZE2( );
			this.QT_TAX2 = QT_TAX2( );
			this.AM_PRC2 = AM_PRC2( );
			this.AM_SUPPLY2 = AM_SUPPLY2( );
			this.AM_TAX2 = AM_TAX2( );
			this.NM_NOTE2 = NM_NOTE2( );
			this.MD_TAX3 = MD_TAX3( );
			this.NM_ITEM3 = NM_ITEM3( );
			this.NM_SIZE3 = NM_SIZE3( );
			this.QT_TAX3 = QT_TAX3( );
			this.AM_PRC3 = AM_PRC3( );
			this.AM_SUPPLY3 = AM_SUPPLY3( );
			this.AM_TAX3 = AM_TAX3( );
			this.NM_NOTE3 = NM_NOTE3( );
			this.MD_TAX4 = MD_TAX4( );
			this.NM_ITEM4 = NM_ITEM4( );
			this.NM_SIZE4 = NM_SIZE4( );
			this.QT_TAX4 = QT_TAX4( );
			this.AM_PRC4 = AM_PRC4( );
			this.AM_SUPPLY4 = AM_SUPPLY4( );
			this.AM_TAX4 = AM_TAX4( );
			this.NM_NOTE4 = NM_NOTE4( );
			this.FINAL_STATUS = FINAL_STATUS( );
			this.NO_BILL = NO_BILL( );
			this.NO_ISS = NO_ISS();
			this.NO_ASSET = NO_ASSET( );
			this.TP_RECORD = TP_RECORD( );
			this.TP_ETCACCT = TP_ETCACCT( );
			this.SELL_DAM_NM = SELL_DAM_NM( );
			this.SELL_DAM_EMAIL = SELL_DAM_EMAIL( );
			this.SELL_DAM_MOBIL = SELL_DAM_MOBIL( );
			this.ST_GWARE = ST_GWARE( );
			this.NM_PUMM = NM_PUMM( );
			this.JEONJASEND15_YN = JEONJASEND15_YN( );
			this.DT_WRITE = DT_WRITE( );
			this.NM_PTR = NM_PTR( );
			this.EX_HP = EX_HP( );
			this.EX_EMIL = EX_EMIL( );
			this.NM_PARTNER = NM_PARTNER( );
			/* 접대비 부표 생성 */
			this.FEE_SEQ = FEE_SEQ( );
			this.FEE_CD_PC = ORG_ERP_PC_CD(); /* CD_PC( ); */
			this.FEE_CD_ACCT = CD_ACCT( );
			this.FEE_CD_DEPT = CD_DEPT( );
			this.FEE_CD_EMP = CD_EMPLOY( );
			this.FEE_DT_START = FEE_DT_START( );
			this.FEE_TP_RECEPT = FEE_TP_RECEPT( );
			this.FEE_RECEPT_GU = FEE_RECEPT_GU( );
			this.FEE_CD_CARD = FEE_CD_CARD( );
			this.FEE_NO_COMPANY = FEE_NO_COMPANY( );
			this.FEE_NM_CEO = FEE_NM_CEO( );
			this.FEE_NO_RES = FEE_NO_RES( );
			this.FEE_NO_RES1 = FEE_NO_RES1( );
			this.FEE_NM_CEO1 = FEE_NM_CEO1( );
			this.FEE_NO_COMPANY1 = FEE_NO_COMPANY1( );
			this.FEE_NM_ADRESS = FEE_NM_ADRESS( );
			this.FEE_USE_AREA = FEE_USE_AREA( );
			this.FEE_USE_COST = FEE_USE_COST( );
			this.FEE_AM_MATIRIAL = FEE_AM_MATIRIAL( );
			this.FEE_AM_SERVICE = FEE_AM_SERVICE( );
			this.FEE_NM_NOTE = FEE_NM_NOTE( );
			this.FEE_RECEPT_GU10 = FEE_RECEPT_GU10( );
			this.FEE_NM_NOTE1 = FEE_NM_NOTE1( );
			this.FEE_ST_DOCU = FEE_ST_DOCU( );
			this.FEE_CD_PARTNER = FEE_CD_PARTNER( );
			this.FEE_CD_PARTNER1 = FEE_CD_PARTNER1( );
			this.FEE_NM_RECEPT = FEE_NM_RECEPT( );
			this.FEE_NM_RECEPT1 = FEE_NM_RECEPT1( );
			this.FEE_TP_RECEPTION = FEE_TP_RECEPTION( );
			this.FEE_TP_COMPANY = FEE_TP_COMPANY( );
			//this.ORG_ERP_PC_CD = ORG_ERP_PC_CD();
			//this.ORG_ERP_PC_NAME = ORG_ERP_PC_NAME();
			this.CD_BIZCAR = CD_BIZCAR();
			this.TP_EVIDENCE = TP_EVIDENCE();
		}

		String getCode ( String type, String defaultValue ) {
			if ( CommonConvert.CommonGetStr(this.cd_mng1).toUpperCase( ).equals( type ) ) {
				return cd_mngd1;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng2).toUpperCase( ).equals( type ) ) {
				return cd_mngd2;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng3).toUpperCase( ).equals( type ) ) {
				return cd_mngd3;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng4).toUpperCase( ).equals( type ) ) {
				return cd_mngd4;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng5).toUpperCase( ).equals( type ) ) {
				return cd_mngd5;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng6).toUpperCase( ).equals( type ) ) {
				return cd_mngd6;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng7).toUpperCase( ).equals( type ) ) {
				return cd_mngd7;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng8).toUpperCase( ).equals( type ) ) {
				return cd_mngd8;
			}
			else {
				return defaultValue;
			}
		}

		String getCode ( String[] type, String defaultValue ) {
			for ( int i = 0; i < type.length; i++ ) {
				String item = type[i];
				if ( CommonConvert.CommonGetStr(this.cd_mng1).toUpperCase( ).equals( item ) ) {
					return cd_mngd1;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng2).toUpperCase( ).equals( item ) ) {
					return cd_mngd2;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng3).toUpperCase( ).equals( item ) ) {
					return cd_mngd3;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng4).toUpperCase( ).equals( item ) ) {
					return cd_mngd4;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng5).toUpperCase( ).equals( item ) ) {
					return cd_mngd5;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng6).toUpperCase( ).equals( item ) ) {
					return cd_mngd6;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng7).toUpperCase( ).equals( item ) ) {
					return cd_mngd7;
				}
				else if ( CommonConvert.CommonGetStr(this.cd_mng8).toUpperCase( ).equals( item ) ) {
					return cd_mngd8;
				}
			}
			return defaultValue;
		}

		String getName ( String type, String defaultValue ) {
			if ( CommonConvert.CommonGetStr(this.cd_mng1).toUpperCase( ).equals( type ) ) {
				return nm_mngd1;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng2).toUpperCase( ).equals( type ) ) {
				return nm_mngd2;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng3).toUpperCase( ).equals( type ) ) {
				return nm_mngd3;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng4).toUpperCase( ).equals( type ) ) {
				return nm_mngd4;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng5).toUpperCase( ).equals( type ) ) {
				return nm_mngd5;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng6).toUpperCase( ).equals( type ) ) {
				return nm_mngd6;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng7).toUpperCase( ).equals( type ) ) {
				return nm_mngd7;
			}
			else if ( CommonConvert.CommonGetStr(this.cd_mng8).toUpperCase( ).equals( type ) ) {
				return nm_mngd8;
			}
			else {
				return defaultValue;
			}
		}

		String NO_TAX ( ) {
			if ( drcr_gbn.equals( "VAT" ) ) {
				return "";
				// return auth_vat_type_code;
			}
			else {
				return "*";
			}
		}

		String CD_PC ( ) {
			// return this.writer_erp_pc_seq;
			return ORG_ERP_PC_CD();
		}

		String ORG_ERP_PC_CD (){
			return this.org_erp_pc_cd;
		}

		String ORG_ERP_PC_NAME (){
			return this.org_erp_pc_name;
		}

		String CD_WDEPT ( ) {
			return this.writer_erp_dept_seq;
		}

		String ID_WRITE ( ) {
			return this.writer_erp_emp_seq;
		}

		String CD_DOCU ( ) {
			return "13";
		}

		String DT_ACCT ( ) {
			if ( !budget_use_yn.equals( "N" ) ) {
				return this.expend_date;
			}
			else {
				return adv_expend_dt;
			}
		}

		String ST_DOCU ( ) {
			return "1";
		}

		String TP_DRCR ( ) {
			if ( drcr_gbn.equals( "CR" ) ) {
				return "2";
			}
			else if ( drcr_gbn.equals( "DR" ) ) {
				return "1";
			}
			else if ( drcr_gbn.equals( "VAT" ) ) {
				return "1";
			}
			else {
				//System.out.println( "차대구분 확인 불가 : " + this.drcr_gbn );
				return "";
			}
		}

		String CD_ACCT ( ) {
			return this.acct_code;
		}

		String AMT ( ) {
			return this.amt;
		}

		String CD_PARTNER ( ) {
			return this.getCode( "A06", this.partner_partner_code );
		}

		String DT_START ( ) {
			// B21의 코드 값은 빈 값으로 처리되었기 때문에 코드 명에서 읽어옴
			return this.getName( "B21", this.expend_date );
		}

		String DT_END ( ) {
			String[] types = { "B22", "B23" };
			if (this.adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.getCode( types, this.expend_req_date );
			} else {
				return this.getCode(types, this.adv_expend_req_dt);
			}
		}

		String AM_TAXSTD ( ) {
			// C05의 코드 값은 빈 값으로 처리되었기 때문에 코드 명에서 읽어옴
			String result = this.getName( "C05", this.sub_std_amt );
			if ( result == null || result.equals( "" ) ) {
				result = this.sub_std_amt;
			}
			return result;
		}

		String AM_ADDTAX ( ) {
			// C16의 코드 값은 빈 값으로 처리되었기 때문에 코드 명에서 읽어옴
			String result = this.getName( "C16", this.sub_tax_amt );
			if ( result == null || result.equals( "" ) ) {
				result = this.sub_tax_amt;
			}
			return result;
		}

		String TP_TAX ( ) {
			return this.getCode( "C14", this.auth_vat_type_code );
		}

		String NO_COMPANY ( ) {
			return this.getCode( "C01", this.partner_partner_no );
		}

		String NM_NOTE ( ) {
			String slipNoteOptionValue = CommonConvert.CommonGetStr(slip_note_option_value);
			String nmNote = "";

			if (!(slipNoteOptionValue.equals(""))) {
				// 전표입력 화면의 차대변적요 설정을 사용하는 경우(적요 설정 옵션)
				if (slipNoteOptionValue.indexOf("NOTE") > -1) {
					slipNoteOptionValue = slipNoteOptionValue.replace("NOTE", note);
				}

				if (slipNoteOptionValue.indexOf("DOCNO") > -1) {
					slipNoteOptionValue = slipNoteOptionValue.replace("DOCNO", doc_no);
				}

				nmNote = slipNoteOptionValue;
			} else {
				nmNote = note;
			}

			if ( nmNote.length( ) > 100 ) {
				nmNote = nmNote.substring( 0, 100 );
			}

			return nmNote;
		}

		String CD_BIZAREA ( ) {
			if ( interface_type.equals( "etax" ) ) {
				return bizCd;
			}
			else {
				return this.getCode( "A01", this.emp_erp_biz_seq );
			}
		}

		String CD_DEPT ( ) {
			return this.getCode( "A03", this.emp_erp_dept_seq );
		}

		String CD_CC ( ) {
			return this.getCode( "A02", this.emp_erp_cc_seq );
		}

		String CD_PJT ( ) {
			return this.getCode( "A05", this.project_project_code );
		}

		String CD_FUND ( ) {
			return "";
		}

		String CD_BUDGET ( ) {
			return this.budget_budget_code;
		}

		String NO_CASH ( ) {
			return this.getCode( "C18", this.auth_no_cash );
		}

		String ST_MUTUAL ( ) {
			return this.getCode( "C18", this.auth_no_tax_code );
		}

		String CD_CARD ( ) {
			if ( CommonConvert.CommonGetStr(this.auth_vat_type_code).equals( "24" ) || CommonConvert.CommonGetStr(this.auth_vat_type_code).equals( "39" ) ) {
				if ( this.getCode( "A08", CommonConvert.CommonGetStr(this.card_card_code) ).equals( "" ) ) {
					return "";
				}
				return this.getCode( "A08", this.card_card_num );
			}
			else {
				return this.getCode( "A08", this.card_card_num );
			}
		}

		String NO_DEPOSIT ( ) {
			return this.getCode( "A07", "" );
		}

		String CD_BANK ( ) {
			return this.getCode( "A09", this.card_partner_code );
		}

		String UCD_MNG1 ( ) {
			return this.getCode( "A21", "" );
		}

		String UCD_MNG2 ( ) {
			return this.getCode( "A22", "" );
		}

		String UCD_MNG3 ( ) {
			return this.getCode( "A23", "" );
		}

		String UCD_MNG4 ( ) {
			return this.getCode( "A24", "" );
		}

		String UCD_MNG5 ( ) {
			return this.getCode( "A25", "" );
		}

		String CD_EMPLOY ( ) {
			return this.getCode( "A04", this.emp_erp_emp_seq );
		}

		String CD_MNG ( ) {
			return "";
		}

		String NO_BDOCU ( ) {
			return "";
		}

		String NO_BDOLINE ( ) {
			return "0";
		}

		String TP_DOCU ( ) {
			return "N";
		}

		String NO_ACCT ( ) {
			return "0";
		}

		String TP_TRADE ( ) {
			return this.getCode( "B12", "" );
		}

		String CD_EXCH ( ) {
			return this.getCode( "B24", "" );
		}

		String RT_EXCH ( ) {
			String result = this.getCode( "B25", "0" );
			if( result.equals( "" )){
				result = "0";
			}
			return result;
		}

		String CD_TRADE ( ) {
			return "";
		}

		String NO_CHECK2 ( ) {
			return "";
		}

		String NO_CHECK3 ( ) {
			return "";
		}

		String NO_CHECK4 ( ) {
			return "";
		}

		String TP_CROSS ( ) {
			return "";
		}

		String ERP_CD ( ) {
			return "";
		}

		String AM_EX ( ) {
			String result = this.getCode( "B26", "0" );
			if(result.equals( "" )){
				result = "0";
			}
			return result;
		}

		String NO_TO ( ) {
			return "";
		}

		String DT_SHIPPING ( ) {
			return "";
		}

		String TP_GUBUN ( ) {
			return "3";
		}

		String NO_INVOICE ( ) {
			return "";
		}

		String NO_ITEM ( ) {
			return "";
		}

		String MD_TAX1 ( ) {
			if ( auth_date.length( ) > 7 ) {
				return this.auth_date.substring( 4 );
			}
			else {
				return "";
			}
		}

		String NM_ITEM1 ( ) {
			return "";
		}

		String NM_SIZE1 ( ) {
			return "";
		}

		String QT_TAX1 ( ) {
			return "0";
		}

		String AM_PRC1 ( ) {
			return "0";
		}

		String AM_SUPPLY1 ( ) {
			return this.sub_std_amt;
		}

		String AM_TAX1 ( ) {
			return this.sub_tax_amt;
		}

		String NM_NOTE1 ( ) {
			return "";
		}

		String CD_BIZPLAN ( ) {
			if ( this.budget_bizplan_code.equals( "" ) ) {
				return "***";
			}
			return this.budget_bizplan_code;
		}

		String CD_BGACCT ( ) {
			return this.budget_bgacct_code;
		}

		String CD_MNGD1 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd1;
			} else {
				if (cd_mng1.equals("B22") || cd_mng1.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd1;
				}
			}
		}

		String NM_MNGD1 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd1;
			} else {
				if (cd_mng1.equals("B22") || cd_mng1.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd1;
				}
			}
		}

		String CD_MNGD2 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd2;
			} else {
				if (cd_mng2.equals("B22") || cd_mng2.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd2;
				}
			}
		}

		String NM_MNGD2 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd2;
			} else {
				if (cd_mng2.equals("B22") || cd_mng2.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd2;
				}
			}
		}

		String CD_MNGD3 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd3;
			} else {
				if (cd_mng3.equals("B22") || cd_mng3.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd3;
				}
			}
		}

		String NM_MNGD3 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd3;
			} else {
				if (cd_mng3.equals("B22") || cd_mng3.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd3;
				}
			}
		}

		String CD_MNGD4 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd4;
			} else {
				if (cd_mng4.equals("B22") || cd_mng4.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd4;
				}
			}
		}

		String NM_MNGD4 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd4;
			} else {
				if (cd_mng4.equals("B22") || cd_mng4.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd4;
				}
			}
		}

		String CD_MNGD5 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd5;
			} else {
				if (cd_mng5.equals("B22") || cd_mng5.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd5;
				}
			}
		}

		String NM_MNGD5 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd5;
			} else {
				if (cd_mng5.equals("B22") || cd_mng5.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd5;
				}
			}
		}

		String CD_MNGD6 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd6;
			} else {
				if (cd_mng6.equals("B22") || cd_mng6.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd6;
				}
			}
		}

		String NM_MNGD6 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd6;
			} else {
				if (cd_mng6.equals("B22") || cd_mng6.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd6;
				}
			}
		}

		String CD_MNGD7 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd7;
			} else {
				if (cd_mng7.equals("B22") || cd_mng7.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd7;
				}
			}
		}

		String NM_MNGD7 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd7;
			} else {
				if (cd_mng7.equals("B22") || cd_mng7.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd7;
				}
			}
		}

		String CD_MNGD8 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.cd_mngd8;
			} else {
				if (cd_mng8.equals("B22") || cd_mng8.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.cd_mngd8;
				}
			}
		}

		String NM_MNGD8 ( ) {
			if (adv_expend_req_dt.equals(commonCode.EMPTYSTR)) {
				return this.nm_mngd8;
			} else {
				if (cd_mng8.equals("B22") || cd_mng8.equals("B23")) {
					return adv_expend_req_dt;
				} else {
					return this.nm_mngd8;
				}
			}
		}

		String CD_BIZCAR() {
			return this.cd_bizcar;
		}

		String YN_ISS ( ) {
			// 전자세금계산서 발행여부 / 종이 : 0, 전자 : 2
			/*
			 * ERPiU 전용
			 * 아래의 부가세 유형인 경우 전자세금계산서 여부 기본 "여" 로 설정.
			 * 아래 부가세들은 계산서와 관련된 부가세이므로 기본값을 "여"로 설정해준다.
			 * 작성일 : 2017. 05. 08
			 * 작성자 : 신재호
			 * 21 과세(세금계산서)
			 * 22 불공(세금계산서)
			 * 23 영세(세금계산서)
			 * 26 면세(계산서)
			 * 27 의제(계산서 2/102)
			 * 29 의제(계산서 3/103)
			 * 32 의제(계산서 5/105)
			 * 38 수입(세금계산서)
			 * 40 의제(계산서 6/106)
			 * 43 매입자발행세금계산서
			 * 44 재활용(계산서 6/106)
			 * 46 재활용(계산서 10/110)
			 * 48 의제(계산서 8/108)
			 * 51 의제(계산서 4/104)
			 * 54 재활용(계산서 9/109)
			 * 65 재활용(계산서 3/103)
			 */
			if ( this.interface_type.toUpperCase( ).equals( "ETAX" ) ) {
				return "2";
			}
			//			else if ( this.auth_vat_type_code.equals( "21" ) || this.auth_vat_type_code.equals( "22" ) || this.auth_vat_type_code.equals( "23" ) || this.auth_vat_type_code.equals( "26" ) || this.auth_vat_type_code.equals( "27" ) || this.auth_vat_type_code.equals( "29" ) || this.auth_vat_type_code.equals( "32" ) || this.auth_vat_type_code.equals( "38" ) || this.auth_vat_type_code.equals( "40" ) || this.auth_vat_type_code.equals( "43" ) || this.auth_vat_type_code.equals( "44" ) || this.auth_vat_type_code.equals( "46" ) || this.auth_vat_type_code.equals( "48" ) || this.auth_vat_type_code.equals( "51" ) || this.auth_vat_type_code.equals( "54" ) || this.auth_vat_type_code.equals( "65" ) ) {
			//				return "2";
			//			}
			else if ( ETAX_YN.equals( commonCode.EMPTYYES ) ) {
				return "2";
			}
			return "0";
		}

		String TP_BILL ( ) {
			// 어음종류 / 어음 : 1,  가계 수표 : 2, 당좌수표 3
			return "";
		}

		String ST_TAX ( ) {
			// 영수, 청구 / 청구 : 1, 영수 : 2
			return "";
		}

		String MD_TAX2 ( ) {
			return "";
		}

		String NM_ITEM2 ( ) {
			return "";
		}

		String NM_SIZE2 ( ) {
			return "";
		}

		String QT_TAX2 ( ) {
			return "0";
		}

		String AM_PRC2 ( ) {
			return "0";
		}

		String AM_SUPPLY2 ( ) {
			return "0";
		}

		String AM_TAX2 ( ) {
			return "0";
		}

		String NM_NOTE2 ( ) {
			return "";
		}

		String MD_TAX3 ( ) {
			return "";
		}

		String NM_ITEM3 ( ) {
			return "";
		}

		String NM_SIZE3 ( ) {
			return "";
		}

		String QT_TAX3 ( ) {
			return "0";
		}

		String AM_PRC3 ( ) {
			return "0";
		}

		String AM_SUPPLY3 ( ) {
			return "0";
		}

		String AM_TAX3 ( ) {
			return "0";
		}

		String NM_NOTE3 ( ) {
			return "";
		}

		String MD_TAX4 ( ) {
			return "";
		}

		String NM_ITEM4 ( ) {
			return "";
		}

		String NM_SIZE4 ( ) {
			return "";
		}

		String QT_TAX4 ( ) {
			return "0";
		}

		String AM_PRC4 ( ) {
			return "0";
		}

		String AM_SUPPLY4 ( ) {
			return "0";
		}

		String AM_TAX4 ( ) {
			return "0";
		}

		String NM_NOTE4 ( ) {
			return "";
		}

		String FINAL_STATUS ( ) {
			return "";
		}

		String NO_BILL ( ) {
			if ( this.interface_type.toUpperCase( ).equals( "ETAX" ) ) {
				return iss_no;
			}
			return "";
		}
		
		String NO_ISS ( ) {
			if ( this.interface_type.toUpperCase( ).equals( "ETAX" ) ) {
				return no_iss;
			}
			return "";
		}

		String NO_ASSET ( ) {
			return "";
		}

		String TP_RECORD ( ) {
			return "";
		}

		String TP_ETCACCT ( ) {
			// 타계정대체
			return this.getCode( "B27", "" );
		}

		String SELL_DAM_NM ( ) {
			return "";
		}

		String SELL_DAM_EMAIL ( ) {
			return "";
		}

		String SELL_DAM_MOBIL ( ) {
			return "";
		}

		String ST_GWARE ( ) {
			return "";
		}

		String NM_PUMM ( ) {
			String noteOptionValue = CommonConvert.CommonGetStr(note_option_value);
			String nmPumm = "";

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

				nmPumm = noteOptionValue;
			}

			if ( nmPumm.length( ) > 100 ) {
				nmPumm = nmPumm.substring( 0, 100 );
			}

			return nmPumm;
		}

		String JEONJASEND15_YN ( ) {
			// 국세청 전송 15일 이내 체크 미체크 여부 , 0체크 / 1 미체크
			/*
			 * ERPiU 전용
			 * 아래의 부가세 유형인 경우 전자세금계산서 여부 기본 "여" 로 설정.
			 * 아래 부가세들은 계산서와 관련된 부가세이므로 기본값을 "여"로 설정해준다.
			 * 작성일 : 2017. 05. 08
			 * 작성자 : 신재호
			 * 21 과세(세금계산서)
			 * 22 불공(세금계산서)
			 * 23 영세(세금계산서)
			 * 26 면세(계산서)
			 * 27 의제(계산서 2/102)
			 * 29 의제(계산서 3/103)
			 * 32 의제(계산서 5/105)
			 * 38 수입(세금계산서)
			 * 40 의제(계산서 6/106)
			 * 43 매입자발행세금계산서
			 * 44 재활용(계산서 6/106)
			 * 46 재활용(계산서 10/110)
			 * 48 의제(계산서 8/108)
			 * 51 의제(계산서 4/104)
			 * 54 재활용(계산서 9/109)
			 * 65 재활용(계산서 3/103)
			 */
			if ( this.interface_type.toUpperCase( ).equals( "ETAX" ) ) {
				return "0";
			}
			//			else if ( this.auth_vat_type_code.equals( "21" ) || this.auth_vat_type_code.equals( "22" ) || this.auth_vat_type_code.equals( "23" ) || this.auth_vat_type_code.equals( "26" ) || this.auth_vat_type_code.equals( "27" ) || this.auth_vat_type_code.equals( "29" ) || this.auth_vat_type_code.equals( "32" ) || this.auth_vat_type_code.equals( "38" ) || this.auth_vat_type_code.equals( "40" ) || this.auth_vat_type_code.equals( "43" ) || this.auth_vat_type_code.equals( "44" ) || this.auth_vat_type_code.equals( "46" ) || this.auth_vat_type_code.equals( "48" ) || this.auth_vat_type_code.equals( "51" ) || this.auth_vat_type_code.equals( "54" ) || this.auth_vat_type_code.equals( "65" ) ) {
			//				return "0";
			//			}
			else if ( ETAX_SEND_YN.equals( commonCode.EMPTYYES ) ) {
				return "0";
			}
			return "1";
		}

		String DT_WRITE ( ) {
			return this.rep_dt;
		}

		String NM_PTR ( ) {
			return "";
		}

		String EX_HP ( ) {
			return "";
		}

		String EX_EMIL ( ) {
			return "";
		}

		String NM_PARTNER ( ) {
			if ( this.partner_partner_code.equals( "00" ) ) {
				return this.partner_partner_name;
			}
			else {
				return null;
			}
		}

		String FEE_SEQ ( ) {
			return this.fee_seq;
		}

		String FEE_DT_START ( ) {
			return this.fee_start_date;
		}

		String FEE_TP_RECEPT ( ) {
			return this.fee_use_fg_code;
		}

		String FEE_RECEPT_GU ( ) {
			return this.fee_auth_fg_code;
		}

		String FEE_CD_CARD ( ) {
			return this.fee_card_code;
		}

		String FEE_NO_COMPANY ( ) {
			return this.partner_partner_no; // 접대 장소 회사(식당) 미입력
		}
		String FEE_CD_PARTNER ( ) {
			return this.partner_partner_code;
		}
		String FEE_NM_CEO ( ) {
			return this.partner_partner_emp_code; // 접대 장소 회사(식당) 사장님 미입력
		}

		String FEE_NO_RES ( ) {
			return ""; // 접대 장소 회사(식당) 사장 주민번호 미입력
		}

		String FEE_NO_RES1 ( ) {
			return this.fee_res_num; // 접대 받는 거래처
		}

		String FEE_NM_CEO1 ( ) {
			return this.fee_ceo_name; // 접대 받는 거래처
		}

		String FEE_CD_PARTNER1 ( ) {
			return this.fee_partner_code; // 접대 받는 거래처 코드
		}

		String FEE_NO_COMPANY1 ( ) {
			return this.fee_partner_num; // 접대 받는 거래처 번호
		}

		String FEE_NM_ADRESS ( ) {
			return "";  // 접대 장소 (특별시, 광역시, 등.) 미입력
		}

		String FEE_USE_AREA ( ) {
			return ""; // 접대 장소 상세 주소 미입력
		}

		String FEE_USE_COST ( ) {
			return this.fee_amt; // 합계 금액
		}

		String FEE_AM_MATIRIAL ( ) {
			return this.fee_metirial_amt; // 물품대
		}

		String FEE_AM_SERVICE ( ) {
			return this.fee_service_amt;  // 봉사료
		}

		String FEE_NM_NOTE ( ) {
			return this.fee_entertainment; // 접대 내역
		}

		String FEE_RECEPT_GU10 ( ) {
			return this.fee_amt_over_yn; // N : Y 20만원 초과~
		}

		String FEE_NM_NOTE1 ( ) {
			return this.note; // 비고
		}

		String FEE_ST_DOCU ( ) {
			return "";
		}

		String FEE_NM_RECEPT ( ) {
			return "";
		}

		String FEE_NM_RECEPT1 ( ) {
			return "";
		}

		String FEE_TP_RECEPTION ( ) {
			return "";
		}

		String FEE_TP_COMPANY ( ) {
			return "";
		}

		String TP_EVIDENCE ( ) { //ERP 증빙
			if(this.auth_erp_auth_code.equals( "" )){
				return this.summary_erp_auth_code;
			}else{
				return this.auth_erp_auth_code;
			}
		}

		public Map<String, Object> getMap ( ) {
			Map<String, Object> result = new HashMap<String, Object>( );
			result.put( "NO_TAX", NO_TAX );
			/* result.put( "CD_PC", CD_PC ); */
			result.put( "CD_PC", ORG_ERP_PC_CD );
			result.put( "CD_WDEPT", CD_WDEPT );
			result.put( "ID_WRITE", ID_WRITE );
			result.put( "CD_DOCU", CD_DOCU );
			result.put( "DT_ACCT", DT_ACCT );
			result.put( "ST_DOCU", ST_DOCU );
			result.put( "TP_DRCR", TP_DRCR );
			result.put( "CD_ACCT", CD_ACCT );
			result.put( "AMT", AMT );
			result.put( "CD_PARTNER", CD_PARTNER );
			result.put( "DT_START", DT_START );
			result.put( "DT_END", DT_END );
			result.put( "AM_TAXSTD", AM_TAXSTD );
			result.put( "AM_ADDTAX", AM_ADDTAX );
			result.put( "TP_TAX", TP_TAX );
			result.put( "NO_COMPANY", NO_COMPANY );
			result.put( "NM_NOTE", NM_NOTE );
			result.put( "CD_BIZAREA", CD_BIZAREA );
			result.put( "CD_DEPT", CD_DEPT );
			result.put( "CD_CC", CD_CC );
			result.put( "CD_PJT", CD_PJT );
			result.put( "CD_FUND", CD_FUND );
			result.put( "CD_BUDGET", CD_BUDGET );
			result.put( "NO_CASH", NO_CASH );
			result.put( "ST_MUTUAL", ST_MUTUAL );
			result.put( "CD_CARD", CD_CARD );
			result.put( "NO_DEPOSIT", NO_DEPOSIT );
			result.put( "CD_BANK", CD_BANK );
			result.put( "UCD_MNG1", UCD_MNG1 );
			result.put( "UCD_MNG2", UCD_MNG2 );
			result.put( "UCD_MNG3", UCD_MNG3 );
			result.put( "UCD_MNG4", UCD_MNG4 );
			result.put( "UCD_MNG5", UCD_MNG5 );
			result.put( "CD_EMPLOY", CD_EMPLOY );
			result.put( "CD_MNG", CD_MNG );
			result.put( "NO_BDOCU", NO_BDOCU );
			result.put( "NO_BDOLINE", NO_BDOLINE );
			result.put( "TP_DOCU", TP_DOCU );
			result.put( "NO_ACCT", NO_ACCT );
			result.put( "TP_TRADE", TP_TRADE );
			result.put( "CD_EXCH", CD_EXCH );
			result.put( "RT_EXCH", RT_EXCH );
			result.put( "CD_TRADE", CD_TRADE );
			result.put( "NO_CHECK2", NO_CHECK2 );
			result.put( "NO_CHECK3", NO_CHECK3 );
			result.put( "NO_CHECK4", NO_CHECK4 );
			result.put( "TP_CROSS", TP_CROSS );
			result.put( "ERP_CD", ERP_CD );
			result.put( "AM_EX", AM_EX );
			result.put( "NO_TO", NO_TO );
			result.put( "DT_SHIPPING", DT_SHIPPING );
			result.put( "TP_GUBUN", TP_GUBUN );
			result.put( "NO_INVOICE", NO_INVOICE );
			result.put( "NO_ITEM", NO_ITEM );
			result.put( "MD_TAX1", MD_TAX1 );
			result.put( "NM_ITEM1", NM_ITEM1 );
			result.put( "NM_SIZE1", NM_SIZE1 );
			result.put( "QT_TAX1", QT_TAX1 );
			result.put( "AM_PRC1", AM_PRC1 );
			result.put( "AM_SUPPLY1", AM_SUPPLY1 );
			result.put( "AM_TAX1", AM_TAX1 );
			result.put( "NM_NOTE1", NM_NOTE1 );
			result.put( "CD_BIZPLAN", CD_BIZPLAN );
			result.put( "CD_BGACCT", CD_BGACCT );
			result.put( "CD_MNGD1", CD_MNGD1 );
			result.put( "NM_MNGD1", NM_MNGD1 );
			result.put( "CD_MNGD2", CD_MNGD2 );
			result.put( "NM_MNGD2", NM_MNGD2 );
			result.put( "CD_MNGD3", CD_MNGD3 );
			result.put( "NM_MNGD3", NM_MNGD3 );
			result.put( "CD_MNGD4", CD_MNGD4 );
			result.put( "NM_MNGD4", NM_MNGD4 );
			result.put( "CD_MNGD5", CD_MNGD5 );
			result.put( "NM_MNGD5", NM_MNGD5 );
			result.put( "CD_MNGD6", CD_MNGD6 );
			result.put( "NM_MNGD6", NM_MNGD6 );
			result.put( "CD_MNGD7", CD_MNGD7 );
			result.put( "NM_MNGD7", NM_MNGD7 );
			result.put( "CD_MNGD8", CD_MNGD8 );
			result.put( "NM_MNGD8", NM_MNGD8 );
			result.put( "YN_ISS", YN_ISS );
			result.put( "TP_BILL", TP_BILL );
			result.put( "ST_TAX", ST_TAX );
			result.put( "MD_TAX2", MD_TAX2 );
			result.put( "NM_ITEM2", NM_ITEM2 );
			result.put( "NM_SIZE2", NM_SIZE2 );
			result.put( "QT_TAX2", QT_TAX2 );
			result.put( "AM_PRC2", AM_PRC2 );
			result.put( "AM_SUPPLY2", AM_SUPPLY2 );
			result.put( "AM_TAX2", AM_TAX2 );
			result.put( "NM_NOTE2", NM_NOTE2 );
			result.put( "MD_TAX3", MD_TAX3 );
			result.put( "NM_ITEM3", NM_ITEM3 );
			result.put( "NM_SIZE3", NM_SIZE3 );
			result.put( "QT_TAX3", QT_TAX3 );
			result.put( "AM_PRC3", AM_PRC3 );
			result.put( "AM_SUPPLY3", AM_SUPPLY3 );
			result.put( "AM_TAX3", AM_TAX3 );
			result.put( "NM_NOTE3", NM_NOTE3 );
			result.put( "MD_TAX4", MD_TAX4 );
			result.put( "NM_ITEM4", NM_ITEM4 );
			result.put( "NM_SIZE4", NM_SIZE4 );
			result.put( "QT_TAX4", QT_TAX4 );
			result.put( "AM_PRC4", AM_PRC4 );
			result.put( "AM_SUPPLY4", AM_SUPPLY4 );
			result.put( "AM_TAX4", AM_TAX4 );
			result.put( "NM_NOTE4", NM_NOTE4 );
			result.put( "FINAL_STATUS", FINAL_STATUS );
			result.put( "NO_BILL", NO_BILL );
			result.put( "NO_ISS", NO_ISS );
			result.put( "NO_ASSET", NO_ASSET );
			result.put( "TP_RECORD", TP_RECORD );
			result.put( "TP_ETCACCT", TP_ETCACCT );
			result.put( "SELL_DAM_NM", SELL_DAM_NM );
			result.put( "SELL_DAM_EMAIL", SELL_DAM_EMAIL );
			result.put( "SELL_DAM_MOBIL", SELL_DAM_MOBIL );
			result.put( "ST_GWARE", ST_GWARE );
			result.put( "NM_PUMM", NM_PUMM );
			result.put( "JEONJASEND15_YN", JEONJASEND15_YN );
			result.put( "DT_WRITE", DT_WRITE );
			result.put( "NM_PTR", NM_PTR );
			result.put( "EX_HP", EX_HP );
			result.put( "EX_EMIL", EX_EMIL );
			result.put( "NM_PARTNER", NM_PARTNER );


			result.put( "FEE_SEQ", FEE_SEQ );
			result.put( "FEE_CD_PC", FEE_CD_PC );
			result.put( "FEE_CD_ACCT", FEE_CD_ACCT );
			result.put( "FEE_CD_DEPT", FEE_CD_DEPT );
			result.put( "FEE_CD_EMP", FEE_CD_EMP );
			result.put( "FEE_DT_START", FEE_DT_START );
			result.put( "FEE_TP_RECEPT", FEE_TP_RECEPT );
			result.put( "FEE_RECEPT_GU", FEE_RECEPT_GU );
			result.put( "FEE_CD_CARD", FEE_CD_CARD );
			result.put( "FEE_NO_COMPANY", FEE_NO_COMPANY );
			result.put( "FEE_NM_CEO", FEE_NM_CEO );
			result.put( "FEE_NO_RES", FEE_NO_RES );
			result.put( "FEE_NO_RES1", FEE_NO_RES1 );
			result.put( "FEE_NM_CEO1", FEE_NM_CEO1 );
			result.put( "FEE_NO_COMPANY1", FEE_NO_COMPANY1 );
			result.put( "FEE_NM_ADRESS", FEE_NM_ADRESS );
			result.put( "FEE_USE_AREA", FEE_USE_AREA );
			result.put( "FEE_USE_COST", FEE_USE_COST );
			result.put( "FEE_AM_MATIRIAL", FEE_AM_MATIRIAL );
			result.put( "FEE_AM_SERVICE", FEE_AM_SERVICE );
			result.put( "FEE_NM_NOTE", FEE_NM_NOTE );
			result.put( "FEE_RECEPT_GU10", FEE_RECEPT_GU10 );
			result.put( "FEE_NM_NOTE1", FEE_NM_NOTE1 );
			result.put( "FEE_ST_DOCU", FEE_ST_DOCU );
			result.put( "FEE_CD_PARTNER", FEE_CD_PARTNER );
			result.put( "FEE_CD_PARTNER1", FEE_CD_PARTNER1 );
			result.put( "FEE_NM_RECEPT", FEE_NM_RECEPT );
			result.put( "FEE_NM_RECEPT1", FEE_NM_RECEPT1 );
			result.put( "FEE_TP_RECEPTION", FEE_TP_RECEPTION );
			result.put( "FEE_TP_COMPANY", FEE_TP_COMPANY );
			result.put( "CD_BIZCAR", CD_BIZCAR );
			result.put( "TP_EVIDENCE", TP_EVIDENCE );

			return result;
		}

		private String cd_mng1;
		@SuppressWarnings ( "unused" )
		private String nm_mng1;
		private String cd_mngd1;
		private String nm_mngd1;
		private String cd_mng2;
		@SuppressWarnings ( "unused" )
		private String nm_mng2;
		private String cd_mngd2;
		private String nm_mngd2;
		private String cd_mng3;
		@SuppressWarnings ( "unused" )
		private String nm_mng3;
		private String cd_mngd3;
		private String nm_mngd3;
		private String cd_mng4;
		@SuppressWarnings ( "unused" )
		private String nm_mng4;
		private String cd_mngd4;
		private String nm_mngd4;
		private String cd_mng5;
		@SuppressWarnings ( "unused" )
		private String nm_mng5;
		private String cd_mngd5;
		private String nm_mngd5;
		private String cd_mng6;
		@SuppressWarnings ( "unused" )
		private String nm_mng6;
		private String cd_mngd6;
		private String nm_mngd6;
		private String cd_mng7;
		@SuppressWarnings ( "unused" )
		private String nm_mng7;
		private String cd_mngd7;
		private String nm_mngd7;
		private String cd_mng8;
		@SuppressWarnings ( "unused" )
		private String nm_mng8;
		private String cd_mngd8;
		private String nm_mngd8;
		@SuppressWarnings ( "unused" )
		private String comp_seq;
		private String expend_seq;
		@SuppressWarnings ( "unused" )
		private String slip_seq;
		private String list_seq;
		private String note;
		private String note_option_value;
		private String slip_note_option_value;
		@SuppressWarnings ( "unused" )
		private String emp_seq;
		@SuppressWarnings ( "unused" )
		private String writer_seq;
		@SuppressWarnings ( "unused" )
		private String auth_seq;
		@SuppressWarnings ( "unused" )
		private String card_seq;
		@SuppressWarnings ( "unused" )
		private String budget_seq;
		@SuppressWarnings ( "unused" )
		private String partner_seq;
		@SuppressWarnings ( "unused" )
		private String project_seq;
		@SuppressWarnings ( "unused" )
		private String summary_seq;
		private String expend_date;
		private String expend_req_date;
		private String drcr_gbn;
		private String acct_code;
		private String amt;
		private String interface_type;
		private String sub_std_amt;
		private String sub_tax_amt;
		@SuppressWarnings ( "unused" )
		private String doc_seq;
		@SuppressWarnings ( "unused" )
		private String doc_no;
		@SuppressWarnings ( "unused" )
		private String doc_title;
		private String form_nm;
		private String iss_no;
		private String no_iss;
		@SuppressWarnings ( "unused" )
		private String emp_comp_seq;
		@SuppressWarnings ( "unused" )
		private String emp_comp_name;
		@SuppressWarnings ( "unused" )
		private String emp_erp_comp_seq;
		@SuppressWarnings ( "unused" )
		private String emp_emp_seq;
		private String emp_erp_emp_seq;
		@SuppressWarnings ( "unused" )
		private String emp_erp_pc_seq;
		private String emp_erp_cc_seq;

		private String org_erp_pc_cd;
		private String org_erp_pc_name;

		@SuppressWarnings ( "unused" )
		private String writer_comp_seq;
		@SuppressWarnings ( "unused" )
		private String writer_comp_name;
		@SuppressWarnings ( "unused" )
		private String writer_erp_comp_seq;
		@SuppressWarnings ( "unused" )
		private String writer_emp_seq;
		private String writer_erp_emp_seq;
		@SuppressWarnings("unused")
		private String writer_erp_pc_seq;
		@SuppressWarnings ( "unused" )
		private String writer_erp_cc_seq;
		@SuppressWarnings ( "unused" )
		private String writer_erp_biz_seq;
		@SuppressWarnings ( "unused" )
		private String auth_auth_div;
		@SuppressWarnings ( "unused" )
		private String auth_auth_code;
		@SuppressWarnings ( "unused" )
		private String auth_cd_acct_code;
		@SuppressWarnings ( "unused" )
		private String auth_vat_acct_code;
		private String auth_vat_type_code;
		@SuppressWarnings ( "unused" )
		private String auth_erp_auth_code;
		private String summary_erp_auth_code;
		@SuppressWarnings ( "unused" )
		private String auth_va_type_code;
		@SuppressWarnings ( "unused" )
		private String auth_va_type_name;
		private String card_card_code;
		private String card_card_num;
		private String budget_budget_code;
		private String budget_bizplan_code;
		private String budget_bgacct_code;
		private String partner_partner_code;
		private String partner_partner_no;
		@SuppressWarnings ( "unused" )
		private String partner_bank_code;
		private String partner_partner_emp_code;
		private String project_project_code;
		@SuppressWarnings ( "unused" )
		private String project_name;
		@SuppressWarnings ( "unused" )
		private String summary_summary_div;
		@SuppressWarnings ( "unused" )
		private String summaty_summary_code;
		@SuppressWarnings ( "unused" )
		private String summary_dr_acct_code;
		@SuppressWarnings ( "unused" )
		private String summary_cr_acct_code;
		private String writer_erp_dept_seq;
		private String emp_erp_dept_seq;
		private String partner_partner_name;
		@SuppressWarnings ( "unused" )
		private String partner_job_gbn;
		@SuppressWarnings ( "unused" )
		private String partner_cls_job_gbn;
		private String auth_date;
		@SuppressWarnings ( "unused" )
		private String std_amt;
		@SuppressWarnings ( "unused" )
		private String tax_amt;
		private String emp_erp_biz_seq;
		private String auth_no_tax_code;
		private String card_partner_code;
		@SuppressWarnings ( "unused" )
		private String partner_deposit_convert;
		private String budget_use_yn;
		private String adv_expend_dt;
		private String adv_expend_req_dt;
		private String bizCd;
		@SuppressWarnings ( "unused" )
		private String bizNm;
		/* fee - 접대비 부표로 넘어갈 정보 */
		private String fee_seq;
		private String fee_start_date;
		private String fee_use_fg_code;
		@SuppressWarnings ( "unused" )
		private String fee_use_fg_name;
		private String fee_auth_fg_code;
		@SuppressWarnings ( "unused" )
		private String fee_auth_fg_name;
		private String fee_card_code;
		@SuppressWarnings ( "unused" )
		private String fee_card_num;
		private String fee_partner_code;
		@SuppressWarnings ( "unused" )
		private String fee_partner_name;
		private String fee_partner_num;
		@SuppressWarnings ( "unused" )
		private String fee_no_company;
		private String fee_ceo_name;
		private String fee_res_num;
		private String fee_amt;
		private String fee_metirial_amt;
		private String fee_service_amt;
		private String fee_entertainment;
		@SuppressWarnings ( "unused" )
		private String fee_note;
		private String fee_amt_over_yn;
		/* 현금승인번호 */
		private String auth_no_cash;

		private String cd_bizcar;

		/* 상신일자 */
		private String rep_dt;

		int InitField ( ) {
			if ( map.get( "fee_no_company" ) == null ) {
				this.fee_no_company = "";
			}
			else {
				this.fee_no_company = map.get( "fee_no_company" ).toString( );
			}
			if ( map.get( "fee_seq" ) == null ) {
				this.fee_seq = "0";
			}
			else {
				this.fee_seq = map.get( "fee_seq" ).toString( );
			}
			if ( map.get( "fee_start_date" ) == null ) {
				fee_start_date = "";
			}
			else {
				fee_start_date = map.get( "fee_start_date" ).toString( );
			}
			if ( map.get( "fee_use_fg_code" ) == null ) {
				fee_use_fg_code = "";
			}
			else {
				fee_use_fg_code = map.get( "fee_use_fg_code" ).toString( );
			}
			if ( map.get( "fee_use_fg_name" ) == null ) {
				fee_use_fg_name = "";
			}
			else {
				fee_use_fg_name = map.get( "fee_use_fg_name" ).toString( );
			}
			if ( map.get( "fee_auth_fg_code" ) == null ) {
				fee_auth_fg_code = "";
			}
			else {
				fee_auth_fg_code = map.get( "fee_auth_fg_code" ).toString( );
			}
			if ( map.get( "fee_auth_fg_name" ) == null ) {
				fee_auth_fg_name = "";
			}
			else {
				fee_auth_fg_name = map.get( "fee_auth_fg_name" ).toString( );
			}
			if ( map.get( "fee_card_code" ) == null ) {
				fee_card_code = "";
			}
			else {
				fee_card_code = map.get( "fee_card_code" ).toString( );
			}
			if ( map.get( "fee_card_num" ) == null ) {
				fee_card_num = "";
			}
			else {
				fee_card_code = map.get( "fee_card_num" ).toString( );
			}
			if ( map.get( "fee_partner_code" ) == null ) {
				fee_partner_code = "";
			}
			else {
				fee_partner_code = map.get( "fee_partner_code" ).toString( );
			}
			if ( map.get( "fee_partner_name" ) == null ) {
				fee_partner_name = "";
			}
			else {
				fee_partner_name = map.get( "fee_partner_name" ).toString( );
			}
			if ( map.get( "fee_partner_num" ) == null ) {
				fee_partner_num = "";
			}
			else {
				fee_partner_num = map.get( "fee_partner_num" ).toString( );
			}
			if ( map.get( "fee_ceo_name" ) == null ) {
				fee_ceo_name = "";
			}
			else {
				fee_ceo_name = map.get( "fee_ceo_name" ).toString( );
			}
			if ( map.get( "fee_res_num" ) == null ) {
				fee_res_num = "";
			}
			else {
				fee_res_num = map.get( "fee_res_num" ).toString( );
			}
			if ( map.get( "fee_amt" ) == null ) {
				fee_amt = "";
			}
			else {
				fee_amt = map.get( "fee_amt" ).toString( );
			}
			if ( map.get( "fee_metirial_amt" ) == null ) {
				fee_metirial_amt = "";
			}
			else {
				fee_metirial_amt = map.get( "fee_metirial_amt" ).toString( );
			}
			if ( map.get( "fee_service_amt" ) == null ) {
				fee_service_amt = "";
			}
			else {
				fee_service_amt = map.get( "fee_service_amt" ).toString( );
			}
			if ( map.get( "fee_entertainment" ) == null ) {
				fee_entertainment = "";
			}
			else {
				fee_entertainment = map.get( "fee_entertainment" ).toString( );
			}
			if ( map.get( "fee_note" ) == null ) {
				fee_note = "";
			}
			else {
				fee_note = map.get( "fee_note" ).toString( );
			}
			if ( map.get( "fee_amt_over_yn" ) == null ) {
				fee_amt_over_yn = "";
			}
			else {
				fee_amt_over_yn = map.get( "fee_amt_over_yn" ).toString( );
			}
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
			if ( map.get( "partner_deposit_convert" ) == null ) {
				partner_deposit_convert = "";
			}
			else {
				partner_deposit_convert = map.get( "partner_deposit_convert" ).toString( );
			}
			if ( map.get( "card_partner_code" ) == null ) {
				card_partner_code = "";
			}
			else {
				card_partner_code = map.get( "card_partner_code" ).toString( );
			}
			if ( map.get( "auth_no_tax_code" ) == null ) {
				auth_no_tax_code = "";
			}
			else {
				auth_no_tax_code = map.get( "auth_no_tax_code" ).toString( );
			}
			if ( map.get( "emp_erp_biz_seq" ) == null ) {
				emp_erp_biz_seq = "";
			}
			else {
				emp_erp_biz_seq = map.get( "emp_erp_biz_seq" ).toString( );
			}
			if ( map.get( "std_amt" ) == null ) {
				std_amt = "";
			}
			else {
				std_amt = map.get( "std_amt" ).toString( );
			}
			if ( map.get( "tax_amt" ) == null ) {
				tax_amt = "";
			}
			else {
				tax_amt = map.get( "tax_amt" ).toString( );
			}
			if ( map.get( "auth_date" ) == null ) {
				auth_date = "";
			}
			else {
				auth_date = map.get( "auth_date" ).toString( );
			}
			if ( map.get( "partner_cls_job_gbn" ) == null ) {
				partner_cls_job_gbn = "";
			}
			else {
				partner_cls_job_gbn = map.get( "partner_cls_job_gbn" ).toString( );
			}
			if ( map.get( "partner_job_gbn" ) == null ) {
				partner_job_gbn = "";
			}
			else {
				partner_job_gbn = map.get( "partner_job_gbn" ).toString( );
			}
			if ( map.get( "partner_partner_name" ) == null ) {
				partner_partner_name = "";
			}
			else {
				partner_partner_name = map.get( "partner_partner_name" ).toString( );
			}
			if ( map.get( "writer_erp_dept_seq" ) == null ) {
				writer_erp_dept_seq = "";
			}
			else {
				writer_erp_dept_seq = map.get( "writer_erp_dept_seq" ).toString( );
			}
			if ( map.get( "emp_erp_dept_seq" ) == null ) {
				emp_erp_dept_seq = "";
			}
			else {
				emp_erp_dept_seq = map.get( "emp_erp_dept_seq" ).toString( );
			}
			if ( map.get( "emp_comp_seq" ) == null ) {
				emp_comp_seq = "";
			}
			else {
				emp_comp_seq = map.get( "emp_comp_seq" ).toString( );
			}
			if ( map.get( "emp_comp_name" ) == null ) {
				emp_comp_name = "";
			}
			else {
				emp_comp_name = map.get( "emp_comp_name" ).toString( );
			}
			if ( map.get( "emp_erp_comp_seq" ) == null ) {
				emp_erp_comp_seq = "";
			}
			else {
				emp_erp_comp_seq = map.get( "emp_erp_comp_seq" ).toString( );
			}
			if ( map.get( "emp_emp_seq" ) == null ) {
				emp_emp_seq = "";
			}
			else {
				emp_emp_seq = map.get( "emp_emp_seq" ).toString( );
			}
			if ( map.get( "emp_erp_emp_seq" ) == null ) {
				emp_erp_emp_seq = "";
			}
			else {
				emp_erp_emp_seq = map.get( "emp_erp_emp_seq" ).toString( );
			}
			if ( map.get( "emp_erp_pc_seq" ) == null ) {
				emp_erp_pc_seq = "";
			}
			else {
				emp_erp_pc_seq = map.get( "emp_erp_pc_seq" ).toString( );
			}
			if ( map.get( "emp_erp_cc_seq" ) == null ) {
				emp_erp_cc_seq = "";
			}
			else {
				emp_erp_cc_seq = map.get( "emp_erp_cc_seq" ).toString( );
			}
			if ( map.get( "writer_comp_seq" ) == null ) {
				writer_comp_seq = "";
			}
			else {
				writer_comp_seq = map.get( "writer_comp_seq" ).toString( );
			}
			if ( map.get( "writer_comp_name" ) == null ) {
				writer_comp_name = "";
			}
			else {
				writer_comp_name = map.get( "writer_comp_name" ).toString( );
			}
			if ( map.get( "writer_erp_comp_seq" ) == null ) {
				writer_erp_comp_seq = "";
			}
			else {
				writer_erp_comp_seq = map.get( "writer_erp_comp_seq" ).toString( );
			}
			if ( map.get( "writer_emp_seq" ) == null ) {
				writer_emp_seq = "";
			}
			else {
				writer_emp_seq = map.get( "writer_emp_seq" ).toString( );
			}
			if ( map.get( "writer_erp_emp_seq" ) == null ) {
				writer_erp_emp_seq = "";
			}
			else {
				writer_erp_emp_seq = map.get( "writer_erp_emp_seq" ).toString( );
			}
			if ( map.get( "writer_erp_pc_seq" ) == null ) {
				writer_erp_pc_seq = "";
			}
			else {
				writer_erp_pc_seq = map.get( "writer_erp_pc_seq" ).toString( );
			}

			if ( map.get( "org_erp_pc_seq" ) == null ) {
				org_erp_pc_cd = "";
			}
			else {
				org_erp_pc_cd = map.get( "org_erp_pc_seq" ).toString( );
			}
			if ( map.get( "writer_erp_cc_seq" ) == null ) {
				writer_erp_cc_seq = "";
			}
			else {
				writer_erp_cc_seq = map.get( "writer_erp_cc_seq" ).toString( );
			}
			if ( map.get( "writer_erp_biz_seq" ) == null ) {
				writer_erp_biz_seq = "";
			}
			else {
				writer_erp_biz_seq = map.get( "writer_erp_biz_seq" ).toString( );
			}
			if ( map.get( "auth_auth_div" ) == null ) {
				auth_auth_div = "";
			}
			else {
				auth_auth_div = map.get( "auth_auth_div" ).toString( );
			}
			if ( map.get( "auth_auth_code" ) == null ) {
				auth_auth_code = "";
			}
			else {
				auth_auth_code = map.get( "auth_auth_code" ).toString( );
			}
			if ( map.get( "auth_cd_acct_code" ) == null ) {
				auth_cd_acct_code = "";
			}
			else {
				auth_cd_acct_code = map.get( "auth_cd_acct_code" ).toString( );
			}
			if ( map.get( "auth_vat_acct_code" ) == null ) {
				auth_vat_acct_code = "";
			}
			else {
				auth_vat_acct_code = map.get( "auth_vat_acct_code" ).toString( );
			}
			if ( map.get( "auth_vat_type_code" ) == null ) {
				auth_vat_type_code = "";
			}
			else {
				auth_vat_type_code = map.get( "auth_vat_type_code" ).toString( );
			}
			if ( map.get( "auth_erp_auth_code" ) == null ) {
				auth_erp_auth_code = "";
			}
			else {
				auth_erp_auth_code = map.get( "auth_erp_auth_code" ).toString( );
			}
			if ( map.get( "summary_erp_auth_code" ) == null ) {
				summary_erp_auth_code = "";
			}
			else {
				summary_erp_auth_code = map.get( "summary_erp_auth_code" ).toString( );
			}
			if ( map.get( "auth_va_type_code" ) == null ) {
				auth_va_type_code = "";
			}
			else {
				auth_va_type_code = map.get( "auth_va_type_code" ).toString( );
			}
			if ( map.get( "auth_va_type_name" ) == null ) {
				auth_va_type_name = "";
			}
			else {
				auth_va_type_name = map.get( "auth_va_type_name" ).toString( );
			}
			if ( map.get( "card_card_code" ) == null ) {
				card_card_code = "";
			}
			else {
				card_card_code = map.get( "card_card_code" ).toString( );
			}
			if ( map.get( "card_card_num" ) == null ) {
				card_card_num = "";
			}
			else {
				card_card_num = map.get( "card_card_num" ).toString( );
			}
			if ( map.get( "budget_budget_code" ) == null ) {
				budget_budget_code = "";
			}
			else {
				budget_budget_code = map.get( "budget_budget_code" ).toString( );
			}
			if ( map.get( "budget_bizplan_code" ) == null ) {
				budget_bizplan_code = "";
			}
			else {
				budget_bizplan_code = map.get( "budget_bizplan_code" ).toString( );
			}
			if ( map.get( "budget_bgacct_code" ) == null ) {
				budget_bgacct_code = "";
			}
			else {
				budget_bgacct_code = map.get( "budget_bgacct_code" ).toString( );
			}
			if ( map.get( "partner_partner_code" ) == null ) {
				partner_partner_code = "";
			}
			else {
				partner_partner_code = map.get( "partner_partner_code" ).toString( );
			}
			if ( map.get( "partner_partner_no" ) == null ) {
				partner_partner_no = "";
			}
			else {
				partner_partner_no = map.get( "partner_partner_no" ).toString( );
			}
			if ( map.get( "partner_bank_code" ) == null ) {
				partner_bank_code = "";
			}
			else {
				partner_bank_code = map.get( "partner_bank_code" ).toString( );
			}
			if ( map.get( "partner_partner_emp_code" ) == null ) {
				partner_partner_emp_code = "";
			}
			else {
				partner_partner_emp_code = map.get( "partner_partner_emp_code" ).toString( );
			}
			if ( map.get( "project_project_code" ) == null ) {
				project_project_code = "";
			}
			else {
				project_project_code = map.get( "project_project_code" ).toString( );
			}
			if ( map.get( "project_name" ) == null ) {
				project_name = "";
			}
			else {
				project_name = map.get( "project_name" ).toString( );
			}
			if ( map.get( "summary_summary_div" ) == null ) {
				summary_summary_div = "";
			}
			else {
				summary_summary_div = map.get( "summary_summary_div" ).toString( );
			}
			if ( map.get( "summaty_summary_code" ) == null ) {
				summaty_summary_code = "";
			}
			else {
				summaty_summary_code = map.get( "summaty_summary_code" ).toString( );
			}
			if ( map.get( "summary_dr_acct_code" ) == null ) {
				summary_dr_acct_code = "";
			}
			else {
				summary_dr_acct_code = map.get( "summary_dr_acct_code" ).toString( );
			}
			if ( map.get( "summary_cr_acct_code" ) == null ) {
				summary_cr_acct_code = "";
			}
			else {
				summary_cr_acct_code = map.get( "summary_cr_acct_code" ).toString( );
			}
			if ( map.get( "cd_mng1" ) == null ) {
				cd_mng1 = "";
			}
			else {
				cd_mng1 = map.get( "cd_mng1" ).toString( );
			}
			if ( map.get( "nm_mng1" ) == null ) {
				nm_mng1 = "";
			}
			else {
				nm_mng1 = map.get( "nm_mng1" ).toString( );
			}
			if ( map.get( "cd_mngd1" ) == null ) {
				cd_mngd1 = "";
			}
			else {
				cd_mngd1 = map.get( "cd_mngd1" ).toString( );
			}
			if ( map.get( "nm_mngd1" ) == null ) {
				nm_mngd1 = "";
			}
			else {
				nm_mngd1 = map.get( "nm_mngd1" ).toString( );
			}
			if ( map.get( "cd_mng2" ) == null ) {
				cd_mng2 = "";
			}
			else {
				cd_mng2 = map.get( "cd_mng2" ).toString( );
			}
			if ( map.get( "nm_mng2" ) == null ) {
				nm_mng2 = "";
			}
			else {
				nm_mng2 = map.get( "nm_mng2" ).toString( );
			}
			if ( map.get( "cd_mngd2" ) == null ) {
				cd_mngd2 = "";
			}
			else {
				cd_mngd2 = map.get( "cd_mngd2" ).toString( );
			}
			if ( map.get( "nm_mngd2" ) == null ) {
				nm_mngd2 = "";
			}
			else {
				nm_mngd2 = map.get( "nm_mngd2" ).toString( );
			}
			if ( map.get( "cd_mng3" ) == null ) {
				cd_mng3 = "";
			}
			else {
				cd_mng3 = map.get( "cd_mng3" ).toString( );
			}
			if ( map.get( "nm_mng3" ) == null ) {
				nm_mng3 = "";
			}
			else {
				nm_mng3 = map.get( "nm_mng3" ).toString( );
			}
			if ( map.get( "cd_mngd3" ) == null ) {
				cd_mngd3 = "";
			}
			else {
				cd_mngd3 = map.get( "cd_mngd3" ).toString( );
			}
			if ( map.get( "nm_mngd3" ) == null ) {
				nm_mngd3 = "";
			}
			else {
				nm_mngd3 = map.get( "nm_mngd3" ).toString( );
			}
			if ( map.get( "cd_mng4" ) == null ) {
				cd_mng4 = "";
			}
			else {
				cd_mng4 = map.get( "cd_mng4" ).toString( );
			}
			if ( map.get( "nm_mng4" ) == null ) {
				nm_mng4 = "";
			}
			else {
				nm_mng4 = map.get( "nm_mng4" ).toString( );
			}
			if ( map.get( "cd_mngd4" ) == null ) {
				cd_mngd4 = "";
			}
			else {
				cd_mngd4 = map.get( "cd_mngd4" ).toString( );
			}
			if ( map.get( "nm_mngd4" ) == null ) {
				nm_mngd4 = "";
			}
			else {
				nm_mngd4 = map.get( "nm_mngd4" ).toString( );
			}
			if ( map.get( "cd_mng5" ) == null ) {
				cd_mng5 = "";
			}
			else {
				cd_mng5 = map.get( "cd_mng5" ).toString( );
			}
			if ( map.get( "nm_mng5" ) == null ) {
				nm_mng5 = "";
			}
			else {
				nm_mng5 = map.get( "nm_mng5" ).toString( );
			}
			if ( map.get( "cd_mngd5" ) == null ) {
				cd_mngd5 = "";
			}
			else {
				cd_mngd5 = map.get( "cd_mngd5" ).toString( );
			}
			if ( map.get( "nm_mngd5" ) == null ) {
				nm_mngd5 = "";
			}
			else {
				nm_mngd5 = map.get( "nm_mngd5" ).toString( );
			}
			if ( map.get( "cd_mng6" ) == null ) {
				cd_mng6 = "";
			}
			else {
				cd_mng6 = map.get( "cd_mng6" ).toString( );
			}
			if ( map.get( "nm_mng6" ) == null ) {
				nm_mng6 = "";
			}
			else {
				nm_mng6 = map.get( "nm_mng6" ).toString( );
			}
			if ( map.get( "cd_mngd6" ) == null ) {
				cd_mngd6 = "";
			}
			else {
				cd_mngd6 = map.get( "cd_mngd6" ).toString( );
			}
			if ( map.get( "nm_mngd6" ) == null ) {
				nm_mngd6 = "";
			}
			else {
				nm_mngd6 = map.get( "nm_mngd6" ).toString( );
			}
			if ( map.get( "cd_mng7" ) == null ) {
				cd_mng7 = "";
			}
			else {
				cd_mng7 = map.get( "cd_mng7" ).toString( );
			}
			if ( map.get( "nm_mng7" ) == null ) {
				nm_mng7 = "";
			}
			else {
				nm_mng7 = map.get( "nm_mng7" ).toString( );
			}
			if ( map.get( "cd_mngd7" ) == null ) {
				cd_mngd7 = "";
			}
			else {
				cd_mngd7 = map.get( "cd_mngd7" ).toString( );
			}
			if ( map.get( "nm_mngd7" ) == null ) {
				nm_mngd7 = "";
			}
			else {
				nm_mngd7 = map.get( "nm_mngd7" ).toString( );
			}
			if ( map.get( "cd_mng8" ) == null ) {
				cd_mng8 = "";
			}
			else {
				cd_mng8 = map.get( "cd_mng8" ).toString( );
			}
			if ( map.get( "nm_mng8" ) == null ) {
				nm_mng8 = "";
			}
			else {
				nm_mng8 = map.get( "nm_mng8" ).toString( );
			}
			if ( map.get( "cd_mngd8" ) == null ) {
				cd_mngd8 = "";
			}
			else {
				cd_mngd8 = map.get( "cd_mngd8" ).toString( );
			}
			if ( map.get( "nm_mngd8" ) == null ) {
				nm_mngd8 = "";
			}
			else {
				nm_mngd8 = map.get( "nm_mngd8" ).toString( );
			}
			if ( map.get( "comp_seq" ) == null ) {
				comp_seq = "";
			}
			else {
				comp_seq = map.get( "comp_seq" ).toString( );
			}
			if ( map.get( "expend_seq" ) == null ) {
				expend_seq = "";
			}
			else {
				expend_seq = map.get( "expend_seq" ).toString( );
			}
			if ( map.get( "slip_seq" ) == null ) {
				slip_seq = "";
			}
			else {
				slip_seq = map.get( "slip_seq" ).toString( );
			}
			if ( map.get( "list_seq" ) == null ) {
				list_seq = "";
			}
			else {
				list_seq = map.get( "list_seq" ).toString( );
			}
			if ( map.get( "note" ) == null ) {
				note = "";
			}
			else {
				note = map.get( "note" ).toString( );
			}
			if ( map.get( "note_option_value" ) == null ) {
				note_option_value = "";
			}
			else {
				note_option_value = map.get( "note_option_value" ).toString( );
			}
			if ( map.get( "slip_note_option_value" ) == null ) {
				slip_note_option_value = "";
			}
			else {
				slip_note_option_value = map.get( "slip_note_option_value" ).toString( );
			}
			if ( map.get( "emp_seq" ) == null ) {
				emp_seq = "";
			}
			else {
				emp_seq = map.get( "emp_seq" ).toString( );
			}
			if ( map.get( "writer_seq" ) == null ) {
				writer_seq = "";
			}
			else {
				writer_seq = map.get( "writer_seq" ).toString( );
			}
			if ( map.get( "auth_seq" ) == null ) {
				auth_seq = "";
			}
			else {
				auth_seq = map.get( "auth_seq" ).toString( );
			}
			if ( map.get( "card_seq" ) == null ) {
				card_seq = "";
			}
			else {
				card_seq = map.get( "card_seq" ).toString( );
			}
			if ( map.get( "budget_seq" ) == null ) {
				budget_seq = "";
			}
			else {
				budget_seq = map.get( "budget_seq" ).toString( );
			}
			if ( map.get( "partner_seq" ) == null ) {
				partner_seq = "";
			}
			else {
				partner_seq = map.get( "partner_seq" ).toString( );
			}
			if ( map.get( "project_seq" ) == null ) {
				project_seq = "";
			}
			else {
				project_seq = map.get( "project_seq" ).toString( );
			}
			if ( map.get( "summary_seq" ) == null ) {
				summary_seq = "";
			}
			else {
				summary_seq = map.get( "summary_seq" ).toString( );
			}
			if ( map.get( "expend_date" ) == null ) {
				expend_date = "";
			}
			else {
				expend_date = map.get( "expend_date" ).toString( );
			}
			if ( map.get( "expend_req_date" ) == null ) {
				expend_req_date = "";
			}
			else {
				expend_req_date = map.get( "expend_req_date" ).toString( );
			}
			if ( map.get( "drcr_gbn" ) == null ) {
				drcr_gbn = "";
			}
			else {
				drcr_gbn = map.get( "drcr_gbn" ).toString( ).toUpperCase( );
			}
			if ( map.get( "acct_code" ) == null ) {
				acct_code = "";
			}
			else {
				acct_code = map.get( "acct_code" ).toString( );
			}
			if ( map.get( "amt" ) == null ) {
				amt = "0";
			}
			else {
				amt = map.get( "amt" ).toString( );
			}
			if ( map.get( "interface_type" ) == null ) {
				interface_type = "";
			}
			else {
				interface_type = map.get( "interface_type" ).toString( );
			}
			if ( map.get( "sub_std_amt" ) == null ) {
				sub_std_amt = "0";
			}
			else {
				sub_std_amt = map.get( "sub_std_amt" ).toString( );
			}
			if ( map.get( "sub_tax_amt" ) == null ) {
				sub_tax_amt = "0";
			}
			else {
				sub_tax_amt = map.get( "sub_tax_amt" ).toString( );
			}
			if ( map.get( "doc_seq" ) == null ) {
				doc_seq = "";
			}
			else {
				doc_seq = map.get( "doc_seq" ).toString( );
			}
			if ( map.get( "doc_no" ) == null ) {
				doc_no = "";
			}
			else {
				doc_no = map.get( "doc_no" ).toString( );
			}
			if ( map.get( "doc_title" ) == null ) {
				doc_title = "";
			}
			else {
				doc_title = map.get( "doc_title" ).toString( );
			}
			if ( map.get( "form_nm" ) == null ) {
				form_nm = "";
			}
			else {
				form_nm = map.get( "form_nm" ).toString( );
			}
			if ( map.get( "iss_no" ) == null ) {
				iss_no = "";
			}
			else {
				iss_no = map.get( "iss_no" ).toString( );
			}
			if ( map.get( "no_iss" ) == null ) {
				no_iss = "";
			}
			else {
				no_iss = map.get( "no_iss" ).toString( );
			}
			if ( map.get( "etax_yn" ) == null ) {
				ETAX_YN = commonCode.EMPTYNO;
			}
			else {
				ETAX_YN = map.get( "etax_yn" ).toString( );
			}
			if ( map.get( "etax_send_yn" ) == null ) {
				ETAX_SEND_YN = commonCode.EMPTYNO;
			}
			else {
				ETAX_SEND_YN = map.get( "etax_send_yn" ).toString( );
			}
			if ( map.get( "bizCd" ) == null ) {
				bizCd = commonCode.EMPTYSTR;
			}
			else {
				bizCd = map.get( "bizCd" ).toString( );
			}
			if ( map.get( "bizNm" ) == null ) {
				bizNm = commonCode.EMPTYSTR;
			}
			else {
				bizNm = map.get( "bizNm" ).toString( );
			}
			if ( map.get( "auth_no_cash" ) == null ) {
				auth_no_cash = commonCode.EMPTYSTR;
			}
			else {
				auth_no_cash = map.get( "auth_no_cash" ).toString( );
			}
			if(map.get("cd_bizcar") == null) {
				cd_bizcar = commonCode.EMPTYSTR;
			} else {
				cd_bizcar = map.get("cd_bizcar").toString();
			}
			if(map.get("rep_dt") == null) {
				rep_dt = commonCode.EMPTYSTR;
			} else {
				rep_dt = map.get("rep_dt").toString();
			}
			return 0;
		}
	}
}
