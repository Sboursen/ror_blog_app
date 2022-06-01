require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns the correct response' do
      get '/users/index'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Users')
      expect(response.body).to include('Shows info for a specific user')
    end
  end
end
