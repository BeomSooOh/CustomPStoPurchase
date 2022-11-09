package common.vo.common;

public class CommonInterface {

    /* 예산연동 양식 하위코드 범위 */
    //public interface ifBudgetRange {
	public final class ifBudgetRange {

		public static final int MING = 1; /* bizboxA 예산 연동 시작 */
		public static final int MAXG = 1000; /* bizboxA 예산 연동 종료 */
		public static final int MINU = 1001; /* ERPiU 예산 연동 시작 */
		public static final int MAXU = 2000; /* ERPiU 예산 연동 종료 */
		public static final int MINI = 2001; /* iCUBE 예산 연동 시작 */
		public static final int MAXI = 3000; /* iCUBE 예산 연동 종료 */
		public static final int MINGORG = 3001; /* 예산편성 시작 */
		public static final int MAXGORG = 4000; /* 예산편성 종료 */
		public static final int MINGADJ = 4001; /* 예산조정 시작 */
		public static final int MAXGADJ = 5000; /* 예산조정 종료 */
    }

    /* CMS 연동 코드 */
    //public interface commonCms {
	public final class commonCms {
		public static final String CMSTYPE = "cmsType";
		public static final String CMSERPIU = "ERPiU";
		public static final String CMSHAHA = "www.kebhana.com";
		public static final String CMSIBK = "www.ibk.co.kr";
		public static final String CMSKB = "www.kbstar.com";
		public static final String CMSNH = "www.nonghyup.com";
		public static final String CMSSHINHAN = "www.shinhan.com";
		public static final String CMSWOORI = "www.wooribank.com";
		public static final String CMSSMART = "smart";
    }

    /* Log module type */
    //public interface commonLogModule {
	public final class commonLogModule {

		public static final String BATCH = "BATCH";
    }

    /* 공통코드 */
    //public interface commonCode {
	public final class commonCode {

        /* result auth type */
		public static final String MASTER = "MASTER";
		public static final String ADMIN = "ADMIN";
		public static final String USER = "USER";
        /* result code */
		public static final String SUCCESS = "SUCCESS";
		public static final String FAIL = "FAIL";
        /* log code */
		public static final String MODULE = "moduleType";
		public static final String TYPE = "logType";
		public static final String MESSAGE = "message";
		public static final String ALERTMESSAGE = "alertMessage";
		public static final String ERROR = "ERROR";
		public static final String INFO = "INFO";
        /* system type */
		public static final String BIZBOXA = "BizboxA";
		public static final String ICUBE = "iCUBE";
		public static final String ERPIU = "ERPiU";
		public static final String ETC = "ETC";
		public static final String EATYPE = "eaType";
		public static final String EA = "ea"; /* 비영리 전자결재 */
		public static final String EAP = "eap"; /* 영리 전자결재 */
		public static final String EAA = "eaa"; /* 통합 전자결재 */
		public static final String IFSYSTEM = "ifSystem";
		public static final String POST = "POST";
		public static final String GET = "GET";
        /* form_d_tp */
		public static final String EXA = "EXPENDA"; /* 지출결의서 Bizbox Alpha */
		public static final String EXI = "EXPENDI"; /* 지출결의서 iCUBE */
		public static final String EXU = "EXPENDU"; /* 지출결의서 ERPiU */
		public static final String G20C = "G20CON"; /* G20 품의서 */
		public static final String G20R = "G20RES"; /* G20 결의서 */
		public static final String EZICUBE = "EziCUBE"; /* 이지바로 아이큐브 결의서 */
		public static final String EZERPIU = "EzERPiU"; /* 이지바로 아이유 결의서 */
		public static final String ANGUI = "ANGUI"; /* iCUBE 국고보조통합시스템 연계 결의서 */
		public static final String ANGUU = "ANGUU"; /* ERPiU 국고보조통합시스템 연계 결의서 */
		public static final String EXNPCONI = "EXNPCONI"; /* G20 품의서 */
		public static final String EXNPCONU = "EXNPCONU"; /* 원인행위 품의서 */
		public static final String EXNPRESI = "EXNPRESI"; /* G20 결의서 */
		public static final String EXNPRESU = "EXNPRESU"; /* 원인행위 결의서 */

