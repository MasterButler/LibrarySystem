package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import manager.LiteratureManager;
import manager.ReservationManager;

@Controller
public class LiteratureReservationController{
String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/reservation")
	public ModelAndView showReservationPage(
			@RequestParam(value = "id", required = true) String id) {
		System.out.println("in controller");
 
		Literature toReserve = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		
		ModelAndView mv = new ModelAndView("literature_reservation");
		mv.addObject("literature", toReserve);
		return mv;
	}
	
	@RequestMapping("/reservation/confirmation")
	public ModelAndView showReservationConfirmation(
			@RequestParam(value = "id", required = true) String id) {
		
		Literature lit = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		boolean successful = ReservationManager.reserve(lit);
		
		ModelAndView mv = new ModelAndView("literature_reservation_result");
		mv.addObject("literature", lit);
		mv.addObject("literature_reservation_bool", successful);
		return mv;
	}
}
