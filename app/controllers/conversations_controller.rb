class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @other_user = User.find(@conversation.other_user(current_user.id))
  end

  def create
    @conversation = Conversation.new(
      participant1_id: current_user.id,
      participant2_id: conversation_params[:user_id]
    )

    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      flash.now[:alert] = "I'm sorry an error occurred while creating this conversation"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:id, :user_id)
  end
end
