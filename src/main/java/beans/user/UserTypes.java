package beans.user;

public enum UserTypes {
	STUDENT(1, "Student"),
	FACULTY(2, "Faculty"),
	DEFAULT(1, "Student");
	
	private int value;
	private String name;
	
	UserTypes(int value, String name){
		this.value = value;
		this.name = name;
	}
	 
	public int getValue(){
		return this.value;
	}
	
	public String getName(){
		return this.name;
	}
}