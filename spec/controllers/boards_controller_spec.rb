require 'rails_helper'

describe BoardsController, type: :request do
  let (:user) { create(:user) }
  let! (:board) { create(:board, author_id: user.id) }

  context '#index' do
    let (:user2) { create(:user) }
    let! (:board2) { create(:board, author_id: user.id) }
    let! (:board3) { create(:board, author_id: user2.id) }

    before do
      login(user)
      get "/boards", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the boards' do
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
      options = { serializer: BoardFullSerializer }
      handler = ActiveModelSerializers::SerializableResource.new(board, options).to_json
      expect(json['data']).to eq(JSON.parse(handler)['data'])
    end
  end

  context '#create' do
    before do
      login(user)
    end

    describe 'with good params' do
      before do
        post "/boards/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { board: { title: 'testBoard' } }
      end

      it 'returns 201' do
        expect(response.status).to eq(201)
      end

      it 'return the board' do
        expect(json['data']['attributes']['title']).to eq('testBoard')
      end
    end

    describe 'with bad params' do
      before do
        post "/boards/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { board: { title: '' } }
      end

      it 'return 422' do
        expect(response.status).to eq(422)
      end
    end
  end

  context '#destroy' do
    before do
      login(user)
      delete "/boards/#{board.slug}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'return 200' do
      expect(response.status).to eq(200)
    end

    it 'delete current board' do
      expect(Board.count).to eq(0)
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
