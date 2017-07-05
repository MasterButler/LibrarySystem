package manager;

import java.util.Calendar;
import java.util.Date;

import beans.LibraryObject;
import beans.Status;
import beans.user.User;
import beans.user.UserTypes;
import util.DateUtil;

public class ReservationManager {
	public static boolean reserve(LibraryObject libObject, User user){
		if(libObject.isBorrowable()){
			Status newStatus = new Status();
			Date dateStart = DateUtil.getCurrentDate();
			//TODO modify this so change will be easeir to do based on user type
			
			System.out.println("USER TYPE: " + user.getUserType());
			System.out.println(UserTypes.values()[user.getUserType()].getNumValues());
			System.out.println(UserTypes.values()[user.getUserType()].getFieldTypes());
			System.out.println(Calendar.MONTH);
			Date dateEnd = DateUtil.addToDate(
					dateStart, 
					UserTypes.values()[user.getUserType()].getFieldTypes(),
					UserTypes.values()[user.getUserType()].getNumValues());
			
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
}
