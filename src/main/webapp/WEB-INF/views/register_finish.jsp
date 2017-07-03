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
<title>Insert title here</title>
</head>
<body>
	Birthday: ${user.birthday} <br>
	<table style="width:100%">
  		<tr>
    		<td>Name</td>
    		<td>${user.name.firstName} ${user.name.middleName} ${user.name.lastName}</td>
  		</tr>
  		<tr>
    		<td>Birthday</td>
    		<td><fmt:formatDate pattern = "${DateUtil.PROPER_DATE_FORMAT}" value = "${user.birthday}" /></td>
  		</tr>
	</table>
	${user.id}
	<a href="index?id=<c:out value="${user.id}"/>">Return to Homepage</a>
</body>
</html>