import { Controller } from "stimulus";
import Mustache from "mustache";
import Toastr from "toastr";

export default class extends Controller {
  static targets = ["template", "participants", "groupName", "participant"];

  connect() {
    this.elementCount = 0;
    this.addRow();
  }

  add(event) {
    this.addRow();
    event.preventDefault();
  }

  async submit(event) {
    event.preventDefault();

    const rows = this.participantTargets.map((row) => {
      return {
        name: row.querySelector("input[name='name']").value,
        email: row.querySelector("input[name='email']").value,
      };
    });

    const data = {
      secret_santa: this.groupNameTarget.value,
      users: rows,
    };

    const response = await fetch("/secret_santas", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
    if (response.ok) {
      window.location.href = "/thanks";
    } else {
      Toastr.error("Error - please try again.");
    }
  }

  addRow() {
    this.participantsTarget.insertAdjacentHTML("beforeend", this.rowHTML());
  }

  rowHTML() {
    return Mustache.render(this.templateTarget.innerHTML, {
      id: this.elementCount++,
    });
  }
}
