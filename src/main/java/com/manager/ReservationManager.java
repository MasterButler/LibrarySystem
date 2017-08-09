package com.manager;

import java.util.Calendar;
import java.util.Date;

import com.beans.LibraryObject;
import com.beans.Literature;
import com.beans.MeetingRoom;
import com.beans.MeetingRoomTimeSlots;
import com.beans.Status;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.util.DateUtil;

public class ReservationManager {
    public static boolean reserve(Literature libObject, User user){
		if(libObject.isBorrowable() || (libObject.isNotOut() && user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue())){
			Status newStatus = new Status();
			Date dateStart = DateUtil.getCurrentDate();
			//TODO modify this so change will be easeir to do based on user type
			
			System.out.println("USER TYPE: " + user.getUserType());
			System.out.println(UserTypes.values()[user.getUserType()].getName());
			System.out.println(UserTypes.values()[user.getUserType()].getNumValues());
			System.out.println(UserTypes.values()[user.getUserType()].getFieldTypes());
			System.out.println(Calendar.MONTH);
			Date dateEnd = DateUtil.addToDate(
					dateStart, 
					UserTypes.values()[user.getUserType()-1].getFieldTypes(),
					UserTypes.values()[user.getUserType()-1].getNumValues());
			
			newStatus.setAvailability(Status.STATUS_RESERVED);
			newStatus.setCurrentHolder(user);
			newStatus.setDateBorrowStart(dateStart);
			newStatus.setDateBorrowEnd(dateEnd);
						
			libObject.setStatus(newStatus);
			
			System.out.println("IN RESERVATIONMANAGER:");
			System.out.println(libObject.getStatus().getCurrentHolder().getId());
			
			return true;
		}
		return false;
	}
    
    public static boolean reserve(MeetingRoom meetingRoom, int timeSlotIndex, User user){
        if(meetingRoom.getUserIsHolding()[timeSlotIndex] == null || user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue() && meetingRoom.getUserIsHolding()[timeSlotIndex].getAvailability() == Status.STATUS_RESERVED){
            
            System.out.println("USER TYPE: " + user.getUserType());
            System.out.println(UserTypes.values()[user.getUserType()].getName());
            System.out.println(UserTypes.values()[user.getUserType()].getNumValues());
            System.out.println(UserTypes.values()[user.getUserType()].getFieldTypes());
            
            Status newStatus = new Status();
            
            Date dateStart = DateUtil.addToDate(DateUtil.addTime(DateUtil.getCurrentDate(), MeetingRoomTimeSlots.slots[timeSlotIndex]), Calendar.DATE, 1);
            Date dateEnd = DateUtil.addToDate(dateStart, Calendar.MINUTE, 55);
            
            newStatus.setAvailability(Status.STATUS_RESERVED);
            newStatus.setCurrentHolder(user);
            newStatus.setDateBorrowStart(dateStart);
            newStatus.setDateBorrowEnd(dateEnd);
            
            meetingRoom.getUserIsHolding()[timeSlotIndex] = newStatus;
            
            System.out.println("IN RESERVATIONMANAGER:");
            System.out.println(meetingRoom.getUserIsHolding()[timeSlotIndex].getCurrentHolder().getId());
            
            return true;
        }
        return false;
    }

}
