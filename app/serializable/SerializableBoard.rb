class SerializableBoard < JSONAPI::Serializable::Resource
  type 'boards'

  attributes :title, :description, :img_url, :slug, :created_at, :updated_at, :author_id

  belongs_to :author, class: SerializableUser

  link :self do
    @url_helpers.board_path(@object.slug)
  end
end
