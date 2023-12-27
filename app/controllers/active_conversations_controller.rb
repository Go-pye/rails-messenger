class ActiveConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_conversations = Conversation.with_recent_messages(current_user.id)
  end
end
