package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.user.User;
import manager.UserManager;

@Controller
public class HomepageController {
String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/index")
	public ModelAndView showMessage(
			@RequestParam(value = "id", required = false) String id) {
		System.out.println("in controller");
 
		User user = UserManager.getInstance().searchUserById(id);
		System.out.println("USER RETURNED HAS ID OF " + user.getId());
		ModelAndView mv = new ModelAndView("index");
		if(user != null)
			mv.addObject("user", user);
		return mv;
	}
}
