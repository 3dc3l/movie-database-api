class GenreSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :slug
  has_many :movies
end
  