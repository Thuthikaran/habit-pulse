import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["daysInput", "pill"]

  connect() {
    // Initialize selectedDays as an empty array to ensure no pills are selected by default
    this.selectedDays = []
    this.updateSelectedPills()
  }

  toggleDay(event) {
    const day = event.currentTarget.dataset.day
    if (this.selectedDays.includes(day)) {
      this.selectedDays = this.selectedDays.filter(selectedDay => selectedDay !== day)
    } else {
      this.selectedDays.push(day)
    }
    this.daysInputTarget.value = this.selectedDays.join(',')
    this.updateSelectedPills()
  }

  updateSelectedPills() {
    this.pillTargets.forEach(pill => {
      if (this.selectedDays.includes(pill.dataset.day)) {
        pill.classList.add("selected")
      } else {
        pill.classList.remove("selected")
      }
    })
  }
}
