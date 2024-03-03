import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drawer"
export default class extends Controller {
  static targets = ["drawer", "overlay"];

  connect() {
    console.log("Drawer controller connected");
    console.log(this.drawerTarget)
    this.close();
  }

  toggle() {
    console.log("Toggling drawer")
    if (this.drawerTarget.classList.contains("hidden")) {
      this.open();
    } else {
      this.close();
    }
  }

  open() {
    this.drawerTarget.classList.remove("hidden");
    // this.overlayTarget.classList.remove("pointer-events-none");
  }

  close() {
    this.drawerTarget.classList.add("hidden");
    // this.overlayTarget.classList.add("pointer-events-none");
  }
}
