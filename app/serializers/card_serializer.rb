class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  belongs_to :column
  belongs_to :board
  belongs_to :author, class_name: 'User'
  has_many :executors, class_name: 'User'

  link(:self) { card_path(object) }
  link(:author) { user_path(object.author) }
end
