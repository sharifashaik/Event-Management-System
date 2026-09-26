<%-- create-event.jsp - PREMIUM EVENT CREATION --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

	String role = (String) session.getAttribute("role");
	if (role == null) { response.sendRedirect("login.jsp"); return; }
	String preSelectedType = request.getParameter("eventType");
	if (preSelectedType == null) preSelectedType = "";

%>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main style="background: var(--cream); padding-bottom: 60px;">
    
    <!-- Page Header -->
    <div class="page-header-premium">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <span style="font-family: var(--font-script); font-size: 1.2rem; color: var(--gold-light);">
                        Let's create something beautiful
                    </span>
                    <h2>Plan Your Event</h2>
                    <p>Fill in the details and we'll help you find the perfect vendors</p>
                </div>
                <div class="col-auto">
                    <a href="DashboardServlet" class="btn btn-premium" 
                       style="background: rgba(255,255,255,0.15); color: white; border: 1px solid rgba(255,255,255,0.3);">
                        <i class="fas fa-arrow-left me-1"></i> Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="form-premium">
                    
                    <div class="text-center mb-4">
                        <div style="width: 60px; height: 60px; border-radius: var(--radius-full); 
                                    background: var(--primary-gradient); display: inline-flex; 
                                    align-items: center; justify-content: center; color: white; font-size: 1.3rem;">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                    </div>
                    
                    <h2 class="form-premium-title">Event Details</h2>
                    <p class="form-premium-subtitle">Tell us about your celebration</p>
                    
                    <% if (request.getAttribute("errorMsg") != null) { %>
                    <div class="alert alert-premium alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("errorMsg") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>
                    
                    <form action="EventServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <!-- Event Type -->
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-star me-1" style="color: var(--gold);"></i> 
                                What are you celebrating? <span style="color: var(--danger);">*</span>
                            </label>
                            <select class="form-select" name="eventType" required>
							    <option value="" disabled <%= preSelectedType.isEmpty() ? "selected" : "" %>>Choose your occasion</option>
							    <option value="MARRIAGE"    <%= "MARRIAGE".equals(preSelectedType)    ? "selected" : "" %>>💒 Wedding / Marriage</option>
							    <option value="BIRTHDAY"    <%= "BIRTHDAY".equals(preSelectedType)    ? "selected" : "" %>>🎂 Birthday Celebration</option>
							    <option value="ANNIVERSARY" <%= "ANNIVERSARY".equals(preSelectedType) ? "selected" : "" %>>🥂 Anniversary</option>
							    <option value="CORPORATE"   <%= "CORPORATE".equals(preSelectedType)   ? "selected" : "" %>>💼 Corporate Event</option>
							</select>
                        </div>
                        
                        <!-- Date & Venue Row -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-calendar me-1" style="color: var(--gold);"></i> 
                                    Event Date <span style="color: var(--danger);">*</span>
                                </label>
                                <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="fas fa-users me-1" style="color: var(--gold);"></i> 
                                    Guest Count <span style="color: var(--danger);">*</span>
                                </label>
                                <input type="number" class="form-control" name="guestCount" 
                                       placeholder="Expected guests" required min="1" max="10000">
                            </div>
                        </div>
                        
                        <!-- Venue -->
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-map-marker-alt me-1" style="color: var(--gold);"></i> 
                                Venue <span style="color: var(--danger);">*</span>
                            </label>
                            <div class="form-icon-wrapper">
                                <i class="fas fa-location-dot form-icon"></i>
                                <input type="text" class="form-control" name="venue" 
                                       placeholder="e.g., The Grand Ballroom, Taj Palace, Mumbai" required>
                            </div>
                        </div>
                        
                        <!-- Info -->
                        <div style="background: linear-gradient(135deg, rgba(183,110,121,0.05), rgba(201,169,110,0.05)); 
                                    border: 1px solid var(--primary-light); border-radius: var(--radius-md); 
                                    padding: 18px; margin-bottom: 25px;">
                            <div style="display: flex; align-items: flex-start; gap: 12px;">
                                <i class="fas fa-lightbulb" style="color: var(--gold); font-size: 1.2rem; margin-top: 2px;"></i>
                                <div>
                                    <strong style="color: var(--charcoal); font-size: 0.9rem;">What happens next?</strong>
                                    <p style="color: var(--medium-gray); font-size: 0.85rem; margin-bottom: 0; margin-top: 5px;">
                                        After creating your event, you'll browse our curated vendor catalog 
                                        to select catering, decoration, music, and photography services.
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-premium btn-premium-primary flex-grow-1 py-3">
                                Continue to Vendors <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                            <a href="DashboardServlet" class="btn btn-premium btn-premium-outline py-3 px-4">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.getElementById('eventDate').min = new Date().toISOString().split('T')[0];
</script>

<%@ include file="HNF/footer.jsp" %>