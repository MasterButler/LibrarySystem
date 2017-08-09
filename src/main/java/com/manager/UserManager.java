package com.manager;

import com.beans.Name;
import com.beans.list.UserList;
import com.beans.user.LoginCredentials;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.handler.TextHandler;

public class UserManager {
	private static volatile UserManager instance;

	private static UserList userList;
	
	private UserManager(){
		
	}
	
	public static UserManager getInstance(){
		if(instance == null){
			instance = new UserManager();
			
			userList = new UserList();
			
			User userBad = new User();
			userBad.setCredentials(new LoginCredentials("12345", "12345"));
			userBad.setEmail("abcde@a.a");
            userBad.setName(new Name("<b onload=alert('test1')>save</b>me", "<b onload=alert('test1')>save</b>me", "<b onload=alert('test1')>save</b>me"));
            userBad.setId("AAAAAAA");
            userBad.setUserType(UserTypes.STUDENT.getValue());
			
			User userGood = new User();
			userGood.setCredentials(new LoginCredentials("23456", "23456"));
			userGood.setEmail("bcdef@a.a");
            userGood.setName(new Name("<body onload=alert('test1')>", "A", "AAAAA"));
            userGood.setId("BBBBB");
            userGood.setUserType(UserTypes.STUDENT.getValue());
            
            User userRandom = new User();
            userRandom.setCredentials(new LoginCredentials("aaaaa", "aaaaa"));
            userRandom.setEmail("aaa@a.a");
            userRandom.setName(new Name("AAA", "A", "AAAAA"));
            userRandom.setId("CCCCC");
            userRandom.setUserType(UserTypes.STUDENT.getValue());
            
			User userA = new User();
			userA.setCredentials(new LoginCredentials("WinVillaluna","1234"));
			userA.setEmail("winfredvillaluna@google.com");
			userA.setName(new Name("Winfred", "D", "Villaluna"));
			userA.setId("11427574");
			userA.setUserType(UserTypes.STUDENT.getValue());
			
			User userB = new User();
			userB.setCredentials(new LoginCredentials("DarMarpa","2345"));
			userB.setEmail("darlenemarpa@google.com");
			userB.setName(new Name("Darlene", "G", "Marpa"));
			userB.setId("11427019");
			userB.setUserType(UserTypes.STUDENT.getValue());
		
			User userC = new User();
			userC.setCredentials(new LoginCredentials("RofSantos", "3456"));
			userC.setEmail("rofisantos@google.com");
			userC.setName(new Name("Rofi", "M", "Santos"));
			userC.setId("11428260");
			userC.setUserType(UserTypes.STUDENT.getValue());
			
			User facultyA = new User();
			facultyA.setCredentials(new LoginCredentials("PROfessor", "1122"));
			facultyA.setEmail("teecher@google.com");
			facultyA.setName(new Name("Tee", "Ain", "Cher"));
			facultyA.setId("1041762");
			facultyA.setUserType(UserTypes.FACULTY.getValue());
			
			User managerA = new User();
			managerA.setCredentials(new LoginCredentials("managerA", "121212"));
			managerA.setEmail("manager@google.com");
			managerA.setName(new Name("Mana", "The", "Jeer"));
			managerA.setId("123456");
			managerA.setUserType(UserTypes.LIBRARY_MANAGER.getValue());
			
			User staffA = new User();
			staffA.setCredentials(new LoginCredentials("staffA", "121212"));
			staffA.setEmail("staff@google.com");
			staffA.setName(new Name("Sta", "The", "Uff"));
			staffA.setId("145678");
			staffA.setUserType(UserTypes.LIBRARY_STAFF.getValue());
					
			User adminA = new User();
			adminA.setCredentials(new LoginCredentials("adminA", "121212"));
			adminA.setEmail("admin@google.com");
			adminA.setName(new Name("Add", "Dee", "Min"));
			adminA.setId("1");
			adminA.setUserType(UserTypes.ADMINISTRATOR.getValue());
			
			System.out.println("ADD");
			
			sanitizeUser(userBad);    
			sanitizeUser(userGood);   
			sanitizeUser(userRandom); 
			sanitizeUser(userA);      
			sanitizeUser(userB);      
			sanitizeUser(userC);      
			sanitizeUser(facultyA);   
			sanitizeUser(managerA);   
			sanitizeUser(staffA);     
			sanitizeUser(adminA);     
			
			userList.add(userGood);
			userList.add(userBad);
			userList.add(userRandom);
			userList.add(userA);
			userList.add(userB);
			userList.add(userC);
			userList.add(facultyA);
			userList.add(managerA);
			userList.add(staffA);
			userList.add(adminA);
		}
		return instance;
	}
	
	public static void sanitizeUser(User user){
		String username = TextHandler.sanitize(user.getCredentials().getUsername());
		String firstName = TextHandler.sanitize(user.getName().getFirstName());
		String middleName = TextHandler.sanitize(user.getName().getMiddleName());
		String lastName = TextHandler.sanitize(user.getName().getLastName());
		
		LoginCredentials credentials = new LoginCredentials(username, user.getCredentials().getPassword());
		Name name = new Name(firstName, middleName, lastName);
		
		user.setCredentials(credentials);
		user.setName(name);
	}
	
	public UserList getAllUsers(){
		for(int i = 0; i < userList.size(); i++){
			User user = removeUser(i);
			userList.add(i, user);
		}
		return userList;
	}
	
	public boolean addUser(User user){
		sanitizeUser(user);
		System.out.println("BEFORE FIRST");
		if(searchUserById(user.getId()) == null){
			System.out.println("BEFORE SECOND");
			if(searchUserByUsername(user.getCredentials().getUsername()) == null){
				System.out.println("PASS FIRST");
				if(userList.add(user)){
					return true;
				}
			}
		}
		return false;
	}
	
	public User searchUserById(String id){
		System.out.println("START ID SEARCH");
		for(int i = 0; i < userList.size(); i++){
			System.out.println("WILL COMPARE " + id + "TO " + getUser(i).getId());
			if(getUser(i).getId().equals(id)){
				return getUser(i);
			}
		}
		System.out.println("DIDN'T FIND ANY");
		return null;
	}
	
	public User searchUserByUsername(String username){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("WILL COMPARE " + username + "TO " + getUser(i).getCredentials().getUsername());
			if(getUser(i).getCredentials().getUsername().toLowerCase().equals(username.toLowerCase())){
				return getUser(i);
			}
		}
		System.out.println("DIDN'T FIND ANY");
		return null;
	}
	
	public User searchUserByEmail(String email){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("COMPARING " + email + " AND " + getUser(i).getEmail());
			if(getUser(i).getEmail().equalsIgnoreCase(email)){
				System.out.println("RETURNING USER WITH EMAIL " + email);
				return getUser(i);
			}
		}
		return null;
	}
	
	private User getUser(int index){
		User user = userList.get(index);
		sanitizeUser(user);
		return user;
	}
	
	private User removeUser(int index){
		User user = userList.remove(index);
		sanitizeUser(user);
		return user;
	}
}
