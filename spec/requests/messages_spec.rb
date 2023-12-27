require 'rails_helper'

RSpec.describe MessagesController, type: :request do
  let(:participant1) { create(:user) }
  let(:participant2) { create(:user) }
  let(:conversation) { create(:conversation) }
  let(:message_params) { { message: { content: "heeeeeyyyyy" } } }

  before do
    sign_in participant1
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Message' do
        expect {
          post conversation_messages_path(conversation), params: message_params
        }.to change(Message, :count).by(1)
      end

      it 'responds with success status code' do
        post conversation_messages_path(conversation), params: message_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Message' do
        expect {
          post conversation_messages_path(conversation), params: { message: { content: nil } }
        }.to change(Message, :count).by(0)
      end

      it 'returns an error response' do
        post conversation_messages_path(conversation), params: { message: { content: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end