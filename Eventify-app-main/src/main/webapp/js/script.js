// js/script.js - Premium Edition

document.addEventListener('DOMContentLoaded', function () {

    // Auto-dismiss alerts
    document.querySelectorAll('.alert').forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(function () { alert.remove(); }, 500);
        }, 5000);
    });

    // Password match validation
    var registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
            var pass = document.getElementById('password').value;
            var confirm = document.getElementById('confirmPassword').value;
            if (pass !== confirm) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    }

    // Phone - digits only
    var phoneInput = document.getElementById('phone');
    if (phoneInput) {
        phoneInput.addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }

    // Event date minimum today
    var eventDate = document.getElementById('eventDate');
    if (eventDate) {
        eventDate.min = new Date().toISOString().split('T')[0];
    }

    // Navbar scroll effect
    window.addEventListener('scroll', function () {
        var navbar = document.querySelector('.navbar-premium');
        if (navbar) {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        }
    });

    // Animate elements on scroll
    var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.feature-card, .event-type-card, .vendor-card-premium, .testimonial-card, .stat-card-premium').forEach(function (el) {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });

    // Active nav link
    var currentPath = window.location.pathname + window.location.search;
    document.querySelectorAll('.navbar-premium .nav-link').forEach(function (link) {
        var href = link.getAttribute('href');
        if (href && currentPath.indexOf(href) !== -1 && href !== 'index.jsp') {
            link.classList.add('active');
        }
    });

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            var target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // Form submit loading state
    document.querySelectorAll('form').forEach(function (form) {
        form.addEventListener('submit', function () {
            var btn = this.querySelector('button[type="submit"]');
            if (btn && !btn.disabled) {
                btn.disabled = true;
                var original = btn.innerHTML;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
                setTimeout(function () {
                    btn.disabled = false;
                    btn.innerHTML = original;
                }, 5000);
            }
        });
    });
});