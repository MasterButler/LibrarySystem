<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
<%@ page import="beans.Literature" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Back to <a href="./">Homepage</a>

	<h3>Staff List</h3>
	<table>
		<tr>
			<td>ID</td>
			<td>Username</td>
			<td>Name</td>
			<td>Email</td>
		</tr>
		
		<c:forEach items="${stafflist}" var="staff">  
			
			<tr>
				<td>${staff.id}</td>
				<td>${staff.credentials.username}</td>
				<td>${staff.name.firstName} ${staff.name.middleName} ${staff.name.lastName}</td>
				<td>${staff.email}</td>
			</tr>
			
		</c:forEach>	
	</table>
	
	
</body>
</html>