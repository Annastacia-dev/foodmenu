import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirmation-modal"
export default class extends Controller {
  static targets = ["modal"];
  connect() {
    this.modalTarget.classList.add('hidden')
  }

  open() {
    this.modalTarget.classList.remove('hidden')
  }

  close() {
    this.modalTarget.classList.add('hidden')
  }
}
