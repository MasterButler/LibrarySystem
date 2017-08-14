package com.manager;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.beans.user.LoginCredentials;
import com.beans.user.User;

public class LoginManager {
	public static final int LOGIN_SUCCESSFUL = 1;
	public static final int LOGIN_MAX_ATTEMPTS = 2;
	public static final int LOGIN_UNSUCCESSFUL = 3;
	
	private static volatile LoginManager instance;
	
	private LoginManager(){
		
	}
	
	public static LoginManager getInstance(){
		if(instance == null){
			instance = new LoginManager();
		}
		return instance;
	}
	
	public int authenticate(LoginCredentials credentials){
		System.out.println("WILL FIND: " + credentials.getUsername());
		System.out.println();
		User retrievedUser = UserManager.getInstance().searchUserByUsername(credentials.getUsername());
		System.out.println("FOUND USER: " + (retrievedUser != null));
		
		if(retrievedUser != null){
			System.out.println(retrievedUser.getCredentials().getUsername());
			retrievedUser.addAttempt();
			System.out.println("CURRENT ATTEMPT NO: " + retrievedUser.getAttempts());
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			boolean success = passwordEncoder.matches(credentials.getPassword(), retrievedUser.getCredentials().getPassword());
			System.out.println("SUCCESS IS " + success);
			if(retrievedUser.getAttempts() >= 3){
				return LOGIN_MAX_ATTEMPTS;				
			}else{
				if(success){
					retrievedUser.resetAttempts();
					return LOGIN_SUCCESSFUL;
				}
			}
		}
		return LOGIN_UNSUCCESSFUL;
	}
	
	public String encrypt(String oldPassword){
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		return passwordEncoder.encode(oldPassword);
	}
}
