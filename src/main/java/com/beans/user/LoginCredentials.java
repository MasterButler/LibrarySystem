package com.beans.user;

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
		this.password = password;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public boolean matches(LoginCredentials c){
		if(this.username.equalsIgnoreCase(c.getUsername())){
			if(this.password.equalsIgnoreCase(c.getPassword())){
				return true;
			}
		}
		return false;
	}
}
