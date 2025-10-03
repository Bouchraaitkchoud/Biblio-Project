import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "alert", "tooltip", "popover"]

    connect() {
        this.initializeBootstrapComponents()
        
        // Listen for Turbo navigation to reinitialize components
        document.addEventListener('turbo:load', () => {
            this.initializeBootstrapComponents()
        })
        
        document.addEventListener('turbo:frame-load', () => {
            this.initializeBootstrapComponents()
        })
    }

    disconnect() {
        // Clean up Bootstrap components to prevent memory leaks
        this.cleanupBootstrapComponents()
    }

    initializeBootstrapComponents() {
        // Initialize modals
        document.querySelectorAll('[data-bs-toggle="modal"]').forEach(modalTrigger => {
            if (!modalTrigger.hasAttribute('data-bs-initialized')) {
                modalTrigger.setAttribute('data-bs-initialized', 'true')
            }
        })

        // Initialize tooltips
        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(tooltipTrigger => {
            if (!tooltipTrigger.hasAttribute('data-bs-initialized')) {
                new window.bootstrap.Tooltip(tooltipTrigger)
                tooltipTrigger.setAttribute('data-bs-initialized', 'true')
            }
        })

        // Initialize popovers
        document.querySelectorAll('[data-bs-toggle="popover"]').forEach(popoverTrigger => {
            if (!popoverTrigger.hasAttribute('data-bs-initialized')) {
                new window.bootstrap.Popover(popoverTrigger)
                popoverTrigger.setAttribute('data-bs-initialized', 'true')
            }
        })

        // Initialize alerts (they should work automatically, but just in case)
        document.querySelectorAll('.alert [data-bs-dismiss="alert"]').forEach(alertButton => {
            if (!alertButton.hasAttribute('data-bs-initialized')) {
                alertButton.setAttribute('data-bs-initialized', 'true')
            }
        })
    }

    cleanupBootstrapComponents() {
        // Dispose of all tooltips
        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(element => {
            const tooltip = window.bootstrap.Tooltip.getInstance(element)
            if (tooltip) {
                tooltip.dispose()
            }
        })

        // Dispose of all popovers
        document.querySelectorAll('[data-bs-toggle="popover"]').forEach(element => {
            const popover = window.bootstrap.Popover.getInstance(element)
            if (popover) {
                popover.dispose()
            }
        })

        // Dispose of all modals
        document.querySelectorAll('.modal').forEach(element => {
            const modal = window.bootstrap.Modal.getInstance(element)
            if (modal) {
                modal.dispose()
            }
        })
    }
}