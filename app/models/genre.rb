class Genre < ApplicationRecord
    #RELATIONSHIPS
    has_and_belongs_to_many :movies

    #VALIDATIONS
    validates :title, presence: true
end
