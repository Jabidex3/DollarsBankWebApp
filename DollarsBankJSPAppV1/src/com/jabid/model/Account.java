package com.jabid.model;

import java.util.ArrayList;

public class Account {
	private int a_id;
	private int c_id;
	private double balance;
	private ArrayList<String> transactions;
	
	
	public Account() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Account(int a_id, int c_id, double balance, ArrayList<String> transactions) {
		super();
		this.a_id = a_id;
		this.c_id = c_id;
		this.balance = balance;
		this.transactions = transactions;
	}

	public int getA_id() {
		return a_id;
	}
	public void setA_id(int a_id) {
		this.a_id = a_id;
	}
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public ArrayList<String> getTransactions() {
		return transactions;
	}
	public void setTransactions(String t) {
		this.transactions.add(t);
	}

	@Override
	public String toString() {
		return "Account [a_id=" + a_id + ", c_id=" + c_id + ", balance=" + balance + ", transactions=" + transactions
				+ "]";
	}
	
	
}
