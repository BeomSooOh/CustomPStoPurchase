package expend.trip.user.res;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import expend.trip.user.option.FTripUserOptionService;


@Service ( "BTripUserResService" )
public class BTripUserResServiceImpl implements BTripUserResService {

	@Resource ( name = "FTripUserResServiceA" )
	private FTripUserResService resA; /* Bizbox Alpha */
	@Resource ( name = "FTripUserOptionServiceA" )
	private FTripUserOptionService serviceOption;

	/** 출장 결의 문서 생성 **/
	@Override
	public ResultVO insertTripResDoc ( Map<String, Object> params ) throws Exception {
		return resA.insertTripResDoc( params );
	}

	/** 출장 결의 문서 정보 조회 **/
	@Override
	public ResultVO selectTripResDocAllInfo ( Map<String, Object> params ) throws Exception {
		return resA.selectTripResDocAllInfo( params );
	}
	
	/** 비영리 2.0 결의 문서 정보 조회 */
	@Override
	public ResultVO selectResDocInfo ( Map<String, Object> params ) throws Exception {
		return resA.selectResDocInfo( params );
	}
	
	/** 사용자 출장 결의 예산, 과목 정보 저장 **/
	@SuppressWarnings("unchecked")
	@Override
	public ResultVO insertTripResBudgetInfo ( Map<String, Object> params ) throws Exception {
	    ResultVO result = new ResultVO( );
	    int isRepeatApproval =  Integer.parseInt(params.get("isReWrite").toString());
	    try {
	        HashMap resInfo = new HashMap<>();
	        resInfo.put("resAmt", params.get("resAmt"));
	        resInfo.put("tripDocSeq", params.get("tripDocSeq"));
	        resInfo.put("resDocSeq", params.get("resDocSeq"));
	        
	        try {
	            if(isRepeatApproval == 0) {
	                /** 출장 결의 문서 예산 정보 저장 최초 작성 **/
	                result = resA.insertTripResBudget(resInfo);
	                HashMap tripBudgetSeq = (HashMap) result.getaData();
	                result = resA.selectResBudgetInfo(resInfo);
	                
	                for(int i=0; i<result.getAaData().size() ;i++) {
	                    result.getAaData().get(i).put("tripBudgetSeq", tripBudgetSeq.get("tripBudgetSeq"));
	                    result.getAaData().get(i).put("tripDocSeq", resInfo.get("tripDocSeq"));
	                    /** 출장 결의 문서 과목 정보 저장 **/
	                    resA.insertTripResBudgetErp(result.getAaData().get(i));
	                }
	            }
	            else {
	                try {
	                    resA.deleteTripResBudgetInfo(resInfo);
	                    resA.deleteTripResBudgetErpInfo(resInfo);
	                } catch(Exception e1) {
	                    e1.printStackTrace();
	                    result.setFail("예산 정보 저장 중 삭제 실패");
	                }
	                
	                result = resA.insertTripResBudget(resInfo);
	                HashMap tripBudgetSeq = (HashMap) result.getaData();
	                result = resA.selectResBudgetInfo(resInfo);
	                
	                for(int i=0; i<result.getAaData().size() ;i++) {
	                    result.getAaData().get(i).put("tripBudgetSeq", tripBudgetSeq.get("tripBudgetSeq"));
	                    result.getAaData().get(i).put("tripDocSeq", resInfo.get("tripDocSeq"));
	                    /** 출장 결의 문서 과목 정보 저장 **/
	                    resA.insertTripResBudgetErp(result.getAaData().get(i));
	                }
	                
	            }
		        result.setSuccess();

	        } catch(Exception ex) {
	            ex.printStackTrace();
	            result.setFail("예산 정보 저장 중 실패");
	            try {
	                resA.deleteTripResBudgetInfo(resInfo);
	                resA.deleteTripResBudgetErpInfo(resInfo);
	            } catch(Exception e) {
	                e.printStackTrace();
	                result.setFail("예산 정보 저장 중 삭제 실패");
	            }
	        }
	        
	    }
	    catch ( Exception ex ) {
	        result.setFail( "데이터 저장 중 오류 발생", ex );
	    }
	    return result;
	}
	
	/** 사용자 출장 결의 인사정보, 경비내역 정보 저장 **/
	@Override
	public ResultVO insertTripResAttExInfo ( Map<String, Object> params ) throws Exception {
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
				/** 출장 결의 문서 근태 정보 저장 **/
				resA.deleteTripResAttend(params);
				result = resA.insertTripResAttend(tripInfo);
				/** 출장 결의 문서 출장자 정보 저장 **/
				
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
				
				resA.deleteTripResTraveler(params);
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
					resA.insertTripResTraveler(tripParam);	
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
				/** 출장 결의 문서 경비 내역 정보 저장 **/
				resA.deleteTripResExpense(params);
				for(int i=0;i<expenseParam.size();i++) {
					resA.insertTripResExpense(expenseParam.get(i));
				}
				
			} catch(Exception ex) {
				result.setFail("사용자 출장 결의 인사정보, 경비내역 정보 저장 실패");
				try {
				resA.deleteTripResAttend(params);
				resA.deleteTripResExpense(params);
				resA.deleteTripResTraveler(params);
				} catch(Exception e) {
					ex.printStackTrace();
					result.setFail("사용자 출장 결의 인사정보, 경비내역 정보 삭제 실패");
				}
				return result;
			}
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "데이터 저장 중 오류 발생", ex );
		}
		return result;
	}



	/** 사용자 출장 결의 현황 정보 조회 **/
	@Override
	public ResultVO selectTripResReport ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = resA.selectTripResReport( params ); 
		}catch(Exception ex){
			result.setFail( "사용자 정보조 조회에 실패하였습니다.", ex );
		}
		return result;		
	}
	
	/** 사용자 참조품의 리스트 조회 **/
	@Override
	public ResultVO selectConfferList ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "deptSeq", loginVo.getOrgnztId( ) );
			result = resA.selectConfferList( params ); 
		}catch(Exception ex){
			result.setFail( "사용자 정보조 조회에 실패하였습니다.", ex );
		}
		return result;		
	}
	
	/** 사용자 참조품의 정보 반영 **/
	@Override
	public ResultVO updateTripConfferCons ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try{
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "empSeq", loginVo.getUniqId( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result = resA.updateTripConfferCons( params ); 
		}catch(Exception ex){
			result.setFail( "사용자 정보조 조회에 실패하였습니다.", ex );
		}
		return result;		
	}
}
