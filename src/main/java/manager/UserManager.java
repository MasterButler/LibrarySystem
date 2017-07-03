package manager;

import beans.list.UserList;
import beans.user.User;

public class UserManager {
	private static volatile UserManager instance;

	private static UserList userList;
	
	private UserManager(){
		
	}
	
	public static UserManager getInstance(){
		if(instance == null){
			instance = new UserManager();
			
			userList = new UserList();
		}
		return instance;
	}
	
	public static boolean addUser(User user){
		if(searchUserById(user.getId()) == null && searchUserByUsername(user.getId()) == null){
			if(userList.add(user)){
				return true;
			}
		}
		return false;
	}
	
	public static User searchUserById(String id){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("WILL COMPARE " + id + "TO " + userList.get(i).getId());
			if(userList.get(i).getId().equals(id)){
				return userList.get(i);
			}
		}
		return null;
	}
	
	public static User searchUserByUsername(String username){
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getCredentials().getUsername().equals(username)){
				return userList.get(i);
			}
		}
		return null;
	}
	
}
