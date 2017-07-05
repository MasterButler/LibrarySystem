package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import beans.user.LoginCredentials;
import beans.user.User;
import manager.LoginManager;
import manager.UserManager;
import util.AttributeDictionary;
import util.DateUtil;

@Controller
@Scope("session")
public class UserController {

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat(DateUtil.NUMBER_FORMAT);
        sdf.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView showRegister(){
		ModelAndView mv = new ModelAndView("register", AttributeDictionary.USER, new User());
		return mv;
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String finishRegister(HttpServletRequest request,
			@ModelAttribute("SpringWeb")User user, 
			BindingResult result, 
			ModelMap model){
		
		boolean success = UserManager.getInstance().addUser(user);
		if(success){
			//model.addAttribute("user_bool", success);
			System.out.println("A");
			request.getSession().setAttribute(AttributeDictionary.USER, user);
			model.addAttribute(AttributeDictionary.USER, user);
			System.out.println("B");
			System.out.println("C");
			return "register_finish";		
		}
		model.addAttribute(AttributeDictionary.USER, user);
		model.addAttribute("registerErrorMessage", "Username, ID Number, or Email has already been taken.");
		return "register";
	}
}
