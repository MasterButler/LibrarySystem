package com.controller;

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
import com.manager.UserManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class AdminController {
	
	@RequestMapping("/staff_list")
	public ModelAndView showStaffList(){
		UserList staffList = getUserList(UserTypes.LIBRARY_STAFF.getValue());
		
		ModelAndView mv = new ModelAndView("staff_list");
		mv.addObject(AttributeDictionary.STAFFLIST, staffList);
		return mv;
	}
	
	@RequestMapping(value = "/admin_account_create", method = RequestMethod.GET)
	public ModelAndView showAdminAccountCreation(){
		ModelAndView mv = new ModelAndView("admin_account_create", AttributeDictionary.USER, new User());
		return mv;
	}
	
	@RequestMapping(value = "/admin_account_create", method = RequestMethod.POST)
	public String showStaffCreation(HttpServletRequest request,
			@ModelAttribute("SpringWeb")User user, 
			BindingResult result, 
			ModelMap model){
		
		
		String action = request.getParameter("action");
		if(action.equals("Register as Staff")){
			user.setUserType(UserTypes.LIBRARY_STAFF.getValue());
		}else if(action.equals("Register as Manager")){
			user.setUserType(UserTypes.LIBRARY_MANAGER.getValue());
		}
		user.setHasTempPassword(true);
		
		boolean success = UserManager.getInstance().addUser(user);
		if(success){
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
	
	@RequestMapping("/manager_list")
	public ModelAndView showManagerList(){
		UserList userList = UserManager.getInstance().getAllUsers();
		UserList managerList = new UserList();
		
		for(int i = 0; i < userList.size(); i++){
			if(userList.get(i).getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
				managerList.add(userList.get(i));
			}
		}
		
		ModelAndView mv = new ModelAndView("manager_list");
		mv.addObject(AttributeDictionary.MANAGERLIST, managerList);
		return mv;
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
