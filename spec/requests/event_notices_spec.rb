require 'rails_helper'

RSpec.describe 'EventNotices', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/event_notices/new'
      expect(response).to have_http_status(:success)
    end
  end

end
