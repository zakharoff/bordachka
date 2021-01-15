require 'rails_helper'

describe CardsController, type: :request do
  let (:user) { create(:user) }
  let! (:card) { create(:card, author_id: user.id, executor_ids: [user.id]) }

  context '#index' do
    let (:user2) { create(:user) }
    let! (:card2) { create(:card, author_id: user.id, executor_ids: [user.id]) }
    let! (:card3) { create(:card, author_id: user2.id) }

    before do
      login(user)
      get "/cards", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the cards' do
      expect(json['data'].size).to eq(2)
    end
  end


  context '#show' do
    before do
      login(user)
      get "/cards/#{card.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the card' do
      @handler = ActiveModelSerializers::SerializableResource.new(card).to_json
      expect(json['data']).to eq(JSON.parse(@handler)['data'])
    end
  end

  context '#create' do
    before do
      login(user)
    end

    describe 'with good params' do
      let (:board) { create(:board) }
      let (:column) { create(:column) }

      before do
        post "/cards/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { card: { title: 'testCard', board_id: board.id, column_id: column.id } }
      end

      it 'returns 201' do
        expect(response.status).to eq(201)
      end

      it 'return the board' do
        expect(json['data']['attributes']['title']).to eq('testCard')
      end
    end

    describe 'with bad params' do
      before do
        post "/cards/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { card: { title: '' } }
      end

      it 'return 422' do
        expect(response.status).to eq(422)
      end
    end
  end

  context '#destroy' do
    before do
      login(user)
      delete "/cards/#{card.id}", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'return 200' do
      expect(response.status).to eq(200)
    end

    it 'delete current card' do
      expect(Card.count).to eq(0)
    end
  end

  context 'When a card is missing' do
    before do
      login(user)
      get "/cards/blank", headers: {
        'Authorization': response.headers['Authorization']
      }
    end

    it 'returns 404' do
      expect(response.status).to eq(404)
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/cards/#{card.id}"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end
