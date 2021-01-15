class UserFullSerializer < ActiveModel::Serializer
  attributes :email

  has_many :boards, foreign_key: :author_id
  has_many :assigned_cards, class_name: 'Card'

  link(:self) { user_path(object) }
end
