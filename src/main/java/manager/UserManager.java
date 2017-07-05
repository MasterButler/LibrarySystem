package manager;

import beans.Name;
import beans.list.UserList;
import beans.user.LoginCredentials;
import beans.user.User;
import beans.user.UserTypes;

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
			userA.setCredentials(new LoginCredentials("myName","1234"));
			userA.setEmail("a@google.com");
			userA.setName(new Name("Winfred", "D", "Villaluna"));
			userA.setId("11427574");
			userA.setUserType(UserTypes.STUDENT.getValue());
			
			User userB = new User();
			userB.setCredentials(new LoginCredentials("myOtherName","2345"));
			userB.setEmail("b@google.com");
			userB.setName(new Name("Darlene", "G", "Marpa"));
			userB.setId("11427019");
			userB.setUserType(UserTypes.FACULTY.getValue());
		
			User managerA = new User();
			managerA.setCredentials(new LoginCredentials("managerA", "121212"));
			managerA.setEmail("c@google.com");
			managerA.setName(new Name("Mana", "The", "Jeer"));
			managerA.setId("123456");
			managerA.setUserType(UserTypes.LIBRARY_MANAGER.getValue());
			
			userList.add(userA);
			userList.add(userB);
			userList.add(managerA);
		}
		return instance;
	}
	
	public boolean addUser(User user){
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
			System.out.println("WILL COMPARE " + id + "TO " + userList.get(i).getId());
			if(userList.get(i).getId().equals(id)){
				return userList.get(i);
			}
		}
		System.out.println("DIDN'T FIND ANY");
		return null;
	}
	
	public User searchUserByUsername(String username){
		for(int i = 0; i < userList.size(); i++){
			System.out.println("WILL COMPARE " + username + "TO " + userList.get(i).getCredentials().getUsername());
			if(userList.get(i).getCredentials().getUsername().equals(username)){
				return userList.get(i);
			}
		}
		System.out.println("DIDN'T FIND ANY");
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
