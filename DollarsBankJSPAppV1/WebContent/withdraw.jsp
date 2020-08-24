<%@page import="com.jabid.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%
	//redirects to index page if you try to access page w/o logging in
if (session.getAttribute("c_username") == null) {
	response.sendRedirect("index.jsp");
}
Utility util = new Utility();
%>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script>
<title>Withdraw</title>
</head>
<body>
	<div class="jumbotron bg-dark">
		<h1 class="alert alert-danger text-center">Withdraw</h1>
	</div>
	<br>
	<div class="container text-center">
		<div class="row">
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			<div class="col-sm">
				<form class="border">
					<br>
					<div class="form-group text-center">
						<label for="iwith">Withdraw Amount:</label> 
						<input type="text" id="iwith" name="iwith" required> 
						<input type="submit" value="Withdraw" class="btn btn-success">
					</div>
				</form>

				<%
					if (request.getParameter("iwith") != null) {
					String s = request.getParameter("iwith");
					String u_name = (String) session.getAttribute("c_username");
					String result = util.withdraw(u_name, s);
					out.println("<p style='color: red'>" + result + "</p>");

				}
				%>
				<a class="btn btn-primary text-center" href="Home.jsp">Back</a>
			</div>
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
		</div>
	</div>
	<br>
	<footer class="p-3 mb-2 bg-dark text-white text-center">
		Copyright © DollarsBank 2020 </footer>
</body>
</html>