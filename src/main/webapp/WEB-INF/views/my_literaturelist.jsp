<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.Status" %>
<%@ page import="com.util.DateUtil" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>

	<%@include file="header.jsp" %>
	
	<div class="container after-header">
		<div class="row">
				<div class="col-xs-12">
					<c:forEach items="${literaturelist}" var="literature">  
		
						<div class="card lit-width">
							<div class="card-block">
								<h4 class="card-title">${literature.title}</h4>
								<h6><c:choose>
									<c:when test="${literature.status.availability == Status.STATUS_OUT}">
										<span class="badge badge-default">Unavailable</span>
									</c:when>
									
									<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
										<span class="badge badge-danger">Reserved</span>
										<a href = "borrow_literature?id=<c:out value="${literature.id}"/>"
										   class="btn btn-success btn-sm" role="button">Borrow Book</a>
									</c:when>
								</c:choose></h6>
								
								<h6 class="card-subtitle mb-2 text-muted">
									<fmt:formatDate value="${literature.status.dateBorrowEnd}" pattern="${DateUtil.NUMBER_FORMAT}"/>
									<br>
									<fmt:formatDate value="${literature.status.dateBorrowEnd}" pattern="${DateUtil.TIME_FORMAT}"/>
								</h6>

							</div>
						</div>	
					</c:forEach>
				</div>
			</div>
	</div>
</body>
</html>