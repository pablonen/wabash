import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["A2","A3","A4","B2","B3","B4","B5","B6","C0","C1","C2","C3","C4","C5","C6","C7","D0","D1","D2","D3","D4","D5","D6","D7","E0","E1","E2","E3","E4","E5","E6","E7","E8","F1","F2","F3","F4","F5","F6","F7","F8","G2","G3","G4","G5","G6","G7","G8","G9","H2","H3","H4","H5","H6","H7","H8","H9","I2","I3","I4","I5","I6","I7","I8","I9","J1","J2","J3","J4","J5","J6","J7","J8","J9","K1","K2","K3","K4","K5","K6","K7","K8","K9","L0","L1","L2","L3","L4","L5","L6","L7","L8","L9","M0","M1","M2","M3","M4","M5","M6","M7","M8","M9","N0","N1","N2","N3","N4","N5","N6","N7","N8","N9","O0","O1","O2","O3","O4","O5","O6","O7","O8","O9","P0","P1","P2","P3","P4","P5","P6","P7","P8","P9","Q0","Q1","Q2","Q3","Q4","Q5","Q6","Q7","Q8","Q9","R0","R1","R2","R3","R4","R5","R6","S0","S1","S2","S3","S4","S5","I10","K10","M10","O10"]
  static classes = ['selected']

  select_hex(event) {
    let hex_id = event.target.id
    event.target.classList.add(this.selectedClass)
    this.dispatch("hex_selected", { detail: { hex: hex_id }})
  }

  unselect_hex({ detail: { hex }}) {
    if(hex === "-1") {
      return;
    }

    let hex_target = hex + "Target"
    eval('this.'+hex_target+'.classList.remove(this.selectedClass)')
  }

  toggle_hex({ detail: { hex }}) {
    let hex_target = hex + "Target"
    eval('this.'+hex_target+'.classList.toggle(this.selectedClass)')
  }

  change_hex_selection({ detail: { from_hex, to_hex }}) {
    let from_hex_target = from_hex+"Target"
    let to_hex_target = to_hex+"Target"

    if(from_hex !== "-1") {
      eval('this.'+from_hex_target+'.classList.remove(this.selectedClass)')
    }
    eval('this.'+to_hex_target+'.classList.add(this.selectedClass)')
  }
}
