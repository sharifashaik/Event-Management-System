<%-- index.jsp - PREMIUM HOME PAGE --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="HNF/header.jsp" %>
<%@ include file="HNF/navbar.jsp" %>

<main>
    <!-- ═══════ HERO SECTION ═══════ -->
    <section class="hero-premium">
        <div class="hero-bg"></div>
        <div class="hero-overlay"></div>
        
        <div class="container">
            <div class="row">
                <div class="col-lg-7 hero-content">
                    <span class="hero-tagline">Where Dreams Meet Reality</span>
                    <h1 class="hero-title">
                        Craft Your<br>
                        <span class="highlight">Unforgettable</span><br>
                        Celebrations
                    </h1>
                    <p class="hero-description">
                        From intimate gatherings to grand celebrations, we curate 
                        bespoke events that tell your unique story. Let our expert 
                        planners and premium vendors bring your vision to life.
                    </p>
                    <div class="hero-buttons">
                        <a href="create-event.jsp" class="btn-hero-primary">
                            <i class="fas fa-sparkles"></i> Start Planning
                        </a>
                        <a href="#events" class="btn-hero-outline">
                            <i class="fas fa-play-circle"></i> Explore Events
                        </a>
                    </div>
                    
                    <div class="hero-stats">
                        <div class="hero-stat">
                            <div class="hero-stat-number">2,500+</div>
                            <div class="hero-stat-label">Events Crafted</div>
                        </div>
                        <div class="hero-stat">
                            <div class="hero-stat-number">150+</div>
                            <div class="hero-stat-label">Elite Vendors</div>
                        </div>
                        <div class="hero-stat">
                            <div class="hero-stat-number">98%</div>
                            <div class="hero-stat-label">Happy Hearts</div>
                        </div>
                        <div class="hero-stat">
                            <div class="hero-stat-number">50+</div>
                            <div class="hero-stat-label">Cities</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="hero-scroll-indicator">
            <a href="#events"><i class="fas fa-chevron-down"></i></a>
        </div>
    </section>

    <!-- ═══════ EVENT TYPES SECTION ═══════ -->
    <section id="events" class="section-premium section-cream">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Our Expertise</span>
                <h2 class="section-title">Events We Specialize In</h2>
                <p class="section-subtitle">
                    Every celebration deserves to be extraordinary. Choose your 
                    occasion and let us handle the magic.
                </p>
                <div class="section-divider"></div>
            </div>
            
            <div class="row g-4">
                <!-- Marriage -->
                <div class="col-lg-3 col-md-6">
                    <div class="event-type-card">
                        <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1519741497674-611481863552?w=600&q=80')"></div>
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <div class="card-icon">
                                <i class="fas fa-heart"></i>
                            </div>
                            <h3 class="card-title">Weddings</h3>
                            <p class="card-text">Your fairy tale begins here</p>
                            <p class="card-price">From ₹50,000</p>
                        </div>
                        <a href="<%= session.getAttribute("userId") != null ? "create-event.jsp?eventType=MARRIAGE" : "login.jsp" %>"  class="card-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Birthday -->
                <div class="col-lg-3 col-md-6">
                    <div class="event-type-card">
                        <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=600&q=80')"></div>
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <div class="card-icon">
                                <i class="fas fa-birthday-cake"></i>
                            </div>
                            <h3 class="card-title">Birthdays</h3>
                            <p class="card-text">Celebrate every milestone</p>
                            <p class="card-price">From ₹15,000</p>
                        </div>
                        <a href="<%= session.getAttribute("userId") != null ? "create-event.jsp?eventType=BIRTHDAY" : "login.jsp" %>" class="card-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Anniversary -->
                <div class="col-lg-3 col-md-6">
                    <div class="event-type-card">
                        <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1469371670807-013ccf25f16a?w=600&q=80')"></div>
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <div class="card-icon">
                                <i class="fas fa-glass-cheers"></i>
                            </div>
                            <h3 class="card-title">Anniversaries</h3>
                            <p class="card-text">Relive your love story</p>
                            <p class="card-price">From ₹25,000</p>
                        </div>
                        <a href="<%= session.getAttribute("userId") != null ? "create-event.jsp?eventType=ANNIVERSARY" : "login.jsp" %>" class="card-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Corporate -->
                <div class="col-lg-3 col-md-6">
                    <div class="event-type-card">
                        <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80')"></div>
                        <div class="card-overlay"></div>
                        <div class="card-content">
                            <div class="card-icon">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <h3 class="card-title">Corporate</h3>
                            <p class="card-text">Impress & inspire</p>
                            <p class="card-price">From ₹75,000</p>
                        </div>
                        <a href="<%= session.getAttribute("userId") != null ? "create-event.jsp?eventType=CORPORATE" : "login.jsp" %>" class="card-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ═══════ WHY CHOOSE US ═══════ -->
    <section class="section-premium section-white">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Why Us</span>
                <h2 class="section-title">The Eventify Difference</h2>
                <p class="section-subtitle">
                    We don't just plan events. We craft experiences that 
                    leave lasting impressions.
                </p>
                <div class="section-divider"></div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-gem"></i>
                        </div>
                        <h5 class="feature-title">Curated Vendors</h5>
                        <p class="feature-text">
                            Hand-picked premium vendors vetted for quality, 
                            reliability, and excellence.
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="feature-title">Secure Payments</h5>
                        <p class="feature-text">
                            Bank-grade encryption with multiple payment 
                            options for your peace of mind.
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="feature-title">Dedicated Support</h5>
                        <p class="feature-text">
                            Personal event coordinator available 24/7 
                            from planning to execution.
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <i class="fas fa-award"></i>
                        </div>
                        <h5 class="feature-title">Best Value</h5>
                        <p class="feature-text">
                            Transparent pricing with no hidden costs. 
                            Get premium quality at competitive rates.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ═══════ VENDOR CATEGORIES PREVIEW ═══════ -->
    <section class="section-premium section-cream">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Our Network</span>
                <h2 class="section-title">Premium Vendor Categories</h2>
                <p class="section-subtitle">
                    From world-class caterers to award-winning photographers
                </p>
                <div class="section-divider"></div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="vendor-card-premium">
                        <div class="vendor-image" style="background-image: url('https://images.unsplash.com/photo-1555244162-803834f70033?w=600&q=80')">
                            <span class="vendor-badge catering">Catering</span>
                        </div>
                        <div class="vendor-body">
                            <h5 class="vendor-name">Gourmet Cuisine</h5>
                            <p class="vendor-desc">Multi-cuisine menus crafted by award-winning chefs</p>
                            <div class="vendor-footer">
                                <span class="badge-premium badge-approved">12+ Vendors</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="vendor-card-premium">
                        <div class="vendor-image" style="background-image: url('https://images.unsplash.com/photo-1478146059778-26028b07395a?w=600&q=80')">
                            <span class="vendor-badge decoration">Décor</span>
                        </div>
                        <div class="vendor-body">
                            <h5 class="vendor-name">Luxury Décor</h5>
                            <p class="vendor-desc">Stunning floral and themed decorations</p>
                            <div class="vendor-footer">
                                <span class="badge-premium badge-approved">10+ Vendors</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="vendor-card-premium">
                        <div class="vendor-image" style="background-image: url('https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600&q=80')">
                            <span class="vendor-badge dj">DJ & Music</span>
                        </div>
                        <div class="vendor-body">
                            <h5 class="vendor-name">Entertainment</h5>
                            <p class="vendor-desc">Professional DJs and live music bands</p>
                            <div class="vendor-footer">
                                <span class="badge-premium badge-approved">8+ Vendors</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="vendor-card-premium">
                        <div class="vendor-image" style="background-image: url('https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600&q=80')">
                            <span class="vendor-badge photography">Photography</span>
                        </div>
                        <div class="vendor-body">
                            <h5 class="vendor-name">Capture Moments</h5>
                            <p class="vendor-desc">Cinematic photography and videography</p>
                            <div class="vendor-footer">
                                <span class="badge-premium badge-approved">15+ Vendors</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ═══════ TESTIMONIALS ═══════ -->
    <section class="section-premium section-white">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Love Stories</span>
                <h2 class="section-title">What Our Clients Say</h2>
                <p class="section-subtitle">
                    Real stories from real couples and clients who trusted us
                </p>
                <div class="section-divider"></div>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card">
                        <div class="testimonial-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="quote-icon">"</div>
                        <p class="testimonial-text">
                            Eventify turned our wedding into a fairy tale. Every 
                            detail was perfect, from the stunning décor to the 
                            incredible catering. We couldn't have asked for more!
                        </p>
                        <div class="testimonial-author">
                            <div class="testimonial-avatar" 
                                 style="background-image: url('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80')">
                            </div>
                            <div>
                                <div class="testimonial-name">Priya & Rahul Sharma</div>
                                <div class="testimonial-event">Wedding · December 2024</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card">
                        <div class="testimonial-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="quote-icon">"</div>
                        <p class="testimonial-text">
                            Our corporate annual gala was flawless. The vendor 
                            selection process was so easy, and the event coordinator 
                            was incredibly professional and responsive.
                        </p>
                        <div class="testimonial-author">
                            <div class="testimonial-avatar" 
                                 style="background-image: url('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80')">
                            </div>
                            <div>
                                <div class="testimonial-name">Arjun Mehta</div>
                                <div class="testimonial-event">Corporate Gala · January 2025</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <div class="testimonial-card">
                        <div class="testimonial-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                        <div class="quote-icon">"</div>
                        <p class="testimonial-text">
                            Surprised my parents with a golden anniversary celebration. 
                            Eventify made it magical. The attention to detail was 
                            beyond our expectations!
                        </p>
                        <div class="testimonial-author">
                            <div class="testimonial-avatar" 
                                 style="background-image: url('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&q=80')">
                            </div>
                            <div>
                                <div class="testimonial-name">Sneha Patel</div>
                                <div class="testimonial-event">Anniversary · November 2024</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ═══════ CTA SECTION ═══════ -->
    <section class="cta-premium">
        <div class="cta-bg"></div>
        <div class="cta-overlay"></div>
        <div class="container">
            <div class="cta-content">
                <span class="hero-tagline" style="animation: none; opacity: 1;">Begin Your Journey</span>
                <h2 class="cta-title">Ready to Create Magic?</h2>
                <p class="cta-text">
                    Join thousands of happy clients who trusted SmartEvent 
                    with their most precious celebrations.
                </p>
                <div class="d-flex gap-3 justify-content-center flex-wrap">
                    <a href="register.jsp" class="btn-hero-primary">
                        <i class="fas fa-rocket"></i> Get Started Free
                    </a>
                    <a href="#" class="btn-hero-outline">
                        <i class="fas fa-phone"></i> Talk to Expert
                    </a>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="HNF/footer.jsp" %>