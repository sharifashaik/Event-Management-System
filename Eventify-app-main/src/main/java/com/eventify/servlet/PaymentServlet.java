package com.eventify.servlet;

import java.io.IOException;

import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;
import com.eventify.paymentDAO.PaymentDAO;
import com.eventify.paymentDAO.PaymentDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	
	private PaymentDAO payDAO = new PaymentDAOImpl();
	private EventDAO eventDAO = new EventDAOImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 	
			
			HttpSession session = req.getSession(false);
	        if (session == null || session.getAttribute("userId") == null) {
	            resp.sendRedirect("login.jsp");
	            return;
	        }
	        
	        Integer userId = (Integer) session.getAttribute("userId");
	        String eventIdStr = req.getParameter("eventId");
	        String amountStr = req.getParameter("amount");
	        String paymentMethod = req.getParameter("paymentMethod");
	        
	        try {
	        	Integer eventId = Integer.parseInt(eventIdStr);
	            Double amount = Double.parseDouble(amountStr);

	            // Save payment record
	            Boolean success = payDAO.createPayment(eventId, userId, amount, paymentMethod);
	            
	            if(success) {
	            	 // Update event status to CONFIRMED
	                eventDAO.updateEventStatus(eventId, "CONFIRMED");

	                // Clean up session
	                session.removeAttribute("currentEventId");
	                session.removeAttribute("selectedVendorIds");

	                resp.sendRedirect("MyEventsServlet");
	            }else {
	            	req.setAttribute("errorMsg", "Payment failed! Try again.");
	                req.getRequestDispatcher("payment.jsp").forward(req, resp);
	            }
	        	
	        }catch(Exception e) {
	        	req.setAttribute("errorMsg", "Invalid payment data!");
	            req.getRequestDispatcher("payment.jsp").forward(req, resp);
	        	
	        }
	}

	

}
