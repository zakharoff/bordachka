class CreateCardsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :cards, column_options: { foreign_key: true } do |t|
      t.index [:user_id, :card_id], unique: true
      t.index [:card_id, :user_id], unique: true

      t.timestamps
    end
  end
end
