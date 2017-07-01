package beans;

public class Status {

	//out of stock
	public final static int STATUS_OUT = 1;
	//borrowed by other people
	public final static int STATUS_RESERVED = 2;
	//available in library
	public final static int STATUS_AVAILABLE = 3;
	
	public int getCurrentStatus(){
		//TODO process the status of the libraryobject
		return STATUS_AVAILABLE;
	}
	
}
