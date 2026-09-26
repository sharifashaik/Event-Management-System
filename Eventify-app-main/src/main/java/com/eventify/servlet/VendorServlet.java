package com.eventify.servlet;

import java.io.IOException;
import java.util.List;

import com.eventify.model.Vendor;
import com.eventify.vendorDAO.VendorDAO;
import com.eventify.vendorDAO.VendorDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VendorServlet")
public class VendorServlet extends HttpServlet {
	
	private VendorDAO vDAO = new VendorDAOImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 HttpSession session = req.getSession(false);
	        if (session == null || session.getAttribute("userId") == null) {
	            resp.sendRedirect("login.jsp");
	            return;
	        }

	        String eventId = req.getParameter("eventId");
	        if (eventId != null) {
	            session.setAttribute("currentEventId", eventId);
	        }
		
	        
	        List<Vendor> vendors = vDAO.getApprovedVendors();

	        // Put in request so JSP can loop through them
	        req.setAttribute("vendors", vendors);

	        req.getRequestDispatcher("vendor-list.jsp").forward(req, resp);
	}

	

}
