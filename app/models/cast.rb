class Cast < ApplicationRecord
    include Rails.application.routes.url_helpers

    #RELATIONSHIPS
    has_and_belongs_to_many :movies
    has_one_attached :image

    attr_accessor :label

    #VALIDATIONS
    validates :first_name, :middle_name, :last_name, :stage_name, presence: true

    def get_image_url
        url_for(self.image)
        # rails_blob_path(self.image, disposition: "attachment", only_path: true)
    end
    
    def full_name
        full_name = [first_name, middle_name, last_name].map(&:capitalize).join(", ")

        if suffix
           full_name =  [full_name, suffix.capitalize].join(", ")
        else
            full_name
        end
    end
end
