package common.helper.exception;

@SuppressWarnings ( "serial" )
public class NotFoundConnectionException extends Exception {
	
	public NotFoundConnectionException(String message){
		super(message);
	}
}
