class AddSettingsForExistingsTables < ActiveRecord::Migration[6.0]
  def change
    change_column_default :boards, :title, from: nil, to: false
    change_column_default :boards, :slug, from: nil, to: false
    change_column_default :columns, :title, from: nil, to: false
    change_column_default :cards, :title, from: nil, to: false
    add_index :boards, :slug, unique: true
  end
end
