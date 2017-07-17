package manager;

import beans.MeetingRoom;
import beans.Name;
import beans.list.MeetingRoomList;
import beans.user.User;

public class MeetingRoomManager {
	private static volatile MeetingRoomManager instance;

	private static MeetingRoomList meetingRoomList;
	
	private MeetingRoomManager(){
		
	}
	
	public static MeetingRoomManager getInstance(){
		if(instance == null){
			instance = new MeetingRoomManager();
			
			meetingRoomList = new MeetingRoomList();
			
			MeetingRoom roomA = new MeetingRoom();
			roomA.setId(1);
			roomA.setName("Room A");
			
			MeetingRoom roomB = new MeetingRoom();
			roomB.setId(2);
			roomB.setName("Room B");
			
			MeetingRoom roomC = new MeetingRoom();
			roomC.setId(1);
			roomC.setName("Room C");
			
			MeetingRoom roomD = new MeetingRoom();
			roomD.setId(1);
			roomD.setName("Room D");
			
			MeetingRoom roomE = new MeetingRoom();
			roomE.setId(1);
			roomE.setName("Room E");
			
			meetingRoomList.add(roomA);
			meetingRoomList.add(roomB);
			meetingRoomList.add(roomC);
			meetingRoomList.add(roomD);
			meetingRoomList.add(roomE);
			
			User userA = new User();
			userA.setName(new Name("Winfred", "D", "VILL"));
			userA.setId("1234");
			
			roomA.addMeeting(9, userA);
			roomA.addMeeting(10, userA);
			roomA.addMeeting(12, userA);
			roomA.addMeeting(14, userA);
			roomA.addMeeting(18, userA);
			roomA.addMeeting(19, userA);
			
			if(roomA.getUserIsHolding()[10] == null){
				System.out.println("IT WAS NOT ADDED");
			}else{
				System.out.println("IT WASS ADDED");
			}
		}
		return instance;
	}
	
	public MeetingRoom getMeetingRoomByID(long id){
		for(int i = 0; i < meetingRoomList.size(); i++){
			if(meetingRoomList.get(i).getId() == id){
				return meetingRoomList.get(i);
			}
		}
		return null;
	}

	public MeetingRoom getMeetingRoomByName(String name){
		for(int i = 0; i < meetingRoomList.size(); i++){
			if(meetingRoomList.get(i).getName().toLowerCase().equals(name.toLowerCase())){
				return meetingRoomList.get(i);
			}
		}
		return null;
	}
	
	public MeetingRoomList getAllMeetingRooms(){
		for(int i = 0; i < 5; i++){
			for(int j = 0; j < 22; j++){
				System.out.println(meetingRoomList.get(i).getName() + ": " + meetingRoomList.get(i).getUserIsHolding()[j]);
			}
		}
		return this.meetingRoomList;
	}
}
