package puzzlemall.test;

import java.io.Console;


public class regexTest {
	   public final static String ALPHA_NUMERIC_MULTI_LENGUAGE_REGEXP = "[\\p{InHebrew}\\p{InArabic}\\p{InCyrillic}a-zA-Z0-9]*";              
	   
       public final static String ALPHA_NUMERIC_MULTI_LENGUAGE_REGEXP2 = "[\\p{InHebrew}\\p{InArabic}\\p{InCyrillic}a-zA-Z0-9]?";
       
       public final static String EXTRA_CHARACTERS_REGEXP2 ="[&amp; ,._'!*+-=$:?()@%+-/&quot;\n\t]?" ;
       public final static String EXTRA_CHARACTERS_REGEXP ="[&amp; ,._'!*+-=$:?()@%+-/&quot;\n\t]*" ;
       

       public final static String FREE_TEXT_REGEXP ="["+ALPHA_NUMERIC_MULTI_LENGUAGE_REGEXP2 + EXTRA_CHARACTERS_REGEXP2 +"]*" ;
       public final static String FREE_TEXT_REGEXP2 ="([\\p{InHebrew}\\p{InArabic}\\p{InCyrillic}a-zA-Z0-9]?[&amp; ,._'!*+-=$:?()@%+-/&quot;\n\t]?)*" ;
       //public final static String FREE_TEXT_REGEXP2 ="("+ALPHA_NUMERIC_MULTI_LENGUAGE_REGEXP+EXTRA_CHARACTERS_REGEXP+")*" ;
       public final static String USERNAME_IV_REGEX = "([a-zA-Z0-9]+)*";
   	   public final static String PASSWORD_IV_REGEX = "([a-zA-Z0-9\\|\\.\\$\\^\\&\\*]+)*";
public static void main(String [] args)
{
//   String str = "slicky4.11<![CDATA[<a 123]]>";
	//String str = "aad1123@aaaaaa<input1]]>"; (4 seconds)
       String str = "assbcad1123@aaaaaa<input1]]]]>@aa+--a@aaa<input1]]]]>";
       //str = "['!******--=$$$$:'!*+-=$:?@>]]]]]";
       
       str = "aaaaaaaaaaaaaaaaaaaaaaaaaa!";
       long t1 = System.currentTimeMillis();
       //System.out.println(str.matches(FREE_TEXT_REGEXP));
       System.out.println(str.matches(USERNAME_IV_REGEX));
       
       long t2 = System.currentTimeMillis();
       //System.out.println(str.matches(FREE_TEXT_REGEXP2));
       System.out.println(str.matches(PASSWORD_IV_REGEX));
       long t3 = System.currentTimeMillis();
       long d1 = t2 - t1;
       long d2 = t3 - t2;

System.out.println(d1);
System.out.println(d2);
}
	

}
