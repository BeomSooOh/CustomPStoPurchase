package common.vo.common;

public class CommonMapInterface {

    public static final class ExPath {
        /* iCUBE */
        public final class iCUBE {
            // 나의 지출결의 현황
            // /ex/user/report/ExApprovalList.do
        	public static final String MYEXPENDREPORT = "/expend/ex/user/content/UserReportExpendList";
            
            // 나의 지출결의 상세 현황
            // /ex/user/report/ExExpendSlipReport.do
        	public static final String MYEXPENDSLIPREPORT = "/expend/ex/user/content/UserSlipReportExpendList";
            
            // 나의 카드 사용 현황
            // /ex/user/report/ExUseCardlList.do
        	public static final String MYCARDREPORT = "/expend/ex/user/content/UserCardReport";

            // 나의 세금계산서 현황(iCUBE)
            // /ex/user/report/ExUserETaxiCUBEList.do
        	public static final String MYETAXREPORT = "/expend/ex/user/content/UserETaxReportiCUBE";

            // 나의 예실대비 현황(iCUBE)
            // /ex/user/yesil/ExUserYesilReport.do
        	public static final String MYBUDGETREPORT = "/expend/ex/user/content/UserYesilReport";

            // 지출결의 확인
            // /ex/admin/report/ExApprovalSendList.do
        	public static final String ADMINEXPENDCONFIRMREPORT = "/expend/ex/admin/content/AdminExpendManagerReport";

            // 지출결의 확인(권한별)
            // /ex/admin/report/ExFormAuthApprovalSendList.do
        	public static final String ADMINEXPENDAUTHREPORT = "/expend/ex/admin/content/AdminExpendManagerReport";

            // 지출결의 상세현황
            // /ex/admin/report/ExApprovalSlipList.do
        	public static final String ADMINEXPENDDETAILREPORT = "/expend/ex/admin/content/AdminSlipReportExpendList";

            // 지출결의 현황
            // /ex/admin/report/ExApprovalList.do
        	public static final String ADMINEXPENDREPORT = "/expend/ex/admin/content/AdminReportExpendList";

            // 카드 사용 현황
            // /ex/admin/report/ExUseCardlList.do
        	public static final String ADMINCARDREPORT = "/expend/ex/admin/content/AdminCardReport";

            // iCUBE 연동문서 현황
            // /ex/admin/report/ExiCUBEDocListReport.do
        	public static final String ADMINICUBELINKREPORT = "/expend/ex/admin/content/AdminiCUBEDocListReport";

            // 세금계산서 현황(iCUBE)
            // /ex/admin/report/ExAdminETaxlListiCUBE.do
        	public static final String ADMINETAXREPORT = "/expend/ex/admin/content/AdminETaxReportiCUBE";

            // 예실대비현황(iCUBE)
            // /ex/admin/yesil/ExAdminYesilReport.do
        	public static final String ADMINBUDGETREPORT = "/expend/ex/admin/content/AdminYesilReport";
        }

        /* ERPiU */
        public final class ERPiU {
            // 나의 지출결의 현황
            // /ex/user/report/ExApprovalList.do
        	public static final String MYEXPENDREPORT = "/expend/ex/user/content/UserReportExpendList";
            
            // 나의 지출결의 상세 현황
            // /ex/user/report/ExExpendSlipReport.do
        	public static final String MYEXPENDSLIPREPORT = "/expend/ex/user/content/UserSlipReportExpendList";

            // 나의 카드 사용 현황
            // /ex/user/report/ExUseCardlList.do
        	public static final String MYCARDREPORT = "/expend/ex/user/content/UserCardReport";

            // 나의 세금계산서 현황(ERPiU)
            // /ex/user/report/ExUserETaxERPiUList.do
        	public static final String MYETAXREPORT = "/expend/ex/user/content/UserETaxReportERPiU";

            // 나의 예실대비 현황(ERPiU)
            // /ex/user/yesil/ExUserYesil2Report.do
        	public static final String MYBUDGETREPORT = "/expend/ex/user/content/UserYesil2Report";
            
            // 나의 예실대비 현황 2.0(ERPiU)
            // /ex/user/yesil/ExUserERPiUYesilReport.do
        	public static final String MYERPIUBUDGETREPORT = "/expend/ex/user/content/UserExERPiUYesil";

            // 지출결의 확인
            // /ex/admin/report/ExApprovalSendList.do
        	public static final String ADMINEXPENDCONFIRMREPORT = "/expend/ex/admin/content/AdminExpendManagerReport";

            // 지출결의 확인(권한별)
            // /ex/admin/report/ExFormAuthApprovalSendList.do
        	public static final String ADMINEXPENDAUTHREPORT = "/expend/ex/admin/content/AdminExpendManagerReport";

            // 지출결의 상세현황
            // /ex/admin/report/ExApprovalSlipList.do
        	public static final String ADMINEXPENDDETAILREPORT = "/expend/ex/admin/content/AdminSlipReportExpendList";

            // 지출결의 현황
            // /ex/admin/report/ExApprovalList.do
        	public static final String ADMINEXPENDREPORT = "/expend/ex/admin/content/AdminReportExpendList";

            // 카드 사용 현황
            // /ex/admin/report/ExUseCardlList.do
        	public static final String ADMINCARDREPORT = "/expend/ex/admin/content/AdminCardReport";

