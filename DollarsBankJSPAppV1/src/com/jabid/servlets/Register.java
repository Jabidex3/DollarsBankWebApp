package com.jabid.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jabid.util.Utility;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

    Utility util = new Utility(); 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String a,b,c,d,e,f;
		a=request.getParameter("name");
		b=request.getParameter("address");
		c=request.getParameter("phone");
		d=request.getParameter("user");
		e=request.getParameter("password");
		f=request.getParameter("depo");
		
		PrintWriter out = response.getWriter();
		boolean valid = util.checkUser(d);
		boolean validDepo = util.checkDepo(f);
		//boolean validEverythingElse = util.chkRest(a,b,c,e);
		if(valid) {
			if(validDepo) {
				out.println("<p>thank you for creating an account!</p> <a href='index.jsp'>Please Login Here</a>");
				util.registerUser(a,b,c,d,e);
				util.createAcc(d,f);
				util.addTranscations(d,Double.valueOf(f),"INITIAL");
			}
			else {
				out.println("<p>Invalid input provided for initial deposit amount!</p> <a href='Register.jsp'>Return to Register Interface</a>");
			}
		
		}
		else {
			out.println("<p>The desired username is already has an account linked to it! Please Enter a different username that is not already used!</p> <a href='Register.jsp'>Return to Register Interface</a>");
			//response.sendRedirect("index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
