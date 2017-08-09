package com.beans;

import java.util.Date;

import com.beans.user.User;
import com.util.DateUtil;

public class Status {

	//out of stock
	public final static int STATUS_OUT = 0;
	//borrowed by other people
	public final static int STATUS_RESERVED = 1;
	//available in library
	public final static int STATUS_AVAILABLE = 2;
	
	private User currentHolder;
	private int availability;
	private Date dateBorrowStart;
	private Date dateBorrowEnd;
	
	public Status(){
		availability = STATUS_AVAILABLE;
		Date currDate = DateUtil.getCurrentDate();
		dateBorrowStart = currDate;
		dateBorrowEnd = currDate;
		currentHolder = null;
	}
	
	public Status(int availability, Date dateBorrowStart, Date dateBorrowEnd, User currentHolder){
		this.availability = availability;
		this.dateBorrowStart = dateBorrowStart;
		this.dateBorrowEnd = dateBorrowEnd;
		this.currentHolder = null;
	}
	
	public void setAvailability(int status){
		this.availability = status;
	}
	
	public int getAvailability(){
		return this.availability;
	}

	public Date getDateBorrowStart() {
		return dateBorrowStart;
	}

	public void setDateBorrowStart(Date dateBorrowStart) {
		this.dateBorrowStart = dateBorrowStart;
	}

	public Date getDateBorrowEnd() {
		return dateBorrowEnd;
	}

	public void setDateBorrowEnd(Date dateBorrowEnd) {
		this.dateBorrowEnd = dateBorrowEnd;
	}

	public User getCurrentHolder() {
		return currentHolder;
	}

	public void setCurrentHolder(User currentHolder) {
		this.currentHolder = currentHolder;
	}
}
