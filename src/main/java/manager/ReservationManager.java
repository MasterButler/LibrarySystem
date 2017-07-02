package manager;

import java.util.Date;

import beans.LibraryObject;
import beans.Status;
import util.DateUtil;

public class ReservationManager {
	public static boolean reserve(LibraryObject libOject){
		if(libOject.isBorrowable()){
			Status newStatus = new Status();
			Date dateStart = DateUtil.getCurrentDate();
			//TODO modify this so change will be easeir to do based on user type
			Date dateEnd = DateUtil.addToDate(dateStart, DateUtil.DATE, 7);
			
			newStatus.setAvailability(Status.STATUS_RESERVED);
			newStatus.setDateBorrowStart(dateStart);
			newStatus.setDateBorrowEnd(dateEnd);
			libOject.setStatus(newStatus);
			
			return true;
		}
		return false;
	}
}
