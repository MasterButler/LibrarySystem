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

import com.beans.user.LoginCredentials;
import com.beans.user.User;
import com.handler.ErrorHandler;
import com.handler.SessionHandler;
import com.handler.TextHandler;
import com.manager.LoginManager;
import com.manager.UserManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class LoginController {
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView showLogin(
			HttpServletRequest request){

		User user = (User) request.getSession().getAttribute(AttributeDictionary.USER);
		
		if(user == null){
			ModelAndView mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
			return mv;
		}
		return ErrorHandler.goToHomePage();
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String finishLogin(HttpServletRequest request,
			@ModelAttribute("SpringWeb")LoginCredentials credentials,
			BindingResult result,
			ModelMap model){
		System.out.println("ENTERED IS " + credentials.getPassword());
		
		credentials.setPassword(LoginManager.getInstance().encrypt(credentials.getPassword()));
		
		if(LoginManager.getInstance().authenticate(credentials)){
			
			System.out.println("A");
			request.getSession().setAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername()));
			request.getSession().setMaxInactiveInterval(SessionHandler.MAX_INACTIVE_INTERVAL);
			//model.addAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername()));
			System.out.println("RETURNING THAT");
			return ErrorHandler.goToHomePageString();
		}else{
			System.out.println("B");
			model.addAttribute(AttributeDictionary.LOGIN, credentials);
			model.addAttribute("loginErrorMessage", "The entered username/password is incorrect");
		}
		System.out.println("RETURNING THIS");
		return "login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		//request.getSession().setAttribute(AttributeDictionary.USER, null);
		request.getSession().invalidate();
		return ErrorHandler.goToHomePageString();
	}
}
