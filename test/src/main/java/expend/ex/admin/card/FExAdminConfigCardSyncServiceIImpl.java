package expend.ex.admin.card;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import main.web.BizboxAMessage;


@Service ( "FExAdminConfigCardSyncServiceI" )
public class FExAdminConfigCardSyncServiceIImpl implements FExAdminConfigCardSyncService {

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminCardServiceADAO" )
	private FExAdminCardServiceADAO cardADAO;
	@Resource ( name = "FExAdminConfigCardSyncServiceIDAO" )
	private FExAdminConfigCardSyncServiceIDAO syncIDAO;

	/* ERP 카드 정보 조회 하여 동기화 작업 진행 */
	/**
	 *   * @Method Name : ExCodeCardInfoFromErpCopy
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 카드 정보 조회하여 동기화 작업 진행
	 *   * @param params
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeCardInfoFromErpCopy ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardiCUBEService - ExCodeCardInfoFromErpCopy" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + params.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* ERP 카드 조회 */
			List<Map<String, Object>> cardListVo = this.ExCodeCardListInfoSelect( params, conVo ).getAaData( );
			/* 그룹웨어 데이터 조회 */
			params.put("eaType", CommonConvert.CommonGetEmpVO().getEaType()); /* 비영리 연동 파라미터 추가 */
			params.put("selPublic", "A"); /* 비영리 연동 파라미터 추가 */
			List<Map<String, Object>> gwData = cardADAO.ExCodeCardInfoSelect( params ).getAaData( );
			HashMap<String, Object> jsonMap = new HashMap<>( );
			for ( Map<String, Object> item : gwData ) {
				String jsonKey = item.get( "compSeq" ).toString( ) + "|" + item.get( "cardCode" ).toString( );
				jsonMap.put( jsonKey, item.get( "cardPublicJson" ) );
			}
			/* 그룹웨어 카드 데이터 모두 삭제 */
			cardADAO.ExCodeCardInfoDeleteAll( params );
			/* ERP 데이터 그룹웨어 이관 */
			if ( cardListVo.size( ) > 0 ) {
				for ( Map<String, Object> item : cardListVo ) {
					item.put( "compSeq", params.get( "compSeq" ).toString( ) );
					item.put( "createSeq", params.get( "createSeq" ).toString( ) );
					item.put( "modifySeq", params.get( "modifySeq" ).toString( ) );
					// 저장되있던 제이슨 데이터 반영.
					String jsonKey = item.get( "compSeq" ).toString( ) + "|" + item.get( "cardCode" ).toString( );
					if ( jsonMap.get( jsonKey ) != null ) {
						item.put( "cardPublicJson", jsonMap.get( jsonKey ) );
					}
					else {
						item.put( "cardPublicJson", commonCode.EMPTYSTR );
					}
					cardADAO.ExCodeCardInfoInsert( item );
				}
			}
			/* 결과 처리 */
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardiCUBEService - ExCodeCardInfoFromErpCopy" );
		return resultVo;
	}

	/* ERP 카드 정보 조회 */
	/**
	 *   * @Method Name : ExCodeCardListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 카드 정보 조회
	 *   * @param params
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExCodeCardListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		resultVo.setAaData( syncIDAO.ExCommonCodeCardSelect( params, conVo ) );
		return resultVo;
	}
}
