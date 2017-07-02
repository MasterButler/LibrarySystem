package beans.user;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import beans.Name;
import util.DateUtil;

public class User {
	
	private String id;
	
	private UserCredentials credentials;
	//private SecretQuestions secretQuestion;
	
	private Name name;
	@DateTimeFormat(pattern=DateUtil.NUMBER_FORMAT)
	private Date birthday;
	private int userType;
	
	public User(){
		this.credentials = new UserCredentials();
		this.name = new Name();
		this.birthday = new Date();
	}
	
	public UserCredentials getCredentials() {
		return credentials;
	}
	public void setCredentials(UserCredentials credentials) {
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
	
	
}
