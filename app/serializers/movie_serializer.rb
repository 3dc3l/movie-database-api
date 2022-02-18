class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :release_year, :get_image_url
  has_many :casts
end
