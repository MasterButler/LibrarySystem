package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import manager.LiteratureManager;

@Controller
public class ReservationController{
String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/reservation")
	public ModelAndView showMessage(
			@RequestParam(value = "id", required = true) String id) {
		System.out.println("in controller");
 
		Literature toReserve = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		
		ModelAndView mv = new ModelAndView("reservation");
		mv.addObject("literature", toReserve);
		return mv;
	}
	
	public String handlePost(@RequestParam String action, Model m){
		if(action.equals("reserve")){
			System.out.println("EYYY");
		}
		return action;
	}
}
