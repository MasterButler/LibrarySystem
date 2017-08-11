package com.beans.user;

import java.util.Calendar;

public enum UserTypes {
	STUDENT(0, "Student", 7, Calendar.DATE),
	FACULTY(1, "Faculty", 1, Calendar.MONTH),
	LIBRARY_MANAGER(2, "Library Manager", 1, Calendar.MONTH),
	LIBRARY_STAFF(3, "Library Staff", 1, Calendar.MONTH),
	ADMINISTRATOR(4, "Administrator", 1, Calendar.MONTH),
	DEFAULT(0, "Student", 7, Calendar.DATE);
	
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