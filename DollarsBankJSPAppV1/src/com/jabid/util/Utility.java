package com.jabid.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.jabid.model.Customer;

public class Utility {
	//connect to db
	static Connection conn = null;
	static {
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/bankapp", "root", "root");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	

	/***
	 * Checks if username passed in is already in db
	 * @param user = username
	 * @return true if it is in db, and false otherwise
	 */
	public boolean checkUser(String user) {
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select* from customer where username='"+user+"'");
			int i=0;
			while(rs.next()) {
				i++;
			}
			if(i>0) {//check if someone already has the desired username
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	//checks if amount entered is an actual number and that it is greater than 0
	public boolean checkDepo(String amt) {
		try {
			double d = Double.valueOf(amt);
			if(d>0) {
				return true;
			}
			else {
				return false;
			}
		}
		catch(Exception e) {
			return false;
		}
		
	}
	
	//retrieves customer balance from db
	public double getCustBalance(String uname) {
		int i=getCustId(uname);
		double bal = 0;
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select balance from accounts where c_id='"+i+"'");
			
			while(rs.next()) {
				bal = rs.getDouble(1);
			}
			return bal;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bal;
	}
	
	//deposit money if valid amount and updates db balance
	public String deposit(String uname, String amt) {
		if(checkDepo(amt)) {
			double currBal = getCustBalance(uname);
			double newBal = currBal+Double.valueOf(amt);
			PreparedStatement ps = null;
			String query = "update accounts set balance='"+newBal+"' where c_id='"+getCustId(uname)+"';";
			try {
				ps=conn.prepareStatement(query);
				ps.executeUpdate();
				addTranscations(uname,Double.valueOf(amt),"DEPOSIT");
				return "Successful Deposit! New Balance is now: $"+getCustBalance(uname);
			} catch (SQLException e) {
				return "Failure";
			}
		}
		else {
			return "Invalid Amount Entered!";
		}
	}
	
	//withdraw money if valid amount and updates db balance
	public String withdraw(String uname, String amt) {
		if(checkDepo(amt)) {
			double currBal = getCustBalance(uname);
			if(currBal<Double.valueOf(amt)) {
				return "Amount Entered is greater than current balance! Current balance is: $"+currBal;
			}
			else {
				double newBal = currBal-Double.valueOf(amt);
				PreparedStatement ps = null;
				String query = "update accounts set balance='"+newBal+"' where c_id='"+getCustId(uname)+"';";
				try {
					ps=conn.prepareStatement(query);
					ps.executeUpdate();
					addTranscations(uname,Double.valueOf(amt),"WITHDRAW");
					return "Successful Withdrawal! New Balance is now: $"+getCustBalance(uname);
				} catch (SQLException e) {
					return "Failure!";
				}
			}
			
		}
		else {
			return "Invalid Amount Entered!";
		}
	}
	
	//add new user to db
	public void registerUser(String a, String b, String c, String d, String e) {
		String query="insert into customer values(null,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, a);
			ps.setString(2, b);
			ps.setString(3, c);
			ps.setString(4, d);
			ps.setString(5, e);
			ps.execute();
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	
	//gets customer id based on username
	public int getCustId(String uname) {
		int i=-1;
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select c_id from customer where username='"+uname+"'");
			
			while(rs.next()) {
				i = rs.getInt(1);
			}
			return i;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}
	
	//create account for new user
	public void createAcc(String user, String initDepo) {
		int cid = getCustId(user);
		String query="insert into accounts values(?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, cid);
			ps.setDouble(2,Double.valueOf(initDepo));
			ps.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//checks if log in information is correct
	public boolean checkLogin(String u, String pw) {
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select* from customer where username='"+u+"' and pass='"+pw+"'");
			int i=0;
			while(rs.next()) {
				i++;
			}
			if(i>0) {//there was a result
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	//returns account info of user
	public Customer accDetails(String uname) {
		int id = getCustId(uname);
		Customer c = new Customer();
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from customer where c_id = '"+id+"'");
			
			while(rs.next()) {
				c.setC_id(rs.getInt(1));
				c.setName(rs.getString(2));
				c.setAddress(rs.getString(3));
				c.setPhone(rs.getString(4));
				c.setUsername(rs.getString(5));
				c.setPassword(rs.getString(6));
			}
			return c;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("problem");
			return c;
		}
		
	}

	
	//add deposit and withdrawals to transaction table in db
	public void addTranscations(String uname, double amt, String type){
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		int id = getCustId(uname);
		String msg ="";
		if(type.equals("INITIAL")) {
			msg+="Initial Deposit of $"+amt+" into account. Current balance is now: $"+getCustBalance(uname)+" as of "+ timestamp;
		}
		else if(type.equals("DEPOSIT")) {
			msg+="Deposited $"+amt+" into account. Current balance is now: $"+getCustBalance(uname)+" as of "+ timestamp;
		}
		else if(type.equals("WITHDRAW")) {
			msg+="Withdrew $"+amt+" from account. Current balance is now: $"+getCustBalance(uname)+" as of "+ timestamp;
		}
	
		String query="insert into transactions values(null,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ps.setString(2,msg);
			ps.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//get 5 most recent transactions of a user
	public ArrayList<String> recentTransactions(String u_name){
		ArrayList<String> transactions = new ArrayList<String>();
		int id = getCustId(u_name);
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT user_transaction FROM transactions where c_id = '"+id+"' order by t_id desc limit 5");
			while(rs.next()) {
				transactions.add(rs.getString(1));
			}
			return transactions;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("problem");
		}
		return transactions;
	}
	
	//checks if amount entered is larger than user acc balance
	public boolean chkAmtIfLargerThanBalance(String uname, String amt) {
		double currBal = getCustBalance(uname);
		if(currBal<Double.valueOf(amt)) {
			return false;
		}
		else {
			return true;
		}
	}
	
	//transfers money from one user to another
	public void transfer(String uname, String recipient, String amt) {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		double currBal = getCustBalance(uname);
		double newBal = currBal-Double.valueOf(amt);
		int id = getCustId(uname);
		PreparedStatement ps = null;
		//update current user balance
		String query = "update accounts set balance='"+newBal+"' where c_id='"+getCustId(uname)+"';";
		try {
			ps=conn.prepareStatement(query);
			ps.executeUpdate();
			
			//add new entry to transaction table for current user
			String query2="insert into transactions values(null,?,?)";
			PreparedStatement ps2 = conn.prepareStatement(query2);
			ps2.setInt(1, id);
			ps2.setString(2,"Sent $"+ amt+ " from account to recipient ["+recipient+"] in a money transfer. Current balance is now: $"+ getCustBalance(uname)+" as of "+ timestamp);
			ps2.execute();
		} catch (SQLException e) {
			System.out.println("Failure 1");
		}
		
		double currBal2 = getCustBalance(recipient);
		double newBal2 = currBal2+Double.valueOf(amt);
		int id2 = getCustId(recipient);
		//update recipient user balance
		String query3 = "update accounts set balance='"+newBal2+"' where c_id='"+getCustId(recipient)+"';";
		try {
			PreparedStatement ps3=conn.prepareStatement(query3);
			ps3.executeUpdate();
			
			//add new entry to transaction table for recipient user
			String query4="insert into transactions values(null,?,?)";
			PreparedStatement ps4 = conn.prepareStatement(query4);
			ps4.setInt(1, id2);
			ps4.setString(2,"Recieved $"+ amt+ " from account ["+uname+"] in a money transfer. Current balance is now: $"+ getCustBalance(recipient) +" as of "+ timestamp);
			ps4.execute();
		} catch (SQLException e) {
			System.out.println("Failure 2");
		}
	}
}
