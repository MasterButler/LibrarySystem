<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix ="form" uri="http://www.springframework.org/tags/form"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="beans.Status" %>
<%@ page import="beans.LibraryObjectTypes" %>
<%@ page import="util.DateUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form:form method="POST" modelAttribute="literature" action="literature_edit">
		<table>
			<tr>
				<td><form:input type="hidden" path="id" value= "${literature.id}" readonly="true"/></td>
			</tr>
			
			<tr>
	    		<td><form:label path="title">Title</form:label></td>
            	<td><form:input path="title" placeholder = "Title" required="required"/></td>
	  		</tr>
	  		
	  		<tr>
	  		<tr>
	  			<td></td>
	  			<td>${author_warning}</td>
	  		</tr>
			<tr>
	  			<td><form:label path="authors">Authors</form:label></td>
	  			<td>
					<c:forEach items="${literature.authors}" var="author" varStatus="loop">
						<form:input path="authors[${loop.index}].firstName" placeholder = "First Name"/>
						<form:input path="authors[${loop.index}].middleName" placeholder = "Middle Name" />
						<form:input path="authors[${loop.index}].lastName" placeholder = "Last Name"/>
						<c:set var="authorNumber" value="${loop.index+1}"/>
						<input id = "${loop.index}" type="submit" value="Delete Author ${authorNumber}" name="action"/>
						<br> 	
		    		</c:forEach>
		    	</td>
			</tr>
			<tr>	
				<td></td>
		    	<td><input type="submit" value="Add Author" name="action"/></td>
		    </tr>
			<tr>
				<td>Category</td>
				<td>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.BOOK.value}" label="${LibraryObjectTypes.BOOK.name}" required="required"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.MAGAZINE.value}" label="${LibraryObjectTypes.MAGAZINE.name}"/>
					<form:radiobutton path="libraryObjectType" value="${LibraryObjectTypes.THESIS.value}" label="${LibraryObjectTypes.THESIS.name}"/>
				</td>
			</tr>
	  		<tr>
	    		<td>Date of Publication</td>
	    		<fmt:formatDate var="fmtDate" value="${literature.datePublished}" pattern="yyyy-MM-dd"/>
				<td><form:input type="date" path="datePublished" name="literature.datePublished" value="${fmtDate}" required="required"/></td>
	  		</tr>
	  		<tr>
	    		<td><form:label path="publisher">Publisher</form:label></td>
            	<td><form:input path="publisher" placeholder="Publisher" required="required"/></td>
	  		</tr>
	  		<tr>
	  			<td><input type="submit" value="Save" name = "action"/></td>
	  		</tr>
		</table>	
	</form:form>
	
</body>
</html>

