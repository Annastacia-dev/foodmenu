import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "panels"];

  connect() {
    // Try to retrieve the selected tab from sessionStorage
    const storedTab = sessionStorage.getItem("selectedTab");

    if (storedTab) {
      this.activateTab(storedTab);
    } else {
      // If not found in sessionStorage, check for tab parameter in the URL
      const urlParams = new URLSearchParams(window.location.search);
      const tabParam = urlParams.get('tab');

      if (tabParam) {
        this.activateTab(tabParam);
      } else {
        // Activate the first tab by default
        this.activateTab(this.tabTargets[0].dataset.tab);
      }
    }
  }

  activate(event) {
    const tabId = event.target.dataset.tab;
    this.activateTab(tabId);
    const url = new URL(window.location);
    url.searchParams.set("tab", tabId);
    window.history.replaceState({}, "", url);

    // Store the selected tab in sessionStorage
    sessionStorage.setItem("selectedTab", tabId);
  }

  activateTab(tabId) {
    this.tabTargets.forEach((tab) => tab.classList.remove("active"));
    this.panelsTargets.forEach((panel) => panel.classList.add("hidden"));

    const selectedTab = this.tabTargets.find((tab) => tab.dataset.tab === tabId);
    const selectedPanel = this.panelsTargets.find((panel) => panel.dataset.tab === tabId);

    if (selectedTab && selectedPanel) {
      selectedTab.classList.add("active");
      selectedPanel.classList.remove("hidden");
    }
  }
}
