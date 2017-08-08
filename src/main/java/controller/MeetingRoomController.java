package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import beans.list.LiteratureList;
import beans.list.MeetingRoomList;
import manager.LiteratureManager;
import manager.MeetingRoomManager;
import util.AttributeDictionary;

@Controller
public class MeetingRoomController {
	
	@RequestMapping(value = "/meeting_room", method = RequestMethod.GET)
	public ModelAndView showMessage() {
			System.out.println("in controller");
	 
			MeetingRoomList meetingrooms = MeetingRoomManager.getInstance().getAllMeetingRooms();
			
			ModelAndView mv = new ModelAndView("meeting_room_view");
			mv.addObject(AttributeDictionary.MEETING_ROOM_LIST, meetingrooms);
			return mv;
	}
}
