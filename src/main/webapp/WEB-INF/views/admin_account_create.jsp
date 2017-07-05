<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.user.UserTypes" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form:form method="POST" action="admin_account_create" modelAttribute="user">
		<table>
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
            <td><form:password path="credentials.password"/></td>
        </tr>
                
        <tr>
			<c:choose>
				<c:when test="${not empty registerErrorMessage}">
					${registerErrorMessage}
				</c:when>
			</c:choose>
        </tr>
                
        <tr>
            <td><input type="submit" value="Register as Staff" name="action"/></td>
            <td><input type="submit" value="Register as Manager" name="action"/></td>
        </tr>
    	</table>
    </form:form>
</body>
</html>