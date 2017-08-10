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
	  		<h1>Change your password here!</h1>
	  		<form:form method="POST" id="change_password" action="login_change_password">
					<input type="hidden" name="login-email" class="form-control" id="login-email" value="${max_attempt_user.email}"/>
				    <div class="form-group row">
				      <label for="create-password" class="col-sm-5 col-form-label">Password</label>
				      <div class="col-sm-10">
				        <input type="password" required="required"  name="password" pattern=".{6,}" class="form-control form-control-sm" id="create-password" placeholder=""/>
				      </div>
				       <div class="col-sm-10">
				       	 <meter max="4" id="password-strength-meter"></meter>
		       			 <p id="password-strength-text"></p>
				       </div>
				    </div>
				    <div class="form-group row">
				      <label for="create-confirmpw" class="col-sm-5 col-form-label">Confirm Password</label>
				      <div class="col-sm-10">
				        <input type="password" required="required" name="confirm_password" pattern=".{6,}"  class="form-control form-control-sm" id="create-confirmpw" placeholder=""/>
				      	<p id="password_match_result">
				      </div>
				    </div>
					<div class="form-group row col-sm-10">
				    	<input id="form_submit" class="btn btn-info" type="submit" value="Save"/>
				    </div>
			</form:form>
	  	</div>
	  	<div class="col-xs-2"></div>
	  </div> 
	</div>
	
	<script type="text/javascript">
		var strength = {
		        0: "Worst",
		        1: "Bad",
		        2: "Weak",
		        3: "Good",
		        4: "Strong"
		}
	
		var password = document.getElementById('create-password');
		var confirmpassword = document.getElementById('create-confirmpw');
		
		var meter = document.getElementById('password-strength-meter');
		var text = document.getElementById('password-strength-text');
	
		password.addEventListener('input', function()
		{
		    var val = password.value;
		    var result = zxcvbn(val);
		    
		    // Update the password strength meter
		    meter.value = result.score;
		   
		    // Update the text indicator
		    if(val !== "") {
		        text.innerHTML = "Strength: " + "<strong>" + strength[result.score] + "</strong>" + "<span class='feedback'>" + result.feedback.warning + " " + result.feedback.suggestions + "</span"; 
		    }
		    else {
		        text.innerHTML = "";
		    }
		});
		
		$('#create-password, #create-confirmpw').on('keyup', function(){
			validatePassword();
		});
		
		function validatePassword(){
			var result = document.getElementById("password_match_result"); 
			if($("#create-password").val() == $("#create-confirmpw").val()){
				$("#password_match_result").html("Matching!").css('color', 'green')
				$("#form_submit").prop("disabled", false);
			}else{
				$("#password_match_result").html("Passwords do not match!").css('color', 'red')
				$("#form_submit").prop("disabled", true);
			}
		}
	</script>
</body>
</html>