        /* 출장 복명 외부시스템 연동 코드 */
		public static final String TRIPCONS = "TRIPCONS"; /* 비영리 회계 - 출장복명 2.0 품의서 */
		public static final String TRIPRES = "TRIPRES"; /* /* 비영리 회계 - 출장복명 2.0 품의서 */

        /* base name def */
		public static final String EXPPATHSEQ = "1400"; /* 지출결의 pathSeq */
		public static final String EXCELPATH = "temp/excel"; /* 엑셀 다운로드 임시 보 */
		public static final String EXPENDSEQ = "expendSeq";
		public static final String LISTSEQ = "listSeq";
		public static final String SLIPSEQ = "slipSeq";
		public static final String MNGSEQ = "mngSeq";
		public static final String ID = "id";
		public static final String GROUPSEQ = "groupSeq";
		public static final String COMPSEQ = "compSeq";
		public static final String COMPNAME = "compName";
		public static final String ERPCOMPSEQ = "erpCompSeq";
		public static final String ERPCOMPNAME = "erpCompName";
		public static final String BIZSEQ = "bizSeq";
		public static final String BIZNAME = "bizName";
		public static final String ERPBIZSEQ = "erpBizSeq";
		public static final String ERPBIZNAME = "erpBizName";
		public static final String DEPTSEQ = "deptSeq";
		public static final String DEPTNAME = "deptName";
		public static final String ERPDEPTSEQ = "erpDeptSeq";
		public static final String ERPDEPTNAME = "erpDeptName";
		public static final String EMPSEQ = "empSeq";
		public static final String EMPNAME = "empName";
		public static final String ERPEMPSEQ = "erpEmpSeq";
		public static final String ERPEMPNAME = "erpEmpName";
		public static final String ERPPCSEQ = "erpPcSeq";
		public static final String ERPPCNAME = "erpPcName";
		public static final String ERPCCSEQ = "erpCcSeq";
		public static final String ERPCCNAME = "erpCcName";
		public static final String LANGCODE = "langCode";
		public static final String USERSE = "userSe";
		public static final String FORMSEQ = "formSeq";
		public static final String EXDOCSEQ = "exDocSeq";
		public static final String DOCSEQ = "docSeq";
		public static final String DOCNO = "docNo";
		public static final String APPROKEY = "approKey";
		public static final String FORMTP = "formTp";
		public static final String FORMDTP = "formDTp";
		public static final String PROCESSID = "processId";
		public static final String DOCID = "docId";
		public static final String DOCSTS = "docSts";
		public static final String DOCTITLE = "docTitle";
		public static final String DOCCONTENT = "docContent";
		public static final String INTERLOCKURL = "interlockUrl";
		public static final String INTERLOCKNAME = "interlockName";
		public static final String USEYN = "useYN";
		public static final String FROMDATE = "fromDate";
		public static final String TODATE = "toDate";
		public static final String EMPTYSTR = "";
		public static final String EMPTYSEQ = "0";
		public static final String EMPTYNO = "N";
		public static final String EMPTYYES = "Y";
        /* common code labeling */
		public static final String CODETYPE = "codeType";
		/*
		public static final String Acct = "Acct";
		public static final String Auth = "Auth";
		public static final String BgAcct = "BgAcct";
		public static final String Bizplan = "Bizplan";
		public static final String Budget = "Budget";
		public static final String Card = "Card";
		public static final String Cc = "Cc";
		public static final String Emp = "Emp";
		public static final String ErpAuth = "ErpAuth";
		public static final String Notax = "Notax";
		public static final String Partner = "Partner";
		public static final String Pc = "Pc";
		public static final String Project = "Project";
		public static final String Summary = "Summary";
		public static final String Va = "Va";
		public static final String VatType = "VatType";
		*/
		public static final String ACCT = "ACCT";
		public static final String AUTH = "AUTH";
		public static final String BGACCT = "BGACCT";
		public static final String BIZPLAN = "BIZPLAN";
		public static final String BUDGET = "BUDGET";
		public static final String CARD = "CARD";
		public static final String CC = "CC";
		public static final String EMP = "EMP";
		public static final String DEPT = "DEPT";
		public static final String EMPONE = "EMPONE";
		public static final String ERPAUTH = "ERPAUTH";
		public static final String NOTAX = "NOTAX";
		public static final String PARTNER = "PARTNER";
		public static final String PC = "PC";
		public static final String PROJECT = "PROJECT";
		public static final String SUMMARY = "SUMMARY";
		public static final String BIZ = "BIZ";
		public static final String VA = "VA";
		public static final String VATTYPE = "VATTYPE";
		public static final String REGNOPARTNER = "REGNOPARTNER";
		public static final String EXCHANGEUNIT = "EXCHANGEUNIT";
		public static final String BUDDEPT = "BUDDEPT";
        /* base code */
		public static final String BIZBOXCOMP = "Comp";
		public static final String BIZBOXFORM = "Form";
		public static final String BIZBOXPOSITION = "Position";
		public static final String BIZBOXGRADE = "Grade";
		public static final String BIZBOXCODE = "CommonCode";
        /* ex code */
		public static final String SENDYN = "ex00015";
		public static final String DRCRTYPE = "ex00017";
		public static final String MNGMAPTYPE = "ex00018";
		public static final String SUMMARYTYPE = "ex00002"; /* 표준적요구분 */
		public static final String SUMMARYSEARCHTYPE = "ex00003"; /* 검색조건(표준적요)구분 */
        /* ea code */
		public static final String DOCSTATUS = "ea0015";
        /* ez code */
		public static final String SEQ = "seq";
        /* 지출결의 매입전자세금계산서 최근 죄회 건수 설정 */
		public static final int ETAXDEAFAULTCOUNT = 100;
		public static final String SEARCHSTR = "searchStr";

