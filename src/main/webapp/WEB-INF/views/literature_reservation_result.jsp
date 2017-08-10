<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.util.DateUtil"%>
<%@ page import="com.util.AttributeDictionary"%>

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
				<div class="card">
				  <div class="card-block">
					 <c:choose>
						<c:when test="${literature_reservation_bool}">
							<h4 class="card-title">${literature.title} has been successfully reserved under the id number ${user.id}.</h4>
							
							<h6 class="card-subtitle mb-2 text-muted">
							Your reservation will last from
							<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowStart}" />
							to 
							<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
							.</h6>
						</c:when>
						<c:otherwise>
							<h4 class="card-title"></h4>
							${literature.title} has already been borrowed by someone else. Please check back after
							<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" /></h4>
						</c:otherwise>
					</c:choose>
				  </div>
				</div>
			</div>		
		</div>
		<div class="row">
			<div class="col-xs-12">
				<a class="btn btn-primary btn-sm" href="literatures" role="button">
				Back to Literature List</a>
			</div>
		</div>
	</div>
</body>
</html>