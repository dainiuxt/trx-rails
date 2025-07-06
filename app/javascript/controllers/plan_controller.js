import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static identifier = "plan"
  static targets = ["plans", "template"]

  connect() {
    console.log("✅ PlanController connected")
    this.index = this.plansTarget.childElementCount
  }

  add(event) {
    event.preventDefault()
    console.log("➕ Add plan triggered")
    console.log("📦 Template contents:", this.templateTarget.innerHTML)
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, this.index)
    this.plansTarget.insertAdjacentHTML("beforeend", content)
    this.index++
  }

  remove(event) {
    event.preventDefault()
    const item = event.target.closest(".nested-plan")
    if (item.dataset.newRecord === "true") {
      item.remove()
    } else {
      item.querySelector("input[name*='_destroy']").value = 1
      item.style.display = "none"
    }
  }
}