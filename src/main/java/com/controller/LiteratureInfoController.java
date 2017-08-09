package com.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.beans.Literature;
import com.beans.Name;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.handler.ErrorHandler;
import com.manager.LiteratureManager;
import com.manager.UserManager;
import com.util.AttributeDictionary;
import com.util.DateUtil;

@Controller
@Scope("session")
public class LiteratureInfoController {
	
	@RequestMapping("/literature_info")
	public ModelAndView showMessage(
		@RequestParam(value = "id", required = true) String id){
		
		Literature toView = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
		//ReviewList reviews = ReviewManager.getInstance().searchReviewsByLiteratureId();
		ModelAndView mv = new ModelAndView("literature_info");
		mv.addObject(AttributeDictionary.LITERATURE, toView);
		return mv;
	}
	
	@RequestMapping(value = "/literature_edit", method = RequestMethod.GET)
	public ModelAndView editLiterature(
			HttpServletRequest request,
			@RequestParam(value = "id", required = true) String id){
		
		ModelAndView mv;
		User user = ((User)request.getSession().getAttribute(AttributeDictionary.USER));
		System.out.println("IN HERE");
		if(user != null){
			System.out.println("NOT NULL");
			System.out.println(user.getUserType());
			if(user.getUserType() == UserTypes.LIBRARY_STAFF.getValue() || user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
				Literature literature = LiteratureManager.getInstance().searchLiteratureById(Long.valueOf(id));
				mv = new ModelAndView("literature_edit");
				mv.addObject(AttributeDictionary.LITERATURE, literature);	
				
				return mv;
			}
		}
		return ErrorHandler.goToAccessDenied();
	}
	
	@InitBinder
	public void bindingPreparation(WebDataBinder binder) {
	  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	  CustomDateEditor orderDateEditor = new CustomDateEditor(dateFormat, true);
	  binder.registerCustomEditor(Date.class, orderDateEditor);
	}
	
	@RequestMapping(value = "/literature_edit", method = RequestMethod.POST)
	public String editLiterature(HttpServletRequest request,
			@ModelAttribute("SpringWeb")Literature literature, 
			BindingResult result,
			ModelMap model){
		
		String action = request.getParameter("action");
		System.out.println("THE ID OF REQUESTER IS: " + request.getParameter("id"));
		
		if(action.contains("Add Author")){
			System.out.println("DONE ADDING");
			return addAuthors(request, model, literature);
		}else if(action.contains("Delete Author")){
			System.out.println("DONE DELETING");
			String index = action.split(" ")[action.split(" ").length-1];
			int indexToRemove = Integer.valueOf(index)-1;
			return deleteAuthors(request, model, literature, indexToRemove);
		}else if(action.contains("Save")){
			System.out.println("WHAT I GOT FROM DATE: " + DateUtil.displayDate(literature.getDatePublished()));
			return saveEdit(request, model, literature);
		}
		return ErrorHandler.goToHomePageString();
		
	}
	
	public String addAuthors(HttpServletRequest request, ModelMap model, Literature literature){
		literature.addAuthor(new Name("", "", ""));
		LiteratureManager.getInstance().updateLiteratureWithId(literature.getId(), literature);
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literature_edit";
	}
	
	public String deleteAuthors(HttpServletRequest request, ModelMap model, Literature literature, int indexToRemove){
		if(literature.getAuthors().size() > 1){
			literature.getAuthors().remove(indexToRemove);
			LiteratureManager.getInstance().updateLiteratureWithId(literature.getId(), literature);
		}else{
			model.addAttribute("author_warning", "There must be at least one (1) author.");
		}
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		return "/literature_edit";
	}
	
	public String saveEdit(HttpServletRequest request, ModelMap model, Literature literature){
		LiteratureManager.getInstance().updateLiteratureWithId(literature.getId(), literature);
		model.addAttribute(AttributeDictionary.LITERATURE_LIST, LiteratureManager.getInstance().getAllLiterature());
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literatures";
	}
}
