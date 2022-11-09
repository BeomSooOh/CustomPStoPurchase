package expend.ex.master.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "FExMasterConfigServiceA" )
public class FExMasterConfigServiceAImpl implements FExMasterConfigService {

	/* 변수정의 - DAO */
	@Resource ( name = "FExMasterConfigServiceADAO" )
	private FExMasterConfigServiceADAO exMasterConfigServiceADAO; /* ERP iCUBE */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */

	/* 공통코드 - ERP 가져오기 */
	/**
	 *   * @Method Name : ExCodeCardInfoFromErpCopy
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 공통코드 - ERP 가져오기
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		return null;
	}

	/* 주석없음 */
	/**
	 *   * @Method Name : ExCodeVatTypeListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param vatTypeVo
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public List<Map<String, Object>> ExCodeVatTypeListInfoSelect ( Map<String, Object> vatTypeVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeVatBizboxAService - ExCodeVatTypeListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeAuthVO vatTypeVo >> " + vatTypeVo.toString( ) );
		List<Map<String, Object>> vatTeypListVo = new ArrayList<Map<String, Object>>( );
		try {
			vatTeypListVo = exMasterConfigServiceADAO.ExCodeVatTypeListInfoSelect( vatTypeVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExCodeAuthVO> vatTeypListVo >> " + vatTeypListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeVatBizboxAService - ExCodeVatTypeListInfoSelect" );
		return vatTeypListVo;
	}
}