package expend.ex.cmm;

import java.util.Map;


public interface BExCommonService {

    // 공통코드 조회
    Map<String, Object> CommonCodeSelect(Map<String, Object> params) throws Exception;

    // 그룹웨어 URL 조회
    String GroupwareUrlSelect(String groupSeq) throws Exception;

}
