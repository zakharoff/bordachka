class Card < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :executor, class_name: 'User', optional: true

  validates :title, length: { maximum: 100 }
  validates :body, length: { maximum: 1_500 }, allow_blank: true
end
