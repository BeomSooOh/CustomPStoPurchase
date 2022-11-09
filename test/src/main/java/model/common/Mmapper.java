package model.common;

import common.helper.logger.ExpInfo;

public final class Mmapper {
    /* ==================================================================================================== */
    /* ExPath - iCUBE - User */
    /* ==================================================================================================== */
    // 나의 지출결의 현황
    private static String EXIUserExpendReport = "/expend/ex/user/content/UserReportExpendList";
    // 나의 지출결의 상세 현황
    private static String EXIUserExpendSlipReport = "/expend/ex/user/content/UserSlipReportExpendList";
    // 나의 카드 사용 현황
    private static String EXIUserCardReport = "/expend/ex/user/content/UserCardReport";
    // 나의 세금계산서 현황(iCUBE)
    private static String EXIUserEtaxReport = "/expend/ex/user/content/UserETaxReportiCUBE";
    // 나의 예실대비 현황(iCUBE)
    private static String EXIUserBudgetReport = "/expend/ex/user/content/UserYesilReport";

    /* Getter --------------------------------------------------------------------------------------------- */
    /**
     * 메뉴 : 나의 지출결의 현황 <br>
     * 호출 : /ex/user/report/ExApprovalList.do <br>
     * 반환 : UserReportExpendList.jsp
     *
     * <pre>
    * # 로그인 사용자의 지출결의 상신 내역을 확인할 수 있는 메뉴
    *   - 전자결재 문서를 기준으로 임시보관, 상신, 진행, 종결, 반려 문서 목록 확인
    *   - 목록 엑셀다운로드 지원
     * </pre>
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 2019. 073. 17. 김상겸 : 검색조건 위치 조정 및 추가 ( UCAIMP-957 )
     *     * 요청 고객 : 중앙에너비스
     *     * 기안일자 디폴트 값 변경 ( 기존 : 2018-10-01 ~ 2018-11-28 > 변경 : 2018-10-28 ~ 2018-11-28 )
     *     * 제목 검색 상단으로 위치 변경
     *     * 지급요청일 검색조건 추가 ( Default 일자 미선택 상태 )
     *     * 관리항목 검색불가 안내문구 추가
     *     * 상세검색 영역 검색조건 순서 및 정렬
     * </pre>
     */
    public static String GetEXIUserExpendReport() {
        return EXIUserExpendReport;
    }

    /**
     * 메뉴 : 나의 지출결의 상세 현황<br>
     * 호출 : /ex/user/report/ExUseCardlList.do <br>
     * 반환 : UserCardReport.jsp
     *
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 이준성  나의 지출결의 상세 현황 개발
     * </pre>
     */
    public static String GetEXIUserExpendSlipReport() {
        return EXIUserExpendSlipReport;
    }

    /**
     * 메뉴 : 나의 카드 사용 현황<br>
     * 호출 : /ex/user/report/ExUseCardlList.do <br>
     * 반환 : UserCardReport.jsp
     *
     * <pre>
     * # 로그인 사용자의 권한에 따른 카드 사용 내역을 확인할 수 있는 메뉴
     *   - CMS 또는 VAN 을 통하여 수신된 카드 사용내역 중, 법인카드 공개범위에 포함된 카듸의 내역만 목록 확인
     *   - 목록 엑셀 다운로드 지원
     * </pre>
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIUserCardReport() {
        return EXIUserCardReport;
    }

    /**
     * 메뉴 : 나의 세금계산서 현황(iCUBE)<br>
     * 기능 : 로그인 사용자의 권한에 따른 세금계산서 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/user/report/ExUserETaxiCUBEList.do <br>
     * 반환 : UserETaxReportiCUBE.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIUserEtaxReport() {
        return EXIUserEtaxReport;
    }

    /**
     * 메뉴 : 나의 예실대비 현황(iCUBE)<br>
     * 기능 : 로그인 사용자의 권한에 따른 예실대비 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/user/yesil/ExUserYesilReport.do <br>
     * 반환 : UserYesilReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIUserBudgetReport() {
        return EXIUserBudgetReport;
    }

    /* ==================================================================================================== */
    /* ExPath - iCUBE - Admin */
    /* ==================================================================================================== */
    // 지출결의 확인
    private static String EXIAdminExpendConfirmReport = "/expend/ex/admin/content/AdminExpendManagerReport";
    // 지출결의 상세현황
    private static String EXIAdminExpendDetailReport = "/expend/ex/admin/content/AdminSlipReportExpendList";
    // 지출결의 현황
    private static String EXIAdminExpendReport = "/expend/ex/admin/content/AdminReportExpendList";
    // 카드 사용 현황
    private static String EXIAdminCardReport = "/expend/ex/admin/content/AdminCardReport";
    // iCUBE 연동문서 현황
    private static String EXIAdminiCUBELinkReport = "/expend/ex/admin/content/AdminiCUBEDocListReport";
    // 세금계산서 현황
    private static String EXIAdminEtaxReport = "/expend/ex/admin/content/AdminETaxReportiCUBE";
    // 예실대비현황(iCUBE)
    private static String EXIAdminBudgetReport = "/expend/ex/admin/content/AdminYesilReport";

