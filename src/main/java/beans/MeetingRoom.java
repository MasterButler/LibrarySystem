package beans;

import beans.user.User;

public class MeetingRoom extends LibraryObject{
	
	private Status[] userIsHolding;
	
	String name;
	long id;
	
	public MeetingRoom(){
		userIsHolding = new Status[MeetingRoomTimeSlots.slots.length];
	}
	
	public int getLibraryObjectType() {
		return LibraryObjectTypes.MEETING_ROOMS.getValue();
	}

	@Override
	public void setLibraryObjectType(int category) {
		this.libraryObjectType = LibraryObjectTypes.MEETING_ROOMS.getValue();		
	}
	
	public Status[] getUserIsHolding() {
		return userIsHolding;
	}

	public void setUserIsHolding(Status[] userIsHolding) {
		this.userIsHolding = userIsHolding;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
}
