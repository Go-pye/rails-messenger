require 'rails_helper'

RSpec.describe ConversationsController, type: :request do
  describe "GET /conversation" do
    context 'user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      before do
        sign_in user
      end

      it 'responds with success status code' do
        get conversations_path
        expect(response).to have_http_status(:success)
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
end
