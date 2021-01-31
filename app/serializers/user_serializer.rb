class UserSerializer < ActiveModel::Serializer
  attributes :email, :slug

  link(:self) { user_path(object) }
end
