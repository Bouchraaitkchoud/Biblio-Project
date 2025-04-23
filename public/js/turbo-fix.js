// Turbo navigation fixes
document.addEventListener('turbo:load', function () {
    console.log('Turbo fix running on page load');

    // Handle navigation between admin and main site sections
    disableTurboForCrossSectionNavigation();
});

// Also run when DOM is loaded in case Turbo didn't trigger
document.addEventListener('DOMContentLoaded', function () {
    console.log('Turbo fix running on DOM content loaded');
    disableTurboForCrossSectionNavigation();
});

function disableTurboForCrossSectionNavigation() {
    // When navigating from admin to main site
    if (window.location.pathname.includes('/admin')) {
        document.querySelectorAll('a[href^="/"]').forEach(link => {
            if (!link.getAttribute('href').includes('/admin')) {
                link.setAttribute('data-turbo', 'false');
                console.log('Disabled turbo for link:', link.getAttribute('href'));
            }
        });
    }

    // When navigating from main site to admin
    if (!window.location.pathname.includes('/admin')) {
        document.querySelectorAll('a[href*="/admin"]').forEach(link => {
            link.setAttribute('data-turbo', 'false');
            console.log('Disabled turbo for admin link:', link.getAttribute('href'));
        });
    }

    // Always disable Turbo for logout link
    document.querySelectorAll('a[href*="logout"]').forEach(link => {
        link.setAttribute('data-turbo', 'false');
        console.log('Disabled turbo for logout link');
    });
} 