            // 세금계산서현황(ERPiU)
            // /ex/admin/report/ExAdminETaxlListERPiU.do
        	public static final String ADMINETAXREPORT = "/expend/ex/admin/content/AdminETaxReportERPiU";

            // 예실대비현황(ERPiU)
            // /ex/admin/yesil/ExAdminYesil2Report.do
        	public static final String ADMINBUDGETREPORT = "/expend/ex/admin/content/AdminYesil2Report";
            
            // 예실대비현황 2.0 (ERPiU)
            // /ex/admin/yesil/ExAdminERPiUYesilReport.do
        	public static final String ADMINERPIUBUDGETREPORT = "/expend/ex/admin/content/AdminExERPiUYesil";
            
            
        	public static final String ADMINERPIUBUDGETREPORTPOP = "/expend/ex/admin/pop/AdminERPiUYesilExpendDetailInfo";
     
            
        }

        /* Bizbox Alpha */
        public final class Bizbox {
            // 카드 설정
        	public static final String ADMINCARDCONFIG = "";

            // 표준적요 설정
        	public static final String ADMINSUMMARYCONFIG = "";

            // 증빙유형 설정
        	public static final String ADMINAUTHCONFIG = "";

            // 양식 별 표준적요 & 증빙유형 설정
        	public static final String ADMINFORMLINKCONFIG = "";

            // 환경 설정
        	public static final String ADMINCONFIG = "";

            // 항목 설정
        	public static final String ADMINITEMCONFIG = "";

            // 관리항목 설정
        	public static final String ADMINMNGCONFIG = "";

            // 명칭 설정
        	public static final String ADMINLANGCONFIG = "";

            // 버튼 설정
        	public static final String ADMINBUTTONCONFIG = "";

            // 매입전자세금계산서 설정
        	public static final String ADMINETAXAUTHCONFIG = "";

            // 마감설정
        	public static final String ADMINEXPENDENDCONFIG = "";
        }
    }

    public static final class ExNpPath {
        /* iCUBE */
        public final class iCUBE {
            // 나의 카드 사용 현황(비영리 2.0)
            // /expend/np/user/NpUserCardReport.do
        	public static final String MYCARDUSEREPORT = "/expend/np/user/content/UserNPCardReport";

            // 나의 예실대비 현황(비영리 2.0)
            // /expend/np/user/NpUserG20Yesil.do
        	public static final String MYBUDGETREPORT = "/expend/np/user/content/UserNpG20Yesil";

            // 나의 세금계산서 현황(비영리 2.0)
            // /expend/np/user/NpUserEtaxReport.do
        	public static final String MYETAXREPORT = "/expend/np/user/content/UserNPETaxReportiCUBE";

            // 품의서 현황(2.0)
            // /expend/np/user/NpUserConsUserReport.do
        	public static final String MYCONSREPORT = "/expend/np/user/content/UserNPConsReport";

            // 결의서 현황(2.0)
            // /expend/np/user/NpUserResUserReport.do
        	public static final String MYRESREPORT = "/expend/np/user/content/UserNPResReport";

            // 품의서 반환(2.0)
            // /expend/np/user/NpUserConsConfferReturn.do
        	public static final String MYCONSCONFFERRETURN = "/expend/np/user/content/UserNPConsConfferReturn";
        }

        /* ERPiU */
        public final class ERPiU {
            // 나의 카드 사용 현황(비영리 2.0)
            // /expend/np/user/NpUserCardReport.do
        	public static final String MYCARDUSEREPORT = "/expend/np/user/content/UserNPCardReport";

            // 나의 세금계산서 현황(비영리 2.0)
            // /expend/np/user/NpUserEtaxReport.do
        	public static final String MYETAXREPORT = "/expend/np/user/content/UserNPETaxReportERPiU";

            // 품의서 현황(2.0)
            // /expend/np/user/NpUserConsUserReport.do
        	public static final String MYCONSREPORT = "/expend/np/user/content/UserNPConsReport";

            // 결의서 현황(2.0)
            // /expend/np/user/NpUserResUserReport.do
        	public static final String MYRESREPORT = "/expend/np/user/content/UserNPResReport";

            // 품의서 반환(2.0)
            // /expend/np/user/NpUserConsConfferReturn.do
        	public static final String MYCONSCONFFERRETURN = "/expend/np/user/content/UserNPConsConfferReturn";
        }
    }

    /* 출장복명 Path 정의 */
    public final class commonTripPath {

        /* 출장복명 USER PATH */
    	public static final String TRIPUSERCONTENTPATH = "/expend/trip/user/content/";
    	public static final String TRIPUSERPOPPATH = "/expend/trip/user/pop/";
        /* 출장복명 ADMIN PATH */
    	public static final String TRIPADMINCONTENTPATH = "/expend/trip/admin/content/";
    	public static final String TRIPADMINPOPPATH = "/expend/trip/admin/pop/";
        /* 출장복명 User Page */
    	public static final String USERTRIPTRANSSETTING = "UserTripTransSetting";
    	public static final String USERTRIPCONSTESTPAGE = "UserTripConsTestPage";
    	public static final String TRIPUSERCONSPOP = "TripUserConsPop";
    	public static final String TRIPUSERRESPOP = "TripUserResPop";
    	public static final String TRIPUSERCONFFERPOP = "TripUserConfferPop";
    	public static final String USERTESTPAGE = "UserTestPage";
    	public static final String USERTRIPCONSREPORT = "UserTripConsReport";
    	public static final String USERTRIPRESREPORT = "UserTripResReport";
        /* 출장복명 Admin Page */
    	public static final String ADMINTRIPAMTSETTING = "AdminTripAmtSetting";
    	public static final String ADMINTRIPLOCATIONINFO = "tripAreaPop";
    	public static final String ADMINTRIPPOSITIONGROUPINFO = "tripPositionGroupPop";
    	public static final String ADMINTRIPTRANSPORTINFO = "tripTransportPop";
    	public static final String ADMINTRIPTRANSPORTSETTING = "AdminTripTransPortSetting";
    	public static final String ADMINTRIPPOSITIONGROUPSETTING = "AdminTripPositionGroupSetting";
    	public static final String ADMINTRIPLOCATIONSETTING = "AdminTripLocationSetting";
    	public static final String ADMINTRIPCONSREPORT = "AdminTripConsReport";
    	public static final String ADMINTRIPRESREPORT = "AdminTripResReport";
    }

