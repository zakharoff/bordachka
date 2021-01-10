class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :boards, foreign_key: :author_id, dependent: :destroy
  has_many :cards, foreign_key: :author_id, dependent: :destroy

  has_and_belongs_to_many :assigned_cards, class_name: 'Card'
end
