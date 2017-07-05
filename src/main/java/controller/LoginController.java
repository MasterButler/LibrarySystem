package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import beans.user.LoginCredentials;
import manager.LoginManager;
import manager.UserManager;
import util.AttributeDictionary;

@Controller
@Scope("session")
public class LoginController {
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView showLogin(){
		ModelAndView mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
		return mv;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String finishLogin(HttpServletRequest request,
			@ModelAttribute("SpringWeb")LoginCredentials credentials,
			BindingResult result,
			ModelMap model){
		
		if(LoginManager.getInstance().authenticate(credentials)){
			System.out.println("A");
			request.getSession().setAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername()));
			model.addAttribute(AttributeDictionary.USER, UserManager.getInstance().searchUserByUsername(credentials.getUsername ()));
			return "index";
		}else{
			System.out.println("B");
			model.addAttribute(AttributeDictionary.LOGIN, credentials);
			model.addAttribute("loginErrorMessage", "The entered username/password is incorrect");
			return "login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		request.getSession().setAttribute(AttributeDictionary.USER, null);
		return "index";
	}
}
