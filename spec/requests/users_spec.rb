require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /index" do
    context 'user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      before do
        sign_in user
      end

      it 'loads users index page' do
        get users_index_path
        expect(response).to have_http_status(:success)
      end

      it 'assigns @users' do
        get users_index_path
        expect(assigns(:users)).to eq(User.all_except(user))
      end

      it 'does not include current user in @users' do
        get users_index_path
        expect(assigns(:users)).not_to include(user)
      end
    end

    context 'user is not logged in' do
      it 'redirects to user sign in page' do
        get users_index_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
