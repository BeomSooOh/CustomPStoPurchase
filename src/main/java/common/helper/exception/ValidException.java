package common.helper.exception;

import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;

@SuppressWarnings ( "serial" )
public class ValidException extends Exception {

	ResultVO result;
	
	public ValidException ( String msg ) {
		super( msg );

		result = new ResultVO( );
		makeResult(msg);
	}
	
	private void makeResult(String message){
		result.setResultCode( commonCode.FAIL );
		result.setResultName( message );
	}
	
	public ResultVO getResult(){
		return result;
	}
}
