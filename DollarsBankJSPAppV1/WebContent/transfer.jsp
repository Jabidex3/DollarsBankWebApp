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
<title>Funds Transfer</title>
</head>
<body>
	<div class="jumbotron bg-dark">
		<h1 class="alert alert-danger text-center">Funds Transfer</h1>
	</div>
	<br>
	<div class="container text-center">
		<div class="row">
			<div class="col-sm">
				<img class="img-fluid" src="img/money.jpg">
			</div>
			<div class="col-sm">
				<form>
					<table class="table table-striped border">
						<tr>
							<td>Recipient Username:</td>
							<td><input name="recipient" required></td>
						</tr>
						<tr>
							<td>Transfer Amount:</td>
							<td><input name="amt" required></td>
						</tr>
						<tr>
							<td><input class="btn btn-success" type="submit" value="Transfer"></td>
							<td><input class="btn btn-danger" type="reset" value="Cancel"></td>
						</tr>
					</table>
				</form>
				<%
					if (request.getParameter("recipient") != null && request.getParameter("amt") != null) {
					String s = request.getParameter("recipient");
					String a = request.getParameter("amt");
					String u_name = (String) session.getAttribute("c_username");
					if (s.equals(u_name)) {
						out.println("<p style='color: red'>You cannot transfer money to yourself!</p>");
					} else {
						boolean valid = util.checkUser(s);
						if (valid == false) {//means that there is a match
					boolean validMoneyAmt = util.checkDepo(a);
					if (validMoneyAmt) {
						if (util.chkAmtIfLargerThanBalance(u_name, a)) {
							util.transfer(u_name, s, a);
							out.println("<p style='color: green'>Successful Money Transfer!</p>");
						} else {
							out.println(
									"<p style='color: red'>Transfer Amount is greater than current balance! please enter an amount less than or equal to your current balance!</p>");
						}
					} else {
						out.println("<p style='color: red'>You have entered an invalid amount. Please Try Again!</p>");
					}
						} else {
					out.println("<p style='color: red'>There is no username that matches! Please enter a valid username!</p>");
						}
					}

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