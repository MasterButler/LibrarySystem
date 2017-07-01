package beans;

public class Literature {
	
	private long id;
	
	private String date;
	private String dds;
	
	private String title;
	private String type;
	private String publisher;
	
	private int category;
	
	public Literature(){
		
	}
	
	public int getLibraryObjectType() {
		return LibraryObjectTypes.MAGAZINE.getValue();
	}
}
