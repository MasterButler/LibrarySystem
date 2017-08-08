<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="beans.Status" %>
<%@ page import="util.DateUtil" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<form:form method="POST" modelAttribute="literature" action="literature_add">
		<table style="width:100%">
	  		<tr>
	    		<td><form:label path="title">Title</form:label></td>
            	<td><form:input path="title" placeholder = "Title"/></td>
	  		</tr>
	  		<tr>
			<tr>
	  			<td><form:label path="authors">Authors</form:label></td>
	  			<td>
					<c:forEach items="${literature.authors}" var="author" varStatus="loop">
						<form:input path="authors[${loop.index}].firstName" placeholder = "First Name"/>
						<form:input path="authors[${loop.index}].middleName" placeholder = "Middle Name" />
						<form:input path="authors[${loop.index}].lastName" placeholder = "Last Name"/>
						<input type="submit" value="Delete Author ${loop.index}" name="action"/>
						<br>
						
						<c:choose>
							<c:when test="${loop.last}">
								<td><input type="submit" value="Add Author" name="action"/></td>		
							</c:when>
						</c:choose>
		    		</c:forEach>
		    	</td>
			</tr>
			<tr>
				<td colspan="2">
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.BOOK.value}" label="${LibraryObjectTypes.BOOK.name}"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.MAGAZINE.value}" label="${LibraryObjectTypes.MAGAZINE.name}"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.THESIS.value}" label="${LibraryObjectTypes.THESIS.name}"/>
				</td>
			</tr>
			
	  		<tr>
	    		<td>Date of Publication</td>
	    		<fmt:formatDate var="fmtDate" value="${literature.datePublished}" pattern="${DateUtil.NUMBER_FORMAT}"/>
				<td><form:input type="text" path="datePublished" placeholder = "MM/dd/yyyy" name="literature.datePublished" value="${fmtDate}"/></td>
	  		</tr>
	  		<tr>
	    		<td><form:label path="publisher">Publisher</form:label></td>
            	<td><form:input path="publisher" placeholder="Publisher"/></td>
	  		</tr>
	  		<tr>
	  			<td><input type="submit" value="Create Literature" name = "action"/></td>
	  		</tr>
		</table>	
	</form:form>
</body>
</html>