    /* Getter --------------------------------------------------------------------------------------------- */
    /**
     * 메뉴 : 지출결의 확인<br>
     * 기능 : 관리자가 종결된 지출결의 문서를 ERP 자동전표로 전송할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExFormAuthApprovalSendList.do <br>
     * 반환 : AdminExpendManagerReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminExpendConfirmReport() {
        return EXIAdminExpendConfirmReport;
    }

    /**
     * 메뉴 : 지출결의 상세현황<br>
     * 기능 : 관리자가 지출결의 문서의 분개정보 단위로 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExApprovalSlipList.do <br>
     * 반환 : AdminSlipReportExpendList.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminExpendDetailReport() {
        return EXIAdminExpendDetailReport;
    }

    /**
     * 메뉴 : 지출결의 현황<br>
     * 기능 : 관리자가 지출결의 문서의 단위로 확인할 수 있는 메뉴 (특이사항 : 임시보관 조회 가능 / 삭제 가능)<br>
     * 호출 : /ex/admin/report/ExApprovalList.do <br>
     * 반환 : AdminReportExpendList.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 2019. 073. 17. 김상겸 : 검색조건 위치 조정 및 추가 ( UCAIMP-957 )
     *     * 요청 고객 : 중앙에너비스
     *     * 지급요청일 검색조건 추가 ( Default 일자 미선택 상태 )
     *     * 관리항목 검색불가 안내문구 추가
     *     * 상세검색 영역 검색조건 순서 및 정렬
     * </pre>
     */
    public static String GetEXIAdminExpendReport() {
        return EXIAdminExpendReport;
    }

    /**
     * 메뉴 : 카드 사용 현황<br>
     * 기능 : 관리자가 카드 사용 내역을 확인할 수 있는 메뉴 (특이사항 : 미사용 처리 가능)<br>
     * 호출 : /ex/admin/report/ExUseCardlList.do <br>
     * 반환 : AdminCardReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminCardReport() {
        return EXIAdminCardReport;
    }

    /**
     * 메뉴 : iCUBE 연동문서 현황<br>
     * 기능 : 관리자가 iCUBE에서 상신된 전자결재 문서를 확인할 수 있는 메뉴 (특이사항 : 삭제 가능)<br>
     * 호출 : /ex/admin/report/ExiCUBEDocListReport.do <br>
     * 반환 : AdminiCUBEDocListReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminiCUBELinkReport() {
        return EXIAdminiCUBELinkReport;
    }

    /**
     * 메뉴 : 세금계산서 현황(iCUBE)<br>
     * 기능 : 관리자가 세금계산서 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExAdminETaxlListiCUBE.do <br>
     * 반환 : AdminETaxReportiCUBE.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminEtaxReport() {
        return EXIAdminEtaxReport;
    }

    /**
     * 메뉴 : 예실대비현황(iCUBE)<br>
     * 기능 : 관리자가 예실대비 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/yesil/ExAdminYesilReport.do <br>
     * 반환 : AdminYesilReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXIAdminBudgetReport() {
        return EXIAdminBudgetReport;
    }

    /* ==================================================================================================== */
    /* ExPath - ERPiU - User */
    /* ==================================================================================================== */
    // 나의 지출결의 현황
    private static String EXUUserExpendReport = "/expend/ex/user/content/UserReportExpendList";
    // 나의 지출결의 상세 현황
    private static String EXUUserExpendSlipReport = "/expend/ex/user/content/UserSlipReportExpendList";
    // 나의 카드 사용 현황
    private static String EXUUserCardReport = "/expend/ex/user/content/UserCardReport";
    // 나의 세금계산서 현황(ERPiU)
    private static String EXUUserEtaxReport = "/expend/ex/user/content/UserETaxReportERPiU";
    // 나의 예실대비 현황(ERPiU)
    private static String EXUUserBudgetReport = "/expend/ex/user/content/UserYesil2Report";

