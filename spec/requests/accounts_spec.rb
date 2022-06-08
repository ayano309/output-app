require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/accounts/show"
      expect(response).to have_http_status(:success)
    end
  end

end
