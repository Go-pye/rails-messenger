require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe "GET /" do
    it 'responds with success status code' do
      get home_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
