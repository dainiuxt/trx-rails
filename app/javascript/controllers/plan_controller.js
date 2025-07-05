import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["plans", "template"]

  connect() {
    this.index = this.plansTarget.childElementCount
  }

  add(event) {
    event.preventDefault()
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