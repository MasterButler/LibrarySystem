<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="util.DateUtil" %>    
<%@ page import="beans.Literature" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spring 4 MVC -HelloWorld</title>
</head>
<body>
	
	<form method="POST" action="literatures">
		<table>
			<tr>
				<td><label for="searchString">Search</label></td>
           		<td><input type= "text" name="searchString"/></td>
           		<td><input type="submit" value="Submit"/></td>
			</tr>
			<tr>
				<td><input type = "radio" name="field" value="${Literature.FIELD_ALL}" checked="checked" />All Fields</td>
				<td><input type = "radio" name="field" value="${Literature.FIELD_TITLE}"/>Title</td>
				<td><input type = "radio" name="field" value="${Literature.FIELD_AUTHOR}"/>Author</td>
				<td><input type = "radio" name="field" value="${Literature.FIELD_PUBLISHER}"/>Publisher</td>
			</tr>
			
		</table>
	</form>


	<c:forEach items="${literaturelist}" var="literature">  
	
		<c:set var="id" value="${literature.id}"/>
	
		<h2><a href = "literature_info?id=<c:out value="${id}"/>">${literature.title}</a></h2>
		
		<br>
		
		<c:forEach items="${literature.authors}" var="author" varStatus="loop">
			${author.firstName} ${author.middleName} ${author.lastName}<c:if test="${!loop.last}">, </c:if>
	    </c:forEach>
		
		<p>${literature.type}</p>
		
		<p><fmt:formatDate pattern = "${DateUtil.DATE_FORMAT }" value = "${literature.datePublished}" /></p>
		
		UserType: ${user.userType}
		UserType GRANT: GREATER THAN ${UserTypes.FACULTY.value} 
		<c:choose>
			<c:when test="${user.userType > UserTypes.FACULTY.value}">
				<a href="edit?id=<c:out value="${id}"/>">Edit Book Information</a>
				
			</c:when>
		</c:choose>
		
		<!--  Hi dar, suggestion pala ni rofi na paran gagawin natin sa isang row nito, mayroon ding 
		nasa dulo nya na color indication kung unavailable, reserved, or available. thanksies :3 -->

<!-- 
		<c:choose>
		
			<c:when test="${literature.status.availability == Status.STATUS_OUT}">
				UNAVAILABLE
			</c:when>
			
			<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
				RESERVED
			</c:when>
			
			<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
				AVAILABLE
			</c:when>
			
		</c:choose>
 -->
		
	</c:forEach>
		
</body>
</html>