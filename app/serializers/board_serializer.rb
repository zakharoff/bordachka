class BoardSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :img_url, :slug, :author_id, :created_at, :updated_at

  belongs_to :author, serializer: :user
end
