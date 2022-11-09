package common.batch.cms;

import java.util.Map;

public interface CommonBatchCmsServiceTest {
  
  int CommonSetCmsSynctest(Map<String, Object> parmas) throws InterruptedException;
  
  void CommonCmsACardTempToCardTempBatch(StringBuffer params, Map<String, Object> custInfo) throws Exception;

}
