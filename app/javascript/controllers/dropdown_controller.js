import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  connect() {
    this.hide();
  }

  toggle() {
    this.menuTarget.classList.toggle('hidden');
  }

  hide() {
    this.menuTarget.classList.add('hidden');
  }

  show() {
    this.menuTarget.classList.remove('hidden');
  }

  close(event) {
    if (!this.menuTarget.contains(event.target)) {
      this.hide();
    }
  }
}