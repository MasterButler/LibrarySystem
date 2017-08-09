package handler;
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
}
