package handler;
import org.springframework.web.servlet.ModelAndView;

public class ErrorHandler {
    public static ModelAndView goToLogin(){
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }
    
    public static ModelAndView goToAccessDenied(){
    	ModelAndView mv = new ModelAndView("redirect:/access_denied");
        return mv;
    }
    
    public static ModelAndView goToNotFound(){
    	ModelAndView mv = new ModelAndView("redirect:/not_found");
        return mv;
    }
    
    public static ModelAndView goToHomePage(){
    	ModelAndView mv = new ModelAndView("redirect:/");
        return mv;
    }
    
    public static String goToHomePageString(){
    	return "redirect:/";
    }
}
