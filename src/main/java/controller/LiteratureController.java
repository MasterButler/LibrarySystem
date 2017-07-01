package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import date.DateUtil;

@Controller
public class LiteratureController {

	String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/sample")
	public ModelAndView showMessage(
		@RequestParam(value = "id", required = true) String id,
		//@RequestParam(value = "date", required = true) String date,
		@RequestParam(value = "title", required = true) String title) {
			System.out.println("in controller");
	 
			Literature newBook = new Literature();
			newBook.setId(Long.valueOf(id));
			//newBook.setDate(DateUtil.readDateFromString(("1998-11-26 12:13:59")));
			newBook.setTitle(title);
			
			ModelAndView mv = new ModelAndView("sample");
			mv.addObject("literature", newBook);
			return mv;
	}
}
