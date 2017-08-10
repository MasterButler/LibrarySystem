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
		
		int login_result = LoginManager.getInstance().authenticate(credentials);
		if(login_result == LoginManager.LOGIN_SUCCESSFUL){
			System.out.println("A");
			request.getSession().setAttribute("max_attempts", false);
			request.getSession().setAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername()));
			request.getSession().setMaxInactiveInterval(SessionHandler.MAX_INACTIVE_INTERVAL);
			//model.addAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername()));
			return ErrorHandler.goToHomePageString();
		}else if(login_result == LoginManager.LOGIN_MAX_ATTEMPTS){
			System.out.println("IN B");
			request.getSession().setAttribute("max_attempts", true);
			//TODO
			return "login_max_attempts";
		}
		System.out.println("IN C");
		request.getSession().setAttribute("max_attempts", false);
		model.addAttribute(AttributeDictionary.LOGIN, credentials);
		model.addAttribute("loginErrorMessage", "The entered username/password is incorrect");
		return ErrorHandler.goToLoginString();
	}
	
	@RequestMapping(value = "/login_max_attempts", method=RequestMethod.GET)
	public ModelAndView showLoginMaxAttemptsScreen(HttpServletRequest request){
		System.out.println("STEP 1 A");
		System.out.println(request.getSession().getAttribute("max_attempts"));
		boolean max = (boolean) request.getSession().getAttribute("max_attempts");
		if(max){
			return ErrorHandler.goToLogInMaxAttempts();
		}
		return ErrorHandler.goToLogin();
	}
	
	@RequestMapping(value = "/login_max_attempts", method=RequestMethod.POST)
	public ModelAndView finalizeLoginMaxAttemptsScreen(ModelMap model, HttpServletRequest request){
		System.out.println("STEP 1 B");
		
		String email = request.getParameter("login-email");
		System.out.println("EMAIL is " + email);
		User user = UserManager.getInstance().searchUserByEmail(email);
		if(user != null){
			ModelAndView mv = new ModelAndView("login_security_questions");
			mv.addObject("max_attempt_user", user);
			return mv;
		}else{
			System.out.println("NO USER FOUND");
			return ErrorHandler.goToLogInMaxAttempts();
		}
	}
	
	@RequestMapping(value="/login_security_questions", method=RequestMethod.GET)
	public ModelAndView showSecurityQuestionPage(HttpServletRequest request){
		System.out.println("IN STEP 2 A");
		String email = (String) request.getSession().getAttribute("max_attempt_user_email");
		User user = UserManager.getInstance().searchUserByEmail(email);
		if(user != null){
			ModelAndView mv = ErrorHandler.goToSecurityQuestions();
			mv.addObject("max_attempt_user", user);
			return mv;
		}else{
			return ErrorHandler.goToLogInMaxAttempts();
		}
	}
	
	@RequestMapping(value="/login_security_questions", method=RequestMethod.POST)
	public ModelAndView finalizeSecurityQuestionPage(HttpServletRequest request){
		System.out.println("IN STEP 2 B");
		String email = request.getParameter("login-email");
		String securityAnswer = request.getParameter("securityAnswer");
		User user = UserManager.getInstance().searchUserByEmail(email);
		if(user != null){
			if(user.getSecurityAnswer().equals(securityAnswer)){
				return ErrorHandler.goToHomePage();
			}
		}
		return ErrorHandler.goToSecurityQuestions();
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		//request.getSession().setAttribute(AttributeDictionary.USER, null);
		request.getSession().invalidate();
		return ErrorHandler.goToHomePageString();
	}
}
