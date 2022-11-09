package expend.trip.user.cons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import expend.trip.user.option.FTripUserOptionService;


@Service ( "BTripUserConsService" )
public class BTripUserConsServiceImpl implements BTripUserConsService {

	@Resource ( name = "FTripUserConsServiceA" )
	private FTripUserConsService consA; /* Bizbox Alpha */
	@Resource ( name = "FTripUserOptionServiceA" )
	private FTripUserOptionService serviceOption;

	/** 출장 품의 문서 생성 **/
	@Override
	public ResultVO insertTripConsDoc ( Map<String, Object> params ) throws Exception {
		return consA.insertTripConsDoc( params );
	}

	/** 출장 품의 문서 정보 조회 **/
	@Override
	public ResultVO selectTripConsDocAllInfo ( Map<String, Object> params ) throws Exception {
		return consA.selectTripConsDocAllInfo( params );
	}
	
	/** 비영리 2.0 품의 문서 정보 조회 */
	@Override
	public ResultVO selectConsDocInfo ( Map<String, Object> params ) throws Exception {
		return consA.selectConsDocInfo( params );
	}
	
	/** 사용자 출장 품의 예산, 과목 정보 저장 **/
	@SuppressWarnings("unchecked")
	@Override
	public ResultVO insertTripConsBudgetInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		int isRepeatApproval =  Integer.parseInt(params.get("isReWrite").toString());
		try {
			HashMap consInfo = new HashMap<>();
			consInfo.put("consAmt", params.get("consAmt"));
			consInfo.put("tripDocSeq", params.get("tripDocSeq"));
			consInfo.put("consDocSeq", params.get("consDocSeq"));
			
			try {
				if(isRepeatApproval == 0) {
					/** 출장 품의 문서 예산 정보 저장 최초 작성 **/
					result = consA.insertTripConsBudget(consInfo);
					HashMap tripBudgetSeq = (HashMap) result.getaData();
					result = consA.selectConsBudgetInfo(consInfo);
					
					for(int i=0; i<result.getAaData().size() ;i++) {
						result.getAaData().get(i).put("tripBudgetSeq", tripBudgetSeq.get("tripBudgetSeq"));
						result.getAaData().get(i).put("tripDocSeq", consInfo.get("tripDocSeq"));
						/** 출장 품의 문서 과목 정보 저장 **/
						consA.insertTripConsBudgetErp(result.getAaData().get(i));
					}
				}
				else {
					try {
						consA.deleteTripConsBudgetInfo(consInfo);
						consA.deleteTripConsBudgetErpInfo(consInfo);
					} catch(Exception e1) {
						e1.printStackTrace();
						result.setFail("예산 정보 저장 중 삭제 실패");
					}
					
					result = consA.insertTripConsBudget(consInfo);
					HashMap tripBudgetSeq = (HashMap) result.getaData();
					result = consA.selectConsBudgetInfo(consInfo);
					
					for(int i=0; i<result.getAaData().size() ;i++) {
						result.getAaData().get(i).put("tripBudgetSeq", tripBudgetSeq.get("tripBudgetSeq"));
						result.getAaData().get(i).put("tripDocSeq", consInfo.get("tripDocSeq"));
						/** 출장 품의 문서 과목 정보 저장 **/
						consA.insertTripConsBudgetErp(result.getAaData().get(i));
					}
					
				}
				
			} catch(Exception ex) {
				ex.printStackTrace();
				result.setFail("예산 정보 저장 중 실패");
				try {
					consA.deleteTripConsBudgetInfo(consInfo);
					consA.deleteTripConsBudgetErpInfo(consInfo);
				} catch(Exception e) {
					e.printStackTrace();
					result.setFail("예산 정보 저장 중 삭제 실패");
				}
			}
			
			result.setSuccess();
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}

	/** 사용자 출장 품의 인사정보, 경비내역 정보 저장 **/
	@Override
	public ResultVO insertTripConsAttExInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> userInfo = CommonConvert.CommonGetJSONToMap( params.get( "userInfo" ).toString( ) );
			Map<String, Object> tripInfo = CommonConvert.CommonGetJSONToMap( params.get( "tripInfo" ).toString( ) );
			Map<String, Object> triperInfo = CommonConvert.CommonGetJSONToMap( params.get( "triperInfo" ).toString( ) );
			Map<String, Object> expenseInfo = CommonConvert.CommonGetJSONToMap( params.get( "expenseInfo" ).toString( ) );
			StringBuilder sb = new StringBuilder();
			
