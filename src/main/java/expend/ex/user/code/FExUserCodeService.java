package expend.ex.user.code;

import java.util.List;
import java.util.Map;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;

public interface FExUserCodeService {
    List<Map<String, Object>> ExUserEmpListInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception;

    List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception;

    List<Map<String, Object>> ExUserCommCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception;

    ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception;

    ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception;

    /* Function - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception;

    ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception;
}
