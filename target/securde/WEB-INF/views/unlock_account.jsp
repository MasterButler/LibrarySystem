<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.util.DateUtil"%>
<%@ page import="com.util.AttributeDictionary"%>
<%@ page import="com.beans.user.UserTypes"%>

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
	<table>
		<tr>
			<td>Username</td>
			<td>Email</td>
			<td>User Type</td>
			
		</tr>
		<c:forEach items="${userlist_locked}" var="user" varStatus="loop">
			<tr>
				<td>${user.credentials.username}</td>
				<td>${user.email}</td>
				<td>
					<c:choose>
						<c:when test="${user.userType == UserTypes.FACULTY.value}">
							Faculty
						</c:when>
						<c:when test="${user.userType == UserTypes.STUDENT.value}">
							Student
						</c:when>
						<c:when test="${user.userType == UserTypes.LIBRARY_MANAGER.value}">
							Library Manager
						</c:when>
						<c:when test="${user.userType == UserTypes.LIBRARY_STAFF.value}">
							Library Staff
						</c:when>
						<c:when test="${user.userType == UserTypes.ADMINISTRATOR.value}">
							Administrator
						</c:when>
					</c:choose>
				</td>
				<td>
					<form action="unlock_specific_account" method="post">
						<input type="hidden" id="user-id" name="user-id" value="${user.id}"/>
						<input type="submit" value="Unlock"/>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>