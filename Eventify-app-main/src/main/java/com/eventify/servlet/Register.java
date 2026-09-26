package com.eventify.servlet;

import java.io.IOException;

import com.eventify.dao.UserDAO;
import com.eventify.dao.UserDAOimpl;
import com.eventify.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class Register extends HttpServlet{
   @Override
 protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  String fullname = req.getParameter("fullName");
	  String email = req.getParameter("email");
	  String phone = req.getParameter("phone");
	  String password = req.getParameter("password");
	  String confirmpass = req.getParameter("confirmPassword");
	  
	  if(fullname == null || email == null || password == null) {
		  req.setAttribute("errorMsg", "all fields are requried");
		  req.getRequestDispatcher("register.jsp").forward(req, resp);
		  return;
	  }
	  if(!password.equals(confirmpass)) {
		  req.setAttribute("errorMsg", "password donot match");
		  req.getRequestDispatcher("register.jsp").forward(req, resp);
		  return;
	  }
	  User u = new User(fullname,email,phone,password);
	  UserDAO ud = new UserDAOimpl();
	  boolean success = ud.saveUser(u);
	  if(success) {
		  resp.sendRedirect("login.jsp?registered=true");
	  }else {
		  req.setAttribute("errorMsg", "registration failed!");
		  req.getRequestDispatcher("register.jsp").forward(req, resp);
	  }	 
	  
	  
}
}
