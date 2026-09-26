<%-- dashboard.jsp - PREMIUM CUSTOMER DASHBOARD --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null) { response.sendRedirect("login.jsp"); return; }
    if ("ADMIN".equals(role)) { response.sendRedirect("AdminDashboardServlet"); return; }
%>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main style="background: var(--cream); padding-bottom: 60px;">
    
    <!-- Welcome Banner -->
    <div class="container" style="padding-top: 30px;">
        <div class="welcome-premium">
            <div class="row align-items-center">
                <div class="col-md-8" style="position: relative; z-index: 1;">
                    <span style="font-family: var(--font-script); font-size: 1.2rem; color: var(--gold-light);">
                        Good to see you again
                    </span>
                    <h2 style="font-family: var(--font-heading); margin-top: 5px;">
                        Welcome, <%= session.getAttribute("userName") %> ✨
                    </h2>
                    <p style="opacity: 0.7; margin-bottom: 20px;">
                        Your event planning dashboard. Manage everything in one place.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="create-event.jsp" class="btn btn-premium btn-premium-primary">
                            <i class="fas fa-plus"></i> Plan New Event
                        </a>
                        <a href="MyEventsServlet" class="btn btn-premium" 
                           style="background: rgba(255,255,255,0.15); color: white; border: 1px solid rgba(255,255,255,0.3);">
                            <i class="fas fa-calendar"></i> My Events
                        </a>
                    </div>
                </div>
                <div class="col-md-4 text-end d-none d-md-block" style="position: relative; z-index: 1;">
                    <img src="https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=300&q=80" 
                         alt="Celebration" 
                         style="width: 200px; height: 200px; object-fit: cover; border-radius: var(--radius-lg); 
                                border: 3px solid rgba(255,255,255,0.2); box-shadow: var(--shadow-lg);">
                </div>
            </div>
        </div>
    </div>
    
    <!-- Stats Cards -->
    <div class="container" style="margin-top: 30px;">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg rose">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-number">
                        <%= request.getAttribute("totalEvents") != null ? request.getAttribute("totalEvents") : "0" %>
                    </div>
                    <div class="stat-label">Total Events Created</div>
                    <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid var(--pearl);">
                        <a href="MyEventsServlet" style="color: var(--primary); font-size: 0.85rem; 
                                                         text-decoration: none; font-weight: 600;">
                            View All <i class="fas fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg green">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-number">
                        <%= request.getAttribute("upcomingEvents") != null ? request.getAttribute("upcomingEvents") : "0" %>
                    </div>
                    <div class="stat-label">Upcoming Events</div>
                    <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid var(--pearl);">
                        <span style="color: var(--success); font-size: 0.85rem; font-weight: 500;">
                            <i class="fas fa-check-circle me-1"></i> All on track
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-12">
                <div class="stat-card-premium">
                    <div class="stat-icon-bg gold">
                        <i class="fas fa-indian-rupee-sign"></i>
                    </div>
                    <div class="stat-number">
                        ₹<%= request.getAttribute("totalSpent") != null ? request.getAttribute("totalSpent") : "0" %>
                    </div>
                    <div class="stat-label">Total Investment</div>
                    <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid var(--pearl);">
                        <span style="color: var(--gold); font-size: 0.85rem; font-weight: 500;">
                            <i class="fas fa-shield-alt me-1"></i> Secure Payments
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="container" style="margin-top: 40px;">
        <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal); margin-bottom: 25px;">
            <i class="fas fa-bolt me-2" style="color: var(--gold);"></i>Quick Actions
        </h4>
        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <a href="create-event.jsp" style="text-decoration: none;">
                    <div class="feature-card" style="cursor: pointer;">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-plus-circle"></i>
                        </div>
                        <h5 class="feature-title">Plan Event</h5>
                        <p class="feature-text">Start planning a new celebration</p>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="VendorServlet?action=list" style="text-decoration: none;">
                    <div class="feature-card" style="cursor: pointer;">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-store"></i>
                        </div>
                        <h5 class="feature-title">Browse Vendors</h5>
                        <p class="feature-text">Explore our premium vendors</p>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="MyEventsServlet" style="text-decoration: none;">
                    <div class="feature-card" style="cursor: pointer;">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h5 class="feature-title">My Events</h5>
                        <p class="feature-text">Track all your events</p>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="MyEventsServlet" style="text-decoration: none;">
                    <div class="feature-card" style="cursor: pointer;">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-receipt"></i>
                        </div>
                        <h5 class="feature-title">Payments</h5>
                        <p class="feature-text">View transaction history</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</main>

<%@ include file="HNF/footer.jsp" %>