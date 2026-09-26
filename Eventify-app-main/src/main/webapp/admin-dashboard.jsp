<%-- admin-dashboard.jsp - PREMIUM ADMIN DASHBOARD --%>
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
    
    <!-- Admin Welcome -->
    <div class="container" style="padding-top: 30px;">
        <div class="welcome-premium" style="background: linear-gradient(135deg, #1a1a2e 0%, #2D2040 100%);">
            <div class="row align-items-center" style="position: relative; z-index: 1;">
                <div class="col-md-8">
                    <span style="display: inline-block; padding: 4px 14px; background: var(--danger); 
                                 border-radius: var(--radius-xl); font-size: 0.75rem; font-weight: 700; 
                                 letter-spacing: 1px; margin-bottom: 10px;">ADMIN PANEL</span>
                    <h2 style="font-family: var(--font-heading);">
                        <i class="fas fa-shield-alt me-2"></i>Control Center
                    </h2>
                    <p style="opacity: 0.7;">
                        Welcome back, <%= session.getAttribute("userName") %>. Here's your platform overview.
                    </p>
                </div>
                <div class="col-md-4 text-end d-none d-md-block">
                    <i class="fas fa-cogs" style="font-size: 5rem; opacity: 0.1;"></i>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Stats -->
    <div class="container" style="margin-top: 30px;">
        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg rose"><i class="fas fa-users"></i></div>
                    <div class="stat-number"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></div>
                    <div class="stat-label">Total Users</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg green"><i class="fas fa-store"></i></div>
                    <div class="stat-number"><%= request.getAttribute("totalVendors") != null ? request.getAttribute("totalVendors") : "0" %></div>
                    <div class="stat-label">Total Vendors</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg blue"><i class="fas fa-calendar-alt"></i></div>
                    <div class="stat-number"><%= request.getAttribute("totalEvents") != null ? request.getAttribute("totalEvents") : "0" %></div>
                    <div class="stat-label">Total Events</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg gold"><i class="fas fa-indian-rupee-sign"></i></div>
                    <div class="stat-number">₹<%= request.getAttribute("totalRevenue") != null ? request.getAttribute("totalRevenue") : "0" %></div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Management Cards -->
    <div class="container" style="margin-top: 40px;">
        <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal); margin-bottom: 25px;">
            <i class="fas fa-cog me-2" style="color: var(--gold);"></i>Management
        </h4>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card" style="text-align: center;">
                    <div class="feature-icon-wrapper" style="background: rgba(91,140,90,0.1);">
                        <i class="fas fa-store" style="color: var(--success);"></i>
                    </div>
                    <h5 class="feature-title">Manage Vendors</h5>
                    <p class="feature-text">Approve, reject, or manage vendor profiles</p>
                    <span class="badge-premium badge-pending" style="margin-bottom: 15px; display: inline-block;">
                        <%= request.getAttribute("pendingVendors") != null ? request.getAttribute("pendingVendors") : "0" %> Pending
                    </span><br>
                    <a href="AdminVendorServlet?action=list" class="btn btn-premium btn-premium-success" style="margin-top: 5px;">
                        <i class="fas fa-arrow-right me-1"></i> Go to Vendors
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card" style="text-align: center;">
                    <div class="feature-icon-wrapper" style="background: rgba(183,110,121,0.1);">
                        <i class="fas fa-calendar-alt" style="color: var(--primary);"></i>
                    </div>
                    <h5 class="feature-title">Manage Events</h5>
                    <p class="feature-text">View and manage all customer events</p>
                    <span class="badge-premium badge-pending" style="margin-bottom: 15px; display: inline-block;">
                        <%= request.getAttribute("pendingEvents") != null ? request.getAttribute("pendingEvents") : "0" %> Pending
                    </span><br>
                    <a href="AdminEventServlet?action=list" class="btn btn-premium btn-premium-primary" style="margin-top: 5px;">
                        <i class="fas fa-arrow-right me-1"></i> Go to Events
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card" style="text-align: center;">
                    <div class="feature-icon-wrapper" style="background: rgba(201,169,110,0.1);">
                        <i class="fas fa-chart-bar" style="color: var(--gold);"></i>
                    </div>
                    <h5 class="feature-title">Reports</h5>
                    <p class="feature-text">View revenue and analytics data</p>
                    <span class="badge-premium badge-confirmed" style="margin-bottom: 15px; display: inline-block;">
                        Live Data
                    </span><br>
                    <a href="#" class="btn btn-premium btn-premium-gold" style="margin-top: 5px;">
                        <i class="fas fa-arrow-right me-1"></i> View Reports
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Recent Events -->
    <div class="container" style="margin-top: 40px;">
        <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal); margin-bottom: 25px;">
            <i class="fas fa-history me-2" style="color: var(--gold);"></i>Recent Events
        </h4>
        <div class="table-premium-wrapper">
            <div class="table-responsive">
                <table class="table table-premium">
                    <thead>
                        <tr>
                            <th>Customer</th><th>Event</th><th>Date</th>
                            <th>Venue</th><th>Status</th><th>Payment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Map<String, Object>> recentEvents = (List<Map<String, Object>>) request.getAttribute("recentEvents");
                            if (recentEvents != null && !recentEvents.isEmpty()) {
                                for (Map<String, Object> ev : recentEvents) {
                        %>
                        <tr>
                            <td><strong><%= ev.get("customerName") %></strong></td>
                            <td><%= ev.get("eventType") %></td>
                            <td><%= ev.get("eventDate") %></td>
                            <td><%= ev.get("venue") %></td>
                            <td>
                                <% String s = (String) ev.get("status");
                                   String bc = "pending";
                                   if ("CONFIRMED".equals(s)) bc = "confirmed";
                                   else if ("CANCELLED".equals(s)) bc = "cancelled";
                                   else if ("COMPLETED".equals(s)) bc = "completed"; %>
                                <span class="badge-premium badge-<%= bc %>"><%= s %></span>
                            </td>
                            <td>
                                <% String ps = (String) ev.get("paymentStatus"); %>
                                <span class="badge-premium badge-<%= "COMPLETED".equals(ps) ? "confirmed" : "pending" %>">
                                    <%= ps != null ? ps : "PENDING" %>
                                </span>
                            </td>
                        </tr>
                        <%  }
                            } else { %>
                        <tr><td colspan="6" class="text-center" style="padding: 30px; color: var(--medium-gray);">No recent events</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<%@ include file="HNF/footer.jsp" %>