/*
 * Copyright doban7 by Duzon Newturns.,
 * All rights reserved.
 */
package ac.cmm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @title AcCmmUtils.java
 * @author doban7
 *
 * @date 2016. 10. 26.
 */
public class AcCmmUtils {

    public static String ConvertDate(String datestring)
    {

        String returnDate = "";
        String dateformatInput = "yyyy-MM-dd";
        String dateformatOutput = "yyyyMMdd";
        SimpleDateFormat formatInput = new SimpleDateFormat(dateformatInput, Locale.getDefault());
        SimpleDateFormat formatOutput = new SimpleDateFormat(dateformatOutput, Locale.getDefault());

        Date date = null;
        try {
            date = formatOutput.parse(datestring);
        } catch (Exception e) {
        	e.printStackTrace( );
        }

        if(date!=null)
        {
            returnDate = formatInput.format(date);
        }

        return returnDate;
    }

    public static String comma(String str)
    {
        String temp = new StringBuffer(str).reverse().toString();
        String result = "";

       for(int i = 0 ; i < temp.length() ; i += 3) {
            if(i + 3 < temp.length()) {
                result += temp.substring(i, i + 3) + ",";
            }
            else {
                result += temp.substring(i);
            }
        }
       return new StringBuffer(result).reverse().toString();
    }

}


