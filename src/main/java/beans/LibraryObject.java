package beans;

public abstract class LibraryObject {
	
	protected long id;
	protected int libraryObjectType;
	
	public LibraryObject(){
		
	}
	
	public abstract void setLibraryObjectType(int category);
	public abstract int getLibraryObjectType();
}
