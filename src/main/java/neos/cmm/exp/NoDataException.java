package neos.cmm.exp;

@SuppressWarnings ( "serial" )
public class NoDataException extends Exception {

	public NoDataException ( String message ) {
		super( message );
	}

	public NoDataException ( Throwable cause ) {
		super( cause );
	}
}
