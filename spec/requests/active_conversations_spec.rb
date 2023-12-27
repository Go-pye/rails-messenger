require 'rails_helper'

RSpec.describe ActiveConversationsController, type: :request do
  describe 'GET /active_conversations/index' do
    let(:user) { create(:user) }
    let!(:conversation) { create(:conversation, participant1: user) }
    let!(:message) { create(:message, conversation: conversation, user: user) }

    context 'when the user is signed in' do
      before do
        sign_in user
      end

      it 'responds with success status code' do
        get active_conversations_index_path
        expect(response).to have_http_status(:ok)
      end

      it 'loads all of the active conversations into @active_conversations' do
        get active_conversations_index_path
        expect(assigns(:active_conversations)).to match_array([conversation])
      end
    end

    context 'user is not logged in' do
      it 'redirects to user sign in page' do
        get active_conversations_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end