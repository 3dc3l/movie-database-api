class Cast < ApplicationRecord
    include Rails.application.routes.url_helpers

    #RELATIONSHIPS
    has_and_belongs_to_many :movies
    has_one_attached :image

    #VALIDATIONS
    validates :first_name, :middle_name, :last_name, :stage_name, :image, presence: true

    def get_image_url
        # url_for(self.image)
        # polymorphic_url(self.image)
        # self.image
        rails_blob_path(self.image, disposition: "attachment", only_path: true)
    end
end
