package com.eventify.servlet;

import java.io.IOException;
import java.sql.Date;

import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;
import com.eventify.model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {
	
	private EventDAO eDAO = new EventDAOImpl();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
		
        String action = req.getParameter("action");
        
        
        if ("create".equals(action)) {
            // Get form data from create-event.jsp
            Integer userId = (Integer) session.getAttribute("userId");
            String eventType = req.getParameter("eventType");
            String eventDateStr = req.getParameter("eventDate");
            String venue = req.getParameter("venue");
            String guestCountStr = req.getParameter("guestCount");
            
            try {
            	Date eventDate = Date.valueOf(eventDateStr);
                Integer guestCount = Integer.parseInt(guestCountStr);
                
                Event event = new Event(userId, eventType, eventDate, venue, guestCount);
                
                Integer eventId = eDAO.createEvent(event);
                
                if (eventId > 0) {
                    // Save event ID in session for next steps
                    session.setAttribute("currentEventId", String.valueOf(eventId));
                    // Go to vendor selection
                    resp.sendRedirect("VendorServlet?action=list&eventId=" + eventId);
                } else {
                    req.setAttribute("errorMsg", "Failed to create event!");
                    req.getRequestDispatcher("create-event.jsp").forward(req, resp);
                }
            	
            }catch(Exception e) {
            	
            	 req.setAttribute("errorMsg", "Invalid data! Check your inputs.");
                 req.getRequestDispatcher("create-event.jsp").forward(req, resp);
            	
            }
            
	}
        
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		String action = req.getParameter("action");
        String eventId = req.getParameter("eventId");
        
        if ("cancel".equals(action) && eventId != null) {
            eDAO.updateEventStatus(Integer.parseInt(eventId), "CANCELLED");
            resp.sendRedirect("MyEventsServlet");
        }

	}
	

}
