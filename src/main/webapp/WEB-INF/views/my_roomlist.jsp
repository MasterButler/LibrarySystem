<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.Status" %>
<%@ page import="com.util.DateUtil" %>
<%@ page import="com.manager.MeetingRoomManager" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>

	<%@include file="header.jsp" %>
	
	<div class="container after-header">
		<div class="row">
			<div class="col-xs-12">
				<h3>Reserved Rooms</h3>
				<c:forEach items="${user.reservationList}" var="reservation" varStatus="loop"> 
					<c:set var="index" value="${loop.index}"/>
					<c:choose>
						<c:when test="${fn:length(reservation) != 0}">
							<div class="card lit-width">
								<div class="card-block">
									<h4 class="card-title"><c:out value="${MeetingRoomManager.ROOM_NAME[index]}"/></h4>
					                <c:forEach items="${reservation}" var="status" varStatus="inner">
										<h6 class="card-subtitle mb-2">Start: 
											<span class="card-text text-muted">
												<fmt:formatDate value="${status.dateBorrowStart}" pattern="${DateUtil.NUMBER_FORMAT}"/>  
												<fmt:formatDate value="${status.dateBorrowStart}" pattern="${DateUtil.TIME_FORMAT}"/></span>
										</h6>
										<h6 class="card-subtitle mb-2">End:
											<span class="card-text text-muted">
												<fmt:formatDate value="${status.dateBorrowEnd}" pattern="${DateUtil.NUMBER_FORMAT}"/>  
												<fmt:formatDate value="${status.dateBorrowEnd}" pattern="${DateUtil.TIME_FORMAT}"/></span>
										</h6>
									</c:forEach>
								</div>
							</div>
						</c:when>
						
						<c:otherwise></c:otherwise>
						
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>	
</body>
</html>