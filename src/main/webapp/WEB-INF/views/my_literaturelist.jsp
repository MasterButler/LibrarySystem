<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="util.DateUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Start of list <br>
	<table>
		<tr>
			<td> Title
			<td> Due On
			<td> Status
			<td> 
		</tr>
		<c:forEach items="${user.literatureList}" var="literature">
			<tr>
				<td>${literature.title}
				<td>${literature.status.dateBorrowEnd}
				
					<c:choose>
						<c:when test="${literature.status.availability == Status.STATUS_OUT}">
							<td>Out
							<td>
						</c:when>
					
						<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
							<td>Reserved
							<td><a href = "borrow_literature">Borrow Book</a>
						</c:when>
					</c:choose>
				<td>

			</tr> 
		</c:forEach>
	</table>
	End of List <br>
</body>
</html>