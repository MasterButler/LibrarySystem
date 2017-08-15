package com.manager;

import com.beans.Name;
import com.beans.list.UserList;
import com.beans.user.LoginCredentials;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.db.DBConnection;
import com.handler.TextHandler;

public class UserManager {
	private static volatile UserManager instance;

	private static UserList userList;
	
	private UserManager(){
		
	}
	
	public static UserManager getInstance(){
		if(instance == null){
			instance = new UserManager();
			userList = new DBConnection().getAllUsers();
		}
		return instance;
	}
	
	public UserList getAllLockedAccounts(){
		UserList list = getInstance().getAllUsers();
		UserList locked = new UserList();
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).getAttempts() >= 3){
				locked.add(list.get(i));
			}
		}
		return locked;
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
			System.out.println("WILL COMPARE " + username + " TO " + getUser(i).getCredentials().getUsername());
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
	
	public User getUser(int index){
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
