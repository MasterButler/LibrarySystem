package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("session")
public class HomepageController {
String message = "Welcome to Spring MVC!";
	
	@RequestMapping(value={"/"})
	public String showMessage(HttpServletRequest request) {
		System.out.println("in controller");
		
		return "index";
	}
	
	@RequestMapping(value={"/**"})
	public String showUnknownPage(HttpServletRequest request){
		return "not_found";
	}
}