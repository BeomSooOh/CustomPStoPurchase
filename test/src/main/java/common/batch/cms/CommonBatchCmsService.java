package common.batch.cms;

import java.util.List;
import java.util.Map;
import common.vo.batch.CommonBatchCmsConfigVO;

public interface CommonBatchCmsService {

    int CommonSetCmsSync(Map<String, Object> parmas) throws InterruptedException;

    List<CommonBatchCmsConfigVO> selectCms(Map<String, String> param) throws Exception;

    void CommonCmsACardTempToCardTempBatch(StringBuffer params, Map<String, Object> custInfo) throws Exception;

}
