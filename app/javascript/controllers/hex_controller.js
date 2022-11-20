import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hex_click() {
    let hex_id = event.target.id
    this.dispatch("hex_click", { detail: { hex: hex_id, target: event.target }})
  }
}
