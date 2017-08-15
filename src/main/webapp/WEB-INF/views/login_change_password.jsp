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
	
	<style>
		@import url(https://fonts.googleapis.com/css?family=Signika:400,700|Courgette);

		meter {
		    /* Reset the default appearance.
		       -webkit-appearance: none is removed
		       because of a known bug in Chrome since 
		       since version 52 */
		       -moz-appearance: none;
		            appearance: none;
		            
		    margin: 0 auto 1em;
		    width: 100%;
		    height: .5em;
		    
		    /* Applicable only to Firefox */
		    background: none;
		    background-color: rgba(0,0,0,0.1);
		}
		
		meter::-webkit-meter-bar {
		    background: none;
		    background-color: rgba(0,0,0,0.1);
		}
		
		meter[value="1"]::-webkit-meter-optimum-value { background: red; }
		meter[value="2"]::-webkit-meter-optimum-value { background: orange; }
		meter[value="3"]::-webkit-meter-optimum-value { background: yellow; }
		meter[value="4"]::-webkit-meter-optimum-value { background: green; }
		
		meter[value="1"]::-moz-meter-bar { background: red; }
		meter[value="2"]::-moz-meter-bar { background: orange; }
		meter[value="3"]::-moz-meter-bar { background: yellow; }
		meter[value="4"]::-moz-meter-bar { background: green; }
		
		.feedback {
		    color: #9ab;
		    font-size: 90%;
		    padding: 0 .25em;
		    font-family: Courgette, cursive;
		    margin-top: 1em;
		}
		
		p.password-strength-text{
			word-wrap: normal;
		}
	</style>
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
					      <p id="alert-password-policy"></p>
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
			rulesAreFollowed = false;
			console.log(password.value.length);
			if(password.value.length >= 8){
	            var upperCase = new RegExp('[A-Z]');
	            var lowerCase = new RegExp('[a-z]');
	            var numbers = new RegExp('[0-9]');
	            var count = 0;
	            if (password.value.match(upperCase)) {
	                console.log("UC");
	                count++;
	            }
	            if (password.value.match(lowerCase)) {
	                console.log("LC");
	                count++;
	            }
	            if (password.value.match(numbers)) {
	                console.log("NUM");
	                count++;
	            }
	
	            //Check if contains special symbols..
				if(password.value.match(/[\W]/)) {
					console.log("SPECIAL CHARACTRERS")
				    count++;
				}
	            
	            if(count > 3){
	            	rulesAreFollowed = true;
		        	$("#alert-password-policy").hide();
	            }else{
	            	$("#alert-password-policy").html("Passwords must contain at least one uppercase, one lowercase, one number, and one special character").css('color', 'red');
	            }
				
			}else{				
				rulesAreFollowed = false
				$("#alert-password-policy").html("Password must have at least of size 8").css('color', 'red');
			}
			
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
			var password = document.getElementById('create-password');
			var val = password.value;
		    var result = zxcvbn(val);
		    
			console.log("score is " + result.score);
			if($("#create-password").val() == $("#create-confirmpw").val()){
				if(result.score > 2){
					$("#password_match_result").html("Strong And Matching!").css('color', 'green')
					$("#form_submit").prop("disabled", false);
				}else{
					$("#password_match_result").html("Matching but weak!").css('color', 'orange')
					$("#form_submit").prop("disabled", true);
				}
			}else{
				$("#password_match_result").html("Passwords do not match!").css('color', 'red')
				$("#form_submit").prop("disabled", true);
			}
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
</body>
</html>