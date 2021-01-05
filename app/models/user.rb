class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :boards, foreign_key: :author_id, dependent: :destroy
  has_many :cards, foreign_key: :author_id, dependent: :destroy
  has_many :cards, foreign_key: :executor_id, dependent: :destroy
end
