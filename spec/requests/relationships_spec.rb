require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "GET /followings" do
    it "returns http success" do
      get "/relationships/followings"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /followers" do
    it "returns http success" do
      get "/relationships/followers"
      expect(response).to have_http_status(:success)
    end
  end

end
