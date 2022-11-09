package common.helper.exception;

@SuppressWarnings ( "serial" )
public class NotFoundLoginSessionException extends Exception {
	
	public NotFoundLoginSessionException(String message){
		super(message);
	}
}
