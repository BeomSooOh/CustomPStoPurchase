package interlock.api.ex;

import java.util.Map;

public interface BApiService {

    /**
     * 카드 내역의 카드 상태값을 변경합니다.
     */
    Map<String, Object> SetCardSync(Map<String, Object> param) throws Exception;
}
