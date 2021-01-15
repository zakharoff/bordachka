class UserSerializer < ActiveModel::Serializer
  attributes :email

  link(:self) { user_path(object) }
end
