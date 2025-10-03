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
            
            // Special handling for home page
            if (currentPath === '/' && linkPath === '/') {
                link.classList.add('active')
            }
            
            // Special handling for discipline pages
            if (currentPath.startsWith('/discipline') && linkPath === '/') {
                // Don't mark home as active for discipline pages
                return
            }
        })
    }
}