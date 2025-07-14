import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "overlay"]

  connect() {
    // Initialize when controller connects
  }

  open() {
    this.menuTarget.classList.remove('hidden')
    this.menuTarget.classList.add('block')
    this.overlayTarget.classList.remove('hidden')
    document.body.style.overflow = 'hidden'
  }

  close() {
    this.menuTarget.classList.remove('block')
    this.menuTarget.classList.add('hidden')
    this.overlayTarget.classList.add('hidden')
    document.body.style.overflow = ''
  }

  closeWithEscape(event) {
    if (event.key === "Escape" && !this.menuTarget.classList.contains('hidden')) {
      this.close()
    }
  }
}