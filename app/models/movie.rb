class Movie < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    #RELATIONSHIPS
    has_and_belongs_to_many :genres
    has_and_belongs_to_many :casts
    has_many :reviews
    has_many :users, through: :favorites

    #ACTIVE STORAGE ATTACHMENT
    has_one_attached :image

    #VALIDATIONS
    validates :title, :release_year, presence: true
    validates :title, uniqueness: true
    validates :release_year, numericality: { only_integer: true }
    validates :image, { presence: true }

    #METHOD FOR DATA MANIPULATIONS
    def get_image_url
        url_for(self.image)
        # rails_blob_path(self.image, disposition: "attachment", only_path: true)
    end
end
