package beans.user;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import beans.Literature;
import beans.Name;
import beans.list.LiteratureList;
import manager.LiteratureManager;
import util.DateUtil;

public class User {
	
	private String id;
	//private SecretQuestions secretQuestion;
	
	private LoginCredentials credentials;
	private String email;
	private Name name;
	
	@DateTimeFormat(pattern=DateUtil.NUMBER_FORMAT)
	private Date birthday;
	private int userType;
	
	private LiteratureList literatureList;
	
	public User(){
		this.credentials = new LoginCredentials();
		this.name = new Name();
		this.birthday = new Date();
		this.literatureList = new LiteratureList();
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
}
