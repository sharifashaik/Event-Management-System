<%-- vendor-list.jsp - PREMIUM VENDOR SELECTION --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventify.model.Vendor" %>
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
                        Handpicked for excellence
                    </span>
                    <h2>Select Your Vendors</h2>
                    <p>Choose the perfect team to bring your event to life</p>
                </div>
                <div class="col-auto">
                    <span style="background: rgba(255,255,255,0.15); padding: 8px 20px; border-radius: var(--radius-xl); 
                                 font-weight: 600; font-size: 0.9rem;">
                        Event #<%= session.getAttribute("currentEventId") != null ? session.getAttribute("currentEventId") : "—" %>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        
        <% if (request.getAttribute("errorMsg") != null) { %>
        <div class="alert alert-premium alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-2"></i>
            <%= request.getAttribute("errorMsg") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>
        
        <!-- Category Filter -->
        <div class="d-flex gap-2 flex-wrap mb-4">
            <button class="btn btn-premium btn-premium-primary btn-sm" data-filter="all" 
                    style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-th me-1"></i> All Vendors
            </button>
            <button class="btn btn-premium btn-premium-outline btn-sm" data-filter="CATERING" 
                    style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-utensils me-1"></i> Catering
            </button>
            <button class="btn btn-premium btn-premium-outline btn-sm" data-filter="DECORATION" 
                    style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-palette me-1"></i> Decoration
            </button>
            <button class="btn btn-premium btn-premium-outline btn-sm" data-filter="DJ" 
                    style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-music me-1"></i> DJ & Music
            </button>
            <button class="btn btn-premium btn-premium-outline btn-sm" data-filter="PHOTOGRAPHY" 
                    style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-camera me-1"></i> Photography
            </button>
        </div>
        
        <form action="BookingServlet" method="post" id="vendorSelectionForm">
            <input type="hidden" name="action" value="selectVendors">
            <input type="hidden" name="eventId" value="<%= session.getAttribute("currentEventId") %>">
            
            <div class="row g-4">
                <%
                    List<Vendor> vendors = (List<Vendor>) request.getAttribute("vendors");
                    String[] categoryImages = {
                        "https://images.unsplash.com/photo-1555244162-803834f70033?w=400&q=80",
                        "https://images.unsplash.com/photo-1478146059778-26028b07395a?w=400&q=80",
                        "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&q=80",
                        "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=400&q=80"
                    };
                    if (vendors != null && !vendors.isEmpty()) {
                        for (Vendor v : vendors) {
                            String catLower = v.getCategory().toLowerCase();
                            String imgUrl;
                            switch(v.getCategory()) {
                                case "CATERING": imgUrl = "https://images.unsplash.com/photo-1555244162-803834f70033?w=400&q=80"; break;
                                case "DECORATION": imgUrl = "https://images.unsplash.com/photo-1478146059778-26028b07395a?w=400&q=80"; break;
                                case "DJ": imgUrl = "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&q=80"; break;
                                default: imgUrl = "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=400&q=80"; break;
                            }
                %>
                <div class="col-lg-4 col-md-6 vendor-item" data-category="<%= v.getCategory() %>">
                    <div class="vendor-card-premium" id="vendorCard<%= v.getVendorId() %>">
                        <div class="vendor-image" style="background-image: url('<%= imgUrl %>')">
                            <span class="vendor-badge <%= catLower %>"><%= v.getCategory() %></span>
                            <input type="checkbox" class="vendor-checkbox" 
                                   name="vendorIds" value="<%= v.getVendorId() %>"
                                   data-price="<%= v.getPrice() %>"
                                   onchange="toggleCard(this, <%= v.getVendorId() %>)">
                        </div>
                        <div class="vendor-body">
                            <h5 class="vendor-name"><%= v.getVendorName() %></h5>
                            <p class="vendor-desc">
                                <%= v.getDescription() != null ? v.getDescription() : "Premium " + catLower + " service for your event" %>
                            </p>
                            <div class="vendor-rating">
                                <span class="stars">
                                    <% for (int i = 1; i <= 5; i++) {
                                        if (i <= v.getRating()) { %>
                                            <i class="fas fa-star"></i>
                                    <%  } else { %>
                                            <i class="far fa-star"></i>
                                    <%  }
                                    } %>
                                </span>
                                <span class="rating-text">(<%= v.getRating() %>)</span>
                            </div>
                            <div class="vendor-footer">
                                <div class="vendor-price">
                                    ₹<%= String.format("%,.0f", v.getPrice()) %>
                                    <span>/ event</span>
                                </div>
                                <i class="fas fa-phone" style="color: var(--medium-gray); font-size: 0.85rem;" 
                                   title="<%= v.getContactPhone() %>"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="col-12 text-center py-5">
                    <i class="fas fa-store-slash fa-3x" style="color: var(--medium-gray); margin-bottom: 15px;"></i>
                    <h4 style="color: var(--medium-gray);">No vendors available</h4>
                    <p style="color: var(--medium-gray);">Please check back later.</p>
                </div>
                <% } %>
            </div>
            
            <% if (vendors != null && !vendors.isEmpty()) { %>
            <!-- Sticky Bottom Bar -->
            <div style="position: sticky; bottom: 20px; z-index: 100; margin-top: 30px;">
                <div style="background: var(--white); border-radius: var(--radius-lg); box-shadow: var(--shadow-xl); 
                            padding: 20px 30px; border: 1px solid rgba(0,0,0,0.06);">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div style="width: 45px; height: 45px; border-radius: var(--radius-full); 
                                            background: var(--primary-gradient); display: flex; align-items: center; 
                                            justify-content: center; color: white;">
                                    <i class="fas fa-calculator"></i>
                                </div>
                                <div>
                                    <div style="font-size: 0.8rem; color: var(--medium-gray); text-transform: uppercase; 
                                                letter-spacing: 1px; font-weight: 600;">Estimated Total</div>
                                    <div id="totalPrice" style="font-family: var(--font-heading); font-size: 1.8rem; 
                                                                font-weight: 700; color: var(--primary);">₹0</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 text-md-end mt-3 mt-md-0">
                            <button type="submit" class="btn btn-premium btn-premium-success btn-lg">
                                <i class="fas fa-check-circle me-2"></i>View Booking Summary
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </form>
    </div>
</main>

<script>
function toggleCard(checkbox, vendorId) {
    var card = document.getElementById('vendorCard' + vendorId);
    if (checkbox.checked) {
        card.classList.add('selected');
    } else {
        card.classList.remove('selected');
    }
    updateTotal();
}

function updateTotal() {
    var total = 0;
    document.querySelectorAll('.vendor-checkbox:checked').forEach(function(cb) {
        total += parseFloat(cb.getAttribute('data-price'));
    });
    document.getElementById('totalPrice').textContent = '₹' + total.toLocaleString('en-IN');
}

// Filter functionality
document.querySelectorAll('[data-filter]').forEach(function(btn) {
    btn.addEventListener('click', function() {
        document.querySelectorAll('[data-filter]').forEach(function(b) {
            b.classList.remove('btn-premium-primary');
            b.classList.add('btn-premium-outline');
        });
        this.classList.remove('btn-premium-outline');
        this.classList.add('btn-premium-primary');
        
        var filter = this.getAttribute('data-filter');
        document.querySelectorAll('.vendor-item').forEach(function(item) {
            item.style.display = (filter === 'all' || item.getAttribute('data-category') === filter) ? 'block' : 'none';
        });
    });
});
</script>

<%@ include file="HNF/footer.jsp" %>