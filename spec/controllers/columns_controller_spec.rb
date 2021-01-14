require 'rails_helper'

describe ColumnsController, type: :request do
  let (:user) { create(:user) }
  let (:board) { create(:board) }
  let! (:column) { create(:column, board_id: board.id) }

  context '#index' do
    let! (:column2) { create(:column, board_id: board.id) }
    let (:board2) { create(:board) }
    let! (:column3) { create(:card, board_id: board2.id) }

    before do
      login(user)
      get "/columns", headers: {
        'Authorization': response.headers['Authorization']
      }, params: { column: { board_id: board.id } }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the columns' do
      expect(json['data'].size).to eq(2)
    end
  end

  context '#create' do
    before do
      login(user)
    end

    describe 'with good params' do
      before do
        post "/columns/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { column: { title: 'testColumn', board_id: board.id } }
      end

      it 'returns 201' do
        expect(response.status).to eq(201)
      end

      it 'return the board' do
        expect(json['data']['attributes']['title']).to eq('testColumn')
      end
    end

    describe 'with bad params' do
      before do
        post "/columns/", headers: {
          'Authorization': response.headers['Authorization']
        }, params: { column: { title: '', board: board.id } }
      end

      it 'return 422' do
        expect(response.status).to eq(422)
      end
    end
  end

  context 'When the Authorization header is missing' do
    before do
      get "/columns"
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end
