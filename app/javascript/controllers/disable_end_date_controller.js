import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Add an event listener to the checkbox for 'currently_working_here'
    this.element.addEventListener("change", () => {
      this.disableEndDate();
    });
    // Initially disable the end date if 'currently_working_here' checkbox is checked
    if (this.element.checked) {
      this.disableEndDate();
    }
  }

  disableEndDate() {
    const endDateElement = document.getElementById('work_experience_end_date');
    if (this.element.checked) {
      endDateElement.value = ''; // Clear the value when disabled
      endDateElement.setAttribute("disabled", true);
    } else {
      endDateElement.removeAttribute("disabled");
    }
  }
}
