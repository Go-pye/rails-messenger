class ActiveConversationsController < ApplicationController
  def index
    @active_conversations = Conversation.with_recent_messages(current_user.id)
  end
end
