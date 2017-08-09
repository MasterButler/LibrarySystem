package com.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.beans.list.LiteratureList;
import com.beans.list.MeetingRoomList;
import com.manager.LiteratureManager;
import com.manager.MeetingRoomManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
public class MeetingRoomController {
	
	@RequestMapping(value = "/meeting_room_view", method = RequestMethod.GET)
	public ModelAndView showMessage() {
			System.out.println("in controller");
	 
			MeetingRoomList meetingrooms = MeetingRoomManager.getInstance().getAllMeetingRooms();
			
			ModelAndView mv = new ModelAndView("meeting_room_view");
			mv.addObject(AttributeDictionary.MEETING_ROOM_LIST, meetingrooms);
			return mv;
	} 
}