    /* Getter --------------------------------------------------------------------------------------------- */
    /**
     * 메뉴 : 나의 지출결의 현황<br>
     * 호출 : /ex/user/report/ExApprovalList.do <br>
     * 반환 : UserReportExpendList.jsp
     *
     * <pre>
     * # 로그인 사용자의 지출결의 상신 내역을 확인할 수 있는 메뉴
     *   - 전자결재 문서를 기준으로 임시보관, 상신, 진행, 종결, 반려 문서 목록 확인
     *   - 목록 엑셀다운로드 지원
     * </pre>
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 2019. 073. 17. 김상겸 : 검색조건 위치 조정 및 추가 ( UCAIMP-957 )
     *     * 요청 고객 : 중앙에너비스
     *     * 기안일자 디폴트 값 변경 ( 기존 : 2018-10-01 ~ 2018-11-28 > 변경 : 2018-10-28 ~ 2018-11-28 )
     *     * 제목 검색 상단으로 위치 변경
     *     * 지급요청일 검색조건 추가 ( Default 일자 미선택 상태 )
     *     * 관리항목 검색불가 안내문구 추가
     *     * 상세검색 영역 검색조건 순서 및 정렬
     * </pre>
     */
    public static String GetEXUUserExpendReport() {
        return EXUUserExpendReport;
    }
    /**
     * 메뉴 : 나의 지출결의 상세 현황<br>
     * 반환 : UserSlipReportExpendList.jsp
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 2020.07.28 이준성 나의 지출결의 상세현황 개발
     * </pre>
     */
    public static String GetEXUUserExpendSlipReport() {
      return EXUUserExpendSlipReport;
    }

    /**
     * 메뉴 : 나의 카드 사용 현황<br>
     * 호출 : /ex/user/report/ExUseCardlList.do <br>
     * 반환 : UserCardReport.jsp
     *
     * <pre>
     * # 로그인 사용자의 권한에 따른 카드 사용 내역을 확인할 수 있는 메뉴
     *   - CMS 또는 VAN 을 통하여 수신된 카드 사용내역 중, 법인카드 공개범위에 포함된 카듸의 내역만 목록 확인
     *   - 목록 엑셀 다운로드 지원
     * </pre>
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUUserCardReport() {
        return EXUUserCardReport;
    }

    /**
     * 메뉴 : 나의 세금계산서 현황(ERPiU)<br>
     * 기능 : 로그인 사용자의 권한에 따른 세금계산서 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/user/report/ExUserETaxERPiUList.do <br>
     * 반환 : UserETaxReportERPiU.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUUserEtaxReport() {
        return EXUUserEtaxReport;
    }

    /**
     * 메뉴 : 나의 예실대비 현황(ERPiU)<br>
     * 호출 : /ex/user/yesil/ExUserYesil2Report.do <br>
     * 반환 : UserYesil2Report.jsp
     *
     * <pre>
     * # 로그인 사용자의 권한에 따른 예실대비 내역을 확인할 수 있는 메뉴
     * </pre>
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUUserBudgetReport() {
        return EXUUserBudgetReport;
    }

    /* ==================================================================================================== */
    /* ExPath - ERPiU - Admin */
    /* ==================================================================================================== */
    // 지출결의 확인
    private static String EXUAdminExpendConfirmReport = "/expend/ex/admin/content/AdminExpendManagerReport";
    // 지출결의 확인(권한별)
    private static String EXUAdminExpendAuthReport = "/expend/ex/admin/content/AdminExpendManagerReport";
    // 지출결의 상세현황
    private static String EXUAdminExpendDetailReport = "/expend/ex/admin/content/AdminSlipReportExpendList";
    // 지출결의 현황
    private static String EXUAdminExpendReport = "/expend/ex/admin/content/AdminReportExpendList";
    // 카드 사용 현황
    private static String EXUAdminCardReport = "/expend/ex/admin/content/AdminCardReport";
    // 세금계산서 현황(ERPiU)
    private static String EXUAdminEtaxReport = "/expend/ex/admin/content/AdminETaxReportERPiU";
    // 예실대비현황(ERPiU)
    private static String EXUAdminBudgetReport = "/expend/ex/admin/content/AdminYesil2Report";
    // 예실대비현황 2.0(ERPiU)
    private static String EXUAdminERPiUBudgetReport = "/expend/ex/admin/content/AdminExERPiUYesil";

