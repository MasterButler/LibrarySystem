package com.controller;

import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.handler.ErrorHandler;
import com.logger.MyLogger;
import com.beans.MeetingRoom;
import com.beans.user.LoginCredentials;
import com.beans.user.User;
import com.manager.LiteratureManager;
import com.manager.MeetingRoomManager;
import com.util.AttributeDictionary;

@Controller
@Scope("session")
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
			
			String toWrite = "";
			if(successful){
				toWrite = room.getName() + " successfully reserved under id number " + user.getId();
			}else{
				
			}
			MyLogger.log(Level.INFO, "");
			
			
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
		System.out.println("IN MY ROOMLIST");
		ModelAndView mv;
		if(request.getSession().getAttribute(AttributeDictionary.USER) != null){
			User user = (User)request.getSession().getAttribute(AttributeDictionary.USER);
			System.out.println("USER IS " + user.getId());
			MeetingRoomManager.getInstance().validateUserReservations(user); //TODO delete once db implementation is implemented
			request.getSession().setAttribute(AttributeDictionary.USER, user);
			for(int i = 0; i < user.getReservationList().size(); i++){
				System.out.println(MeetingRoomManager.getRoomNames()[i]);
				for(int j = 0; j < user.getReservationList().get(i).size(); j++){
					System.out.println(user.getReservationList().get(i).get(j).getDateBorrowStart());
				}
			}
			mv = new ModelAndView("my_roomlist");
			return mv;
		}
		return ErrorHandler.goToLogin();
	}
}
