// app/javascript/controllers/chat_controller.js
import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["input", "messages"];

  connect() {
    const currentUserMetaTag = document.querySelector("meta[name='current-user-id']");
    this.currentUserId = currentUserMetaTag ? parseInt(currentUserMetaTag.content) : null;

    this.subscription = consumer.subscriptions.create(
      { channel: "ConversationChannel", conversation_id: this.data.get("conversationId") },
      {
        received: data => {
          this.received(data);
        }
      }
    );
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  received(data) {
    let isCurrentUser = parseInt(data.user_id) === this.currentUserId;
    let messageHTML = this.buildMessageHTML(data.message_html, isCurrentUser);
    this.messagesTarget.insertAdjacentHTML('beforeend', messageHTML);
  }

  send(event) {
    event.preventDefault();
    const messageContent = this.inputTarget.value.trim();

    if (messageContent.length === 0) return;
    
    const conversationId = this.data.get("conversationId");
    fetch(`/conversation/${conversationId}/messages`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ content: messageContent })
    }).then(response => response.json())
      .then(data => {
        this.inputTarget.value = '';
    });
  }

  buildMessageHTML(messageHTML, isCurrentUser) {
    let template = document.createElement('template');
    messageHTML = messageHTML.trim();
    template.innerHTML = messageHTML;

    let messageDiv = template.content.firstChild;

    if (isCurrentUser) {
      messageDiv.classList.add("self-end", "bg-blue-500", "text-white");
      messageDiv.classList.remove("self-start", "bg-gray-300");
    } else {
      messageDiv.classList.add("self-start", "bg-gray-300");
      messageDiv.classList.remove("self-end", "bg-blue-500", "text-white");
    }

    return messageDiv.outerHTML;
  }
}