    private static String EXUAdminERPiUBudgetReporPop = "/expend/ex/admin/pop/AdminERPiUYesilExpendDetailInfo";

    /* Getter --------------------------------------------------------------------------------------------- */
    /**
     * 메뉴 : 지출결의 확인<br>
     * 기능 : 관리자가 종결된 지출결의 문서를 ERP 자동전표로 전송할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExApprovalSendList.do <br>
     * 반환 : AdminExpendManagerReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminExpendConfirmReport() {
        return EXUAdminExpendConfirmReport;
    }

    /**
     * 메뉴 : 지출결의 확인(권한별)<br>
     * 기능 : 비상교육 전용 대응 메뉴<br>
     * 호출 : /ex/admin/report/ExFormAuthApprovalSendList.do <br>
     * 반환 : AdminExpendManagerReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminExpendAuthReport() {
        return EXUAdminExpendAuthReport;
    }

    /**
     * 메뉴 : 지출결의 상세현황<br>
     * 기능 : 관리자가 지출결의 문서의 분개정보 단위로 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExApprovalSlipList.do <br>
     * 반환 : AdminSlipReportExpendList.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminExpendDetailReport() {
        return EXUAdminExpendDetailReport;
    }

    /**
     * 메뉴 : 지출결의 현황<br>
     * 기능 : 관리자가 지출결의 문서의 단위로 확인할 수 있는 메뉴 (특이사항 : 임시보관 조회 가능 / 삭제 가능)<br>
     * 호출 : /ex/admin/report/ExApprovalList.do <br>
     * 반환 : AdminReportExpendList.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - 2019. 073. 17. 김상겸 : 검색조건 위치 조정 및 추가 ( UCAIMP-957 )
     *     * 요청 고객 : 중앙에너비스
     *     * 지급요청일 검색조건 추가 ( Default 일자 미선택 상태 )
     *     * 관리항목 검색불가 안내문구 추가
     *     * 상세검색 영역 검색조건 순서 및 정렬
     * </pre>
     */
    public static String GetEXUAdminExpendReport() {
        return EXUAdminExpendReport;
    }

    /**
     * 메뉴 : 카드 사용 현황<br>
     * 기능 : 관리자가 카드 사용 내역을 확인할 수 있는 메뉴 (특이사항 : 미사용 처리 가능)<br>
     * 호출 : /ex/admin/report/ExUseCardlList.do <br>
     * 반환 : AdminCardReport.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminCardReport() {
        return EXUAdminCardReport;
    }

    /**
     * 메뉴 : 세금계산서 현황(ERPiU)<br>
     * 기능 : 관리자가 세금계산서 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/report/ExAdminETaxlListERPiU.do <br>
     * 반환 : AdminETaxReportERPiU.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminEtaxReport() {
        return EXUAdminEtaxReport;
    }

    /**
     * 메뉴 : 예실대비현황(ERPiU)<br>
     * 기능 : 관리자가 예실대비 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/yesil/ExAdminYesil2Report.do <br>
     * 반환 : AdminYesil2Report.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   - (예시) 2019. 07. 01. 김상겸 : 기안자 검색조건 추가
     * </pre>
     */
    public static String GetEXUAdminBudgetReport() {
        return EXUAdminBudgetReport;
    }

