class AddSlugToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :slug, :string, empty: false
    add_index :users, :slug, unique: true
  end
end
