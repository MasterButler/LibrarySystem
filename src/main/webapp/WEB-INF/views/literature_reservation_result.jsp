<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="util.DateUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<c:choose>
		<c:when test="${literature_reservation_bool}">
			${literature.title} has been successfully reserved.
			
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