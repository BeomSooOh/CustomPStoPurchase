package expend.np.admin.etax;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.CommonInterface.commonCode;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("BNpAdminETaxService")
public class BNpAdminETaxServiceImpl implements BNpAdminETaxService {

	@Resource(name = "FNpAdminETaxServiceA")
	private FNpAdminETaxService	serviceA;

	@Resource(name = "FNpAdminETaxServiceI")
	private FNpAdminETaxService	serviceI;

	@Resource(name = "FNpAdminETaxServiceU")
	private FNpAdminETaxService	serviceU;

	/* 매입전자세금계산서 목록 조회 */
	public ResultVO GetETaxList(ResultVO param, ConnectionVO conVo) throws Exception {

		/* ----------------- 매입전자 세금 계산서 리스트 조회 ----------------- */
		/* local variable */
		ResultVO result = new ResultVO();
		FNpAdminETaxService impl = null;
		List<Map<String, Object>> eTaxSendList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> eTaxNotUseList = new ArrayList<Map<String, Object>>();

		switch (conVo.getErpTypeCode()) {
			case commonCode.ICUBE:
				impl = serviceI;
				break;
			case commonCode.ERPIU:
				impl = serviceU;
				break;
			default:
				throw new Exception("ERP 연결설정 확인 필요");
		}

		/* [1] ERP 세금 계산서 데이터 조회 */
		ResultVO erpEtaxResult2 = impl.GetETaxList2(param, conVo);
		if(!erpEtaxResult2.getResultCode( ).equals( commonCode.SUCCESS )){
			return erpEtaxResult2;
		}
		
		/* [2] 미사용 목록및 상신 리스트 조회 */
		ResultVO filterResult = serviceA.GetETaxFilterList( param );
		if(!filterResult.getResultCode( ).equals( commonCode.SUCCESS )){
			return filterResult;
		}
		if(filterResult.getAaData( ).size( ) != 3){
			throw new Exception("세금계산서 필터 조회 중 알 수 없는 오류 발생");
		}
		String sendFilter = filterResult.getAaData( ).get( 0 ).get( "superKeys" ).toString( );
		String noUseFilter = filterResult.getAaData( ).get( 1 ).get( "superKeys" ).toString( );
		String receiveFilter = filterResult.getAaData( ).get( 2 ).get( "superKeys" ).toString( );
		
		/* [3] 세금계산서 필터링 진행 */
		List<Map<String, Object>> filterdList = new ArrayList();
		for(Map<String, Object> item : erpEtaxResult2.getAaData( )){

			String issDt = item.get( "issDt" ).toString( );
			String issNo = item.get( "issNo" ).toString( );
			String issNo2 = CommonConvert.NullToString( item.get( "issNo2" ) );
			
			/* 1. 상신 리스트 처리 */
			String regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			Pattern p = Pattern.compile( regex );
			Matcher m = p.matcher( sendFilter );
			boolean catchem = false;
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put( "approYN", "Y" );
				item.put( "approYn", "Y" );
				item.put( "appro_yn", "Y" );
				item.put( "sendYN", "Y" );
				item.put( "sendYn", "Y" );
				item.put( "send_yn", "Y" );
				item.put("approEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				item.put("createEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				catchem = true;
			}
			if( !issNo2.equals( "" ) && (!catchem) ){
				// regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■$";
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( sendFilter );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put( "approYN", "Y" );
					item.put( "approYn", "Y" );
					item.put( "appro_yn", "Y" );
					item.put( "sendYN", "Y" );
					item.put( "sendYn", "Y" );
					item.put( "send_yn", "Y" );
					item.put("approEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
					item.put("createEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}	
			}
			/* 2. 이관내역 리스트 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			p = Pattern.compile( regex );
			m = p.matcher( receiveFilter );
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put("receiveYn", "Y");
				item.put("receiveYN", "Y");
				item.put("receive_yn", "Y");
				item.put("receiveName", superKey.split( "Σ" )[2].replace( "■", "" ));
			}
			if(!issNo2.equals( "" )){
				// regex = issDt + "Σ" + "[\\S\\s]+Σ" + issNo2 + "■$";
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( receiveFilter );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put("receiveYn", "Y");
					item.put("receiveYN", "Y");
					item.put("receive_yn", "Y");
					item.put("receiveName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}
			}
			/* 3. 미사용 리스트 처리 */
			regex = issDt + "Σ" + issNo + "Σ" + "[\\S\\s]+" + "■$";
			
			
			p = Pattern.compile( regex );
			m = p.matcher( noUseFilter );
			while ( m.find( ) ) {
				String superKey = m.group( ).split("■")[0];
				item.put("useYn", "N");
				item.put("useYN", "N");
				item.put("use_yn", "N");
				item.put("notUseEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
			}
			
			if( !issNo2.equals( "" )){
				// regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■$";
				regex = issDt + "Σ" + "[\\S\\s]+" + issNo2 + "■";
				p = Pattern.compile( regex );
				m = p.matcher( noUseFilter );
				while ( m.find( ) ) {
					String superKey = m.group( ).split("■")[0];
					item.put("useYn", "N");
					item.put("useYN", "N");
					item.put("use_yn", "N");
					item.put("notUseEmpName", superKey.split( "Σ" )[2].replace( "■", "" ));
				}
			}
			
			filterdList.add( item );
		}

		/* [5] 데이터 반환 */
		param.setAaData( filterdList );
		param.setSuccess( );
		return param;
	}
	
	public ResultVO GetETaxTransHistoryList(ResultVO param) throws Exception {
		/* VO */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO temp = new ResultVO();

		/* 카드사용내역 이관 목록 조회 */
		param = serviceA.GetETaxTransHistoryList(param);
		return param;
	}

}
