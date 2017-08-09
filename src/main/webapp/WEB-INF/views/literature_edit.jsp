<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>

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
	  		<h1>Add a Literature</h1>
			<form:form method="POST" modelAttribute="literature" action="literature_edit">
				<div class="form-group row">
			      <label for="addlit-title" class="col-sm-5 col-form-label">Title</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="addlit-title" placeholder="Title" path="title"/>
			      </div>
			    </div>
			    
			    <h6>Authors</h6>
			    <c:forEach items="${literature.authors}" var="author" varStatus="loop">
				  	<div class="form-group row">
				      <label for="addlit-firstname" class="col-sm-5 col-form-label">Authors</label>
				      <div class="col-sm-10">
				        <form:input type="text" class="form-control form-control-sm" id="addlit-firstname" placeholder="First Name" path="authors[${loop.index}]"/>
				      	<form:input type="text" class="form-control form-control-sm" id="addlit-middlename" placeholder="Middle Name" path="authors[${loop.index}]"/>
				      	<form:input type="text" class="form-control form-control-sm" id="addlit-lastname" placeholder="Last Name" path="authors[${loop.index}]"/>
				      	<c:set var="authorNumber" value="${loop.index+1}"/>
				      </div>
				      <input type="submit" value="Delete Author ${loop.index}" name="action"/>
				    </div>
				    <c:choose>
				    	<c:when test="${loop.last}">
						    <div class="form-group row">
						      <input type="submit" value="Add Author" name="action"/>
						    </div>
						</c:when>
					</c:choose>
				</c:forEach>
				
				<div class="form-group row">
			      	<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.BOOK.value}" label="${LibraryObjectTypes.BOOK.name}"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.MAGAZINE.value}" label="${LibraryObjectTypes.MAGAZINE.name}"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.THESIS.value}" label="${LibraryObjectTypes.THESIS.name}"/>
			    </div>
			    <div class="form-group row">
			      <label for="addlit-date" class="col-sm-5 col-form-label">Date of Publication</label>
			      <div class="col-sm-10">
			      	<fmt:formatDate var="fmtDate" value="${literature.datePublished}" pattern="${DateUtil.NUMBER_FORMAT}"/>
			        <form:input type="text" class="form-control form-control-sm" id="addlit-date" placeholder="mm/dd/yyy" path="datePublished"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="addlit-publisher" class="col-sm-5 col-form-label">Publisher</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="addlit-publisher" placeholder="publisher" path="Publisher"/>
			      </div>
			    </div>
			    <div class="form-group row">
			    	<input type="submit" value="Save" name = "action"/>
			    </div>	
			</form:form>
		</div>
	</div>
	</div>	
</body>
</html>

