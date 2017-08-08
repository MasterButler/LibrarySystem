package util;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	
	public static final String DATE_FORMAT = "yyyy, MMMM dd";
	public static final String DATETIME_FORMAT = "MMMM dd, yyyy hh:mm aa";
	public static final String NUMBER_FORMAT = "MM-dd-yyyy";
	public static final String PROPER_DATE_FORMAT = "MMMM dd, yyyy";
	
	public static final String TIME_FORMAT = "hh:mm aa"; 
			
	
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
	
	public static Date addTime(Date date, String time){
		//time = time.replace("NN", "PM");
		SimpleDateFormat concat = new SimpleDateFormat(DATE_FORMAT + " " + TIME_FORMAT);
		try {
			System.out.println("PARSING " + displayDate(date) + " " + time);
			System.out.println("FORMAT IS " + DATE_FORMAT + " " + TIME_FORMAT);
			return concat.parse(displayDate(date) + " " + time);
		} catch (ParseException e) {
			System.out.println("Undetermined date and time format. Returning null");
			e.printStackTrace();
		}
		
		return null;
	} 
}
