import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["connection"];
  
  initialize() {
    this.element.setAttribute("data-action", "click->connections#prepareConnectionParams");
  }

  prepareConnectionParams(event) {
    event.preventDefault();

    const element = this.element;
    const requesterId = element.dataset.requesterId;
    const connectedId = element.dataset.connectedId;
    const url = element.getAttribute("href");

    const connectionBody = new FormData();
    connectionBody.append("connection[user_id]", requesterId);
    connectionBody.append("connection[connected_user_id]", connectedId);
    connectionBody.append("connection[status]", "pending");

    fetch(url, {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: connectionBody
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
    .catch(error => console.error('Error creating connection:', error));
  }
}
