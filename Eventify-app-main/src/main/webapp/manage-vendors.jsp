<%-- manage-vendors.jsp - PREMIUM ADMIN VENDOR MANAGEMENT --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventify.model.Vendor" %>
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
                    <h2><i class="fas fa-store me-2"></i>Manage Vendors</h2>
                    <p>Approve, reject, and manage all vendor profiles</p>
                </div>
                <div class="col-auto d-flex gap-2">
                    <a href="AdminDashboardServlet" class="btn btn-premium" 
                       style="background: rgba(255,255,255,0.15); color: white; border: 1px solid rgba(255,255,255,0.3);">
                        <i class="fas fa-arrow-left me-1"></i> Back
                    </a>
                    <button class="btn btn-premium btn-premium-white" data-bs-toggle="modal" data-bs-target="#addVendorModal">
                        <i class="fas fa-plus me-1"></i> Add Vendor
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        
        <!-- Filters -->
        <div class="d-flex gap-2 flex-wrap mb-4">
            <a href="AdminVendorServlet?action=list" class="btn btn-premium btn-premium-primary" style="padding: 8px 20px; font-size: 0.85rem;">All</a>
            <a href="AdminVendorServlet?action=list&filter=PENDING" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-clock me-1"></i> Pending
            </a>
            <a href="AdminVendorServlet?action=list&filter=APPROVED" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-check me-1"></i> Approved
            </a>
            <a href="AdminVendorServlet?action=list&filter=REJECTED" class="btn btn-premium btn-premium-outline" style="padding: 8px 20px; font-size: 0.85rem;">
                <i class="fas fa-times me-1"></i> Rejected
            </a>
        </div>
        
        <div class="table-premium-wrapper">
            <div class="table-responsive">
                <table class="table table-premium">
                    <thead>
                        <tr>
                            <th>ID</th><th>Vendor</th><th>Category</th>
                            <th>Price</th><th>Rating</th><th>Status</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Vendor> vendors = (List<Vendor>) request.getAttribute("vendors");
                            if (vendors != null && !vendors.isEmpty()) {
                                for (Vendor v : vendors) {
                        %>
                        <tr>
                            <td><strong>#<%= v.getVendorId() %></strong></td>
                            <td>
                                <strong style="color: var(--charcoal);"><%= v.getVendorName() %></strong><br>
                                <small style="color: var(--medium-gray);"><%= v.getContactEmail() %></small>
                            </td>
                            <td>
                                <span class="badge-premium" style="background: rgba(183,110,121,0.1); color: var(--primary);">
                                    <%= v.getCategory() %>
                                </span>
                            </td>
                            <td style="font-family: var(--font-heading); font-weight: 700;">
                                ₹<%= String.format("%,.0f", v.getPrice()) %>
                            </td>
                            <td>
                                <i class="fas fa-star" style="color: var(--gold);"></i> 
                                <strong><%= v.getRating() %></strong>
                            </td>
                            <td>
                                <% String vs = v.getApprovalStatus();
                                   String vc = "pending";
                                   if ("APPROVED".equals(vs)) vc = "approved";
                                   else if ("REJECTED".equals(vs)) vc = "rejected"; %>
                                <span class="badge-premium badge-<%= vc %>"><%= vs %></span>
                            </td>
                            <td>
                                <form action="AdminVendorServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="vendorId" value="<%= v.getVendorId() %>">
                                    
                                    <% if (!"APPROVED".equals(vs)) { %>
                                    <button type="submit" name="action" value="approve" 
                                            class="btn btn-premium btn-premium-success" 
                                            style="padding: 4px 10px; font-size: 0.8rem;"
                                            onclick="return confirm('Approve this vendor?')">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <% } %>
                                    
                                    <% if (!"REJECTED".equals(vs)) { %>
                                    <button type="submit" name="action" value="reject" 
                                            class="btn btn-premium" 
                                            style="padding: 4px 10px; font-size: 0.8rem; background: var(--warning); color: white;"
                                            onclick="return confirm('Reject this vendor?')">
                                        <i class="fas fa-times"></i>
                                    </button>
                                    <% } %>
                                    
                                    <button type="submit" name="action" value="delete" 
                                            class="btn btn-premium btn-premium-danger" 
                                            style="padding: 4px 10px; font-size: 0.8rem;"
                                            onclick="return confirm('DELETE this vendor permanently?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center" style="padding: 40px; color: var(--medium-gray);">
                                No vendors found
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<!-- Add Vendor Modal -->
<div class="modal fade" id="addVendorModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border: none; border-radius: var(--radius-lg);">
            <div class="modal-header border-0" style="padding: 25px 30px 10px;">
                <h5 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal);">
                    <i class="fas fa-plus-circle me-2" style="color: var(--primary);"></i>Add New Vendor
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="AdminVendorServlet" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-body" style="padding: 20px 30px;">
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 600;">Vendor Name</label>
                        <input type="text" class="form-control" name="vendorName" required 
                               placeholder="Enter vendor name" style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 600;">Category</label>
                        <select class="form-select" name="category" required 
                                style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;">
                            <option value="CATERING">Catering</option>
                            <option value="DECORATION">Decoration</option>
                            <option value="DJ">DJ</option>
                            <option value="PHOTOGRAPHY">Photography</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 600;">Description</label>
                        <textarea class="form-control" name="description" rows="2" 
                                  style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" style="font-weight: 600;">Price (₹)</label>
                        <input type="number" class="form-control" name="price" required min="1000" 
                               style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;">
                    </div>
                    <div class="row g-3">
                        <div class="col-6">
                            <label class="form-label" style="font-weight: 600;">Email</label>
                            <input type="email" class="form-control" name="contactEmail" required 
                                   style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;">
                        </div>
                        <div class="col-6">
                            <label class="form-label" style="font-weight: 600;">Phone</label>
                            <input type="tel" class="form-control" name="contactPhone" required pattern="[0-9]{10}" 
                                   style="border: 2px solid var(--pearl); border-radius: var(--radius-md); padding: 12px;">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0" style="padding: 10px 30px 25px;">
                    <button type="button" class="btn btn-premium btn-premium-outline" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-premium btn-premium-primary">
                        <i class="fas fa-save me-1"></i> Add Vendor
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="HNF/footer.jsp" %>