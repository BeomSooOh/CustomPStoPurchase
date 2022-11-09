package interlock.api.ex;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;

@Service("BApiService")
public class BApiServiceImpl implements BApiService {

    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());


    @Resource(name = "FApiServiceA")
    private FApiServiceAImpl serviceA;

    // 카드 내역의 카드 상태값을 변경합니다.
    @Override
    public Map<String, Object> SetCardSync(Map<String, Object> param) throws Exception {
        // 요청된 카드 내역의 권한이 존재하는가? < 구현 여부는 점검 필요. >

        // 요청된 카드 내역의 갱신이 현재 상신되었는가? < 패키지 상신여부 점검 - 패키지 상신된 경우에는 복구할 수 없음. >
        Map<String, Object> card = new HashMap<String, Object>();
        card = serviceA.GetCardGeorae(param);
        // card = (card == null ? new HashMap<String, Object>() : card);

        // 카드 내역을 확인할 수 없는 경우
        if (card == null || card.keySet().size() < 1) {
            logger.error("법인카드 사용 내역 정보를 확인할 수 없습니다. syncId값이 정상값인지 확인 바랍니다.");
            throw new Exception("법인카드 사용 내역 정보를 확인할 수 없습니다. syncId값이 정상값인지 확인 바랍니다.");
        }

        // groupSeq 가 일치하지 않는 경우
        if (card.get("groupSeq") == null || !card.get("groupSeq").equals(param.get("groupSeq"))) {
            logger.error("정상값이 아닙니다. (groupSeq)" + param.toString());
            throw new Exception("정상값이 아닙니다. (groupSeq)");
        }

        // compSeq 가 일치하지 않는 경우
        if (card.get("compSeq") == null || !card.get("compSeq").equals(param.get("compSeq"))) {
            logger.error("정상값이 아닙니다. (compSeq)" + param.toString());
            throw new Exception("정상값이 아닙니다. (compSeq)");
        }

        // empSeq 가 일치하지 않는 경우
        if (card.get("empSeq") == null || !card.get("empSeq").equals(param.get("empSeq"))) {
            logger.error("정상값이 아닙니다. (empSeq)" + param.toString());
            throw new Exception("정상값이 아닙니다. (empSeq)");
        }

        // if_m_id 와 if_d_id 의 값이 0이거나 공백인 경우
        // send_yn 의 값이 N 인 경우
        card.put("ifMid", (card.get("ifMid") == null ? "0" : card.get("ifMid")));
        card.put("ifDid", (card.get("ifDid") == null ? "0" : card.get("ifDid")));
        if ((!card.get("ifMid").equals("0") && !card.get("ifMid").equals("")) && (!card.get("ifDid").equals("0") && !card.get("ifDid").equals("")) && card.get("sendYn").equals("Y")) {
            logger.error("패키지 상신 처리된 카드내역입니다 - " + param.toString());
            throw new Exception("패키지 상신 처리된 카드내역입니다.");
        }

        // 기존 데이터와 업데이트 데이터가 동일한 경우 판단 ( 중복 요청 제한 )
        card.put("sendYn", (card.get("sendYn") == null ? "N" : card.get("sendYn")));
        if (card.get("sendYn").equals(param.get("sendYn"))) {
            logger.error("상태값을 변경할 수 없습니다. 현재상태와 업데이트 데이터가 동일합니다. ( sendYn ) - " + param.toString());
            throw new Exception("상태값을 변경할 수 없습니다. 현재상태와 업데이트 상태가 동일합니다. ( sendYn )");
        }

        // 카드내역 상태값 갱신 진행
        int updateCount = 0;
        updateCount = serviceA.SetCardGeoraeSendYn(param);

        if (updateCount != 1) {
            throw new Exception("업데이트 실패하였습니다.");
        } else {
            card.put("sendYn", param.get("sendYn"));
        }

        return card;
    }
}
