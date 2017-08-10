<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.user.UserTypes" %>
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
	<div class="container after-header"></div>
	
	<div class="container after-header">
	  <div class="row">
	  	<div class="col-xs-2"></div>
	  	<div class="col-xs-8">
	  		<h1>Login</h1>
	  		<form:form method="POST" action="login" modelAttribute="credentials">
			    <div class="form-group row">
			      <label for="login-username" class="col-sm-5 col-form-label">Username</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control" id="login-username" placeholder="Username" path="username"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="login-password" class="col-sm-5 col-form-label">Password</label>
			      <div class="col-sm-10">
			        <form:input type="password" class="form-control" id="login-password" placeholder="Password" path="password"/>
			      </div>
			    </div>
			    <div class="form-group row">
			    	<c:choose>
						<c:when test="${not empty loginErrorMessage}">
							<div class="alert alert-danger alert-sm" role="alert">
							  <strong>Oh snap!</strong> ${loginErrorMessage}!
							</div>
						</c:when>
					</c:choose>
			    </div>
			    <div class="form-group row col-sm-10">
			    	<input type="submit" class="btn btn-info" value="Submit" class="btn btn-success">
			    </div>
			    <div class="form-group row col-sm-10">
			    	<br><p>Don't have an account yet?</p>
			    	<a href="register" class="btn btn-success">Sign Up</a>
			    </div>
			</form:form>
	  	</div>
	  	<div class="col-xs-2"></div>
	  </div> 
	</div>
		
</body>
</html>