<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				<div class="jumbotron">
				  <h1 class="display-2">Welcome to the Library!</h1>
				  <p class="lead">Use your account to monitor your borrowed books and reserved rooms.</p>
				  <c:choose>
					<c:when test="${sessionScope.user == null}">
						<hr class="my-4">
				      	<h6>Don't have an account yet?</h6>
				  		<p class="lead"><a class="btn btn-primary btn-lg" href="register" role="button">
				  		Register here!</span></a></p>
					</c:when>	  
				 </c:choose>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-2"></div>
				<c:choose>
					<c:when test="${sessionScope.user.userType == UserTypes.FACULTY.value ||
									sessionScope.user.userType == UserTypes.STUDENT.value ||
									sessionScope.user == null}">
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Borrow Literature</h3>
							    <p class="card-text">Get access to numerous journals and books available in the library.</p>
							    <a href="literatures" class="btn btn-success">
							    	View All Literatures</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Reserve Rooms</h3>
							    <p class="card-text">Hold a group study, meeting or project-making session in one of our library's rooms. </p>
							    <a href="meeting_room_view" class="btn btn-success">
							    	View All Meeting Rooms</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-2"></div>
					</c:when>
					
					<c:when test="${sessionScope.user.userType == UserTypes.LIBRARY_MANAGER.value ||
									sessionScope.user.userType == UserTypes.LIBRARY_STAFF.value ||
									sessionScope.user == null}">
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Literatures</h3>
							    <p class="card-text">Get access to numerous journals and books available in the library.</p>
							    <a href="literatures" class="btn btn-success">
							    	View All Literatures</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Meeting Rooms</h3>
							    <p class="card-text">Hold a group study, meeting or project-making session in one of our library's rooms. </p>
							    <a href="meeting_room_view" class="btn btn-success">
							    	View All Meeting Rooms</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-2"></div>
					</c:when>
						
					<c:when test="${sessionScope.user.userType == UserTypes.ADMINISTRATOR.value}">
						<hr />
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Borrow Literatures</h3>
							    <p class="card-text">Get access to numerous journals and books available in the library.</p>
							    <a href="literatures" class="btn btn-success">
							    	View All Literatures</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-4">
							<div class="card" style="width: 30rem;">
							  <div class="card-block">
							    <h3 class="card-title">Reserve Rooms</h3>
							    <p class="card-text">Hold a group study, meeting or project-making session in one of our library's rooms. </p>
							    <a href="meeting_room_view" class="btn btn-success">
							    	View All Meeting Rooms</a>
							  </div>
							</div>
						</div>
						<div class="col-xs-2"></div>
						
						<div class="row">
							<div class="col-xs-4">
								<div class="card" style="width: 20rem;">
								  <div class="card-block">
								    <h3 class="card-title">High-level Accounts</h3>
								    <p>Have an overview of all the existing high-level accounts in the system.</p>
								    <a href="staff_list" class="btn btn-success">
								    	View All High-level Accounts</a>
								  </div>
								</div>
							</div>
							<div class="col-xs-4">
								<div class="card" style="width: 20rem;">
								  <div class="card-block">
								    <h3 class="card-title">Add New Library Account</h3>
								    <p>Give someone an authority to access the library.</p>
								    <a href="admin_account_create" class="btn btn-success">
								    	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								    	Create an Account</a>
								  </div>
								</div>
							</div>
							<div class="col-xs-4">
								<div class="card" style="width: 20rem;">
								  <div class="card-block">
								    <h3 class="card-title">Unlock Account</h3>
								    <p>Be able to unlock accounts to enable their respective users to access them.</p>
								    <a href="#" class="btn btn-success disabled">
								    	<span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
								    	Unlock</a>
								  </div>
								</div>
							</div>
							<div class="col-xs-2"></div>	
					</c:when>
				</c:choose>
		</div>
	</div>

</body>
</html>