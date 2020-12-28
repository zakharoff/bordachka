class Board < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { in: 1..30 }
  validates :description, length: { in: 0..255 }

  before_create :set_slug

  private

  def set_slug
    loop do
      self.slug = Nanoid.generate(size: 6)
      break unless Board.where(slug: slug).exists?
    end
  end
end
