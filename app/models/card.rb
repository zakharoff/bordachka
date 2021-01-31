class Card < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :column
  belongs_to :board

  has_and_belongs_to_many :executors, class_name: 'User'

  validates :title, length: { maximum: 100 }, presence: true
  validates :body, length: { maximum: 1_500 }, allow_blank: true
end
