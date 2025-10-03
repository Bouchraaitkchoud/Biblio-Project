import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["navLink"]

    connect() {
        this.updateActiveNav()
        
        // Listen for navigation events (Turbo/SPA navigation)
        document.addEventListener('turbo:load', () => {
            this.updateActiveNav()
        })
        
        // Also listen for manual navigation
        document.addEventListener('turbo:frame-load', () => {
            this.updateActiveNav()
        })
    }

    updateActiveNav() {
        const currentPath = window.location.pathname
        
        this.navLinkTargets.forEach(link => {
            link.classList.remove('active')
            
            // Get the href attribute and check if it matches current path
            const linkPath = new URL(link.href).pathname
            
            if (linkPath === currentPath) {
                link.classList.add('active')
            }
            
            // Special handling for nested routes
            if (currentPath.startsWith('/admin/orders') && linkPath.includes('/admin/orders')) {
                link.classList.add('active')
            } else if (currentPath.startsWith('/admin/returns') && linkPath.includes('/admin/returns')) {
                link.classList.add('active')
            } else if (currentPath.startsWith('/admin/books') && linkPath.includes('/admin/books')) {
                link.classList.add('active')
            } else if (currentPath.startsWith('/admin/disciplines') && linkPath.includes('/admin/disciplines')) {
                link.classList.add('active')
            } else if (currentPath.startsWith('/admin/authors') && linkPath.includes('/admin/authors')) {
                link.classList.add('active')
            } else if (currentPath.startsWith('/admin/publishers') && linkPath.includes('/admin/publishers')) {
                link.classList.add('active')
            }
        })
    }
}