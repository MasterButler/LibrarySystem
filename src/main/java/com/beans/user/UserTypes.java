package beans.user;

import java.util.Calendar;

public enum UserTypes {
	STUDENT(1, "Student", 7, Calendar.DATE),
	FACULTY(2, "Faculty", 1, Calendar.MONTH),
	LIBRARY_MANAGER(3, "Library Manager", 1, Calendar.MONTH),
	LIBRARY_STAFF(4, "Library Staff", 1, Calendar.MONTH),
	ADMINISTRATOR(5, "Administrator", 1, Calendar.MONTH),
	DEFAULT(1, "Student", 7, Calendar.DATE);
	
	private int value;
	private String name;
	private int numValues;
	private int fieldType;
	
	UserTypes(int value, String name, int numValues, int fieldType){
		this.value = value;
		this.name = name;
		this.numValues = numValues;
		this.fieldType = fieldType;
	}
	 
	public int getValue(){
		return this.value;
	}
	
	public String getName(){
		return this.name;
	}
	
	public int getNumValues(){
		return this.numValues;
	}
	
	public int getFieldTypes(){
		return this.fieldType;
	}
}