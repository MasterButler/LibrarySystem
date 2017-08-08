<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="util.DateUtil" %>   
<%@ page import="util.AttributeDictionary" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${meeting_room_reservation_bool}">
			${room} has been successfully reserved under the id number ${user.id}.
			
			Your reservation will last from
			<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${time_start}" />
			to 
			<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${time_end}" />
			.			
		</c:when>
		<c:otherwise>
			
		</c:otherwise>
	</c:choose>	
	<a href="meeting_room">Return to room list</a>
</body>
</html>