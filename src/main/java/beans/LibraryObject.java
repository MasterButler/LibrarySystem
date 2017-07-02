package beans;

public abstract class LibraryObject {
	
	protected long id;
	protected Status status;
	protected int libraryObjectType;
	
	public LibraryObject(){
		this.status = new Status();
	}
	
	public boolean isBorrowable(){
		if(status.getAvailability() == Status.STATUS_AVAILABLE)
			return true;
		return false;
	}
	
	public abstract void setLibraryObjectType(int category);
	public abstract int getLibraryObjectType();
	
	public void setStatus(Status status){
		this.status = status;
	}
	
	public Status getStatus(){
		return this.status;
	}
}
