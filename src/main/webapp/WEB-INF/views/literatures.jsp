<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="util.DateUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spring 4 MVC -HelloWorld</title>
</head>
<body>
	<c:forEach items="${literaturelist}" var="literature">  
	
		<c:set var="id" value="${literature.id}"/>
	
		<h2><a href = "literature_info?id=<c:out value="${id}"/>">${literature.title}</a></h2>
		
		<br>
		
		<c:forEach items="${literature.authors}" var="author" varStatus="loop">
			${author.firstName} ${author.middleName} ${author.lastName}<c:if test="${!loop.last}">, </c:if>
	    </c:forEach>
		
		<p>${literature.type}</p>
		
		<p><fmt:formatDate pattern = "${DateUtil.DATE_FORMAT }" value = "${literature.datePublished}" /></p>
		
		<!--  Hi dar, suggestion pala ni rofi na paran gagawin natin sa isang row nito, mayroon ding 
		nasa dulo nya na color indication kung unavailable, reserved, or available. thanksies :3 -->
		<c:choose>
		
			<c:when test="${literature.status.availability == Status.STATUS_OUT}">
				<!-- 
				<button class = "button_borrow_literature">UNAVAILABLE</button>				
				-->
				UNAVAILABLE
			</c:when>
			
			<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
				<!-- 
				<button class = "button_borrow_literature">RESERVED</button>
				-->
				RESERVED
			</c:when>
			
			<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
				<!--
				<a href="reservation?id=<c:out value="${id}"/>">
					<button class = "button_borrow_literature">AVAILABLE</button>	
				</a>			
				-->
				AVAILABLE
			</c:when>
			
		</c:choose>
		
		<p> Status: ${literature.status.availability}
	</c:forEach>
		
</body>
</html>