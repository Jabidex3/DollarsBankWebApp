<%@page import="com.jabid.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%
//redirects to index page if you try to acess page w/o logging in
if(session.getAttribute("c_username")==null){
	response.sendRedirect("index.jsp");
}
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
<title>Home</title>
</head>
<body>
<div class="jumbotron bg-dark">
		<h1 class="alert alert-danger text-center">Welcome <%out.println(session.getAttribute("c_username")); %>!</h1>
	</div>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			<div class="col-sm">
				<table class="table table-dark text-center">
				<tr>
				<th>Transaction Menu</th></tr>
				<tr><td><a class="btn btn-primary" href ="deposit.jsp">Deposit</a></td></tr>
				<tr><td><a class="btn btn-primary" href ="withdraw.jsp">Withdraw</a></td></tr>
				<tr><td><a class="btn btn-primary" href="transfer.jsp">Transfer Money</a></td></tr>
				<tr><td><a class="btn btn-primary" href ="transactions.jsp">Transaction History</a></td></tr>
				<tr><td><a class="btn btn-primary" href="details.jsp">Account Details</a></td></tr>
				<tr><td><a class="btn btn-primary" href ="index.jsp">Sign Out</a></td></tr>
				</table>
				</div>
				<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			</div>
			</div>
			<footer class="p-3 mb-2 bg-dark text-white text-center"> Copyright © DollarsBank 2020 </footer>
</body>
</html>