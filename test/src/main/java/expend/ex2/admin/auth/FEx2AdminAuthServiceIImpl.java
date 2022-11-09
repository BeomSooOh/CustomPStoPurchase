package expend.ex2.admin.auth;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
//import common.vo.common.CommonInterface.commonCode;


@Service ( "FEx2AdminAuthServiceI" )
public class FEx2AdminAuthServiceIImpl implements FEx2AdminAuthService {

	/* 변수정의 - DAO */
	@Resource ( name = "FEx2AdminAuthServiceIDAO" )
	private FEx2AdminAuthServiceIDAO dao;

	@Override
	public ResultVO setAdminAuthInsert ( ResultVO result ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO setAdminAuthUpdate ( ResultVO result ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO setAdminAuthDelete ( ResultVO result ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO setAdminAuthSelect ( ResultVO result ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO setAdminAuthListSelect ( ResultVO result ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResultVO setAdminAutoSelect ( ResultVO result, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> params = (List<Map<String, Object>>) (result.getAaData( ));
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>( );
		for ( Map<String, Object> item : params ) {
			item.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			List<Map<String, Object>> resultList = null;
			String acctType = item.get( "acctType" ).toString( );
			try {
				resultList = dao.setAdminAutoSelect( item, conVo );
			}
			catch ( Exception ex ) {
				resultList = new ArrayList<Map<String, Object>>( );
			}
			if ( resultList.size( ) != 1 ) {
				result.setFail( acctType );
				return result;
			}
			else {
				resultList.get( 0 ).put( "acctType", acctType );
				returnList.add( resultList.get( 0 ) );
			}
			result.setAaData( returnList );
			result.setSuccess( );
		}
		return result;
	}
}
