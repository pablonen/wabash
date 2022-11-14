import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hex"
export default class extends Controller {
  static values = { hexes: Array }
  static targets = ['input']
  static classes = ['selected']

  hex_click() {
    let hex_id = event.target.id
    let new_hexes = this.hexesValue;

    if ( this.hexesValue.length >= 3 && !this.hexesValue.includes(hex_id)) {
      return 0;
    }
    event.target.classList.toggle(this.selectedClass)

    if(new_hexes.includes(hex_id)) {
      new_hexes = new_hexes.filter( hex => hex !== hex_id )
    } else {
      new_hexes.push(hex_id)
    }

    this.hexesValue = Array.from(new Set(new_hexes))
    console.log(this.hexesValue)
  }

  hexesValueChanged() {
    this.inputTargets[0].value = this.hexesValue[0]
    this.inputTargets[1].value = this.hexesValue[1]
    this.inputTargets[2].value = this.hexesValue[2]
  }
}
