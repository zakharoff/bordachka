class CreateColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :columns do |t|
      t.string :title, null: false
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :cards, :column, foreign_key: true
    add_reference :cards, :board, foreign_key: true
  end
end
