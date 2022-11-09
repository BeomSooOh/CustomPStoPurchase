package neos.cmm.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * AESCipher: AES 128bit 암호화
 *
 * 송준석  / 2014-11-13
 */

public class AESCipher {

	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(AESCipher.class);

	final static String SECRETKEY = "1023497555960596";

	// 암호화
	public static String AES_Encode(String str)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		byte[] keyData = SECRETKEY.getBytes();

		SecretKey secureKey = new SecretKeySpec(keyData, "AES");

		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.ENCRYPT_MODE, secureKey,
				new IvParameterSpec(SECRETKEY.getBytes()));

		byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
		String enStr = new String(Base64.encodeBase64(encrypted));

		return enStr;
	}

	// 복호화
	public static String AES_Decode(String str)
			throws java.io.UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException {
		byte[] keyData = SECRETKEY.getBytes();
		SecretKey secureKey = new SecretKeySpec(keyData, "AES");
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, secureKey,
				new IvParameterSpec(SECRETKEY.getBytes("UTF-8")));

		byte[] byteStr = Base64.decodeBase64(str.getBytes());

		return new String(c.doFinal(byteStr), "UTF-8");
	}

	/*
	// 보안성 획득 방안(키 생성 )
		1.	암호화를 하는 시점을 문자열로 받는다. 형식은 yyyyMMddHHmmss
		2.	해당 문자열을 암호화하여 accessToken으로 보낸다.
	// 보안성 획득 방안(키 유효성 체크)
		1.	암호화된 accessToken을 받아서 복호화한다.
		2.	날짜포맷이 맞는지 검증한다. 포맷은 yyyyMMddHHmmss
		3.	앞의 yyyyMMdd 만 빼내어 현재 날짜와 같은지 확인한다.
	*/
	@Test
	public static String makeAccessToken() throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException,
		NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException
	{
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault());
		String nowString = sdf.format(now);

		String accessToken = AESCipher.AES_Encode(nowString);

		//System.out.println("암호화 전 : " + nowString + " / 암호화 후  accessToken : " + accessToken + " / 복호화 : " + AESCipher.AES_Decode(accessToken));
		//log.info("암호화 전 : " + nowString + " / 암호화 후  accessToken : " + accessToken + " / 복호화 : " + AESCipher.AES_Decode(accessToken));

		return accessToken;
	}
}