    /* SQL Map Path 정의 */
    public final class sqlMapPath {

        /* CMS */
    	public static final String CMSPATH = "/batch/cms";
        /* 지출결의 */
    	public static final String EXPATH = "/ex";
        /* 이지바로 */
    	public static final String EZPATH = "/ez";
        /* G20 품의서 / 결의서 */
    	public static final String ACPATH = "/ac";
        /* 국고보조금통합관리시스템 연계 */
    	public static final String ANGUPATH = "/angu";
        /* 업무용승용차 */
    	public static final String BIPATH = "/bi";
    }

    /* 개발용 Path 정의 */
    public final class commonDevPath {

        /* module path */
        /* module path - Contents Path */
    	public static final String CONTENTPATH = "/devmanager/content/";
        /* module path - Popup Path */
    	public static final String POPPATH = "/devmanager/pop/";
        /* module path - Contents Path - LangPack */
    	public static final String LANGPACK = "LangPack";
        /* module path - Contents Path - CMS */
    	public static final String CMS = "CMS";
        /* module path - 네비게이터 지원 */
    	public static final String BUILDASSISTDOCU = "BuildAssistDocu";
        /* module path - 비영리 회계 2.0 설치 */
    	public static final String NP20INSTALL = "Np20Install";
        /* module path - 신입 스크립트 연습 */
    	public static final String PRACTICEFORNEWBIE = "practiceForNewbie";
        /* module path - 신입 스크립트 연습 */
    	public static final String PRACTICEFORBEGINNER = "practiceForBeginner";
        /* module path - 신입 스크립트 연습 */
    	public static final String PRACTICEFORJUNIOR = "practiceForJunior";
        /* module path - 신입 스크립트 연습 */
    	public static final String PRACTICEFORMASTER = "practiceForMaster";
        /* module path - 비영리 회계 1.0 참조품의 권한 설정 */
    	public static final String AUTHMANAGERMAIN = "authManagerMain";    
        /* module path - 신입 현황페이지 연습 */
    	public static final String PRACTICEREPORTPAGE = "practiceReportPage";
        
        
    }

    /* 공통 Path 정의 */
    public final class commonPath {

        /* module path */
        /* module path - Contents Path */
    	public static final String CONTENTPATH = "/common/content/";
        /* module path - Popup Path */
    	public static final String POPPATH = "/common/pop/";
        /* module path - Layer Popup Path */
    	public static final String LAYERPATH = "/common/layer/";
        /* module path - Layer Popup Path - Alert */
    	public static final String COMMONALERT = "AlertLayerPop";
        /* module path - Popup Path - FileDownload */
    	public static final String COMMONFILEDOWNLOAD = "FileDownloadPop";
        /* module path - Popup Path - CommonSuiteMigFileDownload */
    	public static final String COMMONSUITEMIGFILEDOWNLOAD = "CommonSuiteMigFileDownload";
        /* module path - Popup Path - FailPop */
    	public static final String PROCESSFAILPOP = "ProcessFailPop";
        /* module path - Popup Path - AttachPop */
    	public static final String APPROVALATTACHPOP = "ApprovalAttachPop";
        /* module path - Popup Path - ListPop */
    	public static final String APPROVALLISTPOP = "ApprovalListPop";
        /* module path - Popup Path - SlipPop */
    	public static final String APPROVALSLIPPOP = "ApprovalSlipPop";
        /* 표준적요 엑셀 업로드 기능 */
    	public static final String SUMMARYEXCELUPLOADPOP = "SummaryExcelUploadPop";
    }

    /* iCUBE G20 품의서 / 결의서 Path 정의 */
    public final class commonAcPath {

