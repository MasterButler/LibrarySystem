<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.user.UserTypes" %>
<%@ page import="com.util.DateUtil" %>   
<%@ page import="com.util.AttributeDictionary" %>   

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<style>
		.after-header {
	     padding-top: 100px;
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
				<div class="card">
				  <div class="card-block">
					<c:choose>
						<c:when test="${meeting_room_reservation_bool}">
							<h4 class="card-title">${room} has been successfully reserved under the id number ${user.id}.</h4>
							
							<h6 class="card-subtitle mb-2 text-muted">
								Your reservation will last from
								<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${time_start}" />
								to 
								<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${time_end}" />
								.</h6>			
						</c:when>
						<c:otherwise>
							<h4 class="card-title">
							This has already been reserved by another user.</h4> 
						</c:otherwise>
					</c:choose>
				  </div>
				</div>
			</div>		
		</div>
		<div class="row">
			<div class="col-xs-12">
				<a class="btn btn-primary btn-sm" href="meeting_room_view" role="button">
				Return to Room Reservation List</a>
			</div>
		</div>
	</div>
</body>
</html>