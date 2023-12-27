require 'rails_helper'

RSpec.describe "Conversations", type: :request do
  describe "GET /conversation" do
    context 'user is not logged in' do
      it 'redirects to user sign in page' do
        get "/conversation"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in' do
      before do
        user = FactoryBot.create(:user)
        sign_in user
      end
      it 'loads users index page' do
        get "/users/index"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
