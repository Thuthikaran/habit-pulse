import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frequencyInput", "pill"]

  connect() {
    this.selectedFrequency = this.frequencyInputTarget.value
    this.updateSelectedPills()
  }

  toggleFrequency(event) {
    const frequency = event.currentTarget.dataset.frequency
    if (this.selectedFrequency === frequency) {
      this.selectedFrequency = null
    } else {
      this.selectedFrequency = frequency
    }
    this.frequencyInputTarget.value = this.selectedFrequency
    this.updateSelectedPills()
    this.toggleAdditionalOptions()
  }

  updateSelectedPills() {
    this.pillTargets.forEach(pill => {
      if (pill.dataset.frequency === this.selectedFrequency) {
        pill.classList.add("selected")
      } else {
        pill.classList.remove("selected")
      }
    })
  }

  toggleAdditionalOptions() {
    // Example: Toggle visibility of days of the week based on selected frequency
    const daysOfWeekContainer = document.querySelector('.days-label-input')
    if (this.selectedFrequency === 'weekly') {
      daysOfWeekContainer.classList.remove('d-none')
    } else {
      daysOfWeekContainer.classList.add('d-none')
    }
  }
}