        /* np code */
		public static final String CONSDOCSEQ = "consDocSeq";
		public static final String RESDOCSEQ = "resDocSeq";
		public static final String CANBGT = "canBgt";
		public static final String EXCEED = "EXCEED";
		public static final String EXPENDDT = "expendDt";
		public static final String TRIPCONSDOCSEQ = "tripConsDocSeq";
		public static final String TRIPRESDOCSEQ = "tripResDocSeq";

        /* database type */
		public static final String MSSQL = "mssql";
		public static final String ORACLE = "oracle";

        // 20180910 soyoung, interlockName 이전단계 영문/일문/중문 추가
		public static final String INTERLOCKNAMEEN = "interlockNameEn";
		public static final String INTERLOCKNAMEJP = "interlockNameJp";
		public static final String INTERLOCKNAMECN = "interlockNameCn";

        // setting.do Page이동
		public static final String BPSUCCESS = "BPSUCCESS";
		public static final String BPPWD = "bpadmin@1234";

		public static final String MODULECODENP = "EXNP";
		public static final String MODULECODEEXP = "EXP";
    }

    /* 공통코드 키 */
    //public interface commonCodeKey {
	public final class commonCodeKey {

		public static final String USEYN = "ex00001"; /* [ 사용 / 미사용 ] */
		public static final String YESORNO = "ex00004";/* [예 / 아니오] */
		public static final String SETORNOTSET = "ex00033";/* [설정 / 미설정] */
    }

    /* iCUBE 공통코드 키 */
    //public interface commonCodeIKey {
	public final class commonCodeIKey {
    }

    /* ERPiU 공통코드 키 */
    //public interface commonCodeUKey {
	public final class commonCodeUKey {

		public static final String TERMTYPE = "FI_N000002"; /* 기간구분 */
		public static final String ACCTLEVELTYPE = "FI_B000040"; /* 계정레벨 */
		public static final String EXECUTETYPE = "FI_P000008"; /* 집행구분 */
		public static final String MODULPARENT = "FI";
		public static final String DEPTPOP = "P_MA_DEPT_SUB1";
		public static final String BUDGETDEPTPOP = "P_FI_BGCODE_DEPT_SUB1";
		public static final String BIZPLANPOP = "P_FI_BIZCODEJO2_SUB1_BIZPLAN";
    }

    /* 회계모듈 테이블 */
    //public static interface commonTbl {
	public final class commonTbl {

		public static final String ANBOJO = "TExAnbojo";
		public static final String ANBOJOPAY = "TExAnbojoAbdocuPay";
    }

}
