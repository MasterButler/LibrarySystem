package beans;

import beans.user.User;

public class MeetingRoom extends LibraryObject{
	
	private User[] userIsHolding;
	String name;
	long id;
	
	public MeetingRoom(){
		userIsHolding = new User[22];
	}
	
	public int getLibraryObjectType() {
		return LibraryObjectTypes.MEETING_ROOMS.getValue();
	}

	@Override
	public void setLibraryObjectType(int category) {
		this.libraryObjectType = LibraryObjectTypes.MEETING_ROOMS.getValue();		
	}
	
	public boolean addMeeting(int[] time, User[] list){
		for(int i = 0; i < time.length; i++){
			if(userIsHolding[time[i]] == null){
				userIsHolding[time[i]] = list[i];
				return true;
			}
		}
		return false;
	}
	
	public boolean addMeeting(int time, User user){
		if(userIsHolding[time] == null){
			userIsHolding[time] = user;
			return true;
		}
		return false;
	}

	public User[] getUserIsHolding() {
		return userIsHolding;
	}

	public void setUserIsHolding(User[] userIsHolding) {
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
