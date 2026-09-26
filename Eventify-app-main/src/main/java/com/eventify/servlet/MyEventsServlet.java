package com.eventify.servlet;

import java.io.IOException;
import java.util.List;

import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;
import com.eventify.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyEventsServlet")
public class MyEventsServlet extends HttpServlet {
	
	private EventDAO eDAO = new EventDAOImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        List<Event> events = eDAO.getEventByUserId(userId);
        req.setAttribute("events", events);

        req.getRequestDispatcher("my-events.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req,resp);
	}

	

}
