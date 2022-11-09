/**
  * @FileName : AES256Cipher.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.helper.convert;

/**
 *   * @FileName : AES256.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class AES256Cipher {
	//
	//	private static volatile AES256Cipher INSTANCE;
	//	final static String secretKey = "12345678901234567890123456789012"; //32bit
	//	static String IV; //16bit
	//	private static final String password = "#$^&*!@!$";
	//	private static String initializationVector = "@1B2c3D4e5F6g7H8";
	//	private static String salt = "R@j@}{BAe";
	//	private static int pswdIterations = 2;
	//	private static int keySize = 128;
	//
	//	//암호화
	//	public static String AES_Encode ( String str ) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, DigestException {
	//		byte[] saltVytes = salt.getBytes( "ASCII" );
	//		byte[] ivBytes = initializationVector.getBytes( "ASCII" );//"UTF-8");
	//		//		// PasswordDeriveBytes pdb = new PasswordDeriveBytes(secretKey, String.valueOf( secretKey.length( ) ).getBytes( ));
	//		//		// byte[] key = pdb.GetBytes( 32 );
	//		//		// byte[] keyData = secretKey.getBytes( );
	//		//		PasswordDeriveBytes btConvert = new PasswordDeriveBytes( secretKey, new byte[] {51, 50}, "SHA1", 100 );
	//		//		
	//		//		byte[] ex1 = btConvert.GetBytes( 32 );
	//		//		byte[] ex2 = btConvert.GetBytes( 16 );
	//		//		
	//		//		byte[] keyData = btConvert.GetBytes( 32 );
	//		//		byte[] bIV = btConvert.GetBytes( 16 );
	//		//		SecretKey secureKey = new SecretKeySpec( keyData, "AES" );
	//		//		Cipher c = Cipher.getInstance( "AES/CBC/PKCS5Padding" );
	//		//		c.init( Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec( bIV ) );
	//		//		byte[] encrypted = c.doFinal( str.getBytes( "UTF-8" ) );
	//		//		String enStr = new String( Base64.encodeBase64( encrypted ) );
	//		//		return enStr;
	//	}
	//
	//	//복호화
	//	public static String AES_Decode ( String str ) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
	//		byte[] keyData = secretKey.getBytes( );
	//		SecretKey secureKey = new SecretKeySpec( keyData, "AES" );
	//		Cipher c = Cipher.getInstance( "AES/CBC/PKCS5Padding" );
	//		c.init( Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec( IV.getBytes( "UTF-8" ) ) );
	//		byte[] byteStr = Base64.decodeBase64( str.getBytes( ) );
	//		return new String( c.doFinal( byteStr ), "UTF-8" );
	//	}
}
