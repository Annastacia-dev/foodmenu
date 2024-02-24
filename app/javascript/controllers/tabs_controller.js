import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"

export default class extends Controller {
  static targets = ["tab", "panels"];

  connect() {
    // Initialize the first tab and panel as active
    this.activateTab(this.tabTargets[0].dataset.tab);
  }

  activate(event) {
    const tabId = event.target.dataset.tab;
    this.activateTab(tabId);
  }

  activateTab(tabId) {
    // Deactivate all tabs and panels
    this.tabTargets.forEach((tab) => tab.classList.remove("active"));
    this.panelsTargets.forEach((panel) => panel.classList.add("hidden"));

    // Activate the selected tab and panel
    const selectedTab = this.tabTargets.find((tab) => tab.dataset.tab === tabId);
    const selectedPanel = this.panelsTargets.find((panel) => panel.dataset.tab === tabId);

    if (selectedTab && selectedPanel) {
      selectedTab.classList.add("active");
      selectedPanel.classList.remove("hidden");
    }
  }
}