<%@page import="com.jabid.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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
<title>Register</title>
</head>
<body>
	<div class="jumbotron bg-dark">
		<h1 class="alert alert-danger text-center">Register</h1>
	</div>
	<br>
	<div class="container text-center">
		<div class="row">
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			<div class="col-sm">
				<form class="border" method="post">
					<label for="name">Name:</label> <br><input type="text" id="name"
						name="name" required><br>
					<br> <label for="address">Address:</label> <br><input type="text"
						id="address" name="address" required><br>
					<br> <label for="phone">Phone Number:</label><br> <input
						type="text" id="phone" name="phone" required><br>
					<br> <label for="user">Username:</label> <br><input type="text"
						id="user" name="user" required><br>
					<br> <label for="password">Password:</label> <br><input
						type="text" id="password" name="password" required><br>
					<br> <label for="depo">Initial Deposit Amount:</label> <br><input
						type="text" id="depo" name="depo" required><br>
					<%
					Utility util = new Utility();
					if(request.getParameter("user")!=null){
						String a,b,c,d,e,f;
						a=request.getParameter("name");
						b=request.getParameter("address");
						c=request.getParameter("phone");
						d=request.getParameter("user");
						e=request.getParameter("password");
						f=request.getParameter("depo");
						
						boolean valid = util.checkUser(d);
						boolean validDepo = util.checkDepo(f);
						if(valid) {
							if(validDepo) {
								if(c.length()!=10){//check c
									out.println("<p style='color: red'>Phone Numbers must be 10 digits long!</p>");
								}
								else{
									if(a.length()>30){// check a
										out.println("<p style='color: red'>Name too long! Must be 30 characters or less</p>");
									}
									else{
										if(b.length()>50){//chck b
											out.println("<p style='color: red'>Address too long! Must be 50 characters or less</p>");
										}
										else{
											if(e.length()>30){//check e
												out.println("<p style='color: red'>Password too long! Must be 30 characters or less</p>");
											}
											else{//success
												out.println("<p style='color: green'>Thank you for creating an account!");
												util.registerUser(a,b,c,d,e);
												util.createAcc(d,f);
												util.addTranscations(d,Double.valueOf(f),"INITIAL");
											}
										}
									}
									
								}
							}
							else {
								out.println("<p style='color: red'>Invalid input provided for initial deposit amount!</p>");
							}
						
						}
						else {
							out.println("<p style='color: red'>The desired username already has an account linked to it! Please Enter a different username that is not already used!</p>");
						}
					}
					%>
					<br> <input class="btn btn-success" type="submit" value="Submit">
				</form>
				<br> <a class="btn btn-primary text-center" href="Home.jsp">Back</a>
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