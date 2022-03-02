class Review < ApplicationRecord
    #RELATIONSHIPS
    belongs_to :user
    belongs_to :movie

    #VALIDATIONS   
    validates :content, :rating, presence: true
    validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
end
