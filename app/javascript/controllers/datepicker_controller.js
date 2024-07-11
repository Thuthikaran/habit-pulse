import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = [ "start", "end" ]

  connect() {
    flatpickr(this.element, {
      minDate: "today",
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
    })
  }
}
