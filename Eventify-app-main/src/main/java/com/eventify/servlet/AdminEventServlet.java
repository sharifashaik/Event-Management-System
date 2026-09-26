package com.eventify.servlet;

import com.eventify.eventDAO.EventDAO;
import com.eventify.eventDAO.EventDAOImpl;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;


import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminEventServlet")
public class AdminEventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String filter = request.getParameter("filter");
        List<Map<String, Object>> allEvents = eventDAO.getAllEventsWithCustomer(filter);
        request.setAttribute("allEvents", allEvents);
        request.getRequestDispatcher("manage-events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        int eventId = Integer.parseInt(req.getParameter("eventId"));

        if ("approve".equals(action)) {
            eventDAO.updateEventStatus(eventId, "CONFIRMED");
        } else if ("cancel".equals(action)) {
            eventDAO.updateEventStatus(eventId, "CANCELLED");
        } else if ("complete".equals(action)) {
            eventDAO.updateEventStatus(eventId, "COMPLETED");
        }

        resp.sendRedirect("AdminEventServlet?action=list");
    }
}