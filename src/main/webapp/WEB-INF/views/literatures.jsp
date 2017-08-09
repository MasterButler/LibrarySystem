<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
<%@ page import="beans.Literature" %>
<%@ page import="beans.Status" %>

<!DOCTYPE html>
<html>
<head>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
	
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Spring 4 MVC -HelloWorld</title>
	
	<style>
		.after-header {
	     padding-top: 120px;
		}
	</style>
</head>
<body>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<%@include file="header.jsp" %>
	<div class="container after-header"></div>
	
	<div class="container">
		<div class="row">
			<div class="col-xs-2"></div>
			<div class="col-xs-8">
				<h1>Literatures</h1>
				<div class="form-group row">
					<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
						<div class="btn-group" role="group" aria-label="First group">
						    <button type="submit" class="btn btn-secondary" name="action">All</button>
						    <button type="submit" class="btn btn-secondary" name="action">Books</button>
						    <button type="submit" class="btn btn-secondary" name="action">Thesis</button>
						    <button type="submit" class="btn btn-secondary" name="action">Magazine</button>
						</div>
					</div>	 
					<form method="POST" action="literatures">
					    <div class="input-group">
						    <input type="text" class="form-control" placeholder="Search for...">
						    <span class="input-group-btn">
						    	<input class="btn btn-default" type="submit" value="Search"/>
						    </span>
						</div>
					</form>
				</div>
				<div class="form-group">
					<form method="POST" action="literatures">
						<div class="form-check form-check-inline">
						  <label class="form-check-label">
						    <input class="form-check-input" type="radio" name="inlineRadioOptions"
						    id="radio-all" value="${Literature.FIELD_ALL}">
						    All Fields               
						  </label>
						  <label class="form-check-label">
						    <input class="form-check-input" type="radio" name="inlineRadioOptions"
						    id="radio-title" value="${Literature.FIELD_TITLE}"> 
						    Title                 
						  </label>
						  <label class="form-check-label">
						    <input class="form-check-input" type="radio" name="inlineRadioOptions" 
						    id="radio-author" value="${Literature.FIELD_AUTHOR}"> 
						    Author               
						  </label>
						  <label class="form-check-label">
						    <input class="form-check-input" type="radio" name="inlineRadioOptions"
						    id="radio-publisher" value="${Literature.FIELD_PUBLISHER}"> 
						    Publisher             
						  </label>
						</div>
					</form>
				</div>
			</div>
			<div class="col-xs-2"></div>
		</div>
	</div>

	<div class="container">
		<div class="row">
				<div class="col-xs-2"></div>
				<div class="col-xs-8">
					<c:forEach items="${literaturelist}" var="literature">  
						<c:set var="id" value="${literature.id}"/>
		
						<div class="card">
							<div class="card-block">
								<h4 class="card-title"><a href = "literature_info?id=<c:out value="${id}"/>">${literature.title}</a></h4>
								<h5><c:choose>
									<c:when test="${literature.status.availability == Status.STATUS_OUT}">
										<span class="badge badge-default">Unavailable</span>
									</c:when>
									
									<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
										<span class="badge badge-danger">Reserved</span>
									</c:when>
								
									<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
										<span class="badge badge-success">Available</span>
									</c:when>
								</c:choose></h5>
								
								<h5 class="card-subtitle mb-2 text-muted">
									<span class="glyphicon glyphicon-user" aria-hidden="true">
									<c:forEach items="${literature.authors}" var="author" varStatus="loop">
										${author.firstName} ${author.middleName} ${author.lastName}<c:if test="${!loop.last}">, </c:if>
	    							</c:forEach>	
								</h5>
				
								<h5 class="card-subtitle mb-2 text-muted">
									<c:choose>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.BOOK.value }">
											<span class="glyphicon glyphicon-book" aria-hidden="true">
											${LibraryObjectTypes.BOOK.name}
										</c:when>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.THESIS.value }">
											<span class="glyphicon glyphicon-duplicate" aria-hidden="true">
											${LibraryObjectTypes.THESIS.name}
										</c:when>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.MAGAZINE.value }">
											<span class="glyphicon glyphicon-tree-deciduous" aria-hidden="true">
											${LibraryObjectTypes.MAGAZINE.name}	
										</c:when>
									</c:choose>	
								</h5>
								
								<h5 class="card-subtitle mb-2 text-muted">
									<span class="glyphicon glyphicon-calendar" aria-hidden="true">
									<fmt:formatDate pattern = "${DateUtil.DATE_FORMAT }" value = "${literature.datePublished}" />
								</h5>

								<c:choose>
									<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_STAFF.value ||
													sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
										<a href="literature_delete?id=<c:out value="${id}"/>" class="card-link">
										<span class="glyphicon glyphicon-trash" aria-hidden="true">
										Delete</a>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${sessionScope.user.userType > UserTypes.FACULTY.value}">
										<a href="literature_edit?id=<c:out value="${id}"/>" class="card-link">
										<span class="glyphicon glyphicon-trash" aria-hidden="true">
										Edit Book Information</a>
									</c:when>
								</c:choose>
							</div>
						</div>
			<hr />				
	</c:forEach>
		
</body>
</html>