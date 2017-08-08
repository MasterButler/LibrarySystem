import org.springframework.web.servlet.ModelAndView;

public class Handler {
	public ModelAndView goToLogin(){
		ModelAndView mv = new ModelAndView("login");
		return mv;
	}
}
