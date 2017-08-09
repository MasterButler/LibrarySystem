<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.Status" %>
<%@ page import="com.util.DateUtil" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Back to <a href="./">Homepage</a>
	<table style="border-style: double;">
		<tr>
			<td align="center"> Title </td>
			<td align="center"> Due On </td>
			<td align="center"> Status </td>
			<td> </td>
		</tr>
		<c:forEach items="${user.literatureList}" var="literature">
			<tr>
				<td>${literature.title}</td>
				<td>
					<fmt:formatDate value="${literature.status.dateBorrowEnd}" pattern="${DateUtil.NUMBER_FORMAT}"/>
					<br>
					<fmt:formatDate value="${literature.status.dateBorrowEnd}" pattern="${DateUtil.TIME_FORMAT}"/>
				</td>
				
					<c:choose>
						<c:when test="${literature.status.availability == Status.STATUS_OUT}">
							<td>Out</td>
							<td></td>
						</c:when>
					
						<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
							<td>Reserved</td>
							<td><a href = "borrow_literature?id=<c:out value="${literature.id}"/>">Borrow Book</a></td>
						</c:when>
					</c:choose>
				<td>

			</tr> 
		</c:forEach>
	</table>
</body>
</html>