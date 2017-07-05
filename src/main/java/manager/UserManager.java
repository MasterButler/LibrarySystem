package manager;

import beans.Name;
import beans.list.UserList;
import beans.user.LoginCredentials;
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
			
			User userA = new User();
			userA.setCredentials(new LoginCredentials("a@a.a","1234"));
			userA.getCredentials().setUsername("myName");
			userA.setName(new Name("Winfred", "D", "Villaluna"));
			userA.setId("11427574");
			
			User userB = new User();
			userB.setCredentials(new LoginCredentials("b@b.b","2345"));
			userB.getCredentials().setUsername("myOtherName");
			userB.setName(new Name("Darlene", "G", "Marpa"));
			userB.setId("11427019");
		
			userList.add(userA);
			userList.add(userB);
		}
		return instance;
	}
	
	public boolean addUser(User user){
		if(searchUserById(user.getId()) == null && searchUserByUsername(user.getId()) == null){
			if(userList.add(user)){
				return true;
			}
		}
		return false;
	}
	
	public User searchUserById(String id){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("WILL COMPARE " + id + "TO " + userList.get(i).getId());
			if(userList.get(i).getId().equals(id)){
				return userList.get(i);
			}
		}
		return null;
	}
	
	public User searchUserByUsername(String username){
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getCredentials().getUsername().equalsIgnoreCase(username)){
				return userList.get(i);
			}
		}
		return null;
	}
	
	public User searchUserByEmail(String email){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("COMPARING " + email + " AND " + userList.get(i).getEmail());
			if(userList.get(i).getEmail().equalsIgnoreCase(email)){
				System.out.println("RETURNING USER WITH EMAIL " + email);
				return userList.get(i);
			}
		}
		return null;
	}
	
}
