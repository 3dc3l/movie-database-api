class User < ApplicationRecord
       devise :database_authenticatable,
              :jwt_authenticatable,
              :registerable,
              jwt_revocation_strategy: JwtDenylist
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable

       #Models
       has_many :favorites
       has_many :movies, through: :favorites
       has_many :reviews
end
