import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["filterButton", "orderItem", "sortSelect"];

  connect() {
    // Set default active filter
    const allButton = this.filterButtonTargets.find(
      (btn) => btn.dataset.status === "all"
    );
    if (allButton) {
      allButton.classList.add("active");
    }
  }

  filterOrders(event) {
    const status = event.currentTarget.dataset.status;

    // Update active button
    this.filterButtonTargets.forEach((btn) => btn.classList.remove("active"));
    event.currentTarget.classList.add("active");

    // Filter orders
    this.orderItemTargets.forEach((item) => {
      if (status === "all" || item.dataset.status === status) {
        item.style.display = "block";
      } else {
        item.style.display = "none";
      }
    });
  }

  sortOrders(event) {
    const ordersContainer = this.element.querySelector(".orders-container");
    const orders = Array.from(this.orderItemTargets);

    orders.sort((a, b) => {
      const dateA = new Date(a.querySelector(".order-date").textContent.trim());
      const dateB = new Date(b.querySelector(".order-date").textContent.trim());

      return event.target.value === "newest" ? dateB - dateA : dateA - dateB;
    });

    // Re-append in sorted order
    orders.forEach((order) => ordersContainer.appendChild(order));

    // Re-apply current filter after sorting
    const activeButton = this.filterButtonTargets.find((btn) =>
      btn.classList.contains("active")
    );
    if (activeButton) {
      const currentStatus = activeButton.dataset.status;
      this.orderItemTargets.forEach((item) => {
        if (currentStatus === "all" || item.dataset.status === currentStatus) {
          item.style.display = "block";
        } else {
          item.style.display = "none";
        }
      });
    }
  }

  disconnect() {
    // Cleanup if needed when navigating away
  }
}
