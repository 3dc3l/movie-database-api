class CastSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :middle_name, :last_name, :suffix, :stage_name, :get_image_url
end