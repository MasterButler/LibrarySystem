<%@page import="date.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${literature_reservation_bool}">
			${literature.title} has been successfully reserved from
			
			<fmt:formatDate pattern = "MMMM dd, yyyy" value = "${literature.status.dateBorrowStart}" />
			to 
			<fmt:formatDate pattern = "MMMM dd, yyyy" value = "${literature.status.dateBorrowEnd}" />
			
		</c:when>
		<c:otherwise>
			${literature.title} has already been reserved by other people. Please check back after
			<fmt:formatDate pattern = "MMMM dd, yyyy" value = "${literature.status.dateBorrowEnd}" />
		</c:otherwise>
	</c:choose>
	

	<a href="../literatures">Return to literature list</a>
</body>
</html>