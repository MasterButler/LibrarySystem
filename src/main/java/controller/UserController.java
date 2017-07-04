package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.Cookie;
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

import beans.user.User;
import manager.UserManager;
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
		ModelAndView mv = new ModelAndView("register", "user", new User());
		return mv;
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String addStudent(HttpServletRequest request,
			@ModelAttribute("SpringWeb")User user, 
			BindingResult result, ModelMap model){
		
//		if(result.hasErrors()){
//			return "register";
//		}else{		
		boolean success = UserManager.getInstance().addUser(user);
		if(success){
			//model.addAttribute("user_bool", success);
			System.out.println("A");
			request.getSession().setAttribute("user", user);
			System.out.println("B");
			model.addAttribute("user", user);
			System.out.println("C");
			return "register_finish";		
		}
//		}
		//request.getSession().setAttribute("user", user);
		model.addAttribute("user", new User());
		model.addAttribute("errorMessage", "Username, ID Number, or Email has already been taken.");
		return "register";
	}
}
