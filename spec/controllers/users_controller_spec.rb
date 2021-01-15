require 'rails_helper'

describe UsersController, type: :request do
  let (:user) { create(:user) }

  context 'When fetching a user' do
    before do
      login(user)
      get "/users/#{user.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user' do
      options = { serializer: UserFullSerializer }
      @handler = ActiveModelSerializers::SerializableResource.new(user, options).to_json
      expect(json['data']).to eq(JSON.parse(@handler)['data'])
    end
  end

  context 'When a user is missing' do
    before do
      login(user)
      get "/users/blank", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/users/#{user.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end
