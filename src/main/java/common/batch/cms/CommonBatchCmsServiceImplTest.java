package common.batch.cms;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;
import bizbox.orgchart.constant.CloudConstants;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.batch.CommonBatchCmsConfigVO;
import common.vo.batch.CommonBatchCmsDataVO;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;
import neos.cmm.util.BizboxAProperties;

@Service("CommonBatchCmsServiceTest")
public class CommonBatchCmsServiceImplTest implements CommonBatchCmsServiceTest{

  private static org.apache.logging.log4j.Logger logger = LogManager.getLogger(CommonBatchCmsServiceImpl.class);

  // dao
  @Resource(name = "CommonBatchCmsBizboxDAO")
  CommonBatchCmsBizboxDAO daoBizbox;

  @Resource(name = "CommonBatchCmsiCUBEServiceDAO")
  CommonBatchCmsiCUBEServiceDAO daoiCUBE;

  @Resource(name = "CommonBatchCmsERPiUDAO")
  CommonBatchCmsERPiUDAO daoERPiU;

  // class
  @Resource(name = "CommonInfo")
  CommonInfo cmInfo;
  @Resource(name = "CommonLogger")
  CommonLogger cmLog;
  
//CMS 동기화
  @Override
  public int CommonSetCmsSynctest(Map<String,Object> params) throws InterruptedException {
    StopWatch stopWatch = new StopWatch();
    
    stopWatch.start();
    
    logger.error("[CloudRunTest] 새로운 batch 시작");
    
    int isSuccess = 1;
      // 회사정보 확인 ( orgChart 참조 )
      List<Map<String, String>> arrCust = new ArrayList<Map<String, String>>();
      
      
      try {
          arrCust = CloudConnetInfo.getCustInfoList();
      } catch (Exception e) {
          e.printStackTrace();
          logger.error("OrgChart.jar의 고객정보 조회에 오류가 발생되었습니다.");
      }

      // 조회된 고객리스트 기준 반복 처리 진행
      // 참고 : http://wiki.duzon.com:8080/pages/viewpage.action?pageId=13226844
      // 주의사항 : 2019. 07.0 15. 클아우드의 경우 고객사 리스트 조회시 미개통 고객도 조회가 가능하도록 변경되었습니다.
      for (Map<String, String> custInfo : arrCust) {
        
        logger.error("[CloudRunTest] custInfo GroupSeq"+ CommonConvert.CommonGetStr(custInfo.get(CloudConstants.GROUP_SEQ)) );
        
        if(  CommonConvert.CommonGetStr(custInfo.get(CloudConstants.GROUP_SEQ)).equals("hbamc")   ) {
        
          Thread.sleep(20);
          if (CloudConstants.OPERATE_STATUS_OPERATE.equals(custInfo.get(CloudConstants.OPERATE_STATUS))) {
              logger.error("[" + custInfo.get(CloudConstants.GROUP_SEQ) + "] CMS 연동을 진행합니다. - " + custInfo.get(CloudConstants.OPERATE_STATUS_NAME));

              ConnectionVO con = new ConnectionVO(); // ERP 연결정보
              Map<String, Object> mapCmsSyncParams = new HashMap<String, Object>(); // CMS 데이터 조회 파라미터
              List<Map<String, Object>> arrBaseCmsData = new ArrayList<Map<String, Object>>(); // CMS 조회 데이터
              List<CommonBatchCmsConfigVO> arrCmsConfig = new ArrayList<CommonBatchCmsConfigVO>(); // CMS 설정 정보
              List<CommonBatchCmsDataVO> arrCmsData = new ArrayList<CommonBatchCmsDataVO>(); // 실 적용할 CMS 데이터
              List<Map<String, Object>> cmsTempData = new ArrayList<Map<String, Object>>();
              
              // 다중서버의 경우 하나만 배치 처리 : 기존 프로세스 유지 ( IP 주소, t_ex_cms_sync 설정, 프로퍼티(BizboxA.CMS.Sync) 설정 )
              InetAddress local = null;
              try {
                  local = InetAddress.getLocalHost();
              } catch (UnknownHostException e1) {
                  e1.printStackTrace();
              }
              String serverIP = local.getHostAddress();

              try {
                  Enumeration<NetworkInterface> nienum = NetworkInterface.getNetworkInterfaces();
                  while (nienum.hasMoreElements()) {
                      NetworkInterface ni = nienum.nextElement();
                      Enumeration<InetAddress> kk = ni.getInetAddresses();
                      while (kk.hasMoreElements()) {
                          InetAddress inetAddress = kk.nextElement();
                          if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress()) {
                              serverIP = inetAddress.getHostAddress();
                          }
                      }
                  }
                  /*  */
              } catch (Exception e) {
                  serverIP = "";
              }

              // 서버 IP 정보 추가
              custInfo.put("serverIp", serverIP);
              custInfo.put("server_ip", serverIP);

              // CMS 설정 정보 조회 ( DB_NEOS )
              try {
                  if (custInfo.get(CloudConstants.DB_NEOS) == null || custInfo.get(CloudConstants.DB_NEOS).equals("")) {
                      logger.error("OrgChart.jar의 고객 정보조회를 통하여 스키마(DB_NEOS) 정보를 확인할 수 없습니다.");
                  } else {
                      arrCmsConfig = daoBizbox.CommonCmsConfigInfoListSelect(custInfo);
                      arrCmsConfig = (arrCmsConfig == null ? new ArrayList<CommonBatchCmsConfigVO>() : arrCmsConfig);
                  }
              } catch (Exception e) {
                  logger.error("CMS 연동 정보 조회에 실패하였습니다. ( t_ex_cms_sync )");
              }
              
             

              boolean cmsSyncTypeNewAll = false;
              
              JedisClient jedisClient = CloudConnetInfo.getJedisClient();
              String buildType = jedisClient.getBuildType();

              // CMS 연동 동기화 실행
              for (CommonBatchCmsConfigVO cmsConfig : arrCmsConfig) {
                  Thread.sleep(20);
                  cmsSyncTypeNewAll = false;

                  if (!cmsConfig.getServerIp().equals("DEF") && !cmsConfig.getServerIp().equals("") && !cmsConfig.getServerIp().equals(serverIP)) {
                      logger.error("#[01] CMS 동기화 대상 서버가 아닙니다. [" + custInfo.toString() + "]");
                  } else if (cmsConfig.getServerIp().equals("DEF") && BizboxAProperties.getProperty("BizboxA.CMS.Sync").equals("99")) {
                      logger.error("#[02] CMS 동기화 대상 서버가 아닙니다. [" + custInfo.toString() + "]");
                  } else if (cmsConfig.getServerIp().equals("DEF") && !BizboxAProperties.getProperty("BizboxA.CMS.Sync").equals("true")) {
                      logger.error("#[03] CMS 동기화 대상 서버가 아닙니다. [" + custInfo.toString() + "]");
                  } else {
                      mapCmsSyncParams.put("cmsBaseDate", CommonConvert.CommonGetStr(cmsConfig.getCmsBaseDate()));
                      mapCmsSyncParams.put("cmsBaseDay", CommonConvert.CommonGetSeq(cmsConfig.getCmsBaseDay()));
                      mapCmsSyncParams.put("DB_NEOS", CommonConvert.CommonGetStr(custInfo.get(CloudConstants.DB_NEOS)));
                      mapCmsSyncParams.put("DB_MOBILE", CommonConvert.CommonGetStr(custInfo.get(CloudConstants.DB_MOBILE)));
                      mapCmsSyncParams.put("DB_EDMS", CommonConvert.CommonGetStr(custInfo.get(CloudConstants.DB_EDMS)));
                      mapCmsSyncParams.put("groupSeq", CommonConvert.CommonGetStr(custInfo.get(CloudConstants.GROUP_SEQ)));
                      mapCmsSyncParams.put("compSeq", CommonConvert.CommonGetStr(cmsConfig.compSeq));
                      mapCmsSyncParams.put("issDtFrom",CommonConvert.NullToString(params.get("issDtFrom")));
                      mapCmsSyncParams.put("issDtTo",CommonConvert.NullToString(params.get("issDtTo")));
                      mapCmsSyncParams.put("cmsPeriodSync",CommonConvert.NullToString(params.get("cmsPeriodSync")));
                      
                      con = cmInfo.CommonGetConnectionInfo(mapCmsSyncParams);

                      if (con == null) {
                          logger.error("ERP 연동정보가 존재하지 않습니다. [" + mapCmsSyncParams.toString() + "]");
                      } else if (!con.getErpTypeCode().equals(commonCode.ERPIU) && !con.getErpTypeCode().equals(commonCode.ICUBE)) {
                          logger.error("연동된 ERP 연동정보가 ERPiU와 iCUBE에 해당되지 않습니다. [" + mapCmsSyncParams.toString() + "]");
                      } else {

                         if(CommonConvert.NullToString(params.get("cmsPeriodSync")).equals("Y") && con.getErpTypeCode().equals(commonCode.ICUBE)) {
                              try {
                                 int isDifferentGeoraeCall = daoBizbox.CommonCmsConfigDiffrentGeoraeCall(mapCmsSyncParams);
                                 if(isDifferentGeoraeCall > 1) {
                                    logger.error("T_EX_CARD_AQ_TMP 거래콜 겹침 조회 오류 발생.");
                                    isSuccess = 3;
                                    return isSuccess;
                                 }
                              } catch (Exception e) {
                                 logger.error("T_EX_CARD_AQ_TMP 거래콜 겹침 조회 오류 발생.");
                                 e.printStackTrace();
                              }
                         }
                      
                          
                          if (con.getErpTypeCode().equals(commonCode.ERPIU)) {
                              // ERPiU 연동에 해당하는 경우
                              if (cmsConfig.getCustomYN().equals(commonCode.EMPTYNO)) {
                                  // CMS CUSTOM_YN : 미사용
                                  arrBaseCmsData = new ArrayList<Map<String, Object>>();
                                  try {
                                      arrBaseCmsData = daoERPiU.CommonCmsERPiUInfoListSelect(con, mapCmsSyncParams);
                                  } catch (Exception e) {
                                      e.printStackTrace();
                                      logger.error("ERPiU CMS 데이터 조회중 오류가 발생되었습니다.");
                                      isSuccess = 2;
                                  }

                                  for (Map<String, Object> baseCmsData : arrBaseCmsData) {
                                      Thread.sleep(20);
                                      CommonBatchCmsDataVO cmsData = new CommonBatchCmsDataVO();
                                      cmsData = (CommonBatchCmsDataVO) CommonConvert.CommonGetMapToObject(baseCmsData, cmsData);
                                      arrCmsData.add(cmsData);
                                  }
                              } else if (cmsConfig.getCustomYN().equals(commonCode.EMPTYYES)) {
                                  // CMS CUSTOM_YN : 사용
                                  arrBaseCmsData = new ArrayList<Map<String, Object>>();
                                  try {
                                      arrBaseCmsData = daoERPiU.CommonCmsERPiUInfoListSelect_Procedure(con, mapCmsSyncParams);
                                  } catch (Exception e) {
                                      e.printStackTrace();
                                      logger.error("ERPiU CMS 데이터 조회중 오류가 발생되었습니다.");
                                      isSuccess = 2;
                                  }

                                  for (Map<String, Object> baseCmsData : arrBaseCmsData) {
                                      Thread.sleep(20);
                                      CommonBatchCmsDataVO cmsData = new CommonBatchCmsDataVO();
                                      cmsData = (CommonBatchCmsDataVO) CommonConvert.CommonGetMapToObject(baseCmsData, cmsData);
                                      arrCmsData.add(cmsData);
                                  }
                              }
                          }
                          // iCUBE 연동에 해당하는 경우
                          else if (con.getErpTypeCode().equals(commonCode.ICUBE)) {

                              if (cmsConfig.getCustomYN().equals(commonCode.EMPTYNO)) {
                                  
                                  cmsSyncTypeNewAll = true;
                                  arrBaseCmsData = new ArrayList<Map<String, Object>>();

                                  try {
                                      
                                      arrBaseCmsData = daoiCUBE.CommonCmsiCUBEInfoListSelect_All(con, mapCmsSyncParams);
                                      
                                  } catch (Exception e) {
                                      e.printStackTrace();
                                      logger.error("iCUBE CMS 데이터 조회중 오류가 발생되었습니다.");
                                  }
                                  try {
                                      for (Map<String, Object> baseCmsData : arrBaseCmsData) {
                                          Thread.sleep(20);
                                          CommonBatchCmsDataVO cmsData = new CommonBatchCmsDataVO();
                                          cmsData = (CommonBatchCmsDataVO) CommonConvert.CommonGetMapToObject(baseCmsData, cmsData);
                                          arrCmsData.add(cmsData);
                                      }

                                  } catch (Exception e) {
                                      e.printStackTrace();
                                      logger.error("iCUBE CMS 데이터 조회중 오류가 발생되었습니다.");
                                  }

                              } else if (cmsConfig.getCustomYN().equals(commonCode.EMPTYYES)) {
                                  // CMS CUSTOM_YN : 사용
                                  arrBaseCmsData = new ArrayList<Map<String, Object>>();
                                  try {
                                      // 전용 프로시저
                                      arrBaseCmsData = daoiCUBE.CommonCmsiCUBEInfoListSelect_Procedure(con, mapCmsSyncParams);
                                  } catch (Exception e) {
                                      // TODO Auto-generated catch block
                                      e.printStackTrace();
                                      logger.error("iCUBE CMS 조회중 오류가 발생되었습니다.");
                                  }

                                  for (Map<String, Object> baseCmsData : arrBaseCmsData) {
                                      Thread.sleep(20);
                                      CommonBatchCmsDataVO cmsData = new CommonBatchCmsDataVO();
                                      cmsData = (CommonBatchCmsDataVO) CommonConvert.CommonGetMapToObject(baseCmsData, cmsData);
                                      arrCmsData.add(cmsData);
                                      cmsTempData.add(baseCmsData);
                                  }
                              }

                          }

                          arrCmsData = (arrCmsData == null ? new ArrayList<CommonBatchCmsDataVO>() : arrCmsData);
                          StringBuffer sb = new StringBuffer();
                          List<Map<String, Object>> arrCmsSyncUpdateParams = new ArrayList<Map<String, Object>>();
                          
                          
                          if(cmsSyncTypeNewAll && con.getErpTypeCode().equals(commonCode.ICUBE)) {
                            StopWatch TempTime  = new StopWatch();
                            logger.error("[CloudRunTest] CommonCmsACardTempToCardTempBatch 시작 ");
                            TempTime.start();
                              for(int i=0;i<arrCmsData.size();i++) {
                                  try {
                                      if(arrCmsData.size() > 0) {
                                          sb.append(arrCmsData.get(i).makeTempCardData());
                                          
                                          if(i%5000==0) {
                                              CommonCmsACardTempToCardTempBatch(sb,mapCmsSyncParams);
                                              sb.setLength(0);
                                          }
                                          if(i==arrCmsData.size()-1) {
                                              CommonCmsACardTempToCardTempBatch(sb,mapCmsSyncParams);
                                              sb.setLength(0);
                                          }
                                      }
                                      
                                  } catch (Exception e) {
                                      logger.error("ACARD_TEMP 인입중 오류 발생" + e.toString());
                                      e.printStackTrace();
                                  }   
                              }
                              TempTime.stop();
                              logger.error("[CloudRunTest] CommonCmsACardTempToCardTempBatch 종료 ");
                              logger.error("[CloudRunTest " + mapCmsSyncParams.get("groupSeq") + "] CommonCmsACardTempToCardTempBatch 조회 걸린 시간 : " + TempTime.getTotalTimeSeconds()  );
                              
                          }
                          else {
                              for (CommonBatchCmsDataVO cbcd : arrCmsData) {
                                  Thread.sleep(20);
                                  cbcd.setGroupSeq(custInfo.get("GROUP_SEQ"));

                                  if(cbcd.getAmtAmount( ).equals( "" )){
                                      cbcd.setAmtAmount( "0" );
                                  } if(cbcd.getAmtMdAmount( ).equals( "" )){
                                      cbcd.setAmtMdAmount( "0" );
                                  } if(cbcd.getVatAmount( ).equals( "" )){
                                      cbcd.setVatAmount( "0" );
                                  } if(cbcd.getApprAmt( ).equals( "" )){
                                      cbcd.setApprAmt( "0" );
                                  } if(cbcd.getForAmount( ).equals( "" )){
                                      cbcd.setForAmount( "0" );
                                  } if(cbcd.getFreAmount( ).equals( "" )){
                                      cbcd.setFreAmount( "0" );
                                  } if(cbcd.getRequestAmount( ).equals( "" )){
                                      cbcd.setRequestAmount( "0" );
                                  } if(cbcd.getSerAmount( ).equals( "" )){
                                      cbcd.setSerAmount( "0" );
                                  } if(cbcd.getUsdAmount( ).equals( "" )){
                                      cbcd.setUsdAmount( "0" );
                                  } if(cbcd.getVatMdAmount( ).equals( "" )){
                                      cbcd.setVatMdAmount( "0" );
                                  }

                                  cbcd.setCHAIN_ADDR1(CommonConvert.NullToString(cbcd.getCHAIN_ADDR1()).replace("'", "`"));
                                  cbcd.setCHAIN_ADDR2(CommonConvert.NullToString(cbcd.getCHAIN_ADDR2()).replace("'", "`"));
                                  cbcd.setCHAIN_CEO_NM(CommonConvert.NullToString(cbcd.getCHAIN_CEO_NM()).replace("'", "`"));

                                  if (!cmsSyncTypeNewAll) {
                                      if ((daoBizbox.CommonCmsCardTempInfoInsert(cbcd)) > 0 && (con.getErpTypeCode().equals(commonCode.ERPIU) || con.getErpTypeCode().equals(commonCode.ICUBE))) {
                                          if (con.getErpTypeCode().equals(commonCode.ERPIU)) {
                                              Map<String, Object> mapSync = new HashMap<String, Object>();
                                              mapSync.put("acctNo", cbcd.getAcctNo());
                                              mapSync.put("bankCode", cbcd.getBankCode());
                                              mapSync.put("tradeDate", cbcd.getTradeDate());
                                              mapSync.put("tradeTime", cbcd.getTradeTime());
                                              mapSync.put("seq", cbcd.getSeq());
                                              arrCmsSyncUpdateParams.add(mapSync);
                                          }
                                      }
                                  }
                              }


                              if (con.getErpTypeCode().equals(commonCode.ERPIU)) {
                                  // ERPiU 상태값 업데이트
                                  arrCmsSyncUpdateParams = (arrCmsSyncUpdateParams == null ? new ArrayList<Map<String, Object>>() : arrCmsSyncUpdateParams);
                                  try {
                                      daoERPiU.CommonCmsERPiUInfoListUpdate(con, arrCmsSyncUpdateParams);
                                  } catch (Exception e) {
                                      e.printStackTrace();
                                      logger.error("ERPiU CMS 동기화 내역 업데이트 진행중 오류가 발생되었습니다.");
                                  }
                              }   
                          }
                         
                          
                          try {
                              daoBizbox.CommonCmsConfigInfoModifyDate(custInfo);
                          } catch (Exception e) {
                              e.printStackTrace();
                              logger.error("CMS 동기화 시간 업데이트 진행중 오류가 발생되었습니다.");
                          }
                          
                      }
                  }
                  
                 
              }
              
              logger.error("[" + custInfo.get(CloudConstants.GROUP_SEQ) + "] CMS 연동을 종료합니다. - " + custInfo.get(CloudConstants.OPERATE_STATUS_NAME));
              /* CMS 배치 중일땐 t_ex_cms_sync 상태값 N->Y 변경*/

          } else {
              logger.error("[" + custInfo.get(CloudConstants.GROUP_SEQ) + "] 해지된 고객사로 더이상 CMS 연동을 지원하지 않습니다. - " + custInfo.get(CloudConstants.OPERATE_STATUS_NAME));
          }
        }
      }
     
      stopWatch.stop();

      logger.error("[CloudRunTest] 새로운 batch 종료");
      logger.error("CMS Batch 걸린 시간차이(m) : {} 입니다.", stopWatch.getTotalTimeSeconds());
      
      return isSuccess;
  }

  @Override
  public void CommonCmsACardTempToCardTempBatch(StringBuffer sb, Map<String, Object> custInfo) throws Exception {
      daoBizbox.CommonCmsACardTempTrunate(custInfo);
      daoBizbox.CommonCmsACardTempInfoInsert(sb,custInfo);
    
      /* insert update 진행 */
      daoBizbox.CommonCmsCardTempUpdate(custInfo);
      daoBizbox.CommonCmsCardTempInsert(custInfo);
  }
  

}
