class Movie < ApplicationRecord
    #RELATIONSHIPS
    has_and_belongs_to_many :genres
    has_and_belongs_to_many :casts
    has_many :reviews
    has_many :users, through: :favorites

    #VALIDATIONS
    validates :title, :release_year, :thumbnail_url, presence: true
    validates :title, uniqueness: true
    validates :release_year, numericality: { only_integer: true }
    
    #METHOD FOR DATA MANIPULATIONS
end
