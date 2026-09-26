package com.eventify.model;

import java.sql.Date;

public class User {
  private Integer user_id;
  private String full_name;
  private String email;
  private String phone;
  private String password;
  private String role;
  
  public Integer getUser_id() {
	return user_id;
}
public User() {
	  
  }

  public void setUser_id(Integer user_id) {
	this.user_id = user_id;
  }

  public String getFull_name() {
	return full_name;
  }

  public void setFull_name(String full_name) {
	this.full_name = full_name;
  }

  public String getEmail() {
	return email;
  }

  public void setEmail(String email) {
	this.email = email;
  }

  public String getPhone() {
	return phone;
  }

  public void setPhone(String phone) {
	this.phone = phone;
  }

  public String getPassword() {
	return password;
  }

  public void setPassword(String password) {
	this.password = password;
  }

  public String getRole() {
	return role;
  }

  public void setRole(String role) {
	this.role = role;
  }

  
  
  public User(String full_name, String email, String phone, String password) {
	super();
	this.full_name = full_name;
	this.email = email;
	this.phone = phone;
	this.password = password;
	this.role = "customer";
}
  @Override
public String toString() {
	return "User [user_id=" + user_id + ", full_name=" + full_name + ", email=" + email + ", phone=" + phone
			+ ", password=" + password + ", role=" + role + "]";
}
 
 
  
  
}
