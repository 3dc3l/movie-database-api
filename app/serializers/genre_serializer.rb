class GenreSerializer < ActiveModel::Serializer
    attributes :id, :title, :slug
    has_many :movies
  end
  