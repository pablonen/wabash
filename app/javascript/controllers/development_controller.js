import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input']
  static classes = ['selected']
  static values = { previousHex: String }

  process({ detail: { hex }}) {
    // update the input with the newest hex
    let hex_id = hex

    if ( hex_id === this.previousHexValue ) {
      this.inputTarget.value = null
      this.dispatch("toggle_hex", { detail: { hex: hex_id }})
      this.previousHexValue = "-1"
    } else {
      this.inputTarget.value = hex_id
      this.dispatch("change_selection", { detail: { from_hex: this.previousHexValue, to_hex: hex_id }})
      this.previousHexValue = hex_id
    }
  }
}
