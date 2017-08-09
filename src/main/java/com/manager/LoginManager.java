package com.manager;

import com.beans.user.LoginCredentials;
import com.beans.user.User;

public class LoginManager {
	private static volatile LoginManager instance;
	
	private LoginManager(){
		
	}
	
	public static LoginManager getInstance(){
		if(instance == null){
			instance = new LoginManager();
		}
		return instance;
	}
	
	public boolean authenticate(LoginCredentials credentials){
		System.out.println("WILL FIND: " + credentials.getUsername());
		User retrievedUser = UserManager.getInstance().searchUserByUsername(credentials.getUsername());
		System.out.println("FOUND USER: " + (retrievedUser != null));
		if(retrievedUser != null){
			if(retrievedUser.getCredentials().matches(credentials)){
				return true;
			}
		}
		return false;
	}
}
