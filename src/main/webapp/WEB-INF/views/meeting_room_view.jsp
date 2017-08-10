<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.Date" %>
<%@ page import="com.beans.user.UserTypes" %>    
<%@ page import="com.beans.Status" %>
<%@ page import="com.beans.MeetingRoom" %>
<%@ page import="com.beans.MeetingRoomTimeSlots" %>
<%@ page import="com.manager.MeetingRoomManager" %>
<%@ page import="com.util.DateUtil" %>
<%@ page import="com.util.AttributeDictionary" %>

<!DOCTYPE html>
<html>
<head>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
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
	                            "<h4 class=\"card-title\">Booking Details</h4>" +
	                            "<p class=\"card-text\">Room Name: " +appendRoom+
	                            "<br>Reservation Time: " +appendTime + "</p>"  +
	                    "<div class=\"row col-sm-10\"><div class=\"col-xs-12\">" +      
	                    "<form method=\"POST\" action=\"meeting_room_reserve?" +
	                            "${AttributeDictionary.MEETING_ROOM_INDEX}=" + row + 
	                            "&${AttributeDictionary.MEETING_TIME_INDEX}=" + col + "\">" +
	                        
	                        	"<input type=\"submit\" class=\"btn btn-info\" value=\"Submit\"></form></div></div>" ;
	                
	                $(".reservation_Information").show();
	                $(".reservation_Information").html(format);
	            }
	            
	
	        });
	    });
	</script>
	<style>
		a.toggleReservationInHold{
			width: 55px;
		    height: 25px; 
		    float:left; 
		    display: block; 
		    background-color:#ED1C24;   
			border-style:solid; 
			border-color:white;   
			
		}
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
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
	
	<%@include file="header.jsp" %>
	<div class="container after-header"></div>
	
	<div class="container after-header">
		<div class="row">
			<div class="col-xs-12">
				<h4>Meeting Room Reservation</h4>
				<div class="card p-5">
					<table style="font-family:arial;font-size:10px;" cellpadding = "0" cellspacing="1" >
					<tr>
						<td colspan="<%=MeetingRoomTimeSlots.slots.length + 1%>" align="center">
							<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60*60*24*1000)%>"/>
							<p style="font-size:14px;font-weight:bold;padding:0px;margin:0px"  ><fmt:formatDate pattern = "MMMM dd, yyyy (EEEE)" value = "${tomorrow}"/></p> 
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
		                                    
		                                    <c:set var="userList" value = "${meetingroom.userIsHolding}"/>
		                                    <c:set var="userListTime" value = "${userList[index]}"/>
											<c:choose> 
		                                        <c:when test="${userListTime == null}">
													<a class = "toggleReservationUp" style="border-width: 0px 1px 0px 0px; margin-right:4px;"></a>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${userListTime.availability == Status.STATUS_AVAILABLE}">
															<a class = "toggleReservationUp" style="border-width: 0px 1px 0px 0px; margin-right:4px;"></a>
														</c:when>
														<c:when test="${userListTime.availability == Status.STATUS_RESERVED}">
															<c:choose>
																<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
																	<a class = "toggleReservationInHold" style="border-width: 0px 1px 0px 0px; margin-right:4px;"></a>
																</c:when>
															</c:choose>
														</c:when>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</div>
									</td>
								</c:forEach>
							</tr>
						</c:forEach>
				</table>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="card p-2">
					<div class = "reservation_Information"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>