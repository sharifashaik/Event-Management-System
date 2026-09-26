package com.eventify.servlet;

import java.io.IOException;

import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet{
	
	private EventDAO eDAO = new EventDAOImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		 if (session == null || session.getAttribute("userId") == null) {
	            resp.sendRedirect("login.jsp");
	            return;
	        }
		 
		 Integer userId = (Integer)session.getAttribute("userId");
		 
		 Integer totalEvents = eDAO.getTotalEventsForUser(userId);
	     Integer upcomingEvents = eDAO.getUpcomingEventsForUser(userId);
	     Double totalSpent = eDAO.getTotalSpentByUser(userId);
	     
	     
	     req.setAttribute("totalEvents", totalEvents);
	     req.setAttribute("upcomingEvents", upcomingEvents);
	     req.setAttribute("totalSpent", String.format("%,.0f", totalSpent));
	     
	     req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
		
		
		
	}

	

}
