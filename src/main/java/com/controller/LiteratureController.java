package com.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.beans.LibraryObjectTypes;
import com.beans.Literature;
import com.beans.Name;
import com.beans.list.LiteratureList;
import com.beans.list.NameList;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.handler.ErrorHandler;
import com.manager.LiteratureManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class LiteratureController {
	
	@RequestMapping(value = "/literatures", method = RequestMethod.GET)
	public ModelAndView showMessage(
			@RequestParam(value="category", required = false) String category) {
			System.out.println("in controller");
	 
			ModelAndView mv = new ModelAndView("literatures");
			LiteratureList literatures;
			
			if(category != null){
				literatures = LiteratureManager.getInstance().getAllInCategory(Integer.parseInt(category));
				mv.addObject(AttributeDictionary.LITERATURE_CATEGORY, category);
			}else{
				literatures = LiteratureManager.getInstance().getAllLiterature();
			}
			
			mv.addObject(AttributeDictionary.LITERATURE_LIST, literatures);
			return mv;
	}
	
	@RequestMapping(value = "/literatures", method = RequestMethod.POST)
	public ModelAndView search(HttpServletRequest request){
		String category = request.getParameter("category");
		System.out.println("MY REQUEST IS " + category);
		LiteratureList literatures;
		if(category != null){
			literatures = LiteratureManager.getInstance().getAllInCategory(Integer.parseInt(category));
		}else{
			String searchString = request.getParameter("searchString");
			String field = request.getParameter("field");
			int fieldNum = Literature.FIELD_ALL;
			if(field != null){
				if(!field.isEmpty()){
					try{
						fieldNum = Integer.parseInt(field);
					}catch(Exception e){
						fieldNum = Literature.FIELD_ALL;
					}
				}
			}
			System.out.println("SEARCH STRING IS " + searchString);
			System.out.println("FIELD IS " + field);
			System.out.println("FIELD NUM IS " + fieldNum);
			literatures = LiteratureManager.getInstance().search(searchString, fieldNum);			
		}
		
//		int categoryType = Integer.valueOf(request.getParameter("category"));
//		literatures = LiteratureManager.getInstance().search(searchString, fieldType, categoryType);
		
		ModelAndView mv = new ModelAndView("literatures");
		mv.addObject(AttributeDictionary.LITERATURE_LIST, literatures);
		return mv;
	}
	
	@RequestMapping(value="/literatures_categories", method = RequestMethod.POST)
	public ModelAndView byCategory(HttpServletRequest request,
			ModelMap model){
		String action = request.getParameter("action");
		
		System.out.println("CATEGORIZATION NOW");
		
		ModelAndView mv = new ModelAndView("literatures");
		
		if(action.contains("All")){
			System.out.println("ALL");
			mv.addObject(AttributeDictionary.LITERATURE_LIST, LiteratureManager.getInstance().getAllLiterature());
			model.addAttribute(AttributeDictionary.LITERATURE_LIST, LiteratureManager.getInstance().getAllLiterature());
		}else if(action.contains("Books")){
			System.out.println("BOOKS");
			mv.addObject(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.BOOK.getValue()));
			model.addAttribute(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.BOOK.getValue()));
		}else if(action.contains("Thesis")){
			System.out.println("THESIS");
			mv.addObject(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.THESIS.getValue()));
			model.addAttribute(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.THESIS.getValue()));
		}else if(action.contains("Magazine")){
			System.out.println("MAGAZINES");
			mv.addObject(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.MAGAZINE.getValue()));
			model.addAttribute(AttributeDictionary.LITERATURE_LIST, filterByLiteratureType(LiteratureManager.getInstance().getAllLiterature(), LibraryObjectTypes.MAGAZINE.getValue()));
		}else{
			mv.addObject(AttributeDictionary.LITERATURE_LIST, LiteratureManager.getInstance().getAllLiterature());	
		}
		return mv;
	}
	
	public LiteratureList filterByLiteratureType(LiteratureList literatureList, int literatureType){
		LiteratureList filteredList = new LiteratureList();
		
		for(int i = 0; i < literatureList.size(); i++){
			if(literatureList.get(i).getLibraryObjectType() == literatureType){
				filteredList.add(literatureList.get(i));
			}
		}
		
		return filteredList;
	}
	
	@RequestMapping(value ="/literature_delete")
	public ModelAndView deleteLiterature(HttpServletRequest request,
			@RequestParam(value = "id", required = true) String id){
		
		ModelAndView mv;
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User) request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue() || user.getUserType() == UserTypes.LIBRARY_STAFF.getValue()){
				if(LiteratureManager.getInstance().delete(Long.valueOf(id))){
					mv = new ModelAndView("literatures");
					mv.addObject(AttributeDictionary.LITERATURE_LIST, LiteratureManager.getInstance().getAllLiterature());
					return mv;
				}
			}
		}
		return ErrorHandler.goToAccessDenied();
	}
	
	//TODO add lits
	@RequestMapping(value="/literature_add", method = RequestMethod.GET)
	public ModelAndView showAddLiterature(HttpServletRequest request){
		ModelAndView mv;
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = ((User)request.getSession().getAttribute(AttributeDictionary.USER));
			if(user.getUserType() == UserTypes.LIBRARY_STAFF.getValue() || user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
				Literature toCreate = new Literature();
				
				NameList nameList = new NameList();
				nameList.add(new Name());
				
				toCreate.setAuthors(nameList);
				
				System.out.println("IN HERE HEHE");
//				mv = new ModelAndView("literature_add", AttributeDictionary.LITERATURE, toCreate);
				long id = createBlankBook(toCreate);
				mv = new ModelAndView("redirect:/literature_edit?id=" + id);
				return mv;
			}
		}
		return ErrorHandler.goToAccessDenied();
	}
	
	@RequestMapping(value="/literature_add", method = RequestMethod.POST)
	public String addLiterature(HttpServletRequest request,
			@ModelAttribute("SpringWeb")Literature literature, 
			BindingResult result, 
			ModelMap model){
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.LIBRARY_STAFF.getValue() || user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
				String action = request.getParameter("action");
				System.out.println("ACTION IS " + action);
				if(action.contains("Add Author")){
					System.out.println("DONE ADDING");
					return addAuthors(request, model, literature);
				}else if(action.contains("Delete Author")){
					System.out.println("DONE DELETING");
					String index = action.split(" ")[action.split(" ").length-1];
					int indexToRemove = Integer.valueOf(index);
					return deleteAuthors(request, model, literature, indexToRemove);
				}else if(action.contains("Create Literature")){
					System.out.println("WILL CREATE LITERATURE");
					return createBook(request, model, literature);
				}			
			}
		}
		return ErrorHandler.goToHomePageString();
	}
	
	public String addAuthors(HttpServletRequest request, ModelMap model, Literature literature){
		literature.addAuthor(new Name("Firstname", "Middlename", "Lastname"));
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literature_add";
	}
	
	public String deleteAuthors(HttpServletRequest request, ModelMap model, Literature literature, int indexToRemove){
		literature.getAuthors().remove(indexToRemove);
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/literature_add";
	}
	
	public String createBook(HttpServletRequest request, ModelMap model, Literature literature){
		LiteratureManager.getInstance().addLiterature(literature);
		System.out.println("LITERATURE TYPE: " + literature.getLibraryObjectType() + ".");
		request.setAttribute(AttributeDictionary.LITERATURE, literature);
		model.addAttribute(AttributeDictionary.LITERATURE, literature);
		
		return "/index";
	}
	
	public long createBlankBook(Literature literature){
		return LiteratureManager.getInstance().addLiterature(literature);
	}
}
