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
					${sessionScope.user.name.firstName}
				</c:when>
				<c:when test="${sessionScope.user == null}">
					Anonymous User
				</c:when>	
			</c:choose>
		
		</h2>
		<h3>
			<a href="register">Register</a>
			<a href="hello?name=Eric">Click Here</a>
			<a href="literatures">Check all literature available</a>
		</h3>
	</center>
</body>
</html>