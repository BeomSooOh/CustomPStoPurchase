package devmanager.cms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.CommonInterface.commonCode;


@Service ( "FDevManagerCMSServiceMaria" )
public class FDevManagerCMSServiceImplMaria implements FDevManagerCMSService {

	/* 변수정의 */
	@Resource ( name = "FDevManagerCMSDAOMaria" )
	private FDevManagerCMSDAOMaria cmsMariaDAO;

	@Override
	public List<Map<String, Object>> SelectCMSLogList ( Map<String, Object> param ) {
		List<Map<String, Object>> returnList = new ArrayList<>( );
		List<Map<String, Object>> searchedList = new ArrayList<>( );
		try {
			searchedList = (List<Map<String, Object>>) cmsMariaDAO.SelectCMSLogList( param );
			for ( Map<String, Object> item : searchedList ) {
				Map<String, Object> temp = new HashMap<String, Object>( );
				temp.put( "batchSeq", item.get( "batchSeq" ).toString( ) );
				temp.put( commonCode.COMPSEQ, item.get( commonCode.COMPSEQ ).toString( ) );
				temp.put( commonCode.MODULE, item.get( commonCode.MODULE ).toString( ) );
				temp.put( commonCode.TYPE, item.get( commonCode.TYPE ).toString( ) );
				temp.put( commonCode.MESSAGE, item.get( commonCode.MESSAGE ).toString( ) );
				temp.put( "createDate", item.get( "createDate" ).toString( ) );
				temp.put( commonCode.COMPNAME, item.get( commonCode.COMPNAME ).toString( ) );
				temp.put( "bizError", false );
				returnList.add( temp );
			}
		}
		catch ( Exception e ) {
			/* 예외가 발생하면 에러 메시지 전달 */
			returnList.clear( );
			Map<String, Object> o = new HashMap<String, Object>( );
			o.put( "bizError", true );
			o.put( "bizErrorMsg", false );
			returnList.add( o );
		}
		return returnList;
	}
}