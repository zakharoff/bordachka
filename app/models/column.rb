class Column < ApplicationRecord
  belongs_to :board

  has_many :cards, dependent: :destroy

  validates :title, presence: true, length: { maximum: 55 }
end
