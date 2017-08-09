<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
    
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	
	<style>
		.after-header {
	     padding-top: 100px;
		}
	</style>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="container after-header"></div>
	
	<div class="container after-header">
	  <div class="row">
	  	<div class="col-xs-2"></div>
	  	<div class="col-xs-8">
	  		<h1>Create an Administrator Account</h1>
	  
			<form:form method="POST" action="admin_account_create" modelAttribute="user">
				<h3>Basic Information</h3>
				<div class="form-group row">
			      <label for="create-firstname" class="col-sm-5 col-form-label">First Name</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-firstname" placeholder="Marnel" path="name.firstName"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="create-middlename" class="col-sm-5 col-form-label">Middle Name</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-middlename" placeholder="S." path="name.middleName"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="create-lastname" class="col-sm-5 col-form-label">Last Name</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-lastname" placeholder="Peradilla" path="name.lastName"/>
			      </div>
			    </div>
				<hr />
				<div class="form-group row">
			      <label for="create-bday" class="col-sm-5 col-form-label">Birthday</label>
			      <fmt:formatDate var="fmtDate" value="${user.birthday}" pattern="dd/MM/yyyy"/>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-bday" placeholder="dd/mm/yyyy" path="birthday"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="create-idnum" class="col-sm-5 col-form-label">ID Number</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-idnum" placeholder="ID Number" path="id"/>
			      </div>
			    </div>
			    <hr />
			    <h3>Credentials</h3>
			    <div class="form-group row">
			      <label for="create-username" class="col-sm-5 col-form-label">Username</label>
			      <div class="col-sm-10">
			        <form:input type="text" class="form-control form-control-sm" id="create-username" placeholder="Username" path="credentials.username"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="create-email" class="col-sm-5 col-form-label">Email</label>
			      <div class="col-sm-10">
			        <form:input type="email" class="form-control form-control-sm" id="create-email" placeholder="Email" path="email"/>
			      </div>
			    </div>
			    <div class="form-group row">
			      <label for="create-password" class="col-sm-5 col-form-label">Password</label>
			      <div class="col-sm-10">
			        <form:input type="password" class="form-control form-control-sm" id="create-password" placeholder="" path="credentials.password"/>
			      </div>
			    </div>
			    <hr />
			    <div class="form-group row">
			    	<c:choose>
						<c:when test="${not empty loginErrorMessage}">
							<div class="alert alert-danger" role="alert">
							  <strong>Oh snap!</strong> ${loginErrorMessage}
							</div>
						</c:when>
					</c:choose>
			    </div>
			    <div class="form-group row col-sm-10">
			    	<input type="submit" class="btn btn-info" class="btn btn-success" value="Register as Staff" name="action"/>
			    	<input type="submit" class="btn btn-info" class="btn btn-success" value="Register as Manager" name="action"/>
			    </div>
			</form:form>    
</body>
</html>