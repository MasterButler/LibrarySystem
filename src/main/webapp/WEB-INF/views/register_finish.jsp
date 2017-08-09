<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.user.UserTypes" %>
<%@ page import="com.util.DateUtil" %> 

<!DOCTYPE html>
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
	<a href="./">Return to Homepage</a>
</body>
</html>