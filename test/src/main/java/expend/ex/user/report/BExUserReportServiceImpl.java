package expend.ex.user.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExReportCardVO;
import common.vo.common.ResultVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Service("BExUserReportService")
public class BExUserReportServiceImpl implements BExUserReportService {

    /* 변수정의 */
    protected org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    // service
    @Resource(name = "FExUserReportServiceA")
    private FExUserReportService userReportA;

    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    /* Biz - 회계 ( 사용자 ) */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 - 목록 조회 */
    @Override
    public ResultVO ExUserExpendReportListInfoSelect(Map<String, Object> params) throws Exception {
        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        cmLog.CommonSetInfo("Call ExUserExpendReportListInfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        ResultVO resultVo = new ResultVO();
        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 From */
            if (CommonConvert.CommonGetStr(params.get("searchFromDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExUserExpendReportListInfoSelect - BizboxA - parameter not exists >> " + "searchFromDate");
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 To */
            if (CommonConvert.CommonGetStr(params.get("searchToDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExUserExpendReportListInfoSelect - BizboxA - parameter not exists >> " + "searchToDate");
            }
            /* 필수 파라미터 점검 - 지급요청일자, 문서번호, 문서제목은 선택 검색 */
            /* 데이터 조회 */
            resultVo.setParams(params);
            resultVo.setAaData(userReportA.ExUserExpendReportListInfoSelect(params));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* Biz - 회계 ( 사용자 ) */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 - 목록 조회 - 푸딩 */

    /**
     * <pre>
     * # 나의 지출결의 현황 목록 조회
     *   - 나의 지출결의 현황 목록을 조회한다. ( 기본적으로 로그인 사용자 기준의 데이터만 조회되어야 한다. )
     * # 파라미터
     *   - 기안일 시작 : searchDocFromDate: "20190618"
     *   - 기안일 종료 : searchDocToDate: "20190718"
     *   - 문서제목 : appDocTitle: "문서제목"
     *   - 문서상태 : searchDocStatus: "10"
     *   - 회계일자 시작 : searchFromDate: "20190701"
     *   - 회계일자 종료 : searchToDate: "20190702"
     *   - 지급요청일 시작 : searchReqFromDate: "20190703"      *   -지급요청일 종료 : searchReqToDate: "20190704"
     *   -  문서분류 : formName: "문서분류"
     *   - 문서번호 : appDocNo: "문서번호"
     *   - 사업장 : bizCd: "1000"
     *   - 부서 : expendUseDeptName: "부서"
     *   - 사용자 : expendUseEmpName: "사용자"
     *   - 자동전표번호 : expendErpAdocuNumber: "자동전표번호"
     *   - 페이지 : page: 1      *   -페이지 크기 : pageSize: 10
     *   - 정렬 기준 : sortField: ""      *   -정렬 방법 : sortType: ""
     *   - 시작 : startPosition: 0
     *   - 종료 : endPosition: 10
     * # 반환
     *   -
     * </pre>
     *
     * @return common.vo.common.ResultVO
     * @exception java.lang.Exception
     */
    @Override
    public ResultVO ExUserExpendReportListInfoNewSelect(Map<String, Object> params) throws NotFoundDataException, NotFoundLoginSessionException, Exception {

        ResultVO result = new ResultVO();

        try {
            // 로그인 사용자 정보 확인
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);

            // 필수 파라미터 점검
            if (params.get(commonCode.COMPSEQ) == null || params.get(commonCode.COMPSEQ).equals("")) {
                // 회사 시퀀스
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : compSeq");
            } else if (params.get(commonCode.EMPSEQ) == null || params.get(commonCode.EMPSEQ).equals("")) {
                // 사원 시퀀스
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : empSeq");
            } else if (params.get("searchFromDate") == null || params.get("searchFromDate").equals("")) {
                // 회계일자 시작일
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : searchFromDate");
            } else if (params.get("searchToDate") == null || params.get("searchToDate").equals("")) {
                // 회계일자 종료일
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : searchToDate");
            } else if (params.get("startPosition") == null || params.get("startPosition").equals("")) {
                // 검색 시작 인덱스
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : startPosition");
            } else if (params.get("endPosition") == null || params.get("endPosition").equals("")) {
                // 검색 종료 인덱스
                throw new NotFoundDataException("[BExUserReportServiceImpl.ExUserExpendReportListInfoNewSelect] 파라미터 누락 : endPosition");
            } else {
                if (params.get("sortField") == null || params.get("sortField").equals("")) {
                    params.put("sortField", "appRepDate DESC, appDocNo DESC");
                } else if (params.get("sortType") == null || params.get("sortType").equals("")) {
                    params.put("sortType", "");
                }

                // 파라미터 정의
                result.setParams(params);

                // 데이터 조회
                result.setaData(userReportA.ExUserExpendReportListInfoNewSelect(params));
            }
        } catch (NotFoundDataException e) {
            logger.error(e);
            throw e;
        } catch (NotFoundLoginSessionException e) {
            logger.error(e);
            throw e;
        } catch (Exception e) {
            logger.error(e);
            throw e;
        }

        return result;
    }

    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 카드 사용 현황 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 나드 사용 현황 - 목록 조회 */
    @Override
    public ResultVO ExUserCardReportListInfoSelect(ExReportCardVO reportCardVO, PaginationInfo paginationInfo) throws Exception {
        /* parameter : fromDate, toDate, cardNum, mercName */
        ResultVO resultVo = new ResultVO();
        try {
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (reportCardVO.getCompSeq().equals(commonCode.EMPTYSTR)) {
                throw new Exception("BExUserReportService - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 사용자 시퀀스 */
            if (reportCardVO.getEmpSeq().equals(commonCode.EMPTYSTR)) {
                throw new Exception("BExUserReportService - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.EMPSEQ);
            }
            /* 필수 파라미터 점검 - 승인일자 From */
            if (reportCardVO.getFromDate().equals(commonCode.EMPTYSTR)) {
                throw new Exception("BExUserReportService - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.FROMDATE);
            }
            /* 필수 파라미터 점검 - 승인일자 To */
            if (reportCardVO.getToDate().equals(commonCode.EMPTYSTR)) {
                throw new Exception("BExUserReportService - ExUserCardReportListInfoSelect - parameter not exists >> " + commonCode.TODATE);
            }
            /* 필수 파라미터 점검 - 카드번호, 거래처명칭 , 카드명 은 선택 검색 */
            /* 데이터 조회 */
            resultVo.setParams(CommonConvert.ConverObjectToMap(reportCardVO));
            resultVo.setaData(userReportA.ExUserCardReportListInfoSelect(reportCardVO, paginationInfo));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* 인터락 정보 조회 */
    @Override
    public Map<String, Object> ExReportHeaderInterLockInfoSelect(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExReportHeaderInterLockInfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        Map<String, Object> headerMap = new HashMap<String, Object>();
        try {
            headerMap = userReportA.ExReportHeaderInterLockInfoSelect(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return headerMap;
    }

    /* 인터락 정보 조회 */
    @Override
    public List<Map<String, Object>> ExReportContentsInterLockInfoSelect(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExReportContentsInterLockInfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        List<Map<String, Object>> contentsMap = new ArrayList<Map<String, Object>>();
        try {
            contentsMap = userReportA.ExReportContentsInterLockInfoSelect(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return contentsMap;
    }

    /* 인터락 정보 조회 */
    @Override
    public Map<String, Object> ExReportFooterInterLockInfoSelect(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExReportFooterInterLockInfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        Map<String, Object> footerMap = new HashMap<String, Object>();
        try {
            footerMap = userReportA.ExReportFooterInterLockInfoSelect(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return footerMap;
    }

    /* 인터락 정보 조회 - 소계양식 정보 */
    @Override
    public List<Map<String, Object>> ExReportSubtotalInterLockInfoSelect(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExReportSubtotalInterLockInfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        List<Map<String, Object>> subtotalMap = new ArrayList<Map<String, Object>>();
        try {
        	subtotalMap = userReportA.ExReportSubtotalInterLockInfoSelect(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return subtotalMap;
    }

    /* 세금계산서 현황 / 카드사용현황 외부시스템 이관처리 진행 */
    @Override
    public ResultVO ExUserInterfaceTransfer(Map<String, Object> param) throws Exception {
        ResultVO result = new ResultVO();
        param.put("interfaceType", CommonConvert.CommonGetStr(param.get("interfaceType")).toLowerCase());
        List<Map<String, Object>> targetData = new ArrayList<Map<String, Object>>();
        targetData = CommonConvert.CommonGetJSONToListMap(param.get("targetData").toString());
        boolean hasPublic = false;
        for (Map<String, Object> target : targetData) {
            /* 이관받는 사람이 공개범위에 포함되어있는지 확인 진행 */
            List<Map<String, Object>> receiveInfo = new ArrayList<Map<String, Object>>();
            receiveInfo = CommonConvert.CommonGetJSONToListMap(param.get("receiveInfo").toString());
            for (Map<String, Object> tEmp : receiveInfo) {
                List<Map<String, Object>> chkResult = new ArrayList<Map<String, Object>>();
                if (CommonConvert.CommonGetStr(param.get("interfaceType")).equals("etax")) {
                    Map<String, Object> tParam = new LinkedHashMap<String, Object>();
                    tParam.put("trchargeEmail", target.get("trchargeEmail").toString());
                    tParam.put("trregNb", target.get("trregNb").toString().replace("-", ""));
                    tParam = CommonConvert.CommonSetMapCopy(tEmp, tParam);
                    chkResult = userReportA.ExUserETaxTransferChkPossibility(tParam);
                } else {
                    Map<String, Object> tParam = new LinkedHashMap<String, Object>();
                    tParam = CommonConvert.CommonSetMapCopy(tEmp, tParam);
                    chkResult = userReportA.ExUserCardTransferChkPossibility(tParam);
                }
                if (chkResult != null && !chkResult.isEmpty()) {
                    if (CommonConvert.CommonGetStr(param.get("interfaceType")).equals("card")) {
                        for (Map<String, Object> cardTemp : chkResult) {
                            if (CommonConvert.CommonGetStr(cardTemp.get("duplication")).equals("Y")) {
                                hasPublic = true;
                                break;
                            }
                        }
                    } else {
                        hasPublic = true;
                        break;
                    }
                }
            }
            if (hasPublic) {
                break;
            }
        }
        if (hasPublic) {
            result.setFail("이미 조회권한에 포함된 인원입니다.");
            return result;
        }
        for (Map<String, Object> target : targetData) {
            if (CommonConvert.CommonGetStr(param.get("interfaceType")).equals("etax")) {
                target = CommonConvert.CommonSetMapCopy(param, target);
                target.put("amt", target.get("sumAm").toString().replace(",", ""));
            } else {
                target = CommonConvert.CommonSetMapCopy(param, target);
                target.put("amt", target.get("requestAmount").toString().replace(",", ""));
            }
            result = userReportA.ExUserInterfaceTransfer(target);
        }
        return result;
    }

    /* 세금계산서 현황 / 카드사용현황 외부시스템 이관 취소 진행 */
    @Override
    public ResultVO ExUserInterfaceTransferCancel(Map<String, Object> param) throws Exception {
        ResultVO result = new ResultVO();
        param.put("interfaceType", CommonConvert.CommonGetStr(param.get("interfaceType")).toLowerCase());
        userReportA.ExUserInterfaceTransferCancel(param);
        return result;
    }

    /* 세금계산서 현황 이관 내역 조회 */
    @Override
    public List<Map<String, Object>> ExUserETaxTransferHistory(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = userReportA.ExUserETaxTransferHistory(param);
        return result;
    }

    /* 나의 지출결의 상세 현황 이준성 */
    @Override
    public ResultVO ExUserExpendSlipReportListInfoSelect(Map<String, Object> params) throws Exception {

      ResultVO resultVo = new ResultVO();

      try {
        params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
        if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
            throw new Exception("FExUserReportServiceA - ExUserExpendSlipReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
        } else if (CommonConvert.CommonGetStr(params.get(commonCode.EMPSEQ)).equals(commonCode.EMPTYSTR)) {
          throw new Exception("FExUserReportServiceA - ExUserExpendSlipReportListInfoSelect - parameter not exists >> " + commonCode.EMPSEQ);
        }

        resultVo.setParams(params);
        resultVo.setaData(userReportA.ExUserExpendSlipReportListInfoSelect(params));

      } catch (Exception e) {
        cmLog.CommonSetError(e);
        throw e;
      }

      return resultVo;
    }
}
