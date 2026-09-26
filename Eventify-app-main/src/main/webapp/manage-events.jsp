<%-- manage-events.jsp - PREMIUM ADMIN EVENT MANAGEMENT --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null) { response.sendRedirect("login.jsp"); return; }
    if (!"ADMIN".equals(role)) { response.sendRedirect("dashboard.jsp"); return; }
%>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main style="background: var(--cream); padding-bottom: 60px;">
    
    <div class="page-header-premium">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h2><i class="fas fa-calendar-alt me-2"></i>Manage Events</h2>
                    <p>View and manage all customer events and bookings</p>
                </div>
                <div class="col-auto">
                    <a href="AdminDashboardServlet" class="btn btn-premium" 
                       style="background: rgba(255,255,255,0.15); color: white; border: 1px solid rgba(255,255,255,0.3);">
                        <i class="fas fa-arrow-left me-1"></i> Back
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Filters -->
        <div class="d-flex gap-2 flex-wrap mb-4">
            <a href="AdminEventServlet?action=list" class="btn btn-premium btn-premium-primary" style="padding: 8px 20px; font-size: 0.85rem;">All</a>
            <a href="AdminEventServlet?action=list&filter=PENDING" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-clock me-1"></i> Pending
            </a>
            <a href="AdminEventServlet?action=list&filter=CONFIRMED" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-check me-1"></i> Confirmed
            </a>
            <a href="AdminEventServlet?action=list&filter=CANCELLED" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-times me-1"></i> Cancelled
            </a>
            <a href="AdminEventServlet?action=list&filter=COMPLETED" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-flag me-1"></i> Completed
            </a>
        </div>
        
        <div class="table-premium-wrapper">
            <div class="table-responsive">
                <table class="table table-premium">
                    <thead>
                        <tr>
                            <th>ID</th><th>Customer</th><th>Event</th><th>Date</th>
                            <th>Venue</th><th>Guests</th><th>Status</th><th>Payment</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Map<String, Object>> allEvents = (List<Map<String, Object>>) request.getAttribute("allEvents");
                            if (allEvents != null && !allEvents.isEmpty()) {
                                for (Map<String, Object> ev : allEvents) {
                        %>
                        <tr>
                            <td><strong>#<%= ev.get("eventId") %></strong></td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <div style="width: 35px; height: 35px; border-radius: var(--radius-full); 
                                                background: var(--primary-gradient); display: flex; align-items: center; 
                                                justify-content: center; color: white; font-size: 0.75rem; font-weight: 700;">
                                        <%= ((String)ev.get("customerName")).substring(0, 1).toUpperCase() %>
                                    </div>
                                    <div>
                                        <strong style="color: var(--charcoal);"><%= ev.get("customerName") %></strong><br>
                                        <small style="color: var(--medium-gray);"><%= ev.get("customerEmail") %></small>
                                    </div>
                                </div>
                            </td>
                            <td><strong><%= ev.get("eventType") %></strong></td>
                            <td><%= ev.get("eventDate") %></td>
                            <td><%= ev.get("venue") %></td>
                            <td><%= ev.get("guestCount") %></td>
                            <td>
                                <% String es = (String) ev.get("status");
                                   String eb = "pending";
                                   if ("CONFIRMED".equals(es)) eb = "confirmed";
                                   else if ("CANCELLED".equals(es)) eb = "cancelled";
                                   else if ("COMPLETED".equals(es)) eb = "completed"; %>
                                <span class="badge-premium badge-<%= eb %>"><%= es %></span>
                            </td>
                            <td>
                                <% String ep = (String) ev.get("paymentStatus"); %>
                                <span class="badge-premium badge-<%= "COMPLETED".equals(ep) ? "confirmed" : "pending" %>">
                                    <%= "COMPLETED".equals(ep) ? "Paid" : "Pending" %>
                                </span>
                            </td>
                            <td>
                                <form action="AdminEventServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="eventId" value="<%= ev.get("eventId") %>">
                                    
                                    <% if ("PENDING".equals(es)) { %>
                                    <button type="submit" name="action" value="approve" 
                                            class="btn btn-premium btn-premium-success" 
                                            style="padding: 4px 10px; font-size: 0.75rem;"
                                            onclick="return confirm('Approve this event?')">
                                        <i class="fas fa-check me-1"></i>Approve
                                    </button>
                                    <% } %>
                                    
                                    <% if (!"CANCELLED".equals(es) && !"COMPLETED".equals(es)) { %>
                                    <button type="submit" name="action" value="cancel" 
                                            class="btn btn-premium btn-premium-danger" 
                                            style="padding: 4px 10px; font-size: 0.75rem;"
                                            onclick="return confirm('Cancel this event?')">
                                        <i class="fas fa-times me-1"></i>Cancel
                                    </button>
                                    <% } %>
                                    
                                    <% if ("CONFIRMED".equals(es)) { %>
                                    <button type="submit" name="action" value="complete" 
                                            class="btn btn-premium" 
                                            style="padding: 4px 10px; font-size: 0.75rem; background: var(--info); color: white;"
                                            onclick="return confirm('Mark as completed?')">
                                        <i class="fas fa-flag-checkered"></i>
                                    </button>
                                    <% } %>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center" style="padding: 40px; color: var(--medium-gray);">
                                No events found
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