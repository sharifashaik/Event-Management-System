package com.eventify.servlet;

import java.io.IOException;
import java.util.List;

import com.eventify.bookingDAO.BookingDAO;
import com.eventify.bookingDAO.BookingDAOImpl;
import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;
import com.eventify.model.Event;
import com.eventify.model.Vendor;
import com.eventify.vendorDAO.VendorDAO;
import com.eventify.vendorDAO.VendorDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

	private BookingDAO bookDAO = new BookingDAOImpl();
	private EventDAO eventDAO = new EventDAOImpl();
	private VendorDAO vendorDAO = new VendorDAOImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        String eventIdStr = req.getParameter("eventId");
        String[] vendorIdStrs = req.getParameterValues("vendorIds");

        if (vendorIdStrs == null || vendorIdStrs.length == 0) {
            req.setAttribute("errorMsg", "Please select at least one vendor!");
            List<Vendor> vendors = vendorDAO.getApprovedVendors();
            req.setAttribute("vendors", vendors);
            req.getRequestDispatcher("vendor-list.jsp").forward(req, resp);
            return;
        }
        if (eventIdStr == null || eventIdStr.isEmpty()) {
            eventIdStr = (String) session.getAttribute("currentEventId");
        }
        if (eventIdStr == null) {
            req.setAttribute("errorMsg", "Session expired. Please create your event again.");
            resp.sendRedirect("create-event.jsp");
            return;
        }

        Integer eventId = Integer.parseInt(eventIdStr);

        // Convert String array to int array
        Integer[] vendorIds = new Integer[vendorIdStrs.length];
        for (int i = 0; i < vendorIdStrs.length; i++) {
            vendorIds[i] = Integer.parseInt(vendorIdStrs[i]);
        }

        // Save bookings to database
        bookDAO.createBookings(eventId, vendorIds);

        // Store in session for payment step
        session.setAttribute("selectedVendorIds", vendorIds);
        session.setAttribute("currentEventId", String.valueOf(eventId));

        // Get event and vendor details for summary page
        Event event = eventDAO.getEventById(eventId);
        List<Vendor> selectedVendors = vendorDAO.getVendorsByIds(vendorIds);

        req.setAttribute("event", event);
        req.setAttribute("selectedVendors", selectedVendors);

        req.getRequestDispatcher("booking-summary.jsp").forward(req, resp);
    }
	

}
