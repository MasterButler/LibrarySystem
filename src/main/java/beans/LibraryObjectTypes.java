package beans;

public enum LibraryObjectTypes {
	BOOK(1, "Book"), 
	MAGAZINE(2, "Magazine"), 
	THESIS(3, "Thesis"), 
	MEETING_ROOMS(4, "Meeting Room"),
	DEFAULT(1, "Book");
	
	private int value;
	private String name;
	
	LibraryObjectTypes(int value, String name){
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
