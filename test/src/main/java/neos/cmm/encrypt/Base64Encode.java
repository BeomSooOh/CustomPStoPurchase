package neos.cmm.encrypt;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.stereotype.Service;

import com.sun.star.security.KeyException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


@SuppressWarnings ( "restriction" )
@Service ( "Base64Encode" )
public class Base64Encode implements Encryptor {

	@Override
	public String encrypt ( String plainText ) throws UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		// TODO Auto-generated method stub
		BASE64Encoder encoder = new BASE64Encoder( );
		return encoder.encode( plainText.getBytes( "UTF-8" ) );
	}

	@Override
	public String decrypt ( String encryptedText ) throws KeyException, GeneralSecurityException, GeneralSecurityException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, IOException {
		// TODO Auto-generated method stub
		BASE64Decoder decoder = new BASE64Decoder( );
		return new String( decoder.decodeBuffer( encryptedText ), "UTF-8" );
	}
}
