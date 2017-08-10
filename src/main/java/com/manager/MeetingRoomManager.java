package com.manager;

import com.beans.Literature;
import com.beans.MeetingRoom;
import com.beans.MeetingRoomTimeSlots;
import com.beans.Name;
import com.beans.list.MeetingRoomList;
import com.beans.user.User;

public class MeetingRoomManager {
	private static volatile MeetingRoomManager instance;

	private static MeetingRoomList meetingRoomList;

    public static final String[] ROOM_NAME = {
            "Room A",
            "Room B",
            "Room C",
            "Room D",
            "Room E"};

    public static String[] getRoomNames(){
        return ROOM_NAME;
    }

	private MeetingRoomManager(){
		
	}
	
	public static MeetingRoomManager getInstance(){
		if(instance == null){
			instance = new MeetingRoomManager();
			
			meetingRoomList = new MeetingRoomList();
			
			MeetingRoom roomA = new MeetingRoom();
			roomA.setId(1);
            roomA.setName(ROOM_NAME[0]);
			
			MeetingRoom roomB = new MeetingRoom();
			roomB.setId(2);
            roomB.setName(ROOM_NAME[1]);
			
			MeetingRoom roomC = new MeetingRoom();
			roomC.setId(1);
            roomC.setName(ROOM_NAME[2]);
			
			MeetingRoom roomD = new MeetingRoom();
			roomD.setId(1);
            roomD.setName(ROOM_NAME[3]);
			
			MeetingRoom roomE = new MeetingRoom();
			roomE.setId(1);
            roomE.setName(ROOM_NAME[4]);
			
			meetingRoomList.add(roomA);
			meetingRoomList.add(roomB);
			meetingRoomList.add(roomC);
			meetingRoomList.add(roomD);
			meetingRoomList.add(roomE);
			
//            ReservationManager.reserveToday(roomA, 1, UserManager.getInstance().getUser(0));
//            ReservationManager.reserveToday(roomA, 3, UserManager.getInstance().getUser(0));
//            ReservationManager.reserveToday(roomA, 4, UserManager.getInstance().getUser(0));
//            ReservationManager.reserveToday(roomA, 5, UserManager.getInstance().getUser(0));
//            ReservationManager.reserveToday(roomA, 8, UserManager.getInstance().getUser(0));
			reserveStatic(0, 1, UserManager.getInstance().getUser(0));
			reserveStatic(0, 3, UserManager.getInstance().getUser(0));
			reserveStatic(0, 4, UserManager.getInstance().getUser(0));
			reserveStatic(0, 5, UserManager.getInstance().getUser(0));
			reserveStatic(0, 8, UserManager.getInstance().getUser(0));
			
            for(int i = 0; i < roomA.getUserIsHolding().length; i++){
                if(roomA.getUserIsHolding()[i] == null){
                    System.out.println(roomA.getUserIsHolding()[i] + " WAS NOT ADDED");
                }else{
                    System.out.println(roomA.getUserIsHolding()[i] + " WAS ADDED");
                }
            }
		}
		return instance;
	}

	public static boolean reserveStatic(int meetingRoomIndex, int timeSlotIndex, User user){
		if(ReservationManager.reserve(getInstance().getMeetingRoomByIndex(meetingRoomIndex), timeSlotIndex, user)){
			user.getReservationList().get(meetingRoomIndex).add(getInstance().getMeetingRoomByIndex(meetingRoomIndex).getUserIsHolding()[timeSlotIndex]);
			return true;
		}
		return false;
	}
	
	public boolean reserve(int meetingRoomIndex, int timeSlotIndex, User user){
		if(ReservationManager.reserve(getMeetingRoomByIndex(meetingRoomIndex), timeSlotIndex, user)){
			user.getReservationList().get(meetingRoomIndex).add(getMeetingRoomByIndex(meetingRoomIndex).getUserIsHolding()[timeSlotIndex]);
			return true;
		}
		return false;
	}
	
	public MeetingRoom getMeetingRoomByIndex(int index){
		return meetingRoomList.get(index);
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
		for(int i = 0; i < meetingRoomList.size(); i++){
			for(int j = 0; j < MeetingRoomTimeSlots.slots.length; j++){
				System.out.println(meetingRoomList.get(i).getName() + ": " + meetingRoomList.get(i).getUserIsHolding()[j]);
			}
		}
		return this.meetingRoomList;
	}
	
	public void validateUserReservations(User user){
		for(int i = 0; i < user.getReservationList().size(); i++){
			for(int j = 0; j < user.getReservationList().get(i).size(); j++){
				if(!user.getReservationList().get(i).get(j).getCurrentHolder().getId().equals(user.getId())){
					user.getReservationList().get(i).remove(j);
				}
			}
		}
	}
}
