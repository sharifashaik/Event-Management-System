<%-- payment.jsp - PREMIUM PAYMENT --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null) { response.sendRedirect("login.jsp"); return; }
    String eventId = request.getParameter("eventId");
    String totalAmount = request.getParameter("totalAmount");
    if (eventId == null) eventId = (String) session.getAttribute("currentEventId");
    if (totalAmount == null) totalAmount = "0";
%>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main style="background: var(--cream); padding-bottom: 60px;">
    
    <div class="page-header-premium">
        <div class="container">
            <span style="font-family: var(--font-script); font-size: 1.2rem; color: var(--gold-light);">
                Final step
            </span>
            <h2>Secure Payment</h2>
            <p>Complete your payment to confirm the booking</p>
        </div>
    </div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="form-premium">
                    
                    <!-- Amount Display -->
                    <div class="total-display-premium" style="margin-bottom: 30px;">
                        <div style="font-size: 0.8rem; color: var(--medium-gray); text-transform: uppercase; 
                                    letter-spacing: 1.5px; font-weight: 600; margin-bottom: 5px;">Amount to Pay</div>
                        <div class="total-amount">₹<%= totalAmount %></div>
                    </div>
                    
                    <% if (request.getAttribute("errorMsg") != null) { %>
                    <div class="alert alert-premium alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("errorMsg") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>
                    
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="eventId" value="<%= eventId %>">
                        <input type="hidden" name="amount" value="<%= totalAmount %>">
                        
                        <!-- Payment Method -->
                        <div class="mb-4">
                            <label class="form-label" style="font-weight: 700; margin-bottom: 15px;">
                                <i class="fas fa-wallet me-1" style="color: var(--gold);"></i> 
                                Select Payment Method
                            </label>
                            
                            <div class="row g-3 mb-3">
                                <div class="col-4">
                                    <div class="payment-method-option" onclick="selectPayment(this, 'CARD')">
                                        <div class="method-icon"><i class="fas fa-credit-card"></i></div>
                                        <div class="method-name">Card</div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="payment-method-option" onclick="selectPayment(this, 'UPI')">
                                        <div class="method-icon"><i class="fas fa-mobile-alt"></i></div>
                                        <div class="method-name">UPI</div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="payment-method-option" onclick="selectPayment(this, 'NETBANKING')">
                                        <div class="method-icon"><i class="fas fa-university"></i></div>
                                        <div class="method-name">Bank</div>
                                    </div>
                                </div>
                            </div>
                            
                            <select class="form-select" id="paymentMethod" name="paymentMethod" required 
                                    style="display: none;">
                                <option value="" selected>Select method above</option>
                                <option value="CARD">Card</option>
                                <option value="UPI">UPI</option>
                                <option value="NETBANKING">Net Banking</option>
                            </select>
                        </div>
                        
                        <!-- Card Details -->
                        <div id="cardDetails" style="display: none;">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 25px; margin-bottom: 20px;">
                                <h6 style="font-family: var(--font-heading); font-weight: 700; margin-bottom: 18px; color: var(--charcoal);">
                                    <i class="fas fa-credit-card me-2" style="color: var(--primary);"></i>Card Details
                                </h6>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Card Number" maxlength="19" 
                                           style="background: white;">
                                </div>
                                <div class="row g-3">
                                    <div class="col-6">
                                        <input type="text" class="form-control" placeholder="MM/YY" maxlength="5" 
                                               style="background: white;">
                                    </div>
                                    <div class="col-6">
                                        <input type="password" class="form-control" placeholder="CVV" maxlength="4" 
                                               style="background: white;">
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <input type="text" class="form-control" placeholder="Cardholder Name" 
                                           style="background: white;">
                                </div>
                            </div>
                        </div>
                        
                        <!-- UPI Details -->
                        <div id="upiDetails" style="display: none;">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 25px; margin-bottom: 20px;">
                                <h6 style="font-family: var(--font-heading); font-weight: 700; margin-bottom: 18px; color: var(--charcoal);">
                                    <i class="fas fa-mobile-alt me-2" style="color: var(--primary);"></i>UPI Payment
                                </h6>
                                <input type="text" class="form-control" placeholder="yourname@upi" style="background: white;">
                            </div>
                        </div>
                        
                        <!-- NetBanking -->
                        <div id="netbankingDetails" style="display: none;">
                            <div style="background: var(--pearl); border-radius: var(--radius-md); padding: 25px; margin-bottom: 20px;">
                                <h6 style="font-family: var(--font-heading); font-weight: 700; margin-bottom: 18px; color: var(--charcoal);">
                                    <i class="fas fa-university me-2" style="color: var(--primary);"></i>Net Banking
                                </h6>
                                <select class="form-select" style="background: white;">
                                    <option disabled selected>Select your bank</option>
                                    <option>State Bank of India</option>
                                    <option>HDFC Bank</option>
                                    <option>ICICI Bank</option>
                                    <option>Axis Bank</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Security Badge -->
                        <div class="text-center mb-4">
                            <div style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 20px; 
                                        background: var(--success-light); border-radius: var(--radius-xl); font-size: 0.85rem;">
                                <i class="fas fa-shield-alt" style="color: var(--success);"></i>
                                <span style="color: var(--success); font-weight: 500;">256-bit SSL Encrypted</span>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-premium btn-premium-success w-100 py-3" 
                                style="font-size: 1.1rem;"
                                onclick="return confirm('Confirm payment of ₹<%= totalAmount %>?')">
                            <i class="fas fa-lock me-2"></i>Pay ₹<%= totalAmount %>
                        </button>
                        
                        <a href="VendorServlet?action=list&eventId=<%= eventId %>" 
						   class="btn btn-premium btn-premium-outline w-100" style="margin-top: 10px;">
						    <i class="fas fa-arrow-left me-1"></i> Back
						</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
function selectPayment(element, method) {
    document.querySelectorAll('.payment-method-option').forEach(function(opt) {
        opt.classList.remove('selected');
    });
    element.classList.add('selected');
    document.getElementById('paymentMethod').value = method;
    
    document.getElementById('cardDetails').style.display = 'none';
    document.getElementById('upiDetails').style.display = 'none';
    document.getElementById('netbankingDetails').style.display = 'none';
    
    if (method === 'CARD') document.getElementById('cardDetails').style.display = 'block';
    if (method === 'UPI') document.getElementById('upiDetails').style.display = 'block';
    if (method === 'NETBANKING') document.getElementById('netbankingDetails').style.display = 'block';
}
</script>

<%@ include file="HNF/footer.jsp" %>