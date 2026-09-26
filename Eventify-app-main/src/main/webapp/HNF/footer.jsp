<%-- includes/footer.jsp - PREMIUM FOOTER --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="footer-premium">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="footer-brand">
                    Eventify <span class="brand-dot"></span>
                </div>
                <p class="footer-desc">
                    Crafting unforgettable celebrations since 2020. Your trusted 
                    partner for weddings, birthdays, anniversaries, and corporate events.
                </p>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-pinterest-p"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            
            <div class="col-lg-2 col-md-6 mb-4">
                <h5>Company</h5>
                <ul class="footer-links">
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Our Team</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Press</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Services</h5>
                <ul class="footer-links">
                    <li><a href="#"><i class="fas fa-heart me-2" style="color: var(--primary-light);"></i>Weddings</a></li>
                    <li><a href="#"><i class="fas fa-birthday-cake me-2" style="color: var(--primary-light);"></i>Birthdays</a></li>
                    <li><a href="#"><i class="fas fa-glass-cheers me-2" style="color: var(--primary-light);"></i>Anniversaries</a></li>
                    <li><a href="#"><i class="fas fa-briefcase me-2" style="color: var(--primary-light);"></i>Corporate</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <h5>Get in Touch</h5>
                <ul class="footer-links">
                    <li><a href="mailto:hello@eventify.com"><i class="fas fa-envelope me-2" style="color: var(--primary-light);"></i>hello@eventify.com</a></li>
                    <li><a href="tel:+911234567890"><i class="fas fa-phone me-2" style="color: var(--primary-light);"></i>+91 123 456 7890</a></li>
                    <li><a href="#"><i class="fas fa-map-marker-alt me-2" style="color: var(--primary-light);"></i>Bangalore, Karnataka</a></li>
                    <li><a href="#"><i class="fas fa-clock me-2" style="color: var(--primary-light);"></i>Mon-Sat: 9AM - 8PM</a></li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p>&copy; 2026 Eventify. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>
                        <a href="#" class="me-3" style="color: rgba(255,255,255,0.6); text-decoration: none;">Privacy</a>
                        <a href="#" class="me-3" style="color: rgba(255,255,255,0.6); text-decoration: none;">Terms</a>
                        <a href="#" style="color: rgba(255,255,255,0.6); text-decoration: none;">Sitemap</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/script.js"></script>

<!-- Scroll Animation Script -->
<script>
// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar-premium');
    if (navbar) {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }
});

// Animate on scroll
const observer = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
}, { threshold: 0.1 });

document.querySelectorAll('.animate-on-scroll').forEach(function(el) {
    observer.observe(el);
});
</script>

</body>
</html>