package beans;

public abstract class LibraryObject {
	
	private long id;
	private Status status;
	
	public boolean isBorrowable(){
		if(status.getCurrentStatus() == Status.STATUS_AVAILABLE)
			return true;
		return false;
	}
	
	public abstract int getLibraryObjectType();
}
