package beans;

public enum LibraryObjectTypes {
	BOOK(1), 
	MAGAZINE(2), 
	THESIS(3), 
	MEETING_ROOMS(4),
	DEFAULT(1);
	
	private int objectType;
	
	LibraryObjectTypes(int objectType){
		this.objectType = objectType;
	}
	
	public int getValue(){
		return this.objectType;
	}
}
