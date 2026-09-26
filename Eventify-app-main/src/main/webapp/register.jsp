<%-- register.jsp - PREMIUM REGISTRATION --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main>
    <section class="section-premium section-cream" style="padding-top: 60px;">
        <div class="container">
            <div class="row justify-content-center align-items-center min-vh-75">
                
                <!-- Left Side - Image & Info -->
                <div class="col-lg-6 d-none d-lg-block pe-5">
                    <div style="position: relative;">
                        <img src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=600&q=80" 
                             alt="Elegant Event" 
                             style="width: 100%; border-radius: var(--radius-lg); box-shadow: var(--shadow-xl);">
                        
                        <!-- Floating Stats Card -->
                        <div style="position: absolute; bottom: -30px; right: -30px; background: var(--white); 
                                    border-radius: var(--radius-lg); padding: 25px 35px; box-shadow: var(--shadow-lg);">
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div style="width: 50px; height: 50px; border-radius: var(--radius-full); 
                                            background: var(--primary-gradient); display: flex; align-items: center; 
                                            justify-content: center; color: white; font-size: 1.2rem;">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div>
                                    <div style="font-family: var(--font-heading); font-size: 1.5rem; 
                                                font-weight: 700; color: var(--charcoal);">2,500+</div>
                                    <div style="font-size: 0.85rem; color: var(--medium-gray);">Happy Events</div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Floating Rating Card -->
                        <div style="position: absolute; top: 30px; left: -20px; background: var(--white); 
                                    border-radius: var(--radius-lg); padding: 20px 25px; box-shadow: var(--shadow-lg);">
                            <div style="color: var(--gold); margin-bottom: 5px;">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <div style="font-size: 0.8rem; color: var(--medium-gray);">4.9/5 Client Rating</div>
                        </div>
                    </div>
                </div>
                
                <!-- Right Side - Form -->
                <div class="col-lg-5 col-md-8">
                    <div class="form-premium">
                        <div class="text-center mb-4">
                            <div style="width: 60px; height: 60px; border-radius: var(--radius-full); 
                                        background: var(--primary-gradient); display: inline-flex; 
                                        align-items: center; justify-content: center; color: white; font-size: 1.3rem;">
                                <i class="fas fa-user-plus"></i>
                            </div>
                        </div>
                        
                        <h2 class="form-premium-title">Join SmartEvent</h2>
                        <p class="form-premium-subtitle">Create your account and start planning</p>
                        
                        <% if (request.getAttribute("errorMsg") != null) { %>
                        <div class="alert alert-premium alert-danger alert-dismissible fade show">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <%= request.getAttribute("errorMsg") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>
                        
                        <form action="RegisterServlet" method="post" id="registerForm">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <div class="form-icon-wrapper">
                                    <i class="fas fa-user form-icon"></i>
                                    <input type="text" class="form-control" name="fullName" 
                                           placeholder="Enter your full name" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <div class="form-icon-wrapper">
                                    <i class="fas fa-envelope form-icon"></i>
                                    <input type="email" class="form-control" name="email" 
                                           placeholder="you@example.com" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Phone Number</label>
                                <div class="form-icon-wrapper">
                                    <i class="fas fa-phone form-icon"></i>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="10-digit mobile number" required 
                                           pattern="[0-9]{10}" maxlength="10">
                                </div>
                            </div>
                            
                            <div class="row g-3 mb-3">
                                <div class="col-6">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" 
                                           name="password" placeholder="Min 6 chars" required minlength="6">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Confirm</label>
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           name="confirmPassword" placeholder="Re-enter" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="terms" required 
                                           style="accent-color: var(--primary);">
                                    <label class="form-check-label" for="terms" style="font-size: 0.85rem; color: var(--medium-gray);">
                                        I agree to the <a href="#" style="color: var(--primary);">Terms</a> & 
                                        <a href="#" style="color: var(--primary);">Privacy Policy</a>
                                    </label>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-premium btn-premium-primary w-100 py-3" 
                                    style="font-size: 1rem;">
                                <i class="fas fa-sparkles me-2"></i>Create Account
                            </button>
                        </form>
                        
                        <div class="form-divider">or</div>
                        
                        <p class="text-center mb-0" style="color: var(--medium-gray); font-size: 0.95rem;">
                            Already have an account? 
                            <a href="login.jsp" style="color: var(--primary); font-weight: 600; text-decoration: none;">
                                Sign In
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="HNF/footer.jsp" %>