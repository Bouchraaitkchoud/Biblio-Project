import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["select"]

    connect() {
        this.initializeSelect2()
    }

    disconnect() {
        // Clean up Select2 instances
        this.selectTargets.forEach(select => {
            if ($(select).hasClass('select2-hidden-accessible')) {
                $(select).select2('destroy')
            }
        })
    }

    initializeSelect2() {
        this.selectTargets.forEach(select => {
            const $select = $(select)
            
            // Check if Select2 is already initialized
            if ($select.hasClass('select2-hidden-accessible')) {
                return
            }

            const isMultiple = $select.hasClass('select2-multiple')
            
            $select.select2({
                width: '100%',
                closeOnSelect: !isMultiple,
                allowClear: true,
                tags: false,
                placeholder: $select.data('placeholder') || 'Select an option...'
            })
        })
    }
}