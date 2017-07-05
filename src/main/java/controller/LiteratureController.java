package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import beans.list.LiteratureList;
import manager.LiteratureManager;
import util.AttributeDictionary;

@Controller
public class LiteratureController {

	String message = "Welcome to Spring MVC!";
	
	@RequestMapping("/literatures")
	public ModelAndView showMessage() {
			System.out.println("in controller");
	 
			LiteratureList literatures = LiteratureManager.getInstance().getAllLiterature();
			
			ModelAndView mv = new ModelAndView("literatures");
			mv.addObject(AttributeDictionary.LITERATURE_LIST, literatures);
			return mv;
	}
	
	@RequestMapping(value = "/literatures", method = RequestMethod.POST)
	public ModelAndView search(HttpServletRequest request){
		String searchString = request.getParameter("searchString");

		int fieldType = Integer.valueOf(request.getParameter("field"));
		System.out.println("SEARCHSTRING: " + searchString);
		System.out.println("FIELDTYPE" + fieldType);
		LiteratureList literatures = null;; 
		literatures = LiteratureManager.getInstance().search(searchString, fieldType);
		
		ModelAndView mv = new ModelAndView("literatures");
		mv.addObject(AttributeDictionary.LITERATURE_LIST, literatures);
		return mv;
	}
}
