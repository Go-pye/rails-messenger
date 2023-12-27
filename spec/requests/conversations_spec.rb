require 'rails_helper'

RSpec.describe ConversationsController, type: :request do
  describe "GET /conversation" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:conversation) { FactoryBot.create(:conversation, participant1: user, participant2: other_user) }

    context 'user is signed in' do
      before do
        sign_in user
      end

      it 'responds with success status code' do
        get conversations_path
        expect(response).to have_http_status(:success)
      end

      it 'assigns conversations to @conversations' do
        get conversations_path(conversation)
        expect(assigns(:conversations)).to match_array([conversation])
      end
    end

    context 'user is not logged in' do
      it 'redirects to user sign in page' do
        get conversations_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /conversations/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:conversation) { FactoryBot.create(:conversation, participant1: user, participant2: other_user) }

    before do
      sign_in user
    end

    it 'assigns the requested conversation to @conversation' do
      get conversation_path(conversation)
      expect(assigns(:conversation)).to eq(conversation)
    end

    it 'assigns the messages of the conversation to @messages' do
      message = FactoryBot.create(:message, conversation: conversation)
      get conversation_path(conversation)
      expect(assigns(:messages)).to include(message)
    end
  end

  describe "POST /conversations" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    context 'when user is signed in' do
      before do
        sign_in user
      end

      context 'with valid parameters' do
        let(:valid_params) {{ conversation: { user_id: other_user.id } }}

        it 'creates a new conversation' do
          expect {
            post conversations_path, params: valid_params
          }.to change(Conversation, :count).by(1)
        end

        it 'redirects to the conversation show page' do
          post conversations_path, params: valid_params
          expect(response).to redirect_to(conversation_path(Conversation.last))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) {{ conversation: { user_id: nil } }}

        it 'does not create a new conversation' do
          expect {
            post conversations_path, params: invalid_params
          }.not_to change(Conversation, :count)
        end

        it 're-renders the new conversation form' do
          post conversations_path, params: invalid_params
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
