package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
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
	public String addStudent(@ModelAttribute("SpringWeb")User user, 
			BindingResult result, ModelMap model){
		
		model.addAttribute("user", user);
		
		if(result.hasErrors()){
			return "register";
		}else{		
			boolean success = UserManager.getInstance().addUser(user);
			if(success){
				//model.addAttribute("user_bool", success);
				return "register_finish";		
			}
		}
		return "register";
	}
}