			userInfo.put("tripDocSeq", params.get("tripDocSeq"));
			tripInfo.put("tripDocSeq", params.get("tripDocSeq"));
			try{			
				/** 출장 품의 문서 근태 정보 저장 **/
				result = consA.insertTripConsAttend(tripInfo);
				/** 출장 품의 문서 출장자 정보 저장 **/
				result.setAaData(CommonConvert.CommonGetJSONToListMap(triperInfo.get("orgData").toString()));
				
				
				for(int i=0;i<result.getAaData().size();i++) {
					sb.append(",'");
					sb.append(result.getAaData().get(i).get("dutyCode").toString());
					sb.append("'");
				}
				HashMap<String,Object> dutyParam = new HashMap<>();
				
				dutyParam.put("dutyCode", sb.substring(1));		
				dutyParam.put("domesticCode",tripInfo.get("domesticCode"));
				dutyParam.put("compSeq",userInfo.get("compSeq"));
				ResultVO dutyItemResult = new ResultVO();
				dutyItemResult = serviceOption.selectOptionDutyItem(dutyParam);
				
				for(int i=0;i<result.getAaData().size();i++) {
					HashMap<String,Object> tripParam = (HashMap<String, Object>) result.getAaData().get(i);
					String dutyCode = tripParam.get("dutyCode").toString();
					
					for(int j=0;j<dutyItemResult.getAaData().size();j++) {
						if(dutyCode.equals(dutyItemResult.getAaData().get(j).get("dutyCode"))) {
							tripParam.put("dutyItemSeq",dutyItemResult.getAaData().get(j).get("dutyItemSeq").toString() );
							tripParam.put("dutyGroupSeq",dutyItemResult.getAaData().get(j).get("dutyGroupSeq").toString() );
							break;
						} else {
							tripParam.put("dutyItemSeq",0);
							tripParam.put("dutyGroupSeq",0 );
						}
					}
					tripParam.put("attendSeq", result.getaData().get("attendSeq"));					
					tripParam.put("tripDocSeq", params.get("tripDocSeq"));
					
					consA.insertTripConsTraveler(tripParam);	
				}
				
				result.setAaData(CommonConvert.CommonGetJSONToListMap(expenseInfo.get("expenseData").toString()));
				ArrayList<HashMap<String,Object>> expenseParam = new ArrayList<HashMap<String,Object>>();
				
				for(int i=0;i<result.getAaData().size();i++) {
					HashMap<String,Object> expenseTempParam = (HashMap<String, Object>) result.getAaData().get(i);
					
					for(int j=0; j<6 ;j++) {
						HashMap<String,Object> temp = new HashMap<>();
						temp.put("tripDocSeq", params.get("tripDocSeq"));
						temp.put("amtClassCode", (j+1));
						temp.put("amtClassName", expenseTempParam.get("amtClass" + (j+1) + "Name"));
						temp.put("expenseAmt", expenseTempParam.get("amtClass" + (j+1) + "Amt"));
						temp.put("compSeq", expenseTempParam.get("compSeq"));
						temp.put("compName", expenseTempParam.get("compName"));
						temp.put("empSeq", expenseTempParam.get("empSeq"));
						temp.put("empName", expenseTempParam.get("empName"));
						temp.put("dutyItemSeq", expenseTempParam.get("dutyItemSeq"));
						temp.put("dutyName",expenseTempParam.get("dutyName"));
						temp.put("dutyGroupSeq", expenseTempParam.get("dutyGroupSeq"));
						temp.put("transportSeq", expenseTempParam.get("transportSeq"));
						temp.put("locationSeq", expenseTempParam.get("locationSeq"));
						temp.put("amtSeq", expenseTempParam.get("amtClass" + (j+1) + "Seq"));
						temp.put("domesticCode", expenseTempParam.get("amtClass" +(j+1) + "DomesticCode"));
						
						expenseParam.add(temp);
					}
				}
				/** 출장 품의 문서 경비 내역 정보 저장 **/
				for(int i=0;i<expenseParam.size();i++) {
					consA.insertTripConsExpense(expenseParam.get(i));
				}
				result.setSuccess( );
				
			} catch(Exception ex) {
				result.setFail("사용자 출장 품의 인사정보, 경비내역 정보 저장 실패");
				try {
				consA.deleteTripConsAttend(params);
				consA.deleteTripConsExpense(params);
				consA.deleteTripConsTraveler(params);
				} catch(Exception e) {
					ex.printStackTrace();
					result.setFail("사용자 출장 품의 인사정보, 경비내역 정보 삭제 실패");
				}
			}
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}


	/** 사용자 출장 품의 인사정보, 경비내역 정보 저장 **/
	@Override
	public ResultVO updateTripConsAttExInfo ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			Map<String, Object> userInfo = CommonConvert.CommonGetJSONToMap( params.get( "userInfo" ).toString( ) );
			Map<String, Object> tripInfo = CommonConvert.CommonGetJSONToMap( params.get( "tripInfo" ).toString( ) );
			Map<String, Object> triperInfo = CommonConvert.CommonGetJSONToMap( params.get( "triperInfo" ).toString( ) );
			Map<String, Object> expenseInfo = CommonConvert.CommonGetJSONToMap( params.get( "expenseInfo" ).toString( ) );
			StringBuilder sb = new StringBuilder();
			
			userInfo.put("tripDocSeq", params.get("tripDocSeq"));
			tripInfo.put("tripDocSeq", params.get("tripDocSeq"));
			try{			
				/** 출장 품의 문서 근태 정보 수정 **/
				consA.updateTripConsAttend(tripInfo);
				
				/** 출장 품의 문서 출장자 정보 수정 **/
				/* 1. 출장자 정보 재배열 */
				result.setAaData(CommonConvert.CommonGetJSONToListMap(triperInfo.get("orgData").toString()));
				for(int i=0;i<result.getAaData().size();i++) {
					sb.append(",'");
					sb.append(result.getAaData().get(i).get("dutyCode").toString());
					sb.append("'");
				}
				HashMap<String,Object> dutyParam = new HashMap<>();
				
				dutyParam.put("dutyCode", sb.substring(1));		
				dutyParam.put("domesticCode",tripInfo.get("domesticCode"));
				dutyParam.put("compSeq", userInfo.get("compSeq"));
				ResultVO dutyItemResult = new ResultVO();
				dutyItemResult = serviceOption.selectOptionDutyItem(dutyParam);

				/* 2. 출장자 정보 일괄 삭제  */
				consA.deleteTripConsTraveler( params );
				
				/* 3. 출장자 정보 일괄 삭제 이후 재 입력 */
				for(int i=0;i<result.getAaData().size();i++) {
					HashMap<String,Object> tripParam = (HashMap<String, Object>) result.getAaData().get(i);
					String dutyCode = tripParam.get("dutyCode").toString();
					
					for(int j=0;j<dutyItemResult.getAaData().size();j++) {
						if(dutyCode.equals(dutyItemResult.getAaData().get(j).get("dutyCode"))) {
							tripParam.put("dutyItemSeq",dutyItemResult.getAaData().get(j).get("dutyItemSeq").toString() );
							tripParam.put("dutyGroupSeq",dutyItemResult.getAaData().get(j).get("dutyGroupSeq").toString() );
							break;
						} else {
							tripParam.put("dutyItemSeq",0);
							tripParam.put("dutyGroupSeq",0 );
						}
					}
					tripParam.put("attendSeq", result.getaData().get("attendSeq"));					
					tripParam.put("tripDocSeq", params.get("tripDocSeq"));
					
					consA.insertTripConsTraveler(tripParam);	
				}
				
				result.setAaData(CommonConvert.CommonGetJSONToListMap(expenseInfo.get("expenseData").toString()));
				ArrayList<HashMap<String,Object>> expenseParam = new ArrayList<HashMap<String,Object>>();
				
				for(int i=0;i<result.getAaData().size();i++) {
					HashMap<String,Object> expenseTempParam = (HashMap<String, Object>) result.getAaData().get(i);
					
					for(int j=0; j<6 ;j++) {
						HashMap<String,Object> temp = new HashMap<>();
						temp.put("tripDocSeq", params.get("tripDocSeq"));
						temp.put("amtClassCode", (j+1));
						temp.put("amtClassName", expenseTempParam.get("amtClass" + (j+1) + "Name"));
						temp.put("expenseAmt", expenseTempParam.get("amtClass" + (j+1) + "Amt"));
						temp.put("compSeq", expenseTempParam.get("compSeq"));
						temp.put("compName", expenseTempParam.get("compName"));
						temp.put("empSeq", expenseTempParam.get("empSeq"));
						temp.put("empName", expenseTempParam.get("empName"));
						temp.put("dutyItemSeq", expenseTempParam.get("dutyItemSeq"));
						temp.put("dutyName",expenseTempParam.get("dutyName"));
						temp.put("dutyGroupSeq", expenseTempParam.get("dutyGroupSeq"));
						temp.put("transportSeq", expenseTempParam.get("transportSeq"));
						temp.put("locationSeq", expenseTempParam.get("locationSeq"));
						temp.put("amtSeq", expenseTempParam.get("amtClass" + (j+1) + "Seq"));
						temp.put("domesticCode", expenseTempParam.get("amtClass" +(j+1) + "DomesticCode"));
						
						expenseParam.add(temp);
					}
				}
				/** 출장 품의 문서 경비 내역 정보 저장 **/
				consA.deleteTripConsExpense(params);
				for(int i=0;i<expenseParam.size();i++) {
					consA.insertTripConsExpense(expenseParam.get(i));
				}
				result.setSuccess( );
				
			} catch(Exception ex) {
				result.setFail("사용자 출장 품의 인사정보, 경비내역 정보 저장 실패");
				try {
				consA.deleteTripConsAttend(params);
				consA.deleteTripConsExpense(params);
				consA.deleteTripConsTraveler(params);
				} catch(Exception e) {
					ex.printStackTrace();
					result.setFail("사용자 출장 품의 인사정보, 경비내역 정보 삭제 실패");
				}
			}
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}
	
	/** 사용자 출장 품의 현황 정보 조회 **/
	@Override
	public ResultVO selectTripConsReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = consA.selectTripConsReport( params ); 
		}catch(Exception ex){
			result.setFail( "사용자 정보조 조회에 실패하였습니다.", ex );
		}
		return result;
	}


}
