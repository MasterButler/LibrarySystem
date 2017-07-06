<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="beans.user.UserTypes" %>
<%@ page import="util.DateUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table style="width:100%">
  		<tr>
    		<td>Title</td>
    		<td>${literature.title}</td>
  		</tr>
  		<tr>
    		<td>Author</td>
    		<td><c:forEach items="${literature.authors}" var="author" varStatus="loop">
					${author.firstName} ${author.middleName} ${author.lastName}
					<c:choose>
						<c:when test="${!loop.last}">
						  , 
						</c:when>
						<c:otherwise>
					  	  
						</c:otherwise>
					</c:choose>
	    		</c:forEach></td>
  		</tr>
  		<tr>
    		<td>Date of Publication</td>
    		<td><fmt:formatDate pattern = "${DateUtil.DATE_FORMAT}" value = "${literature.datePublished}" /></td>
  		</tr>
  		<tr>
    		<td>Publisher</td>
    		<td>${literature.publisher}</td>
  		</tr>
	</table>
	
	<c:choose>
		<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
			This ${litearture.type} is currently available.
			<c:choose>
				<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value || 
				 				sessionScope.user.userType == UserTypes.STUDENT.value}">
					<a href = "reservation?id=<c:out value="${literature.id}"/>">Proceed to Reservation Page</a>
				</c:when>
			</c:choose>
		</c:when>
	
		<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
		
			This ${litearture.type} has already been reserved by someone else. Available again 
			after <fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
	
			<c:choose>
				<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
					However, you can override this. 
					<a href = "reservation_override/confirmation?id=<c:out value="${literature.id}"/>">Click here</a>
				</c:when>
			</c:choose>
			
		</c:when>
		
		<c:when test="${literature.status.availability == Status.STATUS_OUT}">
		
			This ${litearture.type} has already been borrowed by someone else. Available again
			after <fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
			
		</c:when>
	</c:choose>
	
</body>
</html>

