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
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
						
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
	
	<style>
		@import url(https://fonts.googleapis.com/css?family=Signika:400,700|Courgette);
		
		* {
		    box-sizing: border-box;
		}
		
		body {
		    padding: 2.5em 2em 0em;
		    background: #f5f7f9;
		        font-size: 1.5em;
		        color: #346;
		        font-family: Signika, -apple-system, sans-serif;
		}
		
		section {
		    margin: 0em auto 0;
		    width: 100%;
		    max-width: 800px;
		}
		
		input {
		    display: block;
		    margin: .5em auto 0em;
		    padding: 0.5em 1em 0.5em 0.7em;
		    width: 100%;
		    border: none;
		    background: rgba(0,0,0,0.05);
		    color: rgba(0,0,0,0.8);
		    font-size: 2em;
		    line-height: 0;
		        transition: all .5s linear;
		}
		
		input:hover, input:focus {
		    outline: 0;
		    transition: all .5s linear;
		    box-shadow: inset 0px 0px 10px #ccc;
		}
		
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
	<form:form method="POST" action="register" modelAttribute="user">
		<table style="max-width:800px;">
        <tr>
            <td><form:label path="name.firstName">First Name</form:label></td>
            <td><form:input path="name.firstName"/></td>
        </tr>
        
        <tr>
            <td><form:label path="name.middleName">Middle Name</form:label></td>
            <td><form:input path="name.middleName"/></td>
        </tr>
        
        <tr>
            <td><form:label path="name.lastName">Last Name</form:label></td>
            <td><form:input path="name.lastName"/></td>
        </tr>
        
        <tr>
        	<td><form:label path="birthday">Birthday</form:label></td>
            <fmt:formatDate var="fmtDate" value="${user.birthday}" pattern="dd/MM/yyyy"/>
			<td><form:input type="text" path="birthday" name="user.birthday" value="${fmtDate}"/></td>
            	
        </tr>
         
        <tr>
        	<td><form:radiobutton path="userType" value="${UserTypes.STUDENT.value}" label="${UserTypes.STUDENT.name}"/></td>
        	<td><form:radiobutton path="userType" value="${UserTypes.FACULTY.value}" label="${UserTypes.FACULTY.name}"/></td>
        </tr>
        
        <tr>
            <td><form:label path="id">ID Number</form:label></td>
            <td><form:input path="id"/></td>
        </tr>
        
		<tr>
            <td><form:label path="credentials.username">Username</form:label></td>
            <td><form:input path="credentials.username"/></td>
        </tr>        
        
        <tr>
            <td><form:label path="email">Email</form:label></td>
            <td><form:input type = "email" path="email"/></td>
        </tr>

        <tr>
            <td><form:label path="credentials.password">Password</form:label></td>
            <td><form:password id="password" path="credentials.password"/></td>
        </tr> 
        <tr>
        	<td></td>
	        <td>
		        <meter max="4" id="password-strength-meter"></meter>
		        <p id="password-strength-text"></p>
	        </td>
        </tr>
        
        <tr>
        	<td><form:label path="credentials.password">Confirm Password</form:label></td>
            <td><form:password id="confirm_password" path="credentials.password"/></td>
            <td><p id="password_match_result"></p></td>
        </tr>
        
        <tr>
			<c:choose>
				<c:when test="${not empty registerErrorMessage}">
					${registerErrorMessage}
				</c:when>
			</c:choose>
        </tr>
               
        <tr>
            <td><input type="submit" value="Save"/></td>
        </tr>
        
    	</table>
    </form:form>
    
    <script type="text/javascript">
		var strength = {
		        0: "Worst",
		        1: "Bad",
		        2: "Weak",
		        3: "Good",
		        4: "Strong"
		}
	
		var password = document.getElementById('password');
		var confirmpassword = document.getElementById('confirm_password');
		
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
		
		confirmpassword.addEventListener('input', function(){
			var result = document.getElementById("password_match_result"); 
			if(password.value == confirmpassword.value){
				result.innerHTML = "Passwords match!"
			}else{
				result.innerHTML = "Passwords do not match!"
			}
		});
	</script>
</body>
</html>