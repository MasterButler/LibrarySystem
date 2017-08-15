package com.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.beans.Literature;
import com.beans.Review;
import com.beans.list.LiteratureList;
import com.beans.list.UserList;
import com.beans.user.User;
import com.beans.user.UserTypes;
import com.handler.ErrorHandler;
import com.manager.LiteratureManager;
import com.manager.UserManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class LiteratureReviewController {
	
	@RequestMapping(value = "/submit_review", method = RequestMethod.POST)
	public ModelAndView showStaffList(HttpServletRequest request){
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User) request.getSession().getAttribute(AttributeDictionary.USER);
			if(user.getUserType() == UserTypes.STUDENT.getValue() || user.getUserType() == UserTypes.FACULTY.getValue()){
				String lit_id_raw = request.getParameter("literature-id");
				Long lit_id = Long.valueOf(lit_id_raw);
				
				String user_id_raw = request.getParameter("literature-id");
				//Long user_id = Long.valueOf(lit_id_raw);
				
				String comment = request.getParameter("comment");
				
				Literature lit = LiteratureManager.getInstance().searchLiteratureById(lit_id);
				User userReviewer = UserManager.getInstance().searchUserById(user_id_raw);
				
				Review review = new Review();
				review.setDescription(comment);
				review.setReviewDoneBy(userReviewer);
				review.setReviewDoneFor(lit);
				
				lit.addReview(review);
				
				for(int i = 0; i < lit.getReviews().size(); i++){
					System.out.println(lit.getReviews().get(i).getDescription() + "\n");
				}
				
				String referrer = request.getHeader("Referer");
				System.out.println("REFERRER IS " + referrer);
				System.out.println("NEW LINK IS " + "literatures");
				
				LiteratureList literatures = LiteratureManager.getInstance().getAllLiterature();
				return new ModelAndView("review_finish");
			}
		}
		return ErrorHandler.goToHomePage();
	}
				

}
