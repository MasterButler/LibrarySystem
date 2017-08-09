<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<style>
		.after-header {
	     padding-top: 40px;
		}
	</style>
	
</head>
<body>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<%@include file="header.jsp" %>
	
	<div class="container after-header">
		<div class="row">
			<div class="jumbotron">
			  <h1>Welcome to the Library!</h1>
			  <p>Use your account to monitor your borrowed books and reserved rooms.</p>
			  <h5>Don't have an account yet?</h5>
			  <p><a class="btn btn-primary btn-lg" href="register" role="button">
			  		Register here!
			  		<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a></p>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-2"></div>
			<div class="col-xs-4">
				<div class="card" style="width: 20rem;">
				  <div class="card-block">
				    <h3 class="card-title">Borrow Literature</h3>
				    <p class="card-text">Get access to numerous journals and books available in the library.</p>
				    <a href="literatures" class="btn btn-success">
				    	<span class="glyphicon glyphicon-book" aria-hidden="true"></span>
				    	View All Literatures</a>
				  </div>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="card" style="width: 20rem;">
				  <div class="card-block">
				    <h3 class="card-title">Reserve Rooms</h3>
				    <p class="card-text">Hold a group study, meeting or project-making session in one of our library's rooms. </p>
				    <a href="meeting_room_view" class="btn btn-success">
				    	<span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span>
				    	View All Meeting Rooms</a>
				  </div>
				</div>
			</div>
			<div class="col-xs-2"></div>
		</div>
	</div>

</body>
</html>