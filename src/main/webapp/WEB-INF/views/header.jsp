<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.beans.user.UserTypes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
		
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<style>
		.after-header {
	     padding-top: 50px;
		}
		.lit-width{
		width: 30rem;
		}
	</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
	
	<nav class="navbar sticky-top navbar-toggleable-md navbar-light bg-faded">
	  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <a class="navbar-brand" href="/securde">DLSU Library System</a>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto navbar-left">
   			<li><a class="nav-link" href="literatures">Literatures</a></li>
	        <li><a class="nav-link" href="meeting_room_view">Rooms</a></li>
      	</ul>
	    <ul class="navbar-nav navbar-right my-lg-0 my-2">
	      <c:choose>
				<c:when test="${sessionScope.user == null}">
			      	<li class="nav-item"><a class="nav-link disabled" href="#">Hello, Guest!</a></li>
			      	<li class="nav-item"><a class="nav-link" href="register">Register</a></li>
        			<li class="nav-item"><a class="nav-link" href="login">Login</a></li>
				</c:when>
		  		
		  		<c:when test="${sessionScope.user != null}">
					<c:choose>				
						<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value ||
										sessionScope.user.userType == UserTypes.STUDENT.value}">
										
							<li class="nav-item"><a class="nav-link disabled" href="#">Hello, ${sessionScope.user.name.firstName}</a></li>
				            <li class="nav-item"><a class="nav-link" href="my_literaturelist">My Borrowed Books</a></li>
				            <li class="nav-item"><a class="nav-link" href="my_roomlist">My Reserved Rooms</a></li>
				            <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
						</c:when>
						
						<c:when test="${sessionScope.user.userType == UserTypes.ADMINISTRATOR.value}">
							<li class="nav-item"><a class="nav-link disabled" href="#">Hello, Admin ${sessionScope.user.name.firstName}</a></li>
							<li class="nav-item"><a class="nav-link" href="staff_list">Library Staffs</a></li>
							<li class="nav-item"><a class="nav-link" href="manager_list">Library Managers</a></li>
					        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
						</c:when>
						
						<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value ||
										sessionScope.user.userType == UserTypes.LIBRARY_STAFF.value}">
							<li class="nav-item"><a class="nav-link disabled" href="#">Hello, ${sessionScope.user.name.firstName}</a></li>
					        <li class="nav-item"><a class="nav-link" href="literature_add">Add a Book</a></li>
					        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
						</c:when>	
						
					</c:choose>
				</c:when>
			</c:choose>	
	    </ul>
	  </div>
	</nav>
</body>
</html>