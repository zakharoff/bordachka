class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :title
      t.text :description
      t.text :img_url
      t.string :slug
      t.references :author, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
