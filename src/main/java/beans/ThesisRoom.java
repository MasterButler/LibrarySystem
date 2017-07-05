package beans;

public class ThesisRoom extends LibraryObject{
	
	public int getLibraryObjectType() {
		return LibraryObjectTypes.MEETING_ROOMS.getValue();
	}

	@Override
	public void setLibraryObjectType(int category) {
		this.libraryObjectType = LibraryObjectTypes.MEETING_ROOMS.getValue();		
	}
	
}
