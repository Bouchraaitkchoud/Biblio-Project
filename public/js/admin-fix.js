/**
 * Fix for CSS and design issues in admin interface
 */
document.addEventListener('DOMContentLoaded', function () {
    // Force a repaint when page loads
    setTimeout(function () {
        const tables = document.querySelectorAll('.admin-table');
        tables.forEach(function (table) {
            // Force repainting
            table.style.display = 'none';
            table.offsetHeight; // Force reflow
            table.style.display = '';
        });

        // Fix action buttons
        const actionButtons = document.querySelectorAll('.actions .btn');
        actionButtons.forEach(function (btn) {
            btn.style.display = 'inline-flex';
            btn.style.alignItems = 'center';
            btn.style.justifyContent = 'center';
        });

        // Ensure icons are visible
        const icons = document.querySelectorAll('.fas');
        icons.forEach(function (icon) {
            icon.style.display = 'inline-block';
        });
    }, 50);

    // Add event listener to force repaint on page resize
    window.addEventListener('resize', function () {
        const tables = document.querySelectorAll('.admin-table');
        tables.forEach(function (table) {
            table.style.opacity = '0.99';
            setTimeout(function () {
                table.style.opacity = '1';
            }, 10);
        });
    });

    // Fix for loading issues when navigating between pages
    const links = document.querySelectorAll('a');
    links.forEach(function (link) {
        link.addEventListener('click', function () {
            // Save scroll position before navigation for back button
            sessionStorage.setItem('scrollPosition', window.scrollY);
        });
    });

    // Restore scroll position when navigating back
    if (sessionStorage.getItem('scrollPosition')) {
        window.scrollTo(0, parseInt(sessionStorage.getItem('scrollPosition')));
        setTimeout(function () {
            // Force repaint after restoring scroll position
            document.body.style.opacity = '0.99';
            setTimeout(function () {
                document.body.style.opacity = '1';
            }, 10);
        }, 100);
    }
}); 