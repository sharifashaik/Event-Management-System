package com.eventify.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.eventify.dao.UserDAO;
import com.eventify.dao.UserDAOimpl;
import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;
import com.eventify.vendorDAO.VendorDAO;
import com.eventify.vendorDAO.VendorDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
	
	private UserDAO userDAO = new UserDAOimpl();
    private VendorDAO vendorDAO = new VendorDAOImpl();
    private EventDAO eventDAO = new EventDAOImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// SECURITY: Only admin can access
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Get all stats from DAOs
        req.setAttribute("totalUsers", userDAO.getallUsers());
        req.setAttribute("totalVendors", vendorDAO.getTotalVendors());
        req.setAttribute("totalEvents", eventDAO.getTotalEvents());
        req.setAttribute("totalRevenue", String.format("%,.0f", eventDAO.getTotalRevenue()));
        req.setAttribute("pendingVendors", vendorDAO.getPendingVendors());
        req.setAttribute("pendingEvents", eventDAO.getPendingEvents());

        // Get recent events for table
        List<Map<String, Object>> recentEvents = eventDAO.getAllEventsWithCustomer(null);
        if (recentEvents.size() > 5) recentEvents = recentEvents.subList(0, 5);
        req.setAttribute("recentEvents", recentEvents);

        req.getRequestDispatcher("admin-dashboard.jsp").forward(req, resp);
		
	}

	

}
