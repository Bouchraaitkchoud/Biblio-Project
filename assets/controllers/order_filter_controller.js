import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["filterButton", "orderItem", "sortSelect"]

    connect() {
        this.initializeFilters()
    }

    initializeFilters() {
        // Set up filter button event listeners
        this.filterButtonTargets.forEach(button => {
            button.addEventListener('click', (event) => {
                this.filterOrders(event)
            })
        })

        // Set up sort functionality
        if (this.hasSortSelectTarget) {
            this.sortSelectTarget.addEventListener('change', (event) => {
                this.sortOrders(event)
            })
        }
    }

    filterOrders(event) {
        const status = event.target.dataset.status
        
        // Update active button
        this.filterButtonTargets.forEach(btn => btn.classList.remove('active'))
        event.target.classList.add('active')
        
        // Filter orders
        this.orderItemTargets.forEach(item => {
            if (status === 'all' || item.dataset.status === status) {
                item.style.display = 'block'
            } else {
                item.style.display = 'none'
            }
        })
    }

    sortOrders(event) {
        const ordersContainer = this.element.querySelector('.orders-container')
        const orders = Array.from(this.orderItemTargets)
        
        orders.sort((a, b) => {
            const dateA = new Date(a.querySelector('.order-date').textContent)
            const dateB = new Date(b.querySelector('.order-date').textContent)
            
            return event.target.value === 'newest' ? dateB - dateA : dateA - dateB
        })
        
        orders.forEach(order => ordersContainer.appendChild(order))
    }
}