        /* module path */
        /* module path - Contents Path */
    	public static final String MASTERCONTENTPATH = "/expend/ac/master/content/";
    	public static final String ADMINCONTENTPATH = "/expend/ac/admin/content/";
    	public static final String USERCONTENTPATH = "/expend/ac/user/content/";
        /* module path - Popup Path */
    	public static final String MASTERPOPPATH = "/expend/ac/master/pop/";
    	public static final String ADMINPOPPATH = "/expend/ac/admin/pop/";
    	public static final String USERPOPPATH = "/expend/ac/user/pop/";
        /* module path - Popup */
        /* module path - Popup - G20(사용자) */
        /* module path - Popup - G20(사용자) - 품의서 */
    	public static final String CONSDOCPOP = "AcConsMasterPop";
        /* module path - Popup - G20(사용자) - 결의서 */
    	public static final String RESDOCPOP = "AcResMasterPop";
        /* module path - Popup - G20(사용자) - 참조품의서 */
    	public static final String REFERCONFERPOP = "AcExReferConferPop";
        /* module path - Popup - G20(사용자) - 법인카드 승인 내역 */
    	public static final String CARDSUNGINPOP = "AcExACardSunginPop";
        /* module path - Popup - G20(사용자) - 일반 명세서 */
    	public static final String GOODSITEMSPOP = "AcExGoodsItemsFormPop";
        /* module path - Popup - G20(사용자) - 여비 명세서 */
    	public static final String TRAVELITEMSPOP = "AcExTravelItemsFormPop";
        /* module path - Popup - G20(사용자) - 급여자료 */
    	public static final String PAYDATAPOP = "AcExPayDataPop";
        /* module path - Popup - G20(사용자) - 공통코드 */
    	public static final String COMMONPOP = "AcCommonCodePop";
    }

    /* 지출결의 Path 정의 */
    public final class commonExPath {

