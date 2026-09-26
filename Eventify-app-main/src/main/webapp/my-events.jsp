<%-- my-events.jsp - MY EVENTS LIST --%>
<%-- PURPOSE: Shows table of all user's events --%>
<%-- Data comes from: MyEventsServlet --%>

<%-- my-events.jsp - PREMIUM MY EVENTS --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventify.model.Event" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null) { response.sendRedirect("login.jsp"); return; }
%>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main style="background: var(--cream); padding-bottom: 60px;">
    
    <div class="page-header-premium">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <span style="font-family: var(--font-script); font-size: 1.2rem; color: var(--gold-light);">
                        Your celebrations
                    </span>
                    <h2>My Events</h2>
                    <p>Track and manage all your planned events</p>
                </div>
                <div class="col-auto">
                    <a href="create-event.jsp" class="btn btn-premium btn-premium-white">
                        <i class="fas fa-plus me-1"></i> New Event
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        
        <% if (request.getAttribute("successMsg") != null) { %>
        <div class="alert alert-premium alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i>
            <%= request.getAttribute("successMsg") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>
        
        <div class="table-premium-wrapper">
            <div style="padding: 20px 25px; border-bottom: 1px solid var(--pearl);">
                <h5 style="font-family: var(--font-heading); font-weight: 700; margin-bottom: 0; color: var(--charcoal);">
                    <i class="fas fa-calendar-alt me-2" style="color: var(--primary);"></i>All Events
                </h5>
            </div>
            <div class="table-responsive">
                <table class="table table-premium">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Event</th>
                            <th>Date</th>
                            <th>Venue</th>
                            <th>Guests</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Event> events = (List<Event>) request.getAttribute("events");
                            if (events != null && !events.isEmpty()) {
                                int count = 1;
                                for (Event e : events) {
                        %>
                        <tr>
                            <td><strong><%= count++ %></strong></td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <div style="width: 38px; height: 38px; border-radius: var(--radius-sm); 
                                                display: flex; align-items: center; justify-content: center; font-size: 0.9rem;
                                                background: <%= "MARRIAGE".equals(e.getEventType()) ? "rgba(183,110,121,0.1)" : 
                                                               "BIRTHDAY".equals(e.getEventType()) ? "rgba(212,168,67,0.1)" : 
                                                               "ANNIVERSARY".equals(e.getEventType()) ? "rgba(91,143,185,0.1)" : 
                                                               "rgba(91,140,90,0.1)" %>;
                                                color: <%= "MARRIAGE".equals(e.getEventType()) ? "var(--primary)" : 
                                                          "BIRTHDAY".equals(e.getEventType()) ? "var(--gold)" : 
                                                          "ANNIVERSARY".equals(e.getEventType()) ? "var(--info)" : 
                                                          "var(--success)" %>;">
                                        <% if ("MARRIAGE".equals(e.getEventType())) { %>
                                            <i class="fas fa-heart"></i>
                                        <% } else if ("BIRTHDAY".equals(e.getEventType())) { %>
                                            <i class="fas fa-birthday-cake"></i>
                                        <% } else if ("ANNIVERSARY".equals(e.getEventType())) { %>
                                            <i class="fas fa-glass-cheers"></i>
                                        <% } else { %>
                                            <i class="fas fa-briefcase"></i>
                                        <% } %>
                                    </div>
                                    <strong style="color: var(--charcoal);"><%= e.getEventType() %></strong>
                                </div>
                            </td>
                            <td><%= e.getEventDate() %></td>
                            <td><%= e.getVenue() %></td>
                            <td><%= e.getGuestCount() %></td>
                            <td>
                                <% String status = e.getPaymentStatus();
                                   String badgeClass = "pending";
                                   if ("CONFIRMED".equals(status)) badgeClass = "confirmed";
                                   else if ("CANCELLED".equals(status)) badgeClass = "cancelled";
                                   else if ("COMPLETED".equals(status)) badgeClass = "completed"; %>
                                <span class="badge-premium badge-<%= badgeClass %>"><%= status %></span>
                            </td>
                            <td>
                                <% String pStatus = e.getPaymentStatus();
                                   if (pStatus == null) pStatus = "PENDING"; %>
                                <span class="badge-premium badge-<%= "COMPLETED".equals(pStatus) ? "confirmed" : "pending" %>">
                                    <%= "COMPLETED".equals(pStatus) ? "Paid" : "Pending" %>
                                </span>
                            </td>
                            <td>
                                <% if ("PENDING".equals(status)) { %>
                                <a href="EventServlet?action=cancel&eventId=<%= e.getEventId() %>"
                                   class="btn btn-premium btn-premium-danger" 
                                   style="padding: 5px 12px; font-size: 0.8rem;"
                                   onclick="return confirm('Cancel this event?')">
                                    <i class="fas fa-times"></i>
                                </a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center" style="padding: 60px 20px;">
                                <div style="width: 80px; height: 80px; border-radius: var(--radius-full); 
                                            background: var(--pearl); display: inline-flex; align-items: center; 
                                            justify-content: center; margin-bottom: 20px;">
                                    <i class="fas fa-calendar-times fa-2x" style="color: var(--medium-gray);"></i>
                                </div>
                                <h5 style="color: var(--dark-gray); font-family: var(--font-heading);">No events yet</h5>
                                <p style="color: var(--medium-gray); margin-bottom: 20px;">
                                    Start by creating your first celebration
                                </p>
                                <a href="create-event.jsp" class="btn btn-premium btn-premium-primary">
                                    <i class="fas fa-plus me-1"></i> Create Event
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<%@ include file="HNF/footer.jsp" %>