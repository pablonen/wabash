import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hex"
export default class extends Controller {
  static values = { hexes: Array }
  static targets = ['input']
  static classes = ['selected']

  process({ detail: { hex }}) {
    let selected_hexes = this.hexesValue

    if (selected_hexes.includes(hex)) {
      this.dispatch('unselect', { detail: { hex: hex }})
      selected_hexes = selected_hexes.filter( h => h !== hex)
    } else {
      selected_hexes.push(hex)
    }

    if (selected_hexes.length > 3) {
      this.dispatch('unselect', { detail: { hex: hex }})
      selected_hexes = selected_hexes.filter( h => h !== hex )
    }
    this.hexesValue = Array.from(new Set(selected_hexes))
  }

  hexesValueChanged() {
    this.inputTargets[0].value = this.hexesValue[0]
    this.inputTargets[1].value = this.hexesValue[1]
    this.inputTargets[2].value = this.hexesValue[2]
  }
}
