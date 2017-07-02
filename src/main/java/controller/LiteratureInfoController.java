package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beans.Literature;
import manager.LiteratureManager;

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
}
