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
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
   @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	String email = req.getParameter("email");
	String password = req.getParameter("password");
	
	if(email == null || password == null) {
		req.setAttribute("errorMsg", "email and password are required");
		req.getRequestDispatcher("login.jsp").forward(req, resp);
		return;
	}
	UserDAO userDAO = new UserDAOimpl();
	User u=userDAO.loginUser(email, password);
	if(u!=null) {
		HttpSession session = req.getSession();
		session.setAttribute("userId", u.getUser_id());
		session.setAttribute("userName", u.getFull_name());
		session.setAttribute("email", u.getEmail());
		session.setAttribute("role", u.getRole());
		if("ADMIN".equals(u.getRole())) {
			resp.sendRedirect("AdminDashboardServlet");
		}else {
			resp.sendRedirect("Dashboard");
		}
	}else {
		req.setAttribute("errorMsg", "Invalid email or Password");
		req.getRequestDispatcher("login.jsp").forward(req, resp);
	}
	
	

	   
}
   
}
