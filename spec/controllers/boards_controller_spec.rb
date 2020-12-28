require 'rails_helper'

describe BoardsController, type: :request do
  let (:user) { create(:user) }
  let (:user2) { create(:user) }
  let (:board) { create(:board, author_id: user.id) }
  let (:board2) { create(:board, author_id: user.id) }
  let (:board3) { create(:board, author_id: user2.id) }

  context '#index' do
    before do
      login(user)
      get "/boards", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the board' do
      expect(json['data'].size).to eq(2)
    end
  end


  context '#show' do
    before do
      login(user)
      get "/boards/#{board.slug}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the board' do
      expect(json['data']).to have_id(board.id.to_s)
      expect(json['data']).to have_type('boards')
    end
  end

  context 'When a board is missing' do
    before do
      login(user)
      get "/boards/blank", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/boards/#{user.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end
