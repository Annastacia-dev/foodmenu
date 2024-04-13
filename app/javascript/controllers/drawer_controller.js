import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drawer"
export default class extends Controller {
  static targets = ["drawer"];

  connect() {
    const urlParams = new URLSearchParams(window.location.search);
    // Loop through each drawer element
    this.drawerTargets.forEach((drawer) => {
      const drawerId = drawer.dataset.id
      const drawerOpenParam = urlParams.get(drawerId);

      if (drawerOpenParam && drawerOpenParam.toLowerCase() === 'true') {
        this.open(drawer);
      } else {
        this.close(drawer);
      }
    });
  }

  toggle() {
    if (this.drawerTarget.classList.contains("hidden")) {
      this.open();
    } else {
      this.close();
    }
  }

  open() {
    this.drawerTarget.classList.remove("hidden");
  }

  close() {
    this.drawerTarget.classList.add("hidden");
  }
}
