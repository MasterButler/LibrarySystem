<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="util.DateUtil" %>
<%@ page import="manager.MeetingRoomManager" %>

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
			<td align="center">Time Start</td>
			<td align="center">Time End</td>
			<td align="center"></td>
		</tr>
		
		<c:forEach items="${user.reservationList}" var="reservation" varStatus="loop">
			<c:set var="index" value="${loop.index}"/>

			<c:choose>
				<c:when test="${fn:length(reservation) != 0}">
					<tr>
						<td colspan="2" align="center"><c:out value="${MeetingRoomManager.ROOM_NAME[index]}"/></td>
					<tr>	
					
					<c:forEach items="${reservation}" var="status" varStatus="inner">
						<tr>
							<td>
								<fmt:formatDate value="${status.dateBorrowStart}" pattern="${DateUtil.NUMBER_FORMAT}"/>
								<br>
								<fmt:formatDate value="${status.dateBorrowStart}" pattern="${DateUtil.TIME_FORMAT}"/>
							</td>
							<td>
								<fmt:formatDate value="${status.dateBorrowEnd}" pattern="${DateUtil.NUMBER_FORMAT}"/>
								<br>
								<fmt:formatDate value="${status.dateBorrowEnd}" pattern="${DateUtil.TIME_FORMAT}"/>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</table>
	End of List <br>
</body>
</html>