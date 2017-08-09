<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
<%@ page import="beans.Literature" %>
<%@ page import="beans.Status" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<style>
		.after-header {
	     padding-top: 100px;
		}
	</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>

	<%@include file="header.jsp" %>
	<div class="container after-header"></div>
	
	<div class="container after-header">
		<div class="row">
			<div class="col-xs-12">
				<button type="button" class="btn btn-primary" href="literatures">
				<span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
				Back to Literature List</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<div class="card">
				  <h3 class="card-header">${literature.title}
				  	<c:choose>
						<c:when test="${literature.status.availability == Status.STATUS_OUT}">
							<span class="badge badge-default">Unavailable</span>
						</c:when>
						
						<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
							<span class="badge badge-danger">Reserved</span>
						</c:when>
					
						<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
							<span class="badge badge-success">Available</span>
						</c:when>
					</c:choose></h3>
				  <div class="card-block">
				    <h4 class="card-title">
					    <c:forEach items="${literature.authors}" var="author" varStatus="loop">
						${author.firstName} ${author.middleName} ${author.lastName}
						<c:choose>
							<c:when test="${!loop.last}">
							  , 
							</c:when>
						</c:choose>
		    		</c:forEach></h4>
		    		
				    <p class="card-text">
					    <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
					    <fmt:formatDate pattern = "${DateUtil.DATE_FORMAT}" value = "${literature.datePublished}" />
				    </p>
				    <p class="card-text">
					    <span class="glyphicon glyphicon-print" aria-hidden="true"></span>
					    ${literature.publisher}
				    </p>
				    
				    <p>
				    <c:choose>
						<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
							<div class="alert alert-success" role="alert">
  								<strong>It's available!</strong>
  								<c:choose>
									<c:when test="${sessionScope.user == null}">
										Please <a href="login" class="alert-link">Log-in</a> to reserve this book.
									</c:when>
									
									<c:otherwise>
										<c:choose>
											<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value || 
											 				sessionScope.user.userType == UserTypes.STUDENT.value}">
											 	Proceed to
												<a href = "reservation?id=<c:out value="${literature.id}"/> class="alert-link">
												Reservation Page</a>
											</c:when>
										</c:choose>
									</c:otherwise>
								</c:choose>
 							</div>	
						</c:when>
					
						<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
							<div class="alert alert-warning" role="alert">
  								<strong>Too bad, it's reserved already.</strong>
  								It will be available again after 
  								<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
  							</div>  
  														
 							<c:choose>
								<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
									<h5>Are you a manager? However, you can override this. </h5>
									<button type="button" class="btn btn-primary" 
									href = "reservation_override/confirmation?id=<c:out value="${literature.id}"/>">
									Click here!</button>
								</c:when>
							</c:choose>							
						</c:when>
						
						<c:when test="${literature.status.availability == Status.STATUS_OUT}">
							<div class="alert alert-warning" role="alert">
  								<strong>Someone already borrowed it!</strong>
  								It will be available again after 
  								<fmt:formatDate pattern = "${DateUtil.DATETIME_FORMAT}" value = "${literature.status.dateBorrowEnd}" />
  							</div>  
							
						</c:when>
					</c:choose>
					</p>
				  </div>
				</div>
			</div>
		</div>	
</body>
</html>

