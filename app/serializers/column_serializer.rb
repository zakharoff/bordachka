class ColumnSerializer < ActiveModel::Serializer
  attributes :title, :created_at, :updated_at

  belongs_to :board, class_name: 'User'
  has_many :cards
end
