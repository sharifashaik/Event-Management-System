<%-- login.jsp - PREMIUM LOGIN --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main>
    <section class="section-premium section-cream" style="padding-top: 60px;">
        <div class="container">
            <div class="row justify-content-center align-items-center min-vh-75">
                
                <!-- Left - Form -->
                <div class="col-lg-5 col-md-8 order-lg-1 order-2">
                    <div class="form-premium">
                        <div class="text-center mb-4">
                            <div style="width: 60px; height: 60px; border-radius: var(--radius-full); 
                                        background: var(--primary-gradient); display: inline-flex; 
                                        align-items: center; justify-content: center; color: white; font-size: 1.3rem;">
                                <i class="fas fa-lock"></i>
                            </div>
                        </div>
                        
                        <h2 class="form-premium-title">Welcome Back</h2>
                        <p class="form-premium-subtitle">Sign in to manage your celebrations</p>
                        
                        <% if ("true".equals(request.getParameter("registered"))) { %>
                        <div class="alert alert-premium alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle me-2"></i>
                            Account created successfully! Please sign in.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>
                        
                        <% if (request.getAttribute("errorMsg") != null) { %>
                        <div class="alert alert-premium alert-danger alert-dismissible fade show">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <%= request.getAttribute("errorMsg") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>
                        
                        <form action="Login" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <div class="form-icon-wrapper">
                                    <i class="fas fa-envelope form-icon"></i>
                                    <input type="email" class="form-control" name="email" 
                                           placeholder="you@example.com" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <div class="form-icon-wrapper">
                                    <i class="fas fa-lock form-icon"></i>
                                    <input type="password" class="form-control" name="password" 
                                           placeholder="Enter your password" required>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="remember" 
                                           style="accent-color: var(--primary);">
                                    <label class="form-check-label" for="remember" 
                                           style="font-size: 0.85rem; color: var(--medium-gray);">
                                        Remember me
                                    </label>
                                </div>
                                <a href="#" style="color: var(--primary); font-size: 0.85rem; 
                                                   text-decoration: none; font-weight: 500;">
                                    Forgot Password?
                                </a>
                            </div>
                            
                            <button type="submit" class="btn btn-premium btn-premium-primary w-100 py-3" 
                                    style="font-size: 1rem;">
                                <i class="fas fa-sign-in-alt me-2"></i>Sign In
                            </button>
                        </form>
                        
                        <div class="form-divider">or</div>
                        
                        <!-- Demo Credentials -->
                        <div style="background: linear-gradient(135deg, rgba(183,110,121,0.05), rgba(201,169,110,0.05)); 
                                    border: 1px dashed var(--primary-light); border-radius: var(--radius-md); 
                                    padding: 15px; margin-bottom: 20px;">
                            <p style="font-size: 0.8rem; color: var(--medium-gray); margin-bottom: 5px;">
                                <i class="fas fa-info-circle me-1" style="color: var(--primary);"></i>
                                <strong>Demo Admin Access:</strong>
                            </p>
                            <p style="font-size: 0.8rem; color: var(--dark-gray); margin-bottom: 0; font-family: monospace;">
                                admin@smartevent.com / admin123
                            </p>
                        </div>
                        
                        <p class="text-center mb-0" style="color: var(--medium-gray); font-size: 0.95rem;">
                            New to Eventify? 
                            <a href="register.jsp" style="color: var(--primary); font-weight: 600; text-decoration: none;">
                                Create Account
                            </a>
                        </p>
                    </div>
                </div>
                
                <!-- Right - Image -->
                <div class="col-lg-6 d-none d-lg-block order-lg-2 order-1 ps-5">
                    <div style="position: relative;">
                        <img src="https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=600&q=80" 
                             alt="Celebration" 
                             style="width: 100%; border-radius: var(--radius-lg); box-shadow: var(--shadow-xl);">
                        
                        <div style="position: absolute; bottom: -25px; left: -25px; background: var(--white); 
                                    border-radius: var(--radius-lg); padding: 20px 30px; box-shadow: var(--shadow-lg);">
                            <div style="font-family: var(--font-script); font-size: 1.3rem; color: var(--primary);">
                                Trusted by
                            </div>
                            <div style="font-family: var(--font-heading); font-size: 1.8rem; 
                                        font-weight: 700; color: var(--charcoal);">
                                10,000+ Clients
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="HNF/footer.jsp" %>