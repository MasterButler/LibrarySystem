package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import beans.user.LoginCredentials;
import beans.user.User;
import manager.LiteratureManager;
import manager.ReservationManager;
import manager.UserManager;
import util.AttributeDictionary;

@Controller
public class LiteratureReservationController{
String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/reservation")
	public ModelAndView showReservationPage(
			HttpServletRequest request,
			@RequestParam(value = "id", required = true) String id) {
		
		System.out.println("in controller");
 
		Literature toReserve = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		
		ModelAndView mv;
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			mv = new ModelAndView("literature_reservation");
			mv.addObject("literature", toReserve);
		}else{
			mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
		}
		
		
		return mv;
	}
	
	@RequestMapping("/reservation/confirmation")
	public ModelAndView showReservationConfirmation(
			HttpServletRequest request,
			@RequestParam(value = "id", required = true) String id) {
		
		ModelAndView mv;
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			Literature lit = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
			User user = UserManager.getInstance().searchUserById(((User)request.getSession().getAttribute(AttributeDictionary.USER)).getId());
			boolean successful = LiteratureManager.getInstance().reserve(lit, user);
			
			mv = new ModelAndView("literature_reservation_result");
			mv.addObject("literature", lit);
			mv.addObject("literature_reservation_bool", successful);
			request.getSession().setAttribute(AttributeDictionary.USER, user);
		}else{
			mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
		}
		return mv;
	}
	
	@RequestMapping("/my_literaturelist")
	public ModelAndView showBorrowedLiteratureList(
			HttpServletRequest request){
		
		ModelAndView mv;
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			mv = new ModelAndView("my_literaturelist");
		}else{
			mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
		}
		return mv;
	}
	
	@RequestMapping("/borrow_literature")
	public String borrowLiterature(
			HttpServletRequest request,
			@RequestParam(value="id", required = true) String id){
		Literature toBorrow = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		String currentHolderId = toBorrow.getStatus().getCurrentHolder().getId();
		User loggedUser = (User) request.getSession().getAttribute(AttributeDictionary.USER);
		String loggedUserId = loggedUser.getId();
		
		System.out.println("LITERARY ID          : " + toBorrow.getId());
		System.out.println("CURRENT ID YOU HAVE  : " + currentHolderId);
		System.out.println("LOGGED USER ID OF LIT: " + loggedUserId);
		
		if(currentHolderId.equalsIgnoreCase(loggedUserId)){
			LiteratureManager.getInstance().borrow(toBorrow);
			System.out.println("BORROWED");
		}
		//TODO fix variable currentHolder in Status.java and add cross checking if requesting user and reserved user is the same to finish the borrowing sequence
		return "my_literaturelist";
	}
}
