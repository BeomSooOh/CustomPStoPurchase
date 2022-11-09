package neos.cmm.exp;

@SuppressWarnings ( "serial" )
public class InsufficiencyParameterException extends Exception {

	public InsufficiencyParameterException ( String message ) {
		super( message );
	}

	public InsufficiencyParameterException ( Throwable cause ) {
		super( cause );
	}
}
