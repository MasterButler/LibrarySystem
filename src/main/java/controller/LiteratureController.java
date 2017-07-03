package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import beans.list.LiteratureList;
import manager.LiteratureManager;

@Controller
public class LiteratureController {

	String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/literatures")
	public ModelAndView showMessage() {
			System.out.println("in controller");
	 
			LiteratureList literatures = LiteratureManager.getInstance().getAllLiterature();
			
			ModelAndView mv = new ModelAndView("literatures");
			mv.addObject("literaturelist", literatures);
			return mv;
	}
}
