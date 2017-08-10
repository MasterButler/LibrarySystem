<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="com.beans.user.UserTypes" %>
<%@ page import="com.beans.LibraryObjectTypes" %>
<%@ page import="com.util.DateUtil" %>    
    
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
	
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
	
	<%@include file="header.jsp" %>
	
	<div class="container after-header">
		<div class="row">
	  		<div class="col-xs-12">
	  			<h1>Create an Administrator Account</h1>
	  			<form:form id = "form_register" method="POST" action="register" modelAttribute="user">
	  				<h3>Basic Information</h3>
					<div class="form-group row">
				      <label for="create-firstname" class="col-sm-5 col-form-label">First Name</label>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-firstname" placeholder="Marnel" path="name.firstName"/>
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
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-lastname" placeholder="Peradilla" path="name.lastName"/>
				      </div>
				    </div>
					<hr />
					<div class="form-group row">
				      <label for="create-bday" class="col-sm-5 col-form-label">Birthday</label>
				      <fmt:formatDate var="fmtDate" value="${user.birthday}" pattern="dd/MM/yyyy"/>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-bday" placeholder="dd/mm/yyyy" path="birthday"/>
				      </div>
				    </div>
				    <fieldset class="form-group row">
					      <legend class="col-form-legend col-sm-2">User Type</legend>
					      <div class="col-sm-10">
					        <div class="form-check">
					          <label class="form-check-label">
					            <form:radiobutton path="userType" value="${UserTypes.STUDENT.value}" label="${UserTypes.STUDENT.name}" required="required"/>
					          	<br>
					          	<form:radiobutton path="userType" value="${UserTypes.FACULTY.value}" label="${UserTypes.FACULTY.name}"/>
					          </label>
							</div>
						</div>
					</fieldset>
				    <div class="form-group row">
				      <label for="create-idnum" class="col-sm-5 col-form-label">ID Number</label>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-idnum" placeholder="ID Number" path="id"/>
				      </div>
				    </div>
				    <hr />
				    <h3>Credentials</h3>
				    <div class="form-group row">
				      <label for="create-username" class="col-sm-5 col-form-label">Username</label>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-username" placeholder="Username" path="credentials.username"/>
				      </div>
				    </div>
				    <div class="form-group row">
				      <label for="create-email" class="col-sm-5 col-form-label">Email</label>
				      <div class="col-sm-10">
				        <form:input type="email" required="required" class="form-control form-control-sm" id="create-email" placeholder="Email" path="email"/>
				      </div>
				    </div>
				    <div class="form-group row">
				      <label for="create-password" class="col-sm-5 col-form-label">Password</label>
				      <div class="col-sm-10">
				        <form:input type="password" required="required"  minlength="6" class="form-control form-control-sm" id="create-password" placeholder="" path="credentials.password"/>
				      </div>
				       <div class="col-sm-10">
				       	 <meter max="4" id="password-strength-meter"></meter>
		       			 <p id="password-strength-text"></p>
				       </div>
				    </div>
				    <div class="form-group row">
				      <label for="create-confirmpw" class="col-sm-5 col-form-label">Confirm Password</label>
				      <div class="col-sm-10">
				        <form:input type="password" required="required"  minlength="6" class="form-control form-control-sm" id="create-confirmpw" placeholder="" path="credentials.password"/>
				      	<p id="password_match_result">
				      </div>
				    </div>
				    <hr />
				    <div class="form-group row">
				      <label for="create-secretQ" class="col-sm-5 col-form-label">Security Question</label>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-secretQ" placeholder="(e.g. What is the name of your first favorite pet?)" path="securityQuestion"/>
				      </div>
				    </div>
				    <div class="form-group row">
				      <label for="create-secretA" class="col-sm-5 col-form-label">Answer</label>
				      <div class="col-sm-10">
				        <form:input type="text" required="required" class="form-control form-control-sm" id="create-secretA" placeholder="Answer" path="securityAnswer"/>
				      </div>
				    </div>
				    <hr />
				    <div class="form-group row">
				    	<c:choose>
							<c:when test="${not empty loginErrorMessage}">
								<div class="alert alert-danger alert-sm" role="alert">
								  <strong>Oh snap!</strong> ${loginErrorMessage}.
								</div>
							</c:when>
						</c:choose>
				    </div>
				    <div class="form-group row col-sm-10">
				    	<input id="form_submit" class="btn btn-info" type="submit" value="Save"/>
				    </div>
			    </form:form>
			</div>
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
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
	
</body>
</html>