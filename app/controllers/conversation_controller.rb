class ConversationController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

  def create
    @conversation = Conversation.new(
      participant1_id: current_user.id,
      participant2_id: conversation_params[:user_id]
    )

    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      # set flash message
      # redirect_back 
    end
  end

  def update
  end

  private

  def conversation_params
    params.require(:conversation).permit(:id, :user_id)
  end
end