        ////////////////////////////////////////////////// Content
        /* module path */
        /* module path - Contents Path */
    	public static final String CONTENTPATH = "/expend/ex/content/"; /* 지출결의 현황 기본 URL */
    	public static final String MASTERCONTENTPATH = "/expend/ex/master/content/"; /* 지출결의 현황 기본 URL */
    	public static final String ADMINCONTENTPATH = "/expend/ex/admin/content/"; /* 지출결의 현황 기본 URL */
    	public static final String USERCONTENTPATH = "/expend/ex/user/content/"; /* 지출결의 현황 기본 URL */
    	public static final String USERCONTENTPATH2 = "/expend/ex2/user/content/"; /* 지출결의 현황 기본 URL */
    	public static final String ERRORPAGEPATH = "/expend/common/error/"; /* 에러출력 페이지 기본 URL */
    	public static final String NPUSERCONTENTPATH = "/expend/np/user/content/"; /* [비영리]지출결의 현황 기본 URL */
    	public static final String NPADMINCONTENTPATH = "/expend/np/admin/content/"; /* [비영리]지출결의 현황 기본 URL */
        /* module path - Contents */
        ////////////////////////////////////////////////// Content - Master
        ////////////////////////////////////////////////// Content - Admin
        /* module path - Contents - 회계(관리자) */
        /* module path - Contents - 회계(관리자) - 지출결의 관리 */
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 증빙관리 */
    	public static final String ADMINEXPENDAUTH = "AdminAuthSetting";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
    	public static final String ADMINEXPENDMANAGERREPORT = "AdminExpendManagerReport";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 계정과목관리 */
    	public static final String ADMINACCTSETTING = "AdminAcctSetting";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 지출결의 현황 */
    	public static final String ADMINEXPENDREPORT = "AdminReportExpendList";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 지출결의상세 현황 */
    	public static final String ADMINSLIPREPORTEXPENDLIST = "AdminSlipReportExpendList";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - iCUBE 연동문서 현황 */
    	public static final String ADMINICUBEDOCLISTREPORT = "AdminiCUBEDocListReport";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 카드 사용 현황 */
    	public static final String ADMINCARDREPORT = "AdminCardReport";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 증빙관리 */
    	public static final String ADMINEXPENDSUMMARY = "AdminSummarySetting";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 양식 별 표준적요&증빙유형 설정 */
    	public static final String ADMINFORMLINKCODESETTING = "AdminFormLinkCodeSetting";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 양식 별 표준적요&증빙유형 설정 증빙유형 선택 팝업 */
    	public static final String ADMINFORMLINKAUTHPOP = "AdminFormLinkAuthPop";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 양식 별 표준적요&증빙유형 설정 표준적요 선택 팝업 */
    	public static final String ADMINFORMLINKSUMMARYPOP = "AdminFormLinkSummaryPop";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 지출결의 마감 설정 페이지 */
    	public static final String ADIMCLOSEDATESETTING = "AdimCloseDateSetting";
        /* module path - Contents - 회계(관리자) - 지출결의 관리 - 지출결의 마감 설정 페이지 */
    	public static final String ADMINCLOSEDATEPOP = "AdminCloseDatePop";
        ////////////////////////////////////////////////// Content - User
        /* module path - Contents - 회계(사용자) */
        /* module path - Contents - 회계(사용자) - 지출결의 관리 */
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 나의 지출결의 현황 */
        // String UserExpendReport = "UserExpendReport";
    	public static final String USEREXPENDREPORT = "UserReportExpendList";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 나의 카드 사용 현황 */
    	public static final String USERCARDREPORT = "UserCardReport";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 나의 세금계산서 사용 현황(iCUBE) */
    	public static final String USERETAXICUBEREPORT = "UserETaxReportiCUBE";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 나의 세금계산서 사용 현황 (ERPiU) */
    	public static final String USERETAXERPIUREPORT = "UserETaxReportERPiU";
        /* module path - Contents - 회계(사용자) - 지출결의 관리 - 나의 세금계산서 사용 현황 (ERPiU) */
    	public static final String EXETAXTRANSFERHISTORYPOP = "ExETaxTransferHistoryPop";
        ////////////////////////////////////////////////// Popup
        /* module path - Popup Path */
    	public static final String POPPATH = "/expend/ex/pop/"; /* 지출결의 팝업 기본 URL */
    	public static final String MASTERPOPPATH = "/expend/ex/master/pop/"; /* 지출결의 팝업 기본 URL */
    	public static final String ADMINPOPPATH = "/expend/ex/admin/pop/"; /* 지출결의 팝업 기본 URL */
    	public static final String USERPOPPATH = "/expend/ex/user/pop/"; /* 지출결의 팝업 기본 URL */
    	public static final String USERPOPPATH2 = "/expend/ex2/user/pop/"; /* 지출결의 팝업 기본 URL */
    	public static final String NPUSERPOPPATH = "/expend/np/user/pop/"; /* 비영리 품의/결의 팝업 기본 URL */
    	public static final String NPADMINPOPPATH = "/expend/np/admin/pop/"; /* 비영리 품의/결의 관리자 팝업 기본 URL */
        /* module path - Popup */
        ////////////////////////////////////////////////// Popup - User
        /* module path - Popup - 회계(사용자) */
        /* module path - Popup - 회계(사용자) - 지출결의 */
    	public static final String USEREXPENDPOP = "ExExpendMasterPopup";
        /* module path - Popup - 회계(사용자) - 항목 */
    	public static final String USERLISTPOP = "ListPop";
        /* module path - Popup - 회계(사용자) - 분개 */
    	public static final String USERSLIPPOP = "SlipPop";
        /* module path - Popup - 회계(사용자) - 관리항목 */
    	public static final String USERMNGPOP = "UserMngPop";
        /* module path - Popup - 회계(사용자) - 공통코드 */
        /* module path - Popup - 회계(사용자) - 공통코드 - 사용자 */
    	public static final String USEREMPPOP = "EmpPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 회계단위 */
    	public static final String USERPCPOP = "PcPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 코스트센터 */
    	public static final String USERCCPOP = "CcPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 예산단위 */
    	public static final String USERBUDGETPOP = "BudgetPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 사업계획 */
    	public static final String USERBIZPLANPOP = "BizplanPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 예산계정 */
    	public static final String USERBGACCTPOP = "BgAcctPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 프로젝트 */
    	public static final String USERPROJECTPOP = "ProjectPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 거래처 */
    	public static final String USERPARTNERPOP = "PartnerPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 카드 */
    	public static final String USERCARDPOP = "CardPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 차량 */
    	public static final String USERCARPOP = "CarPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 표준적요 */
    	public static final String USERSUMMARYPOP = "SummaryPop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 증빙유형 */
    	public static final String USERAUTHPOP = "SummaryPop";
        /* module path - Popup - 회계(사용자) - 지출결의 - 접대부 비표 */
    	public static final String USERENTERTAINMENTFEEPOP = "UserEntertainmentFeePop";
        /* module path - Popup - 회계(사용자) - 공통코드 - 테스트 페이지 */
    	public static final String USERCMMCODEPOPTESTPAGE = "UserCmmCodePopTestPage";
        /* module path - Popup - 회계(사용자) - 지출결의 - 접대부 비표 페이지 */
    	public static final String USERENTERTAINMENTFEETESTPAGE = "UserEntertainmentFeeTestPage";
        /* module path - Popup - 회계(사용자,관리자) - 공통 레이어 - 작업 실패사요 */
    	public static final String CMMFAILPOPTESTPAGE = "CmmFailPopTestPage";
        /* module path - Popup - 회계(사용자,관리자) - 명칭설정 테스트 페이지 */
    	public static final String CUSTOMLABELTESTPAGE = "CustomLabelTestPage";
        /* module path - Popup - 회계(사용자) - 공통코드 - 공통팝업 */
    	public static final String USERCMMCODEPOP = "UserCmmCodePop";
        /* module path - Popup - 회계(사용자) - 카드사용내역 - 테스트 페이지 */
    	public static final String USERCARDUSAGEHISTORYPOPTESTPAGE = "UserCardUsageHistoryPopTestPage";
        /* module path - Popup - 회계(사용자) - 지출결의 - 카드사용내역 */
    	public static final String USERCARDUSAGEHISTORYPOP = "UserCardUsageHistoryPop";
        /* module path - Popup - 회계(사용자) - 지출결의 - 카드사용내역 - 카드정보 도움창 */
    	public static final String USERCARDINFOHELPPOP = "UserCardInfoHelpPop";
        /* module path - Popup - 회계(사용자) - 지출결의 - 카드사용 상세 내역 */
    	public static final String EXCARDDETAILINFOPOP = "ExCardDetailInfoPop";
        /* module path - Contents - 회계(사용자) - 예실대비현황 - 샘플 페이지 */
    	public static final String USERYESILSAMPLEPAGE = "UserYesilSamplePage";
        /* module path - Popup - 지출결의 - 항목관리 - 테스트 페이지 */
    	public static final String USERMNGPOPTESTPAGE = "UserMngPopTestPage";
        /* module path - Popup - 지출결의 - 인터락 URL - 테스트 페이지 */
    	public static final String USERINTERLOCKURLTESTPAGE = "UserInterlockUrlTestPage";
        /* module path - Popup - 지출결의 - 버튼설정 적용 - 테스트 페이지 */
    	public static final String USERBUTTONSETTINGTESTPAGE = "UserButtonSettingTestPage";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 항목 설정 */
    	public static final String ADMINITEMSETTING = "AdminExItemSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 관리 항목 설정 */
    	public static final String ADMINMNGDEFSETTING = "AdminExMngDefSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 환경설정 */
    	public static final String ADMINEXPENDSETTING = "AdminExExpendSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 법인카드 설정 */
    	public static final String ADMINCARDSETTING = "AdminCardSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 법인카드 설정(비영리) */
    	public static final String ADMINNPCARDSETTING = "AdminNpCardSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 증빙유형 설정 */
    	public static final String MASTERAUTHSETTING = "MasterAuthSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 표준적요 설정 */
    	public static final String MASTERSUMMARYSETTING = "MasterSummarySetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 계정과목 설정 */
    	public static final String MASTERACCTSETTING = "MasterAcctSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 버튼 설정 */
    	public static final String ADMINBUTTONSETTING = "AdminButtonSetting";
        /* module path - Contents 관리자 - 회계 - 지출결의 설정 - 명칭 설정 */
    	public static final String ADMINLABELSETTING = "AdminLabelSetting";
        /* module path - Contents - 회계(사용자) - 예실대비현황조회 */
    	public static final String USERYESILREPORT = "UserYesilReport";
        /* module path - Contents - 회계(관리자) - 예실대비현황조회 */
    	public static final String ADMINYESILREPORT = "AdminYesilReport";
        /* module path - Popup - 회계(관리자) - 예실대비현황조회 - 팝업 */
    	public static final String ADMINYESILPOP = "AdminYesilPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황조회 지출결의현황 - 팝업 */
    	public static final String ADMINYESILDETAILPOP = "AdminYesilDetailPop";
        /* module path - Popup - 회계(사용자) - 예실대비현황조회 - 팝업 */
    	public static final String USERYESILPOP = "UserYesilPop";
        /* module path - Contents - 회계(관리자) - 예실대비현황2조회 */
    	public static final String ADMINYESIL2REPORT = "AdminYesil2Report";
        /* module path - Contents - 회계(사용자) - 예실대비현황2조회 */
    	public static final String USERYESIL2REPORT = "UserYesil2Report";
     
