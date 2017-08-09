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
	
	<style>
		.navbar {
	    -webkit-border-radius: 0;
	    -moz-border-radius: 0;
	    border-radius: 0;
		}
		
		.after-header {
	     padding-top: 40px;
		}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
</head>
<body>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	
	<nav class="navbar navbar-default navbar-inverse navbar-fixed-top">
	  <div class="container">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">DLSU Library System</a>
	    </div>
	    
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      		<ul class="nav navbar-nav navbar-left">
      			<li><a href="literatures">Books</a></li>
		        <li><a href="meeting_room_view">Rooms</a></li>
      		</ul>
      		
      		<ul class="nav navbar-nav navbar-right">
			<c:choose>
				<c:when test="${sessionScope.user == null}">
			      	<li><a href="#">Hello, Guest!</a></li>
			      	<li><a href="register">Register</a></li>
        			<li><a href="login">Login</a></li>
				</c:when>
				
				<c:otherwise>
					<c:choose>				
						<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value ||
										sessionScope.user.userType == UserTypes.STUDENT.value}">
										
							<li><a href="#">Hello, ${sessionScope.user.name.firstName}</a></li>
				            <li><a href="my_literaturelist">My Borrowed Books</a></li>
				            <li><a href="my_roomlist">My Reserved Rooms</a></li>
				            <li><a href="logout">Logout</a></li>
						</c:when>
						
						<c:when test="${sessionScope.user.userType == UserTypes.ADMINISTRATOR.value}">
							<li><a href="staff_list">Library Staffs</a></li>
							<li><a href="manager_list">Library Managers</a></li>
							<li><a href="admin_account_create">Create Higher Level Users</a></li>
							
							<li><a href="#">Hello, Admin ${sessionScope.user.name.firstName}</a></li>
					        <li><a href="logout">Logout</a></li>
						</c:when>	
					</c:choose>
				</c:otherwise>
			</c:choose>			
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container -->
	</nav>
</body>
</html>