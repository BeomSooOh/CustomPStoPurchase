package expend.ez.user.sendInfo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FEzSendInfoGWDAO" )
public class FEzSendInfoGWDAO extends EgovComAbstractDAO {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/* 이지바로 GW 마스터 정보 생성하기 */
	public Map<String, Object> EzMasterInfoInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzMasterInfoInsert", params );
			returnSeq.put( "master_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}

	/* 이지바로 ERP 마스터 정보 생성하기 */
	public Map<String, Object> EzErpMasterInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzErpMasterInsert", params );
			returnSeq.put( "erp_master_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}

	/* 이지바로 Gw ERP 슬레이브 정보 생성하기 */
	public Map<String, Object> EzErpSlaveInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzErpSlaveInsert", params );
			returnSeq.put( "erp_slave_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}

	/* 이지바로 Gw 파라메터 정보 생성하기 */
	public Map<String, Object> EzGwParamsInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzGwParamsInsert", params );
			returnSeq.put( "param_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}

	/* 이지바로 Gw 정보 생성하기 */
	public Map<String, Object> EzGwMasterInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzGwMasterInsert", params );
			returnSeq.put( "gw_master_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}

	/* 이지바로 Gw 정보 생성하기 */
	public Map<String, Object> EzGwSlaveInsert ( Map<String, Object> params ) {
		Map<String, Object> returnSeq = new HashMap<String, Object>( );
		int resultValue = 0;
		try {
			resultValue = (int) this.insert( "EzGWSQL.EzGwSlaveInsert", params );
			returnSeq.put( "gw_slave_seq", resultValue );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
		}
		return returnSeq;
	}
}
