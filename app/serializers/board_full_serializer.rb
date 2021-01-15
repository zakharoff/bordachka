class BoardFullSerializer < ActiveModel::Serializer
  attributes :slug, :title, :description, :img_url, :created_at, :updated_at

  belongs_to :author, class_name: 'User'
  has_many :columns
  has_many :cards

  link(:self) { board_path(object) }
  link(:author) { user_path(object.author_id) }
end
