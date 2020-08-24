package com.jabid.model;

public class Customer {
	private int c_id;
	private String name;
	private String address;
	private String phone;
	private String username; //unique
	private String password;

	
	
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public Customer(int c_id, String name, String address, String phone, String username, String password) {
		super();
		this.c_id = c_id;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.username = username;
		this.password = password;
	}





	public int getC_id() {
		return c_id;
	}



	public void setC_id(int c_id) {
		this.c_id = c_id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}


	@Override
	public String toString() {
		return "Customer [c_id=" + c_id + ", name=" + name + ", address=" + address + ", phone=" + phone + ", username="
				+ username + ", password=" + password + "]";
	}

	
	
	
}
