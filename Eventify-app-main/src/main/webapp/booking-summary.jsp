<%-- booking-summary.jsp - PREMIUM BOOKING SUMMARY --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eventify.model.Event" %>
<%@ page import="com.eventify.model.Vendor" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null) { response.sendRedirect("login.jsp"); return; }

    /* ── Pull request attributes set by BookingServlet ── */
    Event event = (Event) request.getAttribute("event");
    List<Vendor> selectedVendors = (List<Vendor>) request.getAttribute("selectedVendors");

    /* ── Calculate totals ONCE, at the top ── */
    double totalPrice = 0;
    if (selectedVendors != null) {
        for (Vendor v : selectedVendors) {
            totalPrice += v.getPrice();
        }
    }
    double gst        = totalPrice * 0.18;
    double grandTotal = totalPrice + gst;

    /* ── Safe eventId for links ── */
    String eventIdStr = (event != null)
        ? String.valueOf(event.getEventId())
        : (String) session.getAttribute("currentEventId");
    if (eventIdStr == null) eventIdStr = "";
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
                        Almost there
                    </span>
                    <h2>Booking Summary</h2>
                    <p>Review your selections before proceeding to payment</p>
                </div>
                <div class="col-auto">
                    <span style="background: rgba(255,255,255,0.15); padding: 8px 20px;
                                 border-radius: var(--radius-xl); font-weight: 600; font-size: 0.9rem;">
                        Event #<%= eventIdStr.isEmpty() ? "—" : eventIdStr %>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="container">

        <!-- Error message -->
        <% if (request.getAttribute("errorMsg") != null) { %>
        <div class="alert alert-premium alert-danger alert-dismissible fade show mb-4">
            <i class="fas fa-exclamation-circle me-2"></i>
            <%= request.getAttribute("errorMsg") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Guard: no data in request (e.g. user refreshed the page) -->
        <% if (event == null || selectedVendors == null) { %>
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center py-5">
                <div style="font-size: 4rem; margin-bottom: 20px;">⚠️</div>
                <h4 style="color: var(--charcoal); margin-bottom: 10px;">Session Expired</h4>
                <p style="color: var(--medium-gray); margin-bottom: 25px;">
                    Your booking data is no longer available. This usually happens when you 
                    refresh the page. Please start over.
                </p>
                <a href="create-event.jsp" class="btn btn-premium btn-premium-primary me-2">
                    <i class="fas fa-redo me-1"></i> Start Over
                </a>
                <a href="MyEventsServlet" class="btn btn-premium btn-premium-outline">
                    <i class="fas fa-list me-1"></i> My Events
                </a>
            </div>
        </div>
        <% } else { %>

        <div class="row g-4">

            <!-- ═══ LEFT COLUMN ═══ -->
            <div class="col-lg-8">

                <!-- Event Details Card -->
                <div class="summary-card-premium">
                    <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal);
                               margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--pearl);">
                        <i class="fas fa-calendar-alt me-2" style="color: var(--primary);"></i>Event Details
                    </h4>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 18px;">
                                <div style="font-size: 0.75rem; color: var(--medium-gray); text-transform: uppercase;
                                            letter-spacing: 1px; font-weight: 600; margin-bottom: 5px;">Event Type</div>
                                <div style="font-family: var(--font-heading); font-size: 1.1rem; font-weight: 700; color: var(--charcoal);">
                                    <% String et = event.getEventType(); %>
                                    <% if ("MARRIAGE".equals(et))   { %>💒 Wedding
                                    <% } else if ("BIRTHDAY".equals(et))    { %>🎂 Birthday
                                    <% } else if ("ANNIVERSARY".equals(et)) { %>🥂 Anniversary
                                    <% } else { %>💼 Corporate<% } %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 18px;">
                                <div style="font-size: 0.75rem; color: var(--medium-gray); text-transform: uppercase;
                                            letter-spacing: 1px; font-weight: 600; margin-bottom: 5px;">Date</div>
                                <div style="font-family: var(--font-heading); font-size: 1.1rem; font-weight: 700; color: var(--charcoal);">
                                    <i class="fas fa-calendar-day me-1" style="color: var(--primary);"></i>
                                    <%= event.getEventDate() %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 18px;">
                                <div style="font-size: 0.75rem; color: var(--medium-gray); text-transform: uppercase;
                                            letter-spacing: 1px; font-weight: 600; margin-bottom: 5px;">Venue</div>
                                <div style="font-weight: 600; color: var(--charcoal);">
                                    <i class="fas fa-map-marker-alt me-1" style="color: var(--danger);"></i>
                                    <%= event.getVenue() %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 18px;">
                                <div style="font-size: 0.75rem; color: var(--medium-gray); text-transform: uppercase;
                                            letter-spacing: 1px; font-weight: 600; margin-bottom: 5px;">Guests</div>
                                <div style="font-weight: 600; color: var(--charcoal);">
                                    <i class="fas fa-users me-1" style="color: var(--info);"></i>
                                    <%= event.getGuestCount() %> people
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Selected Vendors Card -->
                <div class="summary-card-premium">
                    <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal);
                               margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--pearl);">
                        <i class="fas fa-store me-2" style="color: var(--primary);"></i>
                        Selected Vendors
                        <span style="font-size: 0.85rem; font-weight: 500; color: var(--medium-gray); margin-left: 8px;">
                            (<%= selectedVendors.size() %> selected)
                        </span>
                    </h4>

                    <% if (!selectedVendors.isEmpty()) { %>
                    <div class="table-premium-wrapper" style="box-shadow: none; border: 1px solid var(--pearl);">
                        <table class="table table-premium mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Vendor</th>
                                    <th>Category</th>
                                    <th>Rating</th>
                                    <th class="text-end">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int count = 1;
                                   for (Vendor v : selectedVendors) { %>
                                <tr>
                                    <td><strong><%= count++ %></strong></td>
                                    <td style="font-weight: 600;"><%= v.getVendorName() %></td>
                                    <td>
                                        <span class="badge-premium badge-approved"
                                              style="background: rgba(183,110,121,0.1); color: var(--primary);">
                                            <%= v.getCategory() %>
                                        </span>
                                    </td>
                                    <td>
                                        <i class="fas fa-star" style="color: var(--gold);"></i>
                                        <strong><%= v.getRating() %></strong>
                                    </td>
                                    <td class="text-end"
                                        style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal);">
                                        ₹<%= String.format("%,.0f", v.getPrice()) %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr style="background: var(--pearl);">
                                    <td colspan="4" style="font-weight: 700; font-family: var(--font-heading);">Subtotal</td>
                                    <td class="text-end" style="font-weight: 700; font-family: var(--font-heading); color: var(--charcoal);">
                                        ₹<%= String.format("%,.0f", totalPrice) %>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <% } else { %>
                    <div class="text-center py-4">
                        <i class="fas fa-store-slash fa-2x" style="color: var(--medium-gray); margin-bottom: 10px;"></i>
                        <p style="color: var(--medium-gray); margin: 0;">No vendors selected.</p>
                    </div>
                    <% } %>
                </div>

            </div><!-- /col-lg-8 -->

            <!-- ═══ RIGHT COLUMN — Price Summary ═══ -->
            <div class="col-lg-4">
                <div class="summary-card-premium" style="position: sticky; top: 100px;">
                    <h4 style="font-family: var(--font-heading); font-weight: 700; color: var(--charcoal);
                               margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--pearl);">
                        <i class="fas fa-receipt me-2" style="color: var(--primary);"></i>Price Summary
                    </h4>

                    <!-- Per-vendor breakdown -->
                    <% for (Vendor v : selectedVendors) { %>
                    <div class="d-flex justify-content-between mb-2">
                        <span style="color: var(--medium-gray); font-size: 0.9rem;">
                            <%= v.getCategory() %>
                            <span style="font-size: 0.8rem; color: var(--medium-gray);">
                                — <%= v.getVendorName() %>
                            </span>
                        </span>
                        <span style="font-weight: 500; white-space: nowrap; margin-left: 10px;">
                            ₹<%= String.format("%,.0f", v.getPrice()) %>
                        </span>
                    </div>
                    <% } %>

                    <hr style="border-color: var(--pearl); margin: 15px 0;">

                    <!-- Subtotal -->
                    <div class="d-flex justify-content-between mb-2">
                        <span style="color: var(--medium-gray);">Subtotal</span>
                        <span style="font-weight: 600;">₹<%= String.format("%,.0f", totalPrice) %></span>
                    </div>

                    <!-- GST -->
                    <div class="d-flex justify-content-between mb-2">
                        <span style="color: var(--medium-gray); font-size: 0.9rem;">GST (18%)</span>
                        <span style="font-size: 0.9rem;">₹<%= String.format("%,.0f", gst) %></span>
                    </div>

                    <hr style="border-color: var(--pearl); margin: 15px 0;">

                    <!-- Grand Total -->
                    <div class="total-display-premium" style="margin-top: 15px;">
                        <div style="font-size: 0.8rem; color: var(--medium-gray); text-transform: uppercase;
                                    letter-spacing: 1.5px; font-weight: 600; margin-bottom: 5px;">Total Amount</div>
                        <div class="total-amount">₹<%= String.format("%,.0f", grandTotal) %></div>
                    </div>

                    <!-- Proceed to Payment -->
                    <a href="payment.jsp?eventId=<%= eventIdStr %>&totalAmount=<%= String.format("%.0f", grandTotal) %>"
                       class="btn btn-premium btn-premium-success w-100 py-3"
                       style="margin-top: 20px; font-size: 1rem;">
                        <i class="fas fa-credit-card me-2"></i>Proceed to Payment
                    </a>

                    <!-- Change Vendors — preserves eventId so VendorServlet works correctly -->
                    <a href="VendorServlet?action=list&eventId=<%= eventIdStr %>"
                       class="btn btn-premium btn-premium-outline w-100"
                       style="margin-top: 10px;">
                        <i class="fas fa-arrow-left me-1"></i> Change Vendors
                    </a>
                </div>
            </div><!-- /col-lg-4 -->

        </div><!-- /row -->
        <% } /* end null guard */ %>

    </div><!-- /container -->
</main>

<%@ include file="HNF/footer.jsp" %>
