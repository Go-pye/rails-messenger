class MessagesController < ApplicationController
  # make to authorize

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.create(message_params.merge(user: current_user))

    if @message.save
      ConversationChannel.broadcast_to(
        @conversation,
        message_html: ApplicationController.render(
          partial: 'messages/message',
          locals: { message: @message, user: @message.user }
        ),
        user_id: @message.user_id
      )
      render json: { success: "Message sent." }, status: :ok
    else
      render json: { error: "Message not sent." }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
