package expend.ex.user.expend;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;


@Repository ( "FExUserFileServiceDAO" )
public class FExUserFileServiceDAO {

	//public ResultVO ReadHtmlCodeForEx ( Map<String, Object> params ) {
	public ResultVO ReadHtmlCodeForEx ( ) {
		ResultVO result = new ResultVO( );
		Map<String, Object> info = new HashMap<String, Object>( );
		StringBuilder contentBuilder = new StringBuilder( );
		try {
			BufferedReader in = new BufferedReader( new FileReader( ".." ) );
			String str;
			while ( (str = in.readLine( )) != null ) {
				contentBuilder.append( str );
			}
			in.close( );
		}
		catch ( IOException e ) {
			e.printStackTrace();
		}
		String content = contentBuilder.toString( );
		info.put( "fileName", commonCode.EMPTYSTR );
		info.put( "htmlCode", content );
		info.put( "filePath", "~/~/~" );
		result.addAaData( info );
		return result;
	}
}