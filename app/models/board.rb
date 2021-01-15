class Board < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :columns, dependent: :destroy
  has_many :cards, dependent: :destroy

  validates :title, length: { in: 1..30 }, presence: true
  validates :description, length: { maximum: 255 }, allow_blank: true

  before_create :set_slug

  private

  def set_slug
    loop do
      self.slug = Nanoid.generate(size: 6)
      break unless Board.where(slug: slug).exists?
    end
  end
end
