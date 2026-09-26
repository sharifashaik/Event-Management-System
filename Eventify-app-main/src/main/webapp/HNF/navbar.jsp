<%-- includes/navbar.jsp - PREMIUM NAVBAR --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loggedInUser = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("role");
    boolean isLoggedIn = (loggedInUser != null);
    boolean isAdmin = "ADMIN".equals(userRole);
%>

<nav class="navbar navbar-expand-lg navbar-premium sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <span class="brand-icon"><i class="fas fa-gem"></i></span>
            Eventify
        </a>
        
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                
                <% if (isLoggedIn && !isAdmin) { %>
                <li class="nav-item">
                    <a class="nav-link" href="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="create-event.jsp">Plan Event</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MyEventsServlet">My Events</a>
                </li>
                <% } %>
                
                <% if (isAdmin) { %>
                <li class="nav-item">
                    <a class="nav-link" href="AdminDashboardServlet">
                        <i class="fas fa-shield-alt me-1"></i> Admin
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdminVendorServlet?action=list">Vendors</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdminEventServlet?action=list">Events</a>
                </li>
                <% } %>
            </ul>
            
            <ul class="navbar-nav">
                <% if (isLoggedIn) { %>
                <li class="nav-item d-flex align-items-center me-3">
                    <span class="user-badge">
                        <span class="avatar-sm">
                            <%= loggedInUser.substring(0, 1).toUpperCase() %>
                        </span>
                        <%= loggedInUser %>
                        <% if (isAdmin) { %>
                        <span class="badge bg-danger" style="font-size: 0.65rem;">ADMIN</span>
                        <% } %>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-nav-logout" href="Logout">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </li>
                <% } else { %>
                <li class="nav-item me-2">
                    <a class="nav-link" href="login.jsp">Sign In</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-nav-primary" href="register.jsp">Get Started</a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>