package manager;

import beans.user.LoginCredentials;
import beans.user.User;

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
		User retrievedUser = UserManager.getInstance().searchUserByEmail(credentials.getUsername());
		System.out.println("FOUND USER: " + (retrievedUser != null));
		if(retrievedUser != null){
			if(retrievedUser.getCredentials().matches(credentials)){
				return true;
			}
		}
		return false;
	}
}
