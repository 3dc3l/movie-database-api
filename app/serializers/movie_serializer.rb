class MovieSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :slug, :release_year, :get_image_url, :is_favorite
  has_many :casts
  has_many :genres
  has_many :reviews
  has_many  :users
end
