import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="active-page"
export default class extends Controller {
  static targets = ["sidebarItem"];

  connect() {
    this.highlightActivePage();
  }

  highlightActivePage() {
    const currentPath = window.location.pathname;
    const pathName = currentPath.split('/').filter(Boolean).pop() || '/';

    this.sidebarItemTargets.forEach((item) => {
      const itemPath = item.dataset.path;

      if (pathName === itemPath) {
        item.classList.add("active");
      } else {
        item.classList.remove("active");
      }
    });
  }
}
