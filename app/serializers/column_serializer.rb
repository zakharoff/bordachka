class ColumnSerializer < ActiveModel::Serializer
  attributes :title, :created_at, :updated_at
end
