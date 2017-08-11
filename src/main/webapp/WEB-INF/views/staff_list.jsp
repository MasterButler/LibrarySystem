<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.user.UserTypes" %>
<%@ page import="com.beans.LibraryObjectTypes" %>
<%@ page import="com.util.DateUtil" %>    
<%@ page import="com.beans.Literature" %>

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
	<div class="container after-header"></div>

	<div class="container">
		<div class="row">
				<div class="col-xs-12">
				<h1>Staff List</h1>
				
				<table class="table table-striped table-bordered table-sm">
				  <thead class="thead-inverse">
				    <tr>
				      <th>ID Number</th>
				      <th>First Name</th>
				      <th>Middle Name</th>
				      <th>Last Name</th>
				      <th>Username</th>
				      <th>Email</th>
				      <th>Status</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach items="${stafflist}" var="staff">
					    <tr>
					      <th scope="row">${staff.id}</th>
					      <td>${staff.name.firstName}</td>
					      <td>${staff.name.middleName}</td>
					      <td>${staff.name.lastName}</td>
					      <td>${staff.credentials.username}</td>
					      <td>${staff.email}</td>
					      <td>
					      	<c:choose>
					      		<c:when test="${staff.hasTempPassword} == true">
					      			Permanent
					      		</c:when>
					      		<c:otherwise>
					      			Temporary
					      		</c:otherwise>
					      	</c:choose>
					      </td>
					    </tr>
				    </c:forEach>
				  </tbody>
				</table>
				
			</div>
		</div>
	</div>
</body>
</html>