        /* module path - Contents - 회계(관리자) - 예실대비현황 ERP iU 2.0조회 */
    	public static final String ADMINEXERPIUYESIL = "AdminExERPiUYesil";
        /* module path - Contents - 회계(사용자) - 예실대비현황 ERP iU 2.0조회 */
    	public static final String USEREXERPIUYESIL = "UserExERPiUYesil";
       
    	public static final String ADMINERPIUYESILEXPENDDETAILINFO = "AdminERPiUYesilExpendDetailInfo";
        
        /* module path - Popup - 회계(관리자) - 예실대비현황2 지출결의현황 조회 - 팝업 */
    	public static final String ADMINYESIL2DETAILPOP = "AdminYesil2DetailPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황2 결의부서조회 - 팝업 */
    	public static final String ADMINYESIL2DEPTPOP = "AdminYesil2DeptPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황2 예산단위그룹 - 팝업 */
    	public static final String ADMINYESIL2BUDGETGRPOP = "AdminYesil2BudgetGrPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황2 예산단위 - 팝업 */
    	public static final String ADMINYESIL2BUDGETDEPTPOP = "AdminYesil2BudgetDeptPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황2 사업계획 - 팝업 */
    	public static final String ADMINYESIL2BIZPLANPOP = "AdminYesil2BizPlanPop";
        /* module path - Popup - 회계(관리자) - 예실대비현황2 예산계정 - 팝업 */
    	public static final String ADMINYESIL2BUDGETACCTPOP = "AdminYesil2BudgetAcctPop";
        /* module path - Popup - 회계(사용자) - 예실대비현황2 예산단위그룹 - 팝업 */
    	public static final String USERYESIL2BUDGETGRPOP = "UserYesil2BudgetGrPop";
        /* module path - Popup - 회계(사용자) - 예실대비현황2 예산단위 - 팝업 */
    	public static final String USERYESIL2BUDGETDEPTPOP = "UserYesil2BudgetDeptPop";
        /* module path - Popup - 회계(사용자) - 예실대비현황2 사업계획 - 팝업 */
    	public static final String USERYESIL2BIZPLANPOP = "UserYesil2BizPlanPop";
        /* module path - Popup - 회계(사용자) - 예실대비현황2 예산계정 - 팝업 */
    	public static final String USERYESIL2BUDGETACCTPOP = "UserYesil2BudgetAcctPop";
        /* 공통 에러 출력 페이지 */
    	public static final String CMERROR = "cmError";
        /* 권한 에러 출력 페이지 */
    	public static final String CMERRORCHECKAUTH = "cmErrorCheckAuth";
        /* 로그인 세션 에러 출력 페이지 */
    	public static final String CMERRORCHECKLOGIN = "cmErrorCheckLogin";
        /* 전자결재 양식설정 에러 출력 페이지 */
    	public static final String CMERRORCHECKDOCSETTING = "cmErrorCheckDocSetting";
        /* ERP 정보 에러 출력 페이지 */
    	public static final String CMERRORCHECKERP = "cmErrorCheckERP";
        /* ERP iCUBE G20 설정 에러 출력 페이지 */
    	public static final String CMERRORCHECKICUBEG20TYPE = "cmErrorCheckICUBEG20Type";
        /* ERP 사번 매핑 미진행 접근 */
    	public static final String CMERRORCHECKERPEMPCDMAPPING = "cmErrorCheckErpEmpCdMapping";
        /* ERP 연동 정보 오류 접근 */
    	public static final String CMERRORCHECKERPSETTING = "cmErrorCheckErpSetting";
        /* 지출결의 가져오기 팝업 */
    	public static final String EXPENDHISTORYPOP = "ExExpendHistoryPopup";
        /* iCUBE 매입전자세금계산서 현황 페이지 */
    	public static final String ADMINICUBEETAXREPORT = "AdminETaxReportiCUBE";
        /* iCUBE 매입전자세금계산서 현황 페이지 */
    	public static final String ADMINERPIUETAXREPORT = "AdminETaxReportERPiU";
        /* NP 매입전자세금계산서 현황 페이지 */
    	public static final String ADMINNPETAXREPORTERPIU = "AdminNPETaxReportERPiU";
    	public static final String ADMINNPETAXREPORTICUBE = "AdminNPETaxReportiCUBE";
        /* 세금계산서 권한 설정 페이지 */
    	public static final String ADMINETAXAUTHSETTING = "AdminETaxAuthSetting";
        /* 카드 검색조건 카드 조회 팝업 */
    	public static final String EXSEARCHCARDLISTPOP = "ExSearchCardListPop";
        /*****************************************************************
         * [ 비영리 ] 컨텐트 경로
         */
        /*
         * [ 비영리 ] 상태 코드 확인 페이지
         */
    	public static final String USERCONSRESTESTPAGE = "UserConsResTestPage";
    	public static final String USERSTATTASTPAGE = "UserStatTastPage";
    	public static final String USERCODETESTPAGE = "UserCodeTestPage";
    	public static final String USERCODEPOPTESTPAGE = "UserCodePopTestPage";
    	public static final String USERBUDGETBALANCETESTPAGE = "UserBudgetBalanceTestPage";
    	public static final String USERPROCEDURETESTPAGE = "UserProcedureTestPage";
    	public static final String USERCARDDETAILPOPTESTPAGE = "UserCardDetailPopTestPage";
    	public static final String USERETAXDETAILPOPTESTPAGE = "UserETaxDetailPopTestPage";
    	public static final String USERAPITESTPAGE = "UserAPITestPage";
        /*
         * [ 비영리 ] 지출결의 옵션 페이지
         */
    	public static final String ADMINNPEXPENDSETTING = "AdminNPExpendSetting";
    	public static final String ADMINNPMASTEROPTION = "AdminNPMasterOption";
    	public static final String ADMINNPFORMOPTION = "AdminNPFormOption";
    	public static final String ADMINNPFORMSETTING = "AdminNPFormSetting";
    	public static final String NPADMINCONSCONFFERRETURN = "NpAdminConsConfferReturn";
        /*
         * [ 비영리 ] 지출결의 현황 페이지
         */
    	public static final String ADMINRESSENDLIST = "AdminResSendList";
    	public static final String ADMINNPCARDREPORT = "AdminNPCardReport";
    	public static final String ADMINNPCONSREPORT = "AdminNPConsReport";
    	public static final String ADMINNPRESREPORT = "AdminNPResReport";
    	public static final String USERNPCARDREPORT = "UserNPCardReport";
    	public static final String USERNPCONSREPORT = "UserNPConsReport";
    	public static final String USERNPCONSCONFFERRETURN = "UserNPConsConfferReturn";
    	public static final String USERNPRESREPORT = "UserNPResReport";
    	public static final String USERNPETAXREPORTERPIU = "UserNPETaxReportERPiU";
    	public static final String USERNPETAXREPORTICUBE = "UserNPETaxReportiCUBE";
        /*
         * [ 비영리 ] 지출결의 G20 예실대비 현황
         */
    	public static final String USERNPG20YESIL = "UserNpG20Yesil";
    	public static final String ADMINNPG20YESIL = "AdminNpG20Yesil";
    	public static final String USERNPERPIUYESIL = "UserNpERPiUYesil";
    	public static final String ADMINNPERPIUYESIL = "AdminNpERPiUYesil";
    	public static final String ADMINYESILCONSAMTDETAILINFO = "AdminYesilConsAmtDetailInfo";
    	public static final String ADMINYESILRESAMTDETAILINFO = "AdminYesilResAmtDetailInfo";
    	public static final String ADMINYESILERPRESAMTDETAILINFO = "AdminYesilERPResAmtDetailInfo";
    	public static final String ADMINERPIUYESILCONSAMTDETAILINFO = "AdminERPiUYesilConsAmtDetailInfo";
    	public static final String ADMINERPIUYESILRESAMTDETAILINFO = "AdminERPiUYesilResAmtDetailInfo";
        /*
         * [ 비영리 ] 팝업 경로
         */
    	public static final String USERCONSPOP = "UserConsPop";
    	public static final String USERRESPOP = "UserResPop";
    	public static final String NUSERCONSPOP = "NUserConsPop";
    	public static final String NUSERRESPOP = "NUserResPop";
    	public static final String USERCOMMONCODEPOP = "UserCommonCodePop";
    	public static final String USERCONFFERPOP = "UserConfferPop";
    	public static final String USERCARDHISTORYPOP = "UserCardHistoryPop";
    	public static final String USERETAXHISTORYPOP = "UserETaxHistoryPop";
    	public static final String USERCARDTRANSHISTORYPOP = "UserCardTransHistoryPop";
    	public static final String USERETAXTRANSHISTORYPOP = "UserETaxTransHistoryPop";
    	public static final String USERCARDDETAILPOP = "UserCardDetailPop";
    	public static final String USERETAXDETAILPOPI = "UserETaxDetailPopI";
    	public static final String USERETAXDETAILPOPU = "UserETaxDetailPopU";
    	public static final String USERCONSREUSEPOP = "UserConsReUsePop";
    	public static final String USERRESREUSEPOP = "UserResReUsePop";
    	public static final String USERBRINGFAVORITESRESPOP = "UserBringFavoritesResPop";
    	public static final String USERBRINGFAVORITESCONSPOP = "UserBringFavoritesConsPop";
    	public static final String USERITEMSPECPOP = "UserItemSpecPop";
        
