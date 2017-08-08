<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>    
<%@ page import="beans.MeetingRoom" %>
<%@ page import="beans.MeetingRoomTimeSlots" %>
<%@ page import="manager.MeetingRoomManager" %>
<%@ page import="util.DateUtil" %>
<%@ page import="util.AttributeDictionary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
	    $(document).ready(function(){
	        $('a.toggleReservationUp').click(function(){
	            if($(this).hasClass("toggleReservationDown")){
	                $(this).removeClass("toggleReservationDown").addClass("toggleReservationUp");
	                
	                $(".reservation_Information").hide();
	            }else{
	                $(".toggleReservationDown").removeClass("toggleReservationDown").addClass("toggleReservationUp");
	                $(this).removeClass("toggleReservationUp").addClass("toggleReservationDown");
	                
	                   var $td = $(this).closest('td');
	                var col = $td.index() - 1;
	                var $tr = $(this).closest('tr');
	                var row = $tr.index() - 2;
	                
	                console.log(col);
	                var importedListTime = [
	                <%    String[] list = MeetingRoomTimeSlots.getSlots();
	                    for(int i = 0; i < list.length; i++){                    %>
	                        "<%=list[i]%>"
	                <%        if(i + 1 < list.length){                             %>
	                            ,
	                <%        }                                                    
	                    }                                                        %>
	                ];
	                
	                
	                var importedRoom =[
	                <%     String[] roomList = MeetingRoomManager.getRoomNames();
	                    for(int i = 0; i < roomList.length; i++){                %>
	                        "<%=roomList[i]%>"
	                <%        if(i + 1 < list.length){                             %>
	                            ,
	                <%        }                                                    
	                    }                                                        %>
	                ];
	                
	                console.log("var=\"${AttributeDictionary.MEETING_ROOM_INDEX}\"");
	                console.log("var=\"${AttributeDictionary.MEETING_ROOM_INDEX}\" value=\"" + row + "\"/>");
	                
	                var appendTime = importedListTime[col];
	                var appendRoom = importedRoom[row]; 
	                var format =
	                    "<table>" +
	                        "<tr>" + 
	                            "<td colspan = \"2\" align = \"center\">Booking Details</td>" +
	                        "</tr>" +
	                        "<tr>" + 
	                            "<td>Room Name </td>" +
	                            "<td>" + appendRoom + "</td>" +
	                        "</tr>" + 
	                        "<tr>" + 
	                            "<td>Reservation Time</td>" +
	                            "<td>" + appendTime + "</td>" + 
	                        "</tr>" +
	                    "</table>" +
	                    "<form method=\"POST\" action=\"meeting_room_reserve?" +
	                            "${AttributeDictionary.MEETING_ROOM_INDEX}=" + row + 
	                            "&${AttributeDictionary.MEETING_TIME_INDEX}=" + col + "\">" +
	                        "<table>" +
	                            "<tr>" +    
	                                "<td><button type = \"submit\" value = \"reserve\">Confirm Reservation</button></td>" +
	                            "</tr>" + 
	                        "</table>" + 
	                    "</form>";
	                
	                $(".reservation_Information").show();
	                $(".reservation_Information").html(format);
	            }
	            
	
	        });
	    });
	</script>
	<style>
		a.toggleReservationUp {
			width: 55px;
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
            width: 55px; 
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
		Back to <a href="./">Homepage</a>
		
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
                                    <c:set var="index" value = "${loop.index}"/>
                                    
                                    <c:set var="userListTime" value = "${userList[index]}"/>
									<!-- 
									<c:out value="${indexA}"/> and <c:out value="${indexB}"/>
									${userListTimeA.name.firstName}
									 -->
									<c:choose> 
                                        <c:when test="${userListTime == null}">
											<a class = "toggleReservationUp" style="border-width: 0px 1px 0px 0px; margin-right:4px;">
											</a>
										</c:when>
									</c:choose>
								</div>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
		</table>
		        
        <div class = "reservation_Information">
        </div>
		
</body>


</html>