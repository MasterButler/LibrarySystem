<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.util.DateUtil"%>
<%@ page import="com.util.AttributeDictionary"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${literature_reservation_bool}">
			${literature.title} has been successfully reserved under the id number ${user.id}.
			
			Your reservation will last from
			<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowStart}" />
			to 
			<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
			.
			
		</c:when>
		<c:otherwise>
			${literature.title} has already been borrowed by someone else. Please check back after
			<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
		</c:otherwise>
	</c:choose>
	

	<a href="../literatures">Return to literature list</a>
</body>
</html>