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
				<h1>Literatures</h1>
				<div class="form-group row">
					<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
						<div class="btn-group" role="group" aria-label="First group">
						    <button type="submit" class="btn btn-secondary btn-info" name="action">All</button>
						    <button type="submit" class="btn btn-secondary btn-info" name="action">Books</button>
						    <button type="submit" class="btn btn-secondary btn-info" name="action">Thesis</button>
						    <button type="submit" class="btn btn-secondary btn-info" name="action">Magazine</button>
						</div>
					</div>	 
					<form method="POST" action="literatures">
					    <div class="input-group mb-2 mr-sm-2 mb-sm-0"">
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
		</div>
	</div>

	<div class="container">
		<div class="row">
				<div class="col-xs-12">
					<c:forEach items="${literaturelist}" var="literature">  
						<c:set var="id" value="${literature.id}"/>
		
						<div class="card lit-width">
							<div class="card-block">
								<h4 class="card-title"><a href = "literature_info?id=<c:out value="${id}"/>">${literature.title}</a></h4>
								<h6><c:choose>
									<c:when test="${literature.status.availability == Status.STATUS_OUT}">
										<span class="badge badge-default">Unavailable</span>
									</c:when>
									
									<c:when test="${literature.status.availability == Status.STATUS_RESERVED}">
										<span class="badge badge-danger">Reserved</span>
									</c:when>
								
									<c:when test="${literature.status.availability == Status.STATUS_AVAILABLE}">
										<span class="badge badge-success">Available</span>
									</c:when>
								</c:choose></h6>
								
								<h6 class="card-subtitle mb-2 text-muted">
									<c:forEach items="${literature.authors}" var="author" varStatus="loop">
										${author.firstName} ${author.middleName} ${author.lastName}<c:if test="${!loop.last}">, </c:if>
	    							</c:forEach>	
								</h5>
				
								<h6 class="card-subtitle mb-2 text-muted">
									<c:choose>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.BOOK.value }">
											${LibraryObjectTypes.BOOK.name}
										</c:when>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.THESIS.value }">
											${LibraryObjectTypes.THESIS.name}
										</c:when>
										<c:when test = "${literature.libraryObjectType == LibraryObjectTypes.MAGAZINE.value }">
											${LibraryObjectTypes.MAGAZINE.name}	
										</c:when>
									</c:choose>	
								</h6>
								
								<h6 class="card-subtitle mb-2 text-muted">
									<fmt:formatDate pattern = "${DateUtil.DATE_FORMAT}" value = "${literature.datePublished}" />
								</h6>

								<c:choose>
									<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_STAFF.value ||
													sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value}">
										<a href="literature_delete?id=<c:out value="${id}"/>" class="card-link" role="button">
										Delete</a>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${sessionScope.user.userType > UserTypes.FACULTY.value}">
										<a href="literature_edit?id=<c:out value="${id}"/>" class="card-link" role="button">
										Edit Book Information</a>
									</c:when>
								</c:choose>
							</div>
						</div>	
					</c:forEach>
				</div>
			</div>
</body>
</html>