<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="util.DateUtil" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Spring 4 MVC - HelloWorld Index Page</title>
</head>
<body>
 
	<center>
		<h2>Hello, 
			<c:choose>
				<c:when test="${sessionScope.user != null}">
					${sessionScope.user.name.firstName}<br>
				</c:when>
				<c:when test="${sessionScope.user == null}">
					Anonymous User<br>
				</c:when>	
			</c:choose>
		
		</h2>
		<h3>
			<c:choose>
				<c:when test="${sessionScope.user != null}">
					<a href="logout">Logout</a><br>
					
					<c:choose>
						<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value ||
										sessionScope.user.userType == UserTypes.STUDENT.value}">
							<a href="my_roomlist">My Room Reservations</a><br>
							<a href="my_literaturelist">My Borrowed Readings</a><br>
						</c:when>
						
						<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_STAFF.value ||
										sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
							<a href="literature_add">Add A Literature</a><br>
							<a href="literatures">Delete A Literature</a><br>
									
							<c:choose>
								<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
									<a href="my_literaturelist">My Overriden Readings</a><br>
								</c:when>
							</c:choose>
							
						</c:when>
						
						<c:when test = "${sessionScope.user.userType == UserTypes.ADMINISTRATOR.value}">
						
							<a href="staff_list">View Current Library Staffs</a><br>
							<a href="manager_list">View Current Library Managers</a><br>
							<a href="admin_account_create">Create Higher Level Users</a>
						</c:when>
						
					</c:choose>
					
				</c:when>
				
				<c:when test="${sessionScope.user == null}">
					<a href="register">Register</a><br>
					<a href="login">Login</a><br>
				</c:when>	
			</c:choose>

			<a href="literatures">Check all literature available</a><br>
			<a href="meeting_room">Check all meeting rooms available</a><br>
		</h3>
		
	</center>
</body>
</html>