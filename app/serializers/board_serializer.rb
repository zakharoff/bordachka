class BoardSerializer < ActiveModel::Serializer
  attributes :slug, :title, :description, :img_url, :created_at, :updated_at

  belongs_to :author, class_name: 'User'

  link(:self) { board_path(object) }
  link(:author) { user_path(object.author) }
end
