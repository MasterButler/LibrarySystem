package date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	private static final String DATE_FORMAT = "yyyy, MMMM dd";
	
	public static final String FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final int MONTH = Calendar.MONTH;
	public static final int DATE = Calendar.DATE;
	
	
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
	
	public static Date addToDate(Date date, int field, int num){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(field, num);
		return c.getTime();
	}
}
