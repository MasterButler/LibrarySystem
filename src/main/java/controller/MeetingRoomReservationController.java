package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import Handler.ErrorHandler;
import beans.MeetingRoom;
import beans.user.LoginCredentials;
import beans.user.User;
import manager.LiteratureManager;
import manager.MeetingRoomManager;
import util.AttributeDictionary;

@Controller
public class MeetingRoomReservationController {

	@RequestMapping(value = "/meeting_room_reserve", method = RequestMethod.POST)
	public ModelAndView reserveMeetingRoom(
			HttpServletRequest request,
			@RequestParam(value = AttributeDictionary.MEETING_ROOM_INDEX, required = true) String roomIndexString,
			@RequestParam(value = AttributeDictionary.MEETING_TIME_INDEX, required = true) String timeIndexString){
		
		System.out.println("IN CONTROLLER OF RESERVE");
		
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User) request.getSession().getAttribute(AttributeDictionary.USER);
			request.getSession().setAttribute(AttributeDictionary.USER, user);
			
			System.out.println((String) request.getSession().getAttribute(AttributeDictionary.MEETING_ROOM_INDEX));
			System.out.println((String) request.getSession().getAttribute(AttributeDictionary.MEETING_TIME_INDEX));
			
			int roomIndex = Integer.parseInt(roomIndexString);
			int timeIndex = Integer.parseInt(timeIndexString);
			
			boolean successful = MeetingRoomManager.getInstance().reserve(roomIndex, timeIndex, user);
			MeetingRoom room = MeetingRoomManager.getInstance().getMeetingRoomByIndex(roomIndex);
			
			ModelAndView mv; 
			mv = new ModelAndView("meeting_room_reservation_result");
			mv.addObject(AttributeDictionary.MEETING_ROOM_RESERVATION_SUCCESS, successful);
			mv.addObject(AttributeDictionary.MEETING_ROOM_NAME, room.getName());
			mv.addObject(AttributeDictionary.MEETING_ROOM_TIME_START, room.getUserIsHolding()[timeIndex].getDateBorrowStart());
			mv.addObject(AttributeDictionary.MEETING_ROOM_TIME_END, room.getUserIsHolding()[timeIndex].getDateBorrowEnd());
			
			return mv;
		}
		
		return ErrorHandler.goToLogin();
	}
	
	@RequestMapping("/my_roomlist")
	public ModelAndView showReservedRoomList(
			HttpServletRequest request){
		
		ModelAndView mv;
		User user = (User) request.getSession().getAttribute(AttributeDictionary.USER);
		if(user != null){
			MeetingRoomManager.getInstance().validateUserReservations(user); //TODO delete once db implementation is implemented
			for(int i = 0; i < user.getReservationList().size(); i++){
				System.out.println(MeetingRoomManager.getRoomNames()[i]);
				for(int j = 0; j < user.getReservationList().get(i).size(); j++){
					System.out.println(user.getReservationList().get(i).get(j).getDateBorrowStart());
				}
			}
			mv = new ModelAndView("my_roomlist");
		}else{
			mv = new ModelAndView("login", AttributeDictionary.LOGIN, new LoginCredentials());
		}
		return mv;
	}
}
