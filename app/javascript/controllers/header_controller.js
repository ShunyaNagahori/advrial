import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static targets = [ "menu" ]

  dropDownMenu(){
    let result = this.menuTarget.classList.contains('hidden');
    if(result) {
      this.menuTarget.classList.remove('hidden');
    } else {
      this.menuTarget.classList.add('hidden');
    }
  }
}
