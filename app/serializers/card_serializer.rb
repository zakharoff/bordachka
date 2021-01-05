class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  belongs_to :author, class_name: 'User'
  belongs_to :executor, class_name: 'User'

  link(:self) { card_path(object) }
  link(:author) { user_path(object.author) }
  link(:executor) do
    user_path(object.executor) if object.executor.present?
  end
end