    	public static final String ADMINETAXTRANSHISTORYPOP = "AdminETaxTransHistoryPop";
    	public static final String ADMINCARDTRANSHISTORYPOP = "AdminCardTransHistoryPop";
        /******************************************************************/
    }

    /* 지출결의 리뉴얼 */
    public static final class Ex2Path {

        /* 기본 경로 */
    	public static final String ADMINCONTENT = "/expend/ex2/admin/content/";
    	public static final String USERCONTENT = "/expend/ex2/user/content/";
    	public static final String ADMINPOPUP = "/expend/ex2/admin/popup/";
    	public static final String USERPOPUP = "/expend/ex2/user/popup/";
        /* 표준적요 설정 */
    	public static final String CONFIGSUMMARY = "Ex2ConfigSummary";
        /* 증빙유형 설정 */
    	public static final String CONFIGAUTH = "Ex2ConfigAuth";
    }

    /* 국고보조금통합시스템 연계 Path 정의 */
    public final class commonAnguPath {

        /* module path */
        /* module path - Contents Path */
    	public static final String MASTERCONTENTPATH = "/expend/angu/master/content/";
    	public static final String ADMINCONTENTPATH = "/expend/angu/admin/content/";
    	public static final String USERCONTENTPATH = "/expend/angu/user/content/";
        /* module path - Popup Path */
    	public static final String MASTERPOPPATH = "/expend/angu/master/pop/";
    	public static final String ADMINPOPPATH = "/expend/angu/admin/pop/";
    	public static final String USERPOPPATH = "/expend/angu/user/pop/";
        /* module path - Popup */
        /* module path - Popup - 국고보조집행결의서 */
    	public static final String ANGUMASTERPOP = "AnguMasterPop";
        /* module path - Popup - 국고보조집행결의서 - 인력정보 등록 */
    	public static final String ANGUEMPPOP = "AnguEmpPop";
        /* module path - Popup - 국고보조집행결의서 - 예산과목 코드도움 */
    	public static final String ANGUBUDGETLISTPOP = "AnguBudgetListPop";
        /* module path - Popup - 국고보조 공통코드 */
    	public static final String ANGUCOMMONCODEPOP = "AnguCommonCodePop";
        /* module path - Popup - 국고보조 전자세금계산서 */
    	public static final String ANGUETAXPOP = "AnguETaxPop";
        /* module path - Popup - 국고보조 카드거래내역 */
    	public static final String ANGUCARDPOP = "AnguCardPop";
        /* module path - Popup - 국고보조 급여자료 */
    	public static final String ANGUEMPPAYPOP = "AnguEmpPayPop";
        /* module path - Popup - 국고보조 기타소득자 */
    	public static final String ANGUETCPAYPOP = "AnguEtcPayPop";
        /* module path - Popup - 국고보조 사업소득자 */
    	public static final String ANGUCOMPPAYPOP = "AnguCompPayPop";
        /* module path - Popup - 국고보조 소득 정보 */
    	public static final String ANGUPAYMENTPOP = "AnguPaymentPop";
    }

