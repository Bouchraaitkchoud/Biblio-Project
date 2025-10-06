import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  connect() {
    // Import Select2 dynamically when needed
    this.loadSelect2().then(() => {
      this.initializeSelect2();
    });
  }

  disconnect() {
    // Clean up Select2 instances properly
    this.selectTargets.forEach((select) => {
      if (window.$ && window.$(select).hasClass("select2-hidden-accessible")) {
        window.$(select).select2("destroy");
      }
    });
  }

  async loadSelect2() {
    // Check if jQuery and Select2 are already loaded
    if (window.$ && window.$.fn.select2) {
      return Promise.resolve();
    }

    // Load jQuery if not present
    if (!window.$) {
      await this.loadScript("https://code.jquery.com/jquery-3.6.0.min.js");
    }

    // Load Select2 if not present
    if (!window.$.fn.select2) {
      await this.loadScript(
        "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"
      );
    }

    // Ensure Select2 CSS is loaded
    this.loadCSS(
      "https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
    );
  }

  loadScript(src) {
    return new Promise((resolve, reject) => {
      if (document.querySelector(`script[src="${src}"]`)) {
        resolve();
        return;
      }

      const script = document.createElement("script");
      script.src = src;
      script.onload = () => resolve();
      script.onerror = () => reject(new Error(`Failed to load script: ${src}`));
      document.head.appendChild(script);
    });
  }

  loadCSS(href) {
    if (document.querySelector(`link[href="${href}"]`)) {
      return;
    }

    const link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = href;
    document.head.appendChild(link);
  }

  initializeSelect2() {
    this.selectTargets.forEach((select) => {
      const $select = window.$(select);

      // Check if Select2 is already initialized
      if ($select.hasClass("select2-hidden-accessible")) {
        return;
      }

      const isMultiple = select.hasAttribute("multiple");

      $select.select2({
        width: "100%",
        closeOnSelect: !isMultiple,
        allowClear: true,
        tags: false,
        placeholder: select.dataset.placeholder || "Select an option...",
        theme: "default",
      });

      // Apply custom styling
      this.applyCustomStyling($select);
    });
  }

  applyCustomStyling($select) {
    const container = $select.next(".select2-container");

    if ($select.attr("multiple")) {
      container.find(".select2-selection--multiple").css({
        border: "1px solid #dee2e6",
        "border-radius": "6px",
        "min-height": "45px",
        padding: "5px",
      });

      container.find(".select2-selection__choice").css({
        "background-color": "#b2903e",
        border: "1px solid #a08232",
        color: "white",
        padding: "2px 8px",
        "border-radius": "4px",
      });
    }
  }
}
