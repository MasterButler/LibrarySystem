package com.beans.user;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import com.google.common.hash.Hashing;

public class LoginCredentials {
	private String username;
	private String password;
	
	public LoginCredentials(){
		
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public LoginCredentials(String username, String password){
		this.username = username;
		setPassword(password);
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
		System.out.println("USER: " + username);
		System.out.println("STORING: " + this.password);
		System.out.println();
	}
	
	public boolean matches(LoginCredentials c){

		System.out.println("CHECK PWORD");
		System.out.println("SENT  : " + c.getPassword() + " \nSTORED: " + getPassword());
		if(this.username.equalsIgnoreCase(c.getUsername())){
			if(this.password.equalsIgnoreCase(c.getPassword())){
				return true;
			}
		}
		return false;
	}
}
