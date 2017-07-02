package date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	
	public static final String FORMAT = "yyyy-MM-dd HH:mm:ss";
	private static final String DATE_FORMAT = "yyyy, MMMM dd";
	
	
	
	public static Date readDateFromString(String date){
		SimpleDateFormat dtf = new SimpleDateFormat(FORMAT);
		
		try{
			return dtf.parse(date);
		}catch(ParseException pe){
			System.out.println("Undetermined date and time format. Returning null");
			pe.printStackTrace();
		};
		
		return null;
	}
	
	public static String convertDateToString(Date date){
		SimpleDateFormat dtf = new SimpleDateFormat(FORMAT);
		
		return dtf.format(date);
	}
	
	public static Date getCurrentDate(){
		return new Date();
	}
	
	public static String displayDate(Date date){
		SimpleDateFormat dtf = new SimpleDateFormat(DATE_FORMAT);
		return dtf.format(date);
	}
}
