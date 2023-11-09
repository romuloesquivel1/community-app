import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-name"
export default class extends Controller {
  static targets = ['name']
  
  connect() {
    console.log('user-name', this.element);
  }

  getUserName = () => {
    const element = this.nameTarget;
    const name = element.textContent;
    alert(`You clicked on ${name}`);
  }
}
