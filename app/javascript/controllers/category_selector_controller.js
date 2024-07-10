import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categoryInput", "icon"]

  connect() {
    this.updateSelectedIcon()
  }

  selectCategory(event) {
    const selectedCategory = event.currentTarget.dataset.category
    this.categoryInputTarget.value = selectedCategory
    this.updateSelectedIcon()
  }

  updateSelectedIcon() {
    const selectedCategory = this.categoryInputTarget.value
    this.iconTargets.forEach(icon => {
      if (icon.dataset.category === selectedCategory) {
        icon.classList.add("selected")
      } else {
        icon.classList.remove("selected")
      }
    })
  }
}
