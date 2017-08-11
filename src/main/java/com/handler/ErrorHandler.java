package com.handler;
import org.springframework.web.servlet.ModelAndView;

public class ErrorHandler {
    public static ModelAndView goToLogin(){
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }
    
    public static String goToLoginString(){
    	return "redirect:/login";
    }
    
    public static ModelAndView goToAccessDenied(){
    	System.out.println("RETURNING ACCESS DENIED");
    	ModelAndView mv = new ModelAndView("access_denied");
        return mv;
    }
    
    public static ModelAndView goToNotFound(){
    	ModelAndView mv = new ModelAndView("not_found");
        return mv;
    }
    
    public static ModelAndView goToHomePage(){
    	System.out.println("RETURNING HOME PAGE");
    	ModelAndView mv = new ModelAndView("redirect:/");
        return mv;
    }
    
    public static String goToHomePageString(){
    	return "redirect:/";
    }
    
    public static ModelAndView goToLogInMaxAttempts(){
    	ModelAndView mv = new ModelAndView("redirect:/login_max_attempts");
    	return mv;
    }
    
    public static String goToLogInMaxAttemptsString(){
    	return "redirect:/login_max_attempts";
    }
    
    public static ModelAndView goToSecurityQuestions(){
    	ModelAndView mv = new ModelAndView("redirect:/login_security_questions");
    	return mv;
    }
    
    public static ModelAndView goToLiteratureList(){
    	ModelAndView mv = new ModelAndView("redirect:/literatures");
    	return mv;
    }
}
