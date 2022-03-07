class Genre < ApplicationRecord
    #RELATIONSHIPS
    has_and_belongs_to_many :movies

    attr_accessor :label

    #VALIDATIONS
    validates :title, presence: true
end