    /**
     * 메뉴 : 예실대비현황 2.0(ERPiU)<br>
     * 기능 : 관리자가 예실대비 내역을 확인할 수 있는 메뉴<br>
     * 호출 : /ex/admin/yesil/ExAdminERPiUYesilReport.do <br>
     * 반환 : AdminYesil2Report.jsp
     *
     * <pre>
     * # 메뉴 변경 이력 및 개선 이력 기록
     *   -  2019. 12. 03. 이준성 : ERP iU 예실대비현황 2.0 개발
     * </pre>
     */
    public static String GetEXUAdminERPiUBudgetReport() {
      return EXUAdminERPiUBudgetReport;
    }

    public static String getEXUAdminERPiUBudgetReporPop() {
      return EXUAdminERPiUBudgetReporPop;
    }

    /* ==================================================================================================== */
    /* ExPath - Bizbox - Admin */
    /* ==================================================================================================== */
    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminCardConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminSummaryConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminAuthConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminFormLinkConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminItemConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminMngConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminLangConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminButtonConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminEtaxAuthConfig = "";

    /**
     * 메뉴 : <br>
     * 기능 : <br>
     * 반환 :
     */
    @SuppressWarnings("unused")
	private static String EXAdminExpendEndConfig = "";

    /* ==================================================================================================== */
    /* ExPath - Bizbox - Error */
    /* ==================================================================================================== */
    private static String ExError = "/expend/common/error/cmError";

    public static String GetExError() {
        ExpInfo.TipLog("return cmError..");
        return ExError;
    }

    private static String ExErrorCheckAuth = "/expend/common/error/cmErrorCheckAuth";

    public static String GetExErrorCheckAuth() {
        ExpInfo.TipLog("return cmErrorCheckAuth..");
        return ExErrorCheckAuth;
    }

    private static String ExErrorCheckLogin = "/expend/common/error/cmErrorCheckLogin";

    public static String GetExErrorCheckLogin() {
        ExpInfo.TipLog("return cmErrorCheckLogin..");
        return ExErrorCheckLogin;
    }

    private static String ExErrorCheckDocSetting = "/expend/common/error/cmErrorCheckDocSetting";

    public static String GetExErrorCheckDocSetting() {
        ExpInfo.TipLog("return cmErrorCheckDocSetting..");
        return ExErrorCheckDocSetting;
    }

    private static String ExErrorCheckERP = "/expend/common/error/cmErrorCheckERP";

    public static String GetExErrorCheckERP() {
        ExpInfo.TipLog("return cmErrorCheckERP..");
        return ExErrorCheckERP;
    }

    private static String ExErrorCheckiCUBEG20Type = "/expend/common/error/cmErrorCheckICUBEG20Type";

    public static String GetExErrorCheckiCUBEG20Type() {
        ExpInfo.TipLog("return cmErrorCheckICUBEG20Type..");
        return ExErrorCheckiCUBEG20Type;
    }

    private static String ExErrorCheckErpEmpCdMapping = "/expend/common/error/cmErrorCheckErpEmpCdMapping";

    public static String GetExErrorCheckErpEmpCdMapping() {
        ExpInfo.TipLog("return cmErrorCheckErpEmpCdMapping..");
        return ExErrorCheckErpEmpCdMapping;
    }

    private static String ExErrorCheckErpSetting = "/expend/common/error/cmErrorCheckErpSetting";

    public static String GetExErrorCheckErpSetting() {
        ExpInfo.TipLog("return cmErrorCheckErpSetting..");
        return ExErrorCheckErpSetting;
    }




}
