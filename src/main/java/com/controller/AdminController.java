package com.controller;

import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.beans.list.UserList;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.handler.ErrorHandler;
import com.logger.MyLogger;
import com.manager.UserManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class AdminController {
	
	@RequestMapping("/staff_list")
	public ModelAndView showStaffList(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				UserList staffList = getUserList(UserTypes.LIBRARY_STAFF.getValue());
				
				ModelAndView mv = new ModelAndView("staff_list");
				mv.addObject(AttributeDictionary.STAFFLIST, staffList);
				
				MyLogger.log(Level.INFO, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " accessed staff listing");
				return mv;
			}else{
				MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " tried to access the staff listing");
			}
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the staff listing.");
		return ErrorHandler.goToAccessDenied();
	}
	
	@RequestMapping(value = "/admin_account_create", method = RequestMethod.GET)
	public ModelAndView showAdminAccountCreation(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				ModelAndView mv = new ModelAndView("admin_account_create", AttributeDictionary.USER, new User());
				MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " accessed admin account creation");
				return mv;
			}
			MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " tried to access the admin account creation");
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the admin account creation.");
		return ErrorHandler.goToAccessDenied();
	}
	
	@RequestMapping(value = "/admin_account_create", method = RequestMethod.POST)
	public String showStaffCreation(HttpServletRequest request,
			@ModelAttribute("SpringWeb")User user, 
			BindingResult result, 
			ModelMap model){
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User curr = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(curr.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				String action = request.getParameter("action");
				if(action.equals("Register as Staff")){
					user.setUserType(UserTypes.LIBRARY_STAFF.getValue());
				}else if(action.equals("Register as Manager")){
					user.setUserType(UserTypes.LIBRARY_MANAGER.getValue());
				}
				user.setHasTempPassword(true);
				
				boolean success = UserManager.getInstance().addUser(user);
				if(success){
					MyLogger.log(Level.INFO, UserTypes.values()[curr.getUserType()].getName() + " with ID " + curr.getId() + " has created a"
							+ UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId()); 
					if(user.getUserType() == UserTypes.LIBRARY_STAFF.getValue()){
						model.addAttribute(AttributeDictionary.STAFFLIST, getUserList(UserTypes.LIBRARY_STAFF.getValue()));
						return "staff_list";
					}else if(user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
						model.addAttribute(AttributeDictionary.MANAGERLIST, getUserList(UserTypes.LIBRARY_MANAGER.getValue()));
						return "manager_list";
					}
				}
				
				model.addAttribute(AttributeDictionary.USER, user);
				model.addAttribute("registerErrorMessage", "Username, ID Number, or Email has already been taken.");
				
				return "admin_account_create";
			}
			MyLogger.log(Level.WARNING, UserTypes.values()[curr.getUserType()].getName() + " with ID " + user.getId() + " tried to access the admin account creation");
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the admin account creation.");
		return ErrorHandler.goToAccessDeniedString();
	}
	
	@RequestMapping("/manager_list")
	public ModelAndView showManagerList(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				UserList managerList = getUserList(UserTypes.LIBRARY_MANAGER.getValue());
				
				ModelAndView mv = new ModelAndView("manager_list");
				mv.addObject(AttributeDictionary.MANAGERLIST, managerList);
				MyLogger.log(Level.INFO, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " opened the manager listing");
				return mv;
			}else{
				MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " tried to access the manager listing");
			}
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the manger listing.");
		return ErrorHandler.goToAccessDenied();
	}
	
	@RequestMapping(value="/unlock_account", method=RequestMethod.GET)
	public ModelAndView unlockAccounts(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				ModelAndView mv = new ModelAndView("unlock_account");
				UserList list = UserManager.getInstance().getAllLockedAccounts();
				mv.addObject("userlist_locked", list);
				return mv;
			}else{
				MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " tried to access the user unlocking page");
			}
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the user unlocking page.");
		return ErrorHandler.goToAccessDenied();
	}
	
	@RequestMapping(value="/unlock_specific_account", method=RequestMethod.POST)
	public ModelAndView unlockTheLockedAccounts(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.ADMINISTRATOR.getValue()){
				ModelAndView mv = new ModelAndView("unlock_specific_account");
				String userId = request.getParameter("user-id");
				User userToUnlock = UserManager.getInstance().searchUserById(userId);
				userToUnlock.setAttempts(0);
				return mv;
			}else{
				MyLogger.log(Level.WARNING, UserTypes.values()[user.getUserType()].getName() + " with ID " + user.getId() + " tried to access the user unlocking capability");
			}
		}
		MyLogger.log(Level.WARNING, "An Anonymous User tried to access the user unlocking capability.");
		return ErrorHandler.goToAccessDenied(); 	
	}
	
	public UserList getUserList(int userType){
		UserList userList = UserManager.getInstance().getAllUsers();
		UserList specialList = new UserList();
		
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getUserType() == userType){
				specialList.add(userList.get(i));
			}
		}
		return specialList;
	}
}
