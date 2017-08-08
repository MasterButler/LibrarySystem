package handler;
import org.springframework.web.servlet.ModelAndView;

public class ErrorHandler {
    public static ModelAndView goToLogin(){
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }
}
