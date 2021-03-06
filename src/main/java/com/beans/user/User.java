package com.beans.user;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.beans.Literature;
import com.beans.MeetingRoom;
import com.beans.MeetingRoomReservedList;
import com.beans.Name;
import com.beans.Status;
import com.beans.list.LiteratureList;
import com.beans.list.MeetingRoomList;
import com.manager.LiteratureManager;
import com.manager.MeetingRoomManager;
import com.util.DateUtil;

public class User {
	
	private int userType;
	private String id;
	//private SecretQuestions secretQuestion;
	
	private LoginCredentials credentials;
	private String email;
	private Name name;
	
	private String securityQuestion;
	private String securityAnswer;
	
	@DateTimeFormat(pattern=DateUtil.NUMBER_FORMAT)
	private Date birthday;
	
	//TODO These TWO lists in particular, I've only placed 
	//to track currently reserved books. We can remove this once
	//db is impelmented, but I'll leave that to you guys. call nyo na to
	//-win
	private LiteratureList literatureList;
	private MeetingRoomReservedList reservationList;
	
	private Date validUntil;
	private boolean hasTempPassword;
	private int attempts;
	
	public User(){
		this.attempts = 0;
		this.credentials = new LoginCredentials();
		this.name = new Name();
		this.birthday = new Date();
		this.literatureList = new LiteratureList();
		this.validUntil = null;
		this.hasTempPassword = false;
		this.reservationList = new MeetingRoomReservedList();
		
		for(int i = 0; i < MeetingRoomManager.ROOM_NAME.length; i++){
			this.reservationList.add(new ArrayList<Status>());
		}
	}	
		
	public String getSecurityQuestion() {
		return securityQuestion;
	}

	public void setSecurityQuestion(String securityQuestion) {
		this.securityQuestion = securityQuestion;
	}

	public String getSecurityAnswer() {
		return securityAnswer;
	}

	public void setSecurityAnswer(String securityAnswer) {
		this.securityAnswer = securityAnswer;
	}

	public boolean getHasTempPassword() {
		return hasTempPassword;
	}

	public void setHasTempPassword(boolean hasTempPassword) {
		this.hasTempPassword = hasTempPassword;
	}

	public void setLiteratureList(LiteratureList literatureList) {
		this.literatureList = literatureList;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public LoginCredentials getCredentials() {
		return credentials;
	}
	public void setCredentials(LoginCredentials credentials) {
		this.credentials = credentials;
	}
	public Name getName() {
		return name;
	}
	public void setName(Name name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}

	public LiteratureList getLiteratureList() {
		return literatureList;
	}

	public void setMyBooks(LiteratureList literatureList) {
		this.literatureList = literatureList;
	}
	
	public boolean addToLiteratureList(Literature literature){
		return this.literatureList.add(literature);
	}
	
	public boolean removeFromLiteratureList(Literature literature){
		for(int i = 0; i < literatureList.size(); i++){
			if(literatureList.get(i).getId() == literature.getId()){
				return true;
			}
		}
		return false;
	}
	
	public boolean addToReservationList(int roomIndex, Status status){
		reservationList.get(roomIndex).add(status);
		return false;
	}

	public MeetingRoomReservedList getReservationList() {
		return reservationList;
	}

	public void setReservationList(MeetingRoomReservedList reservationlist) {
		this.reservationList = reservationlist;
	}

	public int getAttempts() {
		return attempts;
	}

	public void setAttempts(int attempts) {
		this.attempts = attempts;
	}

	public void resetAttempts(){
		this.attempts = 0;
	}
	
	public int addAttempt(){
		attempts++;
		return attempts;
	}
}
