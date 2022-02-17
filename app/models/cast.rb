class Cast < ApplicationRecord
    #RELATIONSHIPS
    has_and_belongs_to_many :movies

    #VALIDATIONS
    validates :first_name, :middle_name, :last_name, :stage_name, presence: true
end
