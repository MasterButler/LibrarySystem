<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
<%@ page import="beans.Literature" %>
<%@ page import="beans.MeetingRoomTimeSlots" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
		    $('a.toggleReservationUp').click(function(){
		        $(this).toggleClass("toggleReservationDown");
		    });
		});
		
		resetReservationClicks(){
			
		}
	</script>
	
	<style>
		a.toggleReservationUp {
		    width: 25px; 
		    height: 25px; 
		    float:left; 
		    display: block; 
		    background-color:#22B14C;   
			border-style:solid; 
			border-color:white;     
	    }
	    
	    a.toggleReservationUp:hover{
	    	background-color:#CDEE6A;
	    }
	
		a.toggleReservationDown {
		    width: 25px; 
		    height: 25px; 
		    float:left; 
		    display: block; 
		    background-color:#F5B93C;   
			border-style:solid; 
			border-color:white;     
	    }
	    
	    a.toggleReservationDown:hover{
	    	background-color:#FFE284;
	    }
	</style>

</head>
<body>
		
		<table style="font-family:arial;font-size:10px;" cellpadding = "0" cellspacing="1" >
			<tr>
				<td colspan="<%=MeetingRoomTimeSlots.slots.length + 1%>" align="center">
					<c:set var = "now" value = "<%= DateUtil.getCurrentDate()%>" />
					<p style="font-size:14px;font-weight:bold;padding:0px;margin:0px"  ><fmt:formatDate pattern = "MMMM dd, yyyy (EEEE)" value = "${now}"/></p> 
				</td>
			</tr>
			<tr>
				<td></td>
			<c:forEach items = "${MeetingRoomTimeSlots.slots}" var = "timeslot" varStatus="loop">
				<td> ${timeslot} </td>
			</c:forEach>
			</tr>
				<c:forEach items = "${meetingroomlist}" var="meetingroom" varStatus="room">
					<c:set var="roomNum" value="${room.index}"/>
					<tr>
						<td> ${meetingroom.name} &nbsp;&nbsp;
						</td>
						<c:forEach items = "${MeetingRoomTimeSlots.slots}" var = "timeslot" varStatus="loop">
							<td>
								<div style="width:60px;height:25px;float:left;background-color:#7ABCDE">
									<c:set var="indexA" value="${loop.index}" />
									<c:set var="indexA" value="${2 * indexA}" />
									
									<c:set var="indexB" value="${loop.index}" />
									<c:set var="indexB" value="${2 * indexB + 1}" />
									
									<c:set var="meetingroom" value = "${meetingroomlist[roomNum]}"/>
									<c:set var="userList" value = "${meetingroom.userIsHolding}"/>
									
									<c:set var="userListTimeA" value = "${userList[indexA]}"/>
									<c:set var="userListTimeB" value = "${userList[indexB]}"/>
									
									<!-- 
									<c:out value="${indexA}"/> and <c:out value="${indexB}"/>
									${userListTimeA.name.firstName}
									 -->
									<c:choose> 
										<c:when test="${userListTimeA == null}">
											<a class = "toggleReservationUp" style="border-width: 0px 1px 0px 0px; margin-right:4px;">
											</a>
										</c:when>
										<c:otherwise>
											<div style="width: 25px; height: 25px; float:left; display: block; 
											border-width: 0px 1px 0px 0px;  
											border-style:solid; 
											border-color: transparent;
											padding-right:4px">
											</div>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${userListTimeB == null}">
											<a class = "toggleReservationUp" style="border-width: 0px 1px 0px 1px; margin-right:0px;">
											</a>
										</c:when>
									</c:choose>
								</div>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
		</table>
</body>


</html>