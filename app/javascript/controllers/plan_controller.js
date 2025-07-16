// app/javascript/controllers/plan_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static identifier = "plan"
  static targets = ["plans", "template"]

  connect() {
    setTimeout(() => {
      if (!this.hasPlansTarget) {
        console.warn("plans target not found after timeout")
        return
      } else
      this.index = this.plansTarget.childElementCount
    }, 500)
  }

  updatePositions() {
    const plans = Array.from(this.plansTarget.querySelectorAll(".nested-plan"));

    // Only update position inputs in plans NOT marked for destruction
    const activePlans = plans.filter(plan => {
      const destroyInput = plan.querySelector('input[name*="_destroy"]');
      return !destroyInput || destroyInput.value !== "1";
    });

    activePlans.forEach((plan, index) => {
      const input = plan.querySelector(".position-input");
      if (input) {
        input.value = index + 1; // Re-assign position starting from 1
      }
    });
  }

  add(event) {
    event.preventDefault();

    // Generate a unique placeholder (timestamp) for the new nested fields
    const uniqueId = new Date().getTime();
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, uniqueId);

    // Wrap HTML into an element for DOM manipulation
    const wrapper = document.createElement("div");
    wrapper.innerHTML = content;

    const newPlan = wrapper.firstElementChild;

    // Append to plans target
    this.plansTarget.appendChild(newPlan);

    // Recalculate all positions (to ensure unique + ordered positions)
    this.updatePositions();
  }

remove(event) {
  event.preventDefault();

  
  const planElement = event.target.closest(".nested-plan");
  if (!planElement) return;
  
  const destroyField = planElement.querySelector('input[name*="_destroy"]');
  
  if (planElement.dataset.newRecord === "true") {
    planElement.remove();
  } else if (destroyField) {
    destroyField.value = "1";
    planElement.style.display = "none";  // or planElement.classList.add("hidden")
  }
  
  const positionInput = planElement.querySelector(".position-input");
  if (positionInput) positionInput.remove();

  this.updatePositions();
}

  moveUp(event) {
    event.preventDefault();
    const current = event.target.closest(".nested-plan");
    const prev = current.previousElementSibling;
    if (prev) {
      this.plansTarget.insertBefore(current, prev);
      this.updatePositions();
    }
  }

  moveDown(event) {
    event.preventDefault();
    const current = event.target.closest(".nested-plan");
    const next = current.nextElementSibling;
    if (next) {
      this.plansTarget.insertBefore(next, current);
      this.updatePositions();
    }
  }
}
