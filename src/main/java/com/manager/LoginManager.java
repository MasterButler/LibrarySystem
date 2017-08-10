package com.manager;

import java.nio.charset.StandardCharsets;

import com.beans.user.LoginCredentials;
import com.beans.user.User;
import com.google.common.hash.Hashing;

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
		System.out.println();
		User retrievedUser = UserManager.getInstance().searchUserByUsername(credentials.getUsername());
		System.out.println("FOUND USER: " + (retrievedUser != null));
		
		if(retrievedUser != null){
			System.out.println(credentials.getUsername());
			System.out.println(retrievedUser.getCredentials().getUsername());
			if(retrievedUser.getCredentials().matches(credentials)){
				return true;
			}
		}
		return false;
	}
	
	public String encrypt(String oldPassword){
		return Hashing.sha256().hashString(oldPassword, StandardCharsets.UTF_8).toString();
		
	}
}
