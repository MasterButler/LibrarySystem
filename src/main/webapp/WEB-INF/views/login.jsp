<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="util.DateUtil" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<form:form method="POST" action="login" modelAttribute="credentials">
		<table>
		<tr>
            <td><form:label path="username">Username</form:label></td>
            <td><form:input path="username"/></td>
        </tr>

        <tr>
            <td><form:label path="password">Password</form:label></td>
            <td><form:password path="password"/></td>
        </tr>
      
      	<tr>
      	</tr>
			<c:choose>
				<c:when test="${not empty loginErrorMessage}">
					${loginErrorMessage}
				</c:when>
			</c:choose>
        <tr>
            <td><input type="submit" value="Submit"/></td>
        </tr>
		</table>   
	</form:form>	

</body>
</html>