    /* 업무용승용차 Path 정의 */
    public final class commonBiPath {

        /* module path */
        /* module path - Contents Path */
    	public static final String MASTERCONTENTPATH = "/expend/bi/master/content/";
    	public static final String ADMINCONTENTPATH = "/expend/bi/admin/content/";
    	public static final String USERCONTENTPATH = "/expend/bi/user/content/";
    	public static final String ERRORPAGEPATH = "/expend/common/error/"; /* 에러출력 페이지 기본 URL */
        /* module path - Popup Path */
    	public static final String MASTERPOPPATH = "/expend/bi/master/pop/";
    	public static final String ADMINPOPPATH = "/expend/bi/admin/pop/";
    	public static final String USERPOPPATH = "/expend/bi/user/pop/";
        /* 공통 에러 출력 페이지 */
    	public static final String CMERROR = "cmError";
        /* 권한 에러 출력 페이지 */
    	public static final String CMERRORCHECKAUTH = "cmErrorCheckAuth";
        /* 로그인 세션 에러 출력 페이지 */
    	public static final String CMERRORCHECKLOGIN = "cmErrorCheckLogin";
        /* ERP 정보 에러 출력 페이지 */
    	public static final String CMERRORCHECKERP = "cmErrorCheckERP";
        /* module path - Content - 차량공개범위 관리 */
    	public static final String ADMINCARPUBLIC = "AdminCarPublic";
        /* module path - Content - 사용자 운행기록부 */
    	public static final String USERCARPERSON = "UserCarPerson";
    	public static final String USERCARSELECTPOP = "UserCarSelectPop";
    }

    /* 전자결재 연동 API URL */
    public final class commonEaApi {

    	public static final String DOCMAKE = "/ea/interface/eadocmake.do";
    }
}
