package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import beans.Name;
import beans.user.User;
import manager.LiteratureManager;
import util.AttributeDictionary;

@Controller
public class LiteratureInfoController {
	
	@RequestMapping("/literature_info")
	public ModelAndView showMessage(
		@RequestParam(value = "id", required = true) String id){
		
		Literature toView = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		//ReviewList reviews = ReviewManager.getInstance().searchReviewsByLiteratureId();
		ModelAndView mv = new ModelAndView("literature_info");
		mv.addObject("literature", toView);
		return mv;
	}
	
	@RequestMapping(value = "/literature_edit", method = RequestMethod.GET)
	public ModelAndView editLiterature(
			@RequestParam(value = "id", required = true) String id){
		
		Literature literature = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		
		ModelAndView mv = new ModelAndView("literature_edit");
		mv.addObject(AttributeDictionary.LITERATURE, literature);
		return mv;
	}
	
	@RequestMapping(value = "/literature_edit", method = RequestMethod.POST)
	public String editLiterature(HttpServletRequest request,
			@ModelAttribute("SpringWeb")Literature literature, 
			BindingResult result,
			ModelMap model){
		
		String action = request.getParameter("action");
		if(action.contains("Add Author")){
			System.out.println("DONE ADDING");
			return addAuthors(request, model, literature);
		}else if(action.contains("Delete Author")){
			System.out.println("DONE DELETING");
			String index = action.split(" ")[action.split(" ").length-1];
			int indexToRemove = Integer.valueOf(index);
			return deleteAuthors(request, model, literature, indexToRemove);
		}else if(action.contains("Save Edits")){
			return saveEdit(request, model, literature);
		}else{
			return "/index";
		}
	}
	
	public String addAuthors(HttpServletRequest request, ModelMap model, Literature literature){
		literature.addAuthor(new Name("Firstname", "Middlename", "Lastname"));
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literature_edit";
	}
	
	public String deleteAuthors(HttpServletRequest request, ModelMap model, Literature literature, int indexToRemove){
		literature.getAuthors().remove(indexToRemove);
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literature_edit";
	}
	
	public String saveEdit(HttpServletRequest request, ModelMap model, Literature literature){
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literatures";
	}
}
