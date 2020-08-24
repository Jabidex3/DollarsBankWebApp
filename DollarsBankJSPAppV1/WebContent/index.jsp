<%@page import="com.jabid.model.Customer"%>
<%@page import="com.jabid.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%
	session.setAttribute("c_username", null);
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
<title>Dollars Bank Online</title>
</head>
<body>
	<div class="jumbotron bg-dark">
		<h1 class="alert alert-danger text-center">Welcome to Dollars Bank!</h1>
	</div>
	<br>
	<div class="container text-center">
		<div class="row">
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			<div class="col-sm">
				<!-- <form method="post" action="./Login">-->
				<form method="post">
					<table class="table table-striped">
						<tr>
							<td><label class="label label-warning">Username</label></td>
							<td><input type="text" name="username" required></td>
						</tr>
						<tr>
							<td><label class="label label-warning">Password</label></td>
							<td><input type="text" name="pass" required></td>
						</tr>
						<tr>
							<td><input type="submit" value="Login"
								class="btn btn-success"></td>
							<td><input type="reset" value="Cancel"
								class="btn btn-danger"></td>
						</tr>
					</table>
				</form>
				<p>Don't have an account? Click <a href="Register.jsp">Here</a> to register!</p>
				<%
					Utility util = new Utility();
					if(request.getParameter("username")!=null &&  request.getParameter("pass")!=null){
						String u = request.getParameter("username");
						String p = request.getParameter("pass");
						boolean validLogin = util.checkLogin(u,p);
						if(validLogin) {
							HttpSession sess=request.getSession();
							sess.setAttribute("c_username",u);
							response.sendRedirect("Home.jsp");
						}
						else{
							out.println("<p style='color: red'>Invalid Login Credentials!</p>");
						}
						
					}
		
				%>
			</div>
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
		</div>
	</div>
	<footer class="p-3 mb-2 bg-dark text-white text-center"> Copyright © DollarsBank 2020 </footer>
</body>
</html>