import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="frequency"
export default class extends Controller {
  static targets = ['frequency', 'daysOfWeek']

  connect() {
    console.log('Connected to frequency controller')
    // console.log(this.frequencyTarget)
    // console.log(this.daysOfWeekTarget)
    this.toggleDaysOfWeek()
  }

  toggleDaysOfWeek() {
    // console.log('Toggling days of week')
    console.log(this.frequencyTarget.value)
    if (this.frequencyTarget.value === 'weekly') {
      this.daysOfWeekTarget.classList.remove('d-none')
    } else {
      this.daysOfWeekTarget.classList.add('d-none')
    }
  }
}
