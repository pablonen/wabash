import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hex"
export default class extends Controller {
  static values = { hexes: Array }
  static targets = ['input']
  static classes = ['selected']

  process({ detail: { hex, target } }) {
    let new_hexes = this.hexesValue

    target.classList.toggle(this.selectedClass)

    if ( this.hexesValue.length >= 3 && !this.hexesValue.includes(hex)) {
      return 0
    }

    if ( new_hexes.includes(hex)) {
      new_hexes = new_hexes.filter( h => h !== hex )
    } else {
      new_hexes.push(hex)
    }

    this.hexesValue = Array.from(new Set(new_hexes))
  }

  hexesValueChanged() {
    this.inputTargets[0].value = this.hexesValue[0]
    this.inputTargets[1].value = this.hexesValue[1]
    this.inputTargets[2].value = this.hexesValue[2]
  }
}
